Return-Path: <linux-kernel+bounces-96775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09087614A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D4CB20C26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B852535D9;
	Fri,  8 Mar 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DStOXZep"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF90535BC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891558; cv=none; b=JD+hKSEj8bV6+FYf2eVoUwpxQcow347MgbFgzbKUixPQFOBA5S78MZ1khdDG0r2Jv4Jkkcv1F00MJiPNnJ3244NqGn2qNXt2czJP8POrPj67/KHISLnbr9pMIGjiwrYAu/S1zjdffZ3yEe2knZwNKkIWrmjdYPBEqXO1olxgu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891558; c=relaxed/simple;
	bh=MC5WJ3/+AfvagxbIMvzTSqJdS5dcRJxajZSX4mEiWV0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGVm6CJn6Ii7GKBLzq3bVlSvuWRzWfN3CZaqj9LpBxySRjohWknq4svVonbAlh0psAK7wd3zUvzOXjEao6MkUJr9ESUZi4WnuFmnnw54sdFTcyjJv5EMbYUD9V1IjnjrKj0+w/Hi68Ek6QmzKl4Cfpx7eMoWMIp6IXMW2TZmV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DStOXZep; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0133E3F6B1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709891547;
	bh=SuoktzUVOHfmeIXEcLMg0wlnX/ibuHT8z/+W2rAnHaI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DStOXZeptIVXT2R0b/t63jkJY+pozC9fvFMRO/0uZD/YTzT1hPhc6V+MGqGbY43UQ
	 DInGCjOyDuJg0yK0fV2Ta9xxhr5a4ZyuGGPA7AN9JOBl+PAZk8xH+ZWiO0ZW3PhKB2
	 srpkqNmTI0smAJ/dZIfYrqGHVKY//CYfp4y5ESGY6eyjonV4xMZYejsQhrIvVLy+CT
	 emwrs+Z0s421/KjAuffuQtiwSJNOTNBwU3IG4U3nr1EeR5s1T0uXFl88DMp8aHHBAV
	 CdpiVLrMRKzUBYfo3e+XERDY//A5GPcgLbXlYJzkLqYAcnanaH7QqInYJeYItyfWQq
	 iE2R8klUljPTA==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42ef69e3758so18545381cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891546; x=1710496346;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuoktzUVOHfmeIXEcLMg0wlnX/ibuHT8z/+W2rAnHaI=;
        b=pRFn4/PO7x3RWVx0LMMkkvumG++hWJ/axM7DzWqZ2YRIGcs1LoWZLJ/E3uHUZEvjd6
         QBKPxrEVAvOLQ1VoudJ1uhVKI/D2eYnrHY2IcQE9PUn5k/fM0SeryCbJ6XHfSUthFp9j
         TIoKTl7PlJbijTm+nvawrKmJFc6XFSZjKoP8KnnH4iKGTzq0SZritqpEnl7+atYwQ1HB
         t9TRRZi19Uvmnu6oZ22UEB/P6LNLTIgcLCUxleFtBhPdc2Omh7ORxlgYhXuDao+8X7VE
         WZwgVBlaCrb0dTpxOjDkBIJLts5bAwsvDJ/Qg+oaVxH+lgOAUBNXvfVagoGFuPWF4TYg
         x+hA==
X-Forwarded-Encrypted: i=1; AJvYcCWgtD7f9us2AC4N3+oWPBOrECQgthteXIKkx8WbYXAm8Vr1zIunStWOcKiTz8zJfKNlbfnDSk6tQeM/FnXjhnn00jwDN/nuCMo9CZvU
X-Gm-Message-State: AOJu0YxXk5YIxESyYComFcoOBFAjv3wQyAbNatTjcw7ey+Fx8ZmWax0N
	oQswhG+HqBEAcrVulCHv2NQJef0h1ROTKI6dEv+k0sYyrEPCMybWrhnOgAt+a6TlNxx0xywE4W1
	ZPXuTOoS58C74NjVYZBcQ2Qhsr7mjK2Nx2Qj9wDMEnEIFT9Le1xfBq1geaIL5iQrYT/i6O1Vee/
	xhKmD+tAppdg39B7Ch6aos69Bwu64WVxyAkYDXXuIPbYYWfSXwe96i
