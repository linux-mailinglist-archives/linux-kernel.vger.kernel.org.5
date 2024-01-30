Return-Path: <linux-kernel+bounces-44489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E28422C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F2295C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C00679F2;
	Tue, 30 Jan 2024 11:14:47 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B7664AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613287; cv=none; b=qFUYLinxIED/kOmuvuptP9gN0SAl3h9ZqhPdRDBFnXdPVo1r+qsmm5lByhLAoptYmu44elbXY7nSxxu/dPcE0QvBBWL/QKf+Tylf423kFbL2jDTJ+JiUQz1O8LXRgymYnRhT8qUp52CG/zdMcIWpCoOF4KV4YemZWVW7Eicg/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613287; c=relaxed/simple;
	bh=hrlC0Nc3SSTE67CT9tQ8BqfKTYytcG1CKlF7JbeaVoo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NlxAzVtnw0O4tXUkabWf3cbBuI+0PQq12iSBmy5XRPwrrmnWhYFCLe/yCtBZhePll1CHh3uasQhCyokcHc2z6tExZ2rstQXGAwScppz5SWEDa++N9MYejFvDlSaDjSNP0sLXqSMe3HcJA2LfR2H7G9PqS8tfzPRgeI6idNXMKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TPMvz6zx9z1Q89B;
	Tue, 30 Jan 2024 19:12:47 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id D80601A016C;
	Tue, 30 Jan 2024 19:14:37 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 19:14:35 +0800
Message-ID: <23795738-b86e-7709-bc2b-5abba2e77b68@huawei.com>
Date: Tue, 30 Jan 2024 19:14:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH v10 3/6] arm64: add uaccess to machine check safe
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
 <20240129134652.4004931-4-tongtiangen@huawei.com>
 <ZbfjvD1_yKK6IVVY@FVFF77S0Q05N>
In-Reply-To: <ZbfjvD1_yKK6IVVY@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/1/30 1:43, Mark Rutland 写道:
> On Mon, Jan 29, 2024 at 09:46:49PM +0800, Tong Tiangen wrote:
>> If user process access memory fails due to hardware memory error, only the
>> relevant processes are affected, so it is more reasonable to kill the user
>> process and isolate the corrupt page than to panic the kernel.
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/arm64/lib/copy_from_user.S | 10 +++++-----
>>   arch/arm64/lib/copy_to_user.S   | 10 +++++-----
>>   arch/arm64/mm/extable.c         |  8 ++++----
>>   3 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
>> index 34e317907524..1bf676e9201d 100644
>> --- a/arch/arm64/lib/copy_from_user.S
>> +++ b/arch/arm64/lib/copy_from_user.S
>> @@ -25,7 +25,7 @@
>>   	.endm
>>   
>>   	.macro strb1 reg, ptr, val
>> -	strb \reg, [\ptr], \val
>> +	USER(9998f, strb \reg, [\ptr], \val)
>>   	.endm
> 
> This is a store to *kernel* memory, not user memory. It should not be marked
> with USER().

This does cause some misconceptions, and my original idea was to reuse 
the fixup capability of USER().

> 
> I understand that you *might* want to handle memory errors on these stores, but
> the commit message doesn't describe that and the associated trade-off. For
> example, consider that when a copy_form_user fails we'll try to zero the
> remaining buffer via memset(); so if a STR* instruction in copy_to_user
> faulted, upon handling the fault we'll immediately try to fix that up with some
> more stores which will also fault, but won't get fixed up, leading to a panic()
> anyway...

When copy_from_user() triggers a memory error, there are two cases: ld
user memory error and st kernel memory error. The former can clear the
remaining kernel memory, and the latter cannot be cleared because the
page is poison.

The purpose of memset() is to keep the data consistency of the kernel
memory (or multiple subsequent pages) (the data that is not copied
should be set to 0). My consideration here is that since our ultimate
goal is to kill the owner thread of the kernel memory data, the
"consistency" of the kernel memory data is not so important, but
increases the processing complexity.

The trade-offs do need to be added to commit message after agreement
is reached :)
> 
> Further, this change will also silently fixup unexpected kernel faults if we
> pass bad kernel pointers to copy_{to,from}_user, which will hide real bugs.

I think this is better than the panic kernel, because the real bugs
belongs to the user process. Even if the wrong pointer is
transferred, the page corresponding to the wrong pointer has a memroy
error. In addition, the panic information contains necessary information
for users to check.

> 
> So NAK to this change as-is; likewise for the addition of USER() to other ldr*
> macros in copy_from_user.S and the addition of USER() str* macros in
> copy_to_user.S.
> 
> If we want to handle memory errors on some kaccesses, we need a new EX_TYPE_*
> separate from the usual EX_TYPE_KACESS_ERR_ZERO that means "handle memory
> errors, but treat other faults as fatal". That should come with a rationale and
> explanation of why it's actually useful.

This makes sense. Add kaccess types that can be processed properly.

> 
> [...]
> 
>> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
>> index 478e639f8680..28ec35e3d210 100644
>> --- a/arch/arm64/mm/extable.c
>> +++ b/arch/arm64/mm/extable.c
>> @@ -85,10 +85,10 @@ bool fixup_exception_mc(struct pt_regs *regs)
>>   	if (!ex)
>>   		return false;
>>   
>> -	/*
>> -	 * This is not complete, More Machine check safe extable type can
>> -	 * be processed here.
>> -	 */
>> +	switch (ex->type) {
>> +	case EX_TYPE_UACCESS_ERR_ZERO:
>> +		return ex_handler_uaccess_err_zero(ex, regs);
>> +	}
> 
> Please fold this part into the prior patch, and start ogf with *only* handling
> errors on accesses already marked with EX_TYPE_UACCESS_ERR_ZERO. I think that
> change would be relatively uncontroversial, and it would be much easier to
> build atop that.

OK, the two patches will be merged in the next release.

Many thanks.
Tong.

> 
> Thanks,
> Mark.
> .

