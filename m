Return-Path: <linux-kernel+bounces-28563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51083001D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B911BB24712
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BFF12E76;
	Wed, 17 Jan 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCvDt1ov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F711711;
	Wed, 17 Jan 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472822; cv=none; b=neeyYUso6OMMFtU4VeihcCZwe/SiqVRDLTLrUBO0ksLDIzDLgIkH2PEj8mr4tquzf7hKe/ryeqXi9m1BgB9RKM20fQlS3fPZkHkorEcmPPMBfFZYohp4A0t7N6gEprRKOMfpAkh6+rjgbEIEwzRhX7A3fpTsNYX+4MW9Bpm3eBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472822; c=relaxed/simple;
	bh=wE82ritHTE74+RHB+Pr/effD1erOa2JK6chZWpXG76o=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=kJHVT45CA/WCukCS2NSyWrYoqdBmyk1jExL/XjO+Ax4/qIbPnpTlMmL/y1o32WsqJxh64VFVrzuNXzAIaBWPzT+QmcAohtrQrjk5LKee5PLfAgiE1ggcPv3PVWmHCh0d7g45KxEBCCAGb9q11K8gxiUbhnb744aEBu2HxVZYDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCvDt1ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9CBC43143;
	Wed, 17 Jan 2024 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472822;
	bh=wE82ritHTE74+RHB+Pr/effD1erOa2JK6chZWpXG76o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCvDt1ov+RkEhIJgqixeTPtwn43mghK+5T1tiNq4SDhTb1g8gCY3gJhPxbNw/JgAe
	 Un+7NOhH0K1CAl+eR9s52pOuLPsvowxHChYJ5LAhG4YG/Rsn/PX/An4bROMbVe9s92
	 4HlhMwIQl9c6QdgXYTzN6BaP7tOsjddijrwlAHbQGYN6yfGu52Vt2FBQTet1dVeMdN
	 8Sig9l+t+O4yZKejIBoQqZsN+FplD814qLI13P2Ttsm/s8/nmW+j2tCm7c39vhcv+t
	 VhkzL6MrmJWveGyfTvgmeHIedRvuyDlBmep/VMPOZbBTj1ZGbHUqo/CIX9PzoNh5SU
	 LMU7hz8s2fKMw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
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
Subject: [PATCH 5/9] perf annotate-data: Handle PC-relative addressing
Date: Tue, 16 Jan 2024 22:26:53 -0800
Message-ID: <20240117062657.985479-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
References: <20240117062657.985479-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index d1ceac7e2441..58c0fac42e9d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -14,6 +14,7 @@
 #include "debuginfo.h"
 #include "debug.h"
 #include "dso.h"
+#include "dwarf-regs.h"
 #include "evsel.h"
 #include "evlist.h"
 #include "map.h"
@@ -193,7 +194,8 @@ static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
 }
 
 /* The type info will be saved in @type_die */
-static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
+static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
+			  bool is_pointer)
 {
 	Dwarf_Word size;
 
@@ -205,15 +207,18 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
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
@@ -234,7 +239,7 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 }
 
 /* The result will be saved in @type_die */
-static int find_data_type_die(struct debuginfo *di, u64 pc,
+static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
@@ -250,21 +255,36 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
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
 
@@ -312,7 +332,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, loc, &type_die) < 0)
+	if (find_data_type_die(di, pc, 0, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
-- 
2.43.0.381.gb435a96ce8-goog


