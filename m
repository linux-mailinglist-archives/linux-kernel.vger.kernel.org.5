Return-Path: <linux-kernel+bounces-69239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D3385861D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313BF1F23B35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86925136658;
	Fri, 16 Feb 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DpiLMbG3"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8355131E5C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111465; cv=none; b=c96q9w1ymlakGavVjdamTa7u+1KI1GiAKC7U5yCyTx0uqTtFo/a6fLLTCBA5IRty93OymRbDhlehdS8GBHIgG1umGS/WNJATNuMksj5k8fFv7UGZuAIns6bvxT0/dN5Pn+uyHOOUQJCZX49WUZ2Rk5UhWgUHT62izFqLUDcF9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111465; c=relaxed/simple;
	bh=P84+6hYgBdmthyo8OVVxjRVFLEergArPtO2XK2R4hqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZopgCoQWgR4oKWG1P9V5Xzt1z0odPxGm6JToqLYzqvu3iTItOKLV0/brQ3Gd2sHjYHe8I+Eo3SesB+MSpfec30nTPYXJM0QB0S4uChTv8D+Rd3c/YXJIrV0wNKMBsZr5KalaP8aeVPvg+fSBMUXMp6tZRePHU0IqGn62cF6zVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DpiLMbG3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6079d44b02bso10333487b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708111462; x=1708716262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SWwggc/U396fv+1RP5MpGMlIODQfe8IEZrz8yDLra2U=;
        b=DpiLMbG3M2htcM/t7kU9E0illyUhnjSkJ8w2KYr+XeX4WmtT3nBMD9r+e1YgXAFWl5
         b/YvJC1l9/xrrp79OYFbzjcQ0V4TYuoVldZKSIA2p2GRYRRtm6Wjj9Xa3xRlamnWIGiy
         mG05/p3VvWW2uSj8YKeqBizZyBtbhdtnA1P0vnvctCgZEdYgQiD+Gn8P3Nc+xpg8dsSE
         QU8XH7g6jfcYyFQy0YZCrGe8HwgsaiaaUnL1C1GteGLkOrVIl1ivcqScsux7ZsSxNbqM
         f2przZIqxrQ7SLcrce935AnasXuJMExFOg+OBpLaM2IQy0T+s8WbOrRkzdlMji7wB4rl
         v4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708111462; x=1708716262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWwggc/U396fv+1RP5MpGMlIODQfe8IEZrz8yDLra2U=;
        b=tp53HQep9ITGzkYk9fPALT+YIAN0Xog/0YmQV6STxkMeLSqC2O4m38LFjBqrjkeWqR
         ZoNjrvnbqWrHXlqLLARZCX1nKa9+ACk32jB01Ao7/fGDveQrw/yZsyAHNlzc+b/+hQZr
         uuNHM/w6pB1Nknrn5uvPc4gDy94xNzbyzWIr/rn/EfJ1ERALDeMSUImBjU3jocij2Ib0
         hYX0K6zLGjGew07secSmsQfIhYhE9HfO45r7oDUS3ZLAEGQqBdsdsBYBSlAZFW/CTkTY
         2zblwuA0zwNCgEhMmPTliCHy7Oduaearz2mWBYmdR9BpxrSV94nyQurYimuSR2VTGsXD
         kiVw==
X-Forwarded-Encrypted: i=1; AJvYcCWocRzxSfJAh1u9DHUp9nVt701zWLHecQ793E6UaICYA4ZifhIhwE3kmqQAAtfSd/vfjna+2A54joi1mzP1DlDGqg7js7gJg02mUJCd
X-Gm-Message-State: AOJu0Yx8JU7HvoF5YfNLQTUnhI6K3zIMQG58NuTz3lxNA4slmGllcK9p
	YuQMX5h6SbDp0VemjFfnm5t4jGBNZnKL5KjSxORcGIGwtLNclWKD2U28jyvMD08=
X-Google-Smtp-Source: AGHT+IEKx4OOe7nvxilF4iirahz81UBGuT4Il92XFAJGZ7/TbXWjWrGyqgFa9SyCPyeWExUPqKluIQ==
X-Received: by 2002:a0d:eb12:0:b0:607:7f6d:e962 with SMTP id u18-20020a0deb12000000b006077f6de962mr6064466ywe.22.1708111461484;
        Fri, 16 Feb 2024 11:24:21 -0800 (PST)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id n62-20020a0dcb41000000b00608058c001esm183054ywd.8.2024.02.16.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:24:21 -0800 (PST)
