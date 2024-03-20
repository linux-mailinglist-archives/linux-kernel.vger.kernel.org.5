Return-Path: <linux-kernel+bounces-108355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC488098C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F294283393
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC4748E;
	Wed, 20 Mar 2024 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L17KtDz2"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8179C2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710901264; cv=none; b=t3vN+bZBgpkRexrAJq/Bhoh3EqXqsnfeN505Z3UeIyxOS3YwIwjP/MBFz8JYkZWIb7rHV7BnRiG/h9n712IBZQOW0bzcNIaKftCCPOsfpmRzEvxD1q9WmOK5GNSxAJcJCpcLToJ6sAXL2qbbPKW+bRgI6qEWpKrzQcBn8pmOFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710901264; c=relaxed/simple;
	bh=6bUQxNSzahONk4aC6t+gwjqMoBt/IWX4TNKW2IKyXPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GN8tV9jopbARCIFyON1xiQLlHvGFRH1ZiKHx2xEdohSAwjhF26HDWw/PwQSAILzG1CVbuMeYRrq2eaFYaRPiCcc4BPoHK+IZxIHhAtlFtVTQXv/kqs4Px6ZXWFRoZ0y7iPDqhaJSaDpK3z50Ae7amUk+yzcVcmz0ODTZFIyidbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L17KtDz2; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c7ee7fa1d8so187371239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710901262; x=1711506062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20q06/6oGIfjPCtmqOWMDp2L8ubG1IZix8+eCUbt12w=;
        b=L17KtDz2rodYYM3VzoPfDzcC2bXLcRzh4TefgTouP5iB20TKzQhV6ebJsjljfB//XL
         TQNB6TbpdZd/ygh7QmPvSlPjbmXXmNsQka2i35yyGk0wTFeAz3MRRT3L4v73dNcwGiJv
         G4Pbu8BUvXkaptKjrQXH4OibXpBQLaSVIHEYRIpyGqa2Gw6HmxJ0HTxtuyDNI6jldVdn
         JJpUrNa+XmD4Lq/vaS0gyoO2zFuWhn6SiS+qL+DqLzXWBawDUJDy/jITgKL9b89G9mkk
         fBFd1IqxANMrrBqgNjFpnBOROkFh4PRfT+97/3FrlKS4r71jwUVdEyyeU9h8NKgAt+/c
         qmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710901262; x=1711506062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20q06/6oGIfjPCtmqOWMDp2L8ubG1IZix8+eCUbt12w=;
        b=JN3dgZhtXTqB3Kskdd8Ky9leg+4AvgLSBS1mcoIkOKRuD1owzVCfOhqHIKhPB+UTgy
         REIG91tmWLKWvwF4E9tZbXvFwIlG1EcttOIHUz6U8TVHjbcsA12rsYnqveXiSrwTtIwF
         Xv6eSfXZA1A3KM5A0b3X9nizkcyNK6Vv2eE59oTlnDEQcVLdyDFtcXiCJMQNVzDUGZty
         IG9av9ibTeEHjdKm1T63sthJuZpfqTW4ZXZjHw/Au5I+F3ypS15zEeLmXIC9RcGk33YA
         LAFXV7XnPsfpv6jxzZDsJU3LebAr+Yo2XcRaDG/f7G2E4oqYCqVL+5YA9QI8QFtBQ9TV
         0GZA==
X-Forwarded-Encrypted: i=1; AJvYcCWEUvWHMLdTtTs/q6le4eAnr8rU0Bfsy1yUho+gxxwgdNFmpegydy0N4QmfWMAvSiuTmhTTLqUUuaTbnZJx227rAC9bp0P16VYyrmXA
X-Gm-Message-State: AOJu0Yzp6RsJswN6v2+O8FU68Dnf6mgZx9DL8YpX2VX4iXx0kOFZqT4B
	8ZwmDqXCO5VjZlNEMmv2Lyjd1/Y+XqSPgG4sgUJlcVfPHmKYfB95Bco6jVb4cxw=
X-Google-Smtp-Source: AGHT+IG2YVVTRWdfjPzSHAdAFRXz/GHhdXhTPItlVa6ZZGxpXjpCDUqeA3MoQ9oXY66IB7K76slCEQ==
X-Received: by 2002:a05:6602:340d:b0:7cc:10da:ac1a with SMTP id n13-20020a056602340d00b007cc10daac1amr13941502ioz.8.1710901261875;
        Tue, 19 Mar 2024 19:21:01 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id fm39-20020a0566382b2700b0047730eb5bebsm3174773jab.60.2024.03.19.19.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:21:01 -0700 (PDT)
