Return-Path: <linux-kernel+bounces-103335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5FD87BE34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828FA2887E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40196F086;
	Thu, 14 Mar 2024 13:59:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1415B5C5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424796; cv=none; b=LczQ3TmiGLo8MjcxzbmAaWeNxKjyo7WE0wN/Hpeh4Tch1Dtg4s9REB9sIIoZbdcssQaMszVNHHaS0JhPceTdzqortyGA2z9Zb1aS3Mqr1uXNAsnlSAjh7gKNyEB3E7lvqdus4dBrkMZUs9p5ki4MY3iAaty2Lr2SuHxoULhTP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424796; c=relaxed/simple;
	bh=Hv0Df++TiWDEFAqeasoMhWQ3o9DlueFHjwfYRj94sK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R16JCJMYt1y4AismQHDImlq37X8kTkzOK3h7xE4B2ji1ds7f9+hxBYlOIxYdnGX3WdPYi64quqzfFH9evI9Ri8yIOQc7sgP7BO+b2nMMXCP8vooPWdmQc+q1jgfyueGTQnEcPhjaqN2ZVhXZ5lqRi+74UJXe4G2A+yNUZqWJ08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TwTX41ZYPz1FM4V;
	Thu, 14 Mar 2024 21:59:32 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DA921A0172;
	Thu, 14 Mar 2024 21:59:49 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 14 Mar 2024 21:59:48 +0800
Message-ID: <ea1764f9-9bb4-229f-7812-8a1b31e70ee2@huawei.com>
Date: Thu, 14 Mar 2024 21:59:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] arm64: lib: improve usercopy performance by mitigating
 data dependencies
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <quic_jiles@quicinc.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240312150845.1356415-1-lizetao1@huawei.com>
 <ZfB22hqeX2nHbxDU@FVFF77S0Q05N>
Content-Language: en-US
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <ZfB22hqeX2nHbxDU@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi Mark,

On 2024/3/12 23:38, Mark Rutland wrote:
> On Tue, Mar 12, 2024 at 11:08:45PM +0800, Li Zetao wrote:
>> In the copy_from/to_user scenario, due to the need to accurately
>> calculate the number of copied bytes for fixup, it is necessary to
>> increment the values of src and dst after each copy of the data.
>> Therefore, this introduce RAW dependency which result in some bubble
>> in pipline and degrade the IPC.
>>
>> Consider updating the values of src and dst only when the copy is
>> completed in the current stage to reduce data dependence. But this will
>> break the function of fixup, so in order to maintain the function of
>> fixup, a new variable is introduced to record the number of bytes to be
>> copied in the current stage. Once an access exception occurs, the variable
>> can be used to determined the final index of access exception by copying
>> byte-by-byte.
>>
>> Here are the test result:
>>    Copy 128 bytes cost on Kunpeng-920(us):
>>      Without this patch:
>>      copy_from_user: 1.0187 copy_to_user: 1.1021
>>
>>      With this patch:
>>      copy_from_user: 0.9523 copy_to_user: 1.0159
>>
>> It's about 7% improvement in copy_from/to_user()
> 
> How exactly are you testing this? Can you share your test code?
> 
> The current structure of this code (and e.g. the use of write-back addressing)
> is largely force upon us by the structure of the Cortex strings functions,
> which are already painful enough to read and work on. If we're going to rewrite
> those I'd rather we abandoned the Cortex strings template for usercopies.
> 
> I had previously attempted to rewrite some of these along with some functional
> tests:
> 
>    https://lore.kernel.org/linux-arm-kernel/20230314115030.347976-1-mark.rutland@arm.com/
> 
> Could you give those a go?  Specifically, could you see how copy_to_user()
> performs with the patch at:
> 
>    https://lore.kernel.org/linux-arm-kernel/20230314115030.347976-4-mark.rutland@arm.com/
> 
> .. if that gets you a similar benefit I'd be happy to revive the series and
> give copy_from_user() similar treatment.
I tested your patch and the result is as follows:
   Copy 128 bytes cost on Kunpeng-920(us):
     With your patch:
     copy_to_user: 1.1967

No performance gain. I guess your patch changed the original copy order, 
which affected the final performance.

