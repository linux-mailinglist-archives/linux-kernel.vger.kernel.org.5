Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E87A979B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjIUR0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjIURZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2024559E1;
        Thu, 21 Sep 2023 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3zuye6cuN/UXKpEDGt76GmiwBqKZcclp/r7kmn7YPt8=;
        t=1695316191; x=1696525791; b=YLEJXpBmqRgzWnGLLIg3lfq3TZDW0FXsGGDdlYK2wl0F4Kw
        qOgd83ieNnwUKZ2GELAfvipv7AwWkkgGvce8wwrb6/BAl9M961J0cyccxYCVzJ7V0ggCcnzZYnAV7
        EqAIwponONEfRnvMStrGKLvYEIXwzlpKKJ2OQILkeOtryJ4rHLmRpmAsk1NCSSrvQRJCsNamhy0fV
        ek5oTp0D+z0CeXDIaxLOjKuL+yqc9oVoFUSjg9xOlH2N1gqGdzQUuh9A68w1qa3FP2bAU7J3zRjUN
        0ccg3gbT1pPu6ocy6vQ6hye9HFTTj7kRUA76UxIrXX7BlxaOAfBqIwPr30Ziwc8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qjFPl-00D3lb-18;
        Thu, 21 Sep 2023 10:52:01 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/4] tracing: add __print_sym() to replace __print_symbolic()
Date:   Thu, 21 Sep 2023 10:51:31 +0200
Message-ID: <20230921105129.cd040deee13e.I9bd2617499f0d170df58471bc51379742190f92d@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921085129.261556-5-johannes@sipsolutions.net>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The way __print_symbolic() works is limited and inefficient
in multiple ways:
 - you can only use it with a static list of symbols, but
   e.g. the SKB dropreasons are now a dynamic list

 - it builds the list in memory _three_ times, so it takes
   a lot of memory:
   - The print_fmt contains the list (since it's passed to
     the macro there). This actually contains the names
     _twice_, which is fixed up at runtime.
   - TRACE_DEFINE_ENUM() puts a 24-byte struct trace_eval_map
     for every entry, plus the string pointed to by it, which
     cannot be deduplicated with the strings in the print_fmt
   - The in-kernel symbolic printing creates yet another list
     of struct trace_print_flags for trace_print_symbols_seq()

 - it also requires runtime fixup during init, which is a lot
   of string parsing due to the print_fmt fixup

Introduce __print_sym() to - over time - replace the old one.
We can easily extend this also to __print_flags later, but I
cared more about the SKB dropreasons for now.

This new __print_sym() requires only a single list of items,
created by TRACE_DEFINE_SYM_LIST(), for can even use another
already existing list by using TRACE_DEFINE_SYM_FNS() with
lookup and show methods.

Then, instead of doing an init-time fixup, just do this at the
time when userspace reads the print_fmt. This way, dynamically
updated lists are possible.

For userspace, nothing actually changes, because the print_fmt
is shown exactly the same way the old __print_symbolic() was.

This adds about 4k .text in my test builds, but that'll be
more than paid for by the actual conversions.

OPEN QUESTIONS:
 - do we need TRACE_EVENT_FL_DYNPRINT or should we just always
   go through show_print_fmt()? If we do, we can get rid of
   set_event_dynprint() which is also a stupid function, and
   somewhat inefficient.

 - Is the WARN_ON() in show_print_fmt() correct? Can we have a
   dynamic event using this infrastructure? I don't know about
   dynamic events enough.

 - Is the double-slash (//) thing a good approach? I was looking
   for something that couldn't happen in C, and that's a comment
   so it shouldn't be possible ... It's only internal though so
   we could always change it. Parsing to the next , means we'd
   have to parse a LOT of C, so that's out of the question.

 - Is it correct that we can assume RCU critical section when in
   the lookup function? The SKB code currently does, but I may
   not ever have actually run this code yet.

 - Where should all the functions be implemented :-)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/asm-generic/vmlinux.lds.h          |   3 +-
 include/linux/module.h                     |   2 +
 include/linux/trace_events.h               |  10 ++
 include/linux/tracepoint.h                 |  20 ++++
 include/trace/stages/init.h                |  54 +++++++++
 include/trace/stages/stage2_data_offsets.h |   6 +
 include/trace/stages/stage3_trace_output.h |   9 ++
 include/trace/stages/stage7_class_define.h |   4 +
 kernel/module/main.c                       |   3 +
 kernel/trace/trace_events.c                | 131 ++++++++++++++++++++-
 kernel/trace/trace_output.c                |  43 +++++++
 11 files changed, 282 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9c59409104f6..b2b45ff0a701 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -263,7 +263,8 @@
 #define FTRACE_EVENTS()							\
 	. = ALIGN(8);							\
 	BOUNDED_SECTION(_ftrace_events)					\
