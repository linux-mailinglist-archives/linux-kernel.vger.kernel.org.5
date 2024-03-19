Return-Path: <linux-kernel+bounces-107034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8587F6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5751C21774
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8C57E575;
	Tue, 19 Mar 2024 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsrZ/AVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1477D41B;
	Tue, 19 Mar 2024 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827482; cv=none; b=uEaTcrrNUbWmeoXqpCCzv0lZLltqu+R9VeCkAzZz0lx8p6FtAfhzVXUUEzPT5nxkjWgQ6pjKbm6Cba9UzjHoN/cvtRxzE21ygkwAOImwtK4HkvHhKEd0m0LtUlWP5o4o0tKFrwCE0szvxb9e7fZf1b12JNTLQ/nc7K0TBALUQWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827482; c=relaxed/simple;
	bh=ek6tyO55YdT1JBe57BgyHQSsS0HIXVRzIrOiaUCJ7Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6RCy11FB4Wpz1YdpqIycmzcjPijznvu4398PaA1Vs086H1/qUZLg9THGVQ7pXxABul8SlzL4+Z2nrcG5FbWKa4+/Jd3NhWqHkZt9E1QubZUiovrWGrHIxDv9K00EqQZO3WjNRQn4tGGnWu4sYqdSHCTEzX7F8uwfysaAca1hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsrZ/AVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FE4C43601;
	Tue, 19 Mar 2024 05:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827482;
	bh=ek6tyO55YdT1JBe57BgyHQSsS0HIXVRzIrOiaUCJ7Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsrZ/AViHFVoq9A7uDh/gzfcOtJNEFoQ/bRR4QNJdM3Hq4LKCIeZMsNB5PgvHjVUi
	 nm2bKuZNZpVNxSu1hKRvpHWWGJ/TA2tzePiF+6H2iQVXTstyOk9UQ5xiFjcfwpHIZ0
	 ddtJLwJESmqjAS8gGPM9XQykf9qnHXSZkXDo5UhDM++xXqwDaD4YNf4XjCFqovmCqI
	 OQHlpP4da9MdH/S8EwVikZoWMyJ1MKVtjMqcZ62TDguZ9cklX7JRw8X7wVbdNHWt+F
	 gzSt2Cerft2hEMBOQOzgXK0JhzLbnHjz9lvlcAjNRc8sLaWcm5zPePj4RVfpF0+MLU
	 WqUMQMDZf27Ug==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 08/23] perf annotate-data: Add debug messages
Date: Mon, 18 Mar 2024 22:51:00 -0700
Message-ID: <20240319055115.4063940-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new debug option "type-profile" to enable the detailed info during
the type analysis especially for instruction tracking.  You can use this
before the command name like 'report' or 'annotate'.

  $ perf --debug type-profile annotate --data-type

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 74 +++++++++++++++++++++++++++++----
 tools/perf/util/debug.c         |  3 ++
 tools/perf/util/debug.h         |  1 +
 3 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index ff81d164aa57..f482ccfdaa91 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -23,6 +23,29 @@
 #include "symbol.h"
 #include "symbol_conf.h"
 
+#define pr_debug_dtp(fmt, ...)					\
+do {								\
+	if (debug_type_profile)					\
+		pr_info(fmt, ##__VA_ARGS__);			\
+	else							\
+		pr_debug3(fmt, ##__VA_ARGS__);			\
+} while (0)
+
+static void pr_debug_type_name(Dwarf_Die *die)
+{
+	struct strbuf sb;
+	char *str;
+
+	if (!debug_type_profile && verbose < 3)
+		return;
+
+	strbuf_init(&sb, 32);
+	die_get_typename_from_type(die, &sb);
+	str = strbuf_detach(&sb, NULL);
+	pr_info(" type=%s (die:%lx)\n", str, (long)dwarf_dieoffset(die));
+	free(str);
+}
+
 /*
  * Compare type name and size to maintain them in a tree.
  * I'm not sure if DWARF would have information of a single type in many
@@ -201,7 +224,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 
 	/* Get the type of the variable */
 	if (die_get_real_type(var_die, type_die) == NULL) {
-		pr_debug("variable has no type\n");
+		pr_debug_dtp("variable has no type\n");
 		ann_data_stat.no_typeinfo++;
 		return -1;
 	}
@@ -215,7 +238,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 		if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
 		     dwarf_tag(type_die) != DW_TAG_array_type) ||
 		    die_get_real_type(type_die, type_die) == NULL) {
-			pr_debug("no pointer or no type\n");
+			pr_debug_dtp("no pointer or no type\n");
 			ann_data_stat.no_typeinfo++;
 			return -1;
 		}
@@ -223,14 +246,15 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 
 	/* Get the size of the actual type */
 	if (dwarf_aggregate_size(type_die, &size) < 0) {
-		pr_debug("type size is unknown\n");
+		pr_debug_dtp("type size is unknown\n");
 		ann_data_stat.invalid_size++;
 		return -1;
 	}
 
 	/* Minimal sanity check */
 	if ((unsigned)offset >= size) {
-		pr_debug("offset: %d is bigger than size: %" PRIu64 "\n", offset, size);
+		pr_debug_dtp("offset: %d is bigger than size: %"PRIu64"\n",
+			     offset, size);
 		ann_data_stat.bad_offset++;
 		return -1;
 	}
