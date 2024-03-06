Return-Path: <linux-kernel+bounces-93319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8469A872DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD151F229E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013DE1C2A6;
	Wed,  6 Mar 2024 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Y7CcmsIv"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC811BDE1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698593; cv=none; b=bMUmjSowL4oFyGlzank59UaSAQS8rgLi/mjtKzfTKatFT7341EFf1TC8IKewM0/fzzPsMqRmqOK7rYNhXB5WnceKsyBoJUimhX/A19mDRG9jKZggwt6eghyQz3rFYZ5ZrBMEz0ya8M1Khr102N1CGCBpufeZmKFvG18RHIFtkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698593; c=relaxed/simple;
	bh=4WQVjj/va+Yhi+zhydS+0RgY2NcpElIgmTQ92qaGzMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz8JY3BiV4YDRPK3B0Eqe+6LDuKTWCyLatKWc9Yis4Ei3YeD1n1D9kr5/l/w9DBMqcjUoMGhTawHX8hRmPEEEbAz6U8vE5bRFENsGoP22r3hGBtW+kKKOaTSrAaAdSB5pMIYYkFdbAu/1R45ByMXGS7nqVb52rdPdqS/WBW7b8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Y7CcmsIv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78822adc835so169180785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698590; x=1710303390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36xbR356rfIzWtgB9qLDyiEGey6MMsGLn5MqndsELSg=;
        b=Y7CcmsIvY0dCwIAlOgkC5SQQECcHx6iFRRBZN0EgeM+R0nmSCLZHg3ruD3CrDm8xNY
         4IKf0603+x6Iem+2AwDvMUQF5nnf8MXL7qDc3AHyjFVayWR8wgqFgDlLef7CW2N9rLLK
         9K4wkxL++G4uidNjJ8fQRefZJ4mm+xMte5kHD+G7grrvHYMVWytaZKJuFatTq540OVfo
         W6XuGzOGoWO6A+G/Zfhl7u10Tth04mFOIBzqPWvzfO3qQS8fk2TRpATACqaiN3FIXizv
         L6ixEYaPYpTikVT427okkXeJ8l6+IF8svTfmIc2I+IkAuC/6BJz3WXjbHQQ8TfUpaC7M
         Ct5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698590; x=1710303390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36xbR356rfIzWtgB9qLDyiEGey6MMsGLn5MqndsELSg=;
        b=XJOdaXTwuCky7cndP2BqkdWxKajzyFUmrV/+gIte0bhmT6pd2zOZB/TJTevVyJQ+OP
         wh+74pzBgYFmnF6nni6XM1e5IHDoU9vmIVHD6dzHO3tZ7L6uC9bWl+2sM0XyRYXLPBdH
         /MRFloT302emjjEkeJRRWlyKwGuMUKke97khh6cjYbre5+cmAzGYsvHDBe7HEfCIIJE9
         avLiddJN8FQU1HPku20dxzuhYcRzdFDT6ar56q+H3TYz6Z6DMjm9GjAS9t8SZfX1C88m
         sZYHrKVTtfSBxxvFMpkOeivCik0kAHKOCWd91554+Yvh/ySGrTVplTqYk2yrJOsDjYET
         wffw==
X-Forwarded-Encrypted: i=1; AJvYcCXQr/9+ookc2AlW30QuIKtjc0Y1plZzWJ3pMnsMzRAUpcyZZc2fT4emo3pic15T8akOlpqUYAik2yoy1BjJQqtKkGoeCxzjOlfPXZb6
X-Gm-Message-State: AOJu0YyLLFgfinzalOELdcH7CRfASiNv3sfye4n3WkWGmFr7u6kcAMmy
	33rDfwecQ0IHuRk5srlcq5xj/6Fv5COlIYaLXKVe5c3970fBIGIT2bCl2V8+n70=
X-Google-Smtp-Source: AGHT+IHjBLTEjXsYssAa7PuQ/BMacfQ6VruPXkruqLKHw1gogijgd2A4F8i/4YwGrtqS5m5epciAkw==
X-Received: by 2002:a05:620a:24c8:b0:788:3f44:f2bf with SMTP id m8-20020a05620a24c800b007883f44f2bfmr488280qkn.43.1709698590368;
        Tue, 05 Mar 2024 20:16:30 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id v13-20020a05620a122d00b00788357d6759sm1351474qkj.11.2024.03.05.20.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:29 -0800 (PST)
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
Subject: [PATCH 07/10] mm: page_alloc: close migratetype race between freeing and stealing
Date: Tue,  5 Mar 2024 23:08:38 -0500
Message-ID: <20240306041526.892167-8-hannes@cmpxchg.org>
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
 mm/page_alloc.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9cf7ed0c4cd6..82e6c4068647 100644
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
@@ -2530,7 +2519,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype, pcpmigratetype;
+	int migratetype;
 
 	if (!free_pages_prepare(page, order))
 		return;
@@ -2542,23 +2531,23 @@ void free_unref_page(struct page *page, unsigned int order)
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
@@ -2615,7 +2604,7 @@ void free_unref_folios(struct folio_batch *folios)
 			 */
 			if (is_migrate_isolate(migratetype)) {
 				free_one_page(zone, &folio->page, pfn,
-					      order, migratetype, FPI_NONE);
+					      order, FPI_NONE);
 				continue;
 			}
 
@@ -2628,7 +2617,7 @@ void free_unref_folios(struct folio_batch *folios)
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
-					      order, migratetype, FPI_NONE);
+					      order, FPI_NONE);
 				continue;
 			}
 			locked_zone = zone;
@@ -6796,13 +6785,14 @@ bool take_page_off_buddy(struct page *page)
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


