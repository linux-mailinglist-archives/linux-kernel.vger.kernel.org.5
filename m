Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C37F6CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjKXH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXH1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:27:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1645D6E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:27:29 -0800 (PST)
Received: from kwepemm000020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sc60q1xMqzsRRS;
        Fri, 24 Nov 2023 15:23:55 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm000020.china.huawei.com (7.193.23.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 15:27:26 +0800
Message-ID: <a4b53c04-681c-4cc0-07f1-db3fc702f8d1@huawei.com>
Date:   Fri, 24 Nov 2023 15:27:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Yin Fengwei <fengwei.yin@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
 <f4dba5b5-2e6e-4c5a-a269-4abe8fe2bcd8@intel.com>
 <b0d869e4-108b-8ffe-e9f7-65c4d98f2bf8@huawei.com>
 <801bd0c9-7d0c-4231-93e5-7532e8231756@intel.com>
 <48235d73-3dc6-263d-7822-6d479b753d46@huawei.com>
 <87y1en7pq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87ttpb7p4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <87ttpb7p4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000020.china.huawei.com (7.193.23.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/24 12:26, Huang, Ying wrote:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>
>>> On 2023/11/23 13:26, Yin Fengwei wrote:
>>>
>>>> On 11/23/23 12:12, zhangpeng (AS) wrote:
>>>>> On 2023/11/23 9:09, Yin Fengwei wrote:
>>>>>
>>>>>> Hi Peng,
>>>>>>
>>>>>> On 11/22/23 22:00, Peng Zhang wrote:
>>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>
>>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>>>>> in application, which leading to an unexpected performance issue[1].
>>>>>>>
>>>>>>> This caused by temporarily cleared pte during a read/modify/write update
>>>>>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>>>>>
>>>>>>> For the data segment of the user-mode program, the global variable area
>>>>>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>>>>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>>>>>> (anonymous pages), but the original file pages cannot be locked and may
>>>>>>> be reclaimed. If the global variable (private anon page) is accessed when
>>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>>>>
>>>>>>> At this time, the original private file page may have been reclaimed.
>>>>>>> If the page cache is not available at this time, a major fault will be
>>>>>>> triggered and the file will be read, causing additional overhead.
>>>>>>>
>>>>>>> Fix this by rechecking the pte by holding ptl in filemap_fault() before
>>>>>>> triggering a major fault.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>>>>>
>>>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>> ---
>>>>>>>     mm/filemap.c | 14 ++++++++++++++
>>>>>>>     1 file changed, 14 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>>>> index 71f00539ac00..bb5e6a2790dc 100644
>>>>>>> --- a/mm/filemap.c
>>>>>>> +++ b/mm/filemap.c
>>>>>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>>>>                 mapping_locked = true;
>>>>>>>             }
>>>>>>>         } else {
>>>>>>> +        pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>>>>> +                          vmf->address, &vmf->ptl);
>>>>>>> +        if (ptep) {
>>>>>>> +            /*
>>>>>>> +             * Recheck pte with ptl locked as the pte can be cleared
>>>>>>> +             * temporarily during a read/modify/write update.
>>>>>>> +             */
>>>>>>> +            if (unlikely(!pte_none(ptep_get(ptep))))
>>>>>>> +                ret = VM_FAULT_NOPAGE;
>>>>>>> +            pte_unmap_unlock(ptep, vmf->ptl);
>>>>>>> +            if (unlikely(ret))
>>>>>>> +                return ret;
>>>>>>> +        }
>>>>>> I am curious. Did you try not to take PTL here and just check whether PTE is not NONE?
>>>>> Thank you for your reply.
>>>>>
>>>>> If we don't take PTL, the current use case won't trigger this issue either.
>>>> Is this verified by testing or just in theory?
>>> If we add a delay between ptep_modify_prot_start() and ptep_modify_prot_commit(),
>>> this issue will also trigger. Without delay, we haven't reproduced this problem
>>> so far.
>>>
>>>>> In most cases, if we don't take PTL, this issue won't be triggered. However,
>>>>> there is still a possibility of triggering this issue. The corner case is that
>>>>> task 2 triggers a page fault when task 1 is between ptep_modify_prot_start()
>>>>> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,task 2 passes the
>>>>> check whether the PTE is not NONE before task 1 updates PTE in
>>>>> ptep_modify_prot_commit() without taking PTL.
>>>> There is very limited operations between ptep_modify_prot_start() and
>>>> ptep_modify_prot_commit(). While the code path from page fault to this check is
>>>> long. My understanding is it's very likely the PTE is not NONE when do PTE check
>>>> here without hold PTL (This is my theory. :)).
>>> Yes, there is a high probability that this issue won't occur without taking PTL.
>>>
>>>> In the other side, acquiring/releasing PTL may bring performance impaction. It may
>>>> not be big deal because the IO operations in this code path. But it's better to
>>>> collect some performance data IMHO.
>>> We tested the performance of file private mapping page fault (page_fault2.c of
>>> will-it-scale [1]) and file shared mapping page fault (page_fault3.c of will-it-scale).
>>> The difference in performance (in operations per second) before and after patch
>>> applied is about 0.7% on a x86 physical machine.
>> Whether is it improvement or reduction?
> And I think that you need to test ramdisk cases too to verify whether
> this will cause performance regression and how much.

Yes, I will.
In addition, are there any ramdisk test cases recommended? 😁

> --
> Best Regards,
> Huang, Ying
>
>> --
>> Best Regards,
>> Huang, Ying
>>
>>> [1] https://github.com/antonblanchard/will-it-scale/tree/master
>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>> Regards
>>>>>> Yin, Fengwei
>>>>>>
>>>>>>> +
>>>>>>>             /* No page in the page cache at all */
>>>>>>>             count_vm_event(PGMAJFAULT);
>>>>>>>             count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

-- 
Best Regards,
Peng

