Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4F7E758C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjKJADa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbjKJACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76E5588;
        Thu,  9 Nov 2023 16:01:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so1362029a91.3;
        Thu, 09 Nov 2023 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574471; x=1700179271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYFwIAb7kxbU9cm7QXOeqNap9fm6ZmSIsEYNNSyiElg=;
        b=AAx/yLIFsFyA4TLBEEBIPwiXspEhEGilnfFR32RWIvOse8KwN9HkvcAxCwozreS+aA
         zQ2N94PKcJdNt7NA41LttT2nBbhhNYuJag/Ds7FcIb0jQOXqMFtm0RwbyPjsnUAryS/O
         T7RN3347oEddcXxv+e28iL7n5r6pRwH2oX880t02uy4bzIJB+sNUE19OFYvan9+Nj0xx
         F69GPPqDf/TDgeYBj1G8wfrr3ME3d+aASzg3vkQBMMJBKl9J8FvQNziwhix4o7hCLzXT
         PzAdnSeJQ6AkXPIFrpi0wRcO/XFR+xrStysH0UayytIdFKjxQ403S5/Y++v8LyOer4w0
         cz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574471; x=1700179271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYFwIAb7kxbU9cm7QXOeqNap9fm6ZmSIsEYNNSyiElg=;
        b=iJwpinMeNZcThINvTiUWSH2DDWf4u/9hp88JKmEQP69vjeDC8Ew/v7oPaXZoB/C8aC
         /Gi19n5Hlw/9bMvmatiWMdV7P+BGXAOPKQndCmS1a7t+QI7d0eQaIWXzlVmTxkLn0Qq3
         saESQKbEYld+IZffrRq0aTs0i5tSO3OMkUjzdycLMzMydYAZYxxiRG0AgLUZsTXDjykG
         RePAokP8q39ubvLqI678NTPcPh52MySoGvCoK5PNKTM6CZJnnAftJ2BB3a7Go6hG6Rb5
         5mvRmq+VUM57ljxfkdGaHjCQ9rQ11WYCDsUxteDnMue21JjaSjjVbEEpCY3bm5pCw2M3
         GYVg==
X-Gm-Message-State: AOJu0YxY7/old4rVtlCsjALRrtKtV9rmlHCDAmhz+runiSZ7Qi77irDA
        f6d0oCg4KUjRNvDujw/wLSI=
X-Google-Smtp-Source: AGHT+IEGqDLGnipkF9YoFz2felgnvo7Vb5L588AAUbBd74/hi1FnZonlpf6NmX8xoius41IHXeYBkA==
X-Received: by 2002:a17:90b:4a0c:b0:279:23a:9e70 with SMTP id kk12-20020a17090b4a0c00b00279023a9e70mr3237201pjb.2.1699574471020;
        Thu, 09 Nov 2023 16:01:11 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:10 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 36/52] perf annotate-data: Support stack variables
Date:   Thu,  9 Nov 2023 15:59:55 -0800
Message-ID: <20231110000012.3538610-37-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variables are allocated in the stack and the location list
should look like base register(s) and an offset.  Extend the
die_find_variable_by_reg() to handle the following expressions

 * DW_OP_breg{0..31}
 * DW_OP_bregx
 * DW_OP_fbreg

Ususally DWARF subprogram entries have frame base information and
use it to locate stack variable like below:

 <2><43d1575>: Abbrev Number: 62 (DW_TAG_variable)
    <43d1576>   DW_AT_location    : 2 byte block: 91 7c         (DW_OP_fbreg: -4)  <--- here
    <43d1579>   DW_AT_name        : (indirect string, offset: 0x2c00c9): i
    <43d157d>   DW_AT_decl_file   : 1
    <43d157e>   DW_AT_decl_line   : 78
    <43d157f>   DW_AT_type        : <0x43d19d7>

I found some differences on saving the frame base between gcc and clang.
The gcc uses the CFA to get the base so it needs to check the current
frame's CFI info.  In this case, stack offset needs to be adjusted from
the start of the CFA.

 <1><1bb8d>: Abbrev Number: 102 (DW_TAG_subprogram)
    <1bb8e>   DW_AT_name        : (indirect string, offset: 0x74d41): kernel_init
    <1bb92>   DW_AT_decl_file   : 2
    <1bb92>   DW_AT_decl_line   : 1440
    <1bb94>   DW_AT_decl_column : 18
    <1bb95>   DW_AT_prototyped  : 1
    <1bb95>   DW_AT_type        : <0xcc>
    <1bb99>   DW_AT_low_pc      : 0xffffffff81bab9e0
    <1bba1>   DW_AT_high_pc     : 0x1b2
    <1bba9>   DW_AT_frame_base  : 1 byte block: 9c      (DW_OP_call_frame_cfa)  <------ here
    <1bbab>   DW_AT_call_all_calls: 1
    <1bbab>   DW_AT_sibling     : <0x1bf5a>