Inspired by your patch, we can reduce the impact of data dependency 
without changing the original copy order. This can not only remove the 
template.S file, but also improve performance. For example, what do you 
think of the following code? Looking forward to your opinion.

/* SPDX-License-Identifier: GPL-2.0-only */
/*
  * Copyright (C) 2012 ARM Ltd.
  */

#include <linux/linkage.h>

#include <asm/asm-uaccess.h>
#include <asm/assembler.h>
#include <asm/cache.h>

/*
  * Copy to user space from a kernel buffer (alignment handled by the 
hardware)
  *
  * Parameters:
  *	x0 - to
  *	x1 - from
  *	x2 - n
  * Returns:
  *	x0 - bytes not copied
  */

end	.req	x5
dstin	.req	x0
srcin	.req	x15
src	.req	x1
count	.req	x2
tmp1	.req	x3
tmp1w	.req	w3
tmp2	.req	x4
tmp2w	.req	w4
dst	.req	x6

A_l	.req	x7
A_h	.req	x8
B_l	.req	x9
B_h	.req	x10
C_l	.req	x11
C_h	.req	x12
D_l	.req	x13
D_h	.req	x14

#define USER_OFF(off, x...)	USER(fixup_offset_##off, x)
#define FIXUP_OFFSET(n)				\
fixup_offset_##n:				\
	sub	x0, end, dst;			\
	sub	x0, x0, n;			\
	ret

FIXUP_OFFSET(0)
FIXUP_OFFSET(8)
FIXUP_OFFSET(16)
FIXUP_OFFSET(24)
FIXUP_OFFSET(32)
FIXUP_OFFSET(40)
FIXUP_OFFSET(48)
FIXUP_OFFSET(56)

SYM_FUNC_START(__arch_copy_to_user)
	add	end, x0, x2
	mov	srcin, x1
	mov	dst, dstin
	cmp	count, #16
	/*When memory length is less than 16, the accessed are not aligned.*/
	b.lo	.Ltiny15

	neg	tmp2, src
	ands	tmp2, tmp2, #15/* Bytes to reach alignment. */
	b.eq	.LSrcAligned
	sub	count, count, tmp2
	/*
	* Copy the leading memory data from src to dst in an increasing
	* address order.By this way,the risk of overwriting the source
	* memory data is eliminated when the distance between src and
	* dst is less than 16. The memory accesses here are alignment.
	*/
	tbz	tmp2, #0, 1f
	ldrb	tmp1w, [src], #1