Message-ID: <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
Date: Tue, 19 Mar 2024 21:20:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
To: Deepak Gupta <debug@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org,
 Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
 Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Andrew Jones <ajones@ventanamicro.com>,
 Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com>
 <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Deepak,

On 2024-03-19 6:55 PM, Deepak Gupta wrote:
> On Tue, Mar 19, 2024 at 2:59 PM Samuel Holland via lists.riscv.org
> <samuel.holland=sifive.com@lists.riscv.org> wrote:
>>
>> Some envcfg bits need to be controlled on a per-thread basis, such as
>> the pointer masking mode. However, the envcfg CSR value cannot simply be
>> stored in struct thread_struct, because some hardware may implement a
>> different subset of envcfg CSR bits is across CPUs. As a result, we need
>> to combine the per-CPU and per-thread bits whenever we switch threads.
>>
> 
> Why not do something like this
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index b3400517b0a9..01ba87954da2 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -202,6 +202,8 @@
>  #define ENVCFG_CBIE_FLUSH              _AC(0x1, UL)
>  #define ENVCFG_CBIE_INV                        _AC(0x3, UL)
>  #define ENVCFG_FIOM                    _AC(0x1, UL)
> +/* by default all threads should be able to zero cache */
> +#define ENVCFG_BASE                    ENVCFG_CBZE

Linux does not assume Sstrict, so without Zicboz being present in DT/ACPI, we
have no idea what the CBZE bit does--there's no guarantee it has the standard
meaning--so it's not safe to set the bit unconditionally. If that policy
changes, we could definitely simplify the code.

>  /* Smstateen bits */
>  #define SMSTATEEN0_AIA_IMSIC_SHIFT     58
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 4f21d970a129..2420123444c4 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -152,6 +152,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>         else
>                 regs->status |= SR_UXL_64;
>  #endif
> +       current->thread_info.envcfg = ENVCFG_BASE;
>  }
> 
> And instead of context switching in `_switch_to`,
> In `entry.S` pick up `envcfg` from `thread_info` and write it into CSR.

The immediate reason is that writing envcfg in ret_from_exception() adds cycles
to every IRQ and system call exit, even though most of them will not change the
envcfg value. This is especially the case when returning from an IRQ/exception
back to S-mode, since envcfg has zero effect there.

The CSRs that are read/written in entry.S are generally those where the value
can be updated by hardware, as part of taking an exception. But envcfg never
changes on its own. The kernel knows exactly when its value will change, and
those places are:

 1) Task switch, i.e. switch_to()
 2) execve(), i.e. start_thread() or flush_thread()
 3) A system call that specifically affects a feature controlled by envcfg

So that's where this series writes it. There are a couple of minor tradeoffs
about when exactly to do the write:

- We could drop the sync_envcfg() calls outside of switch_to() by reading the
  current CSR value when scheduling out a thread, but again that adds overhead
  to the fast path to remove a tiny bit of code in the prctl() handlers.
- We don't need to write envcfg when switching to a kernel thread, only when
  switching to a user thread, because kernel threads never leave S-mode, so
  envcfg doesn't affect them. But checking the thread type takes many more
  instructions than just writing the CSR.

Overall, the optimal implementation will approximate the rule of only writing
envcfg when its value changes.

> This construction avoids
> - declaring per cpu riscv_cpu_envcfg

This is really a separate concern than when we write envcfg. The per-CPU
variable is only necessary to support hardware where a subset of harts support
Zicboz. Since the riscv_cpu_has_extension_[un]likely() helpers were added
specifically for Zicboz, I assume this is an important use case, and dropping
support for this hardware would be a regression. After all, hwprobe() allows
userspace to see that Zicboz is implemented at a per-CPU level. Maybe Andrew can
weigh in on that.

If we decide to enable Zicboz only when all harts support it, or we decide it's
safe to attempt to set the envcfg.CBZE bit on harts that do not declare support
for Zicboz, then we could drop the percpu variable.

