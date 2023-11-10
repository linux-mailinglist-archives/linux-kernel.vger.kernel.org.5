Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769977E7E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjKJRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjKJRnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084AA7AAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699598492; x=1731134492;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qX+PU4tzyzOQ2/Q80/XRzxTEAv2/ABl2VsarYdLMBrU=;
  b=DG8koIpLm55SqQNkkIrlWUfkqWC1w1RzfeFRU8FzW0reuuTweLrt+Oie
   ourWSkt8kwY7zkfAeVsYTxMrs1yM6qpGUUoKHcGyS7p7kxN1C99A8iV3c
   CtFOQ2xY7nr0GTZI5fsAjtxMrKngPgcKgloDAqTKEPFC3Ok7gZhukxuBM
   ww1P+PHelHRX8cqMgarkYEgwwd7VU1CbSQFR9xITfwM02NK1fATb+O59P
   SUnjIz/uTfAfRpF4Gh8IBHyJPqEZCmjo5PVyMIzX+65JvHzv4IbwV/U/k
   s4mXmMIXNaBPFaqD45IzZY2WDQP4QZXWFX+wqAsgkIwDwGF68jiPaD5sw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="369466962"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="369466962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 21:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="937085005"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="937085005"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 21:34:16 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        lstoakes@gmail.com, hughd@google.com, david@redhat.com,
        fengwei.yin@intel.com, vbabka@suse.cz, peterz@infradead.org,
        mgorman@suse.de, mingo@redhat.com, riel@redhat.com,
        hannes@cmpxchg.org, Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [Question]: major faults are still triggered after mlockall
 when numa balancing
In-Reply-To: <ZU0WkMR1s7QNG9RZ@casper.infradead.org> (Matthew Wilcox's message
        of "Thu, 9 Nov 2023 17:27:44 +0000")
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
        <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
Date:   Fri, 10 Nov 2023 13:32:15 +0800
Message-ID: <874jhugom8.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
>> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
>> ptep_modify_prot_start() will clear the vmf->pte, until
>> ptep_modify_prot_commit() assign a value to the vmf->pte.
>
> [...]
>
>> Our problem scenario is as follows:
>> 
>> task 1                      task 2
>> ------                      ------
>> /* scan global variables */
>> do_numa_page()
>>   spin_lock(vmf->ptl)
>>   ptep_modify_prot_start()
>>   /* set vmf->pte as null */
>>                             /* Access global variables */
>>                             handle_pte_fault()
>>                               /* no pte lock */
>>                               do_pte_missing()
>>                                 do_fault()
>>                                   do_read_fault()
>>   ptep_modify_prot_commit()
>>   /* ptep update done */
>>   pte_unmap_unlock(vmf->pte, vmf->ptl)
>>                                     do_fault_around()
>>                                     __do_fault()
>>                                       filemap_fault()
>>                                         /* page cache is not available
>>                                         and a major fault is triggered */
>>                                         do_sync_mmap_readahead()
>>                                         /* page_not_uptodate and goto
>>                                         out_retry. */
>> 
>> Is there any way to avoid such a major fault?
>
> Yes, this looks like a bug.
>
> It seems to me that the easiest way to fix this is not to zero the pte
> but to make it protnone?  That would send task 2 into do_numa_page()
> where it would take the ptl, then check pte_same(), see that it's
> changed and goto out, which will end up retrying the fault.

There are other places in the kernel where the PTE is cleared, for
example, move_ptes() in mremap.c.  IIUC, we need to audit all them.

Another possible solution is to check PTE again with PTL held before
reading in file data.  This will increase the overhead of major fault
path.  Is it acceptable?

> I'm not particularly expert at page table manipulation, so I'll let
> somebody who is propose an actual patch.  Or you could try to do it?

--
Best Regards,
Huang, Ying
