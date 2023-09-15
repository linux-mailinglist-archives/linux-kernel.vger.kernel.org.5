Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130BE7A2696
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjIOSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjIOSvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:51:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF446BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:49:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-274928c74b0so1015660a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694803780; x=1695408580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYSmTOF4KYS04RS6/kkM9Rhx+w8lvbwAPz9Fg6XUkeE=;
        b=DJmguOdiOtprnjBvUxG82Na5H7guQg6deMgaKMaDMLDHuYPUryvAuJYU3HH2ZKuZ05
         XWDEeFG/yDhOKlODgCMDcC6JWGrXrVbWZLHrO/SRfrbsMmxUlBwBmnhX7kbG135QyrfD
         ZLJHzfYdXz5wM0UMQK95zP3A86EwXdgU6miTDEHixq9+CJAcZHzRLhEe/X7N/veOZm30
         tWM2c/Cc++Ww0fDortZJptpZz+9bqgWvVyxMBYcjbxZde3ULyTQJUzbS3IWUO7FdyHds
         nEQr9Mt5rbhOcUs1/h7wpkSXWDnLlpyrOuVM2FaGlaY59TKnp1Vz4IDpk0iWYgTGttda
         b9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803780; x=1695408580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYSmTOF4KYS04RS6/kkM9Rhx+w8lvbwAPz9Fg6XUkeE=;
        b=WEr/Ox2Y2vJMmSZiPfpniY16GveizVUVrzCCqSGgXaM2eeiOc+WyzMvy93D/ftM8RY
         hFQALPh+hCcRtFCzHnIVHbL9Tlu0Ig/WcK4UeQhEm9cFfMHE6GfBbS4jIRXz4VFiwOO/
         hERMUbnY+7j1jaHCALsvZTY0453enNoLc4UZb8hoAn3VniEOkRKsaTOF0Byy7cgYKSSL
         Zyb8ZSeb8zYDvBJR5jxnFLKH7w4z2YakDPoOgrqrYrJBCLlQfOfP0o7eIH+tU6KSInT8
         j/k8y8+QtTW3GvzWJlB8LtoGFy6FJl/JG9d5DXm8zAmuqP+lkFI12QPYWxPYJ6XRSI72
         WXuw==
X-Gm-Message-State: AOJu0YwsIKWMjWAVAEkcrRJP0HkpSLoPcAU+Ree6B/V0Vy5bQorBGH+G
        CwW/TET8VNt9clB1PlMm+1f2ew==
X-Google-Smtp-Source: AGHT+IGL1HqMkQEx+0inVSPfre6GGNigTDq3ef/4CTrXmyvJ3uVn8SIT88LCmaonmmg+jb/AZHsXww==
X-Received: by 2002:a17:90a:c913:b0:268:1d1e:baaf with SMTP id v19-20020a17090ac91300b002681d1ebaafmr2542117pjt.17.1694803780056;
        Fri, 15 Sep 2023 11:49:40 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad24600b00268188ea4b9sm3397849pjw.19.2023.09.15.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:49:39 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: Probe misaligned access speed in parallel
Date:   Fri, 15 Sep 2023 11:49:03 -0700
Message-Id: <20230915184904.1976183-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probing for misaligned access speed takes about 0.06 seconds. On a
system with 64 cores, doing this in smp_callin() means it's done
serially, extending boot time by 3.8 seconds. That's a lot of boot time.

Instead of measuring each CPU serially, let's do the measurements on
all CPUs in parallel. If we disable preemption on all CPUs, the
jiffies stop ticking, so we can do this in stages of 1) everybody
except core 0, then 2) core 0.

The measurement call in smp_callin() stays around, but is now
conditionalized to only run if a new CPU shows up after the round of
in-parallel measurements has run. The goal is to have the measurement
call not run during boot or suspend/resume, but only on a hotplug
addition.

Signed-off-by: Evan Green <evan@rivosinc.com>

---

Jisheng, I didn't add your Tested-by tag since the patch evolved from
the one you tested. Hopefully this one brings you the same result.

---
 arch/riscv/include/asm/cpufeature.h |  3 ++-
 arch/riscv/kernel/cpufeature.c      | 28 +++++++++++++++++++++++-----
 arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index d0345bd659c9..19e7817eba10 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -30,6 +30,7 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void check_unaligned_access(int cpu);
+extern bool misaligned_speed_measured;
+int check_unaligned_access(void *unused);
 
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..8eb36e1dfb95 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -42,6 +42,9 @@ struct riscv_isainfo hart_isa[NR_CPUS];
 /* Performance information */
 DEFINE_PER_CPU(long, misaligned_access_speed);
 
+/* Boot-time in-parallel unaligned access measurement has occurred. */
+bool misaligned_speed_measured;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -556,8 +559,9 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void check_unaligned_access(int cpu)
+int check_unaligned_access(void *unused)
 {
+	int cpu = smp_processor_id();
 	u64 start_cycles, end_cycles;
 	u64 word_cycles;
 	u64 byte_cycles;
@@ -571,7 +575,7 @@ void check_unaligned_access(int cpu)
 	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
 	if (!page) {
 		pr_warn("Can't alloc pages to measure memcpy performance");
-		return;
+		return 0;
 	}
 
 	/* Make an unaligned destination buffer. */
@@ -643,15 +647,29 @@ void check_unaligned_access(int cpu)
 
 out:
 	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
+	return 0;
+}
+
+static void check_unaligned_access_nonboot_cpu(void *param)
+{
+	if (smp_processor_id() != 0)
+		check_unaligned_access(param);
 }
 
-static int check_unaligned_access_boot_cpu(void)
+static int check_unaligned_access_all_cpus(void)
 {
-	check_unaligned_access(0);
+	/* Check everybody except 0, who stays behind to tend jiffies. */
+	on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
+
+	/* Check core 0. */
+	smp_call_on_cpu(0, check_unaligned_access, NULL, true);
+
+	/* Boot-time measurements are complete. */
+	misaligned_speed_measured = true;
 	return 0;
 }
 
-arch_initcall(check_unaligned_access_boot_cpu);
+arch_initcall(check_unaligned_access_all_cpus);
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1b8da4e40a4d..39322ae20a75 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -27,6 +27,7 @@
 #include <linux/sched/mm.h>
 #include <asm/cpu_ops.h>
 #include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
@@ -246,7 +247,15 @@ asmlinkage __visible void smp_callin(void)
 
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
-	check_unaligned_access(curr_cpuid);
+
+	/*
+	 * Boot-time misaligned access speed measurements are done in parallel
+	 * in an initcall. Only measure here for hotplug.
+	 */
+	if (misaligned_speed_measured &&
+	    (per_cpu(misaligned_access_speed, curr_cpuid) == RISCV_HWPROBE_MISALIGNED_UNKNOWN)) {
+		check_unaligned_access(NULL);
+	}
 
 	if (has_vector()) {
 		if (riscv_v_setup_vsize())
-- 
2.34.1

