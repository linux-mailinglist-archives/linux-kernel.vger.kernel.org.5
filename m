Return-Path: <linux-kernel+bounces-55075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F784B751
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AE41C20DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFA131757;
	Tue,  6 Feb 2024 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Yrktoror"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F9131724
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228251; cv=none; b=s/9tFMRCBU8d5vW4raGFVXAD1dbo5f9g/9EeGNz6CkPjnpnJK7/vvMHmw++cHqD3NiRQbN2sT6LgD7a8P/63vB2pCUP9wcLT+oEtqggxazGhEG9vEatExjy9Pb//R+rVXCe7D53din6Lr9AVonfLM98LlyQMIaEcnkVxJkJ6TR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228251; c=relaxed/simple;
	bh=lZquMLmrGxAv0t7rzyW73sNQjjRh4WbV++BVeQAinI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzkotMl7gZ9SmNMbSRKdbPtLXe8xYQDZfXjuHFUlrL6GEPzHzMdCkyLZhAjogvJfwzU+Qj06AhZULEbv56XdLxstDzYiW0lZh89zmneQ9rr4OhJS8s+u6jm1abjFF7NCmG/XKAD+8debnuQ1Bg7UwLvSVig0MFtvtNnFTk9ICpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Yrktoror; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40f030bf978so9856365e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707228247; x=1707833047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKWoarfobpKyGtCpM9eTO32HQXDHwnoM3X9MJI3e2No=;
        b=YrktororJ4UwFHCHvrUeTtwhaHe3cHwxsLZ4lLAOcFqTohtJmtdN3MggvTdfLvWNUS
         cdMQ+ar0Y2kWzMWkeTIY1qxunIRuYgfMStxB1s8loEE48PJ1/v/8XHMVVKEt0Bm5sgBe
         PJQKVnKsZlbTa1OiExhrfn2qik71pDuZGwFP48wYpAXh6Yj1DfXqGyQ+TA78sUaBsT3K
         C2DGiRe91eAERtOsB+ZL3z0DtqrOJVY5XRm2rYXpDOAf+JTzO1Ly0Iz8jLNwqCWS4FzQ
         YMBvxiSbni9sP0HrdKNpGe8leHN0c3S/Hx1k1P32T/qIBKnX01R6h76oC21CHtfrPqie
         svRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707228247; x=1707833047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKWoarfobpKyGtCpM9eTO32HQXDHwnoM3X9MJI3e2No=;
        b=SrvZjoV4jd0sonMYjSjhRuwHkbF6/I79sLHNu4353ei8zFavC3dAbnmutxxPPIKRQJ
         OAV/+sUIuUKxHW0Y8UUnM6W2hZfIS8GmHCssQtizpCHlvsQoYTmJWP0zLQAFr8M13nED
         Maat1kYMtqx+oaFafb3xMhzoBxOPdxl9wqcPvX+zGbXA3aMJ2pOed7+J6xXh7bEvRlhl
         b08etYhJgSuPJ/avlERrXYn51zGi1wxPfVKH/8Vc4cEwRfx15R4ETe9MsBmduZkojwE3
         ERFet4/ld/yDwgXSazO7xD0S3XGWWeev4ynEWvfr/J4e4YHEPfWOJEJoqzWAFHw5HP2q
         0TVg==
X-Gm-Message-State: AOJu0Yyxmbt1z3CNV3ZZVyQM0//5MEP7iRzS1ll3WmmXWzG51GbZnmS5
	FuadRAOvy9i3xiK5U5P5wUolYdjIajKGF5o7KZbZCmheYZm11mV3YY8eeCDSmQM=
X-Google-Smtp-Source: AGHT+IGdY2ysYd9v/jru4nS0+Rf05r4hG4rRcUVGmBgMYKc+Z1JU32zV4h+/J+2szgKl5TsjOzu99w==
X-Received: by 2002:a05:600c:1d07:b0:40f:dd10:180f with SMTP id l7-20020a05600c1d0700b0040fdd10180fmr2188781wms.3.1707228246657;
        Tue, 06 Feb 2024 06:04:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/yQfQtY4heRilZc+jxeORQ5S6ks+8nh4kKeNsu5YVZm55NIHizx6nboz9gvf8pPrIycr43RV5uccWxa+IFhta45baId3gq94rW4g0yke6eKaMqj3+zoLU1wII+LmooA+RmL9tkH/1KM6yj98c6QTUUXWiWe/dJHrsgaqXqebkOnPIkVXySIvMb8IkCwSby69x4sJX5dI/R8374rRFeO/WpY7PXa/EJY2PYS8HqJMVkMa2eFSYqW88R2OzeKRLLw748vFEwHMEd+L1mQUfd+fqD8cV4Zl0dc3BowVqrnhQ
