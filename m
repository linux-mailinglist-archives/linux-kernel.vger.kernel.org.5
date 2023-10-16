Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926387C9EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjJPFar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjJPFah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:30:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14448EE
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697434235; x=1728970235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytDVYvVFNAmjdqNi25Zm1lNN8RkWeXmK0Rkw6kLWu9Y=;
  b=SN67oHpKnwc4LI0KTihDYKl8lfWW9ULPB9Rj+H3wZmT9DjJxODm+WciD
   TTyd89FTVt2ofqCkgYiyVhzHJRn48VsGAOcFLmonG6DYtODwGOe2XBa7c
   xnN1EjzGoMPGuO7Q53bLSnnesGwQl7VTng0xEsTxKKD1dtcvZvNoDJKWP
   w7zEsQ/ZIjQ6yDUL7/rf1BmAp2wDuM+QGN/6p+IvU+oot83GrKK0RjzXF
   P9q1Xx1akSyeuezoqYPkYihsOItkgvOHYDivInzi7V7sv98mxztxTMkkf
   OfIZlEoDN48w3JOXtB+P1UBxylmsPXIliXUH7LX5P6BN/D7aDEh6D4raq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389308016"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="389308016"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899356691"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899356691"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:28:33 -0700
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
Subject: [PATCH -V3 4/9] mm: restrict the pcp batch scale factor to avoid too long latency
Date:   Mon, 16 Oct 2023 13:29:57 +0800
Message-Id: <20231016053002.756205-5-ying.huang@intel.com>
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

Although it is reasonable to use 5 as max batch scale factor for the
systems tested, there are also slower systems.  Where smaller value
should be used to constrain the page allocation/freeing latency.

So, in this patch, a new kconfig option (PCP_BATCH_SCALE_MAX) is added
to set the max batch scale factor.  Whose default value is 5, and
users can reduce it when necessary.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
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
 mm/Kconfig      | 11 +++++++++++
 mm/page_alloc.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 264a2df5ecf5..ece4f2847e2b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -704,6 +704,17 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
+config PCP_BATCH_SCALE_MAX
+	int "Maximum scale factor of PCP (Per-CPU pageset) batch allocate/free"
+	default 5
+	range 0 6
+	help
+	  In page allocator, PCP (Per-CPU pageset) is refilled and drained in
+	  batches.  The batch number is scaled automatically to improve page
+	  allocation/free throughput.  But too large scale factor may hurt
+	  latency.  This option sets the upper limit of scale factor to limit
+	  the maximum latency.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ba2d8f06523e..a5a5a4c3cd2b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2340,7 +2340,7 @@ static int nr_pcp_free(struct per_cpu_pages *pcp, int high, bool free_high)
 	 * freeing of pages without any allocation.
 	 */
 	batch <<= pcp->free_factor;
-	if (batch < max_nr_free)
+	if (batch < max_nr_free && pcp->free_factor < CONFIG_PCP_BATCH_SCALE_MAX)
 		pcp->free_factor++;
 	batch = clamp(batch, min_nr_free, max_nr_free);
 
-- 
2.39.2