X-Received: by 2002:ac8:7d51:0:b0:42e:9fb4:d2c9 with SMTP id h17-20020ac87d51000000b0042e9fb4d2c9mr11880686qtb.66.1709891545764;
        Fri, 08 Mar 2024 01:52:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1PKyI4eqLjtSxgxrIzXNSZirfvR7JdFZykmdV7eUoPbaWEFoYcxvdDPNxIC2IQmrMsiVQTDHJatJzD4yPN8o=
X-Received: by 2002:ac8:7d51:0:b0:42e:9fb4:d2c9 with SMTP id
 h17-20020ac87d51000000b0042e9fb4d2c9mr11880663qtb.66.1709891545209; Fri, 08
 Mar 2024 01:52:25 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Mar 2024 01:52:24 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240307-disable_misaligned_probe_config-v8-4-55d696cb398b@rivosinc.com>
References: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
 <20240307-disable_misaligned_probe_config-v8-4-55d696cb398b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 8 Mar 2024 01:52:24 -0800
Message-ID: <CAJM55Z9SYA=QMg0Wg-e0Q8nOTP6qSKkc+kxHMGOmmmWrEcVf7w@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] riscv: Set unaligned access speed at compile time
To: Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Eric Biggers <ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Charles Lohr <lohr85@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Charlie Jenkins wrote:
> Introduce Kconfig options to set the kernel unaligned access support.
> These options provide a non-portable alternative to the runtime
> unaligned access probe.
>
> To support this, the unaligned access probing code is moved into it's
> own file and gated behind a new RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT
> option.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig                         |  60 ++++--
>  arch/riscv/include/asm/cpufeature.h        |  24 +--
>  arch/riscv/kernel/Makefile                 |   4 +-
>  arch/riscv/kernel/cpufeature.c             | 272 ----------------------------
>  arch/riscv/kernel/sys_hwprobe.c            |  13 ++
>  arch/riscv/kernel/traps_misaligned.c       |   2 +
>  arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
>  7 files changed, 361 insertions(+), 296 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..28c1e75ea88a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -688,27 +688,63 @@ config THREAD_SIZE_ORDER
>  	  affects irq stack size, which is equal to thread stack size.
>
>  config RISCV_MISALIGNED
> -	bool "Support misaligned load/store traps for kernel and userspace"
> +	bool
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
> -	default y
>  	help
> -	  Say Y here if you want the kernel to embed support for misaligned
> -	  load/store for both kernel and userspace. When disable, misaligned
> -	  accesses will generate SIGBUS in userspace and panic in kernel.
> +	  Embed support for misaligned load/store for both kernel and userspace.
> +	  When disabled, misaligned accesses will generate SIGBUS in userspace
> +	  and panic in the kernel.

Hmm.. this is *may* generate SIGBUS in userspace and panic the kernel. The CPU
could support unaligned access natively or there might be a handler in M-mode,
right?

> +
> +choice
> +	prompt "Unaligned Accesses Support"
> +	default RISCV_PROBE_UNALIGNED_ACCESS
> +	help
> +	  This determines the level of support for unaligned accesses. This
> +	  information is used by the kernel to perform optimizations. It is also
> +	  exposed to user space via the hwprobe syscall. The hardware will be
> +	  probed at boot by default.
> +
> +config RISCV_PROBE_UNALIGNED_ACCESS
> +	bool "Probe for hardware unaligned access support"
> +	select RISCV_MISALIGNED
> +	help
> +	  During boot, the kernel will run a series of tests to determine the
> +	  speed of unaligned accesses. This probing will dynamically determine
> +	  the speed of unaligned accesses on the underlying system. If unaligned
> +	  memory accesses trap into the kernel as they are not supported by the
> +	  system, the kernel will emulate the unaligned accesses to preserve the
> +	  UABI.
> +
> +config RISCV_EMULATED_UNALIGNED_ACCESS
> +	bool "Emulate unaligned access where system support is missing"
> +	select RISCV_MISALIGNED
> +	help
> +	  If unaligned memory accesses trap into the kernel as they are not
> +	  supported by the system, the kernel will emulate the unaligned
> +	  accesses to preserve the UABI. When the underlying system does support
> +	  unaligned accesses, the unaligned accesses are assumed to be slow.

