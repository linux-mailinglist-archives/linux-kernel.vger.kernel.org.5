Return-Path: <linux-kernel+bounces-107866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD08802BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75036285C60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD73210E6;
	Tue, 19 Mar 2024 16:52:10 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA0208D0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867130; cv=none; b=RPgygpGYSBjOdjnxogqLdgtxAFrF9CbjqZ+4JEVFnYdawNCawUlXA9216TsfLleXLCv3yIhfCYFERrDrB+oZolciwBmUxamfr6rXFbudlaI82Iz86c2g45ljGpNA7MLrr9hy8eh8iYWr8m61tuyED90SLocHcdWFW4TE/2WBOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867130; c=relaxed/simple;
	bh=NBq5fLIj7FPk154JFi6u2xDwt6s8Dxfvu1J7YpM4Dmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr8OG1z59UiARQ4tsfy4cav8DfD9BI3qUt7mzH+8L7REzElDT9sSMpDykKyxmYxPfFlcNt25TWnol+aHSSGIU9HyAzahl7jN0VHXt2UiNucyyFILDodyjWQZ383TKbhHFXhNtdDFBIAoHtusZe/tbBGRXEA422Enk9+xw+TLHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4B1FE0004;
	Tue, 19 Mar 2024 16:51:54 +0000 (UTC)
Message-ID: <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
Date: Tue, 19 Mar 2024 17:51:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
 Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Yangyu Chen <cyy@cyyself.name>, linux-kernel@vger.kernel.org
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi  Samuel,

On 18/03/2024 22:29, Samuel Holland wrote:
> Hi Alex,
>
> On 2024-03-18 3:50 PM, Alexandre Ghiti wrote:
>> On Wed, Mar 13, 2024 at 7:00 PM Samuel Holland
>> <samuel.holland@sifive.com> wrote:
>>> TASK_SIZE_MAX should be set to the largest userspace address under any
>>> runtime configuration. This optimizes the check in __access_ok(), which
>>> no longer needs to compute the current value of TASK_SIZE. It is still
>>> safe because addresses between TASK_SIZE and TASK_SIZE_MAX are invalid
>>> at the hardware level.
>>>
>>> This removes about half of the references to pgtable_l[45]_enabled.
>>>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>>   arch/riscv/include/asm/pgtable-64.h | 1 +
>>>   arch/riscv/include/asm/pgtable.h    | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
>>> index b99bd66107a6..a677ef3c0fe2 100644
>>> --- a/arch/riscv/include/asm/pgtable-64.h
>>> +++ b/arch/riscv/include/asm/pgtable-64.h
>>> @@ -17,6 +17,7 @@ extern bool pgtable_l5_enabled;
>>>   #define PGDIR_SHIFT_L4  39
>>>   #define PGDIR_SHIFT_L5  48
>>>   #define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
>>> +#define PGDIR_SIZE_L5   (_AC(1, UL) << PGDIR_SHIFT_L5)
>>>
>>>   #define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
>>>                  (pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>> index 6066822e7396..2032f8ac5fc5 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -867,6 +867,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>>   #ifdef CONFIG_64BIT
>>>   #define TASK_SIZE_64   (PGDIR_SIZE * PTRS_PER_PGD / 2)
>>>   #define TASK_SIZE_MIN  (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>>> +#define TASK_SIZE_MAX  (PGDIR_SIZE_L5 * PTRS_PER_PGD / 2)
>>>
>>>   #ifdef CONFIG_COMPAT
>>>   #define TASK_SIZE_32   (_AC(0x80000000, UL))
>>> --
>>> 2.43.1
>>>
>> I think you also need to change the check in handle_page_fault() by
>> using TASK_SIZE_MAX instead of TASK_SIZE, otherwise the fixup can't
>> happen (https://elixir.bootlin.com/linux/latest/source/arch/riscv/mm/fault.c#L273).
> It is not necessary to change that check in fault.c unless we expect to handle
> exceptions (outside of userspace access routines) for addresses between
> TASK_SIZE and TASK_SIZE_MAX.


Which I think could be the case if some code is only using the "new" 
access_ok() without the uaccess routines (which is wrong yes, but such 
code is at the origin of this check).


> It looks like the call to fixup_exception() [added
> in 416721ff05fd ("riscv, mm: Perform BPF exhandler fixup on page fault")] is
> only intended to catch null pointer dereferences. So making the change wouldn't
> have any functional impact, but it would still be a valid optimization.
>
>> Or I was wondering if it would not be better to do like x86 and use an
>> alternative, it would be more correct (even though I believe your
>> solution works)
>> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64.h#L82.
> What would be the benefit of using an alternative? Any access to an address
> between TASK_SIZE and TASK_SIZE_MAX is guaranteed to generate a page fault, so
> the only benefit I see is returning -EFAULT slightly faster at the cost of
> applying a few hundred alternatives at boot. But it's possible I'm missing
> something.


The use of alternatives allows to return right away if the buffer is 
beyond the usable user address space, and it's not just "slightly 
faster" for some cases (a very large buffer with only a few bytes being 
beyond the limit or someone could fault-in all the user pages and fail 
very late...etc). access_ok() is here to guarantee that such situations 
don't happen, so actually it makes more sense to use an alternative to 
avoid that.


Alex


> Regards,
> Samuel
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

