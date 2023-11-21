Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB687F3A73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjKUXrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjKUXro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:47:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC9194
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso5229679b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700610460; x=1701215260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2mLSanzAu7xkVkTlVbQ+OCyp7a1LICmHfqJMNCQTMM=;
        b=QenDxS+3RWNRcbzX9ItHNPIYJXMPQ/Uh+sbOQ537H8PoqiWJQDof8t+vLjni4jP6p+
         ZgxwmSKmvcVjflVB/fIo9nm7DaK1peRnhGgze3WSKaiezamwmYiTg364azkmBl4IhOj7
         M4VGwWVS1OWDm0ftiRXvMRRgFH3ortIn0ziFCnTF2Eq9+VW2qy+JAcH7X770gCX/8ORL
         WjlxIoWicLGBVblyHB8dXTPf+yF85Y8RUurkzlGvPNROA4E/+r0GnsC2XtG3lJroorWP
         VyLkeDTv54kto5b9R55+odzWqFWKSBxqDWOq7mYEs6SQKpgnN3i7JJZfgjd7ddnoN+fq
         iYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610460; x=1701215260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2mLSanzAu7xkVkTlVbQ+OCyp7a1LICmHfqJMNCQTMM=;
        b=KWIVs/TRC6ygjQt4tBY3tJ6WIiu9+ovtwLST6cFb6kzvmyweq4RvyxsBVRufRBJzL1
         Y+Ip1kQBly5AO6LUmjc4jsxWVEGEKlkdZSnpH6yw1ay4kTqC3zswaniQtHdPkiZPdZDN
         L8aSL/oNuV/fL/RZVNj9lNSU9QnnTV42qZdMH74omoKBNV5ykEODsAeO3bztVVT/amMD
         mG0ymPxuH57LlLoyMGxRkfm/EVFhKBBrG34esl4/HXlLvz2q/iMjvUWtH6bIcn+oHiLy
         pOaTMss+kNS565qQGXdngKMvGNyuuyC/PfEZFroNSkXTysw5NmdsJdgvFbXLwFreN+sv
         C5gQ==
X-Gm-Message-State: AOJu0YzD/Oe0qb4A9hQA8p/LpCecFGPdd68vdcaCshnwO4G7mDofznHi
        27c4DEp8wK72Bi/RMK2HwWzY8w==
X-Google-Smtp-Source: AGHT+IHoez2A3aRDrdQwxK18whZwJQR498ZFuayF3Kusj3dBV4VtpQAp7G00A3jzOcyqkuPlxbXNnA==
X-Received: by 2002:a05:6a21:a585:b0:187:cc5f:dbf4 with SMTP id gd5-20020a056a21a58500b00187cc5fdbf4mr692350pzc.42.1700610460323;
        Tue, 21 Nov 2023 15:47:40 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b002802d9d4e96sm82234pju.54.2023.11.21.15.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:47:40 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/3] riscv: Remove unused members from struct cpu_operations
Date:   Tue, 21 Nov 2023 15:47:25 -0800
Message-ID: <20231121234736.3489608-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121234736.3489608-1-samuel.holland@sifive.com>
References: <20231121234736.3489608-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

name is not used anywhere at all. cpu_prepare and cpu_disable do nothing
and always return 0 if implemented.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/cpu_ops.h     | 10 ----------
 arch/riscv/kernel/cpu-hotplug.c      |  9 +--------
 arch/riscv/kernel/cpu_ops.c          |  2 --
 arch/riscv/kernel/cpu_ops_sbi.c      | 19 -------------------
 arch/riscv/kernel/cpu_ops_spinwait.c | 11 -----------
 arch/riscv/kernel/head.S             |  1 -
 arch/riscv/kernel/setup.c            |  1 -
 arch/riscv/kernel/smpboot.c          |  6 ------
 8 files changed, 1 insertion(+), 58 deletions(-)

diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
index aa128466c4d4..18af75e6873c 100644
--- a/arch/riscv/include/asm/cpu_ops.h
+++ b/arch/riscv/include/asm/cpu_ops.h
@@ -13,26 +13,16 @@
 /**
  * struct cpu_operations - Callback operations for hotplugging CPUs.
  *
- * @name:		Name of the boot protocol.
- * @cpu_prepare:	Early one-time preparation step for a cpu. If there
- *			is a mechanism for doing so, tests whether it is
- *			possible to boot the given HART.
  * @cpu_start:		Boots a cpu into the kernel.
- * @cpu_disable:	Prepares a cpu to die. May fail for some
- *			mechanism-specific reason, which will cause the hot
- *			unplug to be aborted. Called from the cpu to be killed.
  * @cpu_stop:		Makes a cpu leave the kernel. Must not fail. Called from
  *			the cpu being stopped.
  * @cpu_is_stopped:	Ensures a cpu has left the kernel. Called from another
  *			cpu.
  */
 struct cpu_operations {
-	const char	*name;
-	int		(*cpu_prepare)(unsigned int cpu);
 	int		(*cpu_start)(unsigned int cpu,
 				     struct task_struct *tidle);
 #ifdef CONFIG_HOTPLUG_CPU
-	int		(*cpu_disable)(unsigned int cpu);
 	void		(*cpu_stop)(void);
 	int		(*cpu_is_stopped)(unsigned int cpu);
 #endif
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 457a18efcb11..934eb64da0d0 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -29,25 +29,18 @@ bool cpu_has_hotplug(unsigned int cpu)
  */
 int __cpu_disable(void)
 {
-	int ret = 0;
 	unsigned int cpu = smp_processor_id();
 
 	if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_stop)
 		return -EOPNOTSUPP;
 
-	if (cpu_ops[cpu]->cpu_disable)
-		ret = cpu_ops[cpu]->cpu_disable(cpu);
-
-	if (ret)
-		return ret;
-
 	remove_cpu_topology(cpu);
 	numa_remove_cpu(cpu);
 	set_cpu_online(cpu, false);
 	riscv_ipi_disable();
 	irq_migrate_all_off_this_cpu();
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index eb479a88a954..5540e2880abb 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -18,8 +18,6 @@ const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 extern const struct cpu_operations cpu_ops_sbi;
 #ifndef CONFIG_RISCV_BOOT_SPINWAIT
 const struct cpu_operations cpu_ops_spinwait = {
-	.name		= "",
-	.cpu_prepare	= NULL,
 	.cpu_start	= NULL,
 };
 #endif
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index efa0f0816634..1cc7df740edd 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -79,23 +79,7 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 	return sbi_hsm_hart_start(hartid, boot_addr, hsm_data);
 }
 
-static int sbi_cpu_prepare(unsigned int cpuid)
-{
-	if (!cpu_ops_sbi.cpu_start) {
-		pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
-		return -ENODEV;
-	}
-	return 0;
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
-static int sbi_cpu_disable(unsigned int cpuid)
-{
-	if (!cpu_ops_sbi.cpu_stop)
-		return -EOPNOTSUPP;
-	return 0;
-}
-
 static void sbi_cpu_stop(void)
 {
 	int ret;
@@ -118,11 +102,8 @@ static int sbi_cpu_is_stopped(unsigned int cpuid)
 #endif
 
 const struct cpu_operations cpu_ops_sbi = {
-	.name		= "sbi",
-	.cpu_prepare	= sbi_cpu_prepare,
 	.cpu_start	= sbi_cpu_start,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable	= sbi_cpu_disable,
 	.cpu_stop	= sbi_cpu_stop,
 	.cpu_is_stopped	= sbi_cpu_is_stopped,
 #endif
diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
index d98d19226b5f..613872b0a21a 100644
--- a/arch/riscv/kernel/cpu_ops_spinwait.c
+++ b/arch/riscv/kernel/cpu_ops_spinwait.c
@@ -39,15 +39,6 @@ static void cpu_update_secondary_bootdata(unsigned int cpuid,
 	WRITE_ONCE(__cpu_spinwait_task_pointer[hartid], tidle);
 }
 
-static int spinwait_cpu_prepare(unsigned int cpuid)
-{
-	if (!cpu_ops_spinwait.cpu_start) {
-		pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
-		return -ENODEV;
-	}
-	return 0;
-}
-
 static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 {
 	/*
@@ -64,7 +55,5 @@ static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 }
 
 const struct cpu_operations cpu_ops_spinwait = {
-	.name		= "spinwait",
-	.cpu_prepare	= spinwait_cpu_prepare,
 	.cpu_start	= spinwait_cpu_start,
 };
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index b77397432403..0349e5cdfe1d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -11,7 +11,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/csr.h>
-#include <asm/cpu_ops_sbi.h>
 #include <asm/hwcap.h>
 #include <asm/image.h>
 #include <asm/scs.h>
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 535a837de55d..2bf882804624 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -26,7 +26,6 @@
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
-#include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
 #include <asm/setup.h>
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1c68e61fb852..5551945255cd 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -49,7 +49,6 @@ void __init smp_prepare_boot_cpu(void)
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
-	int ret;
 	unsigned int curr_cpuid;
 
 	init_cpu_topology();
@@ -66,11 +65,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(cpuid) {
 		if (cpuid == curr_cpuid)
 			continue;
-		if (cpu_ops[cpuid]->cpu_prepare) {
-			ret = cpu_ops[cpuid]->cpu_prepare(cpuid);
-			if (ret)
-				continue;
-		}
 		set_cpu_present(cpuid, true);
 		numa_store_cpu_info(cpuid);
 	}
-- 
2.42.0