It's still not quite clear to me when you'd want to choose this over probing
above. Assuming the probe measures correctly this can only result in a kernel
that behaves the same or slower than with the option above, right?

> +
> +config RISCV_SLOW_UNALIGNED_ACCESS
> +	bool "Assume the system supports slow unaligned memory accesses"
> +	depends on NONPORTABLE
> +	help
> +	  Assume that the system supports slow unaligned memory accesses. The
> +	  kernel and userspace programs may not be able to run at all on systems
> +	  that do not support unaligned memory accesses.

Again you're just explicitly saying no to the optimizations the kernel might do
if it detects fast unaligned access, only here you'll also crash if they're not
handled by the CPU or M-mode. Why would you want that?

I'm probably missing something, but the only reason I can think of is if you
want build a really small kernel and save the few bytes for the handler and
probing code.

/Emil

>  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> -	bool "Assume the CPU supports fast unaligned memory accesses"
> +	bool "Assume the system supports fast unaligned memory accesses"
>  	depends on NONPORTABLE
>  	select DCACHE_WORD_ACCESS if MMU
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	help
> -	  Say Y here if you want the kernel to assume that the CPU supports
> -	  efficient unaligned memory accesses.  When enabled, this option
> -	  improves the performance of the kernel on such CPUs.  However, the
> -	  kernel will run much more slowly, or will not be able to run at all,
> -	  on CPUs that do not support efficient unaligned memory accesses.
> +	  Assume that the system supports fast unaligned memory accesses. When
> +	  enabled, this option improves the performance of the kernel on such
> +	  systems. However, the kernel and userspace programs will run much more
> +	  slowly, or will not be able to run at all, on systems that do not
> +	  support efficient unaligned memory accesses.
>
> -	  If unsure what to do here, say N.
> +endchoice
>
>  endmenu # "Platform type"
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 6fec91845aa0..46061f5e9764 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -28,37 +28,39 @@ struct riscv_isainfo {
>
>  DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>
> -DECLARE_PER_CPU(long, misaligned_access_speed);
> -
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>
>  void riscv_user_isa_enable(void);
>
> -#ifdef CONFIG_RISCV_MISALIGNED
> -bool unaligned_ctl_available(void);
> +#if defined(CONFIG_RISCV_MISALIGNED)
>  bool check_unaligned_access_emulated_all_cpus(void);
>  void unaligned_emulation_finish(void);
> +bool unaligned_ctl_available(void);
> +DECLARE_PER_CPU(long, misaligned_access_speed);
>  #else
>  static inline bool unaligned_ctl_available(void)
>  {
>  	return false;
>  }
> -
> -static inline bool check_unaligned_access_emulated(int cpu)
> -{
> -	return false;
> -}
> -
> -static inline void unaligned_emulation_finish(void) {}
>  #endif
>
> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
>
>  static __always_inline bool has_fast_unaligned_accesses(void)
>  {
>  	return static_branch_likely(&fast_unaligned_access_speed_key);
>  }
> +#else
> +static __always_inline bool has_fast_unaligned_accesses(void)
> +{
> +	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
> +		return true;
> +	else
> +		return false;
> +}
> +#endif
>
>  unsigned long riscv_get_elf_hwcap(void);
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..c8085126a6f9 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -38,7 +38,6 @@ extra-y += vmlinux.lds
>  obj-y	+= head.o
>  obj-y	+= soc.o
>  obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
> -obj-y	+= copy-unaligned.o
>  obj-y	+= cpu.o
>  obj-y	+= cpufeature.o
>  obj-y	+= entry.o
> @@ -62,6 +61,9 @@ obj-y	+= tests/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> +obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
> +obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
> +
>  obj-$(CONFIG_FPU)		+= fpu.o
>  obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
>  obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index abb3a2f53106..319670af5704 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -11,7 +11,6 @@
>  #include <linux/cpu.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/ctype.h>
> -#include <linux/jump_label.h>
>  #include <linux/log2.h>
>  #include <linux/memory.h>
>  #include <linux/module.h>
> @@ -21,20 +20,12 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwcap.h>
> -#include <asm/hwprobe.h>
>  #include <asm/patch.h>
>  #include <asm/processor.h>
>  #include <asm/vector.h>
>
> -#include "copy-unaligned.h"
> -
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>
> -#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> -#define MISALIGNED_BUFFER_SIZE 0x4000
> -#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> -#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> -
>  unsigned long elf_hwcap __read_mostly;
>
>  /* Host ISA bitmap */
> @@ -43,11 +34,6 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>
> -/* Performance information */
> -DEFINE_PER_CPU(long, misaligned_access_speed);
> -
> -static cpumask_t fast_misaligned_access;
> -
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -706,264 +692,6 @@ unsigned long riscv_get_elf_hwcap(void)
>  	return hwcap;
>  }
>
> -static int check_unaligned_access(void *param)
> -{
> -	int cpu = smp_processor_id();
> -	u64 start_cycles, end_cycles;
> -	u64 word_cycles;
> -	u64 byte_cycles;
> -	int ratio;
> -	unsigned long start_jiffies, now;
> -	struct page *page = param;
> -	void *dst;
> -	void *src;
> -	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
> -
> -	if (IS_ENABLED(CONFIG_RISCV_MISALIGNED) &&
> -	    per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> -		return 0;
> -
> -	/* Make an unaligned destination buffer. */
> -	dst = (void *)((unsigned long)page_address(page) | 0x1);
> -	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
> -	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
> -	src += 2;
> -	word_cycles = -1ULL;
> -	/* Do a warmup. */
> -	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> -	preempt_disable();
> -	start_jiffies = jiffies;
> -	while ((now = jiffies) == start_jiffies)
> -		cpu_relax();
> -
> -	/*
> -	 * For a fixed amount of time, repeatedly try the function, and take
> -	 * the best time in cycles as the measurement.
> -	 */
> -	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> -		start_cycles = get_cycles64();
> -		/* Ensure the CSR read can't reorder WRT to the copy. */
> -		mb();
> -		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> -		/* Ensure the copy ends before the end time is snapped. */
> -		mb();
> -		end_cycles = get_cycles64();
> -		if ((end_cycles - start_cycles) < word_cycles)
> -			word_cycles = end_cycles - start_cycles;
> -	}
> -
> -	byte_cycles = -1ULL;
> -	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> -	start_jiffies = jiffies;
> -	while ((now = jiffies) == start_jiffies)
> -		cpu_relax();
> -
> -	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> -		start_cycles = get_cycles64();
> -		mb();
> -		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> -		mb();
> -		end_cycles = get_cycles64();
> -		if ((end_cycles - start_cycles) < byte_cycles)
> -			byte_cycles = end_cycles - start_cycles;
> -	}
> -
> -	preempt_enable();
> -
> -	/* Don't divide by zero. */
> -	if (!word_cycles || !byte_cycles) {
> -		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
> -			cpu);
> -
> -		return 0;
> -	}
> -
> -	if (word_cycles < byte_cycles)
> -		speed = RISCV_HWPROBE_MISALIGNED_FAST;
> -
> -	ratio = div_u64((byte_cycles * 100), word_cycles);
> -	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
> -		cpu,
> -		ratio / 100,
> -		ratio % 100,
> -		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> -
> -	per_cpu(misaligned_access_speed, cpu) = speed;
> -
> -	/*
> -	 * Set the value of fast_misaligned_access of a CPU. These operations
> -	 * are atomic to avoid race conditions.
> -	 */
> -	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
> -		cpumask_set_cpu(cpu, &fast_misaligned_access);
> -	else
> -		cpumask_clear_cpu(cpu, &fast_misaligned_access);
> -
> -	return 0;
> -}
> -
> -static void check_unaligned_access_nonboot_cpu(void *param)
> -{
> -	unsigned int cpu = smp_processor_id();
> -	struct page **pages = param;
> -
> -	if (smp_processor_id() != 0)
> -		check_unaligned_access(pages[cpu]);
> -}
> -
> -DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> -
> -static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
> -{
> -	if (cpumask_weight(mask) == weight)
> -		static_branch_enable_cpuslocked(&fast_unaligned_access_speed_key);
> -	else
> -		static_branch_disable_cpuslocked(&fast_unaligned_access_speed_key);
> -}
> -
> -static void set_unaligned_access_static_branches_except_cpu(int cpu)
> -{
> -	/*
> -	 * Same as set_unaligned_access_static_branches, except excludes the
> -	 * given CPU from the result. When a CPU is hotplugged into an offline
> -	 * state, this function is called before the CPU is set to offline in
> -	 * the cpumask, and thus the CPU needs to be explicitly excluded.
> -	 */
> -
> -	cpumask_t fast_except_me;
> -
> -	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
> -	cpumask_clear_cpu(cpu, &fast_except_me);
> -
> -	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
> -}
> -
> -static void set_unaligned_access_static_branches(void)
> -{
> -	/*
> -	 * This will be called after check_unaligned_access_all_cpus so the
> -	 * result of unaligned access speed for all CPUs will be available.
> -	 *
> -	 * To avoid the number of online cpus changing between reading
> -	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
> -	 * held before calling this function.
> -	 */
> -
> -	cpumask_t fast_and_online;
> -
> -	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
> -
> -	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
> -}
> -
> -static int lock_and_set_unaligned_access_static_branch(void)
> -{
> -	cpus_read_lock();
> -	set_unaligned_access_static_branches();
> -	cpus_read_unlock();
> -
> -	return 0;
> -}
> -
> -arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> -
> -static int riscv_online_cpu(unsigned int cpu)
> -{
> -	static struct page *buf;
> -
> -	/* We are already set since the last check */
> -	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> -		goto exit;
> -
> -	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> -	if (!buf) {
> -		pr_warn("Allocation failure, not measuring misaligned performance\n");
> -		return -ENOMEM;
> -	}
> -
> -	check_unaligned_access(buf);
> -	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
> -
> -exit:
> -	set_unaligned_access_static_branches();
> -
> -	return 0;
> -}
> -
> -static int riscv_offline_cpu(unsigned int cpu)
> -{
> -	set_unaligned_access_static_branches_except_cpu(cpu);
> -
> -	return 0;
> -}
> -
> -/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> -static int check_unaligned_access_speed_all_cpus(void)
> -{
> -	unsigned int cpu;
> -	unsigned int cpu_count = num_possible_cpus();
> -	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
> -				     GFP_KERNEL);
> -
> -	if (!bufs) {
> -		pr_warn("Allocation failure, not measuring misaligned performance\n");
> -		return 0;
> -	}
> -
> -	/*
> -	 * Allocate separate buffers for each CPU so there's no fighting over
> -	 * cache lines.
> -	 */
> -	for_each_cpu(cpu, cpu_online_mask) {
> -		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> -		if (!bufs[cpu]) {
> -			pr_warn("Allocation failure, not measuring misaligned performance\n");
> -			goto out;
> -		}
> -	}
> -
> -	/* Check everybody except 0, who stays behind to tend jiffies. */
> -	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> -
> -	/* Check core 0. */
> -	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> -
> -	/*
> -	 * Setup hotplug callbacks for any new CPUs that come online or go
> -	 * offline.
> -	 */
> -	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> -				  riscv_online_cpu, riscv_offline_cpu);
> -
> -out:
> -	for_each_cpu(cpu, cpu_online_mask) {
> -		if (bufs[cpu])
> -			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> -	}
> -
> -	kfree(bufs);
> -	return 0;
> -}
> -
> -#ifdef CONFIG_RISCV_MISALIGNED
> -static int check_unaligned_access_all_cpus(void)
> -{
> -	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> -
> -	if (!all_cpus_emulated)
> -		return check_unaligned_access_speed_all_cpus();
> -
> -	return 0;
> -}
> -#else
> -static int check_unaligned_access_all_cpus(void)
> -{
> -	return check_unaligned_access_speed_all_cpus();
> -}
> -#endif
> -
> -arch_initcall(check_unaligned_access_all_cpus);
> -
>  void riscv_user_isa_enable(void)
>  {
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index a7c56b41efd2..8cae41a502dd 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -147,6 +147,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
>  	return (pair.value & ext);
>  }
>
> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
>  	int cpu;
> @@ -169,6 +170,18 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>
>  	return perf;
>  }
> +#else
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
> +		return RISCV_HWPROBE_MISALIGNED_FAST;
> +
> +	if (IS_ENABLED(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS) && unaligned_ctl_available())
> +		return RISCV_HWPROBE_MISALIGNED_EMULATED;
> +
> +	return RISCV_HWPROBE_MISALIGNED_SLOW;
> +}
> +#endif
>
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  			     const struct cpumask *cpus)
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index e55718179f42..2adb7c3e4dd5 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
>
>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>  	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
> +#endif
>
>  	if (!unaligned_enabled)
>  		return -1;
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> new file mode 100644
> index 000000000000..52264ea4f0bd
> --- /dev/null
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Rivos Inc.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/jump_label.h>
> +#include <linux/mm.h>
> +#include <linux/smp.h>
> +#include <linux/types.h>
> +#include <asm/cpufeature.h>
> +#include <asm/hwprobe.h>
> +
> +#include "copy-unaligned.h"
> +
> +#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> +#define MISALIGNED_BUFFER_SIZE 0x4000
> +#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> +#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> +
> +DEFINE_PER_CPU(long, misaligned_access_speed);
> +
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> +static cpumask_t fast_misaligned_access;
> +static int check_unaligned_access(void *param)
> +{
> +	int cpu = smp_processor_id();
> +	u64 start_cycles, end_cycles;
> +	u64 word_cycles;
> +	u64 byte_cycles;
> +	int ratio;
> +	unsigned long start_jiffies, now;
> +	struct page *page = param;
> +	void *dst;
> +	void *src;
> +	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
> +
> +	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> +		return 0;
> +
> +	/* Make an unaligned destination buffer. */
> +	dst = (void *)((unsigned long)page_address(page) | 0x1);
> +	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
> +	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
> +	src += 2;
> +	word_cycles = -1ULL;
> +	/* Do a warmup. */
> +	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +	preempt_disable();
> +	start_jiffies = jiffies;
> +	while ((now = jiffies) == start_jiffies)
> +		cpu_relax();
> +
> +	/*
> +	 * For a fixed amount of time, repeatedly try the function, and take
> +	 * the best time in cycles as the measurement.
> +	 */
> +	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> +		start_cycles = get_cycles64();
> +		/* Ensure the CSR read can't reorder WRT to the copy. */
> +		mb();
> +		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +		/* Ensure the copy ends before the end time is snapped. */
> +		mb();
> +		end_cycles = get_cycles64();
> +		if ((end_cycles - start_cycles) < word_cycles)
> +			word_cycles = end_cycles - start_cycles;
> +	}
> +
> +	byte_cycles = -1ULL;
> +	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +	start_jiffies = jiffies;
> +	while ((now = jiffies) == start_jiffies)
> +		cpu_relax();
> +
> +	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> +		start_cycles = get_cycles64();
> +		mb();
> +		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +		mb();
> +		end_cycles = get_cycles64();
> +		if ((end_cycles - start_cycles) < byte_cycles)
> +			byte_cycles = end_cycles - start_cycles;
> +	}
> +
> +	preempt_enable();
> +
> +	/* Don't divide by zero. */
> +	if (!word_cycles || !byte_cycles) {
> +		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
> +			cpu);
> +
> +		return 0;
> +	}
> +
> +	if (word_cycles < byte_cycles)
> +		speed = RISCV_HWPROBE_MISALIGNED_FAST;
> +
> +	ratio = div_u64((byte_cycles * 100), word_cycles);
> +	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
> +		cpu,
> +		ratio / 100,
> +		ratio % 100,
> +		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> +
> +	per_cpu(misaligned_access_speed, cpu) = speed;
> +
> +	/*
> +	 * Set the value of fast_misaligned_access of a CPU. These operations
> +	 * are atomic to avoid race conditions.
> +	 */
> +	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
> +		cpumask_set_cpu(cpu, &fast_misaligned_access);
> +	else
> +		cpumask_clear_cpu(cpu, &fast_misaligned_access);
> +
> +	return 0;
> +}
> +
> +static void check_unaligned_access_nonboot_cpu(void *param)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct page **pages = param;
> +
> +	if (smp_processor_id() != 0)
> +		check_unaligned_access(pages[cpu]);
> +}
> +
> +DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> +
> +static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
> +{
> +	if (cpumask_weight(mask) == weight)
> +		static_branch_enable_cpuslocked(&fast_unaligned_access_speed_key);
> +	else
> +		static_branch_disable_cpuslocked(&fast_unaligned_access_speed_key);
> +}
> +
> +static void set_unaligned_access_static_branches_except_cpu(int cpu)
> +{
> +	/*
> +	 * Same as set_unaligned_access_static_branches, except excludes the
> +	 * given CPU from the result. When a CPU is hotplugged into an offline
> +	 * state, this function is called before the CPU is set to offline in
> +	 * the cpumask, and thus the CPU needs to be explicitly excluded.
> +	 */
> +
> +	cpumask_t fast_except_me;
> +
> +	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
> +	cpumask_clear_cpu(cpu, &fast_except_me);
> +
> +	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
> +}
> +
> +static void set_unaligned_access_static_branches(void)
> +{
> +	/*
> +	 * This will be called after check_unaligned_access_all_cpus so the
> +	 * result of unaligned access speed for all CPUs will be available.
> +	 *
> +	 * To avoid the number of online cpus changing between reading
> +	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
> +	 * held before calling this function.
> +	 */
> +
> +	cpumask_t fast_and_online;
> +
> +	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
> +
> +	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
> +}
> +
> +static int lock_and_set_unaligned_access_static_branch(void)
> +{
> +	cpus_read_lock();
> +	set_unaligned_access_static_branches();
> +	cpus_read_unlock();
> +
> +	return 0;
> +}
> +
> +arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> +
> +static int riscv_online_cpu(unsigned int cpu)
> +{
> +	static struct page *buf;
> +
> +	/* We are already set since the last check */
> +	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
> +		goto exit;
> +
> +	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +	if (!buf) {
> +		pr_warn("Allocation failure, not measuring misaligned performance\n");
> +		return -ENOMEM;
> +	}
> +
> +	check_unaligned_access(buf);
> +	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
> +
> +exit:
> +	set_unaligned_access_static_branches();
> +
> +	return 0;
> +}
> +
> +static int riscv_offline_cpu(unsigned int cpu)
> +{
> +	set_unaligned_access_static_branches_except_cpu(cpu);
> +
> +	return 0;
> +}
> +
> +/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> +static int check_unaligned_access_speed_all_cpus(void)
> +{
> +	unsigned int cpu;
> +	unsigned int cpu_count = num_possible_cpus();
> +	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
> +				     GFP_KERNEL);
> +
> +	if (!bufs) {
> +		pr_warn("Allocation failure, not measuring misaligned performance\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Allocate separate buffers for each CPU so there's no fighting over
> +	 * cache lines.
> +	 */
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +		if (!bufs[cpu]) {
> +			pr_warn("Allocation failure, not measuring misaligned performance\n");
> +			goto out;
> +		}
> +	}
> +
> +	/* Check everybody except 0, who stays behind to tend jiffies. */
> +	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> +
> +	/* Check core 0. */
> +	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> +
> +	/*
> +	 * Setup hotplug callbacks for any new CPUs that come online or go
> +	 * offline.
> +	 */
> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> +				  riscv_online_cpu, riscv_offline_cpu);
> +
> +out:
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		if (bufs[cpu])
> +			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> +	}
> +
> +	kfree(bufs);
> +	return 0;
> +}
> +
> +static int check_unaligned_access_all_cpus(void)
> +{
> +	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> +
> +	if (!all_cpus_emulated)
> +		return check_unaligned_access_speed_all_cpus();
> +
> +	return 0;
> +}
> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> +static int check_unaligned_access_all_cpus(void)
> +{
> +	check_unaligned_access_emulated_all_cpus();
> +
> +	return 0;
> +}
> +#endif
> +
> +arch_initcall(check_unaligned_access_all_cpus);
>
> --
> 2.43.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

