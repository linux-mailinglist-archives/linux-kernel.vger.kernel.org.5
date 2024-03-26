Return-Path: <linux-kernel+bounces-118943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0588C1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E431C2AE29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9B74405;
	Tue, 26 Mar 2024 12:11:38 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E96F09C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455098; cv=none; b=d4lqlJDp4VgHWsEAMZo0MzHAuZa3N6hYUqUFyHEpRzVNQPBs8vT6180scT/FIh2J3+xPN8yYSCCDc1HcwzL/mOokZGAyE5VI/QAsXhh/PvBwzr2NRC7DRjrYblbPIJtwy/pNHczNHZxqASrl+IZONANMAq23aVA7Ozizwm/KWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455098; c=relaxed/simple;
	bh=IPnqgB78qUgeBMSAv4tIpBYUNFAYVlCqB+9U3MdX+oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMahALYWKd5Y8xgyJjbPZNjcknRyQwGM/PT6ZGFwtmLNrvnOFsDG7ABOkegB+U0FuAPnwUlVBk20LSPG2XubCJ0XwLvNHZG/4AD4+NNkKBP8CzWhUJlx8yZO+Z36mPX6FGqz8GVmFmPw7snu3DkUlaZ9Mejqm2tY3o9qM8WYmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxdfF2uwJm_FweAA--.6132S3;
	Tue, 26 Mar 2024 20:11:34 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs1zuwJm8eVoAA--.8693S3;
	Tue, 26 Mar 2024 20:11:33 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 1/3] LoongArch: Give chance to build under !CONFIG_SMP
Date: Tue, 26 Mar 2024 20:11:28 +0800
Message-ID: <20240326121130.16622-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240326121130.16622-1-yangtiezhu@loongson.cn>
References: <20240326121130.16622-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTs1zuwJm8eVoAA--.8693S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4UKFWDJw4kuFy3Xry8tFc_yoWxGF15pF
	9Fyr1kJr4rWr1kAFyqy34fWr1UJr1kG3yaqF12kay8AFsrXw1UZr4vgrnFqFyUKws5WFWI
	gFn3G3WaqF15AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

In the current code, SMP is selected in Kconfig for LoongArch, the users
can not unset it, this is reasonable for a multiprocessor machine. But as
the help info of config SMP said, if you have a system with only one CPU,
say N. On a uniprocessor machine, the kernel will run faster if you say N
here.

The Loongson-2K0500 is a single-core CPU for applications like industrial
control, printing terminals, and BMC (Baseboard Management Controller),
there are many development boards, products and solutions on the market,
so it is better and necessary to give a chance to build under !CONFIG_SMP
for a uniprocessor machine.

First of all, do not select SMP for config LOONGARCH in Kconfig to make it
possible to unset CONFIG_SMP. Then, do some changes to fix the warnings and
errors if CONFIG_SMP is not set.

(1) Define cpu_logical_map(cpu) as 0 under !CONFIG_SMP in asm/smp.h and
include asm/smp.h in asm/acpi.h to fix the error:
/arch/loongarch/include/asm/acpi.h: In function ‘get_acpi_id_for_cpu’:
/arch/loongarch/include/asm/acpi.h:44:30: error: implicit declaration of function ‘cpu_logical_map’ [-Wimplicit-function-declaration]

(2) Define get_ipi_irq() only if CONFIG_SMP is set to fix the warning:
arch/loongarch/kernel/irq.c:90:19: warning: ‘get_ipi_irq’ defined but not used [-Wunused-function]

(3) Define machine_shutdown() as empty under !CONFIG_SMP to fix the error:
arch/loongarch/kernel/machine_kexec.c: In function ‘machine_shutdown’:
arch/loongarch/kernel/machine_kexec.c:233:25: error: implicit declaration of function ‘cpu_device_up’; did you mean ‘put_device’? [-Wimplicit-function-declaration]

