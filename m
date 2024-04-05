Return-Path: <linux-kernel+bounces-132450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0556899508
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4971C22198
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819A495CC;
	Fri,  5 Apr 2024 06:09:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41367481AC;
	Fri,  5 Apr 2024 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297354; cv=none; b=ZwuZrXAkCrvBQLFXEj4KDdwBF5A61wyV/Ls+aUqUSAyTyHepBUr2MROaU9uq7nr9Cj61tc6G4tBcqk6EnZldRyXfX2ecbgUKX4rsO94who1oQG/AUZHQ4PyXZzB8Pf0wfLOJY1NbEmR7+AyOEGw4QxxCY9rj89RQQIOW/DZ6Tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297354; c=relaxed/simple;
	bh=W3mt8mOCa+BsunCXjuZaMC2bD+wmxhYuB7tpSjWh41A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqMgFJngO8Evv1uOudM49W3avUqyVAF7UF7KYZkUvQMFL3LXZs8EaYz1bXmj4hj2BouRyPJ3K+aTKbDbcY8rlhxt5s4jxmypzTGShWfrJ+NnQY0h+I0bHayh70Pakai89+8EvChtgZ284Z9riEi1MHUq/ApBtrsOha+lVl3az6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-8f-660f9580d017
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
Subject: [RFC PATCH v3 2/7] mm: make alloc_demote_folio externally invokable for migration
Date: Fri,  5 Apr 2024 15:08:51 +0900
Message-ID: <20240405060858.2818-3-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXC9ZZnkW7DVP40g7N/TC0m9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXR+X8picXnXHDaLe2v+s1ocWX+WxWLz2TPMFouX
	q1ns63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95jdxD2WHr6DZvHhiYgsXPWXXaPln23
	2D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweOx9aerzYPJPRo7f5HZvH501yAXxR
	XDYpqTmZZalF+nYJXBmHjj9hKTgkWHHr/VzGBsbNfF2MHBwSAiYSE85KdjFygpl31zazgdhs
	AmoSV15OYgIpERFwkFj1VaGLkYuDWeA/s8Tl3l+sIDXCAlESS0+8BLNZBFQlFty7D9bLK2Am
	8e70O3aImZoSj7f/BLM5Bcwl5j3eAGYLAdV8OniMHaJeUOLkzCcsIDazgLxE89bZzCDLJASO
	sUv03PrOCDFIUuLgihssExj5ZyHpmYWkZwEj0ypGocy8stzEzBwTvYzKvMwKveT83E2MwKhb
	VvsnegfjpwvBhxgFOBiVeHg95vKlCbEmlhVX5h5ilOBgVhLh7XbgTRPiTUmsrEotyo8vKs1J
	LT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAWOatH6b/L89C8d/CqDVemTeuZH8+
	X/5rodYsN9EFLz8aP2P9dG2NeM3+Gw9UlRUvNYRLdK37oDmjOCw8Rj346zMztQ0NSTc2GFY3
	rWqOqVx95YSpS9aMAzIz7JZYvn3SuOnK6xcNrfv3bfm08e2e757Pvkaw9V0tdLlQbf7ggO0N
	LdH+Jg6lGCWW4oxEQy3mouJEAHAPeW+2AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXCNUNLT7dhKn+awclHGhYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLD4/e81s0fnkO6PF4bknWS06vy9lsbi8aw6bxb01
	/1ktjqw/y2Kx+ewZZovFy9UsDl17zmqxr+MBk8Xhr2+YLCZfWsBm8WLKGUaLk7Mms1jMPnqP
	3UHcY+npN2weG5qAxM5Zd9k9WvbdYvdYsKnUo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN4
	7Hxo6fFi80xGj97md2we3257eCx+8YHJ4/MmuQCBKC6blNSczLLUIn27BK6MQ8efsBQcEqy4
	9X4uYwPjZr4uRk4OCQETibtrm9lAbDYBNYkrLycxdTFycIgIOEis+qrQxcjFwSzwn1nicu8v
	VpAaYYEoiaUnXoLZLAKqEgvu3Qfr5RUwk3h3+h07xExNicfbf4LZnALmEvMebwCzhYBqPh08
	xg5RLyhxcuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZec
	n7uJERhry2r/TNzB+OWy+yFGAQ5GJR5ej7l8aUKsiWXFlbmHGCU4mJVEeLsdeNOEeFMSK6tS
	i/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGLdVHdhTwN9+yD3Jw63+
	JXvOuqMRXl+z9825+mHGKZ8WR529Mb90dG3cTi3O4ckKf3TTi/vew4yrTr3Vy024a479SPhf
	db/Q7PuhRReyTaTnxlZs65JO8bgv9NmodPkpmVpf37t926983XPrcXDdBIZD6Wn5jCF5ggfs
	znZ9+DS3LaY2M776jxJLcUaioRZzUXEiAFYH+5KxAgAA
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
index f309a010d50f..c96ff9bc82d0 100644
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
index 4255619a1a31..9e456cac03b4 100644
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


