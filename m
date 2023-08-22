Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F4784075
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjHVMND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjHVMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:13:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AAF193;
        Tue, 22 Aug 2023 05:13:00 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVSr13fyWz1L9DH;
        Tue, 22 Aug 2023 20:11:29 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 20:12:56 +0800
Message-ID: <7fff8202-0be1-4989-959f-8c0b14ca1236@huawei.com>
Date:   Tue, 22 Aug 2023 20:12:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc v2 05/10] powerpc: mm: use try_vma_locked_page_fault()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "surenb@google.com" <surenb@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
References: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
 <20230821123056.2109942-6-wangkefeng.wang@huawei.com>
 <7eeed961-c2c0-2aeb-ff8c-3717de09d605@csgroup.eu>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <7eeed961-c2c0-2aeb-ff8c-3717de09d605@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/22 17:38, Christophe Leroy wrote:
> 
> 
> Le 21/08/2023 à 14:30, Kefeng Wang a écrit :
>> Use new try_vma_locked_page_fault() helper to simplify code.
>> No functional change intended.
> 
> Does it really simplifies code ? It's 32 insertions versus 34 deletions
> so only removing 2 lines.

Yes，it is unfriendly for powerpc as the arch's vma access check is much
complex than other arch,
> 
> I don't like the struct vm_fault you are adding because when it was four
> independant variables it was handled through local registers. Now that
> it is a struct it has to go via the stack, leading to unnecessary memory
> read and writes. And going back and forth between architecture code and
> generic code may also be counter-performant.

Because different arch has different var to check vma access, so the
easy way to add them into vmf, I don' find a better way.
> 
> Did you make any performance analysis ? Page faults are really a hot
> path when dealling with minor faults.

no, this is only built and rfc to see the feedback about the conversion.

Thanks.

> 
> Thanks
> Christophe
> 
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>    arch/powerpc/mm/fault.c | 66 ++++++++++++++++++++---------------------
>>    1 file changed, 32 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index b1723094d464..52f9546e020e 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -391,6 +391,22 @@ static int page_fault_is_bad(unsigned long err)
>>    #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_32S)
>>    #endif
>>    
>> +#ifdef CONFIG_PER_VMA_LOCK
>> +bool arch_vma_access_error(struct vm_area_struct *vma, struct vm_fault *vmf)
>> +{
>> +	int is_exec = TRAP(vmf->regs) == INTERRUPT_INST_STORAGE;
>> +	int is_write = page_fault_is_write(vmf->fault_code);
>> +
>> +	if (unlikely(access_pkey_error(is_write, is_exec,
>> +				(vmf->fault_code & DSISR_KEYFAULT), vma)))
>> +		return true;
>> +
>> +	if (unlikely(access_error(is_write, is_exec, vma)))
>> +		return true;
>> +	return false;
>> +}
>> +#endif
>> +
>>    /*
>>     * For 600- and 800-family processors, the error_code parameter is DSISR
>>     * for a data fault, SRR1 for an instruction fault.
>> @@ -407,12 +423,18 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>>    {
>>    	struct vm_area_struct * vma;
>>    	struct mm_struct *mm = current->mm;
>> -	unsigned int flags = FAULT_FLAG_DEFAULT;
>>    	int is_exec = TRAP(regs) == INTERRUPT_INST_STORAGE;
>>    	int is_user = user_mode(regs);
>>    	int is_write = page_fault_is_write(error_code);
>>    	vm_fault_t fault, major = 0;
>>    	bool kprobe_fault = kprobe_page_fault(regs, 11);
>> +	struct vm_fault vmf = {
>> +		.real_address = address,
>> +		.fault_code = error_code,
>> +		.regs = regs,
>> +		.flags = FAULT_FLAG_DEFAULT,
>> +	};
>> +
>>    
>>    	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
>>    		return 0;
>> @@ -463,45 +485,21 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>>    	 * mmap_lock held
>>    	 */
>>    	if (is_user)
>> -		flags |= FAULT_FLAG_USER;
>> +		vmf.flags |= FAULT_FLAG_USER;
>>    	if (is_write)
>> -		flags |= FAULT_FLAG_WRITE;
>> +		vmf.flags |= FAULT_FLAG_WRITE;
>>    	if (is_exec)
>> -		flags |= FAULT_FLAG_INSTRUCTION;
>> +		vmf.flags |= FAULT_FLAG_INSTRUCTION;
>>    
>> -	if (!(flags & FAULT_FLAG_USER))
>> -		goto lock_mmap;
>> -
>> -	vma = lock_vma_under_rcu(mm, address);
>> -	if (!vma)
>> -		goto lock_mmap;
>> -
>> -	if (unlikely(access_pkey_error(is_write, is_exec,
>> -				       (error_code & DSISR_KEYFAULT), vma))) {
>> -		vma_end_read(vma);
>> -		goto lock_mmap;
>> -	}
>> -
>> -	if (unlikely(access_error(is_write, is_exec, vma))) {
>> -		vma_end_read(vma);
>> -		goto lock_mmap;
>> -	}
>> -
>> -	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
>> -	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
>> -		vma_end_read(vma);
>> -
>> -	if (!(fault & VM_FAULT_RETRY)) {
>> -		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>> +	fault = try_vma_locked_page_fault(&vmf);
>> +	if (fault == VM_FAULT_NONE)
>> +		goto retry;
>> +	if (!(fault & VM_FAULT_RETRY))
>>    		goto done;
>> -	}
>> -	count_vm_vma_lock_event(VMA_LOCK_RETRY);
>>    
>>    	if (fault_signal_pending(fault, regs))
>>    		return user_mode(regs) ? 0 : SIGBUS;
>>    
>> -lock_mmap:
>> -
>>    	/* When running in the kernel we expect faults to occur only to
>>    	 * addresses in user space.  All other faults represent errors in the
>>    	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
>> @@ -528,7 +526,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>>    	 * make sure we exit gracefully rather than endlessly redo
>>    	 * the fault.
>>    	 */
>> -	fault = handle_mm_fault(vma, address, flags, regs);
>> +	fault = handle_mm_fault(vma, address, vmf.flags, regs);
>>    
>>    	major |= fault & VM_FAULT_MAJOR;
>>    
>> @@ -544,7 +542,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>>    	 * case.
>>    	 */
>>    	if (unlikely(fault & VM_FAULT_RETRY)) {
>> -		flags |= FAULT_FLAG_TRIED;
>> +		vmf.flags |= FAULT_FLAG_TRIED;
>>    		goto retry;
>>    	}
>>    