While clang sets it to a register directly and it can check the register
and offset in the instruction directly.

 <1><43d1542>: Abbrev Number: 60 (DW_TAG_subprogram)
    <43d1543>   DW_AT_low_pc      : 0xffffffff816a7c60
    <43d154b>   DW_AT_high_pc     : 0x98
    <43d154f>   DW_AT_frame_base  : 1 byte block: 56    (DW_OP_reg6 (rbp))  <---------- here
    <43d1551>   DW_AT_GNU_all_call_sites: 1
    <43d1551>   DW_AT_name        : (indirect string, offset: 0x3bce91): foo
    <43d1555>   DW_AT_decl_file   : 1
    <43d1556>   DW_AT_decl_line   : 75
    <43d1557>   DW_AT_prototyped  : 1
    <43d1557>   DW_AT_type        : <0x43c7332>
    <43d155b>   DW_AT_external    : 1

Also it needs to update the offset after finding the type like global
variables since the offset was from the frame base.  Factor out
match_var_offset() to check global and local variables in the same way.

The type stats are improved too:

  Annotate data type stats:
  total 294, ok 160 (54.4%), bad 134 (45.6%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          51 : no_var
          14 : no_typeinfo
           7 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 35 +++++++++++++--
 tools/perf/util/dwarf-aux.c     | 79 ++++++++++++++++++++++++---------
 tools/perf/util/dwarf-aux.h     |  3 ++
 3 files changed, 93 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 99ecf4b3665c..b60c24091360 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -208,7 +208,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 	/*
 	 * Usually it expects a pointer type for a memory access.
 	 * Convert to a real type it points to.  But global variables
-	 * are accessed directly without a pointer.
+	 * and local variables are accessed directly without a pointer.
 	 */
 	if (is_pointer) {
 		if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
@@ -247,6 +247,9 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	int reg, offset;
 	int ret = -1;
 	int i, nr_scopes;
+	int fbreg = -1;
+	bool is_fbreg = false;
+	int fb_offset = 0;
 
 	/* Get a compile_unit for this address */
 	if (!find_cu_die(di, pc, &cu_die)) {
@@ -278,7 +281,33 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
 	nr_scopes = die_get_scopes(&cu_die, pc, &scopes);
 
+	if (reg != DWARF_REG_PC && dwarf_hasattr(&scopes[0], DW_AT_frame_base)) {
+		Dwarf_Attribute attr;
+		Dwarf_Block block;
+
+		/* Check if the 'reg' is assigned as frame base register */
+		if (dwarf_attr(&scopes[0], DW_AT_frame_base, &attr) != NULL &&
+		    dwarf_formblock(&attr, &block) == 0 && block.length == 1) {
+			switch (*block.data) {
+			case DW_OP_reg0 ... DW_OP_reg31:
+				fbreg = *block.data - DW_OP_reg0;
+				break;
+			case DW_OP_call_frame_cfa:
+				if (die_get_cfa(di->dbg, pc, &fbreg,
+						&fb_offset) < 0)
+					fbreg = -1;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
 retry:
+	is_fbreg = (reg == fbreg);
+	if (is_fbreg)
+		offset = loc->offset - fb_offset;
+
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
 		if (reg == DWARF_REG_PC) {
@@ -288,13 +317,13 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		} else {
 			/* Look up variables/parameters in this scope */
 			if (!die_find_variable_by_reg(&scopes[i], pc, reg,
-						      &var_die))
+						      &offset, is_fbreg, &var_die))
 				continue;
 		}
 
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
-				     reg != DWARF_REG_PC);
+				     reg != DWARF_REG_PC && !is_fbreg);
 		loc->offset = offset;
 		goto out;
 	}
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 3d42a8613869..7caf52fdc255 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1272,11 +1272,39 @@ struct find_var_data {
 	unsigned reg;
 	/* Access offset, set for global data */
 	int offset;
+	/* True if the current register is the frame base */
+	bool is_fbreg;
 };
 
 /* Max number of registers DW_OP_regN supports */
 #define DWARF_OP_DIRECT_REGS  32
 
+static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
+			     u64 addr_offset, u64 addr_type)
+{
+	Dwarf_Die type_die;
+	Dwarf_Word size;
+
+	if (addr_offset == addr_type) {
+		/* Update offset relative to the start of the variable */
+		data->offset = 0;
+		return true;
+	}
+
+	if (die_get_real_type(die_mem, &type_die) == NULL)
+		return false;
+
+	if (dwarf_aggregate_size(&type_die, &size) < 0)
+		return false;
+
+	if (addr_offset >= addr_type + size)
+		return false;
+
+	/* Update offset relative to the start of the variable */
+	data->offset = addr_offset - addr_type;
+	return true;
+}
+
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1301,14 +1329,30 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		if (start > data->pc)
 			break;
 
