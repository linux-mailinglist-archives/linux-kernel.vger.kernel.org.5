Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0077E303C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjKFW7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKFW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:59:07 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD69510D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:59:03 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-581f78a0206so2717688eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699311543; x=1699916343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjTrbVO5DQDFfCNQXlxC4Kehdfa5zqUUgQgAbIyQh7E=;
        b=j5DHn6vieo1kgHTc9hy5l4CvwvqcHXVRGmzHqvjHCXnxU8tif1KNszvLBzdPThftpJ
         DEfIdodPnFfMszJm8DoABMO0tuVEvfKtBZxOJrgbLKOeWPdMV1UlNYECNivAkGU/JCgR
         pHLvX6zjLId6Apob0esNSFwFsbO34fAHtJYl5VI6JWbe/OKzhegt+TdtGv67eWxD0rGk
         DPPAsoSqIGAaHnXK13YGPPJMnBZk5hXLU1R1fu6v3NEqPlGDZIZvXl8Vq+leZQbpaRoY
         kz3TxpCzwfdBWri/FpWJQ2XTiASqM7YJXE3CFwaviVX7BxerNvrbTE3PL2IhAZ9zfTgi
         283g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311543; x=1699916343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjTrbVO5DQDFfCNQXlxC4Kehdfa5zqUUgQgAbIyQh7E=;
        b=jSntUl3AHUyh0dnEYcy7hWDhqTr3mLWMa19o1/8SkDrfLP86HFTl0DNm599IDUaDwY
         f5ucUOxAaDtSxkDVdBYNIPrPVjOQTL8wzVIZf3nTx1YGEL9RV9n03mTY5FCW2vGikTvG
         MMrep834eGet3xACHpwD7DegaPMncKoCs7scdaXzeogiY9IMFhoNQEv1VZOytkWFHu2H
         0sp36BttV+DJbFlIKteZFmL0k7LO0pYv6GqUCqRUSagcJq5BQoj1jsP1C/5kPJaqxwoa
         O5lIeDVbdfb84IGlYR6SMdSo9wN/rIgBvR9tqiVBoP2giDF/PdyT52OYGv03BAYN51fc
         kQuQ==
X-Gm-Message-State: AOJu0YzyUUCKdBK1peLd1HDxls7cimLCGwNdJizfVuiMGX3F6t+X4CiM
        +0QHcvSipv/3UW93iqTpezBdJ/sWRL6i/dz9VkatHA==
X-Google-Smtp-Source: AGHT+IGJGoME8X8LqT0dQqrq8zLlt5O/Rz53cZhJIyjZHL5dZRVWcXb3vddhFyqP5x1o6XfoLkHSig==
X-Received: by 2002:a4a:c919:0:b0:582:1477:8362 with SMTP id v25-20020a4ac919000000b0058214778362mr28266888ooq.4.1699311543185;
        Mon, 06 Nov 2023 14:59:03 -0800 (PST)
Received: from evan.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w15-20020a4aa98f000000b00586a945615csm1737346oom.6.2023.11.06.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:59:02 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Laight <David.Laight@aculab.com>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3] RISC-V: Probe misaligned access speed in parallel
Date:   Mon,  6 Nov 2023 14:58:55 -0800
Message-Id: <20231106225855.3121724-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
except core 0, then 2) core 0. The allocations are all done outside of
on_each_cpu() to avoid calling alloc_pages() with interrupts disabled.

For hotplugged CPUs that come in after the boot time measurement,
register CPU hotplug callbacks, and do the measurement there. Interrupts
are enabled in those callbacks, so they're fine to do alloc_pages() in.

Reported-by: Jisheng Zhang <jszhang@kernel.org>
Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97debe1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
Signed-off-by: Evan Green <evan@rivosinc.com>

---

Changes in v3:
 - Avoid alloc_pages() with interrupts disabled (Sebastien)
 - Use cpuhp callbacks instead of hooking into smp_callin() (Sebastien).
 - Move cached answer check in check_unaligned_access() out to the
   hotplug callback, both to save the work of a useless allocation, and
   since check_unaligned_access_emulated() resets the answer to unknown.

