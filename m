Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33F7E9460
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjKMCEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:04:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048281727
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699841076; x=1731377076;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uhCzrhUih1kdqliJvzI4rlufC8mvCxq1FIYTIy906zE=;
  b=A2DkHJZfsy4dV/sESUCWDcjcIrIb3siMwiQcEGyysDeg4wFanxf/w4D7
   u4CVavxCRs5RaxIXWkn3NUSxpSMohZGTPtwjc+jmnZCBtrDiel2S0aVSK
   4CaygccPti8sn+mIw9I4szgwKRrGUF7v5gJOyYrEbqtHLOeE9wReQfnC7
   muU2xuCF46u4fhyiFGIwXlDalDn2xjuhH1f6+zbq1L7Y9taI4zFx8WHco
   OEfMIRZHYX/jsZiDrBFBH55BcdvJ7qU7SnHyZC+/IT9osmSXqnd+eMsTa
   g8CJcckPIGGCvXFpK9FZk7wU32eeEukS40HSyI6o9d85F53k56qnP7xWw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="11915610"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="11915610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 18:04:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="834603249"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="834603249"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 18:04:31 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <lstoakes@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <peterz@infradead.org>, <mgorman@suse.de>,
        <mingo@redhat.com>, <riel@redhat.com>, <hannes@cmpxchg.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [Question]: major faults are still triggered after mlockall
 when numa balancing
In-Reply-To: <2c95d0d0-a708-436f-a9d9-4b3d90eafb16@intel.com> (Fengwei Yin's
        message of "Fri, 10 Nov 2023 17:04:26 +0800")
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
        <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
        <874jhugom8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2c95d0d0-a708-436f-a9d9-4b3d90eafb16@intel.com>
Date:   Mon, 13 Nov 2023 10:02:30 +0800
Message-ID: <87r0kufm15.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Yin, Fengwei" <fengwei.yin@intel.com> writes:

> On 11/10/2023 1:32 PM, Huang, Ying wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>>> On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
>>>> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
>>>> ptep_modify_prot_start() will clear the vmf->pte, until
>>>> ptep_modify_prot_commit() assign a value to the vmf->pte.
>>>
>>> [...]
>>>
>>>> Our problem scenario is as follows:
>>>>
>>>> task 1                      task 2
>>>> ------                      ------
>>>> /* scan global variables */
>>>> do_numa_page()
>>>>   spin_lock(vmf->ptl)
>>>>   ptep_modify_prot_start()
>>>>   /* set vmf->pte as null */
>>>>                             /* Access global variables */
>>>>                             handle_pte_fault()
>>>>                               /* no pte lock */
>>>>                               do_pte_missing()
>>>>                                 do_fault()
>>>>                                   do_read_fault()
>>>>   ptep_modify_prot_commit()
>>>>   /* ptep update done */
>>>>   pte_unmap_unlock(vmf->pte, vmf->ptl)
>>>>                                     do_fault_around()
>>>>                                     __do_fault()
>>>>                                       filemap_fault()
>>>>                                         /* page cache is not available
>>>>                                         and a major fault is triggered */
>>>>                                         do_sync_mmap_readahead()
>>>>                                         /* page_not_uptodate and goto
>>>>                                         out_retry. */
>>>>
>>>> Is there any way to avoid such a major fault?
>>>
>>> Yes, this looks like a bug.
>>>
>>> It seems to me that the easiest way to fix this is not to zero the pte
>>> but to make it protnone?  That would send task 2 into do_numa_page()
>>> where it would take the ptl, then check pte_same(), see that it's
>>> changed and goto out, which will end up retrying the fault.
>> 
>> There are other places in the kernel where the PTE is cleared, for
>> example, move_ptes() in mremap.c.  IIUC, we need to audit all them.
>> 
>> Another possible solution is to check PTE again with PTL held before
>> reading in file data.  This will increase the overhead of major fault
>> path.  Is it acceptable?
> What if we check the PTE without page table lock acquired?

The PTE is zeroed temporarily only with PTL held.  So, if we acquire the
PTL in filemap_fault() and check the PTE, the PTE which is zeroed in
do_numa_page() will be non-zero now.  So we can avoid the major fault.

But, if we don't acquire the PTL, the PTE may still be zero.

--
Best Regards,
Huang, Ying

> Regards
> Yin, Fengwei
>
>> 
>>> I'm not particularly expert at page table manipulation, so I'll let
>>> somebody who is propose an actual patch.  Or you could try to do it?
>> 
>> --
>> Best Regards,
>> Huang, Ying
