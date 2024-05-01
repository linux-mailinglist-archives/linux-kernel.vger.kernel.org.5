Return-Path: <linux-kernel+bounces-165649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87F8B8F08
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69082282EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0021CAA1;
	Wed,  1 May 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="trfIiJqg"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DA130A48
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584411; cv=none; b=n5J1OKT2YZCXHqf51TsFWlAGMS3exrg8YXRb8BRH/bYOTbnNjDCutyXFKW4d8cjnrQCr6Xiy0PkxD93AMFy4YWTYr7EbMY3M11Sx4rUwLdYp7pKojlqW22bXpo8/N6myehTf0Ryss9cX6v90fYgEhUX3Bcm3CM5iG+SiidCnxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584411; c=relaxed/simple;
	bh=8cFU4L9onx/D15Kw9WsRrYrXqLb8O5GWIxTJCH23XfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvXhr0YADzF9wpXcUNqSlwbs7/AfFJ3PNcgfOQSge2flM6nMRyvh2FbCMyjbpznXe4+4KBL4O4jW+CGJi5MjVd1q/izp1RFt3xJM+5koshjQg09Tn3Mbd7/7snTT4d71aEA7nc4yoFLRcSCc8kAHTarYhFJojVq19MqtrrfNahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=trfIiJqg; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714584408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSfZvMT0meM6+Tg2n6OjVJNbS0vHa+pAGl0pke03oZo=;
	b=trfIiJqgV4cZZHqhDCNO3VkVT22d/YhoirgzSeIxHk0Kyp4BRRYVdbzVdcRQUlf99KJVIB
	+sqEruaqw97BM6RkWEWKQYlkT3DaUVJvFUGmcuMT4MflewgGqt6Zg8xgqKU5yk0B6aoJF4
	tPo0pBwMJJ1keoewuqZXlJvbt60TGN0=
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
Subject: [PATCH v4 7/8] memcg: warn for unexpected events and stats
Date: Wed,  1 May 2024 10:26:16 -0700
Message-ID: <20240501172617.678560-8-shakeel.butt@linux.dev>
In-Reply-To: <20240501172617.678560-1-shakeel.butt@linux.dev>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
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
Changes since v3:
- N/A

 mm/memcontrol.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a78cf00dd537..b4a1b4bb599d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -671,7 +671,7 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -687,14 +687,14 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx)
 {
 	struct mem_cgroup_per_node *pn;
-	long x = 0;
+	long x;
 	int i;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -923,7 +923,7 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state[i]);
@@ -960,7 +960,10 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
 	int i = memcg_stats_index(idx);
 
-	if (mem_cgroup_disabled() || i < 0)
+	if (mem_cgroup_disabled())
+		return;
+
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
@@ -973,7 +976,7 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
 	x = READ_ONCE(memcg->vmstats->state_local[i]);
@@ -992,7 +995,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (WARN_ONCE(i < 0, "%s: missing stat item %d\n", __func__, idx))
 		return;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
@@ -1106,34 +1109,38 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
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


