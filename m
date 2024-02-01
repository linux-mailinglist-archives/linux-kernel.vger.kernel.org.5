Return-Path: <linux-kernel+bounces-48258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59A2845935
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D580293707
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CBE5D46D;
	Thu,  1 Feb 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2V8fpxr5"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B471B5CDF5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795201; cv=none; b=MxVMyD9FBBxiD+LmjC9DIptCdeSs0cJ4NaYtcxE4mjNbymjrEIgfK26yfv97ZOq9b0ULLwoj13zTwnE1gG2X4PwsUtT1CymbXmAlDdWXm1fOtnZ7EeyfxdaG8AFZBCkntHfzlrlvbk+uGum0EV6BzwZcJu2yby7p0GJ9tFZzP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795201; c=relaxed/simple;
	bh=9IKstakBakGCbgqw96jiaW89QVjpGs65PcztQ3qiHfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hu2unkEljUCenctIR32J+5UWQyPctuk/Z0YfUKAsVZUi+7bJauizYWhLpg5mkW5HUz74Uy/0T+KEdFp/OxOFJxkdTs5ODvZwJlwv+dIMhSe6Svtz/oT0QYSlJS5gjZe5b+NYnfnYNuJiRw7dFrcRpskqBbmL3Bs7IjOXIYQu52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2V8fpxr5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29593a27fcaso234980a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706795199; x=1707399999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZFa+LNfa3OVO8BZQTtB6GNguhTEIHIMl1CK3meQbk0=;
        b=2V8fpxr5VKwgdWoiryJAJE0R8M6C2VEYbQ+UQZpOJKmDSKYFtM9Pn2Y1bEAedXWnBk
         z96GNNkY7V6al95TihsQVhPgGR6VqfOFYC25WGznOKx/cjejaRhilFjIin/pTi/zECso
         Ilrgr0j4It0cSOycj0ux8ecuEvERUK8U7tAh1S9hiJ5hNj4ZdVrtSIWvGA+J3Wm+inbc
         HsRm6lX6ywfCOeXxFUlOYOpu4eHmCA63p8+GklaN/NB8ZTogP+Jq+Mh9oV8BakcGBx9y
         QFo1TAhXatuGk+XKZaf5Pi/zdDVhN1eDh0gtpwgiyZuvCLGZxx8ipU+D8Tqz13P+aMmP
         M3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795199; x=1707399999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZFa+LNfa3OVO8BZQTtB6GNguhTEIHIMl1CK3meQbk0=;
        b=Pf845AnOLBMpDVYKQMQ/TySfvqAxWdGwsHaC0xHmE04cwQ6V0no8oZoyW3Bdr6Qw5A
         UTn/K63G6URcJsl1MXOjmyDRsC1w5j77GiPjUmONHOyWRayEyIe9frvqA4AMCTHF23cw
         1GXWQJD2ZdsQdyNVF0afa0a2KsAdPJkg+F3kmDDQKx5ApmMgGB+pD1cFMWCrjhayQmW6
         A05T0DyDMUFstKewcj68IEYlw5OPGivhfkVy0Cw2ENi7Y82Y9/k7oR9Q7BiuVSY4PdRY
         IO83BjLwEeOhiHtW1bNcvQ/9evUlIF0BTd5xB9uwYkUK3m9Eu3AwfhO7wjnL5qSFVpFr
         +oKw==
X-Forwarded-Encrypted: i=0; AJvYcCVrSPZnxy0t+c6VNtONuLGNz458AK7fZ6Sx5ij1ZKtxZ/+zkmuZJFkmbPxt9diZUq3ubdEDPQPb3/pCwUnzzm/UuZKt1xuw6n+gN4SV
X-Gm-Message-State: AOJu0YzmxFYt8+P6498KQsEvY2UKRD95QpyGDlo0MdRQ/X6g/z0DPToF
	mD5Y0GutvyOYtHnl0FPYXRAIJGBUGmywa7kUDaaaNi8JfQS2WQHgXXvc/tRKhgs=
