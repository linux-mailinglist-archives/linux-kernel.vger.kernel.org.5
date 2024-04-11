Return-Path: <linux-kernel+bounces-139608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE68A054D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFB528937F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E509C69DF7;
	Thu, 11 Apr 2024 01:05:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B4E60EDC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797523; cv=none; b=Elq3HudpSzfBWTF+bsBfb7zOjiWAJrJ33S/Ncqm4eOaxmsew9k4Lhl1kDfsAJFXtjvcuoKGjr1xEl9+S+a8+3cqIYusCw+d9dTpx0SccFalC0ogaatsn9X22wNDUJ+Cp+bAStDoQmGQM8+aDxioXy5/bG40Mw1qUficwFZJ4oqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797523; c=relaxed/simple;
	bh=bUZXht1r8Me2Bybf8H3aka3zwa4D+6HaPcSWY3c8kLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFHYd5R8KU9XPVtfdlKF+bX/lCc9QqFNAS5E6rZzFpUJZAcn7i0WAAmBv+ftub8xrCbayirMLdGiEk5iYdMf6Wv5bS/nbzfDAXzV7KqUW7BbdL/fCb7TK6ub7+BLyF2n7mYmDNFfjx4R1Bflz4ZZDGJix0YQZSPOe1kQSgODSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxuvBPNxdm_pAlAA--.20590S3;
	Thu, 11 Apr 2024 09:05:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhhFHNxdmnrx3AA--.22869S6;
	Thu, 11 Apr 2024 09:05:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 4/4] LoongArch: Give chance to build under !CONFIG_SMP
Date: Thu, 11 Apr 2024 09:05:10 +0800
Message-ID: <20240411010510.22135-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240411010510.22135-1-yangtiezhu@loongson.cn>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxhhFHNxdmnrx3AA--.22869S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr4UKFWDJw4kZF13Xw4DZFc_yoW7uF4UpF
	WDAr4DJr4rWr1vyryqy3yfWr98Jr1kGay2qF17Cay8JFsrX34UXr1kKwnFqFyUKwsYgFWI
	qFn3W3WaqF45AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

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

(1) Define get_ipi_irq() only if CONFIG_SMP is set to fix the warning:
arch/loongarch/kernel/irq.c:90:19: warning: 'get_ipi_irq' defined but not used [-Wunused-function]

(2) Add "#ifdef CONFIG_SMP" in asm/smp.h to fix the warning:
/arch/loongarch/include/asm/smp.h:49:9: warning: "raw_smp_processor_id" redefined
   49 | #define raw_smp_processor_id raw_smp_processor_id
      |         ^~~~~~~~~~~~~~~~~~~~
/include/linux/smp.h:198:9: note: this is the location of the previous definition
  198 | #define raw_smp_processor_id()                  0

(3) Define machine_shutdown() as empty under !CONFIG_SMP to fix the error:
arch/loongarch/kernel/machine_kexec.c: In function 'machine_shutdown':
arch/loongarch/kernel/machine_kexec.c:233:25: error: implicit declaration of function 'cpu_device_up'; did you mean 'put_device'? [-Wimplicit-function-declaration]

(4) Make config SCHED_SMT depends on SMP to fix many errors such as:
kernel/sched/core.c: In function 'sched_core_find':
kernel/sched/core.c:310:43: error: 'struct rq' has no member named 'cpu'

(5) Define cpu_logical_map(cpu) as read_csr_cpuid() under !CONFIG_SMP
in asm/smp.h and then include asm/smp.h in asm/acpi.h (because acpi.h
is included in linux/irq.h indirectly) to fix many build errors under
drivers/irqchip such as:
drivers/irqchip/irq-loongson-eiointc.c: In function 'cpu_to_eio_node':
drivers/irqchip/irq-loongson-eiointc.c:59:16: error: implicit declaration of function 'cpu_logical_map' [-Wimplicit-function-declaration]

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
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 64052ae2c2af..8946945daf34 100644
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
index a4ad3f75bd60..5174063ad08e 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_LOONGARCH_ACPI_H
 #define _ASM_LOONGARCH_ACPI_H
 
+#include <asm/smp.h>
 #include <asm/suspend.h>
 
 #ifdef CONFIG_ACPI
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index f81e5f01d619..1ec11b57e60c 100644
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
+#define cpu_logical_map(cpu)	read_csr_cpuid()
+#endif /* CONFIG_SMP */
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
-- 
2.42.0


