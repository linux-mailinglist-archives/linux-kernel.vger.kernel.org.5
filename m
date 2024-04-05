Return-Path: <linux-kernel+bounces-132459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA75899518
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D76B2698F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302F8061F;
	Fri,  5 Apr 2024 06:09:22 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EA55E45;
	Fri,  5 Apr 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297361; cv=none; b=bW4ALew6qoGarNrnYRaSULrcIEQPi9418XnVi3Ykd9ewHbXYOGQTmG/Alnz7LoXkDh3B9+GgqZU0qHQwBfxPD6eBCf59kDyMmYx57h5jXbZRsz6sgAVvxr/Hh9zFN/FEnOybEOPFu+a0QwAsVXrAWdAo+QyHoJU+S5Gkz37XW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297361; c=relaxed/simple;
	bh=1NLtaDXpkC9ZSmLCYjLXJroBuC67b3ZA9SER/MNivlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtMHxl35Nv0ftP2zq6yCh7FpugMCrewzdNky1YK9DuTKUdG1VmnY0m6xdswRXCObt67isl8qhi8sof654g/pl1Vju8KRkQp9tpdjFM9z+921K1A/HJn4WNjCgcwQc2+2PW+jtdMjrEAd0o/96L/2RCH/hNeMMVGhqNHpfUpeis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ce-660f958600fc
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: [RFC PATCH v3 6/7] mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion
Date: Fri,  5 Apr 2024 15:08:55 +0900
Message-ID: <20240405060858.2818-7-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240405060858.2818-1-honggyu.kim@sk.com>
References: <20240405060858.2818-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXC9ZZnkW7bVP40g9Mt8hYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLDq/L2WxuLxrDpvFvTX/WS2OrD/LYrH57Blmi8XL
	1Sz2dTxgsjj89Q2TxeRLC9gsXkw5w2hxctZkFovZR++xOwh7LD39hs1jQxOQ2DnrLrtHy75b
	7B4LNpV6tBx5y+qxeM9LJo9NqzrZPDZ9msTucWLGbxaPnQ8tPV5snsno0dv8js3j8ya5AL4o
	LpuU1JzMstQifbsEroyNM8+xFLxTqph67Cd7A+M0mS5GDg4JAROJ26v9uxg5wcyli64ygdhs
	AmoSV15OYgIpERFwkFj1VaGLkYuDWeA/s8Tl3l+sIDXCAjESH2aeB7NZBFQlfjxbzAJi8wqY
	SRw9PpMJYqamxOPtP9lBbE4Bc4l5jzeA2UJANZ8OHmOHqBeUODnzCVgvs4C8RPPW2cwgyyQE
	jrFLrOjdyAYxSFLi4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMCo
	W1b7J3oH46cLwYcYBTgYlXh4PebypQmxJpYVV+YeYpTgYFYS4e124E0T4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwLjet/qB7OnPBmzmEtdW13gl7fzQ
	fE8npWbXjF1p/bUfO7U8bPxSv3r8iWBgl+bfYtiRfthSR/BMzsLy9y9ZH/1oEVYM8bqpde9h
	oNTii+dV0nu2hpq9ivT4c/XS+lVx92TvmdWafWDdyfD727TJrsks92M9GZdaPOrXedf19mK4
	HN+XfdPcdiixFGckGmoxFxUnAgAvypFstgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXCNUNLT7dtKn+aQd9CQYuJPQYWc9avYbPY
	dSPE4v6D1+wW//ceY7R48v83q8WJm41sFp+fvWa26HzyndHi8NyTrBad35eyWFzeNYfN4t6a
	/6wWR9afZbHYfPYMs8Xi5WoWh649Z7XY1/GAyeLw1zdMFpMvLWCzeDHlDKPFyVmTWSxmH73H
	7iDusfT0GzaPDU1AYuesu+weLftusXss2FTq0XLkLavH4j0vmTw2repk89j0aRK7x4kZv1k8
	dj609HixeSajR2/zOzaPb7c9PBa/+MDk8XmTXIBAFJdNSmpOZllqkb5dAlfGxpnnWAreKVVM
	PfaTvYFxmkwXIyeHhICJxNJFV5lAbDYBNYkrLycB2RwcIgIOEqu+KnQxcnEwC/xnlrjc+4sV
	pEZYIEbiw8zzYDaLgKrEj2eLWUBsXgEziaPHZzJBzNSUeLz9JzuIzSlgLjHv8QYwWwio5tPB
	Y+wQ9YISJ2c+AetlFpCXaN46m3kCI88sJKlZSFILGJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn
	525iBMbasto/E3cwfrnsfohRgINRiYfXYy5fmhBrYllxZe4hRgkOZiUR3m4H3jQh3pTEyqrU
	ovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRuM05lmL5/4X2KG0/vU9
	/zehc5peCP9NUohbvKtUgNlj+xYrg3mJyjNlDPVsbDze1gVFuy9207+Yd0de6BmDIcvz6dHL
	pn0z3h4ancnct2bJ9yUThRcd4D/i1Zx6TfbDwZpFWjP93HiLEzvVvT6U7Hyy47v/5k15i3uX
	thu2Mz8M2RlzI8XjoRJLcUaioRZzUXEiAIKQFJOxAgAA
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch introduces DAMOS_MIGRATE_HOT action, which is similar to
DAMOS_MIGRATE_COLD, but it is targeted to migrate hot pages.

