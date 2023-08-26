Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258D07892D6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjHZA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjHZA4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:56:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A35526BD;
        Fri, 25 Aug 2023 17:56:32 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXdZy6d9WztRf4;
        Sat, 26 Aug 2023 08:52:42 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 08:56:28 +0800
Message-ID: <26989657-3ad9-48c5-9863-12993b78141c@huawei.com>
Date:   Sat, 26 Aug 2023 08:56:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc v2 01/10] mm: add a generic VMA lock-based page fault
 handler
Content-Language: en-US
To:     Alexander Gordeev <agordeev@linux.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <surenb@google.com>, <willy@infradead.org>,
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
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>
References: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
 <20230821123056.2109942-2-wangkefeng.wang@huawei.com>
 <ZOcC7RsYy5yJLgNb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZOcC7RsYy5yJLgNb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/24 15:12, Alexander Gordeev wrote:
> On Mon, Aug 21, 2023 at 08:30:47PM +0800, Kefeng Wang wrote:
> 
> Hi Kefeng,
> 
>> The ARCH_SUPPORTS_PER_VMA_LOCK are enabled by more and more architectures,
>> eg, x86, arm64, powerpc and s390, and riscv, those implementation are very
>> similar which results in some duplicated codes, let's add a generic VMA
>> lock-based page fault handler try_to_vma_locked_page_fault() to eliminate
>> them, and which also make us easy to support this on new architectures.
>>
>> Since different architectures use different way to check vma whether is
>> accessable or not, the struct pt_regs, page fault error code and vma flags
>> are added into struct vm_fault, then, the architecture's page fault code
>> could re-use struct vm_fault to record and check vma accessable by each
>> own implementation.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
...
>> +
>> +vm_fault_t try_vma_locked_page_fault(struct vm_fault *vmf)
>> +{
>> +	vm_fault_t fault = VM_FAULT_NONE;
>> +	struct vm_area_struct *vma;
>> +
>> +	if (!(vmf->flags & FAULT_FLAG_USER))
>> +		return fault;
>> +
>> +	vma = lock_vma_under_rcu(current->mm, vmf->real_address);
>> +	if (!vma)
>> +		return fault;
>> +
>> +	if (arch_vma_access_error(vma, vmf)) {
>> +		vma_end_read(vma);
>> +		return fault;
>> +	}
>> +
>> +	fault = handle_mm_fault(vma, vmf->real_address,
>> +				vmf->flags | FAULT_FLAG_VMA_LOCK, vmf->regs);
>> +
>> +	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
>> +		vma_end_read(vma);
> 
> Could you please explain how vma_end_read() call could be conditional?

The check is added for swap and userfault, see

https://lkml.kernel.org/r/20230630211957.1341547-4-surenb@google.com
> 
>> +
>> +	if (fault & VM_FAULT_RETRY)
>> +		count_vm_vma_lock_event(VMA_LOCK_RETRY);
>> +	else
>> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>> +
>> +	return fault;
>> +}
>> +
>>   #endif /* CONFIG_PER_VMA_LOCK */
>>   
>>   #ifndef __PAGETABLE_P4D_FOLDED
