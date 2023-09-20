Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35817A8CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjITTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjITTiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:38:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBE2A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:38:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-274b3d48e15so80864a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695238696; x=1695843496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39pvP98AoIFjGXMcEMP3U5n+E4U9Aq4ivPpQhUdCDI4=;
        b=eqg6wbArS7HCw/w0d9a5cIipa9gTR8GhtxYVjF5W/gelvyELzRrnq/j5QBYS4amaGE
         NRjWA/mzBjIpY3h/0OoQ+UA7TxXtQ/WV6qpB1b72uMHWZP/zGCcgrYJRS7MdTtaJ7Ux7
         gLZ3kD1uq5XRabJytg5Skw2IDP7mFMf4C3RbGMaCdGRQqySWVJqVvqEf8Nvo+oB7jLZA
         Wwc49PhnUihwizqkx6F44HWQxm+qevKU2wU2sb5itjuAterSxVRRg8r7zhfdbASu8GnL
         zDtwCFTQmHBsaZ6/ZDRRic6nVgynlujWtMeK/rDp0o+Z9FAZ8luyWnIlyEeHqZd7VaAX
         +sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238696; x=1695843496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39pvP98AoIFjGXMcEMP3U5n+E4U9Aq4ivPpQhUdCDI4=;
        b=vmNjy+wA8FM3OiUaGYfYbbLfOIu8TYyV39/iHoIXaD/cS/YmrJ2OP5Ds53h48vUtR6
         He30ZnI9o7nowyGalO5RewoeOafJuzOdkmPwzWk0OXTYlOcby+8YcHje9PQcvTRne9Qi
         OctwTEQyfz/YZZV27Ipn71uivznOG1WSPaKTHavoksGNvUTNyKkiNMHEP/i77Qb8/HnO
         kQPyE7P3sXV9id9S+gFcesmp9wNl2LxK4Iuh2wQ+/a+tdgYFfxS8PUgC4+E/Gn6B4mFz
         9ltW+JOAVW2OreFtZjxOFtbTXln0Jny4XblpjKYxnRhlsyfWRgAuRzDm/d0pq58OFUOP
         XPFQ==
X-Gm-Message-State: AOJu0YxXrizduJX+dq739qvDWOxhSwFsrq2XDgo1nmnvT9nqmPmC2//V
        DHSHmJdR9uz4JwR3KovqaemlWg==
X-Google-Smtp-Source: AGHT+IFiT/s35Hen/GbTyCXs8Du2zExU1YXL3rbivM6LSR8Rhrc2NrfvfDY5uDT1M3CHbv4LWllWmA==
X-Received: by 2002:a17:90a:bd0a:b0:274:694c:167d with SMTP id y10-20020a17090abd0a00b00274694c167dmr3593378pjr.5.1695238696031;
        Wed, 20 Sep 2023 12:38:16 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0026b50d9aee6sm1819606pjj.25.2023.09.20.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:38:15 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Evan Green <evan@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
Date:   Wed, 20 Sep 2023 12:38:01 -0700
Message-Id: <20230920193801.3035093-1-evan@rivosinc.com>
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

Reported-by: Jisheng Zhang <jszhang@kernel.org>
Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97debe1cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
Signed-off-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Andrew Jones <ajones@ventanamicro.com>

---

Changes in v2:
 - Removed new global, used system_state == SYSTEM_RUNNING instead
   (Jisheng)
 - Added tags

 arch/riscv/include/asm/cpufeature.h |  2 +-
 arch/riscv/kernel/cpufeature.c      | 22 +++++++++++++++++-----
 arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index d0345bd659c9..b139796392d0 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -30,6 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void check_unaligned_access(int cpu);
+int check_unaligned_access(void *unused);
 
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..40bb854fcb96 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -556,8 +556,9 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void check_unaligned_access(int cpu)
+int check_unaligned_access(void *unused)
 {
+	int cpu = smp_processor_id();
 	u64 start_cycles, end_cycles;
 	u64 word_cycles;
 	u64 byte_cycles;
@@ -571,7 +572,7 @@ void check_unaligned_access(int cpu)
 	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
 	if (!page) {
 		pr_warn("Can't alloc pages to measure memcpy performance");
-		return;
+		return 0;
 	}
 
 	/* Make an unaligned destination buffer. */
@@ -643,15 +644,26 @@ void check_unaligned_access(int cpu)
 
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
 	return 0;
 }
 
-arch_initcall(check_unaligned_access_boot_cpu);
+arch_initcall(check_unaligned_access_all_cpus);
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1b8da4e40a4d..a014955b8699 100644
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
+	if ((system_state == SYSTEM_RUNNING) &&
+	    (per_cpu(misaligned_access_speed, curr_cpuid) == RISCV_HWPROBE_MISALIGNED_UNKNOWN)) {
+		check_unaligned_access(NULL);
+	}
 
 	if (has_vector()) {
 		if (riscv_v_setup_vsize())
-- 
2.34.1