It migrates pages inside the given region to the 'target_nid' NUMA node
in the sysfs.

Here is one of the example usage of this 'migrate_hot' action.

  $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
  $ cat contexts/<N>/schemes/<N>/action
  migrate_hot
  $ echo 0 > contexts/<N>/schemes/<N>/target_nid
  $ echo commit > state
  $ numactl -p 2 ./hot_cold 500M 600M &
  $ numastat -c -p hot_cold

  Per-node process memory usage (in MBs)
  PID             Node 0 Node 1 Node 2 Total
  --------------  ------ ------ ------ -----
  701 (hot_cold)     501      0    601  1101

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/damon.h    |  2 ++
 mm/damon/paddr.c         | 12 ++++++++++--
 mm/damon/sysfs-schemes.c |  4 +++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index df8671e69a70..934c95a7c042 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -105,6 +105,7 @@ struct damon_target {
  * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
  * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
  * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
+ * @DAMOS_MIGRATE_HOT:  Migrate for the given hot region.
  * @DAMOS_MIGRATE_COLD: Migrate for the given cold region.
  * @DAMOS_STAT:		Do nothing but count the stat.
  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
@@ -123,6 +124,7 @@ enum damos_action {
 	DAMOS_NOHUGEPAGE,
 	DAMOS_LRU_PRIO,
 	DAMOS_LRU_DEPRIO,
+	DAMOS_MIGRATE_HOT,
 	DAMOS_MIGRATE_COLD,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fe217a26f788..fd9d35b5cc83 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -229,6 +229,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 
 enum migration_mode {
 	MIG_PAGEOUT,
+	MIG_MIGRATE_HOT,
 	MIG_MIGRATE_COLD,
 };
 
@@ -375,8 +376,10 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
 
-		folio_clear_referenced(folio);
-		folio_test_clear_young(folio);
+		if (mm != MIG_MIGRATE_HOT) {
+			folio_clear_referenced(folio);
+			folio_test_clear_young(folio);
+		}
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
 		/*
@@ -394,6 +397,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	case MIG_PAGEOUT:
 		applied = reclaim_pages(&folio_list);
 		break;
+	case MIG_MIGRATE_HOT:
 	case MIG_MIGRATE_COLD:
 		applied = damon_pa_migrate_pages(&folio_list, mm,
 						 s->target_nid);
@@ -454,6 +458,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r, scheme);
+	case DAMOS_MIGRATE_HOT:
+		return damon_pa_migrate(r, scheme, MIG_MIGRATE_HOT);
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, scheme, MIG_MIGRATE_COLD);
 	case DAMOS_STAT:
@@ -476,6 +482,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_hot_score(context, r, scheme);
 	case DAMOS_LRU_DEPRIO:
 		return damon_cold_score(context, r, scheme);
+	case DAMOS_MIGRATE_HOT:
+		return damon_hot_score(context, r, scheme);
 	case DAMOS_MIGRATE_COLD:
 		return damon_cold_score(context, r, scheme);
 	default:
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 18b7d054c748..1d2f62aa79ca 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1406,6 +1406,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 	"nohugepage",
 	"lru_prio",
 	"lru_deprio",
+	"migrate_hot",
 	"migrate_cold",
 	"stat",
 };
@@ -1660,7 +1661,8 @@ static ssize_t target_nid_store(struct kobject *kobj,
 			struct damon_sysfs_scheme, kobj);
 	int err = 0;
 
-        if (scheme->action != DAMOS_MIGRATE_COLD)
+        if (scheme->action != DAMOS_MIGRATE_HOT &&
+            scheme->action != DAMOS_MIGRATE_COLD)
                 return -EINVAL;
 
 	/* TODO: error handling for target_nid range. */
-- 
2.34.1


