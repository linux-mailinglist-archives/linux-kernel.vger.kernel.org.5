Return-Path: <linux-kernel+bounces-119024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5593688C2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792B21C3595E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB674433;
	Tue, 26 Mar 2024 12:59:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFC6FE2B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457941; cv=none; b=RWerBEAIZ0EWrwzzQwKuBhbiCypG8lKscbDgFWi3hiWfRTjjnbsBKGiYbjyvqAOui5vWK4kl7Y+a+VoRyaNu09A6C3Y8YyOnk2yuN9ztQ6iIThpZ+IEdbKGDrnvyMvqMDzl+S66yCuNFSdm39SDIHLalbdVufEJnQNnjyM7JyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457941; c=relaxed/simple;
	bh=52VpueoKuCHelfDdjmDBD/RaiFytrkMn0a6ic5DGkUk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qnXv4N1DY/qXDKQvFEQ8wpE2bLW9IshmPq58NxOVpcbSHI75PLfv3RjNd5ks8EmESibFz8gcDmo6TjUj+JsY9azhA+67OvzSjXMBskHDMCv968BzXYEMIJl9iDjantOVCXiPxQDKc56Lzx9EkwSa7kG2cM1ERApCpnvhqZMdPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8DxvuuPxgJm92AeAA--.5427S3;
	Tue, 26 Mar 2024 20:58:55 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX8+LxgJmJvJoAA--.9641S3;
	Tue, 26 Mar 2024 20:58:53 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Give chance to build under !CONFIG_SMP
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 loongson-kernel@lists.loongnix.cn
References: <20240326062101.9822-1-yangtiezhu@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <55494710-ddaa-c35a-f6cd-5baf98b13931@loongson.cn>
Date: Tue, 26 Mar 2024 20:58:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240326062101.9822-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxX8+LxgJmJvJoAA--.9641S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFy7uF1DXr4DXrWfKry7twc_yoWfWF1rpF
	WqyF4kJr4rGr4kur90y3y3ury5Jwn7G3y2g3W2kay8JFnrXw1UZr1kJ3srXFykKws5WF4I
	gFn3ua4a9a1UAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUU
	U==



On 2024/3/26 下午2:21, Tiezhu Yang wrote:
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
> First of all, do not select SMP for config LOONGARCH in Kconfig to make it
> possible to unset CONFIG_SMP. Then, do some changes to fix the warnings and
> errors if CONFIG_SMP is not set.
> 
> (1) Select GENERIC_IRQ_EFFECTIVE_AFF_MASK only if SMP for config
> IRQ_LOONGARCH_CPU to fix the warning when make menuconfig:
> WARNING: unmet direct dependencies detected for GENERIC_IRQ_EFFECTIVE_AFF_MASK
> 
> (2) Define cpu_logical_map(cpu) as 0 under !CONFIG_SMP in asm/smp.h and
> include asm/smp.h in asm/acpi.h to fix the error:
> /arch/loongarch/include/asm/acpi.h: In function ‘get_acpi_id_for_cpu’:
> /arch/loongarch/include/asm/acpi.h:44:30: error: implicit declaration of function ‘cpu_logical_map’ [-Wimplicit-function-declaration]
> 
> (3) Define get_ipi_irq() only if CONFIG_SMP is set to fix the warning:
> arch/loongarch/kernel/irq.c:90:19: warning: ‘get_ipi_irq’ defined but not used [-Wunused-function]
> 
> (4) Define machine_shutdown() as empty under !CONFIG_SMP to fix the error:
> arch/loongarch/kernel/machine_kexec.c: In function ‘machine_shutdown’:
> arch/loongarch/kernel/machine_kexec.c:233:25: error: implicit declaration of function ‘cpu_device_up’; did you mean ‘put_device’? [-Wimplicit-function-declaration]
> 
> (5) Make config SCHED_SMT depends on SMP to avoid many errors such as:
> kernel/sched/core.c: In function ‘sched_core_find’:
> kernel/sched/core.c:310:43: error: ‘struct rq’ has no member named ‘cpu’
> 
> (6) Call per_cpu_offset() only under CONFIG_HAVE_SETUP_PER_CPU_AREA to
> fix the error:
> arch/loongarch/power/suspend.c: In function ‘loongarch_common_resume’:
> arch/loongarch/power/suspend.c:47:21: error: implicit declaration of function ‘per_cpu_offset’ [-Wimplicit-function-declaration]
> 
> (7) Define and call eiointc_set_irq_affinity() under CONFIG_SMP to set
> the CPU affinity only on SMP machines.
> 
> When running the UnixBench tests with "-c 1" single-streamed pass,
> the improvement in performance is about 9 percent with this patch.
> 
> By the way, it is helpful to debug and analysis the kernel issue
> of multi-core system under !CONFIG_SMP.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> This patch is based on 6.9-rc1. Please let me know if it is better to
> split it into two patches, the first one is for arch/loongarch and the
> second one is for drivers/irqchip.
> 
>   arch/loongarch/Kconfig                 | 2 +-
>   arch/loongarch/include/asm/acpi.h      | 1 +
>   arch/loongarch/include/asm/smp.h       | 5 +++++
>   arch/loongarch/kernel/irq.c            | 2 ++
>   arch/loongarch/kernel/machine_kexec.c  | 2 +-
>   arch/loongarch/power/suspend.c         | 2 ++
>   drivers/irqchip/Kconfig                | 2 +-
>   drivers/irqchip/irq-loongson-eiointc.c | 4 ++++
>   8 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..8d892de0b7a8 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -174,7 +174,6 @@ config LOONGARCH
>   	select PCI_QUIRKS
>   	select PERF_USE_VMALLOC
>   	select RTC_LIB
> -	select SMP
>   	select SPARSE_IRQ
>   	select SYSCTL_ARCH_UNALIGN_ALLOW
>   	select SYSCTL_ARCH_UNALIGN_NO_WARN
> @@ -420,6 +419,7 @@ config EFI_STUB
>   
>   config SCHED_SMT
>   	bool "SMT scheduler support"
> +	depends on SMP
>   	default y
>   	help
>   	  Improves scheduler's performance when there are multiple
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
> index 49e29b29996f..313f66f7913a 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -8,6 +8,7 @@
>   #ifndef _ASM_LOONGARCH_ACPI_H
>   #define _ASM_LOONGARCH_ACPI_H
>   
> +#include <asm/smp.h>
>   #include <asm/suspend.h>
>   
>   #ifdef CONFIG_ACPI
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
> index f81e5f01d619..c14ddfcd4829 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -6,6 +6,7 @@
>   #ifndef __ASM_SMP_H
>   #define __ASM_SMP_H
>   
> +#ifdef CONFIG_SMP
>   #include <linux/atomic.h>
>   #include <linux/bitops.h>
>   #include <linux/linkage.h>
> @@ -101,4 +102,8 @@ static inline void __cpu_die(unsigned int cpu)
>   }
>   #endif
>   
> +#else /* !CONFIG_SMP */
> +#define cpu_logical_map(cpu)	0
It is unsafe here though physical cpuid of BSP is 0 always.
It is better to use __cpu_logical_map[cpu] or read_csr_cpuid()