(4) Make config SCHED_SMT depends on SMP to avoid many errors such as:
kernel/sched/core.c: In function ‘sched_core_find’:
kernel/sched/core.c:310:43: error: ‘struct rq’ has no member named ‘cpu’

(5) Call per_cpu_offset() only under CONFIG_HAVE_SETUP_PER_CPU_AREA to
fix the error:
arch/loongarch/power/suspend.c: In function ‘loongarch_common_resume’:
arch/loongarch/power/suspend.c:47:21: error: implicit declaration of function ‘per_cpu_offset’ [-Wimplicit-function-declaration]

When running the UnixBench tests with "-c 1" single-streamed pass,
the improvement in performance is about 9 percent with this patch.

By the way, it is helpful to debug and analysis the kernel issue
of multi-core system under !CONFIG_SMP.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                | 2 +-
 arch/loongarch/include/asm/acpi.h     | 1 +
 arch/loongarch/include/asm/smp.h      | 5 +++++
 arch/loongarch/kernel/irq.c           | 2 ++
 arch/loongarch/kernel/machine_kexec.c | 2 +-
 arch/loongarch/power/suspend.c        | 2 ++
 6 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..8d892de0b7a8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -174,7 +174,6 @@ config LOONGARCH
 	select PCI_QUIRKS
 	select PERF_USE_VMALLOC
 	select RTC_LIB
-	select SMP
 	select SPARSE_IRQ
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
@@ -420,6 +419,7 @@ config EFI_STUB
 
 config SCHED_SMT
 	bool "SMT scheduler support"
+	depends on SMP
 	default y
 	help
 	  Improves scheduler's performance when there are multiple
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 49e29b29996f..313f66f7913a 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_LOONGARCH_ACPI_H
 #define _ASM_LOONGARCH_ACPI_H
 
+#include <asm/smp.h>
 #include <asm/suspend.h>
 
 #ifdef CONFIG_ACPI
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index f81e5f01d619..c14ddfcd4829 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -6,6 +6,7 @@
 #ifndef __ASM_SMP_H
 #define __ASM_SMP_H
 
+#ifdef CONFIG_SMP
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/linkage.h>
@@ -101,4 +102,8 @@ static inline void __cpu_die(unsigned int cpu)
 }
 #endif
 
+#else /* !CONFIG_SMP */
+#define cpu_logical_map(cpu)	0
+#endif
+
 #endif /* __ASM_SMP_H */
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 883e5066ae44..e791fa275ec5 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -87,6 +87,7 @@ static void __init init_vec_parent_group(void)
 	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
 }
 
+#ifdef CONFIG_SMP
 static int __init get_ipi_irq(void)
 {
 	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
@@ -96,6 +97,7 @@ static int __init get_ipi_irq(void)
 
 	return -EINVAL;
 }
+#endif
 
 void __init init_IRQ(void)
 {
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 2dcb9e003657..8ae641dc53bb 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -225,6 +225,7 @@ void crash_smp_send_stop(void)
 
 void machine_shutdown(void)
 {
+#ifdef CONFIG_SMP
 	int cpu;
 
 	/* All CPUs go to reboot_code_buffer */
@@ -232,7 +233,6 @@ void machine_shutdown(void)
 		if (!cpu_online(cpu))
 			cpu_device_up(get_cpu_device(cpu));
 
-#ifdef CONFIG_SMP
 	smp_call_function(kexec_shutdown_secondary, NULL, 0);
 #endif
 }
diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
index 166d9e06a64b..e8ca77eb3288 100644
--- a/arch/loongarch/power/suspend.c
+++ b/arch/loongarch/power/suspend.c
@@ -44,7 +44,9 @@ void loongarch_common_resume(void)
 {
 	sync_counter();
 	local_flush_tlb_all();
+#ifdef CONFIG_HAVE_SETUP_PER_CPU_AREA
 	csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
+#endif
 	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
 	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
 	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
-- 
2.42.0


