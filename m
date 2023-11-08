Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB407E4EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjKHBlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKHBlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:41:37 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D5129
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:41:35 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SQ7411xhZzMmgY;
        Wed,  8 Nov 2023 09:37:05 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 09:41:32 +0800
Message-ID: <9cb900f1-6b49-4160-adc2-cdeae1b00b17@huawei.com>
Date:   Wed, 8 Nov 2023 09:41:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mm: memory: use a folio in do_cow_page()
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-5-wangkefeng.wang@huawei.com>
 <ff007e3a-9951-bd6e-2780-e46e70321665@oracle.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ff007e3a-9951-bd6e-2780-e46e70321665@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/8 2:27, Sidhartha Kumar wrote:
> On 11/7/23 5:52 AM, Kefeng Wang wrote:
>> Use folio_prealloc() helper and convert to use a folio in
>> do_cow_page(), which save five compound_head() calls.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/memory.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 062136d25da3..5ecee3eac29d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4648,6 +4648,7 @@ static vm_fault_t do_read_fault(struct vm_fault 
>> *vmf)
>>   static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>>   {
>>       struct vm_area_struct *vma = vmf->vma;
>> +    struct folio *folio;
>>       vm_fault_t ret;
>>       ret = vmf_can_call_fault(vmf);
>> @@ -4656,16 +4657,11 @@ static vm_fault_t do_cow_fault(struct vm_fault 
>> *vmf)
>>       if (ret)
>>           return ret;
>> -    vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, 
>> vmf->address);
>> -    if (!vmf->cow_page)
>> +    folio = folio_prealloc(vma->vm_mm, vma, vmf->address, false);
>> +    if (!folio)
>>           return VM_FAULT_OOM;
>> -    if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
>> -                GFP_KERNEL)) {
>> -        put_page(vmf->cow_page);
>> -        return VM_FAULT_OOM;
>> -    }
>> -    folio_throttle_swaprate(page_folio(vmf->cow_page), GFP_KERNEL);
> 
> Hi Kefeng,
> 
> I was wondering why this block of code is no longer needed after using a 
> folio?

folio_prealloc(previous page_copy_prealloc) already with above code.

> 
> Thanks,
> Sidhartha Kumar
> 
>> +    vmf->cow_page = &folio->page;
>>       ret = __do_fault(vmf);
>>       if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | 
>> VM_FAULT_RETRY)))
>> @@ -4674,7 +4670,7 @@ static vm_fault_t do_cow_fault(struct vm_fault 
>> *vmf)
>>           return ret;
>>       copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
>> -    __SetPageUptodate(vmf->cow_page);
>> +    __folio_mark_uptodate(folio);
>>       ret |= finish_fault(vmf);
>>       unlock_page(vmf->page);
>> @@ -4683,7 +4679,7 @@ static vm_fault_t do_cow_fault(struct vm_fault 
>> *vmf)
>>           goto uncharge_out;
>>       return ret;
>>   uncharge_out:
>> -    put_page(vmf->cow_page);
>> +    folio_put(folio);
>>       return ret;
>>   }
> 