> +#endif
> +
>   #endif /* __ASM_SMP_H */
> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
> index 883e5066ae44..e791fa275ec5 100644
> --- a/arch/loongarch/kernel/irq.c
> +++ b/arch/loongarch/kernel/irq.c
> @@ -87,6 +87,7 @@ static void __init init_vec_parent_group(void)
>   	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
>   }
>   
> +#ifdef CONFIG_SMP
>   static int __init get_ipi_irq(void)
>   {
>   	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
> @@ -96,6 +97,7 @@ static int __init get_ipi_irq(void)
>   
>   	return -EINVAL;
>   }
> +#endif
>   
>   void __init init_IRQ(void)
>   {
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
> index 2dcb9e003657..8ae641dc53bb 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -225,6 +225,7 @@ void crash_smp_send_stop(void)
>   
>   void machine_shutdown(void)
>   {
> +#ifdef CONFIG_SMP
>   	int cpu;
>   
>   	/* All CPUs go to reboot_code_buffer */
> @@ -232,7 +233,6 @@ void machine_shutdown(void)
>   		if (!cpu_online(cpu))
>   			cpu_device_up(get_cpu_device(cpu));
>   
> -#ifdef CONFIG_SMP
>   	smp_call_function(kexec_shutdown_secondary, NULL, 0);
>   #endif
>   }
> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
> index 166d9e06a64b..e8ca77eb3288 100644
> --- a/arch/loongarch/power/suspend.c
> +++ b/arch/loongarch/power/suspend.c
> @@ -44,7 +44,9 @@ void loongarch_common_resume(void)
>   {
>   	sync_counter();
>   	local_flush_tlb_all();
> +#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
>   	csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
> +#endif
It is another issue, CONFIG_HAVE_SETUP_PER_CPU_AREA should not depend on 
NUMA. PERCPU_BASE_KS should be set even for UP.

Regards
Bibo Mao

>   	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
>   	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
>   	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 72c07a12f5e1..bfa1d77749f3 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -568,7 +568,7 @@ config IRQ_LOONGARCH_CPU
>   	bool
>   	select GENERIC_IRQ_CHIP
>   	select IRQ_DOMAIN
> -	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> +	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
>   	select LOONGSON_HTVEC
>   	select LOONGSON_LIOINTC
>   	select LOONGSON_EIOINTC
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> index b64cbe3052e8..4f5e6d21d77d 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -59,6 +59,7 @@ static int cpu_to_eio_node(int cpu)
>   	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
>   }
>   
> +#ifdef CONFIG_SMP
>   static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode, nodemask_t *node_map)
>   {
>   	int i, node, cpu_node, route_node;
> @@ -126,6 +127,7 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
>   
>   	return IRQ_SET_MASK_OK;
>   }
> +#endif
>   
>   static int eiointc_index(int node)
>   {
> @@ -238,7 +240,9 @@ static struct irq_chip eiointc_irq_chip = {
>   	.irq_ack		= eiointc_ack_irq,
>   	.irq_mask		= eiointc_mask_irq,
>   	.irq_unmask		= eiointc_unmask_irq,
> +#ifdef CONFIG_SMP
>   	.irq_set_affinity	= eiointc_set_irq_affinity,
> +#endif
>   };
>   
>   static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
> 


