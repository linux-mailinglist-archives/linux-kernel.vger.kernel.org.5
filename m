Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E667C6385
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377420AbjJLDyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377511AbjJLDxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE710D7;
        Wed, 11 Oct 2023 20:51:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5859b1c92a0so416347a12.2;
        Wed, 11 Oct 2023 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082714; x=1697687514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtpWSuKxD/2tbbvos5iko7H6sC+KDA3u3X+/mk0vrcI=;
        b=jKPZLrrhUKWSElEoYKJgcJFYglL8QxzTTPGM1apjsJ7o1zGMA/ne43lVWatb2q2IwG
         LmCrcbhHMKQa8hCRbVb4lZydJrhniwYl0bu2Nx0f7QdPa08eYkI1/aMPfwE8pW06r82c
         b7JT5stgm+hva876JrSrQbt6IZScwJ4a0zNcU1xWMA1UMB9TT1/a5l3yOfUy7JaEeNYd
         Nb/32UsoYkFf2UKHQgWDdXPajiX4V+VXWMRrdg6dXpZPY88Uhk5sVAo8/SpBojQWUC+M
         3haaqhcBDaiwe8fVLTlRfV56Jym5p9JGMOdPpSDiESA+MyJEpiqFFXUJ5HQ1lpzMOPJZ
         cc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082714; x=1697687514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JtpWSuKxD/2tbbvos5iko7H6sC+KDA3u3X+/mk0vrcI=;
        b=KSa7mmkr+J3xVCh7+Ag42SnSet+B60PPLO3sST5qX65/a0PpvtK6uqh/TxzSX89cd4
         qjZwo/zAXuDIhFfYhPuFb9mZQnwQNKs4jj9iB6/knpoiE0XgqDbVlBjthgbs69tTzMQi
         J0QcWDAbuvTSbYlstjeACyXXjH7sdwplhV/i2xMI6ZpzBV2yN1puveaqdcLnehb9PqYz
         iDLTwgwEY0wsLTPjbx9ucDxY8Tl7dOQsuvyM891GpQ5LFW1R65kCSwyAQlDRkcAB7AVE
         JiLwMTMwmJDkR+7PkQCq8SVKl/QDCFaEIM8o1HG/itSGcj1aCpi65GeGwpq7Utg6fsDL
         1IJA==
X-Gm-Message-State: AOJu0YyEdhw9KjhsObr1IvQZ3VhbgXfDHB2bS8m1sqB8i5MEVm0QH/4C
        qpkzAmmFmC1aePTUTjISEkQ=
X-Google-Smtp-Source: AGHT+IGYjGl4pDMZkUSrw3XBAdgmiyRWI3Vr1d4giFir8yMQ7vu/Eoa6xT1Wxhg2lqqZGxj9T/1elA==
X-Received: by 2002:a17:902:c412:b0:1bd:aeb3:9504 with SMTP id k18-20020a170902c41200b001bdaeb39504mr33709683plk.15.1697082714332;
        Wed, 11 Oct 2023 20:51:54 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:54 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 30/48] perf annotate-data: Support global variables
Date:   Wed, 11 Oct 2023 20:50:53 -0700
Message-ID: <20231012035111.676789-31-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global variables are accessed using PC-relative address so it needs to
be handled separately.  The PC-rel addressing is detected by using
DWARF_REG_PC.  On x86, %rip register would be used.

The address can be calculated using the ip and offset in the
instruction.  But it should start from the next instruction so add
calculate_pcrel_addr() to do it properly.

But global variables defined in a different file would only have a
declaration which doesn't include a location list.  So it first tries
to get the type info using the address, and then looks up the variable
declarations using name.  The name of global variables should be get
from the symbol table.  The declaration would have the type info.

So extend find_var_type() to take both address and name for global
variables.

The stat is now looks like:

  Annotate data type stats:
  total 294, ok 153 (52.0%), bad 141 (48.0%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          61 : no_var
          10 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 38 ++++++++++++++++------
 tools/perf/util/annotate-data.h |  6 ++--
 tools/perf/util/annotate.c      | 57 +++++++++++++++++++++++++++++++--
 tools/perf/util/annotate.h      |  4 +++
 4 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 3d4bd5040782..857e2fbe83f2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -257,7 +257,8 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
-			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
+			      const char *var_name, struct annotated_op_loc *loc,
+			      Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
@@ -275,11 +276,21 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	reg = loc->reg1;
 	offset = loc->offset;
 
-	if (reg == DWARF_REG_PC &&
-	    die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
-		ret = check_variable(&var_die, type_die, offset,
-				     /*is_pointer=*/false);
-		goto out;
+	if (reg == DWARF_REG_PC) {
+		if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
+			ret = check_variable(&var_die, type_die, offset,
+					     /*is_pointer=*/false);
+			loc->offset = offset;
+			goto out;
+		}
+
+		if (var_name && die_find_variable_at(&cu_die, var_name, pc,
+						     &var_die)) {
+			ret = check_variable(&var_die, type_die, 0,
+					     /*is_pointer=*/false);
+			/* loc->offset will be updated by the caller */
+			goto out;
+		}
 	}
 
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
@@ -302,6 +313,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
 				     reg != DWARF_REG_PC);
