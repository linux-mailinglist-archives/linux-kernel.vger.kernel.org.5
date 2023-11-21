Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D107F3A74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjKUXrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjKUXrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:47:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4FC19E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285196aaecaso2339465a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700610461; x=1701215261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfO2TsuP5+bzwc+1UBNKacN7ooenjZKMpjxDQuaWHLs=;
        b=aZrT63MgnuSZW4fEYf/0NWsduVv1PId3L91IjnWURSTnyE/T44v7vPbC5kuMGAqT0D
         1kCJWNo6GONRkpF9EDupy47EueoEjG/tArf234YzpkaI3YOB/cpoKgy1OSneoYxXvORN
         DAJUvg5gBhZpm2t6KlFoo2YA7KlksPlY/64vIh0662J/TVmDd8J/OXRx/O/2vgRwpfPA
         5TF+K1crnC+SZ3ZX2rtUlihyPhe86nNqCTCA9HALAeFuhDiBZxzeHtrTSUPpUyTHxQI6
         rBQKdgSTvLdCS4El1suH7s3Qz8Y40rCjQ9AXtdL+xbzdsUL9/V76DrE1xjY7J260DgS3
         yt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610461; x=1701215261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfO2TsuP5+bzwc+1UBNKacN7ooenjZKMpjxDQuaWHLs=;
        b=t/YpmZH0SZOl0tqfCOARNSUSLQ9cLojpes6taKpL7MNJJ6q8pJtvr0T8G9ZXP6vZet
         +1DRa4Qu1VCpNYKs43LJYixlMVBU4zEfxvJEh3sL+2KHkUM4onPnvSauOm73jIoxqtNd
         YTnJZZdLK+dA47PmRFcDYqEimUNrR2Hn0F4FMwuIjm3ecSZorx3xqScY1bGCflsBZrFT
         WKEly3z5rbgQyn8ZghRVW20VJdEUfw4H5lnLPFrktTAzeVZhb/hAsIier0JnN8CqYRnn
         drrGlbfiLErCGfb6HFzUi8tLhPXMj2ZiotvZ2piDK7zl3Y1I+0x2rZ2ExPMjjWI08iNf
         hCew==
X-Gm-Message-State: AOJu0YzweT0Of1CeeN4Kvxl++AZWPiYB287pYMWTi1mf/aZl8l1D2Czt
        jKKND/aimibSVozs10lO5jP1Mg==
X-Google-Smtp-Source: AGHT+IEuxWeyQyxVZpHs2HhfPBfaktXQRoOaYpXSTZYzhyVnj051EXkgI0JValZG2raCSDzrUvzGGg==
X-Received: by 2002:a17:90b:17c9:b0:27d:661f:59ac with SMTP id me9-20020a17090b17c900b0027d661f59acmr803651pjb.38.1700610461416;
        Tue, 21 Nov 2023 15:47:41 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b002802d9d4e96sm82234pju.54.2023.11.21.15.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:47:41 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/3] riscv: Use the same CPU operations for all CPUs
Date:   Tue, 21 Nov 2023 15:47:26 -0800
Message-ID: <20231121234736.3489608-4-samuel.holland@sifive.com>
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

RISC-V provides no binding (ACPI or DT) to describe per-cpu start/stop
operations, so cpu_set_ops() will always detect the same operations for
every CPU. Replace the cpu_ops array with a single pointer to save space
and reduce boot time.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/cpu_ops.h |  4 ++--
 arch/riscv/kernel/cpu-hotplug.c  | 10 +++++-----
 arch/riscv/kernel/cpu_ops.c      | 12 +++++-------
 arch/riscv/kernel/smp.c          |  2 +-
 arch/riscv/kernel/smpboot.c      | 13 +++++--------
 5 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
