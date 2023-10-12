Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54317C6DED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378555AbjJLMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjJLMXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:23:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE2EBA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697113394; x=1728649394;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=7uKE27R2y/wLv51v6eEem7rTHjDlCCUWdaUVwm5Xme4=;
  b=EzJFmJYSd+rUbguFmV9UnBX3ETBZPn0Sz7j35Vrwavuaps3uQOekhcfS
   RWGOSuQv49LIwXIjnnaAe+KUp6mDS3ecI0/FiUOzkdpJOp9HLmuJEzQFI
   k8y7mhcpqn4t2UNdE8zvFq3LqAn0Cq1qo2AcFPVeVEmNCqKFYLenGOboe
   5AXAWy1/wBcF7I0R43+yPd+W7GX/iGtt8XcLTCFuowJTwFOJ/jjGPptws
   R2oi5ygsK2aSx/oZYnJ/j9KGwdA7Ui41g0MBFMTDDMpuq5LigSyh84jN6
   OBMbzaCDtvvcZrhhxNur0qmFSxoMjxSGZltNHve7rC710jHLuSmL2fUyn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="369972087"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="369972087"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754226968"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="754226968"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 05:23:10 -0700
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
Subject: Re: [PATCH 01/10] mm, pcp: avoid to drain PCP when process exit
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-2-ying.huang@intel.com>
        <20231011124610.4punxroovolyvmgr@techsingularity.net>
Date:   Thu, 12 Oct 2023 20:21:06 +0800
In-Reply-To: <20231011124610.4punxroovolyvmgr@techsingularity.net> (Mel
        Gorman's message of "Wed, 11 Oct 2023 13:46:10 +0100")
Message-ID: <87zg0odob1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Wed, Sep 20, 2023 at 02:18:47PM +0800, Huang Ying wrote:
>> In commit f26b3fa04611 ("mm/page_alloc: limit number of high-order
>> pages on PCP during bulk free"), the PCP (Per-CPU Pageset) will be
>> drained when PCP is mostly used for high-order pages freeing to
>> improve the cache-hot pages reusing between page allocation and
>> freeing CPUs.
>> 
>> But, the PCP draining mechanism may be triggered unexpectedly when
>> process exits.  With some customized trace point, it was found that
>> PCP draining (free_high == true) was triggered with the order-1 page
>> freeing with the following call stack,
>> 
>>  => free_unref_page_commit
>>  => free_unref_page
>>  => __mmdrop
>>  => exit_mm
>>  => do_exit
>>  => do_group_exit
>>  => __x64_sys_exit_group
>>  => do_syscall_64
>> 
>> Checking the source code, this is the page table PGD
>> freeing (mm_free_pgd()).  It's a order-1 page freeing if
>> CONFIG_PAGE_TABLE_ISOLATION=y.  Which is a common configuration for
>> security.
>> 
>> Just before that, page freeing with the following call stack was
>> found,
>> 
>>  => free_unref_page_commit
>>  => free_unref_page_list
>>  => release_pages
>>  => tlb_batch_pages_flush
>>  => tlb_finish_mmu
>>  => exit_mmap
>>  => __mmput
>>  => exit_mm
>>  => do_exit
>>  => do_group_exit
>>  => __x64_sys_exit_group
>>  => do_syscall_64
>> 
>> So, when a process exits,
>> 
>> - a large number of user pages of the process will be freed without
>>   page allocation, it's highly possible that pcp->free_factor becomes
>>   > 0.
>> 
>> - after freeing all user pages, the PGD will be freed, which is a
>>   order-1 page freeing, PCP will be drained.
>> 
>> All in all, when a process exits, it's high possible that the PCP will
>> be drained.  This is an unexpected behavior.
>> 
>> To avoid this, in the patch, the PCP draining will only be triggered
>> for 2 consecutive high-order page freeing.
>> 
>> On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
>> one socket with `make -j 112`.  With the patch, the build time
>> decreases 3.4% (from 206s to 199s).  The cycles% of the spinlock
>> contention (mostly for zone lock) decreases from 43.6% to 40.3% (with
>> PCP size == 361).  The number of PCP draining for high order pages
>> freeing (free_high) decreases 50.8%.
>> 
>> This helps network workload too for reduced zone lock contention.  On
>> a 2-socket Intel server with 128 logical CPU, with the patch, the
>> network bandwidth of the UNIX (AF_UNIX) test case of lmbench test
>> suite with 16-pair processes increase 17.1%.  The cycles% of the
>> spinlock contention (mostly for zone lock) decreases from 50.0% to
>> 45.8%.  The number of PCP draining for high order pages
>> freeing (free_high) decreases 27.4%.  The cache miss rate keeps 0.3%.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>
> However, I want to note that batching on exit is not necessarily
> unexpected. For processes that are multi-TB in size, the time to exit
> can actually be quite large and batching is of benefit but optimising
> for exit is rarely a winning strategy. The pattern of "all allocs on CPU
> B and all frees on CPU B" or "short-lived tasks triggering a premature
> drain" is a bit more compelling but not worth a changelog rewrite.
>> 
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 4106fbc5b4b3..64d5ed2bb724 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -676,12 +676,15 @@ enum zone_watermarks {
>>  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
>>  #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
>>  
>> +#define	PCPF_PREV_FREE_HIGH_ORDER	0x01
>> +
>
> The meaning of the flag and its intent should have been documented.

Sure.  Will add comments for the flags.

--
Best Regards,
Huang, Ying