Date: Fri, 16 Feb 2024 14:24:19 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <Zc+2Y5MuwwInf7+Q@ghost>
References: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
 <20240202-disable_misaligned_probe_config-v3-2-c44f91f03bb6@rivosinc.com>
 <CALs-HssKav=+P_w5VuoZZU3xkut6FxMUpdpd5HSa5iPMRDu=5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HssKav=+P_w5VuoZZU3xkut6FxMUpdpd5HSa5iPMRDu=5A@mail.gmail.com>

On Wed, Feb 14, 2024 at 09:24:16AM -0500, Evan Green wrote:
> On Fri, Feb 2, 2024 at 6:54 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> > set to have fast misaligned access without needing to probe.
> >
> > To avoid some ifdefs, move unalignment probing code into its own file
> > and make CONFIG_RISCV_MISALIGNED depend on
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> One nit below, but feel free to add my tag on the next spin:
> 
> Reviewed-by: Evan Green <evan@rivosinc.com>

Thanks! I will apply your suggestions. I am also going to add support
for selecting the other alignment speeds so I will leave off the
reviewed-by for now in case you have further suggestions for that.

- Charlie

> 
> > ---
> >  arch/riscv/Kconfig                          |   1 +
> >  arch/riscv/include/asm/cpufeature.h         |   7 +
> >  arch/riscv/kernel/Makefile                  |   3 +
> >  arch/riscv/kernel/cpufeature.c              | 255 --------------------------
> >  arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++++++++
> >  arch/riscv/kernel/sys_hwprobe.c             |   4 +
> >  6 files changed, 280 insertions(+), 255 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bffbd869a068..3223d2d08f74 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -690,6 +690,7 @@ config THREAD_SIZE_ORDER
> >  config RISCV_MISALIGNED
> >         bool "Support misaligned load/store traps for kernel and userspace"
> >         select SYSCTL_ARCH_UNALIGN_ALLOW
> > +       depends on !HAVE_EFFICIENT_UNALIGNED_ACCESS
> >         default y
> >         help
> >           Say Y here if you want the kernel to embed support for misaligned
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index eb3ac304fc42..44734e5169b1 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -51,6 +51,12 @@ static inline bool check_unaligned_access_emulated(int cpu)
> >  static inline void unaligned_emulation_finish(void) {}
> >  #endif
> >
> > +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +static __always_inline bool has_fast_misaligned_accesses(void)
> > +{
> > +       return true;
> > +}
> > +#else
> >  DECLARE_PER_CPU(long, misaligned_access_speed);
> >
> >  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > @@ -59,6 +65,7 @@ static __always_inline bool has_fast_misaligned_accesses(void)
> >  {
> >         return static_branch_likely(&fast_misaligned_access_speed_key);
> >  }
> > +#endif
> >
> >  unsigned long riscv_get_elf_hwcap(void);
> >
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f71910718053..ffba5ecf12c2 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -62,6 +62,9 @@ obj-y += tests/
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> >
> >  obj-$(CONFIG_RISCV_MISALIGNED) += traps_misaligned.o
> > +ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS), y)
> > +obj-y  += misaligned_access_speed.o
> 
> copy-unaligned.o can also go in here (those are the assembly copy
> routines used only by the probing code).
> 
> > +endif
> >  obj-$(CONFIG_FPU)              += fpu.o
> >  obj-$(CONFIG_RISCV_ISA_V)      += vector.o
> >  obj-$(CONFIG_RISCV_ISA_V)      += kernel_mode_vector.o
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 89920f84d0a3..319670af5704 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -11,7 +11,6 @@
> >  #include <linux/cpu.h>
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/ctype.h>
> > -#include <linux/jump_label.h>
> >  #include <linux/log2.h>
> >  #include <linux/memory.h>
> >  #include <linux/module.h>
> > @@ -21,20 +20,12 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/hwcap.h>
> > -#include <asm/hwprobe.h>
> >  #include <asm/patch.h>
> >  #include <asm/processor.h>
> >  #include <asm/vector.h>
> >
> > -#include "copy-unaligned.h"
> > -
> >  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> >
> > -#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> > -#define MISALIGNED_BUFFER_SIZE 0x4000
> > -#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> > -#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> > -
> >  unsigned long elf_hwcap __read_mostly;
> >
> >  /* Host ISA bitmap */
> > @@ -43,11 +34,6 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> >  /* Per-cpu ISA extensions. */
> >  struct riscv_isainfo hart_isa[NR_CPUS];
> >
> > -/* Performance information */
> > -DEFINE_PER_CPU(long, misaligned_access_speed);
> > -
> > -static cpumask_t fast_misaligned_access;
> > -
> >  /**
> >   * riscv_isa_extension_base() - Get base extension word
> >   *
> > @@ -706,247 +692,6 @@ unsigned long riscv_get_elf_hwcap(void)
> >         return hwcap;
> >  }
> >
> > -static int check_unaligned_access(void *param)
> > -{
> > -       int cpu = smp_processor_id();
> > -       u64 start_cycles, end_cycles;
> > -       u64 word_cycles;
> > -       u64 byte_cycles;
> > -       int ratio;
> > -       unsigned long start_jiffies, now;
> > -       struct page *page = param;
> > -       void *dst;
> > -       void *src;
> > -       long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
> > -
> > -       if (check_unaligned_access_emulated(cpu))
> > -               return 0;
> > -
> > -       /* Make an unaligned destination buffer. */
> > -       dst = (void *)((unsigned long)page_address(page) | 0x1);
> > -       /* Unalign src as well, but differently (off by 1 + 2 = 3). */
> > -       src = dst + (MISALIGNED_BUFFER_SIZE / 2);
> > -       src += 2;
> > -       word_cycles = -1ULL;
> > -       /* Do a warmup. */
> > -       __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > -       preempt_disable();
> > -       start_jiffies = jiffies;
> > -       while ((now = jiffies) == start_jiffies)
> > -               cpu_relax();
> > -
> > -       /*
> > -        * For a fixed amount of time, repeatedly try the function, and take
> > -        * the best time in cycles as the measurement.
> > -        */
> > -       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> > -               start_cycles = get_cycles64();
> > -               /* Ensure the CSR read can't reorder WRT to the copy. */
> > -               mb();
> > -               __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > -               /* Ensure the copy ends before the end time is snapped. */
> > -               mb();
> > -               end_cycles = get_cycles64();
> > -               if ((end_cycles - start_cycles) < word_cycles)
> > -                       word_cycles = end_cycles - start_cycles;
> > -       }
> > -
> > -       byte_cycles = -1ULL;
> > -       __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > -       start_jiffies = jiffies;
> > -       while ((now = jiffies) == start_jiffies)
> > -               cpu_relax();
> > -
> > -       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> > -               start_cycles = get_cycles64();
> > -               mb();
> > -               __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > -               mb();
> > -               end_cycles = get_cycles64();
> > -               if ((end_cycles - start_cycles) < byte_cycles)
> > -                       byte_cycles = end_cycles - start_cycles;
> > -       }
> > -
> > -       preempt_enable();
> > -
> > -       /* Don't divide by zero. */
> > -       if (!word_cycles || !byte_cycles) {
> > -               pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
> > -                       cpu);
> > -
> > -               return 0;
> > -       }
> > -
> > -       if (word_cycles < byte_cycles)
> > -               speed = RISCV_HWPROBE_MISALIGNED_FAST;
> > -
> > -       ratio = div_u64((byte_cycles * 100), word_cycles);
> > -       pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
> > -               cpu,
> > -               ratio / 100,
> > -               ratio % 100,
> > -               (speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> > -
> > -       per_cpu(misaligned_access_speed, cpu) = speed;
> > -
> > -       /*
> > -        * Set the value of fast_misaligned_access of a CPU. These operations
> > -        * are atomic to avoid race conditions.
> > -        */
> > -       if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
> > -               cpumask_set_cpu(cpu, &fast_misaligned_access);
> > -       else
> > -               cpumask_clear_cpu(cpu, &fast_misaligned_access);
> > -
> > -       return 0;
> > -}
> > -
> > -static void check_unaligned_access_nonboot_cpu(void *param)
> > -{
> > -       unsigned int cpu = smp_processor_id();
> > -       struct page **pages = param;
> > -
> > -       if (smp_processor_id() != 0)
> > -               check_unaligned_access(pages[cpu]);
> > -}
> > -
> > -DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > -
> > -static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
> > -{
> > -       if (cpumask_weight(mask) == weight)
> > -               static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
> > -       else
> > -               static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
> > -}
> > -
> > -static void set_unaligned_access_static_branches_except_cpu(int cpu)
> > -{
> > -       /*
> > -        * Same as set_unaligned_access_static_branches, except excludes the
> > -        * given CPU from the result. When a CPU is hotplugged into an offline
> > -        * state, this function is called before the CPU is set to offline in
> > -        * the cpumask, and thus the CPU needs to be explicitly excluded.
> > -        */
> > -
> > -       cpumask_t fast_except_me;
> > -
> > -       cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
> > -       cpumask_clear_cpu(cpu, &fast_except_me);
> > -
> > -       modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
> > -}
> > -
> > -static void set_unaligned_access_static_branches(void)
> > -{
> > -       /*
> > -        * This will be called after check_unaligned_access_all_cpus so the
> > -        * result of unaligned access speed for all CPUs will be available.
> > -        *
> > -        * To avoid the number of online cpus changing between reading
> > -        * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
> > -        * held before calling this function.
> > -        */
> > -
> > -       cpumask_t fast_and_online;
> > -
> > -       cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
> > -
> > -       modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
> > -}
> > -
> > -static int lock_and_set_unaligned_access_static_branch(void)
> > -{
> > -       cpus_read_lock();
> > -       set_unaligned_access_static_branches();
> > -       cpus_read_unlock();
> > -
> > -       return 0;
> > -}
> > -
> > -arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> > -
> > -static int riscv_online_cpu(unsigned int cpu)
> > -{
> > -       static struct page *buf;
> > -
> > -       /* We are already set since the last check */
> > -       if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> > -               goto exit;
> > -
> > -       buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> > -       if (!buf) {
> > -               pr_warn("Allocation failure, not measuring misaligned performance\n");
> > -               return -ENOMEM;
> > -       }
> > -
> > -       check_unaligned_access(buf);
> > -       __free_pages(buf, MISALIGNED_BUFFER_ORDER);
> > -
> > -exit:
> > -       set_unaligned_access_static_branches();
> > -
> > -       return 0;
> > -}
> > -
> > -static int riscv_offline_cpu(unsigned int cpu)
> > -{
> > -       set_unaligned_access_static_branches_except_cpu(cpu);
> > -
> > -       return 0;
> > -}
> > -
> > -/* Measure unaligned access on all CPUs present at boot in parallel. */
> > -static int check_unaligned_access_all_cpus(void)
> > -{
> > -       unsigned int cpu;
> > -       unsigned int cpu_count = num_possible_cpus();
> > -       struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
> > -                                    GFP_KERNEL);
> > -
> > -       if (!bufs) {
> > -               pr_warn("Allocation failure, not measuring misaligned performance\n");
> > -               return 0;
> > -       }
> > -
> > -       /*
> > -        * Allocate separate buffers for each CPU so there's no fighting over
> > -        * cache lines.
> > -        */
> > -       for_each_cpu(cpu, cpu_online_mask) {
> > -               bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> > -               if (!bufs[cpu]) {
> > -                       pr_warn("Allocation failure, not measuring misaligned performance\n");
> > -                       goto out;
> > -               }
> > -       }
> > -
> > -       /* Check everybody except 0, who stays behind to tend jiffies. */
> > -       on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> > -
> > -       /* Check core 0. */
> > -       smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> > -
> > -       /*
> > -        * Setup hotplug callbacks for any new CPUs that come online or go
> > -        * offline.
> > -        */
> > -       cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> > -                                 riscv_online_cpu, riscv_offline_cpu);
> > -
> > -out:
> > -       unaligned_emulation_finish();
> > -       for_each_cpu(cpu, cpu_online_mask) {
> > -               if (bufs[cpu])
> > -                       __free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> > -       }
> > -
> > -       kfree(bufs);
> > -       return 0;
> > -}
> > -
> > -arch_initcall(check_unaligned_access_all_cpus);
> > -
> >  void riscv_user_isa_enable(void)
> >  {
> >         if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
> > diff --git a/arch/riscv/kernel/misaligned_access_speed.c b/arch/riscv/kernel/misaligned_access_speed.c
> > new file mode 100644
> > index 000000000000..b725c07dd1af
> > --- /dev/null
> > +++ b/arch/riscv/kernel/misaligned_access_speed.c
> > @@ -0,0 +1,265 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2024 Rivos Inc.
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/jump_label.h>
> > +#include <linux/mm.h>
> > +#include <linux/smp.h>
> > +#include <linux/types.h>
> > +#include <asm/cpufeature.h>
> > +#include <asm/hwprobe.h>
> > +
> > +#include "copy-unaligned.h"
> > +
> > +#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> > +#define MISALIGNED_BUFFER_SIZE 0x4000
> > +#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> > +#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> > +
> > +DEFINE_PER_CPU(long, misaligned_access_speed);
> > +
> > +static cpumask_t fast_misaligned_access;
> > +
> > +static int check_unaligned_access(void *param)
> > +{
> > +       int cpu = smp_processor_id();
> > +       u64 start_cycles, end_cycles;
> > +       u64 word_cycles;
> > +       u64 byte_cycles;
> > +       int ratio;
> > +       unsigned long start_jiffies, now;
> > +       struct page *page = param;
> > +       void *dst;
> > +       void *src;
> > +       long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
> > +
> > +       if (check_unaligned_access_emulated(cpu))
> > +               return 0;
> > +
> > +       /* Make an unaligned destination buffer. */
> > +       dst = (void *)((unsigned long)page_address(page) | 0x1);
> > +       /* Unalign src as well, but differently (off by 1 + 2 = 3). */
> > +       src = dst + (MISALIGNED_BUFFER_SIZE / 2);
> > +       src += 2;
> > +       word_cycles = -1ULL;
> > +       /* Do a warmup. */
> > +       __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +       preempt_disable();
> > +       start_jiffies = jiffies;
> > +       while ((now = jiffies) == start_jiffies)
> > +               cpu_relax();
> > +
> > +       /*
> > +        * For a fixed amount of time, repeatedly try the function, and take
> > +        * the best time in cycles as the measurement.
> > +        */
> > +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> > +               start_cycles = get_cycles64();
> > +               /* Ensure the CSR read can't reorder WRT to the copy. */
> > +               mb();
> > +               __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +               /* Ensure the copy ends before the end time is snapped. */
> > +               mb();
> > +               end_cycles = get_cycles64();
> > +               if ((end_cycles - start_cycles) < word_cycles)
> > +                       word_cycles = end_cycles - start_cycles;
> > +       }
> > +
> > +       byte_cycles = -1ULL;
> > +       __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +       start_jiffies = jiffies;
> > +       while ((now = jiffies) == start_jiffies)
> > +               cpu_relax();
> > +
> > +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> > +               start_cycles = get_cycles64();
> > +               mb();
> > +               __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +               mb();
> > +               end_cycles = get_cycles64();
> > +               if ((end_cycles - start_cycles) < byte_cycles)
> > +                       byte_cycles = end_cycles - start_cycles;
> > +       }
> > +
> > +       preempt_enable();
> > +
> > +       /* Don't divide by zero. */
> > +       if (!word_cycles || !byte_cycles) {
> > +               pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
> > +                       cpu);
> > +
> > +               return 0;
> > +       }
> > +
> > +       if (word_cycles < byte_cycles)
> > +               speed = RISCV_HWPROBE_MISALIGNED_FAST;
> > +
> > +       ratio = div_u64((byte_cycles * 100), word_cycles);
> > +       pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
> > +               cpu,
> > +               ratio / 100,
> > +               ratio % 100,
> > +               (speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> > +
> > +       per_cpu(misaligned_access_speed, cpu) = speed;
> > +
> > +       /*
> > +        * Set the value of fast_misaligned_access of a CPU. These operations
> > +        * are atomic to avoid race conditions.
> > +        */
> > +       if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
> > +               cpumask_set_cpu(cpu, &fast_misaligned_access);
> > +       else
> > +               cpumask_clear_cpu(cpu, &fast_misaligned_access);
> > +
> > +       return 0;
> > +}
> > +
> > +static void check_unaligned_access_nonboot_cpu(void *param)
> > +{
> > +       unsigned int cpu = smp_processor_id();
> > +       struct page **pages = param;
> > +
> > +       if (smp_processor_id() != 0)
> > +               check_unaligned_access(pages[cpu]);
> > +}
> > +
> > +DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > +
> > +static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
> > +{
> > +       if (cpumask_weight(mask) == weight)
> > +               static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
> > +       else
> > +               static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
> > +}
> > +
> > +static void set_unaligned_access_static_branches_except_cpu(int cpu)
> > +{
> > +       /*
> > +        * Same as set_unaligned_access_static_branches, except excludes the
> > +        * given CPU from the result. When a CPU is hotplugged into an offline
> > +        * state, this function is called before the CPU is set to offline in
> > +        * the cpumask, and thus the CPU needs to be explicitly excluded.
> > +        */
> > +
> > +       cpumask_t fast_except_me;
> > +
> > +       cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
> > +       cpumask_clear_cpu(cpu, &fast_except_me);
> > +
> > +       modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
> > +}
> > +
> > +static void set_unaligned_access_static_branches(void)
> > +{
> > +       /*
> > +        * This will be called after check_unaligned_access_all_cpus so the
> > +        * result of unaligned access speed for all CPUs will be available.
> > +        *
> > +        * To avoid the number of online cpus changing between reading
> > +        * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
> > +        * held before calling this function.
> > +        */
> > +
> > +       cpumask_t fast_and_online;
> > +
> > +       cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
> > +
> > +       modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
> > +}
> > +
> > +static int lock_and_set_unaligned_access_static_branch(void)
> > +{
> > +       cpus_read_lock();
> > +       set_unaligned_access_static_branches();
> > +       cpus_read_unlock();
> > +
> > +       return 0;
> > +}
> > +
> > +arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> > +
> > +static int riscv_online_cpu(unsigned int cpu)
> > +{
> > +       static struct page *buf;
> > +
> > +       /* We are already set since the last check */
> > +       if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> > +               goto exit;
> > +
> > +       buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> > +       if (!buf) {
> > +               pr_warn("Allocation failure, not measuring misaligned performance\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       check_unaligned_access(buf);
> > +       __free_pages(buf, MISALIGNED_BUFFER_ORDER);
> > +
> > +exit:
> > +       set_unaligned_access_static_branches();
> > +
> > +       return 0;
> > +}
> > +
> > +static int riscv_offline_cpu(unsigned int cpu)
> > +{
> > +       set_unaligned_access_static_branches_except_cpu(cpu);
> > +
> > +       return 0;
> > +}
> > +
> > +/* Measure unaligned access on all CPUs present at boot in parallel. */
> > +static int check_unaligned_access_all_cpus(void)
> > +{
> > +       unsigned int cpu;
> > +       unsigned int cpu_count = num_possible_cpus();
> > +       struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
> > +                                    GFP_KERNEL);
> > +
> > +       if (!bufs) {
> > +               pr_warn("Allocation failure, not measuring misaligned performance\n");
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +        * Allocate separate buffers for each CPU so there's no fighting over
> > +        * cache lines.
> > +        */
> > +       for_each_cpu(cpu, cpu_online_mask) {
> > +               bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> > +               if (!bufs[cpu]) {
> > +                       pr_warn("Allocation failure, not measuring misaligned performance\n");
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       /* Check everybody except 0, who stays behind to tend jiffies. */
> > +       on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> > +
> > +       /* Check core 0. */
> > +       smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> > +
> > +       /*
> > +        * Setup hotplug callbacks for any new CPUs that come online or go
> > +        * offline.
> > +        */
> > +       cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> > +                                 riscv_online_cpu, riscv_offline_cpu);
> > +
> > +out:
> > +       unaligned_emulation_finish();
> > +       for_each_cpu(cpu, cpu_online_mask) {
> > +               if (bufs[cpu])
> > +                       __free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> > +       }
> > +
> > +       kfree(bufs);
> > +       return 0;
> > +}
> > +
> > +arch_initcall(check_unaligned_access_all_cpus);
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index a7c56b41efd2..d9bd24776a3e 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -149,6 +149,9 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
> >
> >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  {
> > +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +       return RISCV_HWPROBE_MISALIGNED_FAST;
> > +#else
> 
> Ok, two nits, this is a little clunky with the ifdef inside the
> function body. The pattern I see more often is the ifdef/else each
> containing a separate function definition. That would work nicely
> here.
> 
> >         int cpu;
> >         u64 perf = -1ULL;
> >
> > @@ -168,6 +171,7 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >                 return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> >
> >         return perf;
> > +#endif
> >  }
> >
> >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >
> > --
> > 2.43.0
> >