X-Google-Smtp-Source: AGHT+IHIqDU9S+2aKCCCjOYslFLHgHltlcOCZPFzV1O5LPJ9qhc8imhSiPiYmfIbuqO/dgdxrhgcEw==
X-Received: by 2002:a05:6a20:7d8c:b0:19e:3681:6651 with SMTP id v12-20020a056a207d8c00b0019e36816651mr2761933pzj.3.1706795198739;
        Thu, 01 Feb 2024 05:46:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0ZQv1avPu6WtHMSN5E18SCQhuJCPmHTfypmA3KV/L0crHb2C2D/JppZxK3MmuKsqAhqbINcxY5edCcauDvDMhM9zUfkJB0UCV4pbQGHLv+/7suYJWLVsgAwY2kM07GymT4yYeoc58ZLIp67EncmBR3o167ocf+B5W/oZQde4UCDt4xV9jXLwQANn9aHWW7ELw1D0YeKRwVdJaEPOlN4o/Sp5diPK0+7RdjXtWSG1kjsYB28BW6p1PdMz8TMeZjJZdIgrnhcRbwbVVK/4=
Received: from ?IPV6:2a01:e0a:999:a3a0:189:f9cd:e10f:7a3f? ([2a01:e0a:999:a3a0:189:f9cd:e10f:7a3f])
        by smtp.gmail.com with ESMTPSA id f15-20020aa79d8f000000b006dd872c00dasm12149955pfq.96.2024.02.01.05.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:46:38 -0800 (PST)
Message-ID: <11229bf2-01f4-4219-b358-d5db57038838@rivosinc.com>
Date: Thu, 1 Feb 2024 14:46:30 +0100
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
To: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, David Laight <David.Laight@ACULAB.COM>
References: <20231128165206.589240-1-cleger@rivosinc.com>
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231128165206.589240-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ping ?