+		loc->offset = offset;
 		goto out;
 	}
 
@@ -323,13 +335,21 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
  * @ms: map and symbol at the location
  * @ip: instruction address of the memory access
  * @loc: instruction operand location
+ * @addr: data address of the memory access
+ * @var_name: global variable name
  *
  * This functions searches the debug information of the binary to get the data
- * type it accesses.  The exact location is expressed by (ip, reg, offset).
+ * type it accesses.  The exact location is expressed by (@ip, reg, offset)
+ * for pointer variables or (@ip, @addr) for global variables.  Note that global
+ * variables might update the @loc->offset after finding the start of the variable.
+ * If it cannot find a global variable by address, it tried to fine a declaration
+ * of the variable using @var_name.  In that case, @loc->offset won't be updated.
+ *
  * It return %NULL if not found.
  */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc)
+					   struct annotated_op_loc *loc, u64 addr,
+					   const char *var_name)
 {
 	struct annotated_data_type *result = NULL;
 	struct dso *dso = ms->map->dso;
@@ -349,7 +369,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, 0, loc, &type_die) < 0)
+	if (find_data_type_die(di, pc, addr, var_name, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 214c625e7bc9..1b0db8e8c40e 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -107,7 +107,8 @@ extern struct annotated_data_stat ann_data_stat;
 
 /* Returns data type at the location (ip, reg, offset) */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc);
+					   struct annotated_op_loc *loc, u64 addr,
+					   const char *var_name);
 
 /* Update type access histogram at the given offset */
 int annotated_data_type__update_samples(struct annotated_data_type *adt,
@@ -121,7 +122,8 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 
 static inline struct annotated_data_type *
 find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
-	       struct annotated_op_loc *loc __maybe_unused)
+	       struct annotated_op_loc *loc __maybe_unused,
+	       u64 addr __maybe_unused, const char *var_name __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index dbbd349e67fc..fe0074bb98f0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -37,6 +37,7 @@
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
+#include "thread.h"
 #include <regex.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
@@ -3700,6 +3701,30 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	return false;
 }
 
+u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
+			struct disasm_line *dl)
+{
+	struct annotation *notes;
+	struct disasm_line *next;
+	u64 addr;
+
+	notes = symbol__annotation(ms->sym);
+	/*
+	 * PC-relative addressing starts from the next instruction address
+	 * But the IP is for the current instruction.  Since disasm_line
+	 * doesn't have the instruction size, calculate it using the next
+	 * disasm_line.  If it's the last one, we can use symbol's end
+	 * address directly.
+	 */
+	if (&dl->al.node == notes->src->source.prev)
+		addr = ms->sym->end + offset;
+	else {
+		next = list_next_entry(dl, al.node);
+		addr = ip + (next->al.offset - dl->al.offset) + offset;
+	}
+	return map__rip_2objdump(ms->map, addr);
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3719,7 +3744,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
 	struct annotated_item_stat *istat;
-	u64 ip = he->ip;
+	u64 ip = he->ip, addr = 0;
+	const char *var_name = NULL;
+	int var_offset;
 	int i;
 
 	ann_data_stat.total++;
@@ -3773,12 +3800,38 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		mem_type = find_data_type(ms, ip, op_loc);
+		var_offset = op_loc->offset;
+
+		/* PC-relative addressing */
+		if (op_loc->reg1 == DWARF_REG_PC) {
+			struct addr_location al;
+			struct symbol *var;
+			u64 map_addr;
+
+			addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
+			/* Kernel symbols might be relocated */
+			map_addr = addr + map__reloc(ms->map);
+
+			addr_location__init(&al);
+			var = thread__find_symbol_fb(he->thread, he->cpumode,
+						     map_addr, &al);
+			if (var) {
+				var_name = var->name;
+				/* Calculate type offset from the start of variable */
+				var_offset = map_addr - map__unmap_ip(al.map, var->start);
+			}
+			addr_location__exit(&al);
+		}
+
+		mem_type = find_data_type(ms, ip, op_loc, addr, var_name);
 		if (mem_type)
 			istat->good++;
 		else
 			istat->bad++;
 
+		if (mem_type && var_name)
+			op_loc->offset = var_offset;
+
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
 							    op_loc->offset,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 18a81faeb44b..99c8d30a2fa7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -489,4 +489,8 @@ struct annotated_item_stat {
 };
 extern struct list_head ann_insn_stat;
 
+/* Calculate PC-relative address */
+u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
+			struct disasm_line *dl);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.42.0.655.g421f12c284-goog

