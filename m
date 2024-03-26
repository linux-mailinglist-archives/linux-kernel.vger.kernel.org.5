Return-Path: <linux-kernel+bounces-119795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A788CD15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C5F1C63C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E0713D626;
	Tue, 26 Mar 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o7pzY7mT"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3D13CC67;
	Tue, 26 Mar 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480902; cv=none; b=KVvCHWEeIzlhIF3IQMCsKQtH8q18fzAbn/DGfbZ77cG8EgkEeGiaCccyeTL4b3xdsSoi2RoazzJlfVC9Pq/CXFFAxIf22FzAi5S5wVE2Wh6CMGBpxe5Lq6npq+ZwAkl6i88S/kRodCbrqc9VvkTRfxopBqp6Z1m0M41ZIK8xJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480902; c=relaxed/simple;
	bh=v0kZAh/Wi6RA8ev/TBq58ZbkkHO5UaMlPL7IWHg6pDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ba2nxPr5Ip06VJfA8ud3wQq/cZ/5r3hMpbRnIELi/IZpYAoqBsrdx+ePsOSfsmouNhILQ/4Bk92NwtcO7QxaKM/b2hLYDHxVKSCIAYcZJk4KUg59jiATZuMfWpowp10EUnFKUSZ0K1ahkYjYquu8aZInjFqEiuo+SbMYciPS7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o7pzY7mT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WDDl6+QSDCdHokk2DTGGkJCAFUsdK1rrcb/OBf7c//8=;
	t=1711480898; x=1712690498; b=o7pzY7mTYBb7PHh7VFIfq+vnkYPyv7tc0QehMCU6XDUIdlN
	LcbG6guf7WyXCHoZkgHBVYsRjEa2Xpkq/e58hOfS0xK15xHKBKlZqRVcLzlGqDZGfuL24g3WYpQyA
	xScvFOMoIMOW3rFir57YCXDHiAXFgjwwXnDhySzI5e3aA+hS3eN5Gi1JZsE/AGlFRPIM3Vw5gG4Ju
	8OFTuCIivo3Vo5eqsjyCka//Wjd8s+FPC2ejunvWpsc5Ov1uy5+kvFNEwU+NcO74r0Q5sKhelnJVX
	QD30u9eMGo4cl+U6oLzrRvzdskeCJ0VEX7ImUrQJraYeUOmsLafmtoF5m0XKP+jQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpCMZ-0000000FvLV-2JCk;
	Tue, 26 Mar 2024 20:21:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 1/4] tracing: add __print_sym() to replace __print_symbolic()
Date: Tue, 26 Mar 2024 20:15:56 +0100
Message-ID: <20240326202131.9d261d5bb667.I9bd2617499f0d170df58471bc51379742190f92d@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326192131.438648-6-johannes@sipsolutions.net>
References: <20240326192131.438648-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
cared only about the SKB dropreasons for now, which has only
__print_symbolic().

This new __print_sym() requires only a single list of items,
created by TRACE_DEFINE_SYM_LIST(), or can even use another
already existing list by using TRACE_DEFINE_SYM_FNS() with
lookup and show methods.

Then, instead of doing an init-time fixup, just do this at the
time when userspace reads the print_fmt. This way, dynamically
updated lists are possible.

For userspace, nothing actually changes, because the print_fmt
is shown exactly the same way the old __print_symbolic() was.

This adds about 4k .text in my test builds, but that'll be
more than paid for by the actual conversions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - fix RCU
 - use ':' as separator to simplify the code, that's
   still not valid in a C identifier
---
 include/asm-generic/vmlinux.lds.h          |  3 +-
 include/linux/module.h                     |  2 +
 include/linux/trace_events.h               |  7 ++
 include/linux/tracepoint.h                 | 20 +++++
 include/trace/stages/init.h                | 54 +++++++++++++
 include/trace/stages/stage2_data_offsets.h |  6 ++
 include/trace/stages/stage3_trace_output.h |  9 +++
 include/trace/stages/stage7_class_define.h |  3 +
 kernel/module/main.c                       |  3 +
 kernel/trace/trace_events.c                | 90 +++++++++++++++++++++-
 kernel/trace/trace_output.c                | 45 +++++++++++
 11 files changed, 239 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f7749d0f2562..88de434578a5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -256,7 +256,8 @@
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
index 1153b0d99a80..571e5e8f17b6 100644
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
index 6f9bdfb09d1d..bc7045d535d0 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -27,6 +27,13 @@ const char *trace_print_flags_seq(struct trace_seq *p, const char *delim,
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
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..cc3b387953d1 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -31,6 +31,24 @@ struct trace_eval_map {
 	unsigned long		eval_value;
 };
 
+struct trace_sym_def {
+	const char		*system;
+	const char		*symbol_id;
+	/* may return NULL, called under rcu_read_lock() */
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
index 8b0cff06d346..5afd9de7deb3 100644
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
index bcb960d16fc0..cf552916935f 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -25,6 +25,9 @@
 #undef __print_hex_dump
 #undef __get_buf
 
+#undef __print_sym
+#define __print_sym(value, symbol_id)	__print_sym(value:symbol_id)
+
 /*
  * The below is not executed in the kernel. It is only what is
  * displayed in the print format for userspace to parse.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index e1e8a7a9d6c1..babc45cbf1de 100644
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
index 7c364b87352e..24f185836dcc 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1570,6 +1570,93 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
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
+	bool in_print_sym = false;
+	int quote = 0;
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
+		if (in_print_sym && *ptr != ':')
+			goto next;
+
+		if (in_print_sym && *ptr == ':') {
+			const char *name;
+
+			ptr++;
+			name = ptr;
+			/* skip the name */
+			while (*ptr && *ptr != ')')
+				ptr++;
+			/* and show the actual list inline now */
+			show_sym_list(m, call, name);
+			in_print_sym = false;
+			continue;
+		}
+
+		if (strncmp(ptr, "__print_sym(", 12) == 0) {
+			ptr += 12;
+			seq_puts(m, "__print_symbolic(");
+			in_print_sym = true;
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
@@ -1588,8 +1675,7 @@ static int f_show(struct seq_file *m, void *v)
 		return 0;
 
 	case FORMAT_PRINTFMT:
-		seq_printf(m, "\nprint fmt: %s\n",
-			   call->print_fmt);
+		show_print_fmt(m, call);
 		return 0;
 	}
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..8a3aa661ea46 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -124,6 +124,51 @@ trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
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
+	rcu_read_lock();
+	name = lookup(val);
+	if (name)
+		trace_seq_puts(p, name);
+	else
+		trace_seq_printf(p, "0x%llx", val);
+	rcu_read_unlock();
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
2.44.0


