Return-Path: <linux-kernel+bounces-109282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB688171E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD611C210F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4870CBE;
	Wed, 20 Mar 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="wp8yL/c4"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAF6FE37
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957905; cv=none; b=kdAOViFGeoL/6zx0y4AIM8XemshHGPdWZtppM4ntU8C0MlmWNIlnACC51iBPyhtNff4E8mc3te5S1sTj5YFa5aZIPvDW5H7cachE4Z+5RCnWvZckT8W7YUJskWNcvzlpLkY1A0YGeR8/J40L1tOuCZBg4jyiUdm3jKbbn+Y8kE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957905; c=relaxed/simple;
	bh=a5Hd9QHmzdUL3ZAgZf882mRDeq1mAtAaKRwDN3PrUTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SULiKmZwHNri71k39kVCMojK5x20tOoEGmDLOWrSzB9LiHoeBL2XW6U1zL+9ES1FLpihWFsJDZ11dp3wz08GqIpT1xgf6C0uMRLHwguzeQ8j4m6EzWYQ/n9nCbMo+PLGxlhWS+RyCOMPBAYb2fneWNPOdnua6daOiPCGtvVO71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=wp8yL/c4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-789e6e1d96eso10281485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957903; x=1711562703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/agc7Iq+rpxvE93VG+YAHYepTCDVe1OJjvDT1Xeceos=;
        b=wp8yL/c4TdGVoNhDI2CRYI0IP4ibTxyFQEOcJx3ypVX9f/TpNG+sD608mKENz8VRxt
         lzOe+mck5rZlfhcPXu5gx2HkvyFjMhA5EcwVgZV7hMr3rJz+OkQ/D1MJ1LMAcUpuSdro
         keQ0UYvs1m/OH11fg39vfy+F5RtXranFRa/+BkMVboaGoKXHvc59xEJgClBUAfufeCoO
         eKUlZkLAwVWRBZwI30dnib2d5fH0QgbDlaFXGxDDoxm1QAiGRKMG/kJohNsVxh7BZaUL
         BM8PIMHAU2IlXSTVXRqjv+yArEVPp4eVQby7k5f60mSyQ9hvJUEazgz55vEFBN9S24Rs
         0sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957903; x=1711562703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/agc7Iq+rpxvE93VG+YAHYepTCDVe1OJjvDT1Xeceos=;
        b=HNL4nD2r0mjnBDJqqzcoph4T7cPHh6riG2WhSZQTe2Nk2cS+NBv6nakxjqNodsY5Dv
         yeeoTUVDSlGAYuvuM5Kz5Rq2N0jiLoEzE1AN8D/0BmNaUhT7uU6PZRVAB5JNXo4DPRGM
         KmsElbxxDzXd8UtB+yDZgmxtBFaQ9b8QJhv+qWrrIOd+7IEnfaZkw9rQ3kryOEA9h0cp
         zC+YB1FHEXpDvfMxg7hUg0Uktk4jGzepVGRfQzkw/zrWhuM9wQLriZleiNpVk3sds+0i
         jm63eJ/wpWLfHYXTgMUWdJVBpwPoWYZ93kzw2xTw3cJsrm0mf/oTrP/txb6TejLTZ/re
         aCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtzF700FVTe3QA9v4IigCSCSep2KCE10gyidu7H2XgXnk4kVxXZECrtWb6LpVMle20OYG8t8tSXAoFPKwYRVhhre9J47qWNrKXXmTk
X-Gm-Message-State: AOJu0Yyl/rUiFVNZDyImqxQXmbrbIALbKlYrxrt4a5omvBMPI4j9AuzD
	p0M1dES2ytM50WvSZqHqudq1uDSmcOpn+OO4U0Be3qbRBwWjyzibtBpCqWnlCv4=
X-Google-Smtp-Source: AGHT+IHVDZsbT9cqnC3HSTs2AyL3KxvP5tWB415HoSJ1bTxAaB/NmMu1L5tzkR6Fc/n91vn14sa1gw==
X-Received: by 2002:a37:db11:0:b0:78a:86:534f with SMTP id e17-20020a37db11000000b0078a0086534fmr2673755qki.76.1710957902810;
        Wed, 20 Mar 2024 11:05:02 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a094800b0078a210372fasm900228qkw.86.2024.03.20.11.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:05:02 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] mm: page_alloc: set migratetype inside move_freepages()
Date: Wed, 20 Mar 2024 14:02:13 -0400
Message-ID: <20240320180429.678181-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
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
index 3f65b565eaad..d687f27d891f 100644
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
@@ -2711,10 +2711,9 @@ int __isolate_free_page(struct page *page, unsigned int order)
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


