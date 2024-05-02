Return-Path: <linux-kernel+bounces-165995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6848B9476
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878A01C21254
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95024211;
	Thu,  2 May 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adJBniXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611E21A04;
	Thu,  2 May 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629614; cv=none; b=i/K0PLBrQ0DpmvuQUogUPZNbuPx0R57MrzmhzBKj1/5is3sEueX9YoXggRu5cA/fNV1EgEST5MclTS0kwt2QlGAVwR+nKLuUt7wufFf4bJVxWRQxtCmXr0GxuykuvrJH5ErqJkwH+EEkLlCZljPBGKblkHs8JY5qErCU03J4pOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629614; c=relaxed/simple;
	bh=h6exK3w1cm8ykwfB731qAJf7BoUGS3DGiwQPGvQefUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5FXmSt5nGmF0wtDnkV4XdAYHBn8JbDC/H8m1YPevHyu/aRvd52JEuLzWpeQUD/WRLokGAlYYEv9kGIRbjf9EMec9Jmp3Ys4TkOUHQnCOUffTUcp1mZkvd+ka+R3lA+QMH2ntxcsF7VNuDdLytdOr/Bpovb4MwY9XtZCRrW9IfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adJBniXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A06CC4AF1D;
	Thu,  2 May 2024 06:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714629613;
	bh=h6exK3w1cm8ykwfB731qAJf7BoUGS3DGiwQPGvQefUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adJBniXSqe9CqNaEDowdyCnnQxX74cujjSFodDuirMe2YrAtlbg8rZpzuaubIz4VZ
	 QwmdKxU2WrCOCtKVEqVChvXrcODU0FJBupEylSxdIFXs4Yhm7xNXr9wpNxjlaQ8rBB
	 PHWRgs1D+C9R4R8kksySAbGVo6lRl1JeJTaQjHgOWgPf2lOj/ZA8N3HtFN24CRtO/t
	 zimC6Fv0Oz8zRVsyVX6RlcNZexBeIsPpeLB2K7PdUuLRdkIGPDHBTqbaP66A+3xZ8P
	 RvAI4KvrDnXHKlmD816XHICJsviqG621fud7QRWXz6eQ7Vk1g2CP1wViXKiDLCgoVE
	 CZG7/tN062ycQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/6] perf annotate-data: Collect global variables in advance
Date: Wed,  1 May 2024 23:00:07 -0700
Message-ID: <20240502060011.1838090-3-namhyung@kernel.org>
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

Currently it looks up global variables from the current CU using address
and name.  But it sometimes fails to find a variable as the variable can
come from a different CU - but it's still strange it failed to find a
declaration for some reason.

Anyway, it can collect all global variables from all CU once and then
lookup them later on.  This slightly improves the success rate of my
test data set.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 57 +++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 12d5faff3b7a..4dd0911904f2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -28,6 +28,8 @@
 /* register number of the stack pointer */
 #define X86_REG_SP 7
 
+static void delete_var_types(struct die_var_type *var_types);
+
 enum type_state_kind {
 	TSR_KIND_INVALID = 0,
 	TSR_KIND_TYPE,
@@ -557,8 +559,8 @@ static bool global_var__add(struct data_loc_info *dloc, u64 addr,
 	if (gvar == NULL)
 		return false;
 
-	gvar->name = strdup(name);
-	if (gvar->name == NULL) {
+	gvar->name = name ? strdup(name) : NULL;
+	if (name && gvar->name == NULL) {
 		free(gvar);
 		return false;
 	}
@@ -612,6 +614,53 @@ static bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
 	return true;
 }
 
+static void global_var__collect(struct data_loc_info *dloc)
+{
+	Dwarf *dwarf = dloc->di->dbg;
+	Dwarf_Off off, next_off;
+	Dwarf_Die cu_die, type_die;
+	size_t header_size;
+
+	/* Iterate all CU and collect global variables that have no location in a register. */
+	off = 0;
+	while (dwarf_nextcu(dwarf, off, &next_off, &header_size,
+			    NULL, NULL, NULL) == 0) {
+		struct die_var_type *var_types = NULL;
+		struct die_var_type *pos;
+
+		if (dwarf_offdie(dwarf, off + header_size, &cu_die) == NULL) {
+			off = next_off;
+			continue;
+		}
+
+		die_collect_global_vars(&cu_die, &var_types);
+
+		for (pos = var_types; pos; pos = pos->next) {
+			const char *var_name = NULL;
+			int var_offset = 0;
+
+			if (pos->reg != -1)
+				continue;
+
+			if (!dwarf_offdie(dwarf, pos->die_off, &type_die))
+				continue;
+
+			if (!get_global_var_info(dloc, pos->addr, &var_name,
+						 &var_offset))
+				continue;
+
+			if (var_offset != 0)
+				continue;
+
+			global_var__add(dloc, pos->addr, var_name, &type_die);
+		}
+
+		delete_var_types(var_types);
+
+		off = next_off;
+	}
+}
+
 static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 				u64 ip, u64 var_addr, int *var_offset,
 				Dwarf_Die *type_die)
@@ -620,8 +669,12 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 	int offset;
 	const char *var_name = NULL;
 	struct global_var_entry *gvar;
+	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die var_die;
 
+	if (RB_EMPTY_ROOT(&dso->global_vars))
+		global_var__collect(dloc);
+
 	gvar = global_var__find(dloc, var_addr);
 	if (gvar) {
 		if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_die))
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


