Return-Path: <linux-kernel+bounces-83953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908086A07C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A41C254AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF44524D4;
	Tue, 27 Feb 2024 19:49:00 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F113AA27;
	Tue, 27 Feb 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063340; cv=none; b=AELF6b+Kb28+WMfSccZpWjmLld3kh97qxy1drnZXjaonP1fvi1036g/hicgVxVk0ci2hd/mczJxSieSiNyMQne4swoxlYBgH9h0x7a1fKm6BLyZCAYgL7m4z0/H8kxkoeacUnKuu59eKu32zgTaXlwuO8ob8wRPiV4yLyNHx/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063340; c=relaxed/simple;
	bh=T4NRM4qBfwkx48BHPpCSmvWo4swu8CkEHCR2aja6ssg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/OfqAcLcJ0Exn7dsM3r3j1JJfE51HqVTtAUMcwBubuiOh3QeZGbri5Fm8NPdUkZ+9n5dUERByp2ktHBtXF2XvEixLJtBnVdkaxiOOmYVJoiHzdDB/E1tPZ8/aWR0Q3eXqqb4RZcRunSTdQpan7xF38RzTuCaKsRYEKHqKTeDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56C4BFF802;
	Tue, 27 Feb 2024 19:48:55 +0000 (UTC)
Message-ID: <579c9f3f-8c28-4e4e-88ce-9f266597b7bd@ghiti.fr>
Date: Tue, 27 Feb 2024 20:48:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v3 1/2] riscv: Fix enabling cbo.zero when running
 in M-mode
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
References: <20240214090206.195754-1-samuel.holland@sifive.com>
 <20240214090206.195754-2-samuel.holland@sifive.com>
 <20240214-661604d82db4ef137540b762@orel>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240214-661604d82db4ef137540b762@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 14/02/2024 10:28, Andrew Jones wrote:
> On Wed, Feb 14, 2024 at 01:01:56AM -0800, Samuel Holland wrote:
>> When the kernel is running in M-mode, the CBZE bit must be set in the
>> menvcfg CSR, not in senvcfg.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v1)
>>
>>   arch/riscv/include/asm/csr.h   | 2 ++
>>   arch/riscv/kernel/cpufeature.c | 2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>> index 510014051f5d..2468c55933cd 100644
>> --- a/arch/riscv/include/asm/csr.h
>> +++ b/arch/riscv/include/asm/csr.h
>> @@ -424,6 +424,7 @@
>>   # define CSR_STATUS	CSR_MSTATUS
>>   # define CSR_IE		CSR_MIE
>>   # define CSR_TVEC	CSR_MTVEC
>> +# define CSR_ENVCFG	CSR_MENVCFG
>>   # define CSR_SCRATCH	CSR_MSCRATCH
>>   # define CSR_EPC	CSR_MEPC
>>   # define CSR_CAUSE	CSR_MCAUSE
>> @@ -448,6 +449,7 @@
>>   # define CSR_STATUS	CSR_SSTATUS
>>   # define CSR_IE		CSR_SIE
>>   # define CSR_TVEC	CSR_STVEC
>> +# define CSR_ENVCFG	CSR_SENVCFG
>>   # define CSR_SCRATCH	CSR_SSCRATCH
>>   # define CSR_EPC	CSR_SEPC
>>   # define CSR_CAUSE	CSR_SCAUSE
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 89920f84d0a3..c5b13f7dd482 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -950,7 +950,7 @@ arch_initcall(check_unaligned_access_all_cpus);
>>   void riscv_user_isa_enable(void)
>>   {
>>   	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
>> -		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
>> +		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>>   }
>>   
>>   #ifdef CONFIG_RISCV_ALTERNATIVE
>> -- 
>> 2.43.0
>>
> After our back and forth on how we determine the existence of the *envcfg
> CSRs, I wonder if we shouldn't put a comment above this
> riscv_user_isa_enable() function capturing the [current] decision.
>
> Something like
>
>   /*
>    * While the [ms]envcfg CSRs weren't defined until priv spec 1.12,
>    * they're assumed to be present when an extension is present which
>    * specifies [ms]envcfg bit(s). Hence, we don't do any additional
>    * priv spec version checks or CSR probes here.
>    */


I was about to read the whole discussion in v2 to understand the 
v3...thank you Drew :) I think it really makes sense to add this 
comment, do you intend to do so Samuel?

Thanks,

Alex


>
> Thanks,
> drew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

