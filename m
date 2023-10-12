Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065187C6383
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377393AbjJLDye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376980AbjJLDxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0310CA;
        Wed, 11 Oct 2023 20:51:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso469296b3a.2;
        Wed, 11 Oct 2023 20:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082713; x=1697687513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/3AXS9Rj9IPcZO9IlTYzpMxmpnZprD+7U+lZk0v8yU=;
        b=WuJyjeFH3yZpX5R/DtMMTxa5B0IdPLBSjRDW3meBBJp3hok+L1kiKtN3rczG3wCk5q
         wJjRZCRBg3fdOgFH5Qwywpe2sTn9ecuLe85a25Da+1Cp7OaEUrBoMcJbbpg7aTNA+aYb
         2b4EVsSnqU2Kx8+XaLLLLf+xsuLOayxCopRF/pnu0xM1glnW79YSgxflAKzDHwSpRd3a
         vJz4CfdSk+gh5HPufqtmDtEjZOfwVt8WdOkd9kaz/aj02rJP6qH8QuuNgrKb8/wmKowz
         fU11vjC0VYjVJLcnoU3J1aIN771gzZTPOuLN98S1erOCSNWHsNS3e7CAYoW7jWK9rQ3j
         4XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082713; x=1697687513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/3AXS9Rj9IPcZO9IlTYzpMxmpnZprD+7U+lZk0v8yU=;
        b=KyUk5Z2slsgsiGO8FqcHDNhVWUObVVfea3WTRdsa3UiMqVRvW1spVZsgpSCGU/eXmO
         IA6L94G7Zpvf91EuyH2tksi1gcEBaxg1Bni7qHM1ePtuHIX4+1K4ECc3KgqrCGIv9BgE
         Ah7NTuLZKtkNHz11fmJ99KRgjow69gmin9lsvG6/3GthkemyY4XgSNpXgoIeWPs3ZZ4k
         bHW0X89LIXdZovCWMd+ZxEctsYTN9BipTq22jkWGuVzg5aVBQF4vGnqOspZRpZQgQurS
         kngpT7A4UTIgvR9tVkp3FKdnvRY/KmD4gxzcY8L3rH5xXcIRp/nlULezCqH34b0TwGtM
         ED7A==
X-Gm-Message-State: AOJu0YwrdZhHxaDyLH3HV4CZC1EL2N8jmbhZfYoiBlLrPGgiQ03wAuKZ
        7d01o/jeNGv34sYLeLH9HEE=
X-Google-Smtp-Source: AGHT+IGIGFc6nerncuK7S2GIAerHdtJKeM0g3yKnFCiw7Gu7PMhXZ3/WNNaFm483buOG4tJOKjNASQ==
X-Received: by 2002:a05:6a21:6d88:b0:162:d056:9f52 with SMTP id wl8-20020a056a216d8800b00162d0569f52mr27347817pzb.14.1697082713018;
        Wed, 11 Oct 2023 20:51:53 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:52 -0700 (PDT)
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
Subject: [PATCH 29/48] perf annotate-data: Handle PC-relative addressing
Date:   Wed, 11 Oct 2023 20:50:52 -0700
Message-ID: <20231012035111.676789-30-namhyung@kernel.org>
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
index a4276106e8a8..3d4bd5040782 100644
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
@@ -210,7 +211,8 @@ static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
 }
 
 /* The type info will be saved in @type_die */
-static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
+static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
+			  bool is_pointer)
 {
 	Dwarf_Word size;
 
@@ -222,15 +224,18 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
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
@@ -251,7 +256,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 }
 
 /* The result will be saved in @type_die */
-static int find_data_type_die(struct debuginfo *di, u64 pc,
+static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
@@ -267,21 +272,36 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
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
 
@@ -329,7 +349,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, loc, &type_die) < 0)
+	if (find_data_type_die(di, pc, 0, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
-- 
2.42.0.655.g421f12c284-goog