+		/* Local variables accessed using frame base register */
+		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
+		    data->offset >= (int)ops->number &&
+		    match_var_offset(die_mem, data, data->offset, ops->number))
+			return DIE_FIND_CB_END;
+
 		/* Only match with a simple case */
 		if (data->reg < DWARF_OP_DIRECT_REGS) {
 			if (ops->atom == (DW_OP_reg0 + data->reg) && nops == 1)
 				return DIE_FIND_CB_END;
+
+			/* Local variables accessed by a register + offset */
+			if (ops->atom == (DW_OP_breg0 + data->reg) &&
+			    match_var_offset(die_mem, data, data->offset, ops->number))
+				return DIE_FIND_CB_END;
 		} else {
 			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
 			    nops == 1)
 				return DIE_FIND_CB_END;
+
+			/* Local variables accessed by a register + offset */
+			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
+			    match_var_offset(die_mem, data, data->offset, ops->number2))
+				return DIE_FIND_CB_END;
 		}
 	}
 	return DIE_FIND_CB_SIBLING;
@@ -1319,18 +1363,29 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
  * @sc_die: a scope DIE
  * @pc: the program address to find
  * @reg: the register number to find
+ * @poffset: pointer to offset, will be updated for fbreg case
+ * @is_fbreg: boolean value if the current register is the frame base
  * @die_mem: a buffer to save the resulting DIE
  *
- * Find the variable DIE accessed by the given register.
+ * Find the variable DIE accessed by the given register.  It'll update the @offset
+ * when the variable is in the stack.
  */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
+				    int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem)
 {
 	struct find_var_data data = {
 		.pc = pc,
 		.reg = reg,
+		.offset = *poffset,
+		.is_fbreg = is_fbreg,
 	};
-	return die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
+	Dwarf_Die *result;
+
+	result = die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
+	if (result)
+		*poffset = data.offset;
+	return result;
 }
 
 /* Only checks direct child DIEs in the given scope */
@@ -1341,8 +1396,6 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 	ptrdiff_t off = 0;
 	Dwarf_Attribute attr;
 	Dwarf_Addr base, start, end;
-	Dwarf_Word size;
-	Dwarf_Die type_die;
 	Dwarf_Op *ops;
 	size_t nops;
 
@@ -1359,24 +1412,8 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 		if (data->addr < ops->number)
 			continue;
 
-		if (data->addr == ops->number) {
-			/* Update offset relative to the start of the variable */
-			data->offset = 0;
+		if (match_var_offset(die_mem, data, data->addr, ops->number))
 			return DIE_FIND_CB_END;
-		}
-
-		if (die_get_real_type(die_mem, &type_die) == NULL)
-			continue;
-
-		if (dwarf_aggregate_size(&type_die, &size) < 0)
-			continue;
-
-		if (data->addr >= ops->number + size)
-			continue;
-
-		/* Update offset relative to the start of the variable */
-		data->offset = data->addr - ops->number;
-		return DIE_FIND_CB_END;
 	}
 	return DIE_FIND_CB_SIBLING;
 }
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index f209f9162908..85dd527ae1f7 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -142,6 +142,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
 /* Find a variable saved in the 'reg' at given address */
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
+				    int *poffset, bool is_fbreg,
 				    Dwarf_Die *die_mem);
 
 /* Find a (global) variable located in the 'addr' */
@@ -161,6 +162,8 @@ static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
 static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unused,
 						  Dwarf_Addr pc __maybe_unused,
 						  int reg __maybe_unused,
+						  int *poffset __maybe_unused,
+						  bool is_fbreg __maybe_unused,
 						  Dwarf_Die *die_mem __maybe_unused)
 {
 	return NULL;
-- 
2.42.0.869.gea05f2083d-goog

