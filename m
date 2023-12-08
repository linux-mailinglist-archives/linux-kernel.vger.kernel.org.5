Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED4809D24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjLHHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573242AbjLHHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:31:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD43172E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702020664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTgJq0WDYWry7hy4y8Pbn9hjTuGpWfcbIu67sKiiHlw=;
        b=HQLQXuZvuUhkF8mJtP+F/cbhEmtYjr66RBEiZgmfLdWIuF4QCDgfMdIXGzX7fAEK1urVjo
        N4pjj20MG5gC0CUsnQ48yYuiaXZKJkGNvQ6WUAAgRLLFR0ggP453h9DKVPB3XjbPIeBptM
        PjEkonomPwIC1RvQAQL+XgApXZ76l5g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-1A-qT-_-OQ2MXlptes4paQ-1; Fri,
 08 Dec 2023 02:31:00 -0500
X-MC-Unique: 1A-qT-_-OQ2MXlptes4paQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE30A38062AB;
        Fri,  8 Dec 2023 07:30:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BE108CD0;
        Fri,  8 Dec 2023 07:30:54 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-next@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        sfr@canb.auug.org.au, ignat@cloudflare.com,
        Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 3/5] mips, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
Date:   Fri,  8 Dec 2023 15:30:34 +0800
Message-ID: <20231208073036.7884-4-bhe@redhat.com>
In-Reply-To: <20231208073036.7884-1-bhe@redhat.com>
References: <20231208073036.7884-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The select of KEXEC for CRASH_DUMP in kernel/Kconfig.kexec will be
dropped, then compiling errors will be triggered if below config
items are set:

===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
===

--------------------------------------------------------------------
mipsel-linux-ld: kernel/kexec_core.o: in function `kimage_free':
kernel/kexec_core.c:(.text+0x2200): undefined reference to `machine_kexec_cleanup'
mipsel-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
kernel/kexec_core.c:(.text+0x2480): undefined reference to `machine_crash_shutdown'
mipsel-linux-ld: kernel/kexec_core.c:(.text+0x2488): undefined reference to `machine_kexec'
mipsel-linux-ld: kernel/kexec_core.o: in function `kernel_kexec':
kernel/kexec_core.c:(.text+0x29b8): undefined reference to `machine_shutdown'
mipsel-linux-ld: kernel/kexec_core.c:(.text+0x29c0): undefined reference to `machine_kexec'
--------------------------------------------------------------------

Here, change the dependency of building kexec_core related object files,
and the ifdeffery in mips from CONFIG_KEXEC to CONFIG_KEXEC_CORE.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311302042.sn8cDPIX-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/mips/cavium-octeon/smp.c   |  4 ++--
 arch/mips/include/asm/kexec.h   |  2 +-
 arch/mips/include/asm/smp-ops.h |  2 +-
 arch/mips/include/asm/smp.h     |  2 +-
 arch/mips/kernel/Makefile       |  2 +-
 arch/mips/kernel/smp-bmips.c    |  4 ++--
 arch/mips/kernel/smp-cps.c      | 10 +++++-----
 arch/mips/loongson64/reset.c    |  4 ++--
 arch/mips/loongson64/smp.c      |  2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 33c09688210f..08ea2cde1eb5 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -422,7 +422,7 @@ static const struct plat_smp_ops octeon_smp_ops = {
 	.cpu_disable		= octeon_cpu_disable,
 	.cpu_die		= octeon_cpu_die,
 #endif
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
 #endif
 };
@@ -502,7 +502,7 @@ static const struct plat_smp_ops octeon_78xx_smp_ops = {
 	.cpu_disable		= octeon_cpu_disable,
 	.cpu_die		= octeon_cpu_die,
 #endif
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
 #endif
 };
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index d6d5fa5cc31d..69e579e41e66 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -31,7 +31,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 		prepare_frametrace(newregs);
 }
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 struct kimage;
 extern unsigned long kexec_args[4];
 extern int (*_machine_kexec_prepare)(struct kimage *);
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 5719ff49eff1..0c59e168f800 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -35,7 +35,7 @@ struct plat_smp_ops {
 	void (*cpu_die)(unsigned int cpu);
 	void (*cleanup_dead_cpu)(unsigned cpu);
 #endif
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	void (*kexec_nonboot_cpu)(void);
 #endif
 };
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index a40d8c0e4b87..901bc61fa7ae 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -93,7 +93,7 @@ static inline void __cpu_die(unsigned int cpu)
 extern void __noreturn play_dead(void);
 #endif
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 static inline void kexec_nonboot_cpu(void)
 {
 	extern const struct plat_smp_ops *mp_ops;	/* private */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 853a43ee4b44..ecf3278a32f7 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -90,7 +90,7 @@ obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_EARLY_PRINTK_8250)	+= early_printk_8250.o
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index c074ecce3fbf..b3dbf9ecb0d6 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -434,7 +434,7 @@ const struct plat_smp_ops bmips43xx_smp_ops = {
 	.cpu_disable		= bmips_cpu_disable,
 	.cpu_die		= bmips_cpu_die,
 #endif
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
 #endif
 };
@@ -451,7 +451,7 @@ const struct plat_smp_ops bmips5000_smp_ops = {
 	.cpu_disable		= bmips_cpu_disable,
 	.cpu_die		= bmips_cpu_die,
 #endif
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
 #endif
 };
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index dd55d59b88db..f6c37d407f36 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -392,7 +392,7 @@ static void cps_smp_finish(void)
 	local_irq_enable();
 }
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC_CORE)
 
 enum cpu_death {
 	CPU_DEATH_HALT,
@@ -429,7 +429,7 @@ static void cps_shutdown_this_cpu(enum cpu_death death)
 	}
 }
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 
 static void cps_kexec_nonboot_cpu(void)
 {
@@ -439,9 +439,9 @@ static void cps_kexec_nonboot_cpu(void)
 		cps_shutdown_this_cpu(CPU_DEATH_POWER);
 }
 
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_KEXEC_CORE */
 
-#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_HOTPLUG_CPU
 
@@ -610,7 +610,7 @@ static const struct plat_smp_ops cps_smp_ops = {
 	.cpu_die		= cps_cpu_die,
 	.cleanup_dead_cpu	= cps_cleanup_dead_cpu,
 #endif
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.kexec_nonboot_cpu	= cps_kexec_nonboot_cpu,
 #endif
 };
diff --git a/arch/mips/loongson64/reset.c b/arch/mips/loongson64/reset.c
index e420800043b0..e01c8d4a805a 100644
--- a/arch/mips/loongson64/reset.c
+++ b/arch/mips/loongson64/reset.c
@@ -53,7 +53,7 @@ static void loongson_halt(void)
 	}
 }
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 
 /* 0X80000000~0X80200000 is safe */
 #define MAX_ARGS	64
@@ -158,7 +158,7 @@ static int __init mips_reboot_setup(void)
 	_machine_halt = loongson_halt;
 	pm_power_off = loongson_poweroff;
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	kexec_argv = kmalloc(KEXEC_ARGV_SIZE, GFP_KERNEL);
 	if (WARN_ON(!kexec_argv))
 		return -ENOMEM;
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index e015a26a40f7..498bdc1bb0ed 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -864,7 +864,7 @@ const struct plat_smp_ops loongson3_smp_ops = {
 	.cpu_disable = loongson3_cpu_disable,
 	.cpu_die = loongson3_cpu_die,
 #endif
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.kexec_nonboot_cpu = kexec_nonboot_cpu_jump,
 #endif
 };
-- 
2.41.0

