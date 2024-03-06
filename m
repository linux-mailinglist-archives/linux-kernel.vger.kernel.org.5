Return-Path: <linux-kernel+bounces-93320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC457872DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3228B1F22674
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7E1C696;
	Wed,  6 Mar 2024 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Z7qztWbb"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A81C287
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698595; cv=none; b=f2Jt0niHTx1RLItuostzO2/b2MoDvtK34EoqxEs+GJ5CJR0UD8AdVpiyABArqMWLGOtnmnREOJw6/er5R8OpLTv1kkgsXtjCj8KOkbmqsJxWCb8S2TI+aqq1uf9KWjNLZdKAsQIHkakGjlTMT0MRKa8rQf1XZL+AU0Q/q81fyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698595; c=relaxed/simple;
	bh=e6YdF+uo8QOiGW71azSWYV45mVoP1WOMRJ0W3MkhvWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkm755/UXZ3rsfCawCApe5ErJ+rU4X0yOhupT5qE4Zv+d+Kh+W2x65g1y+YlibEvd1jFCRzD4vX3o2+J0HShSjkJkhaZcLJN33y/zkp/EuRCd03Cpvssp8KqyD23GkOewUUqP7Y0VjZqzry0nV2qEZ3daFy8ODc1SiJGrDCcFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Z7qztWbb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6900f479e3cso13728006d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698592; x=1710303392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/ZzL/TH/R4lBA3ZDd+dHH0WpYTGgWIE5ifE2nwqWl8=;
        b=Z7qztWbb9VYRRchmyVsC0/7xKPbcgEcpHu3DcypSMDG4Xla3qYEKenFc2AIjg73zjh
         rs7cfdIHdG7I3orYyv9upY/KNyAP8VCJN1mLlZWdnyaDi3DLcimiQNfpfgDafftCVRjt
         8ET58MT9Tnh5YyfNFeGVvjySLeCx5Vlh2XuA5I94UQK/Ymk3XIJNR10g1HlhKfJKhlrN
         3pCXUoUZfIlhUGYVqgVJEdwGuD1AnzsKgkjtaUrOHfYVoP7nmjWL/j6Xd6ZS8axz7Ztd
         Rm0l2wl+Q/O2Vo2xAdY5EjiCRj3Pdc3Y+XEVrCwxBcJs99vlkwjAgY0VoCj9sisN4/m+
         IP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698592; x=1710303392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/ZzL/TH/R4lBA3ZDd+dHH0WpYTGgWIE5ifE2nwqWl8=;
        b=fnLJ5ZH3kOllJONwZJEcamKHrEp+qAKMag4LPGBaB0jbf6ygsPgIvtntCCFdwoMBA5
         4UT0FgULw6j8wvq5HCiE2bj0MxVCK9lilbLJligvwoxMU8BuECYgHa5/PS7UIkA6LLPb
         zxwM1D+Qu5Zv48qTBHNPDZ/p65kaBKiaZ5hLfXZcEAZk4ogantPN53vLO0Dq5K0Teklj
         rmtJ1qmS+PdAhpknz/89ShGLHR33/uy+b9S/6FC3iYrkgOkv3kl98a0CVmS4OIkYzXLU
         CLNEMv8MTGqOpDXSAv9TEUs2RVwjNnx/zTAe1p/6veAFq6rory169fcBCVFys7dZGzze
         iYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVYyf+eOvJQnzu3kni6P/iwxP7+/CAecdKhaAoL99FrBSh4grXw+e+Qs7zA5nBX3DfpsgazVXgnuxKm4i0LVSudPTfMT4xBN79eTBly
X-Gm-Message-State: AOJu0YxuZe9xfJPHXjpdZvJxGHrSx+oFgyD03B4GYxSvcW7+41qeYId7
	Byq3JrMLGjPyWdu3MeVuR7k7ll5vWwUIphdsSh3/lZIS7VHO/h5j4S+FrysvBBj1Rpc897Xb7U6
	N
