Return-Path: <linux-kernel+bounces-109281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3488171C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DF5281B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA26D1B1;
	Wed, 20 Mar 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ur0JuruC"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB66E5EC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957904; cv=none; b=Ih/CoQtxaLWgyICLeMJTM5KXj5p9HABvqQufYxvUIRrF1zOI60FSa6UwC6nCWhy+0grnoe0TjYQK+NBmNERm4MVb4A6gL+NOMzRfl9d+Z1K6SGkHvvjy/gsm+VEoWZwusLth2y6X96Yqmdp2fvhe5zMzQpfJOGNCtolmPt6/Nj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957904; c=relaxed/simple;
	bh=vgs1fSn63PW51Wej021f8rVcPq+RIeHb4BdM8Eq5vK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCZZPxXxYGT+Iogzm+HU3j89TpBcVhs/A1TQuarCJ0NHN2q/NF4kXVDuzIHCM5kI4H4bmyY8U2QQOglbeOMynlrDmT6g9dsZRkVxPs891v9Q+TeP9hPlhx/vSISu4DCl7n38cqqGzv6M3digm+vs+5vj8Io6kwgBR6BUn5v/w0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ur0JuruC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690fed6816fso1159286d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957901; x=1711562701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flNXTtbOi6l1opPzPulo8MxPNWZbuYfRY5TPRoxN0V8=;
        b=ur0JuruChaxtUELNnIfd3d+MPEKilCPRR6KJuAuaOTjFBN5nn2mUpJGSFztvBKo4kE
         g+WGn8pASnhKWnbaE9ghiETm/D7xDZ/n1Mym8pcWXJNxooP24znJGlYwGvqLQjDhYm3m
         FjRIGJJd6RIDZ4mL9ZH6gMZaLcDq93it6MY8MBlu/1RBqxpOSlkvfb2mHmCFMHdnJaLw
         u2tuKdsbYFEidOEYw3srx/VfgzXjXQAOcEYasCpewVVM9d1bOnLbd2+sfau9xw8bF/sP
         tcXpRf06VP3rkcPknrf9FiseUGNxcd31epDe7mvD/zVWmxMhyO05R39y1EPKsQ9/aXgw
         1U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957901; x=1711562701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flNXTtbOi6l1opPzPulo8MxPNWZbuYfRY5TPRoxN0V8=;
        b=oPNVutagaIoR59Ew/59J+udteqOqfFcjD1jitzQXhYI1baupcHvkFCr6zXtiHTypMj
         7qA4CwOlKzPKuUSVkgOmq43C9z8yrFSizj6NuqJoOSXDuTo3/3XkgsvgP5mvgkyA5DZq
         cb0NW8W2/SXjxoxgu9bE9tah00YQ+lZkZ60inVv1axIym0AwYUrHly1CRb7ZGvYFygRW
         0eg43bvzObATIV1ax1p+J0O36pG26KyAUTUJWUxc8rNHdtZ/3ZZEUz4IWXu4WL01b13X
         UXCTY2qIlD91tYzxlgEG4FmsaGIqyXKqfeoM+UyXWWI+EMUWfI4rH33XFFjRNhZJ/LHf
         AiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWO6by3kG6fzALeycmiBNsDIbT2UjfVA799L0rh+mOpxwsvZ6qt/ul5dAJHe8A/mErYYR8vAsPhydGXkB1oIHuRrGpLnipZd1TjclI
X-Gm-Message-State: AOJu0YzsJqPLohqyp/ZXWAiMZdt00OXSQX0TcspfsWKStEXIeOAKFfQQ
	cI1Ro/CaakBTYfg3EHuh/TGz/GruSuUIv4Hm8lmtGoOIoR3Mgluw5aj8OTLE7NY=
X-Google-Smtp-Source: AGHT+IFZ8dHGGlrLtFAYw7pJUEMpCiD9DvUpZzuKYVnmjN5J3RADhgWs7NKoZjpYmw1YXPj55rjIPA==
X-Received: by 2002:ad4:55d1:0:b0:696:48ca:99ad with SMTP id bt17-20020ad455d1000000b0069648ca99admr1661910qvb.14.1710957901465;
        Wed, 20 Mar 2024 11:05:01 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id jm14-20020ad45ece000000b00690c5cc0ff6sm8102285qvb.124.2024.03.20.11.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:05:00 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] mm: page_alloc: close migratetype race between freeing and stealing
Date: Wed, 20 Mar 2024 14:02:12 -0400
Message-ID: <20240320180429.678181-8-hannes@cmpxchg.org>
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

