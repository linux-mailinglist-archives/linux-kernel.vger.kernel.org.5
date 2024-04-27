Return-Path: <linux-kernel+bounces-160825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0178B434E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4782827F0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE323FBB3;
	Sat, 27 Apr 2024 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sivGlrSp"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281233FBA2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178284; cv=none; b=plcSjjEc6J2bwYj5DmdlMUDhQC2udnGVaiKauydy4FYboTuAfmZ1UoPSP/yszNfiCaIR34g9SjQfBgxHYwDH9LcpkyJ8qiEFHSuXGeuu6SAO6fuCKzp3zpaZ6DbMLEW9qvRAC5uO/83sCAAI2eULxSJHA/20dNVUm7EFR33Q8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178284; c=relaxed/simple;
	bh=eMj3Z5zlEYlTfocBWKvpvJxSBuEHTxAA4dcpTuqRF/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQCvhxVaEv8/spAhKoP7gSPE2zBN0jxLrb7NuUPAbJTs1c63lJHD5XHmuOt+SQZjfWV2eSG82ai0iUexImhuMsTg4RMHQf5OoweokefGaY3LRwhKPxyPTgbNzfXkGebxILjg+oThl4mN/iWrrK1oafAWFkinRfYZN+dNnyT9NCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sivGlrSp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx3PKav0CetNdFI0jFUffF6lUGwk4q4qKzC3INQ2E8A=;
	b=sivGlrSpl81qjvi6K7a/ZlE+lX7x9zLqRfOxT3jTy3TpHNeCbRa/CRH5yGHNGDKvqIijXu
	BGuhy0LIWV81fc/WqvGITWNss9qyDo50w1qvtd+jaICAMwbaUac4gGWLUWsi6XL7uBHCmV
	pOaOEV7xvE4/E41E676iu4kaYa9KQZU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] memcg: use proper type for mod_memcg_state
Date: Fri, 26 Apr 2024 17:37:32 -0700
Message-ID: <20240427003733.3898961-7-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-1-shakeel.butt@linux.dev>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg stats update functions can take arbitrary integer but the
only input which make sense is enum memcg_stat_item and we don't
want these functions to be called with arbitrary integer, so replace
the parameter type with enum memcg_stat_item and compiler will be able
to warn if memcg stat update functions are called with incorrect index
value.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 13 +++++++------
 mm/memcontrol.c            |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab8a6e884375..73cad69dfb5a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -974,7 +974,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 void folio_memcg_lock(struct folio *folio);
 void folio_memcg_unlock(struct folio *folio);
 
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
+void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item  idx,
+		       int val);
 
 /* try to stablize folio_memcg() for all the pages in a memcg */
 static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
@@ -995,7 +996,7 @@ static inline void mem_cgroup_unlock_pages(void)
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
-				   int idx, int val)
+				   enum memcg_stat_item idx, int val)
 {
 	unsigned long flags;
 
@@ -1005,7 +1006,7 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 }
 
 static inline void mod_memcg_page_state(struct page *page,
-					int idx, int val)
+					enum memcg_stat_item idx, int val)
 {
 	struct mem_cgroup *memcg;
 
@@ -1491,19 +1492,19 @@ static inline void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 static inline void __mod_memcg_state(struct mem_cgroup *memcg,
-				     int idx,
+				     enum memcg_stat_item idx,
 				     int nr)
 {
 }
 
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
-				   int idx,
+				   enum memcg_stat_item idx,
 				   int nr)
 {
 }
 
 static inline void mod_memcg_page_state(struct page *page,
-					int idx, int val)
+					enum memcg_stat_item idx, int val)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36145089dcf5..d11536ef59ef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -961,7 +961,8 @@ static int memcg_state_val_in_pages(int idx, int val)
  * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
  * @val: delta to add to the counter, can be negative
  */
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
+void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+		       int val)
 {
 	int i = memcg_stats_index(idx);
 
-- 
2.43.0


