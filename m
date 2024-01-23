Return-Path: <linux-kernel+bounces-34810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFF8387C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9764AB24117
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A95103A;
	Tue, 23 Jan 2024 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7m1VD26"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD75524A4;
	Tue, 23 Jan 2024 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993402; cv=none; b=jLkdG3Ik7DJPJsV3QZTtmlCzdofsHbDUNRWwZFs4tZ/8COmNXYj28PFRN+C7K84w2RG8TJNrfLnj1N1CJiXUrGQg2uBwHsAUoU2O/SYOfRGfGHaOPX51qx+4lwbwIDigDhWN8MUHMSMPiuOHnnXPkZhnhOS/UN/OaHeqXFp3lEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993402; c=relaxed/simple;
	bh=zz2DhOsA7lKV454Wy4HlDezE8wkN5htlxq1g9lqRAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVHx1bvkYOtdsI47WKeyvvFP0ODhBfZFq8Nlufj51TSIuuANL7IMJsespIVLx/F7lISMJ1EZcHyYgo/ryaTEWiF1D3M2Ahy/tkHyVHi1b+s2SwRcbifVzK4GowZSNUq83YKqlSfEXdmEE88/CrhwZt7tPBCRKOpX5eSuAKMl0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7m1VD26; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5999f3f6ce9so492463eaf.0;
        Mon, 22 Jan 2024 23:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705993399; x=1706598199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKSMteuWkKCP1Fe0jW8ClSMxtYeAHuiJeStYDwoZyCE=;
        b=B7m1VD260USnXrzU+4+hWUQN5CpMr0NWKXYuQVi1YeY3a/Nv2reIXdA3fLnHr+YPpu
         QItXH5gzew6O+sK4oJbApjL7xuYaofZlUfTi8SRWCTAcgvlrNLWjjv4WSZQtagaiujvx
         S0pf1/YO5KvrtloI2EHqYEhRkpRvHfu4MvwXcFF79g7057P4LQSqKRWwio6rcOeJw8Dz
         N20P3ZD8Iw7VpcqeHTETeYGsG1Urn7QZd00L+ucgOnrFoAoIusXIXXKy/r5XM8EDbFu0
         dFZ5DXywswAN6Zfe7JOBgKPqs+XxOYi5mwvqQQpPsOyS1aTuM75Wcexeg1MF7YK5/6jA
         P7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705993399; x=1706598199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKSMteuWkKCP1Fe0jW8ClSMxtYeAHuiJeStYDwoZyCE=;
        b=II3fRNUQu4bGALwZhj94RHVf9q+k8gHbEN1EwDAnUL/rDE80SfO/B7QMv6BbWE6QT7
         TgjkE7URJzNCZe/3xWziO9ETi/WReGaDhZ/YkEgCdqnIDbar1OU9C0Yt1cQ8gAKuOGVD
         W3njtfzX22+9OAUyAHI0NsL3+B7lNaCLg9c08m651r35qXLv2nnDKn0U4IyFvCOFLAS8
         oJ+17/nyxozVuq6oLNOX6A4+D8nZsWnfiEEpzcTtGXRfuwNPLRiO7OsK4Bc3UhhfB60S
         ljzetRspY+iCNTHmvxS/DyiHo388KYMV3HAcu9lNg/0+erQW+t/T3ntMsXQMNa+tVcPc
         5tFQ==
X-Gm-Message-State: AOJu0YzXoKE2IFLAIY5c+OqFxVASZRrwoefKtCgSUsdM5evCWA/TJxE6
	9H12JL/Ypy4G76mNd30vhDP3rQpKaYm1ZJuUpJEH8rzcFfOjzRSi
X-Google-Smtp-Source: AGHT+IE+tgIe+tNobDsNkDlBW1p4j8yuov2/PcOmj91vCjrHJTiqThxQMD+5plzBwX04sckZHrrm/A==
X-Received: by 2002:a05:6358:7f18:b0:175:7274:99c4 with SMTP id p24-20020a0563587f1800b00175727499c4mr5253359rwn.39.1705993399332;
        Mon, 22 Jan 2024 23:03:19 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.googlemail.com with ESMTPSA id y39-20020a056a00182700b006dbd41ce285sm4619730pfa.16.2024.01.22.23.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 23:03:18 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH] perf evsel: Rename get_states() to parse_task_states() and make it public
Date: Tue, 23 Jan 2024 02:02:11 -0500
Message-ID: <20240123070210.1669843-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240122070859.1394479-2-zegao@tencent.com>
References: <20240122070859.1394479-2-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since get_states() assumes the existence of libtraceevent, so move
to where it should belong, i.e, util/trace-event-parse.c, and also
rename it to parse_task_states().

Leave evsel_getstate() untouched as it fits well in the evsel
category.

Also make some necessary tweaks for python support, and get it
verified with: perf test python.