USER_OFF(0,	sttrb tmp1w, [dst, #0])
	add	dst, dst, #1
1:
	tbz	tmp2, #1, 2f
	ldrh	tmp1w, [src], #2
USER_OFF(0,	sttrh tmp1w, [dst, #0])
	add	dst, dst, #2
2:
	tbz	tmp2, #2, 3f
	ldr	tmp1w, [src], #4
USER_OFF(0,	sttr tmp1w, [dst, #0])
	add	dst, dst, #4
3:
	tbz	tmp2, #3, .LSrcAligned
	ldr	tmp1, [src], #8
USER_OFF(0,	sttr tmp1, [dst, #0])
	add	dst, dst, #8

LSrcAligned:
	cmp	count, #64
	b.ge	.Lcpy_over64
	/*
	* Deal with small copies quickly by dropping straight into the
	* exit block.
	*/
Ltail63:
	/*
	* Copy up to 48 bytes of data. At this point we only need the
	* bottom 6 bits of count to be accurate.
	*/
	ands	tmp1, count, #0x30
	b.eq	.Ltiny15
	cmp	tmp1w, #0x20
	b.eq	1f
	b.lt	2f
	ldp	A_l, A_h, [src], #16
USER_OFF(0,	sttr A_l, [dst, #0])
USER_OFF(8,	sttr A_h, [dst, #8])
	add	dst, dst, #16
1:
	ldp	A_l, A_h, [src], #16
USER_OFF(0,	sttr A_l, [dst, #0])
USER_OFF(8,	sttr A_h, [dst, #8])
	add	dst, dst, #16
2:
	ldp	A_l, A_h, [src], #16
USER_OFF(0,	sttr A_l, [dst, #0])
USER_OFF(8,	sttr A_h, [dst, #8])
	add	dst, dst, #16
Ltiny15:
	/*
	* Prefer to break one ldp/stp into several load/store to access
	* memory in an increasing address order,rather than to load/store 16
	* bytes from (src-16) to (dst-16) and to backward the src to aligned
	* address,which way is used in original cortex memcpy. If keeping
	* the original memcpy process here, memmove need to satisfy the
	* precondition that src address is at least 16 bytes bigger than dst
	* address,otherwise some source data will be overwritten when memove
	* call memcpy directly. To make memmove simpler and decouple the
	* memcpy's dependency on memmove, withdrew the original process.
	*/
	tbz	count, #3, 1f
	ldr	tmp1, [src], #8
USER_OFF(0,	sttr tmp1, [dst, #0])
	add	dst, dst, #8
1:
	tbz	count, #2, 2f
	ldr	tmp1w, [src], #4
USER_OFF(0,	sttr tmp1w, [dst, #0])
	add	dst, dst, #4
2:
	tbz	count, #1, 3f
	ldrh	tmp1w, [src], #2
USER_OFF(0,	sttrh tmp1w, [dst, #0])
	add	dst, dst, #2
3:
	tbz	count, #0, .Lexitfunc
	ldrb	tmp1w, [src], #1
USER_OFF(0,	sttrb tmp1w, [dst, #0])
	add	dst, dst, #1

	b	.Lexitfunc

Lcpy_over64:
	subs	count, count, #128
	b.ge	.Lcpy_body_large
	/*
	* Less than 128 bytes to copy, so handle 64 here and then jump
	* to the tail.
	*/

	ldp	A_l, A_h, [src, #0]
USER_OFF(0,	sttr A_l, [dst, #0])
USER_OFF(8,	sttr A_h, [dst, #8])
	ldp	B_l, B_h, [src, #16]
	ldp	C_l, C_h, [src, #32]
USER_OFF(16,	sttr B_l, [dst, #16])
USER_OFF(24,	sttr B_h, [dst, #24])
USER_OFF(32,	sttr C_l, [dst, #32])
USER_OFF(40,	sttr C_h, [dst, #40])
	ldp	D_l, D_h, [src, #48]
USER_OFF(48,	sttr D_l, [dst, #48])
USER_OFF(56,	sttr D_h, [dst, #56])
	add	src, src, #64
	add	dst, dst, #64

	tst	count, #0x3f
	b.ne	.Ltail63
	b	.Lexitfunc

	/*
	* Critical loop.  Start at a new cache line boundary.  Assuming
	* 64 bytes per line this ensures the entire loop is in one line.
	*/
	.p2align	L1_CACHE_SHIFT
Lcpy_body_large:
	/* pre-get 64 bytes data. */
	ldp	A_l, A_h, [src, #0]
	ldp	B_l, B_h, [src, #16]
	ldp	C_l, C_h, [src, #32]
	ldp	D_l, D_h, [src, #48]
	add	src, src, #64
1:
	/*
	* interlace the load of next 64 bytes data block with store of the last
	* loaded 64 bytes data.
	*/
USER_OFF(0,	sttr A_l, [dst, #0])
USER_OFF(8,	sttr A_h, [dst, #8])
	ldp	A_l, A_h, [src, #0]
USER_OFF(16,	sttr B_l, [dst, #16])
USER_OFF(24,	sttr B_h, [dst, #24])
	ldp	B_l, B_h, [src, #16]
USER_OFF(32,	sttr C_l, [dst, #32])
USER_OFF(40,	sttr C_h, [dst, #40])
	ldp	C_l, C_h, [src, #32]
USER_OFF(48,	sttr D_l, [dst, #48])
USER_OFF(56,	sttr D_h, [dst, #56])
	ldp	D_l, D_h, [src, #48]
	add	src, src, #64
	add	dst, dst, #64
	subs	count, count, #64
	b.ge	1b
USER_OFF(0,	sttr A_l, [dst, #0])
USER_OFF(8,	sttr A_h, [dst, #8])
USER_OFF(16,	sttr B_l, [dst, #16])
USER_OFF(24,	sttr B_h, [dst, #24])
USER_OFF(32,	sttr C_l, [dst, #32])
USER_OFF(40,	sttr C_h, [dst, #40])
USER_OFF(48,	sttr D_l, [dst, #48])
USER_OFF(56,	sttr D_h, [dst, #56])
	add	dst, dst, #64

	tst	count, #0x3f
	b.ne	.Ltail63
Lexitfunc:
	mov	x0, #0
	ret

SYM_FUNC_END(__arch_copy_to_user)
EXPORT_SYMBOL(__arch_copy_to_user)

> 
> Thanks,
> Mark.
> 
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   arch/arm64/include/asm/asm-uaccess.h | 14 +++---
>>   arch/arm64/lib/copy_from_user.S      | 21 +++++++--
>>   arch/arm64/lib/copy_template.S       | 66 +++++++++++++++++-----------
>>   arch/arm64/lib/copy_to_user.S        | 22 +++++++---
>>   4 files changed, 81 insertions(+), 42 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
>> index 5b6efe8abeeb..ccbde0d0c113 100644
>> --- a/arch/arm64/include/asm/asm-uaccess.h
>> +++ b/arch/arm64/include/asm/asm-uaccess.h
>> @@ -66,19 +66,17 @@ alternative_else_nop_endif
>>    * This is complicated as there is no post-increment or pair versions of the
>>    * unprivileged instructions, and USER() only works for single instructions.
>>    */
>> -	.macro user_ldp l, reg1, reg2, addr, post_inc
>> -8888:		ldtr	\reg1, [\addr];
>> -8889:		ldtr	\reg2, [\addr, #8];
>> -		add	\addr, \addr, \post_inc;
>> +	.macro user_ldp l, reg1, reg2, addr, offs_inc
>> +8888:		ldtr	\reg1, [\addr, \offs_inc];
>> +8889:		ldtr	\reg2, [\addr, \offs_inc + 8];
>>   
>>   		_asm_extable_uaccess	8888b, \l;
>>   		_asm_extable_uaccess	8889b, \l;
>>   	.endm
>>   
>> -	.macro user_stp l, reg1, reg2, addr, post_inc
>> -8888:		sttr	\reg1, [\addr];
>> -8889:		sttr	\reg2, [\addr, #8];
>> -		add	\addr, \addr, \post_inc;
>> +	.macro user_stp l, reg1, reg2, addr, offs_inc
>> +8888:		sttr	\reg1, [\addr, \offs_inc];
>> +8889:		sttr	\reg2, [\addr, \offs_inc + 8];
>>   
>>   		_asm_extable_uaccess	8888b,\l;
>>   		_asm_extable_uaccess	8889b,\l;
>> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
>> index 34e317907524..c575829b85be 100644
>> --- a/arch/arm64/lib/copy_from_user.S
>> +++ b/arch/arm64/lib/copy_from_user.S
>> @@ -49,7 +49,7 @@
>>   	.endm
>>   
>>   	.macro stp1 reg1, reg2, ptr, val
>> -	stp \reg1, \reg2, [\ptr], \val
>> +	stp \reg1, \reg2, [\ptr, \val]
>>   	.endm
>>   
>>   end	.req	x5
>> @@ -62,12 +62,25 @@ SYM_FUNC_START(__arch_copy_from_user)
>>   	ret
>>   
>>   	// Exception fixups
>> -9997:	cmp	dst, dstin
>> +9997:	sub	x7, src, srcin
>> +	sub	x8, dst, dstin
>> +	cmp	x7, x8
>> +	b.le	no_need_to_adjust_src
>> +	sub	x9, x7, x8
>> +	sub	src, src, p_copy
>> +	add	p_copy, p_copy, x9
>> +no_need_to_adjust_src:
>> +	cmp	dst, dstin
>>   	b.ne	9998f
>>   	// Before being absolutely sure we couldn't copy anything, try harder
>> -USER(9998f, ldtrb tmp1w, [srcin])
>> +calculate_bytes_copied:
>> +USER(9999f, ldtrb tmp1w, [src])
>>   	strb	tmp1w, [dst], #1
>> -9998:	sub	x0, end, dst			// bytes not copied
>> +	add	src, src, #1
>> +	sub	p_copy, p_copy, #1
>> +9998:	cmp	p_copy, 0
>> +	b.ge	calculate_bytes_copied
>> +9999:	sub	x0, end, dst			// bytes not copied
>>   	ret
>>   SYM_FUNC_END(__arch_copy_from_user)
>>   EXPORT_SYMBOL(__arch_copy_from_user)
>> diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
>> index 488df234c49a..8832b9fd0257 100644
>> --- a/arch/arm64/lib/copy_template.S
>> +++ b/arch/arm64/lib/copy_template.S
>> @@ -29,6 +29,7 @@ tmp1w	.req	w3
>>   tmp2	.req	x4
>>   tmp2w	.req	w4
>>   dst	.req	x6
>> +p_copy	.req	x16
>>   
>>   A_l	.req	x7
>>   A_h	.req	x8
>> @@ -39,6 +40,7 @@ C_h	.req	x12
>>   D_l	.req	x13
>>   D_h	.req	x14
>>   
>> +	mov	p_copy, 16
>>   	mov	dst, dstin
>>   	cmp	count, #16
>>   	/*When memory length is less than 16, the accessed are not aligned.*/
>> @@ -82,19 +84,26 @@ D_h	.req	x14
>>   	* Copy up to 48 bytes of data. At this point we only need the
>>   	* bottom 6 bits of count to be accurate.
>>   	*/
>> +	mov	p_copy, #16
>>   	ands	tmp1, count, #0x30
>>   	b.eq	.Ltiny15
>>   	cmp	tmp1w, #0x20
>>   	b.eq	1f
>>   	b.lt	2f
>> -	ldp1	A_l, A_h, src, #16
>> -	stp1	A_l, A_h, dst, #16
>> +	ldp1	A_l, A_h, src, #0
>> +	stp1	A_l, A_h, dst, #0
>> +	add	src, src, #16
>> +	add	dst, dst, #16
>>   1:
>> -	ldp1	A_l, A_h, src, #16
>> -	stp1	A_l, A_h, dst, #16
>> +	ldp1	A_l, A_h, src, #0
>> +	stp1	A_l, A_h, dst, #0
>> +	add	src, src, #16
>> +	add	dst, dst, #16
>>   2:
>> -	ldp1	A_l, A_h, src, #16
>> -	stp1	A_l, A_h, dst, #16
>> +	ldp1	A_l, A_h, src, #0
>> +	stp1	A_l, A_h, dst, #0
>> +	add	src, src, #16
>> +	add	dst, dst, #16
>>   .Ltiny15:
>>   	/*
>>   	* Prefer to break one ldp/stp into several load/store to access
>> @@ -126,20 +135,23 @@ D_h	.req	x14
>>   	b	.Lexitfunc
>>   
>>   .Lcpy_over64:
>> +	mov	p_copy, #64
>>   	subs	count, count, #128
>>   	b.ge	.Lcpy_body_large
>>   	/*
>>   	* Less than 128 bytes to copy, so handle 64 here and then jump
>>   	* to the tail.
>>   	*/
>> -	ldp1	A_l, A_h, src, #16
>> -	stp1	A_l, A_h, dst, #16
>> +	ldp1	A_l, A_h, src, #0
>> +	stp1	A_l, A_h, dst, #0
>>   	ldp1	B_l, B_h, src, #16
>> -	ldp1	C_l, C_h, src, #16
>> +	ldp1	C_l, C_h, src, #32
>>   	stp1	B_l, B_h, dst, #16
>> -	stp1	C_l, C_h, dst, #16
>> -	ldp1	D_l, D_h, src, #16
>> -	stp1	D_l, D_h, dst, #16
>> +	stp1	C_l, C_h, dst, #32
>> +	ldp1	D_l, D_h, src, #48
>> +	stp1	D_l, D_h, dst, #48
>> +	add	src, src, #64
>> +	add	dst, dst, #64
>>   
>>   	tst	count, #0x3f
>>   	b.ne	.Ltail63
>> @@ -152,30 +164,34 @@ D_h	.req	x14
>>   	.p2align	L1_CACHE_SHIFT
>>   .Lcpy_body_large:
>>   	/* pre-get 64 bytes data. */
>> -	ldp1	A_l, A_h, src, #16
>> +	ldp1	A_l, A_h, src, #0
>>   	ldp1	B_l, B_h, src, #16
>> -	ldp1	C_l, C_h, src, #16
>> -	ldp1	D_l, D_h, src, #16
>> +	ldp1	C_l, C_h, src, #32
>> +	ldp1	D_l, D_h, src, #48
>> +	add	src, src, #64
>>   1:
>>   	/*
>>   	* interlace the load of next 64 bytes data block with store of the last
>>   	* loaded 64 bytes data.
>>   	*/
>> -	stp1	A_l, A_h, dst, #16
>> -	ldp1	A_l, A_h, src, #16
>> +	stp1	A_l, A_h, dst, #0
>> +	ldp1	A_l, A_h, src, #0
>>   	stp1	B_l, B_h, dst, #16
>>   	ldp1	B_l, B_h, src, #16
>> -	stp1	C_l, C_h, dst, #16
>> -	ldp1	C_l, C_h, src, #16
>> -	stp1	D_l, D_h, dst, #16
>> -	ldp1	D_l, D_h, src, #16
>> +	stp1	C_l, C_h, dst, #32
>> +	ldp1	C_l, C_h, src, #32
>> +	stp1	D_l, D_h, dst, #48
>> +	ldp1	D_l, D_h, src, #48
>> +	add	src, src, #64
>> +	add	dst, dst, #64
>>   	subs	count, count, #64
>>   	b.ge	1b
>> -	stp1	A_l, A_h, dst, #16
>> +	stp1	A_l, A_h, dst, #0
>>   	stp1	B_l, B_h, dst, #16
>> -	stp1	C_l, C_h, dst, #16
>> -	stp1	D_l, D_h, dst, #16
>> +	stp1	C_l, C_h, dst, #32
>> +	stp1	D_l, D_h, dst, #48
>> +	add	dst, dst, #64
>>   
>>   	tst	count, #0x3f
>>   	b.ne	.Ltail63
>> -.Lexitfunc:
>> +.Lexitfunc: mov	p_copy, #0
>> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
>> index 802231772608..89db19e09ca2 100644
>> --- a/arch/arm64/lib/copy_to_user.S
>> +++ b/arch/arm64/lib/copy_to_user.S
>> @@ -44,7 +44,7 @@
>>   	.endm
>>   
>>   	.macro ldp1 reg1, reg2, ptr, val
>> -	ldp \reg1, \reg2, [\ptr], \val
>> +	ldp \reg1, \reg2, [\ptr, \val]
>>   	.endm
>>   
>>   	.macro stp1 reg1, reg2, ptr, val
>> @@ -61,13 +61,25 @@ SYM_FUNC_START(__arch_copy_to_user)
>>   	ret
>>   
>>   	// Exception fixups
>> -9997:	cmp	dst, dstin
>> +9997:	sub	x7, src, srcin
>> +	sub	x8, dst, dstin
>> +	cmp	x7, x8
>> +	b.le	no_need_to_adjust_src
>> +	sub	x9, x7, x8
>> +	sub	src, src, x9
>> +	add	p_copy, p_copy, x9
>> +no_need_to_adjust_src:
>> +	cmp	dst, dstin
>>   	b.ne	9998f
>>   	// Before being absolutely sure we couldn't copy anything, try harder
>> -	ldrb	tmp1w, [srcin]
>> -USER(9998f, sttrb tmp1w, [dst])
>> +calculate_bytes_copied:
>> +	ldrb	tmp1w, [src], #1
>> +USER(9999f, sttrb tmp1w, [dst])
>>   	add	dst, dst, #1
>> -9998:	sub	x0, end, dst			// bytes not copied
>> +	sub	p_copy, p_copy, #1
>> +9998:	cmp	p_copy, 0
>> +	b.ge	calculate_bytes_copied
>> +9999:	sub	x0, end, dst			// bytes not copied
>>   	ret
>>   SYM_FUNC_END(__arch_copy_to_user)
>>   EXPORT_SYMBOL(__arch_copy_to_user)
>> -- 
>> 2.34.1
>>
> 

Best regards,
Li Zetao

