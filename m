Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6670277DB59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbjHPHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242504AbjHPHpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:45:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3550D2128
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692171943; x=1723707943;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0gLlCbmYzg2wy0DYbrdCzerQJcl5tvnMOc2/dPCa0ts=;
  b=h/0iq1ZmNkU6FSQkDidGPbkDZvjFkpvj4zhZAHiWiTK2Qev2PDE9ZEVB
   mjktPhippTPEF/6keAXSNCUQxcQjVF/+vlMqjFBO4ofPfbz7qY+8mFQnS
   hGOxeERdR3diJFz6DzVoQyrM8C89wtK1yrHk8aewaV1dL/iuON89wh6SU
   YCb0dQFDKvHHSZe4mW+X0s62eEZ51QpN91s5jWnLaoDgnGEOYinmHXLCB
   KW4pt+eMKeEIHBQ6ZiPmWC9vqzC2l7AIXPy7zuYyjc8NxlBV9PE9JfEMO
   /Z6ntliCWXHb1OahA+tX3c9dsQwzRPr1InSVSjdghU+euIFYfhGsRiOPO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375239253"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="375239253"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 00:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711029060"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="711029060"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 00:45:39 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Page batch allocation latency measurement and max batch scale
 discussion
Date:   Wed, 16 Aug 2023 15:44:02 +0800
Message-ID: <87fs4j77p9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,

In page allocator, PCP (Per-CPU Pageset) is refilled and drained in
batches to increase page allocation throughput, reduce page
allocation/freeing latency per page, and reduce zone lock contention.
But too large batch size will cause too long maximal
allocation/freeing latency, which may punish arbitrary users.  So the
default batch size is chosen carefully (in zone_batchsize(), the value
is 63 now) to avoid that.

In commit 3b12e7e97938 ("mm/page_alloc: scale the number of pages that
are batch freed"), the batch size will be scaled for large number of
page freeing to improve page freeing performance and reduce zone lock
contention.  Similar optimization are advised for large number of
pages allocation too in [1].

[1] https://lore.kernel.org/linux-mm/20230714140710.5xbesq6xguhcbyvi@techsingularity.net/

To find out a suitable max batch scale factor (that is, max effective
batch size), we have done some tests and measurement on some machines
as follows.

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


From the above data, it can be found that

- If the max batch size is 1023, the allocate/free latency at 99
  percentile will be less than 100 us

- If the max batch size is 2047, the allocate/free latency at 99
  percentile will be less than 100 us at most cases, but the max value
  can reach 140 us.

So, if we can accept 100 us latency at most, batch size 1023 or 2047
is acceptable.  This translates to batch scale factor 4 or 5.  If so,
we should restrict the max batch scale factor to be 4 or 5.

What do you think about this?  Do we need to collect more data?

--
Best Regards,
Huang, Ying
