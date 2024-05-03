Return-Path: <linux-kernel+bounces-168171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230B8BB4AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A633A1F24094
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7F158D74;
	Fri,  3 May 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWM/xn2u"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC4158DD4
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767544; cv=none; b=u40houpC2+0qpWL8udMoew9ajCBae3M3CPjUVwft97tiXKULbEyRX6Sv6PnA8dc9mkjmEC6b1rSUocqdGIe4U5I0NHpq0JSfj9arTDLYUVqrzfXAvJ8zqCagXu+lIJen31Xd5/k53JgHZPQU4QEWyvMaMZgZLXmW457mxTYXCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767544; c=relaxed/simple;
	bh=eI9xFq2kX5lBGKU8ubCZm2CGcfjJ/rSVsL00jiXJ4hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcWeeqJSa54RKuu1odVP2e2CezG0OHdweTC6gqYvN6mrlOBk2O78nSLA0ajN89MjJKbiicheUe2/2TSRp2jqH8ZtYJsCvFRohI1k85S8K9r/RQYlVyVbyJ/tieI16t7FAYTF34Bv95q6Qb7fZhiaVPPmqvrSU34zoGCRQb/S2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vWM/xn2u; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714767539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFkZrf+dM1tVK36JDqPspeMNDuJI8Dzfelt+0AW+5E8=;
	b=vWM/xn2uztR0kVJVznl+MWnB716gH9m2QmOJP+reJrlv493o2yq4sat0Wt99PyRdOFyd54
	EDXeiCaElTjH/PNYs+RPQzEtBIURfEF96X9qJrtLZkFpKN9jIG29Ih5KsOrL+vvN0tGggt
	VpCpmFyzajJGi+C460U/iMjLPuHeTYQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Frank van der Linden <fvdl@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 3/4] mm: memcg: don't call propagate_protected_usage() needlessly
Date: Fri,  3 May 2024 13:18:34 -0700
Message-ID: <20240503201835.2969707-4-roman.gushchin@linux.dev>
In-Reply-To: <20240503201835.2969707-1-roman.gushchin@linux.dev>
References: <20240503201835.2969707-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memory protection (min/low) requires a constant tracking of
the usage of protected memory. propagate_protected_usage() is called
each time and does a number of operations even in cases when
the actual memory protection functionality is not supported
(e.g. hugetlb cgroups or memcg swap counters). It's an obvious
inefficiency, which can be addressed by calling
propagate_protected_usage() optionally and only for the right
counter type. It eliminates a number of operations from hot paths.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/page_counter.h |  8 +++++++-
 mm/hugetlb_cgroup.c          |  2 +-
 mm/memcontrol.c              |  4 ++--
 mm/page_counter.c            | 15 ++++++++++++---
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index ae6cc080b78b..5d963f54fcb8 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -62,6 +62,7 @@ struct page_counter {
 	/* Keep all the read most fields in a separete cacheline. */
 	CACHELINE_PADDING(_pad2_);
 
+	bool protection_support;
 	unsigned long min;
 	unsigned long low;
 	unsigned long high[__MCT_NR_ITEMS];
@@ -75,8 +76,12 @@ struct page_counter {
 #define PAGE_COUNTER_MAX (LONG_MAX / PAGE_SIZE)
 #endif
 
+/*
+ * Protection is supported only for the first counter (with id 0).
+ */
 static inline void page_counter_init(struct page_counter *counter,
-				     struct page_counter *parent)
+				     struct page_counter *parent,
+				     bool protection_support)
 {
 	int i;
 
@@ -86,6 +91,7 @@ static inline void page_counter_init(struct page_counter *counter,
 	}
 
 	counter->parent = parent;
+	counter->protection_support = protection_support;
 }
 
 static inline unsigned long page_counter_read(struct page_counter *counter,
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 069c7f164dc5..81cb78d0714f 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -79,7 +79,7 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 	int idx;
 
 	page_counter_init(&h_cgroup->res,
-			  parent_h_cgroup ? &parent_h_cgroup->res : NULL);
+			  parent_h_cgroup ? &parent_h_cgroup->res : NULL, false);
 
 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
 		unsigned long limit;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f4511506ef1f..46becae5ff99 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5761,11 +5761,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
-		page_counter_init(&memcg->memory, &parent->memory);
+		page_counter_init(&memcg->memory, &parent->memory, true);
 	} else {
 		init_memcg_stats();
 		init_memcg_events();
-		page_counter_init(&memcg->memory, NULL);
+		page_counter_init(&memcg->memory, NULL, true);
 		root_mem_cgroup = memcg;
 		return &memcg->css;
 	}
diff --git a/mm/page_counter.c b/mm/page_counter.c
index b6ca3adbc226..5a27e3141ff3 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -60,7 +60,8 @@ void page_counter_cancel(struct page_counter *counter,
 		new = 0;
 		atomic_long_set(&counter->usage[id], new);
 	}
-	propagate_protected_usage(counter, new);
+	if (counter->protection_support && id == 0)
+		propagate_protected_usage(counter, new);
 }
 
 /**
@@ -76,12 +77,14 @@ void page_counter_charge(struct page_counter *counter,
 			 unsigned long nr_pages)
 {
 	struct page_counter *c;
+	bool track_protection = counter->protection_support && (id == 0);
 
 	for (c = counter; c; c = c->parent) {
 		long new;
 
 		new = atomic_long_add_return(nr_pages, &c->usage[id]);
-		propagate_protected_usage(c, new);
+		if (track_protection)
+			propagate_protected_usage(c, new);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -107,6 +110,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     struct page_counter **fail)
 {
 	struct page_counter *c;
+	bool track_protection = counter->protection_support && (id == 0);
 
 	for (c = counter; c; c = c->parent) {
 		long new;
@@ -136,7 +140,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 			*fail = c;
 			goto failed;
 		}
-		propagate_protected_usage(c, new);
+		if (track_protection)
+			propagate_protected_usage(c, new);
 		/*
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
@@ -226,6 +231,8 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
 
+	WARN_ON_ONCE(!counter->protection_support);
+
 	WRITE_ONCE(counter->min, nr_pages);
 
 	for (c = counter; c; c = c->parent)
@@ -243,6 +250,8 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
 
+	WARN_ON_ONCE(!counter->protection_support);
+
 	WRITE_ONCE(counter->low, nr_pages);
 
 	for (c = counter; c; c = c->parent)
-- 
2.43.2


