Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB37C9EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjJPFbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjJPFbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:31:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767D1A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434249; x=1728970249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oayBWHmLvZPHkilBpaQJzT0ghr/vVONoAKNZEgSFLCA=;
  b=aNwA0sNOFRBXky4E/8jKhyFIQyuK3bIzNwKHV6tvtr/BucBLexbY+Azk
   YeErJoSG87Ir9TqdE1CF8nkhTBc16Ugn8MQhOXz61TmYm6gd49hQnun2C
   OygZO/ejcP6O2ZNH4fZ07eE1qre5fFMG2B8KteDoRBbz7FghPkWZt3sy2
   yC4ZtEsYR2XHjQjSwuAIQXWQiS7vbS4CuJzoF1JwdvTX7z8Qlgsk+nmp9
   X9MtGHSsIZk+SEOHWV2jDKh9jTQMl/vb5UPmmdjqaVtzcXfpI78MVIDct
   o32XXQCn1fVIrY5HdpTyblYwvDIxmQxI8peU0ikyFz6s2naiVL+CDpLhn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389308119"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389308119"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356750"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356750"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:47 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH -V3 8/9] mm, pcp: decrease PCP high if free pages < high watermark
Date:   Mon, 16 Oct 2023 13:30:01 +0800
Message-Id: <20231016053002.756205-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016053002.756205-1-ying.huang@intel.com>
References: <20231016053002.756205-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One target of PCP is to minimize pages in PCP if the system free pages
is too few.  To reach that target, when page reclaiming is active for
the zone (ZONE_RECLAIM_ACTIVE), we will stop increasing PCP high in
allocating path, decrease PCP high and free some pages in freeing
path.  But this may be too late because the background page reclaiming
may introduce latency for some workloads.  So, in this patch, during
page allocation we will detect whether the number of free pages of the
zone is below high watermark.  If so, we will stop increasing PCP high
in allocating path, decrease PCP high and free some pages in freeing
path.  With this, we can reduce the possibility of the premature
background page reclaiming caused by too large PCP.

The high watermark checking is done in allocating path to reduce the
overhead in hotter freeing path.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <jweiner@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ec3f7daedcc7..c88770381aaf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1018,6 +1018,7 @@ enum zone_flags {
 					 * Cleared when kswapd is woken.
 					 */
 	ZONE_RECLAIM_ACTIVE,		/* kswapd may be scanning the zone. */
+	ZONE_BELOW_HIGH,		/* zone is below high watermark. */
 };
 
 static inline unsigned long zone_managed_pages(struct zone *zone)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8382ad2cdfd4..253fc7d0498e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2407,7 +2407,13 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		return min(batch << 2, pcp->high);
 	}
 
-	if (pcp->count >= high && high_min != high_max) {
+	if (high_min == high_max)
+		return high;
+
+	if (test_bit(ZONE_BELOW_HIGH, &zone->flags)) {
+		pcp->high = max(high - (batch << pcp->free_factor), high_min);
+		high = max(pcp->count, high_min);
+	} else if (pcp->count >= high) {
 		int need_high = (batch << pcp->free_factor) + batch;
 
 		/* pcp->high should be large enough to hold batch freed pages */
@@ -2457,6 +2463,10 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	if (pcp->count >= high) {
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
 				   pcp, pindex);
+		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
+		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
+				      ZONE_MOVABLE, 0))
+			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
 	}
 }
 
@@ -2763,7 +2773,7 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 	 * If we had larger pcp->high, we could avoid to allocate from
 	 * zone.
 	 */
-	if (high_min != high_max && !test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
+	if (high_min != high_max && !test_bit(ZONE_BELOW_HIGH, &zone->flags))
 		high = pcp->high = min(high + batch, high_max);
 
 	if (!order) {
@@ -3225,6 +3235,25 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			}
 		}
 
+		/*
+		 * Detect whether the number of free pages is below high
+		 * watermark.  If so, we will decrease pcp->high and free
+		 * PCP pages in free path to reduce the possibility of
+		 * premature page reclaiming.  Detection is done here to
+		 * avoid to do that in hotter free path.
+		 */
+		if (test_bit(ZONE_BELOW_HIGH, &zone->flags))
+			goto check_alloc_wmark;
+
+		mark = high_wmark_pages(zone);
+		if (zone_watermark_fast(zone, order, mark,
+					ac->highest_zoneidx, alloc_flags,
+					gfp_mask))
+			goto try_this_zone;
+		else
+			set_bit(ZONE_BELOW_HIGH, &zone->flags);
+
+check_alloc_wmark:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (!zone_watermark_fast(zone, order, mark,
 				       ac->highest_zoneidx, alloc_flags,
-- 
2.39.2