On 28/11/2023 17:52, Clément Léger wrote:
> While reworking code to fix sparse errors, it appears that the
> RISCV_M_MODE specific could actually be removed and use the one for
> normal mode. Even though RISCV_M_MODE can do direct user memory access,
> using the user uaccess helpers is also going to work. Since there is no
> need anymore for specific accessors (load_u8()/store_u8()), we can
> directly use memcpy()/copy_{to/from}_user() and get rid of the copy
> loop entirely. __read_insn() is also fixed to use an unsigned long
> instead of a pointer which was cast in __user address space. The
> insn_addr parameter is now cast from unsigned long to the correct
> address space directly.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
> 
> Notes: This patch is a complete rework of a previous one [1] and thus is
> not a V3.
> 
> [1] https://lore.kernel.org/linux-riscv/d156242a-f104-4925-9736-624a4ba8210d@rivosinc.com/
> ---
>  arch/riscv/kernel/traps_misaligned.c | 108 +++++----------------------
>  1 file changed, 18 insertions(+), 90 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 5eba37147caa..38af97f4819c 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -264,86 +264,14 @@ static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
>  #define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
>  #define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
>  
> -#ifdef CONFIG_RISCV_M_MODE
> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> -{
> -	u8 val;
> -
> -	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
> -	*r_val = val;
> -
> -	return 0;
> -}
> -
> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> -{
> -	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
> -
> -	return 0;
> -}
> -
> -static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
> -{
> -	register ulong __mepc asm ("a2") = mepc;
> -	ulong val, rvc_mask = 3, tmp;
> -
> -	asm ("and %[tmp], %[addr], 2\n"
> -		"bnez %[tmp], 1f\n"
> -#if defined(CONFIG_64BIT)
> -		__stringify(LWU) " %[insn], (%[addr])\n"
> -#else
> -		__stringify(LW) " %[insn], (%[addr])\n"
> -#endif
> -		"and %[tmp], %[insn], %[rvc_mask]\n"
> -		"beq %[tmp], %[rvc_mask], 2f\n"
> -		"sll %[insn], %[insn], %[xlen_minus_16]\n"
> -		"srl %[insn], %[insn], %[xlen_minus_16]\n"
> -		"j 2f\n"
> -		"1:\n"
> -		"lhu %[insn], (%[addr])\n"
> -		"and %[tmp], %[insn], %[rvc_mask]\n"
> -		"bne %[tmp], %[rvc_mask], 2f\n"
> -		"lhu %[tmp], 2(%[addr])\n"
> -		"sll %[tmp], %[tmp], 16\n"
> -		"add %[insn], %[insn], %[tmp]\n"
> -		"2:"
> -	: [insn] "=&r" (val), [tmp] "=&r" (tmp)
> -	: [addr] "r" (__mepc), [rvc_mask] "r" (rvc_mask),
> -	  [xlen_minus_16] "i" (XLEN_MINUS_16));
> -
> -	*r_insn = val;
> -
> -	return 0;
> -}
> -#else
> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> -{
> -	if (user_mode(regs)) {
> -		return __get_user(*r_val, addr);
> -	} else {
> -		*r_val = *addr;
> -		return 0;
> -	}
> -}
> -
> -static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
> -{
> -	if (user_mode(regs)) {
> -		return __put_user(val, addr);
> -	} else {
> -		*addr = val;
> -		return 0;
> -	}
> -}
> -
> -#define __read_insn(regs, insn, insn_addr)		\
> +#define __read_insn(regs, insn, insn_addr, type)	\
>  ({							\
>  	int __ret;					\
>  							\
> -	if (user_mode(regs)) {				\
> -		__ret = __get_user(insn, insn_addr);	\
> +	if (user_mode(regs)) { \
> +		__ret = __get_user(insn, (type __user *) insn_addr); \
>  	} else {					\
> -		insn = *insn_addr;			\
> +		insn = *(type *)insn_addr;		\
>  		__ret = 0;				\
>  	}						\
>  							\
> @@ -356,9 +284,8 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>  
>  	if (epc & 0x2) {
>  		ulong tmp = 0;
> -		u16 __user *insn_addr = (u16 __user *)epc;
>  
> -		if (__read_insn(regs, insn, insn_addr))
> +		if (__read_insn(regs, insn, epc, u16))
>  			return -EFAULT;
>  		/* __get_user() uses regular "lw" which sign extend the loaded
>  		 * value make sure to clear higher order bits in case we "or" it
> @@ -369,16 +296,14 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>  			*r_insn = insn;
>  			return 0;
>  		}
> -		insn_addr++;
> -		if (__read_insn(regs, tmp, insn_addr))
> +		epc += sizeof(u16);
> +		if (__read_insn(regs, tmp, epc, u16))
>  			return -EFAULT;
>  		*r_insn = (tmp << 16) | insn;
>  
>  		return 0;
>  	} else {
> -		u32 __user *insn_addr = (u32 __user *)epc;
> -
> -		if (__read_insn(regs, insn, insn_addr))
> +		if (__read_insn(regs, insn, epc, u32))
>  			return -EFAULT;
>  		if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) {
>  			*r_insn = insn;
> @@ -390,7 +315,6 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
>  		return 0;
>  	}
>  }
> -#endif
>  
>  union reg_data {
>  	u8 data_bytes[8];
> @@ -409,7 +333,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>  	unsigned long epc = regs->epc;
>  	unsigned long insn;
>  	unsigned long addr = regs->badaddr;
> -	int i, fp = 0, shift = 0, len = 0;
> +	int fp = 0, shift = 0, len = 0;
>  
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
> @@ -490,9 +414,11 @@ int handle_misaligned_load(struct pt_regs *regs)
>  		return -EOPNOTSUPP;
>  
>  	val.data_u64 = 0;
> -	for (i = 0; i < len; i++) {
> -		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
> +	if (user_mode(regs)) {
> +		if (raw_copy_from_user(&val, (u8 __user *)addr, len))
>  			return -1;
> +	} else {
> +		memcpy(&val, (u8 *)addr, len);
>  	}
>  
>  	if (!fp)
> @@ -513,7 +439,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	unsigned long epc = regs->epc;
>  	unsigned long insn;
>  	unsigned long addr = regs->badaddr;
> -	int i, len = 0, fp = 0;
> +	int len = 0, fp = 0;
>  
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>  
> @@ -588,9 +514,11 @@ int handle_misaligned_store(struct pt_regs *regs)
>  	if (!IS_ENABLED(CONFIG_FPU) && fp)
>  		return -EOPNOTSUPP;
>  
> -	for (i = 0; i < len; i++) {
> -		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
> +	if (user_mode(regs)) {
> +		if (raw_copy_to_user((u8 __user *)addr, &val, len))
>  			return -1;
> +	} else {
> +		memcpy((u8 *)addr, &val, len);
>  	}
>  
>  	regs->epc = epc + INSN_LEN(insn);

