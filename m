Return-Path: <linux-kernel+bounces-148364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702298A8185
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA281C218CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293D13C81C;
	Wed, 17 Apr 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A9w10OeQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497036A02E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351760; cv=none; b=leZXUQO2U7x0Tix+tQK0Y7IRsM57Llo7MZsRW/eVnwdbCFMaIhvPYCBtQ0bAadrmaPh7GRi/rPuEEARsb+jGnW21VLP+QwfdVrp4ksPQQSaFnM3sdHqnGoKKM0SEw87p/JPZP9VqKAynmI6k1O4Cnrl8QmhDfqRMzge0DMRyRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351760; c=relaxed/simple;
	bh=Bxcf5DrN5rW7x4ED4yBNra/B/MhC1bA9RU+os6Ht7vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8/p9boT8K1C3vXXvVn/Y5jEay175ejW7O/7DK5XkS3nIRIw090+qsok+PCyK+ANc6k66voGpboz23TGscPaOs9DcRf2+t1/rMAguy5AYwmNUFgunArvWo2D9xajIeF5vEc26w5d72wbIBh596vRAqr0R732sR2lIg/cMoJeDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A9w10OeQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343d1003106so3843260f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713351756; x=1713956556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKc6zNttBr/4gkhSe3lbFoZGXxpmXb1Bln3h/MbJvp0=;
        b=A9w10OeQ9a1RlgFadcK/v9iId8Fj7cuTMjQ7xOrGaIhJ7XpJjuThzvMI1jp6h9R/nj
         tYw2oqzCw6r0+G2rx9BxnNhSfTJX+9vlokH0bizQh/b1x8xVuqWwDKGVfLlN29KemtBx
         710/th2uPr7xs//CpjTfTw44/G7X7G2w2cD/CpTQ7vPFOcf2b0p5/MiiR8uXOQ819I0g
         g7iGNhxQvHqk0K6pbl2YNAEOyQxCBcU45Jm9xlhMIo6k2cgMhyLWc5/4KQ5BJ/b/1VR4
         izkNjo7fmg0qhecuXthwEZ1I9vgh7tTYx4BGoxApHXschGp4xm4H/2yakgMvjRHF0cjX
         uSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713351756; x=1713956556;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKc6zNttBr/4gkhSe3lbFoZGXxpmXb1Bln3h/MbJvp0=;
        b=cmUv3hkpvxz/6CM/Vc3qzSQBiP6PzllzZId0L5ADcMDnH+LuMejl9tOtyvYH3FgygW
         0RdUrgoXwazNzDf44kfowsLrynrpLF63qwXKr1Qqxf/Hqv6+fwnNrk5HAW12yIRguGMV
         aMfIM3XTJyWiPk4ivZvxcdPC80JVySLShmNkaKdPZ77z3IHJ9dJ7UR0hnWwzPYGDkJnK
         TXISbYLahEGUQltkaHV4Lji2hjallhQIhxUKFm8BuMISgcDRKfbsYBvfisOjGRZIab29
         vHC10uAocU2LEgZ18HaZblfYuHcQrzM77PHljGw3b/ctgu5Ou8AaWHtJr0bZ3rx5atV1
         8Ngw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8ijx3+mtnpdfTpEuWpi2OLtzQaOxFhOcZ2Dn2xahlSZ0KOBVniTKBzEBhQsKl0VzhZIqBNMoCnr7AMwELtEtQgaAl9TsNB96G6nC
X-Gm-Message-State: AOJu0Yw9a74RxLEIwvLa+/fbncvSw3a0AEJaEFzaX188Ef3ZEVTYx9um
	PtdVrhb3yrk9eYH1hSV2GmUttLZaP4L1ys+ynCchyJP6LiHxSz2ya2EwoukYUcw=
X-Google-Smtp-Source: AGHT+IFyMA0kN9GGJ6VUtcqnVuJ0jXnyjxEhl78mmYee4XcueTZ7ZSiVIMxipJfDmWIavDcPvy9oKA==
X-Received: by 2002:adf:fed1:0:b0:345:be70:191c with SMTP id q17-20020adffed1000000b00345be70191cmr11949917wrs.37.1713351756526;
        Wed, 17 Apr 2024 04:02:36 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.9])
        by smtp.gmail.com with ESMTPSA id dl5-20020a0560000b8500b00345fb949c28sm17218768wrb.100.2024.04.17.04.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 04:02:36 -0700 (PDT)
Message-ID: <d0979bd9-fd12-4672-b451-23f23fc2353c@suse.com>
Date: Wed, 17 Apr 2024 14:02:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
References: <20240417063001.3773507-1-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240417063001.3773507-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17.04.24 г. 9:30 ч., Xin Li (Intel) wrote:
> Add a FRED-specific INT80 handler fred_int80_emulation():
> 
> 1) As INT instructions and hardware interrupts are separate event
>     types, FRED does not preclude the use of vector 0x80 for external
>     interrupts. As a result the FRED setup code does *NOT* reserve
>     vector 0x80 and calling int80_is_external() is not merely
>     suboptimal but actively incorrect: it could cause a system call
>     to be incorrectly ignored.
> 
> 2) fred_int80_emulation(), only called for handling vector 0x80 of
>     event type EVENT_TYPE_SWINT, will NEVER be called to handle any
>     external interrupt (event type EVENT_TYPE_EXTINT).
> 
> 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
>     which is of event type EVENT_TYPE_SWINT, so compared with
>     do_int80_emulation(), there is no need to do any user mode check.
> 
> 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely >     overkill for new x86 CPU implementations that support FRED.

