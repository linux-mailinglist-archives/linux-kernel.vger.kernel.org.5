Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89017C6DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378475AbjJLMRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347221AbjJLMRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:17:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDDB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697113069; x=1728649069;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=TsWwp6y4lxASPuSdg0tEU4cS1WQ994qMPTC91I8n58M=;
  b=gcPiTjb9rf1xQ+7lnsRGphcM/o+ZpoaX1i155IgwgZfj17bCLtyiA/tQ
   pXul+hYruE3Ws/M7gzqp7ZEAbp/H46vsAXqfFm2bu5umUjNI1PGvj7eFH
   kztA+4bgc9Tq1DciqggNsl7kzd3sedIl06R/Kk5EJ4bZDAixI7IvP2NvT
   a30TTNnzRG+ckyOYaU7+Cu4IJ05hhQHASBFhL/sUTAwPpEKkxrvpYaxAB
   D+wOS6m0Xofgf8lsnov5MAFp4WY3m0ANygwd0rJoERcveeG1Rn69JGALr
   25lLyg0UCHo1vyekP99LUdFIiiQuTzXgTs/HvElXjKTSfYNfoKyyK8qWs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="382139887"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="382139887"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="844977593"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="844977593"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:17:45 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Christoph Lameter" <cl@linux.com>
Subject: Re: [PATCH 04/10] mm: restrict the pcp batch scale factor to avoid
 too long latency
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-5-ying.huang@intel.com>
        <20231011125219.kuoluyuwxzva5q5w@techsingularity.net>
