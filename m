Return-Path: <linux-kernel+bounces-101063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79187A1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF42B1F22EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6869DDA2;
	Wed, 13 Mar 2024 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KXWf/hiA"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8CC13D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299142; cv=none; b=Cg3k51Krhro2u4moWjhURsGlbYP9jevGUkP7fruNQa4PGW2fvQyqoQXvlpluWbxDNPRBirEQ+tE172DNz5Ll3QB3T1v++1d52/T6GAZr6GxarU3i6DgV9QYLZx/TNWPIdX5uA3uEZ3ltlWwJApIMzmFCmIQfVQXh/GWudICE0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299142; c=relaxed/simple;
	bh=5AQVABSCCPA3GxKzRQmLPhnBYQjFMLEJmUur/wYzlLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHogJ2KIpN9xVBOJ4S1u7EM0L6+sVs/jeMNku/HdbZx7XWiFc2hXPAYwDfzQHimzfvqqvvcrBdnrYtxpBpxiCaNxOj5AhsmO3RTrA4lfupRBhCvibcbvQ3S0tcem/3cm836EfvNBQPTxyNLTPynJ4rPxS6dTrE66bHiGNSDoWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KXWf/hiA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7810827e54eso462997885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710299139; x=1710903939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kbf82l7XAPAahjc9O+Lns4/hY3cNPQ6gdkwG4sxvUl4=;
        b=KXWf/hiAgPhAg7RsRLiDIUDtk35k7JBDA2mZZ4tXMCv6fAEeKjQSlyIx/ND7e5z79p
         bYH/7CeOztnMA6UsLu8mnxJW1585NIzgGqTNY0U3C0xy1jvnLRA+G84zFxmeZ/7dck4y
         6v8dRkIMoqQJgKZtXIllrHSrmGHpj1yirtUnpjZUVnpSkCN1kSciwza+oMnnS760rkwz
         2YIifbIAnXG22TflrIjkAXUII7A0vhxJU2WWb7y5CfdfeTim1PpLe0yPK0/z6YJcPSv5
         7sBVVXNSk9/S9IjIROpCfoqBx4Tmw85dqRDgAbg9PiJJiVfc2acGGAGIupdT3ItI2TiM
         VwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710299139; x=1710903939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbf82l7XAPAahjc9O+Lns4/hY3cNPQ6gdkwG4sxvUl4=;
        b=PkAL9Z4ZIZXKDAk/Gk//UFti21lDO4UmZFwEs2+49uIfZAzCCB2zxzh+7msNnIQjvg
         O2/TJ1XF1pcQvl0XoWQ6cjAkfBEr3iUVZaG3l+E0/H+sjVWH7LyAaSZ7DE55GnF//zJ+
         UGrQtyytIYno8JWjLmK7geRs6wvUHH0KYf5uMLQFvunwV1HdEEs3mM0kK9rCb2FdEjP0
         vb+g9XJj/q5gVh6s/aAH7Y2cfpABvNnUyhCCCST/06Je6eyYXDa//BpkdluPwHHa53DN
         ggK3+Nj+0+8oS3gIKAGLYeQzuNgMC/Rkgg6H23FhFljedpw0JBbASQwDIb0yApOWxv/r
         LdBw==
X-Forwarded-Encrypted: i=1; AJvYcCUGItUZeUv3fSrARJSuJc55Tuj8E5VOXrxuR+dGRggZ44CD6SQC9uOw77PvrtKxFSuPB+4HQPqLCdATf2J1ZD3QDC1VFVSmBkXAW1hB
X-Gm-Message-State: AOJu0YyWAKDaabpLZTAnFu+2W/CcDnTI38MkGt+pCb7YLq9Q1HurUHbA
	uvtSKDMOHu97ae2MfXnl0wNfRa1wms+iIVfdzuKEyHJlJf4MXMEGlUgxryg+qUk=
