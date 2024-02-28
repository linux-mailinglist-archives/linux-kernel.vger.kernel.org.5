Return-Path: <linux-kernel+bounces-85528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3B86B713
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141F42888BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B571EAE;
	Wed, 28 Feb 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ea4LILr/"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35940868
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144476; cv=none; b=qmvGzsJ6J4Iey7fnPEniz+GHv9W1vDcKtftMqDf16QKfEP3T7RCvKPOgea8pzWXcNxJOhuoPf/zDR+caMqH/pW4wTNx4M/BtJolvsKiqfF9Tgp4jEwQJEBnq+W5tbyn2bloQ3eZ6zVqyiWm5V56EhV8hL5WuGv+nwgk2/8rN4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144476; c=relaxed/simple;
	bh=U/35yZauNfn/yXZB88kYKZuMxXuKf/iKnkd2JjyBfy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sty0QwlCoIIIV6OLPXiGlR5gq5IpYC+yrosZK4QaGQFdb550Ng8sGd9Mlck8ypyhmllDPigVjhoTSemnTP1i0tq4JLaQDM+NlivrYXzBU4ANkkiboygY+sHLWx0QcK0mLdCdTCPOgp57Oco58uKxMWfaK2CeO3oTbwkG0Pi3Guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Ea4LILr/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36519980c04so276765ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709144474; x=1709749274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08d0NHfoqroa1V4eYj1iLjIHMDy0L3o0VRrTUb12x9c=;
        b=Ea4LILr/eUHZUPkpTItbc+Dq9PWU7p1DZGfGYr6XAAcIo6HwqVtIqWfX303iypp9Fg
         M455WtErj5TKPeFKqBJWUqxOnOA7b2LS0v5YakT8Fl9Vp+0Q64dzYekI9u3JaqYHjFHd
         Lu/QiyzC5brZH/QJgxplXNW0lw5NUf2V5HJ1fAfLEl7vH15BLnfJF3tfdEXzDyDZg0tc
         9pP7WJxr+J1Cuu2eiPaUfmVmYFAza9mij1vamCOtuEhQxMOm4agssHKire0dhNB3kb0R
         xA4Ww/L8Nz6HFgUSvou5HrJOtSQWqDyU7myaCtvpHOYJw5nNx+qeGTNfI/u+E5ZK5s8m
         re0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144474; x=1709749274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08d0NHfoqroa1V4eYj1iLjIHMDy0L3o0VRrTUb12x9c=;
        b=hXb6wZUmIcFSUZvxP7nQCe77IGfw52BWlmgHkwetQFbhmqijJiPHkHhV4yg4DxtYAT
         NxSBCBzBwCkewN0K5Un9LyOAvPzb3fcaotj16B8JDvAdDFBOA6pYeHUNJN8cyyp5S2Q/
         CVlC4sli5gLZw4Z10cInRUWFKHwjzOwhsJsLP0zcVSHwSzoB/K3YDbXHDIGs3n7Ax/3B
         +ULeJ7n/Oe4i6LWolZxoSKlbNlPHd2b2f6KokQcOkWXTc990shG0/Zi61WmwequHp37O
         JNJ//ppEE8pAEQ0M+FKrM0Ag3R79PDv/xJw4QUqXNHbQ5cT3k0DegWRvmWuWpiwdPp97
         Fuhw==
X-Forwarded-Encrypted: i=1; AJvYcCVitwxMYUg+hcy9nW9cLOnl7eTNG44Pcyy5i5gpZP1CXrbD8TVVbRA+N/oLyglDbvuJlzHw6+z4bmWkMVrOe7bv2plupeBWEaP7Mvyr
X-Gm-Message-State: AOJu0YyOa0aE21W/Bo6suuZ3R7D/w6BnfYVFnhuzmsMJxCW0+xmaaG7V
	6USZ9lMbWmilbPnVs9SgRT1xatQku1QpQ1zXm/eJLKko+2Ryx8K2RYws6hyZYbE=
X-Google-Smtp-Source: AGHT+IHiR99D2BpM734RwDyOoiFWYbAyNElJ0/muIImLUYBA5CvXwg5wO0mpbjv4vAMqzrgZg+2hhg==
X-Received: by 2002:a92:c00c:0:b0:365:c5c:dfa7 with SMTP id q12-20020a92c00c000000b003650c5cdfa7mr67118ild.1.1709144473768;
        Wed, 28 Feb 2024 10:21:13 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.201])
        by smtp.gmail.com with ESMTPSA id ck13-20020a056e02370d00b00364372c5b5asm2956326ilb.15.2024.02.28.10.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 10:21:13 -0800 (PST)
Message-ID: <74d7adee-8293-4fad-82c3-f4458b2e3960@sifive.com>
Date: Wed, 28 Feb 2024 12:21:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Fix text patching when IPI are used
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrea Parri <andrea@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
 <20240228175149.162646-3-alexghiti@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240228175149.162646-3-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-02-28 11:51 AM, Alexandre Ghiti wrote:
> For now, we use stop_machine() to patch the text and when we use IPIs for
> remote icache flushes (which is emitted in patch_text_nosync()), the system
> hangs.
> 
> So instead, make sure every cpu executes the stop_machine() patching
> function and emit a local icache flush there.
> 
> Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/patch.h |  1 +
>  arch/riscv/kernel/ftrace.c     | 42 ++++++++++++++++++++++++++++++----
>  arch/riscv/kernel/patch.c      | 18 +++++++++------
>  3 files changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> index e88b52d39eac..9f5d6e14c405 100644
> --- a/arch/riscv/include/asm/patch.h
> +++ b/arch/riscv/include/asm/patch.h
> @@ -6,6 +6,7 @@
>  #ifndef _ASM_RISCV_PATCH_H
>  #define _ASM_RISCV_PATCH_H
>  
> +int patch_insn_write(void *addr, const void *insn, size_t len);
>  int patch_text_nosync(void *addr, const void *insns, size_t len);
>  int patch_text_set_nosync(void *addr, u8 c, size_t len);
>  int patch_text(void *addr, u32 *insns, int ninsns);
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index f5aa24d9e1c1..5654966c4e7d 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -8,6 +8,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/uaccess.h>
>  #include <linux/memory.h>
> +#include <linux/stop_machine.h>
>  #include <asm/cacheflush.h>
>  #include <asm/patch.h>
>  
> @@ -75,8 +76,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>  		make_call_t0(hook_pos, target, call);
>  
>  	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
> -	if (patch_text_nosync
> -	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
> +	if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
>  		return -EPERM;
>  
>  	return 0;
> @@ -88,7 +88,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  
>  	make_call_t0(rec->ip, addr, call);
>  
> -	if (patch_text_nosync((void *)rec->ip, call, MCOUNT_INSN_SIZE))
> +	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
>  		return -EPERM;
>  
>  	return 0;
> @@ -99,7 +99,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  {
>  	unsigned int nops[2] = {NOP4, NOP4};
>  
> -	if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> +	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
>  		return -EPERM;
>  
>  	return 0;
> @@ -134,6 +134,40 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  
>  	return ret;
>  }
> +
> +struct ftrace_modify_param {
> +	int command;
> +	atomic_t cpu_count;
> +};
> +
> +static int __ftrace_modify_code(void *data)
> +{
> +	struct ftrace_modify_param *param = data;
> +
> +	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
> +		ftrace_modify_all_code(param->command);
> +		/*
> +		 * Make sure the patching store is effective *before* we
> +		 * increment the counter which releases all waiting cpus
> +		 * by using the release version of atomic increment.
> +		 */
> +		atomic_inc_return_release(&param->cpu_count);
> +	} else {
> +		while (atomic_read(&param->cpu_count) <= num_online_cpus())
> +			cpu_relax();
> +	}
> +
> +	local_flush_icache_all();
> +
> +	return 0;
> +}
> +
> +void arch_ftrace_update_code(int command)
> +{
> +	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
> +
> +	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
> +}
>  #endif
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b5c16dfe3f4..82d8508c765b 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -188,7 +188,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>  }
>  NOKPROBE_SYMBOL(patch_text_set_nosync);
>  
> -static int patch_insn_write(void *addr, const void *insn, size_t len)
> +int patch_insn_write(void *addr, const void *insn, size_t len)
>  {
>  	size_t patched = 0;
>  	size_t size;
> @@ -211,11 +211,9 @@ NOKPROBE_SYMBOL(patch_insn_write);
>  
>  int patch_text_nosync(void *addr, const void *insns, size_t len)
>  {
> -	u32 *tp = addr;
>  	int ret;
>  
> -	ret = patch_insn_write(tp, insns, len);
> -
> +	ret = patch_insn_write(addr, insns, len);
>  	if (!ret)
>  		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);

This only happens to compile because flush_icache_range() is a macro that
ignores its parameters. You could replace tp with addr in this line as well, but
that seems like more of a cosmetic change and should be a separate patch (like
in [1] which covers both related functions) if you respin this.

Regards,
Samuel

[1]:
https://lore.kernel.org/linux-riscv/20240212025529.1971876-8-samuel.holland@sifive.com/

>  
> @@ -232,15 +230,21 @@ static int patch_text_cb(void *data)
>  	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>  		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
>  			len = GET_INSN_LENGTH(patch->insns[i]);
> -			ret = patch_text_nosync(patch->addr + i * len,
> -						&patch->insns[i], len);
> +			ret = patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
>  		}
> -		atomic_inc(&patch->cpu_count);
> +		/*
> +		 * Make sure the patching store is effective *before* we
> +		 * increment the counter which releases all waiting cpus
> +		 * by using the release version of atomic increment.
> +		 */
> +		atomic_inc_return_release(&patch->cpu_count);
>  	} else {
>  		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>  			cpu_relax();
>  	}
>  
> +	local_flush_icache_all();
> +
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_cb);