-	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
+	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)		\
+	BOUNDED_SECTION(_ftrace_sym_defs)
 #else
 #define FTRACE_EVENTS()
 #endif
diff --git a/include/linux/module.h b/include/linux/module.h
index a98e188cf37b..bf14b74a872c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -524,6 +524,8 @@ struct module {
 	unsigned int num_trace_events;
 	struct trace_eval_map **trace_evals;
 	unsigned int num_trace_evals;
+	struct trace_sym_def **trace_sym_defs;
+	unsigned int num_trace_sym_defs;
 #endif
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 	unsigned int num_ftrace_callsites;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index eb5c3add939b..9ab651a8fa0b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -24,6 +24,13 @@ const char *trace_print_flags_seq(struct trace_seq *p, const char *delim,
 const char *trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
 				    const struct trace_print_flags *symbol_array);
 
+const char *trace_print_sym_seq(struct trace_seq *p, unsigned long long val,
+				const char *(*lookup)(unsigned long long val));
+const char *trace_sym_lookup(const struct trace_sym_entry *list,
+			     size_t len, unsigned long long value);
+void trace_sym_show(struct seq_file *m,
+		    const struct trace_sym_entry *list, size_t len);
+
 #if BITS_PER_LONG == 32
 const char *trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
 		      unsigned long long flags,
@@ -331,6 +338,7 @@ enum {
 	TRACE_EVENT_FL_EPROBE_BIT,
 	TRACE_EVENT_FL_FPROBE_BIT,
 	TRACE_EVENT_FL_CUSTOM_BIT,
+	TRACE_EVENT_FL_DYNPRINT_BIT,
 };
 
 /*
@@ -348,6 +356,7 @@ enum {
  *  CUSTOM        - Event is a custom event (to be attached to an exsiting tracepoint)
  *                   This is set when the custom event has not been attached
  *                   to a tracepoint yet, then it is cleared when it is.
+ *  DYNPRINT      - Event has dynamic symbol prints
  */
 enum {
 	TRACE_EVENT_FL_FILTERED		= (1 << TRACE_EVENT_FL_FILTERED_BIT),
@@ -361,6 +370,7 @@ enum {
 	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
 	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
 	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
+	TRACE_EVENT_FL_DYNPRINT		= (1 << TRACE_EVENT_FL_DYNPRINT_BIT),
 };
 
 #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_UPROBE)
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 88c0ba623ee6..7650019f4347 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -31,6 +31,24 @@ struct trace_eval_map {
 	unsigned long		eval_value;
 };
 
+struct trace_sym_def {
+	const char		*system;
+	const char		*symbol_id;
+	/* may return NULL */
+	const char *		(*lookup)(unsigned long long);
+	/*
+	 * Must print the list: ', { val, "name"}, ...'
+	 * with no trailing comma, but with the leading ', '
+	 * to simplify things:
+	 */
+	void 			(*show)(struct seq_file *);
+};
+
+struct trace_sym_entry {
+	unsigned long long	value;
+	const char		*name;
+};
+
 #define TRACEPOINT_DEFAULT_PRIO	10
 
 extern struct srcu_struct tracepoint_srcu;
@@ -109,6 +127,8 @@ extern void syscall_unregfunc(void);
 
 #define TRACE_DEFINE_ENUM(x)
 #define TRACE_DEFINE_SIZEOF(x)
+#define TRACE_DEFINE_SYM_FNS(...)
+#define TRACE_DEFINE_SYM_LIST(...)
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
diff --git a/include/trace/stages/init.h b/include/trace/stages/init.h
index 000bcfc8dd2e..251ab22485d1 100644
--- a/include/trace/stages/init.h
+++ b/include/trace/stages/init.h
@@ -23,6 +23,60 @@ TRACE_MAKE_SYSTEM_STR();
 	__section("_ftrace_eval_map")			\
 	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
 
+/*
+ * Define a symbol for __print_sym by giving lookup and
+ * show functions. See &struct trace_sym_def.
+ */
+#define TRACE_DEFINE_SYM_FNS(_symbol_id, _lookup, _show)		\
+	_TRACE_DEFINE_SYM_FNS(TRACE_SYSTEM, _symbol_id, _lookup, _show)
+#define _TRACE_DEFINE_SYM_FNS(_system, _symbol_id, _lookup, _show)	\
+	__TRACE_DEFINE_SYM_FNS(_system, _symbol_id, _lookup, _show)
+#define __TRACE_DEFINE_SYM_FNS(_system, _symbol_id, _lookup, _show)	\
+	___TRACE_DEFINE_SYM_FNS(_system ## _ ## _symbol_id, _symbol_id,	\
+				_lookup, _show)
+#define ___TRACE_DEFINE_SYM_FNS(_name, _symbol_id, _lookup, _show)	\
+	static struct trace_sym_def					\
+	__trace_sym_def_ ## _name = {					\
+		.system = TRACE_SYSTEM_STRING,				\
+		/* need the ) for later strcmp */			\
+		.symbol_id = #_symbol_id ")",				\
+		.lookup = _lookup,					\
+		.show = _show,						\
+	};								\
+	static struct trace_sym_def 					\
+	__section("_ftrace_sym_defs")					\
+	*__trace_sym_def_p_ ## _name = &__trace_sym_def_ ## _name
+
+/*
+ * Define a symbol for __print_sym by giving lookup and
+ * show functions. See &struct trace_sym_def.
+ */
+#define TRACE_DEFINE_SYM_LIST(_symbol_id, ...)				\
+	_TRACE_DEFINE_SYM_LIST(TRACE_SYSTEM, _symbol_id, __VA_ARGS__)
+#define _TRACE_DEFINE_SYM_LIST(_system, _symbol_id, ...)		\
+	__TRACE_DEFINE_SYM_LIST(_system, _symbol_id, __VA_ARGS__)
+#define __TRACE_DEFINE_SYM_LIST(_system, _symbol_id, ...)		\
+	___TRACE_DEFINE_SYM_LIST(_system ## _ ## _symbol_id, _symbol_id,\
+				 __VA_ARGS__)
+#define ___TRACE_DEFINE_SYM_LIST(_name, _symbol_id, ...)		\
+	static struct trace_sym_entry					\
+	__trace_sym_list_ ## _name[] = { __VA_ARGS__ };			\
+	static const char *						\
+	__trace_sym_lookup_ ## _name(unsigned long long value)		\
+	{								\
+		return trace_sym_lookup(__trace_sym_list_ ## _name,	\
+			ARRAY_SIZE(__trace_sym_list_ ## _name), value);	\
+	}								\
+	static void							\
+	__trace_sym_show_ ## _name(struct seq_file *m)			\
+	{								\
+		trace_sym_show(m, __trace_sym_list_ ## _name,		\
+			       ARRAY_SIZE(__trace_sym_list_ ## _name));	\
+	}								\
+	___TRACE_DEFINE_SYM_FNS(_name, _symbol_id,			\
+				__trace_sym_lookup_ ## _name,		\
+				__trace_sym_show_ ## _name)
+
 #undef TRACE_DEFINE_SIZEOF
 #define TRACE_DEFINE_SIZEOF(a)				\
 	static struct trace_eval_map __used __initdata	\
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 469b6a64293d..83a287f78501 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -5,6 +5,12 @@
 #undef TRACE_DEFINE_ENUM
 #define TRACE_DEFINE_ENUM(a)
 
+#undef TRACE_DEFINE_SYM_FNS
+#define TRACE_DEFINE_SYM_FNS(_symbol_id, _lookup, _show)
+
+#undef TRACE_DEFINE_SYM_LIST
+#define TRACE_DEFINE_SYM_LIST(_symbol_id, ...)
+
 #undef TRACE_DEFINE_SIZEOF
 #define TRACE_DEFINE_SIZEOF(a)
 
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..d2c6458b62dc 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -79,6 +79,15 @@
 		trace_print_symbols_seq(p, value, symbols);		\
 	})
 
+#undef __print_sym
+#define __print_sym(value, symbol_id)					\
+	___print_sym(TRACE_SYSTEM, value, symbol_id)
+#define ___print_sym(sys, value, symbol_id)				\
+	____print_sym(sys, value, symbol_id)
+#define ____print_sym(sys, value, symbol_id)				\
+	trace_print_sym_seq(p, value,					\
+		__trace_sym_def_p_ ## sys ## _ ## symbol_id->lookup)
+
 #undef __print_flags_u64
 #undef __print_symbolic_u64
 #if BITS_PER_LONG == 32
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index bcb960d16fc0..ce802172b5d7 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -25,6 +25,10 @@
 #undef __print_hex_dump
 #undef __get_buf
 
+#undef __print_sym
+/* use // as the separator since it'd be a comment in C */
+#define __print_sym(value, symbol_id)	__print_sym(value\/\/symbol_id)
+
 /*
  * The below is not executed in the kernel. It is only what is
  * displayed in the print format for userspace to parse.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..7752c3883cd2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2161,6 +2161,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->trace_evals = section_objs(info, "_ftrace_eval_map",
 					sizeof(*mod->trace_evals),
 					&mod->num_trace_evals);
+	mod->trace_sym_defs = section_objs(info, "_ftrace_sym_defs",
+					   sizeof(*mod->trace_sym_defs),
+					   &mod->num_trace_sym_defs);
 #endif
 #ifdef CONFIG_TRACING
 	mod->trace_bprintk_fmt_start = section_objs(info, "__trace_printk_fmt",
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ed367d713be0..38eaa7dce078 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1559,6 +1559,104 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 		return node;
 }
 
+extern struct trace_sym_def *__start_ftrace_sym_defs[];
+extern struct trace_sym_def *__stop_ftrace_sym_defs[];
+
+static void show_sym_list(struct seq_file *m, struct trace_event_call *call,
+			  const char *name)
+{
+	struct trace_sym_def **sym_defs;
+	unsigned int n_sym_defs, i;
+
+	if (call->module) {
+		struct module *mod = call->module;
+
+		sym_defs = mod->trace_sym_defs;
+		n_sym_defs = mod->num_trace_sym_defs;
+	} else {
+		sym_defs = __start_ftrace_sym_defs;
+		n_sym_defs = __stop_ftrace_sym_defs - __start_ftrace_sym_defs;
+	}
+
+	for (i = 0; i < n_sym_defs; i++) {
+		if (!sym_defs[i])
+			continue;
+		if (sym_defs[i]->system != call->class->system)
+			continue;
+		if (strncmp(name, sym_defs[i]->symbol_id,
+			    strlen(sym_defs[i]->symbol_id)))
+			continue;
+		if (sym_defs[i]->show)
+			sym_defs[i]->show(m);
+		break;
+	}
+}
+
+static void show_print_fmt(struct seq_file *m, struct trace_event_call *call)
+{
+	char *ptr = call->print_fmt;
+	int quote = 0;
+	int wait_for_doubleslash = 0;
+
+	if (!(call->flags & TRACE_EVENT_FL_DYNPRINT) ||
+	    /* WARN because dynamic events have no module */
+	    WARN_ON_ONCE(call->flags & TRACE_EVENT_FL_DYNAMIC)) {
+		seq_printf(m, "\nprint fmt: %s\n", call->print_fmt);
+		return;
+	}
+
+	seq_puts(m, "\nprint fmt: ");
+	while (*ptr) {
+		if (*ptr == '\\') {
+			seq_putc(m, *ptr);
+			ptr++;
+			/* paranoid */
+			if (!*ptr)
+				break;
+			goto next;
+		}
+		if (*ptr == '"') {
+			quote ^= 1;
+			goto next;
+		}
+		if (quote)
+			goto next;
+
+		if (wait_for_doubleslash == 1 && *ptr == '/') {
+			wait_for_doubleslash = 2;
+			ptr++;
+			continue;
+		} else if (wait_for_doubleslash == 2 && *ptr != '/') {
+			seq_putc(m, '/');
+			wait_for_doubleslash = 1;
+			goto next;
+		} else if (wait_for_doubleslash == 2 && *ptr == '/') {
+			const char *name;
+
+			ptr++;
+			name = ptr;
+			/* skip the name */
+			while (*ptr && *ptr != ')')
+				ptr++;
+			wait_for_doubleslash = 0;
+			show_sym_list(m, call, name);
+			continue;
+		}
+
+		if (strncmp(ptr, "__print_sym(", 12) == 0) {
+			ptr += 12;
+			seq_puts(m, "__print_symbolic(");
+			wait_for_doubleslash = 1;
+			continue;
+		}
+next:
+		seq_putc(m, *ptr);
+		ptr++;
+	}
+
+	seq_putc(m, '\n');
+}
+
 static int f_show(struct seq_file *m, void *v)
 {
 	struct trace_event_call *call = event_file_data(m->private);
@@ -1577,8 +1675,7 @@ static int f_show(struct seq_file *m, void *v)
 		return 0;
 
 	case FORMAT_PRINTFMT:
-		seq_printf(m, "\nprint fmt: %s\n",
-			   call->print_fmt);
+		show_print_fmt(m, call);
 		return 0;
 	}
 
@@ -2552,6 +2649,32 @@ static int event_init(struct trace_event_call *call)
 	return ret;
 }
 
+static void set_event_dynprint(struct trace_event_call *call)
+{
+	char *ptr;
+	int quote = 0;
+
+	for (ptr = call->print_fmt; *ptr; ptr++) {
+		if (*ptr == '\\') {
+			ptr++;
+			/* paranoid */
+			if (!*ptr)
+				break;
+			continue;
+		}
+		if (*ptr == '"') {
+			quote ^= 1;
+			continue;
+		}
+		if (quote)
+			continue;
+		if (strncmp(ptr, "__print_sym(", 12) == 0) {
+			call->flags |= TRACE_EVENT_FL_DYNPRINT;
+			break;
+		}
+	}
+}
+
 static int
 __register_event(struct trace_event_call *call, struct module *mod)
 {
@@ -2567,6 +2690,8 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	else
 		call->module = mod;
 
+	set_event_dynprint(call);
+
 	return 0;
 }
 
@@ -3810,6 +3935,8 @@ static __init int event_trace_enable(void)
 		ret = event_init(call);
 		if (!ret)
 			list_add(&call->list, &ftrace_events);
+
+		set_event_dynprint(call);
 	}
 
 	register_trigger_cmds();
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index db575094c498..9196f408a1d2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -124,6 +124,49 @@ trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
 }
 EXPORT_SYMBOL(trace_print_symbols_seq);
 
+const char *trace_sym_lookup(const struct trace_sym_entry *list,
+			     size_t len, unsigned long long value)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (list[i].value == value)
+			return list[i].name;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(trace_sym_lookup);
+
+void trace_sym_show(struct seq_file *m,
+		    const struct trace_sym_entry *list, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		seq_printf(m, ", { %lld, \"%s\" }",
+			   list[i].value, list[i].name);
+}
+EXPORT_SYMBOL(trace_sym_show);
+
+const char *
+trace_print_sym_seq(struct trace_seq *p, unsigned long long val,
+		    const char *(*lookup)(unsigned long long val))
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	const char *name;
+
+	name = lookup(val);
+	if (name)
+		trace_seq_puts(p, name);
+	else
+		trace_seq_printf(p, "0x%llx", val);
+
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+EXPORT_SYMBOL(trace_print_sym_seq);
+
 #if BITS_PER_LONG == 32
 const char *
 trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
-- 
2.41.0