Changes in v2:
 - Removed new global, used system_state == SYSTEM_RUNNING instead
   (Jisheng)
 - Added tags

 arch/riscv/include/asm/cpufeature.h |  1 -
 arch/riscv/kernel/cpufeature.c      | 96 +++++++++++++++++++++++------
 arch/riscv/kernel/smpboot.c         |  1 -
 3 files changed, 77 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 7f1e46a9d445..69f2cae96f0b 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -30,7 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void check_unaligned_access(int cpu);
 void riscv_user_isa_enable(void);
 
 #ifdef CONFIG_RISCV_MISALIGNED
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 6a01ded615cd..fe59e18dbd5b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
@@ -29,6 +30,7 @@
 
 #define MISALIGNED_ACCESS_JIFFIES_LG2 1
 #define MISALIGNED_BUFFER_SIZE 0x4000
+#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
 #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
 
 unsigned long elf_hwcap __read_mostly;
@@ -557,30 +559,21 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void check_unaligned_access(int cpu)
+static int check_unaligned_access(void *param)
 {
+	int cpu = smp_processor_id();
 	u64 start_cycles, end_cycles;
 	u64 word_cycles;
 	u64 byte_cycles;
 	int ratio;
 	unsigned long start_jiffies, now;
-	struct page *page;
+	struct page *page = param;
 	void *dst;
 	void *src;
 	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
 
 	if (check_unaligned_access_emulated(cpu))
-		return;
-
-	/* We are already set since the last check */
-	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
-		return;
-
-	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
-	if (!page) {
-		pr_warn("Can't alloc pages to measure memcpy performance");
-		return;
-	}
+		return 0;
 
 	/* Make an unaligned destination buffer. */
 	dst = (void *)((unsigned long)page_address(page) | 0x1);
@@ -634,7 +627,7 @@ void check_unaligned_access(int cpu)
 		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
 			cpu);
 
-		goto out;
+		return 0;
 	}
 
 	if (word_cycles < byte_cycles)
@@ -648,19 +641,84 @@ void check_unaligned_access(int cpu)
 		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
 
 	per_cpu(misaligned_access_speed, cpu) = speed;
+	return 0;
+}
 
-out:
-	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
+static void check_unaligned_access_nonboot_cpu(void *param)
+{
+	unsigned int cpu = smp_processor_id();
+	struct page **pages = param;
+
+	if (smp_processor_id() != 0)
+		check_unaligned_access(pages[cpu]);
+}
+
+static int riscv_online_cpu(unsigned int cpu)
+{
+	static struct page *buf;
+
+	/* We are already set since the last check */
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		return 0;
+
+	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+	if (!buf) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return -ENOMEM;
+	}
+
+	check_unaligned_access(buf);
+	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
+	return 0;
 }
 
-static int __init check_unaligned_access_boot_cpu(void)
+/* Measure unaligned access on all CPUs present at boot in parallel. */
+static int check_unaligned_access_all_cpus(void)
 {
-	check_unaligned_access(0);
+	unsigned int cpu;
+	unsigned int cpu_count = num_possible_cpus();
+	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
+				     GFP_KERNEL);
+
+	if (!bufs) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return 0;
+	}
+
+	/*
+	 * Allocate separate buffers for each CPU so there's no fighting over
+	 * cache lines.
+	 */
+	for_each_cpu(cpu, cpu_online_mask) {
+		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+		if (!bufs[cpu]) {
+			pr_warn("Allocation failure, not measuring misaligned performance\n");
+			goto out;
+		}
+	}
+
+	/* Check everybody except 0, who stays behind to tend jiffies. */
+	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
+
+	/* Check core 0. */
+	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
+
+	/* Setup hotplug callback for any new CPUs that come online. */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu, NULL);
+
+out:
 	unaligned_emulation_finish();
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (bufs[cpu])
+			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
+	}
+
+	kfree(bufs);
 	return 0;
 }
 
-arch_initcall(check_unaligned_access_boot_cpu);
+arch_initcall(check_unaligned_access_all_cpus);
 
 void riscv_user_isa_enable(void)
 {
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index d69c628c24f4..d162bf339beb 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -247,7 +247,6 @@ asmlinkage __visible void smp_callin(void)
 	riscv_ipi_enable();
 
 	numa_add_cpu(curr_cpuid);
-	check_unaligned_access(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 
 	if (has_vector()) {
-- 
2.34.1