Date:   Thu, 12 Oct 2023 20:15:42 +0800
In-Reply-To: <20231011125219.kuoluyuwxzva5q5w@techsingularity.net> (Mel
        Gorman's message of "Wed, 11 Oct 2023 13:52:19 +0100")
Message-ID: <878r88f34h.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Wed, Sep 20, 2023 at 02:18:50PM +0800, Huang Ying wrote:
>> In page allocator, PCP (Per-CPU Pageset) is refilled and drained in
>> batches to increase page allocation throughput, reduce page
>> allocation/freeing latency per page, and reduce zone lock contention.
>> But too large batch size will cause too long maximal
>> allocation/freeing latency, which may punish arbitrary users.  So the
>> default batch size is chosen carefully (in zone_batchsize(), the value
>> is 63 for zone > 1GB) to avoid that.
>> 
>> In commit 3b12e7e97938 ("mm/page_alloc: scale the number of pages that
>> are batch freed"), the batch size will be scaled for large number of
>> page freeing to improve page freeing performance and reduce zone lock
>> contention.  Similar optimization can be used for large number of
>> pages allocation too.
>> 
>> To find out a suitable max batch scale factor (that is, max effective
>> batch size), some tests and measurement on some machines were done as
>> follows.
>> 
>> A set of debug patches are implemented as follows,
>> 
>> - Set PCP high to be 2 * batch to reduce the effect of PCP high
>> 
>> - Disable free batch size scaling to get the raw performance.
>> 
>> - The code with zone lock held is extracted from rmqueue_bulk() and
>>   free_pcppages_bulk() to 2 separate functions to make it easy to
>>   measure the function run time with ftrace function_graph tracer.
>> 
>> - The batch size is hard coded to be 63 (default), 127, 255, 511,
>>   1023, 2047, 4095.
>> 
>> Then will-it-scale/page_fault1 is used to generate the page
>> allocation/freeing workload.  The page allocation/freeing throughput
>> (page/s) is measured via will-it-scale.  The page allocation/freeing
>> average latency (alloc/free latency avg, in us) and allocation/freeing
>> latency at 99 percentile (alloc/free latency 99%, in us) are measured
>> with ftrace function_graph tracer.
>> 
>> The test results are as follows,
>> 
>> Sapphire Rapids Server
>> ======================
>> Batch	throughput	free latency	free latency	alloc latency	alloc latency
>> 	page/s		avg / us	99% / us	avg / us	99% / us
>> -----	----------	------------	------------	-------------	-------------
>>   63	513633.4	 2.33		 3.57		 2.67		  6.83
>>  127	517616.7	 4.35		 6.65		 4.22		 13.03
>>  255	520822.8	 8.29		13.32		 7.52		 25.24
>>  511	524122.0	15.79		23.42		14.02		 49.35
>> 1023	525980.5	30.25		44.19		25.36		 94.88
>> 2047	526793.6	59.39		84.50		45.22		140.81
>> 
>> Ice Lake Server
>> ===============
>> Batch	throughput	free latency	free latency	alloc latency	alloc latency
>> 	page/s		avg / us	99% / us	avg / us	99% / us
>> -----	----------	------------	------------	-------------	-------------
>>   63	620210.3	 2.21		 3.68		 2.02		 4.35
>>  127	627003.0	 4.09		 6.86		 3.51		 8.28
>>  255	630777.5	 7.70		13.50		 6.17		15.97
>>  511	633651.5	14.85		22.62		11.66		31.08
>> 1023	637071.1	28.55		42.02		20.81		54.36
>> 2047	638089.7	56.54		84.06		39.28		91.68
>> 
>> Cascade Lake Server
>> ===================
>> Batch	throughput	free latency	free latency	alloc latency	alloc latency
>> 	page/s		avg / us	99% / us	avg / us	99% / us
>> -----	----------	------------	------------	-------------	-------------
>>   63	404706.7	 3.29		  5.03		 3.53		  4.75
>>  127	422475.2	 6.12		  9.09		 6.36		  8.76
>>  255	411522.2	11.68		 16.97		10.90		 16.39
>>  511	428124.1	22.54		 31.28		19.86		 32.25
>> 1023	414718.4	43.39		 62.52		40.00		 66.33
>> 2047	429848.7	86.64		120.34		71.14		106.08
>> 
>> Commet Lake Desktop
>> ===================
>> Batch	throughput	free latency	free latency	alloc latency	alloc latency
>> 	page/s		avg / us	99% / us	avg / us	99% / us
>> -----	----------	------------	------------	-------------	-------------
>> 
>>   63	795183.13	 2.18		 3.55		 2.03		 3.05
>>  127	803067.85	 3.91		 6.56		 3.85		 5.52
>>  255	812771.10	 7.35		10.80		 7.14		10.20
>>  511	817723.48	14.17		27.54		13.43		30.31
>> 1023	818870.19	27.72		40.10		27.89		46.28
>> 
>> Coffee Lake Desktop
>> ===================
>> Batch	throughput	free latency	free latency	alloc latency	alloc latency
>> 	page/s		avg / us	99% / us	avg / us	99% / us
>> -----	----------	------------	------------	-------------	-------------
>>   63	510542.8	 3.13		  4.40		 2.48		 3.43
>>  127	514288.6	 5.97		  7.89		 4.65		 6.04
>>  255	516889.7	11.86		 15.58		 8.96		12.55
>>  511	519802.4	23.10		 28.81		16.95		26.19
>> 1023	520802.7	45.30		 52.51		33.19		45.95
>> 2047	519997.1	90.63		104.00		65.26		81.74
>> 
>> From the above data, to restrict the allocation/freeing latency to be
>> less than 100 us in most times, the max batch scale factor needs to be
>> less than or equal to 5.
>> 
>> So, in this patch, the batch scale factor is restricted to be less
>> than or equal to 5.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>
> However, it's worth noting that the time to free depends on the CPU and
> while the CPUs you tested are reasonable, there are also slower CPUs out
> there and I've at least one account that the time is excessive. While
> this patch is fine, there may be a patch on top that makes this runtime
> configurable, a Kconfig default or both.

Sure.  Will add a Kconfig option first in a follow-on patch.

--
Best Regards,
Huang, Ying
