Return-Path: <linux-kernel+bounces-132460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0420899517
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2805B1C215A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32326823A2;
	Fri,  5 Apr 2024 06:09:22 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61F55E49;
	Fri,  5 Apr 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297361; cv=none; b=nUOIhIlI7F4Vo70HwqvxnoZKkUVUhKIvSeCX6ZkZf92ly0CYzvoosatDwd39mI+UonUJ+efCTihEMl+6Qu/RsELIP9FnE09fRSfZU/Y02wpTlgnHBE/DxTa3N1PVDDk+RzstMcVfbq+dskozlADvXHTDqLEgpeRTNWjmbJfvjdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297361; c=relaxed/simple;
	bh=XUA4CVfhy0+KcI2uVKXxc554ESRbQuU/raIL43nW8B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLlJr/wV51B9yO753qW7Sa17kJ53kxxXSMNXjB9WxsqMX7ieIr8n2tGEAwUqfCeLfU/6QimkvT4/Tc+CEVWl6ilGwVergJZn4ECpS/zQkmUKRX3Y7xHScKcaryTBGQ3JGpN8Lxq6KNxxQ4bbUixBOeEAJWof4ivM7DB6Bz4wkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-e9-660f9587c0c4
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
Subject: [RFC PATCH v3 7/7] mm/damon: Add "damon_migrate_{hot,cold}" vmstat
Date: Fri,  5 Apr 2024 15:08:56 +0900
Message-ID: <20240405060858.2818-8-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXC9ZZnkW77VP40g/v3jS0m9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXR+X8picXnXHDaLe2v+s1ocWX+WxWLz2TPMFouX
	q1ns63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95jdxD2WHr6DZvHhiYgsXPWXXaPln23
	2D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweOx9aerzYPJPRo7f5HZvH501yAXxR
	XDYpqTmZZalF+nYJXBknXi5iL+gWqzi65j5TA+NXwS5GTg4JAROJG51nGGHsbfvbmEFsNgE1
	iSsvJzF1MXJwiAg4SKz6qtDFyMXBLPCfWeJy7y9WkBphAW+J6xuOMoLUsAioSnxbbwsS5hUw
	k1iz7wU7xEhNicfbf4LZnALmEvMebwCzhYBqPh08xg5RLyhxcuYTFhCbWUBeonnrbGaQXRIC
	p9glfm1+BnWbpMTBFTdYJjDyz0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgVG3
	rPZP9A7GTxeCDzEKcDAq8fB6zOVLE2JNLCuuzD3EKMHBrCTC2+3AmybEm5JYWZValB9fVJqT
	WnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBsVOshzOZ2dzpVu0tg5VW/auevHjv
	lv74yKOknQeNZLdk2M0SyAxVPnR3b9MiiUMsG4+4qt5cNJt1O1MnY3bv3MNZT/v/X7zGd6t0
	xa0yodMLvFNXz3zEe+r2/wB55ddRLDfYdkTkzmyN+znPQa9/4aV4vwcd9SWtFyQPL21K48ru
	+aJ+/KVqhxJLcUaioRZzUXEiAKaMzZm2AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCNUNLT7d9Kn+awe31qhYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLD4/e81s0fnkO6PF4bknWS06vy9lsbi8aw6bxb01
	/1ktjqw/y2Kx+ewZZovFy9UsDl17zmqxr+MBk8Xhr2+YLCZfWsBm8WLKGUaLk7Mms1jMPnqP
	3UHcY+npN2weG5qAxM5Zd9k9WvbdYvdYsKnUo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN4
	7Hxo6fFi80xGj97md2we3257eCx+8YHJ4/MmuQCBKC6blNSczLLUIn27BK6MEy8XsRd0i1Uc
	XXOfqYHxq2AXIyeHhICJxLb9bcwgNpuAmsSVl5OYuhg5OEQEHCRWfVXoYuTiYBb4zyxxufcX
	K0iNsIC3xPUNRxlBalgEVCW+rbcFCfMKmEms2feCHWKkpsTj7T/BbE4Bc4l5jzeA2UJANZ8O
	HmOHqBeUODnzCQuIzSwgL9G8dTbzBEaeWUhSs5CkFjAyrWIUycwry03MzDHVK87OqMzLrNBL
	zs/dxAiMtGW1fybuYPxy2f0QowAHoxIPr8dcvjQh1sSy4srcQ4wSHMxKIrzdDrxpQrwpiZVV
	qUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYxVlz35HuTVFB8uXW0c
	wjiDP7l55bRvM1lzQlf5/pHbt+Ju/QXuj0VPxP96evh9mLw/5d0spTs+1asmvjH9eumt7E03
	nak8E/sSe2Orte2YEwusOjnfNhlmTrYItvHXaPi0q+z9eh2mhy+EVF0U9eLb9Ez0tl0rMM9/
	PfOVi+dvH9Fbn01mGymxFGckGmoxFxUnAgDlDExNsAIAAA==
X-CFilter-Loop: Reflected

This patch adds "damon_migrate_{hot,cold}" under node specific vmstat
counters at the following location.

  /sys/devices/system/node/node*/vmstat

The counted values are accumulcated to the global vmstat so it also
introduces the same counter at /proc/vmstat as well.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/mmzone.h |  4 ++++
 mm/damon/paddr.c       | 17 ++++++++++++++++-
 mm/vmstat.c            |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a497f189d988..0005372c5503 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -214,6 +214,10 @@ enum node_stat_item {
 	PGDEMOTE_KSWAPD,
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
+#ifdef CONFIG_DAMON_PADDR
+	DAMON_MIGRATE_HOT,
+	DAMON_MIGRATE_COLD,
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fd9d35b5cc83..d559c242d151 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -235,10 +235,23 @@ enum migration_mode {
 
 static unsigned int migrate_folio_list(struct list_head *migrate_folios,
 				       struct pglist_data *pgdat,
+				       enum migration_mode mm,
 				       int target_nid)
 {
 	unsigned int nr_succeeded;
 	nodemask_t allowed_mask = NODE_MASK_NONE;
+	enum node_stat_item node_stat;
+
+	switch (mm) {
+	case MIG_MIGRATE_HOT:
+		node_stat = DAMON_MIGRATE_HOT;
+		break;
+	case MIG_MIGRATE_COLD:
+		node_stat = DAMON_MIGRATE_COLD;
+		break;
+	default:
+		return 0;
+	}
 
 	struct migration_target_control mtc = {
 		/*
@@ -263,6 +276,8 @@ static unsigned int migrate_folio_list(struct list_head *migrate_folios,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
 		      &nr_succeeded);
 
+	mod_node_page_state(pgdat, node_stat, nr_succeeded);
+
 	return nr_succeeded;
 }
 
@@ -302,7 +317,7 @@ static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */
 
 	/* Migrate folios selected for migration */
-	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, target_nid);
+	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, mm, target_nid);
 	/* Folios that could not be migrated are still in @migrate_folios */
 	if (!list_empty(&migrate_folios)) {
 		/* Folios which weren't migrated go back on @folio_list */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index db79935e4a54..be9ba89fede1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1252,6 +1252,10 @@ const char * const vmstat_text[] = {
 	"pgdemote_kswapd",
 	"pgdemote_direct",
 	"pgdemote_khugepaged",
+#ifdef CONFIG_DAMON_PADDR
+	"damon_migrate_hot",
+	"damon_migrate_cold",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.34.1