There are three freeing paths that read the page's migratetype
optimistically before grabbing the zone lock. When this races with
block stealing, those pages go on the wrong freelist.

The paths in question are:
- when freeing >costly orders that aren't THP
- when freeing pages to the buddy upon pcp lock contention
- when freeing pages that are isolated
- when freeing pages initially during boot
- when freeing the remainder in alloc_pages_exact()
- when "accepting" unaccepted VM host memory before first use
- when freeing pages during unpoisoning

None of these are so hot that they would need this optimization at the
cost of hampering defrag efforts. Especially when contrasted with the
fact that the most common buddy freeing path - free_pcppages_bulk - is
checking the migratetype under the zone->lock just fine.

In addition, isolated pages need to look up the migratetype under the
lock anyway, which adds branches to the locked section, and results in
a double lookup when the pages are in fact isolated.

Move the lookups into the lock.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 52 ++++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e7d0d4711bdd..3f65b565eaad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1227,18 +1227,15 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
-static void free_one_page(struct zone *zone,
-				struct page *page, unsigned long pfn,
-				unsigned int order,
-				int migratetype, fpi_t fpi_flags)
+static void free_one_page(struct zone *zone, struct page *page,
+			  unsigned long pfn, unsigned int order,
+			  fpi_t fpi_flags)
 {
 	unsigned long flags;
+	int migratetype;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	if (unlikely(has_isolate_pageblock(zone) ||
-		is_migrate_isolate(migratetype))) {
-		migratetype = get_pfnblock_migratetype(page, pfn);
-	}
+	migratetype = get_pfnblock_migratetype(page, pfn);
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -1246,21 +1243,13 @@ static void free_one_page(struct zone *zone,
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags)
 {
-	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
 	if (!free_pages_prepare(page, order))
 		return;
 
-	/*
-	 * Calling get_pfnblock_migratetype() without spin_lock_irqsave() here
-	 * is used to avoid calling get_pfnblock_migratetype() under the lock.
-	 * This will reduce the lock holding time.
-	 */
-	migratetype = get_pfnblock_migratetype(page, pfn);
-
-	free_one_page(zone, page, pfn, order, migratetype, fpi_flags);
+	free_one_page(zone, page, pfn, order, fpi_flags);
 
 	__count_vm_events(PGFREE, 1 << order);
 }
@@ -2533,7 +2522,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype, pcpmigratetype;
+	int migratetype;
 
 	if (!free_pages_prepare(page, order))
 		return;
@@ -2545,23 +2534,23 @@ void free_unref_page(struct page *page, unsigned int order)
 	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = pcpmigratetype = get_pfnblock_migratetype(page, pfn);
+	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, FPI_NONE);
 			return;
 		}
-		pcpmigratetype = MIGRATE_MOVABLE;
+		migratetype = MIGRATE_MOVABLE;
 	}
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
+		free_unref_page_commit(zone, pcp, page, migratetype, order);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
+		free_one_page(zone, page, pfn, order, FPI_NONE);
 	}
 	pcp_trylock_finish(UP_flags);
 }
@@ -2591,12 +2580,8 @@ void free_unref_folios(struct folio_batch *folios)
 		 * allocator.
 		 */
 		if (!pcp_allowed_order(order)) {
-			int migratetype;
-
-			migratetype = get_pfnblock_migratetype(&folio->page,
-							       pfn);
-			free_one_page(folio_zone(folio), &folio->page, pfn,
-					order, migratetype, FPI_NONE);
+			free_one_page(folio_zone(folio), &folio->page,
+				      pfn, order, FPI_NONE);
 			continue;
 		}
 		folio->private = (void *)(unsigned long)order;
@@ -2632,7 +2617,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, migratetype, FPI_NONE);
+					      order, FPI_NONE);
 				continue;
 			}
 
@@ -2645,7 +2630,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, migratetype, FPI_NONE);
+					      order, FPI_NONE);
 				continue;
 			}
 			locked_zone = zone;
@@ -6823,13 +6808,14 @@ bool take_page_off_buddy(struct page *page)
 bool put_page_back_buddy(struct page *page)
 {
 	struct zone *zone = page_zone(page);
-	unsigned long pfn = page_to_pfn(page);
 	unsigned long flags;
-	int migratetype = get_pfnblock_migratetype(page, pfn);
 	bool ret = false;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	if (put_page_testzero(page)) {
+		unsigned long pfn = page_to_pfn(page);
+		int migratetype = get_pfnblock_migratetype(page, pfn);
+
 		ClearPageHWPoisonTakenOff(page);
 		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
 		if (TestClearPageHWPoison(page)) {
-- 
2.44.0