X-Google-Smtp-Source: AGHT+IEhLmA5Z/jbA3zn2+GD6DrmyUDwK6kcHB1ddo4FwuhIkm61lmFRuGfA57LnzXsN6BEZH/RY/w==
X-Received: by 2002:ad4:4d06:0:b0:690:6ce7:432e with SMTP id l6-20020ad44d06000000b006906ce7432emr4033712qvl.9.1709698591864;
        Tue, 05 Mar 2024 20:16:31 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id pd6-20020a056214490600b006907801a000sm2714835qvb.26.2024.03.05.20.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:31 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] mm: page_alloc: set migratetype inside move_freepages()
Date: Tue,  5 Mar 2024 23:08:39 -0500
Message-ID: <20240306041526.892167-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306041526.892167-1-hannes@cmpxchg.org>
References: <20240306041526.892167-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

This avoids changing migratetype after move_freepages() or
move_freepages_block(), which is error prone. It also prepares for
upcoming changes to fix move_freepages() not moving free pages
partially in the range.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c     | 27 +++++++++++++--------------
 mm/page_isolation.c |  7 +++----
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 82e6c4068647..a057b82c4f1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1581,9 +1581,8 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 #endif
 
 /*
- * Move the free pages in a range to the freelist tail of the requested type.
- * Note that start_page and end_pages are not aligned on a pageblock
- * boundary. If alignment is required, use move_freepages_block()
+ * Change the type of a block and move all its free pages to that
+ * type's freelist.
  */
 static int move_freepages(struct zone *zone, unsigned long start_pfn,
 			  unsigned long end_pfn, int migratetype)
@@ -1593,6 +1592,9 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
 	unsigned int order;
 	int pages_moved = 0;
 
+	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
+	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 != end_pfn);
+
 	for (pfn = start_pfn; pfn <= end_pfn;) {
 		page = pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
@@ -1610,6 +1612,8 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
 		pages_moved += 1 << order;
 	}
 
+	set_pageblock_migratetype(pfn_to_page(start_pfn), migratetype);
+
 	return pages_moved;
 }
 
@@ -1837,7 +1841,6 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled) {
 		move_freepages(zone, start_pfn, end_pfn, start_type);
-		set_pageblock_migratetype(page, start_type);
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
@@ -1911,12 +1914,10 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
 	/* Yoink! */
 	mt = get_pageblock_migratetype(page);
 	/* Only reserve normal pageblocks (i.e., they can merge with others) */
-	if (migratetype_is_mergeable(mt)) {
-		if (move_freepages_block(zone, page, MIGRATE_HIGHATOMIC) != -1) {
-			set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
+	if (migratetype_is_mergeable(mt))
+		if (move_freepages_block(zone, page,
+					 MIGRATE_HIGHATOMIC) != -1)
 			zone->nr_reserved_highatomic += pageblock_nr_pages;
-		}
-	}
 
 out_unlock:
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -1995,7 +1996,6 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * not fail on zone boundaries.
 			 */
 			WARN_ON_ONCE(ret == -1);
-			set_pageblock_migratetype(page, ac->migratetype);
 			if (ret > 0) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return ret;
@@ -2698,10 +2698,9 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			 * Only change normal pageblocks (i.e., they can merge
 			 * with others)
 			 */
-			if (migratetype_is_mergeable(mt) &&
-			    move_freepages_block(zone, page,
-						 MIGRATE_MOVABLE) != -1)
-				set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+			if (migratetype_is_mergeable(mt))
+				move_freepages_block(zone, page,
+						     MIGRATE_MOVABLE);
 		}
 	}
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 71539d7b96cf..f84f0981b2df 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -188,7 +188,6 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 			return -EBUSY;
 		}
 		__mod_zone_freepage_state(zone, -nr_pages, mt);
-		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		zone->nr_isolate_pageblock++;
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
@@ -262,10 +261,10 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		 */
 		WARN_ON_ONCE(nr_pages == -1);
 		__mod_zone_freepage_state(zone, nr_pages, migratetype);
-	}
-	set_pageblock_migratetype(page, migratetype);
-	if (isolated_page)
+	} else {
+		set_pageblock_migratetype(page, migratetype);
 		__putback_isolated_page(page, order, migratetype);
+	}
 	zone->nr_isolate_pageblock--;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-- 
2.44.0


