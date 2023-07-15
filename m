Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B42754626
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGOByr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjGOByq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:54:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD373AA1;
        Fri, 14 Jul 2023 18:54:42 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R2rx46ZcYzhYcy;
        Sat, 15 Jul 2023 09:54:00 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 15 Jul 2023 09:54:38 +0800
Message-ID: <153b94dc-d003-fe81-eef4-332ece878af0@huawei.com>
Date:   Sat, 15 Jul 2023 09:54:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH rfc -next 01/10] mm: add a generic VMA lock-based page
 fault handler
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>
References: <20230713095339.189715-1-wangkefeng.wang@huawei.com>
 <20230713095339.189715-2-wangkefeng.wang@huawei.com>
 <ZLAjFQGgcjt4ykS7@casper.infradead.org>
 <CAJuCfpGBaAJof=5-Xh1saoN9dhOauMiHBZzb0crVNn9OyOeZHw@mail.gmail.com>
 <6f06f7d5-7d84-815e-699b-eef684e014b0@huawei.com>
In-Reply-To: <6f06f7d5-7d84-815e-699b-eef684e014b0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/14 9:52, Kefeng Wang wrote:
> 
> 
> On 2023/7/14 4:12, Suren Baghdasaryan wrote:
>> On Thu, Jul 13, 2023 at 9:15 AM Matthew Wilcox <willy@infradead.org> 
>> wrote:
>>>
>>>> +int try_vma_locked_page_fault(struct vm_locked_fault *vmlf, 
>>>> vm_fault_t *ret)
>>>> +{
>>>> +     struct vm_area_struct *vma;
>>>> +     vm_fault_t fault;
>>>
>>>
>>> On Thu, Jul 13, 2023 at 05:53:29PM +0800, Kefeng Wang wrote:
>>>> +#define VM_LOCKED_FAULT_INIT(_name, _mm, _address, _fault_flags, 
>>>> _vm_flags, _regs, _fault_code) \
>>>> +     _name.mm                = _mm;                  \
>>>> +     _name.address           = _address;             \
>>>> +     _name.fault_flags       = _fault_flags;         \
>>>> +     _name.vm_flags          = _vm_flags;            \
>>>> +     _name.regs              = _regs;                \
>>>> +     _name.fault_code        = _fault_code
>>>
>>> More consolidated code is a good idea; no question.  But I don't think
>>> this is the right way to do it.
> 
> I agree it is not good enough, but the arch's vma check acess has
> different implementation, some use vm flags, some need fault code and
> regs, and some use both :(
> 
>>>
>>>> +int __weak arch_vma_check_access(struct vm_area_struct *vma,
>>>> +                              struct vm_locked_fault *vmlf);
>>>
>>> This should be:
>>>
>>> #ifndef vma_check_access
>>> bool vma_check_access(struct vm_area_struct *vma, )
>>> {
>>>          return (vma->vm_flags & vm_flags) == 0;
>>> }
>>> #endif
>>>
>>> and then arches which want to do something different can just define
>>> vma_check_access.
> 
> Ok, I could convert to use this way.
> 
>>>
>>>> +int try_vma_locked_page_fault(struct vm_locked_fault *vmlf, 
>>>> vm_fault_t *ret)
>>>> +{
>>>> +     struct vm_area_struct *vma;
>>>> +     vm_fault_t fault;
>>>
>>> Declaring the vmf in this function and then copying it back is just 
>>> wrong.
>>> We need to declare vm_fault_t earlier (in the arch fault handler) and
>>> pass it in.
> 
> Actually I passed the vm_fault_t *ret(in the arch fault handler), we
> could directly use *ret instead of a new local variable, and no copy.
>>
>> Did you mean to say "we need to declare vmf (struct vm_fault) earlier
>> (in the arch fault handler) and pass it in." ?

After recheck the code, I think Matthew' idea is 'declare vmf (struct 
vm_fault) earlier' like Suren said, not vm_fault_t, right? will try 
this, thanks.

>>
>>>   I don't think that creating struct vm_locked_fault is the
>>> right idea either.
> 
> As mentioned above for vma check access, we need many arguments for a 
> function, a new struct looks possible better, is there better solution
> or any suggestion?
> 
> Thanks.
> 
