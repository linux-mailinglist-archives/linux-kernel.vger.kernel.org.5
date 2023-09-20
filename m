Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95D7A72BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjITGUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjITGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:20:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F6AB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695190809; x=1726726809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FoiCfoy4TLCRTojH1ubjvlhPyG87O12FA/RyIO19/k=;
  b=e97HTkmWjwmBWqYJ2BvfTxhgtOMn93iCwx8Wx/VoQdW619wARiAfUR+h
   PBFq9LJAByZADaQTe9s5h5LVYgifqsNhBvBPLff0dGi6K+AtbyKJ7dOxx
   xPIEZFzUvgPijRIgA4VCGalczuY+dSqpQehUZ+SUyTyGz9+2vynsNX7fj
   yA19bEJukBC7qwrxZRL24HKQUqbz8wsTRJbusqboeIlFVMZOje/w3m4LN
   wKlrcoBHEoYXfIKNNaqbITjcLjHnbF4luZn5Rq/CXee7hLn4sEZtApt9q
   RT3a1Xt5xzOB+faZTQN6gcecHJ9ktYRoemR6vADnkC3eP0cKPEFMq5xgn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="365187785"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="365187785"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="740060679"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="740060679"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:20:05 -0700
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
Subject: [PATCH 09/10] mm, pcp: avoid to reduce PCP high unnecessarily
Date:   Wed, 20 Sep 2023 14:18:55 +0800
Message-Id: <20230920061856.257597-10-ying.huang@intel.com>
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

In PCP high auto-tuning algorithm, to minimize idle pages in PCP, in
periodic vmstat updating kworker (via refresh_cpu_vm_stats()), we will
decrease PCP high to try to free possible idle PCP pages.  One issue
is that even if the page allocating/freeing depth is larger than
maximal PCP high, we may reduce PCP high unnecessarily.

To avoid the above issue, in this patch, we will track the minimal PCP
page count.  And, the periodic PCP high decrement will not more than
the recent minimal PCP page count.  So, only detected idle pages will
be freed.

On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
one socket with `make -j 112`.  With the patch, The number of pages
allocated from zone (instead of from PCP) decreases 25.8%.

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
 mm/page_alloc.c        | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8a19e2af89df..35b78c7522a7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -682,6 +682,7 @@ enum zone_watermarks {
 struct per_cpu_pages {
 	spinlock_t lock;	/* Protects lists field */
 	int count;		/* number of pages in the list */
+	int count_min;		/* minimal number of pages in the list recently */
 	int high;		/* high watermark, emptying needed */
 	int high_min;		/* min high watermark */
 	int high_max;		/* max high watermark */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3f8c7dfeed23..77e9b7b51688 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2166,19 +2166,20 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	int high_min, to_drain, batch;
+	int high_min, decrease, to_drain, batch;
 	int todo = 0;
 
 	high_min = READ_ONCE(pcp->high_min);
 	batch = READ_ONCE(pcp->batch);
 	/*
-	 * Decrease pcp->high periodically to try to free possible
-	 * idle PCP pages.  And, avoid to free too many pages to
-	 * control latency.
+	 * Decrease pcp->high periodically to free idle PCP pages counted
+	 * via pcp->count_min.  And, avoid to free too many pages to
+	 * control latency.  This caps pcp->high decrement too.
 	 */
 	if (pcp->high > high_min) {
+		decrease = min(pcp->count_min, pcp->high / 5);
 		pcp->high = max3(pcp->count - (batch << PCP_BATCH_SCALE_MAX),
-				 pcp->high * 4 / 5, high_min);
+				 pcp->high - decrease, high_min);
 		if (pcp->high > high_min)
 			todo++;
 	}
@@ -2191,6 +2192,8 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 		todo++;
 	}
 
+	pcp->count_min = pcp->count;
+
 	return todo;
 }
 
@@ -2828,6 +2831,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		page = list_first_entry(list, struct page, pcp_list);
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
+		if (pcp->count < pcp->count_min)
+			pcp->count_min = pcp->count;
 	} while (check_new_pages(page, order));
 
 	return page;
-- 
2.39.2

