Return-Path: <linux-kernel+bounces-93314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB83872DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A98C1F22B06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9319BCA;
	Wed,  6 Mar 2024 04:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="LgWk2zI7"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF315ACB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698584; cv=none; b=L9Gf5LbKmFcsTyVyAvwB/EabjwUmwyZLB+RmYd78Efli0H7Bd75s52qKiOmGn/QrELiPrKnoSCiJNESwmCE4I3LL8/d0T13WhDKdlP1EXRZGAN3BTmhMpHz0Xdijl4GeQf6fn5EjuQtEyT7eZL8OmdS6+c1TTCUsYsJvGfcvj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698584; c=relaxed/simple;
	bh=dEF4fHRjltrstHuxukV0Wd2znano2LVwA29eCmc//+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfZ8Ya9h1eyF2ykMQ/hQs4ETjn23iuhlvlomAGQMUYCgXSB0p6Zh9H1qSmG60VHSpa4IAnvstCP5HU3jeZat3j6Qy9acqw+aAtsFhadvdtBUwoyYTTstDnQWcwPGV8gNwsRQfeZQ+mTThQKNL6sOeIuoH/WdErVkzfhksJ+s5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=LgWk2zI7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42edb6f56f2so17933281cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698581; x=1710303381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpqItcyH2EDAXtPSFuVCpgEvxVG9s6bJRth9b0kyPMA=;
        b=LgWk2zI7jGhLHmdeBJx0VevSKPoeopb+6F33HQRCc96RfG0mslR7b394J/wV5NW1RM
         BRXBux8eeK4PpFcnZPSC+tdpuE+XMkPe4H0JXb1h7G1eZAg2gcgBRZVV5gm/SqqUntp/
         +x6+VCsFOD2NXn2HL5F/w2OmfNqz24qOFkW6j2gtFfviziO37CrzMNSDgnumgi0DkimR
         0tZMAtPb9D7cEHygucTVg7+1XrrBPU4Eum0ortfkI/+/5vD/+d9LW42x+r52acE4heHI
         kDvVwZEfDuIJAK5jqustPmzCJyv40hO2uGVJCNZoJnQ4CDvPz2dVvIHzFEjrz5XmkX3N
         MGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698581; x=1710303381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpqItcyH2EDAXtPSFuVCpgEvxVG9s6bJRth9b0kyPMA=;
        b=TzFxpMjKr+vuWyygYi9/Sau01tAJA2nxD0SG/xdpOqQoGxqxfE6E/DeCVQaR5aIluF
         sXcJF6+bEm4O3ynoXj297k+i8NXbp0tgjzmf+GS6P+SKobNrJtxFo8pr14ueRkIAGh3H
         VWlaRYDQuQx+cUzwXbfHDUA5zsVAPFkxCgNXlAug52J4Cto1jAkmLicjGFRnGhWCEvq4
         ounFb+IJ2f7o7Qs2BaAIqQzlBnkMPWsXlaJW+ljNzEk9JMsCN469AFG6QOFpNmoeCApP
         NN2AYuq0d5CAhWc1BPzlrICUF1poZYUyAyJGS/SinRzi6u6lMGwNRzbKsxUn8KqKyT4m
         WPAA==
X-Forwarded-Encrypted: i=1; AJvYcCWtDJt2fHW4MUy+XExBUBAYSilM2+V/s8ehOiwVCMGGXpy+ZmjI3VQEffHDOkTS4jPV7PMKZ/91Vd7Ds9PyQA4IzALtB4cHfWzZ/yls
X-Gm-Message-State: AOJu0Yw/uAiQbMX3w5Lp8IKUJSK4g2BvihzaYdugn8FaNYWuUni4jH81
	n/U4G80n+nAM9Lz1jisCfob1KnmC4LWiLbHzoPhoSp/xo5l9Z3Gd62tqcGzNg5o=
X-Google-Smtp-Source: AGHT+IFlnJve3Rb16fSRkg2cnwF59nsIv8qKr5z8db/VPIGVmj2pSzSHnn6osAw7nOgwMuODvBzfPg==
X-Received: by 2002:a05:622a:110b:b0:42e:f56b:91d1 with SMTP id e11-20020a05622a110b00b0042ef56b91d1mr4214660qty.32.1709698581469;
        Tue, 05 Mar 2024 20:16:21 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id k6-20020ac80746000000b0042ee243ca95sm3509250qth.50.2024.03.05.20.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:20 -0800 (PST)
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
Subject: [PATCH 02/10] mm: page_alloc: optimize free_unref_page_list()
Date: Tue,  5 Mar 2024 23:08:33 -0500
Message-ID: <20240306041526.892167-3-hannes@cmpxchg.org>
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

Move direct freeing of isolated pages to the lock-breaking block in
the second loop. This saves an unnecessary migratetype reassessment.

Minor comment and local variable scoping cleanups.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9665a2db3b53..88f4e08726ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2521,30 +2521,17 @@ void free_unref_folios(struct folio_batch *folios)
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
-	int i, j, migratetype;
+	int i, j;
 
 	/* Prepare folios for freeing */
 	for (i = 0, j = 0; i < folios->nr; i++) {
 		struct folio *folio = folios->folios[i];
-		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
 		if (order > 0 && folio_test_large_rmappable(folio))
 			folio_undo_large_rmappable(folio);
 		if (!free_pages_prepare(&folio->page, order))
 			continue;
-
-		/*
-		 * Free isolated folios and orders not handled on the PCP
-		 * directly to the allocator, see comment in free_unref_page.
-		 */
-		migratetype = get_pfnblock_migratetype(&folio->page, pfn);
-		if (!pcp_allowed_order(order) ||
-		    is_migrate_isolate(migratetype)) {
-			free_one_page(folio_zone(folio), &folio->page, pfn,
-					order, migratetype, FPI_NONE);
-			continue;
-		}
 		folio->private = (void *)(unsigned long)order;
 		if (j != i)
 			folios->folios[j] = folio;
@@ -2557,15 +2544,29 @@ void free_unref_folios(struct folio_batch *folios)
 		struct zone *zone = folio_zone(folio);
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = (unsigned long)folio->private;
+		int migratetype;
 
 		folio->private = NULL;
 		migratetype = get_pfnblock_migratetype(&folio->page, pfn);
 
 		/* Different zone requires a different pcp lock */
-		if (zone != locked_zone) {
+		if (zone != locked_zone ||
+		    is_migrate_isolate(migratetype)) {
 			if (pcp) {
 				pcp_spin_unlock(pcp);
 				pcp_trylock_finish(UP_flags);
+				locked_zone = NULL;
+				pcp = NULL;
+			}
+
+			/*
+			 * Free isolated pages directly to the
+			 * allocator, see comment in free_unref_page.
+			 */
+			if (is_migrate_isolate(migratetype)) {
+				free_one_page(zone, &folio->page, pfn,
+					      order, migratetype, FPI_NONE);
+				continue;
 			}
 
 			/*
@@ -2578,7 +2579,6 @@ void free_unref_folios(struct folio_batch *folios)
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
 					      order, migratetype, FPI_NONE);
-				locked_zone = NULL;
 				continue;
 			}
 			locked_zone = zone;
-- 
2.44.0


