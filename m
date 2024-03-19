Return-Path: <linux-kernel+bounces-107030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60087F6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C812827AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8367CF33;
	Tue, 19 Mar 2024 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrPViAIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524277C0BA;
	Tue, 19 Mar 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827480; cv=none; b=rkfbpXVsCmccrarJe3xgdcM0mnfStTc4n1l2vLc2/gjOzJv4lQ54PRnB5Iar2rjMH2AWSKFZtglEM93wqbBCLpSLQS2LNqo9YOJ7Y1x44BzPAiikcE8g5ryVapEVSyms2HACZ+HhaaVPULt4tl2zHp1xSPmmhLOTJSrzovQzO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827480; c=relaxed/simple;
	bh=WMphHepUfbpYGRKmFUiOHSnJjO7ivT7ai1Zyujs+j20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYjBf12Wj/SfiwPAJtloo/bM0mjRBbxFUWDDGEPLztnltUjUvna8D/tFHOOYistUkMDQcdDxYSVgJTpDJHRyG1qcL7zWD6dL4KyEZQz3S65HBznKJtHAQMvLbmJvTYuPvLEZ1G1qSvMkTZx0ww2eWpDLaSHiil/uVUXHLLIKqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrPViAIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7BDC433B1;
	Tue, 19 Mar 2024 05:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827479;
	bh=WMphHepUfbpYGRKmFUiOHSnJjO7ivT7ai1Zyujs+j20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrPViAIc2rkJp3ROlZ/5mRnPP9LI3J+f3rT0y/CBSWeNuGMayEEhJUIPHX1PsEZC6
	 tmbQZ71+DRtskBu75xZgyzo8lgiCisfmKFm0oQ0RQneLHB90CPnTssgNuOAR6RBHRD
	 lUZNVUAPG4yS4CPD07lKuBG+Ku6KdKyHnyMROPttdqNOrkGK+uARsXN2pHzyPTZZpl
	 S546O/YhfRnqKGTmONHCPTiQTHr7gtv9HDLxUe4KnHSrnBKJwlYwiT9hHTTQTkN0kK
	 TohtfDWCfkt96dwk9qkFHnIFamjCQxUBy1eZiZtTAFUlEPgbrxTfOCn8JInVEjebEg
	 RcRMd8ocLc33A==
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
Subject: [PATCH 04/23] perf dwarf-aux: Add die_find_func_rettype()
Date: Mon, 18 Mar 2024 22:50:56 -0700
Message-ID: <20240319055115.4063940-5-namhyung@kernel.org>
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

The die_find_func_rettype() is to find a debug entry for the given
function name and sets the type information of the return value.  By
convention, it'd return the pointer to the type die (should be the
same as the given mem_die argument) if found, or NULL otherwise.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 43 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  4 ++++
 2 files changed, 47 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index cd9364d296b6..9080119a258c 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -696,6 +696,49 @@ Dwarf_Die *die_find_inlinefunc(Dwarf_Die *sp_die, Dwarf_Addr addr,
 	return die_mem;
 }
 
+static int __die_find_func_rettype_cb(Dwarf_Die *die_mem, void *data)
+{
+	const char *func_name;
+
+	if (dwarf_tag(die_mem) != DW_TAG_subprogram)
+		return DIE_FIND_CB_SIBLING;
+
+	func_name = dwarf_diename(die_mem);
+	if (func_name && !strcmp(func_name, data))
+		return DIE_FIND_CB_END;
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_find_func_rettype - Search a return type of function
+ * @cu_die: a CU DIE
+ * @name: target function name
+ * @die_mem: a buffer for result DIE
+ *
+ * Search a non-inlined function which matches to @name and stores the
+ * return type of the function to @die_mem and returns it if found.
+ * Returns NULL if failed.  Note that it doesn't needs to find a
+ * definition of the function, so it doesn't match with address.
+ * Most likely, it can find a declaration at the top level.  Thus the
+ * callback function continues to sibling entries only.
+ */
+Dwarf_Die *die_find_func_rettype(Dwarf_Die *cu_die, const char *name,
+				 Dwarf_Die *die_mem)
+{
+	Dwarf_Die tmp_die;
+
+	cu_die = die_find_child(cu_die, __die_find_func_rettype_cb,
+				(void *)name, &tmp_die);
+	if (!cu_die)
+		return NULL;
+
+	if (die_get_real_type(&tmp_die, die_mem) == NULL)
+		return NULL;
+
+	return die_mem;
+}
+
 struct __instance_walk_param {
 	void    *addr;
 	int	(*callback)(Dwarf_Die *, void *);
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 16c916311bc0..b0f25fbf9668 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -94,6 +94,10 @@ Dwarf_Die *die_find_top_inlinefunc(Dwarf_Die *sp_die, Dwarf_Addr addr,
 Dwarf_Die *die_find_inlinefunc(Dwarf_Die *sp_die, Dwarf_Addr addr,
 			       Dwarf_Die *die_mem);
 
+/* Search a non-inlined function by name and returns its return type */
+Dwarf_Die *die_find_func_rettype(Dwarf_Die *sp_die, const char *name,
+				 Dwarf_Die *die_mem);
+
 /* Walk on the instances of given DIE */
 int die_walk_instances(Dwarf_Die *in_die,
 		       int (*callback)(Dwarf_Die *, void *), void *data);
-- 
2.44.0.291.gc1ea87d7ee-goog


