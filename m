Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8E7E7589
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjKJADM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbjKJACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33703525C;
        Thu,  9 Nov 2023 16:01:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28010522882so1314629a91.0;
        Thu, 09 Nov 2023 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574466; x=1700179266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwhq2HXjG2411ugWKKGi+YPUSV7LvJmORRwVZhcG1E4=;
        b=BAgtCuSSk8OO/rkuonWq0zB/Pxz/JRF3c5mtaDpuIk9L+DZ4Fq7gz+XTEtxrz0Hnw/
         pjPrcy4EKCNp/ppQnNQTOzY3kMHes2bDfmk2qO/H5LZ9DFafpE4w5JfsL0knC6N4oXCa
         9TYhUb68nUbu1qg6evUxeenRyH/7C/ZYuRNnvdMsSNDRfC4zVJdVCWDDSlD2e0rwimpz
         QZ997rhoVKeZHHahpgheQ5oD6W5m4AQwYPOD2T4DDDRA/l7MSP4tskPLiOxHurU0s8yU
         Rn9oiYE2iwgxmJns+pKX/T5mKcGWixgo9pkeyK7ULwR9JbDzOOQuYFMCxzlWPM3LHlyZ
         H5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574466; x=1700179266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwhq2HXjG2411ugWKKGi+YPUSV7LvJmORRwVZhcG1E4=;
        b=k43bnA8FRfgbx1e52qe52sXIIE9yGKXKW1TNe2aVcS/AtKr9ViqkS7zOwCwt3ET3lN
         XH0ZVUyCGgbuRls1b3QxPouzwNyF6mzV4hi1TUu94GEoNlGadnPaD98d+ob8CgQsX8HE
         LwFSARUYi7KKHEWfFa7gruSmVloiX5wqOU9Fc6xXsKXLcLeZEBZpaqRRlfGXPJmoOc3p
         dqhPRzDT1hGK8LDKbBvx0mCFqreavDw7YrYzyR0CKObRkyH1iz4MUB4a0AXeAsLRIn+8
         oT8U1UHaNBVKcRj/A+JV90Vmr+OXWNsOh0CkyODX5Q4WOgsxN1d6aQwFWyoDJJmTkWoL
         IQZg==
X-Gm-Message-State: AOJu0YzzQovqh+ViYamasfOhQySynyB3nbUq0wB1XvB20o2lkiTesR8/
        KjLb70V3FmOyDNhZzbkIf7A=
X-Google-Smtp-Source: AGHT+IHDL+Z4a9rWgnaAQPyeqkbi1U+vt6X03McufmDlefT0OtYZG3E99FadkSmHlPtiOcaOGr7FyA==
X-Received: by 2002:a17:90b:4d09:b0:283:84c:3871 with SMTP id mw9-20020a17090b4d0900b00283084c3871mr622222pjb.3.1699574466457;
        Thu, 09 Nov 2023 16:01:06 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:06 -0800 (PST)
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
Subject: [PATCH 33/52] perf annotate-data: Handle PC-relative addressing
Date:   Thu,  9 Nov 2023 15:59:52 -0800
Message-ID: <20231110000012.3538610-34-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend find_data_type_die() to find data type from PC-relative address
using die_find_variable_by_addr().  Users need to pass the address for
the (global) variable.

The offset for the variable should be updated after finding the type
because the offset in the instruction is just to calcuate the address
for the variable.  So it changed to pass a pointer to offset and renamed
it to 'poffset'.

First it searches variables in the CU DIE as it's likely that the global
variables are defined in the file level.  And then it iterates the scope
DIEs to find a local (static) variable.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 56 ++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 159fceeebaa4..61d2a17044c0 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -13,6 +13,7 @@
 #include "debuginfo.h"
 #include "debug.h"
 #include "dso.h"
+#include "dwarf-regs.h"
 #include "evsel.h"
 #include "evlist.h"
 #include "map.h"
@@ -192,7 +193,8 @@ static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
 }
 
 /* The type info will be saved in @type_die */
-static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
+static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
+			  bool is_pointer)
 {
 	Dwarf_Word size;
 
@@ -204,15 +206,18 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 	}
 
 	/*
-	 * It expects a pointer type for a memory access.
-	 * Convert to a real type it points to.
+	 * Usually it expects a pointer type for a memory access.
+	 * Convert to a real type it points to.  But global variables
+	 * are accessed directly without a pointer.
 	 */
-	if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
-	     dwarf_tag(type_die) != DW_TAG_array_type) ||
-	    die_get_real_type(type_die, type_die) == NULL) {
-		pr_debug("no pointer or no type\n");
-		ann_data_stat.no_typeinfo++;
-		return -1;
+	if (is_pointer) {
+		if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
+		     dwarf_tag(type_die) != DW_TAG_array_type) ||
+		    die_get_real_type(type_die, type_die) == NULL) {
+			pr_debug("no pointer or no type\n");
+			ann_data_stat.no_typeinfo++;
+			return -1;
+		}
 	}
 
 	/* Get the size of the actual type */
@@ -233,7 +238,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 }
 
 /* The result will be saved in @type_die */
-static int find_data_type_die(struct debuginfo *di, u64 pc,
+static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
@@ -249,21 +254,36 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 		return -1;
 	}
 
-	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
-	nr_scopes = die_get_scopes(&cu_die, pc, &scopes);
-
 	reg = loc->reg1;
 	offset = loc->offset;
 
+	if (reg == DWARF_REG_PC &&
+	    die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
+		ret = check_variable(&var_die, type_die, offset,
+				     /*is_pointer=*/false);
+		goto out;
+	}
+
+	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
+	nr_scopes = die_get_scopes(&cu_die, pc, &scopes);
+
 retry:
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
-		/* Look up variables/parameters in this scope */
-		if (!die_find_variable_by_reg(&scopes[i], pc, reg, &var_die))
-			continue;
+		if (reg == DWARF_REG_PC) {
+			if (!die_find_variable_by_addr(&scopes[i], pc, addr,
+						       &var_die, &offset))
+				continue;
+		} else {
+			/* Look up variables/parameters in this scope */
+			if (!die_find_variable_by_reg(&scopes[i], pc, reg,
+						      &var_die))
+				continue;
+		}
 
 		/* Found a variable, see if it's correct */
-		ret = check_variable(&var_die, type_die, offset);
+		ret = check_variable(&var_die, type_die, offset,
+				     reg != DWARF_REG_PC);
 		goto out;
 	}
 
@@ -311,7 +331,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, loc, &type_die) < 0)
+	if (find_data_type_die(di, pc, 0, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
-- 
2.42.0.869.gea05f2083d-goog

