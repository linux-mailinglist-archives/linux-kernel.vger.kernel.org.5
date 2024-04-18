Return-Path: <linux-kernel+bounces-149466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF98A9180
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A957283E53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C24F896;
	Thu, 18 Apr 2024 03:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QESCY0mJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199714294
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713410272; cv=none; b=XDVY+M0M00qdvKSvAG5ej/tjUvhGib5OYRK9jUC/v8pW5hoC9z0WANOCoIW5+fUor2W+kVRssFKjPW+eo8p2qmre/Vc3/vcRZjJ75YwuPSj6kXTxwlwCOv4f6NASOo13EFKp/DWWJVdDGncfn8KrOsrhfqs128lyUSQyNWB+IV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713410272; c=relaxed/simple;
	bh=AHMJpOA/WNn4yhMKG2A+aeW6Y5MThboNxtwBBUYg+xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoG001thx6ouOz6+VCiwxudZaNneXYlS1dWCbDi5DqTJjHUdrvMn6kKx5JHd4n6NvcRZE5zB3uJH0SHpEsMlS0fRiSdVmkVOG8DyYgrA0KyibRqAKVyWEY+33bmD8Rv1zJJ7snxWG8RSUbsV4WLhRC6HNC+CfYaQ+5poMzxwbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QESCY0mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C9EC072AA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713410271;
	bh=AHMJpOA/WNn4yhMKG2A+aeW6Y5MThboNxtwBBUYg+xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QESCY0mJ1XO8iRUTVmcf7/Qbgj7t7L1NSKKKsp2k7GNvJAL5VhIlmwOCHztYBIVvI
	 FM3Fk4gWF4rdvu532+QSViNlGMHOwlJw9j4scYg8T78ODIyJD+9LTT1CWdJfFxLmDL
	 aretL3sy0I/KBEEHeac+4ovvpZTGfDWUGnV6d/q2supDbexRGNPFTov64y8DKWtZDM
	 01O87MuLd3i2bFJYXZTTwwk5YDuNuR070yTuD/24CHEQS02N0OVtWazDdf8m8gOe5S
	 2AtjP7L4bLwuVK07UaugOJ8Kxea+SiMtJDOoGPqKIA8FAi9agvXIYWPbZNk2U9hMq9
	 7C8/tWVP476+g==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a554afec54eso32765966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMXwptPSSn/5dj0D5U7lbMz0HMzsSFgEiFVoiCJE36GEZT8GSYQZhFi+agTsHWiOzIlSYfyCZJkfkDsD1HnhozKyR8KA3XYYGZet0v
X-Gm-Message-State: AOJu0YwcLHui5fZqDgp2YJtRiqbQVrSgXEH7Ne4ZA70Sy8VYcm8xZVkr
	/MFlWq7meRIeoLIrb/MCA+c2g9UcRxL5KiSlzorRc6mueM/ceUjCduZE+UYFL6XBTlafslyJOx5
	HNfGTeofo8z151miY+TOYjNdJKQM=
X-Google-Smtp-Source: AGHT+IHpWgawESLEc0MsVF2KVC/SpkAVwxgQ6CMFF2JuQZxca6wNbEISg9S+ODGUkaqtWFMybAMn6w6jVkEDb7fGx90=
X-Received: by 2002:a17:907:9947:b0:a4e:7a36:4c38 with SMTP id
 kl7-20020a170907994700b00a4e7a364c38mr723682ejc.20.1713410270086; Wed, 17 Apr
 2024 20:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417095951.2635-1-yangtiezhu@loongson.cn> <20240417095951.2635-4-yangtiezhu@loongson.cn>
In-Reply-To: <20240417095951.2635-4-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Apr 2024 11:17:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Srx551P8_7i5JP020bJj9sgVkt8ndNraQ0D_q4L8xxA@mail.gmail.com>
Message-ID: <CAAhV-H7Srx551P8_7i5JP020bJj9sgVkt8ndNraQ0D_q4L8xxA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] LoongArch: Give chance to build under !CONFIG_SMP
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Wed, Apr 17, 2024 at 6:00=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> In the current code, SMP is selected in Kconfig for LoongArch, the users
> can not unset it, this is reasonable for a multiprocessor machine. But as
> the help info of config SMP said, if you have a system with only one CPU,
> say N. On a uniprocessor machine, the kernel will run faster if you say N
> here.
>
> The Loongson-2K0500 is a single-core CPU for applications like industrial
> control, printing terminals, and BMC (Baseboard Management Controller),
> there are many development boards, products and solutions on the market,
> so it is better and necessary to give a chance to build under !CONFIG_SMP
> for a uniprocessor machine.
>
> First of all, do not select SMP for config LOONGARCH in Kconfig to make i=
t
> possible to unset CONFIG_SMP. Then, do some changes to fix the warnings a=
nd
> errors if CONFIG_SMP is not set.
>
> (1) Define get_ipi_irq() only if CONFIG_SMP is set to fix the warning:
> arch/loongarch/kernel/irq.c:90:19: warning: 'get_ipi_irq' defined but not=
 used [-Wunused-function]
