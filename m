Return-Path: <linux-kernel+bounces-81582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD48677D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8331F2BE36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03112C815;
	Mon, 26 Feb 2024 14:06:23 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4412BF3C;
	Mon, 26 Feb 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956383; cv=none; b=HHXiI0j3QpZImVnrrAvN1e9OBNOgJsPWW8hz6N1WzbEPg5zwa1y6INO9yLb1iYxVznwzr2nCxKeWeq/2YQ23NYfhrlTMZRVdvRbWUTV41Ds8MRXIU52b7UlaHUF3LHGQJQ/s0sBE9nvTh4RP3DdK72nh7FkxyjPAMj8ZakAOhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956383; c=relaxed/simple;
	bh=C468lHYjYAI9vBRck8tz19UeLn3N7jq8un3nPfdUOcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9b+rOJlfvJtfKp0RIYUtmgyeS0HHWwiOcvltFCtIDlEdle9wcbHTXOm4TX8txbgL5/hFMiwhL7O6122PA5YetrC0TRAYN3+xnqWrsacwTNBPuU8jsaCD6xRVPbbWhgns4wo84/cyJMjW4LGYrqMibCq69JHazaYDcqmwOP/jh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-65-65dc9ad7da0c
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
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: [PATCH v2 2/7] mm: make alloc_demote_folio externally invokable for migration
Date: Mon, 26 Feb 2024 23:05:48 +0900
Message-ID: <20240226140555.1615-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226140555.1615-1-honggyu.kim@sk.com>
References: <20240226140555.1615-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsXC9ZZnoe71WXdSDU4sELaY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx7haQtfnsGWaLxcvV
	LPZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7CHv8PziJ2WPp6TdsHhuagMTOWXfZ
	PVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e5ndsHp83
	yQXwR3HZpKTmZJalFunbJXBlbHjym73gkGDFtMmn2RsYN/N1MXJySAiYSByY2cnexcgBZl+f
	JwkSZhNQk7jychITSFhEwEFi1VeFLkYuDmaBBhaJH58vsYDUCAuESdxasBPMZhFQldix4ymY
	zStgJrF19jZWiPGaEo+3/2QHsTkFzCX+H25nA5kpBFRz9DYzRLmgxMmZT8BamQXkJZq3zmYG
	2SUhcIpd4mPLUyaIOZISB1fcYJnAyD8LSc8sJD0LGJlWMQpl5pXlJmbmmOhlVOZlVugl5+du
	YgRG37LaP9E7GD9dCD7EKMDBqMTD61B7J1WINbGsuDL3EKMEB7OSCG+4zM1UId6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYwKC0Iq+iRk+wtOMx6fcP/m
	4uKgw+oTP809kbxG4lzdzPaa+Z/lGrYcblm3/HBZ/dRHKVx/8r7tlPv5+yDXAkaGO+s2uXu7
	7E1r3zVP6se5c6cVjD2inrp94nrs81HnV0+kW95hG8l3GVY6lhfdF4ao5NYo9RcaZB9vm7p9
	RYu/UdcW1ZCPf94rsRRnJBpqMRcVJwIABBv4HboCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCNUNLT/f6rDupBgfPMltM7DGwmLN+DZvF
	rhshFv/3HmO0ePL/N6vFiZuNbBafn71mtuh88p3R4vDck6wWnd+Xslhc3jWHzeLemv+sFkfW
	n2WxWHcLyNp89gyzxeLlahaHrj1ntdjX8YDJ4vDXN0wWky8tYLN4MeUMo8XJWZNZLGYfvcfu
	IO7x/+AkZo+lp9+weWxoAhI7Z91l92jZd4vdY8GmUo+WI29ZPRbvecnksWlVJ5vHpk+T2D1O
	zPjN4rHzoaXHi80zGT16m9+xeXy77eGx+MUHpgDBKC6blNSczLLUIn27BK6MDU9+sxccEqyY
	Nvk0ewPjZr4uRg4OCQETievzJLsYOTnYBNQkrrycxAQSFhFwkFj1VaGLkYuDWaCBReLH50ss
	IDXCAmEStxbsBLNZBFQldux4CmbzCphJbJ29jRXElhDQlHi8/Sc7iM0pYC7x/3A7G8hMIaCa
	o7eZIcoFJU7OfALWyiwgL9G8dTbzBEaeWUhSs5CkFjAyrWIUycwry03MzDHVK87OqMzLrNBL
	zs/dxAiMtGW1fybuYPxy2f0QowAHoxIPr0PtnVQh1sSy4srcQ4wSHMxKIrzhMjdThXhTEiur
	Uovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjZNkyuCLp5K9RnIVvv
	BK/jzJd2fv5YuFJ0kqB47etlR0SNBHy9s7PU5Z+dnLlbueDFzfiM1A/Mc9tWv88t3V9o0+/j
	FhMptMBwh0blCYtZ65uz/z2Kaj2276LO18eTpxTeaWu8y78lz9Tn4b8TDNJ/9yxo+HR+S7zC
	pudtX1USPNaWlTpyTvuuxFKckWioxVxUnAgAPK1J3bACAAA=
X-CFilter-Loop: Reflected

The alloc_demote_folio can be used out of vmscan.c so it'd be better to
remove static keyword from it.

This function can also be used for both demotion and promotion so it'd
be better to rename it from alloc_demote_folio to alloc_migrate_folio.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/internal.h |  1 +
 mm/vmscan.c   | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..61af6641235d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -866,6 +866,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
+struct folio *alloc_migrate_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..b8a1a1599e3c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -910,8 +910,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-static struct folio *alloc_demote_folio(struct folio *src,
-		unsigned long private)
+struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
@@ -935,6 +934,11 @@ static struct folio *alloc_demote_folio(struct folio *src,
 	if (dst)
 		return dst;
 
+	/*
+	 * Allocation failed from the target node so try to allocate from
+	 * fallback nodes based on allowed_mask.
+	 * See fallback_alloc() at mm/slab.c.
+	 */
 	mtc->gfp_mask &= ~__GFP_THISNODE;
 	mtc->nmask = allowed_mask;
 
@@ -973,7 +977,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	node_get_allowed_targets(pgdat, &allowed_mask);
 
 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_folios, alloc_demote_folio, NULL,
+	migrate_pages(demote_folios, alloc_migrate_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-- 
2.34.1