Signed-off-by: Ze Gao <zegao@tencent.com>
---

Hi Namhyung,

This is the promised refactoring patch for [1], and hopefully it
works as what we all expected.

[1]: https://lore.kernel.org/all/20240122070859.1394479-2-zegao@tencent.com/


Regards,
        -- Ze

 tools/perf/Makefile.perf            |   2 +-
 tools/perf/util/evsel.c             | 115 +---------------------------
 tools/perf/util/python-ext-sources  |   1 +
 tools/perf/util/setup.py            |   1 +
 tools/perf/util/trace-event-parse.c | 113 +++++++++++++++++++++++++++
 tools/perf/util/trace-event.h       |   3 +
 6 files changed, 120 insertions(+), 115 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 27e7c478880f..a5d274bd804b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -370,7 +370,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
 else
-  PYTHON_EXT_SRCS := $(shell grep -v ^\#\\\|util/trace-event.c util/python-ext-sources)
+  PYTHON_EXT_SRCS := $(shell grep -v ^\#\\\|util/trace-event.c\\\|util/trace-event-parse.c util/python-ext-sources)
 endif
 
 PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4d14f14f2506..9e67324b1608 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2851,119 +2851,6 @@ u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const
 	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
 }
 
-/*
- * prev_state is of size long, which is 32 bits on 32 bit architectures.
- * As it needs to have the same bits for both 32 bit and 64 bit architectures
- * we can just assume that the flags we care about will all be within
- * the 32 bits.
- */
-#define MAX_STATE_BITS 32
-
-static const char *convert_sym(struct tep_print_flag_sym *sym)
-{
-	static char save_states[MAX_STATE_BITS + 1];
-
-	memset(save_states, 0, sizeof(save_states));
-
-	/* This is the flags for the prev_state_field, now make them into a string */
-	for (; sym; sym = sym->next) {
-		long bitmask = strtoul(sym->value, NULL, 0);
-		int i;
-
-		for (i = 0; !(bitmask & 1); i++)
-			bitmask >>= 1;
-
-		if (i >= MAX_STATE_BITS)
-			continue;
-
-		save_states[i] = sym->str[0];
-	}
-
-	return save_states;
-}
-
-static struct tep_print_arg_field *
-find_arg_field(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
-{
-	struct tep_print_arg_field *field;
-
-	if (!arg)
-		return NULL;
-
-	if (arg->type == TEP_PRINT_FIELD)
-		return &arg->field;
-
-	if (arg->type == TEP_PRINT_OP) {
-		field = find_arg_field(prev_state_field, arg->op.left);
-		if (field && field->field == prev_state_field)
-			return field;
-		field = find_arg_field(prev_state_field, arg->op.right);
-		if (field && field->field == prev_state_field)
-			return field;
-	}
-	return NULL;
-}
-
-static struct tep_print_flag_sym *
-test_flags(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
-{
-	struct tep_print_arg_field *field;
-
-	field = find_arg_field(prev_state_field, arg->flags.field);
-	if (!field)
-		return NULL;
-
-	return arg->flags.flags;
-}
-
-static struct tep_print_flag_sym *
-search_op(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
-{
-	struct tep_print_flag_sym *sym = NULL;
-
-	if (!arg)
-		return NULL;
-
-	if (arg->type == TEP_PRINT_OP) {
-		sym = search_op(prev_state_field, arg->op.left);
-		if (sym)
-			return sym;
-
-		sym = search_op(prev_state_field, arg->op.right);
-		if (sym)
-			return sym;
-	} else if (arg->type == TEP_PRINT_FLAGS) {
-		sym = test_flags(prev_state_field, arg);
-	}
-
-	return sym;
-}
-
-static const char *get_states(struct tep_format_field *prev_state_field)
-{
-	struct tep_print_flag_sym *sym;
-	struct tep_print_arg *arg;
-	struct tep_event *event;
-
-	event = prev_state_field->event;
-
-	/*
-	 * Look at the event format fields, and search for where
-	 * the prev_state is parsed via the format flags.
-	 */
-	for (arg = event->print_fmt.args; arg; arg = arg->next) {
-		/*
-		 * Currently, the __print_flags() for the prev_state
-		 * is embedded in operations, so they too must be
-		 * searched.
-		 */
-		sym = search_op(prev_state_field, arg);
-		if (sym)
-			return convert_sym(sym);
-	}
-	return NULL;
-}
-
 char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name)
 {
 	static struct tep_format_field *prev_state_field;
@@ -2979,7 +2866,7 @@ char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const cha
 		return state;
 
 	if (!states || field != prev_state_field) {
-		states = get_states(field);
+		states = parse_task_states(field);
 		if (!states)
 			return state;
 		prev_state_field = field;
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 593b660ec75e..1bec945f4838 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -31,6 +31,7 @@ util/counts.c
 util/print_binary.c
 util/strlist.c
 util/trace-event.c
+util/trace-event-parse.c
 ../lib/rbtree.c
 util/string.c
 util/symbol_fprintf.c
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 79d5e2955f85..3107f5aa8c9a 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -85,6 +85,7 @@ if '-DHAVE_LIBTRACEEVENT' in cflags:
     extra_libraries += [ 'traceevent' ]
 else:
     ext_sources.remove('util/trace-event.c')
+    ext_sources.remove('util/trace-event-parse.c')
 
 # use full paths with source files
 ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 2d3c2576bab7..f0332bd3a501 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -122,6 +122,119 @@ void event_format__print(struct tep_event *event,
 	return event_format__fprintf(event, cpu, data, size, stdout);
 }
 
+/*
+ * prev_state is of size long, which is 32 bits on 32 bit architectures.
+ * As it needs to have the same bits for both 32 bit and 64 bit architectures
+ * we can just assume that the flags we care about will all be within
+ * the 32 bits.
+ */
+#define MAX_STATE_BITS 32
+
+static const char *convert_sym(struct tep_print_flag_sym *sym)
+{
+	static char save_states[MAX_STATE_BITS + 1];
+
+	memset(save_states, 0, sizeof(save_states));
+
+	/* This is the flags for the prev_state_field, now make them into a string */
+	for (; sym; sym = sym->next) {
+		long bitmask = strtoul(sym->value, NULL, 0);
+		int i;
+
+		for (i = 0; !(bitmask & 1); i++)
+			bitmask >>= 1;
+
+		if (i >= MAX_STATE_BITS)
+			continue;
+
+		save_states[i] = sym->str[0];
+	}
+
+	return save_states;
+}
+
+static struct tep_print_arg_field *
+find_arg_field(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
+{
+	struct tep_print_arg_field *field;
+
+	if (!arg)
+		return NULL;
+
+	if (arg->type == TEP_PRINT_FIELD)
+		return &arg->field;
+
+	if (arg->type == TEP_PRINT_OP) {
+		field = find_arg_field(prev_state_field, arg->op.left);
+		if (field && field->field == prev_state_field)
+			return field;
+		field = find_arg_field(prev_state_field, arg->op.right);
+		if (field && field->field == prev_state_field)
+			return field;
+	}
+	return NULL;
+}
+
+static struct tep_print_flag_sym *
+test_flags(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
+{
+	struct tep_print_arg_field *field;
+
+	field = find_arg_field(prev_state_field, arg->flags.field);
+	if (!field)
+		return NULL;
+
+	return arg->flags.flags;
+}
+
+static struct tep_print_flag_sym *
+search_op(struct tep_format_field *prev_state_field, struct tep_print_arg *arg)
+{
+	struct tep_print_flag_sym *sym = NULL;
+
+	if (!arg)
+		return NULL;
+
+	if (arg->type == TEP_PRINT_OP) {
+		sym = search_op(prev_state_field, arg->op.left);
+		if (sym)
+			return sym;
+
+		sym = search_op(prev_state_field, arg->op.right);
+		if (sym)
+			return sym;
+	} else if (arg->type == TEP_PRINT_FLAGS) {
+		sym = test_flags(prev_state_field, arg);
+	}
+
+	return sym;
+}
+
+const char *parse_task_states(struct tep_format_field *state_field)
+{
+	struct tep_print_flag_sym *sym;
+	struct tep_print_arg *arg;
+	struct tep_event *event;
+
+	event = state_field->event;
+
+	/*
+	 * Look at the event format fields, and search for where
+	 * the prev_state is parsed via the format flags.
+	 */
+	for (arg = event->print_fmt.args; arg; arg = arg->next) {
+		/*
+		 * Currently, the __print_flags() for the prev_state
+		 * is embedded in operations, so they too must be
+		 * searched.
+		 */
+		sym = search_op(state_field, arg);
+		if (sym)
+			return convert_sym(sym);
+	}
+	return NULL;
+}
+
 void parse_ftrace_printk(struct tep_handle *pevent,
 			 char *file, unsigned int size __maybe_unused)
 {
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index a69ee29419f3..bbf8b26bc8da 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -15,6 +15,7 @@ struct perf_tool;
 struct thread;
 struct tep_plugin_list;
 struct evsel;
+struct tep_format_field;
 
 struct trace_event {
 	struct tep_handle	*pevent;
@@ -51,6 +52,8 @@ int parse_event_file(struct tep_handle *pevent,
 unsigned long long
 raw_field_value(struct tep_event *event, const char *name, void *data);
 
+const char *parse_task_states(struct tep_format_field *state_field);
+
 void parse_proc_kallsyms(struct tep_handle *pevent, char *file, unsigned int size);
 void parse_ftrace_printk(struct tep_handle *pevent, char *file, unsigned int size);
 void parse_saved_cmdline(struct tep_handle *pevent, char *file, unsigned int size);
-- 
2.41.0


