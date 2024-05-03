Return-Path: <linux-kernel+bounces-167666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598A18BAD0A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890011C21899
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2814154423;
	Fri,  3 May 2024 13:03:05 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B9152DE9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741385; cv=none; b=lGMXgeWZ0pnJCwZwxIEUjydIzLKZykC0gGhRnEBBtmypa86snbonVjgW3arAjiapYB1rpJx5UHRaBA7rqOKwXOLmBXy9ykCGiO81p3+MLQ2hUa3038wDgvlEneZqmg06rU80ZHoECU01p10DVseKz35HQlnMcC+Z7W1+2Ifw9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741385; c=relaxed/simple;
	bh=oQmjdxGYsDhXld29EHZ9WVW9GGkAFwo3EOm5ZAfbmSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrWasjLx9C+PQEBcohMN3GygcSpXJo+ZnpBEc27/9SYx6IZoahNmQGdGPYmqCA/InWxRqKjcajNlXc9hQODGNUVLh6/Sj/vMOeNWecBE6m+9uCNGazMSFEfzmQRQmyda+YQpbwx3ObwzAPTpbp7bV/OBv6z7xodSm2fmVIO+o2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A26A8E0008;
	Fri,  3 May 2024 13:02:52 +0000 (UTC)
Message-ID: <daa955d9-b554-4e0e-a08e-835c4cd5a366@ghiti.fr>
Date: Fri, 3 May 2024 15:02:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
Content-Language: en-US
To: Ben Dooks <ben.dooks@codethink.co.uk>, Xiao Wang <xiao.w.wang@intel.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: jerry.shih@sifive.com, nick.knight@sifive.com, ajones@ventanamicro.com,
 bjorn@rivosinc.com, andy.chiu@sifive.com, viro@zeniv.linux.org.uk,
 cleger@rivosinc.com, alexghiti@rivosinc.com, haicheng.li@intel.com,
 akira.tsukamoto@gmail.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240313103334.4036554-1-xiao.w.wang@intel.com>
 <7ebc5b28-7115-494f-a607-e46c71214cce@ghiti.fr>
 <4bc238eb-410b-46b1-98e1-4aaa35e34404@codethink.co.uk>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <4bc238eb-410b-46b1-98e1-4aaa35e34404@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Ben,

On 03/05/2024 14:19, Ben Dooks wrote:
> On 03/05/2024 13:16, Alexandre Ghiti wrote:
>> Hi Xiao,
>>
>> On 13/03/2024 11:33, Xiao Wang wrote:
>>> When the dst buffer pointer points to the last accessible aligned 
>>> addr, we
>>> could still run another iteration of unrolled copy.
>>>
>>> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
>>> ---
>>>   arch/riscv/lib/uaccess.S | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>>> index 2e665f8f8fcc..1399d797d81b 100644
>>> --- a/arch/riscv/lib/uaccess.S
>>> +++ b/arch/riscv/lib/uaccess.S
>>> @@ -103,7 +103,7 @@ SYM_FUNC_START(fallback_scalar_usercopy)
>>>       fixup REG_S   t4,  7*SZREG(a0), 10f
>>>       addi    a0, a0, 8*SZREG
>>>       addi    a1, a1, 8*SZREG
>>> -    bltu    a0, t0, 2b
>>> +    bleu    a0, t0, 2b
>>>       addi    t0, t0, 8*SZREG /* revert to original value */
>>>       j    .Lbyte_copy_tail
>>
>>
>> I agree it is still safe to continue for another word_copy here.
>>
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Out of interest, has anyone checked if causing a schedule event during
> this code breaks like the last time we had issues with the upstream
> testing?


I vaguely remember something, do you have a link to that discussion by 
chance?


>
> I did propose saving the state of the user-access flag in the task
> struct


Makes sense, I just took a quick look and SR_SUM is cleared as soon as 
we enter handle_exception() and it does not seem to be restored. Weird 
it works, unless I missed something!


> but we mostly solved it by making sleeping functions stay
> away from the address calculation. This of course may have been done
> already or need to be done if three's long areas where the user-access
> flags can be disabled (generally only a few drivers did this, so we
> may not have come across the problem)
>
I don't understand what you mean here, would you mind expanding a bit?

Thanks,

Alex