@@ -251,6 +275,19 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	int fb_offset = 0;
 	bool is_fbreg = false;
 	u64 pc;
+	char buf[64];
+
+	if (dloc->op->multi_regs)
+		snprintf(buf, sizeof(buf), " or reg%d", dloc->op->reg2);
+	else if (dloc->op->reg1 == DWARF_REG_PC)
+		snprintf(buf, sizeof(buf), " (PC)");
+	else
+		buf[0] = '\0';
+
+	pr_debug_dtp("-----------------------------------------------------------\n");
+	pr_debug_dtp("%s [%"PRIx64"] for reg%d%s offset=%#x in %s\n",
+		     __func__, dloc->ip - dloc->ms->sym->start,
+		     dloc->op->reg1, buf, dloc->op->offset, dloc->ms->sym->name);
 
 	/*
 	 * IP is a relative instruction address from the start of the map, as
@@ -261,7 +298,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 
 	/* Get a compile_unit for this address */
 	if (!find_cu_die(dloc->di, pc, &cu_die)) {
-		pr_debug("cannot find CU for address %" PRIx64 "\n", pc);
+		pr_debug_dtp("cannot find CU for address %"PRIx64"\n", pc);
 		ann_data_stat.no_cuinfo++;
 		return -1;
 	}
@@ -269,12 +306,17 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	reg = loc->reg1;
 	offset = loc->offset;
 
+	pr_debug_dtp("CU die offset: %#lx\n", (long)dwarf_dieoffset(&cu_die));
+
 	if (reg == DWARF_REG_PC) {
 		if (die_find_variable_by_addr(&cu_die, dloc->var_addr, &var_die,
 					      &offset)) {
 			ret = check_variable(&var_die, type_die, offset,
 					     /*is_pointer=*/false);
 			dloc->type_offset = offset;
+
+			pr_debug_dtp("found PC-rel by addr=%#"PRIx64" offset=%#x\n",
+				     dloc->var_addr, offset);
 			goto out;
 		}
 
@@ -310,6 +352,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			default:
 				break;
 			}
+
+			pr_debug_dtp("frame base: cfa=%d fbreg=%d\n",
+				     dloc->fb_cfa, fbreg);
 		}
 	}
 
@@ -334,6 +379,19 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
 				     reg != DWARF_REG_PC && !is_fbreg);
+		if (ret == 0) {
+			pr_debug_dtp("found \"%s\" in scope=%d/%d (die: %#lx) ",
+				     dwarf_diename(&var_die), i+1, nr_scopes,
+				     (long)dwarf_dieoffset(&scopes[i]));
+			if (reg == DWARF_REG_PC)
+				pr_debug_dtp("%#x(PC) offset=%#x", loc->offset, offset);
+			else if (reg == DWARF_REG_FB || is_fbreg)
+				pr_debug_dtp("%#x(reg%d) stack fb_offset=%#x offset=%#x",
+					     loc->offset, reg, fb_offset, offset);
+			else
+				pr_debug_dtp("%#x(reg%d)", loc->offset, reg);
+			pr_debug_type_name(type_die);
+		}
 		dloc->type_offset = offset;
 		goto out;
 	}
@@ -343,8 +401,10 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		goto retry;
 	}
 
-	if (ret < 0)
+	if (ret < 0) {
+		pr_debug_dtp("no variable found\n");
 		ann_data_stat.no_var++;
+	}
 
 out:
 	free(scopes);
@@ -373,7 +433,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 
 	dloc->di = debuginfo__new(dso->long_name);
 	if (dloc->di == NULL) {
-		pr_debug("cannot get the debug info\n");
+		pr_debug_dtp("cannot get the debug info\n");
 		return NULL;
 	}
 
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index c39ee0fcb8cf..d633d15329fa 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -41,6 +41,7 @@ static int redirect_to_stderr;
 int debug_data_convert;
 static FILE *_debug_file;
 bool debug_display_time;
+int debug_type_profile;
 
 FILE *debug_file(void)
 {
@@ -231,6 +232,7 @@ static struct sublevel_option debug_opts[] = {
 	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
 	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
 	{ .name = "kmaps",		.value_ptr = &debug_kmaps },
+	{ .name = "type-profile",	.value_ptr = &debug_type_profile },
 	{ .name = NULL, }
 };
 
@@ -270,6 +272,7 @@ int perf_quiet_option(void)
 	redirect_to_stderr = 0;
 	debug_peo_args = 0;
 	debug_kmaps = 0;
+	debug_type_profile = 0;
 
 	return 0;
 }
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 35a7a5ae762e..a4026d1fd6a3 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -14,6 +14,7 @@ extern int debug_peo_args;
 extern bool quiet, dump_trace;
 extern int debug_ordered_events;
 extern int debug_data_convert;
+extern int debug_type_profile;
 
 #ifndef pr_fmt
 #define pr_fmt(fmt) fmt
-- 
2.44.0.291.gc1ea87d7ee-goog