>
> (2) Add "#ifdef CONFIG_SMP" in asm/smp.h to fix the warning:
> ./arch/loongarch/include/asm/smp.h:49:9: warning: "raw_smp_processor_id" =
redefined
>    49 | #define raw_smp_processor_id raw_smp_processor_id
>       |         ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/smp.h:198:9: note: this is the location of the previous d=
efinition
>   198 | #define raw_smp_processor_id()                  0
>
> (3) Define machine_shutdown() as empty under !CONFIG_SMP to fix the error=
:
> arch/loongarch/kernel/machine_kexec.c: In function 'machine_shutdown':
> arch/loongarch/kernel/machine_kexec.c:233:25: error: implicit declaration=
 of function 'cpu_device_up'; did you mean 'put_device'? [-Wimplicit-functi=
on-declaration]
>
> (4) Make config SCHED_SMT depends on SMP to fix many errors such as:
> kernel/sched/core.c: In function 'sched_core_find':
> kernel/sched/core.c:310:43: error: 'struct rq' has no member named 'cpu'
>
> (5) Define cpu_logical_map(cpu) as read_csr_cpuid() under !CONFIG_SMP
> in asm/smp.h and then include asm/smp.h in asm/acpi.h (because acpi.h
> is included in linux/irq.h indirectly) to fix many build errors under
> drivers/irqchip such as:
> drivers/irqchip/irq-loongson-eiointc.c: In function 'cpu_to_eio_node':
> drivers/irqchip/irq-loongson-eiointc.c:59:16: error: implicit declaration=
 of function 'cpu_logical_map' [-Wimplicit-function-declaration]
>
> When running the UnixBench tests with "-c 1" single-streamed pass,
> the improvement in performance is about 9 percent with this patch.
>
> By the way, it is helpful to debug and analysis the kernel issue
> of multi-core system under !CONFIG_SMP.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig                | 2 +-
>  arch/loongarch/include/asm/acpi.h     | 1 +
>  arch/loongarch/include/asm/smp.h      | 5 +++++
>  arch/loongarch/kernel/irq.c           | 2 ++
>  arch/loongarch/kernel/machine_kexec.c | 2 +-
>  5 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..8d892de0b7a8 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -174,7 +174,6 @@ config LOONGARCH
>         select PCI_QUIRKS
>         select PERF_USE_VMALLOC
>         select RTC_LIB
> -       select SMP
>         select SPARSE_IRQ
>         select SYSCTL_ARCH_UNALIGN_ALLOW
>         select SYSCTL_ARCH_UNALIGN_NO_WARN
> @@ -420,6 +419,7 @@ config EFI_STUB
>
>  config SCHED_SMT
>         bool "SMT scheduler support"
> +       depends on SMP
>         default y
>         help
>           Improves scheduler's performance when there are multiple
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/a=
sm/acpi.h
> index 49e29b29996f..313f66f7913a 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -8,6 +8,7 @@
>  #ifndef _ASM_LOONGARCH_ACPI_H
>  #define _ASM_LOONGARCH_ACPI_H
>
> +#include <asm/smp.h>
>  #include <asm/suspend.h>
>
>  #ifdef CONFIG_ACPI
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index f81e5f01d619..1ec11b57e60c 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -6,6 +6,7 @@
>  #ifndef __ASM_SMP_H
>  #define __ASM_SMP_H
>
> +#ifdef CONFIG_SMP
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/linkage.h>
> @@ -101,4 +102,8 @@ static inline void __cpu_die(unsigned int cpu)
>  }
>  #endif
>
> +#else /* !CONFIG_SMP */
> +#define cpu_logical_map(cpu)   read_csr_cpuid()
> +#endif /* CONFIG_SMP */
Non-SMP kernel is not supposed to run on SMP hardware, just define it
to 0 to keep it as simple as possible.

Huacai

> +
>  #endif /* __ASM_SMP_H */
> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
> index 883e5066ae44..e791fa275ec5 100644
> --- a/arch/loongarch/kernel/irq.c
> +++ b/arch/loongarch/kernel/irq.c
> @@ -87,6 +87,7 @@ static void __init init_vec_parent_group(void)
>         acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
>  }
>
> +#ifdef CONFIG_SMP
>  static int __init get_ipi_irq(void)
>  {
>         struct irq_domain *d =3D irq_find_matching_fwnode(cpuintc_handle,=
 DOMAIN_BUS_ANY);
> @@ -96,6 +97,7 @@ static int __init get_ipi_irq(void)
>
>         return -EINVAL;
>  }
> +#endif
>
>  void __init init_IRQ(void)
>  {
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index 2dcb9e003657..8ae641dc53bb 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -225,6 +225,7 @@ void crash_smp_send_stop(void)
>
>  void machine_shutdown(void)
>  {
> +#ifdef CONFIG_SMP
>         int cpu;
>
>         /* All CPUs go to reboot_code_buffer */
> @@ -232,7 +233,6 @@ void machine_shutdown(void)
>                 if (!cpu_online(cpu))
>                         cpu_device_up(get_cpu_device(cpu));
>
> -#ifdef CONFIG_SMP
>         smp_call_function(kexec_shutdown_secondary, NULL, 0);
>  #endif
>  }
> --
> 2.42.0
>
>