> - syncing up
> - collection of *envcfg bits.
> 
> 
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/include/asm/cpufeature.h |  2 ++
>>  arch/riscv/include/asm/processor.h  |  1 +
>>  arch/riscv/include/asm/switch_to.h  | 12 ++++++++++++
>>  arch/riscv/kernel/cpufeature.c      |  4 +++-
>>  4 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index 0bd11862b760..b1ad8d0b4599 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -33,6 +33,8 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
>>  /* Per-cpu ISA extensions. */
>>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>>
>> +DECLARE_PER_CPU(unsigned long, riscv_cpu_envcfg);
>> +
>>  void riscv_user_isa_enable(void);
>>
>>  #ifdef CONFIG_RISCV_MISALIGNED
>> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>> index a8509cc31ab2..06b87402a4d8 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -118,6 +118,7 @@ struct thread_struct {
>>         unsigned long s[12];    /* s[0]: frame pointer */
>>         struct __riscv_d_ext_state fstate;
>>         unsigned long bad_cause;
>> +       unsigned long envcfg;
>>         u32 riscv_v_flags;
>>         u32 vstate_ctrl;
>>         struct __riscv_v_ext_state vstate;
>> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
>> index 7efdb0584d47..256a354a5c4a 100644
>> --- a/arch/riscv/include/asm/switch_to.h
>> +++ b/arch/riscv/include/asm/switch_to.h
>> @@ -69,6 +69,17 @@ static __always_inline bool has_fpu(void) { return false; }
>>  #define __switch_to_fpu(__prev, __next) do { } while (0)
>>  #endif
>>
>> +static inline void sync_envcfg(struct task_struct *task)
>> +{
>> +       csr_write(CSR_ENVCFG, this_cpu_read(riscv_cpu_envcfg) | task->thread.envcfg);
>> +}
>> +
>> +static inline void __switch_to_envcfg(struct task_struct *next)
>> +{
>> +       if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
> 
> I've seen `riscv_cpu_has_extension_unlikely` generating branchy code
> even if ALTERNATIVES was turned on.
> Can you check disasm on your end as well.  IMHO, `entry.S` is a better
> place to pick up *envcfg.

The branchiness is sort of expected, since that function is implemented by
switching on/off a branch instruction, so the alternate code is necessarily a
separate basic block. It's a tradeoff so we don't have to write assembly code
for every bit of code that depends on an extension. However, the cost should be
somewhat lowered since the branch is unconditional and so entirely predictable.

If the branch turns out to be problematic for performance, then we could use
ALTERNATIVE directly in sync_envcfg() to NOP out the CSR write.

>> +               sync_envcfg(next);
>> +}
>> +
>>  extern struct task_struct *__switch_to(struct task_struct *,
>>                                        struct task_struct *);
>>
>> @@ -80,6 +91,7 @@ do {                                                  \
>>                 __switch_to_fpu(__prev, __next);        \
>>         if (has_vector())                                       \
>>                 __switch_to_vector(__prev, __next);     \
>> +       __switch_to_envcfg(__next);                     \
>>         ((last) = __switch_to(__prev, __next));         \
>>  } while (0)
>>
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index d1846aab1f78..32aaaf41f8a8 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -44,6 +44,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>>  /* Per-cpu ISA extensions. */
>>  struct riscv_isainfo hart_isa[NR_CPUS];
>>
>> +DEFINE_PER_CPU(unsigned long, riscv_cpu_envcfg);
>> +
>>  /* Performance information */
>>  DEFINE_PER_CPU(long, misaligned_access_speed);
>>
>> @@ -978,7 +980,7 @@ arch_initcall(check_unaligned_access_all_cpus);
>>  void riscv_user_isa_enable(void)
>>  {
>>         if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
>> -               csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>> +               this_cpu_or(riscv_cpu_envcfg, ENVCFG_CBZE);

If we drop the percpu variable, this becomes

	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
		current->thread.envcfg |= ENVCFG_CBZE;

since the init thread's envcfg gets copied to all other threads via fork(), and
we can drop the call to riscv_user_isa_enable() from smp_callin(). Or if we
decide CBZE is always safe to set, then the function is even simpler:

	current->thread.envcfg = ENVCFG_CBZE;

Regards,
Samuel

>>  }
>>
>>  #ifdef CONFIG_RISCV_ALTERNATIVE
>> --
>> 2.43.1


