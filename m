Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCB17E7FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjKJSBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjKJR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE824C1E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:39:48 -0800 (PST)
Received: from kwepemm000020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SRYZp6VHgzMmgh;
        Fri, 10 Nov 2023 17:35:14 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm000020.china.huawei.com (7.193.23.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 17:39:44 +0800
Message-ID: <dadffb1c-4491-b242-5568-b661e32cca1f@huawei.com>
Date:   Fri, 10 Nov 2023 17:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <lstoakes@gmail.com>,
        <hughd@google.com>, <david@redhat.com>, <fengwei.yin@intel.com>,
        <vbabka@suse.cz>, <peterz@infradead.org>, <mgorman@suse.de>,
        <mingo@redhat.com>, <riel@redhat.com>, <ying.huang@intel.com>,
        <hannes@cmpxchg.org>, Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000020.china.huawei.com (7.193.23.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/10 1:27, Matthew Wilcox wrote:

> On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
>> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
>> ptep_modify_prot_start() will clear the vmf->pte, until
>> ptep_modify_prot_commit() assign a value to the vmf->pte.
> [...]
>
>> Our problem scenario is as follows:
>>
>> task 1                      task 2
>> ------                      ------
>> /* scan global variables */
>> do_numa_page()
>>    spin_lock(vmf->ptl)
>>    ptep_modify_prot_start()
>>    /* set vmf->pte as null */
>>                              /* Access global variables */
>>                              handle_pte_fault()
>>                                /* no pte lock */
>>                                do_pte_missing()
>>                                  do_fault()
>>                                    do_read_fault()
>>    ptep_modify_prot_commit()
>>    /* ptep update done */
>>    pte_unmap_unlock(vmf->pte, vmf->ptl)
>>                                      do_fault_around()
>>                                      __do_fault()
>>                                        filemap_fault()
>>                                          /* page cache is not available
>>                                          and a major fault is triggered */
>>                                          do_sync_mmap_readahead()
>>                                          /* page_not_uptodate and goto
>>                                          out_retry. */
>>
>> Is there any way to avoid such a major fault?
> Yes, this looks like a bug.
>
> It seems to me that the easiest way to fix this is not to zero the pte
> but to make it protnone?  That would send task 2 into do_numa_page()
> where it would take the ptl, then check pte_same(), see that it's
> changed and goto out, which will end up retrying the fault.
>
> I'm not particularly expert at page table manipulation, so I'll let
> somebody who is propose an actual patch.  Or you could try to do it?

Thank you for your reply.
Sorry, I'm not particularly good at page table related manipulation
either. It would be great if somebody who are better at this part could
help solve it.

-- 
Best Regards,
Peng