Well, that's a bit of an overstatement/speculation, because 
clear_branch_history will only be effective if the machine is 
susceptible to the given bug and there isn't a better options (i.e using 
a hardware bit controlling the respective aspect of the CPU).
> 
> 5) int $0x80 is the FAST path for 32-bit system calls under FRED.
> 
> A dedicated FRED INT80 handler duplicates quite a bit of the code in
> do_int80_emulation(), but it avoids sprinkling more tests and seems
> more readable. Just remember that we can always unify common stuff
> later if it turns out that it won't diverge anymore, i.e., after the
> FRED code settles.
> 
> Fixes: 55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")
> 
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
> 
> Changes since v2:
> * Add comments explaining the reasons why a FRED-specific INT80 handler
>    is required to the head comment of fred_int80_emulation(), not just
>    the change log (H. Peter Anvin).
> * Incorporate extra clarifications from H. Peter Anvin.
> * Fix a few typos and wordings (H. Peter Anvin).
> * Add a maintainer tip to the change log and head comment: unify common
>    stuff later, i.e., after the code settles (Borislav Petkov).
> 
> Change since v1:
> * Prefer a FRED-specific INT80 handler instead of sprinkling more tests
>    around (Borislav Petkov).
> ---
>   arch/x86/entry/common.c     | 64 +++++++++++++++++++++++++++++++++++++
>   arch/x86/entry/entry_fred.c |  2 +-
>   2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6de50b80702e..213d9b33a63c 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -255,6 +255,70 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
>   	instrumentation_end();
>   	syscall_exit_to_user_mode(regs);
>   }
> +
> +#ifdef CONFIG_X86_FRED
> +/*
> + * A FRED-specific INT80 handler fred_int80_emulation() is required:
> + *
> + * 1) As INT instructions and hardware interrupts are separate event
> + *    types, FRED does not preclude the use of vector 0x80 for external
> + *    interrupts. As a result the FRED setup code does *NOT* reserve
> + *    vector 0x80 and calling int80_is_external() is not merely
> + *    suboptimal but actively incorrect: it could cause a system call
> + *    to be incorrectly ignored.
> + *
> + * 2) fred_int80_emulation(), only called for handling vector 0x80 of
> + *    event type EVENT_TYPE_SWINT, will NEVER be called to handle any
> + *    external interrupt (event type EVENT_TYPE_EXTINT).
> + *
> + * 3) The FRED kernel entry handler does *NOT* dispatch INT instructions,
> + *    which is of event type EVENT_TYPE_SWINT, so compared with
> + *    do_int80_emulation(), there is no need to do any user mode check.
> + *
> + * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY, which is likely
> + *    overkill for new x86 CPU implementations that support FRED.
> + *
> + * 5) int $0x80 is the FAST path for 32-bit system calls under FRED.
> + *
> + * A dedicated FRED INT80 handler duplicates quite a bit of the code in
> + * do_int80_emulation(), but it avoids sprinkling more tests and seems
> + * more readable. Just remember that we can always unify common stuff
> + * later if it turns out that it won't diverge anymore, i.e., after the
> + * FRED code settles.
> + */
> +DEFINE_FREDENTRY_RAW(int80_emulation)
> +{
> +	int nr;
> +
> +	enter_from_user_mode(regs);
> +
> +	instrumentation_begin();
> +	add_random_kstack_offset();
> +
> +	/*
> +	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
> +	 * syscall number.
> +	 *
> +	 * User tracing code (ptrace or signal handlers) might assume
> +	 * that the regs::orig_ax contains a 32-bit number on invoking
> +	 * a 32-bit syscall.
> +	 *
> +	 * Establish the syscall convention by saving the 32bit truncated
> +	 * syscall number in regs::orig_ax and by invalidating regs::ax.
> +	 */
> +	regs->orig_ax = regs->ax & GENMASK(31, 0);
> +	regs->ax = -ENOSYS;
> +
> +	nr = syscall_32_enter(regs);
> +
> +	local_irq_enable();
> +	nr = syscall_enter_from_user_mode_work(regs, nr);
> +	do_syscall_32_irqs_on(regs, nr);
> +
> +	instrumentation_end();
> +	syscall_exit_to_user_mode(regs);
> +}
> +#endif
>   #else /* CONFIG_IA32_EMULATION */
>   
>   /* Handles int $0x80 on a 32bit kernel */
> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
> index ac120cbdaaf2..9fa18b8c7f26 100644
> --- a/arch/x86/entry/entry_fred.c
> +++ b/arch/x86/entry/entry_fred.c
> @@ -66,7 +66,7 @@ static noinstr void fred_intx(struct pt_regs *regs)
>   	/* INT80 */
>   	case IA32_SYSCALL_VECTOR:
>   		if (ia32_enabled())
> -			return int80_emulation(regs);
> +			return fred_int80_emulation(regs);
>   		fallthrough;
>   #endif
>   
> 
> base-commit: 367dc2b68007e8ca00a0d8dc9afb69bff5451ae7

