Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABF7A72BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjITGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjITGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:20:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0CCC9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190805; x=1726726805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6W6lJyCPE2vK1mxwG+RBHDFX6xtr7yfsoTDfDpxDR10=;
  b=EJur15BdL1AofMJxC1dgVPzOu6jkqI1uiiSu9QDQNm5rjdI5ghObtCnU
   B7sqjN0uTlMAwW35J2+xf9TapE76cyd799uZ/I6PdNc2PEJoj6TAVyfnO
   Ev2Y/Rs7a4OZhQOfH/qL44GVwcHdPY+ZXJ1v3VKSw7kbP++jX+B67BQTR
   3uKUdKzTzerKd44k2sBrekpfIlEqJsKSM7QNcl+lCMkUIBTOuRJj/pk0S
   V/VbAVmsiWm2BvCp4kjK6iNRslW0sdw+bq7jpfOECMJkW8GxBbWi9gunP
   hMhDqMRb9HQ2TDSV2gdwpk2KfweKTC+H+cdR87sSmEtW2VKULP2Y3EEZM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187763"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187763"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060665"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060665"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:20:01 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH 08/10] mm, pcp: decrease PCP high if free pages < high watermark
Date:   Wed, 20 Sep 2023 14:18:54 +0800
Message-Id: <20230920061856.257597-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920061856.257597-1-ying.huang@intel.com>
References: <20230920061856.257597-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 mm/page_alloc.c        | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d6cfb5023f3e..8a19e2af89df 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1006,6 +1006,7 @@ enum zone_flags {
 					 * Cleared when kswapd is woken.
 					 */
 	ZONE_RECLAIM_ACTIVE,		/* kswapd may be scanning the zone. */
+	ZONE_BELOW_HIGH,		/* zone is below high watermark. */
 };
 
 static inline unsigned long zone_managed_pages(struct zone *zone)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 225abe56752c..3f8c7dfeed23 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2409,7 +2409,13 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
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
@@ -2459,6 +2465,10 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	if (pcp->count >= high) {
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
 				   pcp, pindex);
+		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
+		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
+				      ZONE_MOVABLE, 0))
+			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
 	}
 }
 
@@ -2765,7 +2775,7 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 	 * If we had larger pcp->high, we could avoid to allocate from
 	 * zone.
 	 */
-	if (high_min != high_max && !test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
+	if (high_min != high_max && !test_bit(ZONE_BELOW_HIGH, &zone->flags))
 		high = pcp->high = min(high + batch, high_max);
 
 	if (!order) {
@@ -3226,6 +3236,14 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			}
 		}
 
+		mark = high_wmark_pages(zone);
+		if (zone_watermark_fast(zone, order, mark,
+					ac->highest_zoneidx, alloc_flags,
+					gfp_mask))
+			goto try_this_zone;
+		else if (!test_bit(ZONE_BELOW_HIGH, &zone->flags))
+			set_bit(ZONE_BELOW_HIGH, &zone->flags);
+
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (!zone_watermark_fast(zone, order, mark,
 				       ac->highest_zoneidx, alloc_flags,
-- 
2.39.2

