Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514BD7CF876
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbjJSMNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjJSMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:13:06 -0400
Received: from outbound-smtp43.blacknight.com (outbound-smtp43.blacknight.com [46.22.139.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8AEBE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:13:03 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp43.blacknight.com (Postfix) with ESMTPS id 38B1A20BC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:13:02 +0100 (IST)
Received: (qmail 26744 invoked from network); 19 Oct 2023 12:13:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.199.31])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Oct 2023 12:13:01 -0000
Date:   Thu, 19 Oct 2023 13:12:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH -V3 4/9] mm: restrict the pcp batch scale factor to avoid
 too long latency
Message-ID: <20231019121258.52y5o7aaivyq2ex7@techsingularity.net>
References: <20231016053002.756205-1-ying.huang@intel.com>
 <20231016053002.756205-5-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231016053002.756205-5-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 01:29:57PM +0800, Huang Ying wrote:
> In page allocator, PCP (Per-CPU Pageset) is refilled and drained in
> batches to increase page allocation throughput, reduce page
> allocation/freeing latency per page, and reduce zone lock contention.
> But too large batch size will cause too long maximal
> allocation/freeing latency, which may punish arbitrary users.  So the
> default batch size is chosen carefully (in zone_batchsize(), the value
> is 63 for zone > 1GB) to avoid that.
> 
> In commit 3b12e7e97938 ("mm/page_alloc: scale the number of pages that
> are batch freed"), the batch size will be scaled for large number of
> page freeing to improve page freeing performance and reduce zone lock
> contention.  Similar optimization can be used for large number of
> pages allocation too.
> 
> To find out a suitable max batch scale factor (that is, max effective
> batch size), some tests and measurement on some machines were done as
> follows.
> 
> A set of debug patches are implemented as follows,
> 
> - Set PCP high to be 2 * batch to reduce the effect of PCP high
> 
> - Disable free batch size scaling to get the raw performance.
> 
> - The code with zone lock held is extracted from rmqueue_bulk() and
>   free_pcppages_bulk() to 2 separate functions to make it easy to
>   measure the function run time with ftrace function_graph tracer.
> 
> - The batch size is hard coded to be 63 (default), 127, 255, 511,
>   1023, 2047, 4095.
> 
> Then will-it-scale/page_fault1 is used to generate the page
> allocation/freeing workload.  The page allocation/freeing throughput
> (page/s) is measured via will-it-scale.  The page allocation/freeing
> average latency (alloc/free latency avg, in us) and allocation/freeing
> latency at 99 percentile (alloc/free latency 99%, in us) are measured
> with ftrace function_graph tracer.
> 
> The test results are as follows,
> 
> Sapphire Rapids Server
> ======================
> Batch	throughput	free latency	free latency	alloc latency	alloc latency
> 	page/s		avg / us	99% / us	avg / us	99% / us
> -----	----------	------------	------------	-------------	-------------
>   63	513633.4	 2.33		 3.57		 2.67		  6.83
>  127	517616.7	 4.35		 6.65		 4.22		 13.03
>  255	520822.8	 8.29		13.32		 7.52		 25.24
>  511	524122.0	15.79		23.42		14.02		 49.35
> 1023	525980.5	30.25		44.19		25.36		 94.88
> 2047	526793.6	59.39		84.50		45.22		140.81
> 
> Ice Lake Server
> ===============
> Batch	throughput	free latency	free latency	alloc latency	alloc latency
> 	page/s		avg / us	99% / us	avg / us	99% / us
> -----	----------	------------	------------	-------------	-------------
>   63	620210.3	 2.21		 3.68		 2.02		 4.35
>  127	627003.0	 4.09		 6.86		 3.51		 8.28
>  255	630777.5	 7.70		13.50		 6.17		15.97
>  511	633651.5	14.85		22.62		11.66		31.08
> 1023	637071.1	28.55		42.02		20.81		54.36
> 2047	638089.7	56.54		84.06		39.28		91.68
> 
> Cascade Lake Server
> ===================
> Batch	throughput	free latency	free latency	alloc latency	alloc latency
> 	page/s		avg / us	99% / us	avg / us	99% / us
> -----	----------	------------	------------	-------------	-------------
>   63	404706.7	 3.29		  5.03		 3.53		  4.75
>  127	422475.2	 6.12		  9.09		 6.36		  8.76
>  255	411522.2	11.68		 16.97		10.90		 16.39
>  511	428124.1	22.54		 31.28		19.86		 32.25
> 1023	414718.4	43.39		 62.52		40.00		 66.33
> 2047	429848.7	86.64		120.34		71.14		106.08
> 
> Commet Lake Desktop
> ===================
> Batch	throughput	free latency	free latency	alloc latency	alloc latency
> 	page/s		avg / us	99% / us	avg / us	99% / us
> -----	----------	------------	------------	-------------	-------------
> 
>   63	795183.13	 2.18		 3.55		 2.03		 3.05
>  127	803067.85	 3.91		 6.56		 3.85		 5.52
>  255	812771.10	 7.35		10.80		 7.14		10.20
>  511	817723.48	14.17		27.54		13.43		30.31
> 1023	818870.19	27.72		40.10		27.89		46.28
> 
> Coffee Lake Desktop
> ===================
> Batch	throughput	free latency	free latency	alloc latency	alloc latency
> 	page/s		avg / us	99% / us	avg / us	99% / us
> -----	----------	------------	------------	-------------	-------------
>   63	510542.8	 3.13		  4.40		 2.48		 3.43
>  127	514288.6	 5.97		  7.89		 4.65		 6.04
>  255	516889.7	11.86		 15.58		 8.96		12.55
>  511	519802.4	23.10		 28.81		16.95		26.19
> 1023	520802.7	45.30		 52.51		33.19		45.95
> 2047	519997.1	90.63		104.00		65.26		81.74
> 
> From the above data, to restrict the allocation/freeing latency to be
> less than 100 us in most times, the max batch scale factor needs to be
> less than or equal to 5.
> 
> Although it is reasonable to use 5 as max batch scale factor for the
> systems tested, there are also slower systems.  Where smaller value
> should be used to constrain the page allocation/freeing latency.
> 
> So, in this patch, a new kconfig option (PCP_BATCH_SCALE_MAX) is added
> to set the max batch scale factor.  Whose default value is 5, and
> users can reduce it when necessary.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
