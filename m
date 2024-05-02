Return-Path: <linux-kernel+bounces-165994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC98B9475
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66434283D72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54421A06;
	Thu,  2 May 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf2zs8bG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAC200C1;
	Thu,  2 May 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629613; cv=none; b=KUu/4MxVDMi40qtfEROUgXwFW0HgJNBfHzyCqjboK9Pmppmg7AWYLhTl8EI7SHcXfkaATE+4Pb9LVNiRa/+D9kTCYDve5iRemgz6+ZbQ3XfaRuyx326mQNZ/hjp3fU219VQ4Uuq1oDo/M5rdo1lgxREF0pcKZfeTwfEbYAEB/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629613; c=relaxed/simple;
	bh=zamPJCSjSG+pCfLqayGyCmEr6GJWt/RSUPZolnFgaGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3Xt3uj05gyVcrdM3EEMgkLB82Z0Guoj7aZIxN1oUq/BmuuZlYBOTW377ihW2r4yCK+xatQctfbXf+TiPRCZ0G+6+mUdrvJoM55Wuz/NE4TU3Wx/QCBS1/TGsOobLxxWwSoj7hjzNhna96rCBK9ZLa5JKbk0d1wr2qrScw4tF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf2zs8bG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE07CC4AF1B;
	Thu,  2 May 2024 06:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714629613;
	bh=zamPJCSjSG+pCfLqayGyCmEr6GJWt/RSUPZolnFgaGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mf2zs8bGiCmtcXgOJkeMSCdHVIVT415uotH3XYA+24ZYUoz+tYMvw71BANcQ1/Vae
	 BMNGfbb2y00lYg2yot8ZWh9eYODHM4h72jktERY4ypljt00HdQbFHaSie3bYeZc2Vs
	 xjnB5GupsH9RMPLkqKUPDktbQMzBx0PS/koYUf1QJdHIbu/FO5fW+cQ07XHdC2kZGp
	 w3HwNfY5h3lboobASJTP8hezJHY8kDAjWAhlB6wV7/u4aUANypM6GjkDKmkjky5jbW
	 PA6xK2DFUnaKPCgSCBDrjNe/+uQccWGfdpVpnnaJgWNesVPoi+F1WEygWVxpQOthLa
	 +KFa7F4dRYr4g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/6] perf dwarf-aux: Add die_collect_global_vars()
Date: Wed,  1 May 2024 23:00:06 -0700
Message-ID: <20240502060011.1838090-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240502060011.1838090-1-namhyung@kernel.org>
References: <20240502060011.1838090-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is to search all global variables in the CU.  We want to
have the list of global variables at once and match them later.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 62 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  8 +++++
 2 files changed, 70 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 40cfbdfe2d75..c0a492e65388 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1630,6 +1630,68 @@ void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types)
 
 	die_find_child(sc_die, __die_collect_vars_cb, (void *)var_types, &die_mem);
 }
+
+static int __die_collect_global_vars_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct die_var_type **var_types = arg;
+	Dwarf_Die type_die;
+	int tag = dwarf_tag(die_mem);
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t nops;
+	struct die_var_type *vt;
+
+	if (tag != DW_TAG_variable)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	/* Only collect the location with an absolute address. */
+	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
+		return DIE_FIND_CB_SIBLING;
+
+	if (ops->atom != DW_OP_addr)
+		return DIE_FIND_CB_SIBLING;
+
+	if (!check_allowed_ops(ops, nops))
+		return DIE_FIND_CB_SIBLING;
+
+	if (die_get_real_type(die_mem, &type_die) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	vt = malloc(sizeof(*vt));
+	if (vt == NULL)
+		return DIE_FIND_CB_END;
+
+	vt->die_off = dwarf_dieoffset(&type_die);
+	vt->addr = ops->number;
+	vt->reg = -1;
+	vt->offset = 0;
+	vt->next = *var_types;
+	*var_types = vt;
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_collect_global_vars - Save all global variables
+ * @cu_die: a CU DIE
+ * @var_types: a pointer to save the resulting list
+ *
+ * Save all global variables in the @cu_die and save them to @var_types.
+ * The @var_types is a singly-linked list containing type and location info.
+ * Actual type can be retrieved using dwarf_offdie() with 'die_off' later.
+ *
+ * Callers should free @var_types.
+ */
+void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types)
+{
+	Dwarf_Die die_mem;
+
+	die_find_child(cu_die, __die_collect_global_vars_cb, (void *)var_types, &die_mem);
+}
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #ifdef HAVE_DWARF_CFI_SUPPORT
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index b0f25fbf9668..24446412b869 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -171,6 +171,9 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
 /* Save all variables and parameters in this scope */
 void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
 
+/* Save all global variables in this CU */
+void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -203,6 +206,11 @@ static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
 {
 }
 
+static inline void die_collect_global_vars(Dwarf_Die *cu_die __maybe_unused,
+					   struct die_var_type **var_types __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #ifdef HAVE_DWARF_CFI_SUPPORT
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


