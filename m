Return-Path: <linux-kernel+bounces-44439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231E84220F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0631F29F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE3664A0;
	Tue, 30 Jan 2024 10:57:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1204657DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612258; cv=none; b=gQBjdoBGW70IiKtjtWZJcJlxIJwTQgnnpQhs/K6mc6dm6i+CVFR6CfEBsvlt5vhZYG++XzWTjCEWVl3MVAii6z5T1KOejBrdzjz6VwIGGOUM1aLOAsLcin/Z/LgdcG1TYaxNt+9+BuJzXzEZP0Y2qYNNhQjgTeayaCfe3ZWTkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612258; c=relaxed/simple;
	bh=WuuIYrJs4mXDs4Xkz4rRqUD+xA+XGputIdfKrip9PII=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AWO/+g7YFuYy3H1/3U8eGA41FRbiDPm3/df6mFbXHmVirxLJsQYQlr5j4YXuhcbFbUtvNfYd6ung5ZQFmBOEgbRr5EczaiJTUwnyQYUUPmdQE7ukZIn8Lj93oeh3AcOJyZkdv6DHc8oyU4NT5aSospwNl01O5ZL7NGMLZa54RyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TPMXB10ljz29krw;
	Tue, 30 Jan 2024 18:55:38 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id AB70B1404D7;
	Tue, 30 Jan 2024 18:57:27 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 18:57:25 +0800
Message-ID: <eb78caf9-ac03-1030-4e32-b614e73c0f62@huawei.com>
Date: Tue, 30 Jan 2024 18:57:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 2/6] arm64: add support for machine check error safe
To: Mark Rutland <mark.rutland@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
	<glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrey
 Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
References: <20240129134652.4004931-1-tongtiangen@huawei.com>
 <20240129134652.4004931-3-tongtiangen@huawei.com>
 <ZbflpQV7aVry0qPz@FVFF77S0Q05N>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <ZbflpQV7aVry0qPz@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/1/30 1:51, Mark Rutland 写道:
> On Mon, Jan 29, 2024 at 09:46:48PM +0800, Tong Tiangen wrote:
>> For the arm64 kernel, when it processes hardware memory errors for
>> synchronize notifications(do_sea()), if the errors is consumed within the
>> kernel, the current processing is panic. However, it is not optimal.
>>
>> Take uaccess for example, if the uaccess operation fails due to memory
>> error, only the user process will be affected. Killing the user process and
>> isolating the corrupt page is a better choice.
>>
>> This patch only enable machine error check framework and adds an exception
>> fixup before the kernel panic in do_sea().
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/arm64/Kconfig               |  1 +
>>   arch/arm64/include/asm/extable.h |  1 +
>>   arch/arm64/mm/extable.c          | 16 ++++++++++++++++
>>   arch/arm64/mm/fault.c            | 29 ++++++++++++++++++++++++++++-
>>   4 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index aa7c1d435139..2cc34b5e7abb 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -20,6 +20,7 @@ config ARM64
>>   	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>>   	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>>   	select ARCH_HAS_CACHE_LINE_SIZE
>> +	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
>>   	select ARCH_HAS_CURRENT_STACK_POINTER
>>   	select ARCH_HAS_DEBUG_VIRTUAL
>>   	select ARCH_HAS_DEBUG_VM_PGTABLE
>> diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
>> index 72b0e71cc3de..f80ebd0addfd 100644
>> --- a/arch/arm64/include/asm/extable.h
>> +++ b/arch/arm64/include/asm/extable.h
>> @@ -46,4 +46,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>>   #endif /* !CONFIG_BPF_JIT */
>>   
>>   bool fixup_exception(struct pt_regs *regs);
>> +bool fixup_exception_mc(struct pt_regs *regs);
>>   #endif
>> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
>> index 228d681a8715..478e639f8680 100644
>> --- a/arch/arm64/mm/extable.c
>> +++ b/arch/arm64/mm/extable.c
>> @@ -76,3 +76,19 @@ bool fixup_exception(struct pt_regs *regs)
>>   
>>   	BUG();
>>   }
>> +
>> +bool fixup_exception_mc(struct pt_regs *regs)
> 
> Can we please replace 'mc' with something like 'memory_error' ?
> 
> There's no "machine check" on arm64, and 'mc' is opaque regardless.

