Return-Path: <linux-kernel+bounces-109276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BB881717
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A46B1F23A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804946BFCD;
	Wed, 20 Mar 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0g/90nVD"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33206A010
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957897; cv=none; b=ZgmBIYtw9xjZsnDjuRM6nGgyZf6GEInwwowpFSUUOuOnUuXInK0VcNqBexTnX6Ebc0ojqzGfx/OwahCyPZWDXgOX6KT8IbpST/Pcp1jzVoEGYwqmZgKOfCf5kgTJeibmn51cdn/6yIdpujolm57+/xEFE81YLrWz2cqgW0tP8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957897; c=relaxed/simple;
	bh=zMKmZdkkzKtk9Q/OCnNBuxwjuv/WnG/o79eAJs14Hq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwvt+Vxfik5cVa3bjCqDMhCiNFkUhlUIlqAkxRzQ22aU1E9i5gLDv5Y/4xx/Vo/9JIrfxoNTbjfs2PS4YkdYk2TmDUfG0n33xRmPwefJDcTlJZ1o34Ah7YPV2WCMOD94Vjgn8gsdeYkQQZq1j3e9t0IYxFhHrXUE8XyOQnrB9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0g/90nVD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430c4b1a439so936771cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957894; x=1711562694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCOZaDSQS3uSogr2y2Y4MtomH1kr/Fi4b+AnkoSHYG0=;
        b=0g/90nVDDAWf8MlBvLX9nRCd6KV9Sk2v0FwTBAY4xIp89n+7Yoy3QfjFZ3nkkhtHeO
         P6eHgNTf1zEzQQBNlwhaEJ01jZicA/1XsisDWfZMgx9AijcKbeqYGvbeFi4GFjZiYcMs
         EX22Mtw+AHZhwirAdJHlWMrsHd1SlKbtpii/hgjsF+dMpQisPQjgxMYfa4hhyteYTOM+
         XsW0owMTP7XaDvvX/7qGdPLoEeMAjiVCM8w5/3gNY0RgFpBy1BIiMfXbBIwmNM8IGShf
         MOPDYinoZZVqZrxWjcXFSpWfsoP7MyzkQ6mE0OJwQR24oEqOYQQ6Y0M/gvwWdHTg1Hms
         PMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957894; x=1711562694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCOZaDSQS3uSogr2y2Y4MtomH1kr/Fi4b+AnkoSHYG0=;
        b=BMWIFtP5OrwZZqzo2yivIFpMIRgCVHV6CSM5CHk72DKeuK+PH04ZNcDqOtVCYXsdFA
         90QKdJu+I4UVzBNMQMcnx4IaQPkieobDYdVaRDBM5gzt87UZnFdd9anbh7bk0NbgUPzh
         oisYreXTQF1k19y31ztayIiTSeaysujMTuFiVfc5dcFGixKFGWJ+idWXtuaam7nyrRCj
         eGUPx9UQf/8g8d+Yq6thnNm2xVFt1JvWlIiRRZggbdT+hUdLTMQ0iE0KkARhFM7mK/qG
         FR8lClhre4D6iCzMTM+usz47JEK3pFw61zcJLGelMlukVgxyX8oBiFQZO6Sr7tIUmbYx
         13Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWAq1RQ2qdCnWvRvGWged49p+11FWyInbhS/Zc+1QUpMnqnbU7Y4/0MQd8VZl5kg4dfai/+7XMHWdCN7cX6N5gn/WrbsQ/NO+nx4y70
X-Gm-Message-State: AOJu0YwJe8A1TlXRwNQzUm0F/XHVRKNuZehWp8vLfdtwojFqh29s/Hul
	nFRzuY3/9CK6d77edGMt5wlr76VwzM7DBVkPsVN18WRLFBp+ehJG8YjhEUSYA2Y=
X-Google-Smtp-Source: AGHT+IF5UfXc5lTV+1+ZbEqDKnB2S/2dMfIITfLAmk8SgkXLoh8oySBupjmVBPzQZ9ttFuOzueZSzQ==
X-Received: by 2002:a05:622a:54:b0:42f:20f2:c4cf with SMTP id y20-20020a05622a005400b0042f20f2c4cfmr2979645qtw.31.1710957894003;
        Wed, 20 Mar 2024 11:04:54 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id y17-20020a05622a005100b00430d8e11bebsm3231779qtw.64.2024.03.20.11.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:04:53 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] mm: page_alloc: optimize free_unref_folios()
Date: Wed, 20 Mar 2024 14:02:07 -0400
Message-ID: <20240320180429.678181-3-hannes@cmpxchg.org>
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

Move direct freeing of isolated pages to the lock-breaking block in
the second loop. This saves an unnecessary migratetype reassessment.

Minor comment and local variable scoping cleanups.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 60a632b7c9f6..994e4f790e92 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2524,7 +2524,7 @@ void free_unref_folios(struct folio_batch *folios)
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
-	int i, j, migratetype;
+	int i, j;
 
 	/* Prepare folios for freeing */
 	for (i = 0, j = 0; i < folios->nr; i++) {
@@ -2536,14 +2536,15 @@ void free_unref_folios(struct folio_batch *folios)
 			folio_undo_large_rmappable(folio);
 		if (!free_pages_prepare(&folio->page, order))
 			continue;
-
 		/*
-		 * Free isolated folios and orders not handled on the PCP
-		 * directly to the allocator, see comment in free_unref_page.
+		 * Free orders not handled on the PCP directly to the
+		 * allocator.
 		 */
-		migratetype = get_pfnblock_migratetype(&folio->page, pfn);
-		if (!pcp_allowed_order(order) ||
-		    is_migrate_isolate(migratetype)) {
+		if (!pcp_allowed_order(order)) {
+			int migratetype;
+
+			migratetype = get_pfnblock_migratetype(&folio->page,
+							       pfn);
 			free_one_page(folio_zone(folio), &folio->page, pfn,
 					order, migratetype, FPI_NONE);
 			continue;
@@ -2560,15 +2561,29 @@ void free_unref_folios(struct folio_batch *folios)
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
@@ -2581,7 +2596,6 @@ void free_unref_folios(struct folio_batch *folios)
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
 					      order, migratetype, FPI_NONE);
-				locked_zone = NULL;
 				continue;
 			}
 			locked_zone = zone;
-- 
2.44.0


