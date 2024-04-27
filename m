Return-Path: <linux-kernel+bounces-160824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1525B8B434D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3893F1C22550
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25213D984;
	Sat, 27 Apr 2024 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="houO09vD"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C73C473
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178279; cv=none; b=tIAY0z4MiqoB44nPKgPko0CGAyFJuYhVC/W6bXMYxFthbRGwqVPTHH5GhVZtHwNhwMkHyUTtDLQM+60jb1d8vfmdbiAgLuhSiHWaXsEq7dYcNK8ekpfw8FSZbAW4SIxQY4XFb5oJqbzD+ly5q6PYIshUL2HPYVB+tKIKnumGfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178279; c=relaxed/simple;
	bh=BJaMUZqNYD+vFZj/LHcHOqshLcOBcpf1OX6HJEFXK+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giOMp4R8sf1yDgyAPOk4/F+gem9ZsnNUQmeu93XCdif34VCtOGWR3REYSBuhu0YR8E2+FVFj4aZqWmvhKiZ+pCHoSwtBWYdaBxphBkC4VV31EQBK9t8IkbOPsMiQkfG3soVM9kJrGP7e1S24dzIydJFansn9ZGboSc8jHFZ+5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=houO09vD; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLHD4gb8t6zDRcF8qzenGgWmsGCHlQSRICk2vCIqKfk=;
	b=houO09vDhohFagXTbOfhLSJqhpc84FITSFNLRlY6ylNtuLjFRkyPyDJyqpgi6EbQHK4FZn
	RhE2P7AnzkgfYA/sfqlnm1T5oG8du97LuVbDILIJXqYXe1+56MCMYjkGUrV8Oga2UzpQz5
	EeBGScH0Y4HpVoFLboUXkjNMFabeuPk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] memcg: pr_warn_once for unexpected events and stats
Date: Fri, 26 Apr 2024 17:37:31 -0700
Message-ID: <20240427003733.3898961-6-shakeel.butt@linux.dev>
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

To reduce memory usage by the memcg events and stats, the kernel uses
indirection table and only allocate stats and events which are being
used by the memcg code. To make this more robust, let's add warnings
where unexpected stats and events indexes are used.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 103e0e53e20a..36145089dcf5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -671,9 +671,11 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (i >= 0) {
+	if (likely(i >= 0)) {
 		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 		x = READ_ONCE(pn->lruvec_stats->state[i]);
+	} else {
+		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
 	}
 #ifdef CONFIG_SMP
 	if (x < 0)
@@ -693,9 +695,11 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-	if (i >= 0) {
+	if (likely(i >= 0)) {
 		pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 		x = READ_ONCE(pn->lruvec_stats->state_local[i]);
+	} else {
+		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
 	}
 #ifdef CONFIG_SMP
 	if (x < 0)
@@ -922,8 +926,10 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (unlikely(i < 0)) {
+		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
 		return 0;
+	}
 
 	x = READ_ONCE(memcg->vmstats->state[i]);
 #ifdef CONFIG_SMP
@@ -959,8 +965,13 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
 	int i = memcg_stats_index(idx);
 
-	if (mem_cgroup_disabled() || i < 0)
+	if (mem_cgroup_disabled())
+		return;
+
+	if (unlikely(i < 0)) {
+		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
 		return;
+	}
 
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
@@ -972,8 +983,10 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	long x;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (unlikely(i < 0)) {
+		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
 		return 0;
+	}
 
 	x = READ_ONCE(memcg->vmstats->state_local[i]);
 #ifdef CONFIG_SMP
@@ -991,8 +1004,10 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
 
-	if (i < 0)
+	if (unlikely(i < 0)) {
+		pr_warn_once("%s: stat item index: %d\n", __func__, idx);
 		return;
+	}
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
@@ -1107,8 +1122,13 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 {
 	int index = memcg_events_index(idx);
 
-	if (mem_cgroup_disabled() || index < 0)
+	if (mem_cgroup_disabled())
+		return;
+
+	if (unlikely(index < 0)) {
+		pr_warn_once("%s: event item index: %d\n", __func__, idx);
 		return;
+	}
 
 	memcg_stats_lock();
 	__this_cpu_add(memcg->vmstats_percpu->events[index], count);
@@ -1120,8 +1140,11 @@ static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
 	int index = memcg_events_index(event);
 
-	if (index < 0)
+	if (unlikely(index < 0)) {
+		pr_warn_once("%s: event item index: %d\n", __func__, event);
 		return 0;
+	}
+
 	return READ_ONCE(memcg->vmstats->events[index]);
 }
 
@@ -1129,8 +1152,10 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
 	int index = memcg_events_index(event);
 
-	if (index < 0)
+	if (unlikely(index < 0)) {
+		pr_warn_once("%s: event item index: %d\n", __func__, event);
 		return 0;
+	}
 
 	return READ_ONCE(memcg->vmstats->events_local[index]);
 }
-- 
2.43.0