OK, It's more appropriate to use "memory_error" on arm64.

> 
>> +{
>> +	const struct exception_table_entry *ex;
>> +
>> +	ex = search_exception_tables(instruction_pointer(regs));
>> +	if (!ex)
>> +		return false;
>> +
>> +	/*
>> +	 * This is not complete, More Machine check safe extable type can
>> +	 * be processed here.
>> +	 */
>> +
>> +	return false;
>> +}
> 
> As with my comment on the subsequenty patch, I'd much prefer that we handle
> EX_TYPE_UACCESS_ERR_ZERO from the outset.

OK, In the next version, the two patches will be merged.

> 
> 
> 
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 55f6455a8284..312932dc100b 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -730,6 +730,31 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
>>   	return 1; /* "fault" */
>>   }
>>   
>> +static bool arm64_do_kernel_sea(unsigned long addr, unsigned int esr,
>> +				     struct pt_regs *regs, int sig, int code)
>> +{
>> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
>> +		return false;
>> +
>> +	if (user_mode(regs))
>> +		return false;
> 
> This function is called "arm64_do_kernel_sea"; surely the caller should *never*
> call this for a SEA taken from user mode?

In do_sea(), the processing logic is as follows:
   do_sea()
   {
     [...]
     if (user_mode(regs) && apei_claim_sea(regs) == 0) {
        return 0;
     }
     [...]
     //[1]
     if (!arm64_do_kernel_sea()) {
        arm64_notify_die();
     }
   }

[1] user_mode() is still possible to go here,If user_mode() goes here,
  it indicates that the impact caused by the memory error cannot be
  processed correctly by apei_claim_sea().


In this case, only arm64_notify_die() can be used, This also maintains
the original logic of user_mode()'s processing.

> 
>> +
>> +	if (apei_claim_sea(regs) < 0)
>> +		return false;
>> +
>> +	if (!fixup_exception_mc(regs))
>> +		return false;
>> +
>> +	if (current->flags & PF_KTHREAD)
>> +		return true;
> 
> I think this needs a comment; why do we allow kthreads to go on, yet kill user
> threads? What about helper threads (e.g. for io_uring)?

If a memroy error occurs in the kernel thread, the problem is more
serious than that of the user thread. As a result, related kernel
functions, such as khugepaged, cannot run properly. kernel panic should
be a better choice at this time.

Therefore, the processing scope of this framework is limited to the user 
  thread.

> 
>> +
>> +	set_thread_esr(0, esr);
> 
> Why do we set the ESR to 0?

The purpose is to reuse the logic of arm64_notify_die() and set the 
following parameters before sending signals to users:
   current->thread.fault_address = 0;
   current->thread.fault_code = err;

I looked at the git log and found that the logic was added by this
commit:


9141300a5884 （“arm64: Provide read/write fault information in compat 
signal handlers”）

According to the description of commit message, the purpose seems to be
for aarch32.

Many thanks.
Tong.


> 
> Mark.
> 
>> +	arm64_force_sig_fault(sig, code, addr,
>> +		"Uncorrected memory error on access to user memory\n");
>> +
>> +	return true;
>> +}
>> +
>>   static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
>>   {
>>   	const struct fault_info *inf;
>> @@ -755,7 +780,9 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
>>   		 */
>>   		siaddr  = untagged_addr(far);
>>   	}
>> -	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
>> +
>> +	if (!arm64_do_kernel_sea(siaddr, esr, regs, inf->sig, inf->code))
>> +		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.25.1
>>
> .