X-Google-Smtp-Source: AGHT+IGFDeMhxikLP+fXFmb/qaz+LTzsQ4Ifr2IOlIDzBr+zLzd26Ujac9cPg6+HSOdBcVSQtUKFiQ==
X-Received: by 2002:ae9:c202:0:b0:788:7299:e79a with SMTP id j2-20020ae9c202000000b007887299e79amr5796096qkg.28.1710299139369;
        Tue, 12 Mar 2024 20:05:39 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a248b00b0078874151152sm1943779qkn.18.2024.03.12.20.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 20:05:39 -0700 (PDT)
Message-ID: <06ebe952-c872-4406-bcb9-00b0b892fb6c@sifive.com>
Date: Tue, 12 Mar 2024 22:05:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix spurious errors from __get/put_kernel_nofault
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240312022030.320789-1-samuel.holland@sifive.com>
 <ZfEVNbt9AMeVJS0k@ghost>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZfEVNbt9AMeVJS0k@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-12 9:53 PM, Charlie Jenkins wrote:
> On Mon, Mar 11, 2024 at 07:19:13PM -0700, Samuel Holland wrote:
>> These macros did not initialize __kr_err, so they could fail even if
>> the access did not fault.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d464118cdc41 ("riscv: implement __get_kernel_nofault and __put_user_nofault")
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>> Found while testing the unaligned access speed series[1]. The observed
>> behavior was that with RISCV_EFFICIENT_UNALIGNED_ACCESS=y, the
>> copy_from_kernel_nofault() in prepend_copy() failed every time when
>> filling out /proc/self/mounts, so all of the mount points were "xxx".
>>
>> I'm surprised this hasn't been seen before. For reference, I'm compiling
>> with clang 18.
>>
>> [1]: https://lore.kernel.org/linux-riscv/20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com/
>>
>>  arch/riscv/include/asm/uaccess.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
>> index ec0cab9fbddd..72ec1d9bd3f3 100644
>> --- a/arch/riscv/include/asm/uaccess.h
>> +++ b/arch/riscv/include/asm/uaccess.h
>> @@ -319,7 +319,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>>  
>>  #define __get_kernel_nofault(dst, src, type, err_label)			\
>>  do {									\
>> -	long __kr_err;							\
>> +	long __kr_err = 0;						\
>>  									\
>>  	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
>>  	if (unlikely(__kr_err))						\
>> @@ -328,7 +328,7 @@ do {									\
>>  
>>  #define __put_kernel_nofault(dst, src, type, err_label)			\
>>  do {									\
>> -	long __kr_err;							\
>> +	long __kr_err = 0;						\
>>  									\
>>  	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
>>  	if (unlikely(__kr_err))						\
>> -- 
>> 2.43.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> I am not able to reproduce this using Clang 18 with
> RISCV_EFFICIENT_UNALIGNED_ACCESS=y on 6.8. However I can see how this
> could be an issue.
> 
> Going down the rabbit hold of macros here, I end up at
> arch/riscv/include/asm/asm-extable.h where the register that hold 'err'
> is written into the __ex_table section:
> 
> #define EX_DATA_REG(reg, gpr)						\
> 	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
> 
> #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
> 	__DEFINE_ASM_GPR_NUMS						\
> 	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
> 			  __stringify(EX_TYPE_UACCESS_ERR_ZERO),	\
> 			  "("						\
> 			    EX_DATA_REG(ERR, err) " | "			\
> 			    EX_DATA_REG(ZERO, zero)			\
> 			  ")")
> 
> I am wondering if setting this value to zero solves the problem by
> hiding another issue. It seems like this shouldn't need to be
> initialized to zero, however I am lost as to how this extable setup
> works so perhaps this is the proper solution.

extable works by running the handler (selected by EX_TYPE_*) if some exception
occurs while executing that instruction -- see the calls to fixup_exception() in
fault.c and traps.c. If there is no exception, then the handler does not run,
and the err register is not written by ex_handler_uaccess_err_zero().

If you look at __get_user_asm(), you can see that the err register is not
touched by the assembly code at all -- the only reference to %0 is in the
extable entry. So if the macro that declares the error variable doesn't
initialize it, nothing will.

Compare __get_user() and __put_user() which do initialize their error variable.

Regards,
Samuel


