Return-Path: <linux-kernel+bounces-163392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CD8B6A32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF0A2814CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B819477;
	Tue, 30 Apr 2024 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9Ajc1vV"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDED3B1A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457205; cv=none; b=jIgdDVMD1Uqtl4O5gabO0FvaxW31tAvK7tJSsAId1b0g4GVNiO/i2ghZ1jR7GO5RuBaRNghDo76ftbgsIeYySHbVSO4FwHbBF4j8qH0XqOKgITEn6V5KSF3R2V7oCardCNQYPUsaEabtHemY9ulPsJNbrC+EtQPSVCQZx6RLLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457205; c=relaxed/simple;
	bh=Ib6rRlgqmKYtC6TnTGgY8/vznC1/0zQVzuYMOueSGG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwvuIr1TC6aC8I5RSRZjRYbbYRzgpu0Sem6dTlg8ycmIjH/hM5+rp06/P7Pz0mONTGlzFBk/aUfxINe2krKa3Wvo2vjEAevCJ11mzbYShTTMlw2CrLKwU2kEq/MakHSb7IPXdXFjTW0uH40BZKaK6e54ifmcQIptKxSXIDSVsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9Ajc1vV; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714457202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/V685kde9L0ZctsmCACzkCSs3YoKScmeI639UOEVavY=;
	b=i9Ajc1vVEAxx3DPEALD4PHoTBLkXVrvxG8ZT0+gtHZi8WqtrmLvE1uboXg7LzmLXkBmgAe
	mkiSrRVvWlwUHmiKEHwyPJOySqzpYOfr9raHJAytZqjOw0fL57/fyFm58R4EVIawHdQKE1
	7rcnHurz3ckYjl7kQ8vgmKrnNFzRbXU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] memcg: warn for unexpected events and stats
Date: Mon, 29 Apr 2024 23:06:11 -0700
Message-ID: <20240430060612.2171650-8-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-1-shakeel.butt@linux.dev>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To reduce memory usage by the memcg events and stats, the kernel uses
indirection table and only allocate stats and events which are being
used by the memcg code. To make this more robust, let's add warnings
where unexpected stats and events indexes are used.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---

Changes since v2:
- Based on feedback from Johannes, switched to WARN_ONCE() from
  pr_warn_once().

 mm/memcontrol.c | 55 ++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index df94abc0088f..72e36977a96e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -664,17 +664,18 @@ struct lruvec_stats {
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
 {
 	struct mem_cgroup_per_node *pn;
-	long x = 0;
+	long x;
 	int i;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (i >= 0) {
-		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-		x = READ_ONCE(pn->lruvec_stats->state[i]);
-	}
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+		return 0;
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	x = READ_ONCE(pn->lruvec_stats->state[i]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -686,17 +687,18 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx)
 {
 	struct mem_cgroup_per_node *pn;
-	long x = 0;
+	long x;
 	int i;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (i >= 0) {
-		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-		x = READ_ONCE(pn->lruvec_stats->state_local[i]);
-	}
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
+		return 0;
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -921,7 +923,7 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state[i]);
@@ -958,7 +960,10 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
 	int i = memcg_stats_index(idx);
 
-	if (mem_cgroup_disabled() || i < 0)
+	if (mem_cgroup_disabled())
+		return;
+
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
@@ -971,7 +976,7 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state_local[i]);
@@ -990,7 +995,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -1104,34 +1109,38 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count)
 {
-	int index = memcg_events_index(idx);
+	int i = memcg_events_index(idx);
 
-	if (mem_cgroup_disabled() || index < 0)
+	if (mem_cgroup_disabled())
+		return;
+
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	memcg_stats_lock();
-	__this_cpu_add(memcg->vmstats_percpu->events[index], count);
+	__this_cpu_add(memcg->vmstats_percpu->events[i], count);
 	memcg_rstat_updated(memcg, count);
 	memcg_stats_unlock();
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
-	int index = memcg_events_index(event);
+	int i = memcg_events_index(event);
 
-	if (index < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, event))
 		return 0;
-	return READ_ONCE(memcg->vmstats->events[index]);
+
+	return READ_ONCE(memcg->vmstats->events[i]);
 }
 
 static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
-	int index = memcg_events_index(event);
+	int i = memcg_events_index(event);
 
-	if (index < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, event))
 		return 0;
 
-	return READ_ONCE(memcg->vmstats->events_local[index]);
+	return READ_ONCE(memcg->vmstats->events_local[i]);
 }
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
-- 
2.43.0