Received: from ?IPV6:2a01:e0a:999:a3a0:20a2:d2ee:941a:156e? ([2a01:e0a:999:a3a0:20a2:d2ee:941a:156e])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b0040e3bdff98asm2189842wmq.23.2024.02.06.06.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:04:06 -0800 (PST)
Message-ID: <b15ac1d0-a5dd-4b4e-83e5-86c706b095ea@rivosinc.com>
Date: Tue, 6 Feb 2024 15:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: misaligned: remove CONFIG_RISCV_M_MODE specific
 code
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Ben Dooks
 <ben.dooks@codethink.co.uk>, David Laight <David.Laight@aculab.com>
References: <20231128165206.589240-1-cleger@rivosinc.com>
 <ZcGPWrGRi92Chtj8@ghost>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZcGPWrGRi92Chtj8@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/02/2024 02:46, Charlie Jenkins wrote:
> On Tue, Nov 28, 2023 at 05:52:06PM +0100, Clément Léger wrote:
>> While reworking code to fix sparse errors, it appears that the
>> RISCV_M_MODE specific could actually be removed and use the one for
>> normal mode. Even though RISCV_M_MODE can do direct user memory access,
>> using the user uaccess helpers is also going to work. Since there is no
>> need anymore for specific accessors (load_u8()/store_u8()), we can
>> directly use memcpy()/copy_{to/from}_user() and get rid of the copy
>> loop entirely. __read_insn() is also fixed to use an unsigned long
>> instead of a pointer which was cast in __user address space. The
>> insn_addr parameter is now cast from unsigned long to the correct
>> address space directly.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>
>> Notes: This patch is a complete rework of a previous one [1] and thus is
>> not a V3.
>>
>> [1] https://lore.kernel.org/linux-riscv/d156242a-f104-4925-9736-624a4ba8210d@rivosinc.com/
>> ---
>>  arch/riscv/kernel/traps_misaligned.c | 108 +++++----------------------
>>  1 file changed, 18 insertions(+), 90 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index 5eba37147caa..38af97f4819c 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -264,86 +264,14 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
>>  #define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
>>  #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
>>  
>> -#ifdef CONFIG_RISCV_M_MODE
>> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>> -{
>> -	u8 val;
>> -
>> -	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
>> -	*r_val = val;
>> -
>> -	return 0;
>> -}
>> -
>> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>> -{
>> -	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
>> -
>> -	return 0;
>> -}
>> -
>> -static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
>> -{
>> -	register ulong __mepc asm ("a2") = mepc;
>> -	ulong val, rvc_mask = 3, tmp;
>> -
>> -	asm ("and %[tmp], %[addr], 2\n"
>> -		"bnez %[tmp], 1f\n"
>> -#if defined(CONFIG_64BIT)
>> -		__stringify(LWU) " %[insn], (%[addr])\n"
>> -#else
>> -		__stringify(LW) " %[insn], (%[addr])\n"
>> -#endif
>> -		"and %[tmp], %[insn], %[rvc_mask]\n"
>> -		"beq %[tmp], %[rvc_mask], 2f\n"
>> -		"sll %[insn], %[insn], %[xlen_minus_16]\n"
>> -		"srl %[insn], %[insn], %[xlen_minus_16]\n"
>> -		"j 2f\n"
>> -		"1:\n"
>> -		"lhu %[insn], (%[addr])\n"
>> -		"and %[tmp], %[insn], %[rvc_mask]\n"
>> -		"bne %[tmp], %[rvc_mask], 2f\n"
>> -		"lhu %[tmp], 2(%[addr])\n"
>> -		"sll %[tmp], %[tmp], 16\n"
>> -		"add %[insn], %[insn], %[tmp]\n"
>> -		"2:"
>> -	: [insn] "=&r" (val), [tmp] "=&r" (tmp)
>> -	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
>> -	  [xlen_minus_16] "i" (XLEN_MINUS_16));
>> -
>> -	*r_insn = val;
>> -
>> -	return 0;
>> -}
>> -#else
>> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>> -{
>> -	if (user_mode(regs)) {
>> -		return __get_user(*r_val, addr);
>> -	} else {
>> -		*r_val = *addr;
>> -		return 0;
>> -	}
>> -}
>> -
>> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
>> -{
>> -	if (user_mode(regs)) {
>> -		return __put_user(val, addr);
>> -	} else {
>> -		*addr = val;
>> -		return 0;
>> -	}
>> -}
>> -
>> -#define __read_insn(regs, insn, insn_addr)		\
>> +#define __read_insn(regs, insn, insn_addr, type)	\
>>  ({							\
>>  	int __ret;					\
>>  							\
>> -	if (user_mode(regs)) {				\
>> -		__ret = __get_user(insn, insn_addr);	\
>> +	if (user_mode(regs)) { \
> Nit: formatting was changed here (previous indentation seems better)

Acked.

> 
>> +		__ret = __get_user(insn, (type __user *) insn_addr); \
>>  	} else {					\
>> -		insn = *insn_addr;			\
>> +		insn = *(type *)insn_addr;		\
>>  		__ret = 0;				\
>>  	}						\
>>  							\
>> @@ -356,9 +284,8 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>>  
>>  	if (epc & 0x2) {
>>  		ulong tmp = 0;
>> -		u16 __user *insn_addr = (u16 __user *)epc;
>>  
>> -		if (__read_insn(regs, insn, insn_addr))
>> +		if (__read_insn(regs, insn, epc, u16))
>>  			return -EFAULT;
>>  		/* __get_user() uses regular "lw" which sign extend the loaded
>>  		 * value make sure to clear higher order bits in case we "or" it
>> @@ -369,16 +296,14 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>>  			*r_insn = insn;
>>  			return 0;
>>  		}
>> -		insn_addr++;
>> -		if (__read_insn(regs, tmp, insn_addr))
>> +		epc += sizeof(u16);
>> +		if (__read_insn(regs, tmp, epc, u16))
>>  			return -EFAULT;
>>  		*r_insn = (tmp << 16) | insn;
>>  
>>  		return 0;
>>  	} else {
>> -		u32 __user *insn_addr = (u32 __user *)epc;
>> -
>> -		if (__read_insn(regs, insn, insn_addr))
>> +		if (__read_insn(regs, insn, epc, u32))
>>  			return -EFAULT;
>>  		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
>>  			*r_insn = insn;
>> @@ -390,7 +315,6 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>>  		return 0;
>>  	}
>>  }
>> -#endif
>>  
>>  union reg_data {
>>  	u8 data_bytes[8];
>> @@ -409,7 +333,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>>  	unsigned long epc = regs->epc;
>>  	unsigned long insn;
>>  	unsigned long addr = regs->badaddr;
>> -	int i, fp = 0, shift = 0, len = 0;
>> +	int fp = 0, shift = 0, len = 0;
>>  
>>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>>  
>> @@ -490,9 +414,11 @@ int handle_misaligned_load(struct pt_regs *regs)
>>  		return -EOPNOTSUPP;
>>  
>>  	val.data_u64 = 0;
>> -	for (i = 0; i < len; i++) {
>> -		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
>> +	if (user_mode(regs)) {
>> +		if (raw_copy_from_user(&val, (u8 __user *)addr, len))
>>  			return -1;
>> +	} else {
>> +		memcpy(&val, (u8 *)addr, len);
>>  	}
>>  
>>  	if (!fp)
>> @@ -513,7 +439,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>>  	unsigned long epc = regs->epc;
>>  	unsigned long insn;
>>  	unsigned long addr = regs->badaddr;
>> -	int i, len = 0, fp = 0;
>> +	int len = 0, fp = 0;
>>  
>>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>>  
>> @@ -588,9 +514,11 @@ int handle_misaligned_store(struct pt_regs *regs)
>>  	if (!IS_ENABLED(CONFIG_FPU) && fp)
>>  		return -EOPNOTSUPP;
>>  
>> -	for (i = 0; i < len; i++) {
>> -		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
>> +	if (user_mode(regs)) {
>> +		if (raw_copy_to_user((u8 __user *)addr, &val, len))
>>  			return -1;
>> +	} else {
>> +		memcpy((u8 *)addr, &val, len);
>>  	}
>>  
>>  	regs->epc = epc + INSN_LEN(insn);
>> -- 
>> 2.42.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> The changes here logically make sense but I don't know how to test this
> misaligned access code on M-mode or in S-mode. Can you provide how this
> was tested?

The test used to validate these changes is the one used originally for
S-mode misaligned support:

https://github.com/clementleger/unaligned_test

This test exercise (almost) all the supported instructions, all the
registers for FPU instructions and is compiled with and without
compressed instructions.

For S-mode, you simply need a classic toolchain and export CROSS_COMPILE
to match it.

For M-mode validation, I used the following commands:

Buildroot toolchain:
$ make O=build_nommu qemu_riscv64_nommu_virt_defconfig

Test:
$ git clone https://github.com/clementleger/unaligned_test.git
$ cd unaligned_test
$ make CFLAGS="-fPIC -Wl,-elf2flt=-r"
CROSS_COMPILE=<buildroot>/build_nommu/host/bin/riscv64-buildroot-linux-uclibc-

Copy the resulting elf files (unaligned & unaligned_c) to buildroot
rootfs and rebuild it.

Kernel:
$ make O=build_nommu nommu_virt_defconfig
$ make O=build_nommu loader

Either set the kernel initramfs or provide one on spike command line
using the one built with buildroot

Then to run it on spike (QEMU always emulate misaligned accesses and
won't generate any misaligned exception):

$ spike <kernel>/build_nommu/loader

And finally execute the tests.

Clément


> 
> There are also some merge conflicts that were introduced in 6.8-rc1.
> 
> - Charlie
> 

