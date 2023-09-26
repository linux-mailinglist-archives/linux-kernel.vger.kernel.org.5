Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5177AE58B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjIZGKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjIZGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:09:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811E310E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708583; x=1727244583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XuWRBp7awNhgI2gxGvdBoVlgeQn1EFxLB/yFfQ9Zo1k=;
  b=i/KlUGvVVDuW94LW+gJBQP0CFY1ui215I1Pj20kVlXujUFk8oXWl7tSo
   znB2+6YdO3qeD2SaOVByQLMpPRNlU0e0GFKKYeADvC/byTaheUIpRTCUj
   s9buj8QTFkNwiszguVvPf1YsJR5gy1HK6TV5ewpRVmOr81YOBPTPdBr4P
   mvztanv8Jstbma7L3K05DBwXhq1ufBJs1pSXpI3Gw82nMTrG4G01aFjeF
   d8MR1w+n5CdT/1WYLRUU1xIJgaWqWqyri/6b8m37ktU9Ezfd7ac9N36ms
   nTP29MnyxZ/bK/0BExSD+JIE2s6IuyjIzP/JF9LB2B5SkHJqLE9ltLekN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447991335"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447991335"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892075894"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892075894"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:08:34 -0700
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
Subject: [PATCH -V2 04/10] mm: restrict the pcp batch scale factor to avoid too long latency
Date:   Tue, 26 Sep 2023 14:09:05 +0800
Message-Id: <20230926060911.266511-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926060911.266511-1-ying.huang@intel.com>
References: <20230926060911.266511-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In page allocator, PCP (Per-CPU Pageset) is refilled and drained in
batches to increase page allocation throughput, reduce page
allocation/freeing latency per page, and reduce zone lock contention.
But too large batch size will cause too long maximal
allocation/freeing latency, which may punish arbitrary users.  So the
default batch size is chosen carefully (in zone_batchsize(), the value
is 63 for zone > 1GB) to avoid that.

In commit 3b12e7e97938 ("mm/page_alloc: scale the number of pages that
are batch freed"), the batch size will be scaled for large number of
page freeing to improve page freeing performance and reduce zone lock
contention.  Similar optimization can be used for large number of
pages allocation too.

To find out a suitable max batch scale factor (that is, max effective
batch size), some tests and measurement on some machines were done as
follows.

A set of debug patches are implemented as follows,

- Set PCP high to be 2 * batch to reduce the effect of PCP high

- Disable free batch size scaling to get the raw performance.

- The code with zone lock held is extracted from rmqueue_bulk() and
  free_pcppages_bulk() to 2 separate functions to make it easy to
  measure the function run time with ftrace function_graph tracer.

- The batch size is hard coded to be 63 (default), 127, 255, 511,
  1023, 2047, 4095.

Then will-it-scale/page_fault1 is used to generate the page
allocation/freeing workload.  The page allocation/freeing throughput
(page/s) is measured via will-it-scale.  The page allocation/freeing
average latency (alloc/free latency avg, in us) and allocation/freeing
latency at 99 percentile (alloc/free latency 99%, in us) are measured
with ftrace function_graph tracer.

The test results are as follows,

Sapphire Rapids Server
======================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	513633.4	 2.33		 3.57		 2.67		  6.83
 127	517616.7	 4.35		 6.65		 4.22		 13.03
 255	520822.8	 8.29		13.32		 7.52		 25.24
 511	524122.0	15.79		23.42		14.02		 49.35
1023	525980.5	30.25		44.19		25.36		 94.88
2047	526793.6	59.39		84.50		45.22		140.81

Ice Lake Server
===============
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	620210.3	 2.21		 3.68		 2.02		 4.35
 127	627003.0	 4.09		 6.86		 3.51		 8.28
 255	630777.5	 7.70		13.50		 6.17		15.97
 511	633651.5	14.85		22.62		11.66		31.08
1023	637071.1	28.55		42.02		20.81		54.36
2047	638089.7	56.54		84.06		39.28		91.68

Cascade Lake Server
===================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	404706.7	 3.29		  5.03		 3.53		  4.75
 127	422475.2	 6.12		  9.09		 6.36		  8.76
 255	411522.2	11.68		 16.97		10.90		 16.39
 511	428124.1	22.54		 31.28		19.86		 32.25
1023	414718.4	43.39		 62.52		40.00		 66.33
2047	429848.7	86.64		120.34		71.14		106.08

Commet Lake Desktop
===================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------

  63	795183.13	 2.18		 3.55		 2.03		 3.05
 127	803067.85	 3.91		 6.56		 3.85		 5.52
 255	812771.10	 7.35		10.80		 7.14		10.20
 511	817723.48	14.17		27.54		13.43		30.31
1023	818870.19	27.72		40.10		27.89		46.28

Coffee Lake Desktop
===================
Batch	throughput	free latency	free latency	alloc latency	alloc latency
	page/s		avg / us	99% / us	avg / us	99% / us
-----	----------	------------	------------	-------------	-------------
  63	510542.8	 3.13		  4.40		 2.48		 3.43
 127	514288.6	 5.97		  7.89		 4.65		 6.04
 255	516889.7	11.86		 15.58		 8.96		12.55
 511	519802.4	23.10		 28.81		16.95		26.19
1023	520802.7	45.30		 52.51		33.19		45.95
2047	519997.1	90.63		104.00		65.26		81.74

From the above data, to restrict the allocation/freeing latency to be
less than 100 us in most times, the max batch scale factor needs to be
less than or equal to 5.

So, in this patch, the batch scale factor is restricted to be less
than or equal to 5.

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
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e97814985710..4b601f505401 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -86,6 +86,9 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
 
+/* Maximum PCP batch scale factor to restrict max allocation/freeing latency */
+#define PCP_BATCH_SCALE_MAX	5
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -2340,7 +2343,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
 	 * freeing of pages without any allocation.
 	 */
 	batch <<= pcp->free_factor;
-	if (batch < max_nr_free)
+	if (batch < max_nr_free && pcp->free_factor < PCP_BATCH_SCALE_MAX)
 		pcp->free_factor++;
 	batch = clamp(batch, min_nr_free, max_nr_free);
 
-- 
2.39.2