index 18af75e6873c..176b570ef982 100644
--- a/arch/riscv/include/asm/cpu_ops.h
+++ b/arch/riscv/include/asm/cpu_ops.h
@@ -29,7 +29,7 @@ struct cpu_operations {
 };
 
 extern const struct cpu_operations cpu_ops_spinwait;
-extern const struct cpu_operations *cpu_ops[NR_CPUS];
-void __init cpu_set_ops(int cpu);
+extern const struct cpu_operations *cpu_ops;
+void __init cpu_set_ops(void);
 
 #endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 934eb64da0d0..28b58fc5ad19 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -18,7 +18,7 @@
 
 bool cpu_has_hotplug(unsigned int cpu)
 {
-	if (cpu_ops[cpu]->cpu_stop)
+	if (cpu_ops->cpu_stop)
 		return true;
 
 	return false;
@@ -31,7 +31,7 @@ int __cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_stop)
+	if (!cpu_ops->cpu_stop)
 		return -EOPNOTSUPP;
 
 	remove_cpu_topology(cpu);
@@ -55,8 +55,8 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 	pr_notice("CPU%u: off\n", cpu);
 
 	/* Verify from the firmware if the cpu is really stopped*/
-	if (cpu_ops[cpu]->cpu_is_stopped)
-		ret = cpu_ops[cpu]->cpu_is_stopped(cpu);
+	if (cpu_ops->cpu_is_stopped)
+		ret = cpu_ops->cpu_is_stopped(cpu);
 	if (ret)
 		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
 }
@@ -70,7 +70,7 @@ void __noreturn arch_cpu_idle_dead(void)
 
 	cpuhp_ap_report_dead();
 
-	cpu_ops[smp_processor_id()]->cpu_stop();
+	cpu_ops->cpu_stop();
 	/* It should never reach here */
 	BUG();
 }
diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index 5540e2880abb..6a8bd8f4db07 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -13,7 +13,7 @@
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
-const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
+const struct cpu_operations *cpu_ops __ro_after_init = &cpu_ops_spinwait;
 
 extern const struct cpu_operations cpu_ops_sbi;
 #ifndef CONFIG_RISCV_BOOT_SPINWAIT
@@ -22,14 +22,12 @@ const struct cpu_operations cpu_ops_spinwait = {
 };
 #endif
 
-void __init cpu_set_ops(int cpuid)
+void __init cpu_set_ops(void)
 {
 #if IS_ENABLED(CONFIG_RISCV_SBI)
 	if (sbi_probe_extension(SBI_EXT_HSM)) {
-		if (!cpuid)
-			pr_info("SBI HSM extension detected\n");
-		cpu_ops[cpuid] = &cpu_ops_sbi;
-	} else
+		pr_info("SBI HSM extension detected\n");
+		cpu_ops = &cpu_ops_sbi;
+	}
 #endif
-		cpu_ops[cpuid] = &cpu_ops_spinwait;
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 40420afbb1a0..45dd4035416e 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -81,7 +81,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_has_hotplug(cpu))
-		cpu_ops[cpu]->cpu_stop();
+		cpu_ops->cpu_stop();
 #endif
 
 	for(;;)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 5551945255cd..519b6bd946e5 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -166,25 +166,22 @@ void __init setup_smp(void)
 {
 	int cpuid;
 
-	cpu_set_ops(0);
+	cpu_set_ops();
 
 	if (acpi_disabled)
 		of_parse_and_init_cpus();
 	else
 		acpi_parse_and_init_cpus();
 
-	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
-		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
-			cpu_set_ops(cpuid);
+	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++)
+		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID)
 			set_cpu_possible(cpuid, true);
-		}
-	}
 }
 
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 {
-	if (cpu_ops[cpu]->cpu_start)
-		return cpu_ops[cpu]->cpu_start(cpu, tidle);
+	if (cpu_ops->cpu_start)
+		return cpu_ops->cpu_start(cpu, tidle);
 
 	return -EOPNOTSUPP;
 }
-- 
2.42.0

