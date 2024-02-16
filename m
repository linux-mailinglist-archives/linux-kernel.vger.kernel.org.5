Return-Path: <linux-kernel+bounces-69316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DD858736
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEDD1C255CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CF153BFB;
	Fri, 16 Feb 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oGtoYdsi"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CB150983
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115613; cv=none; b=ZhbqbDsQ+FITaQC9g1rxNT9I0OtsBfXwnPoerRaUKGaeu0I6Hezu0361A8bZaNmTfPIAXKoAkGrDZ+U3n2JpN1+uYS2v8N9HsPPcjfqPJTmN1FHJKQopiQrS8nhYiIRDQ3oCCKz/KyWRwQ4oxxaa47HQXpEDNHmNZeeDNQ3Cmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115613; c=relaxed/simple;
	bh=BRU0ZPtfDJ93IUhr5hCXZSq5REacOWCi6I1cIVzywMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToC7k+TUgDytLDPH1AUtViIUXBFf7eqYE1F0Vc2KlULl/Kk8hiihJdc+aHA55veBgGsWb3AayoiR6PkNRX7vaXmuKkUOUrHGSFPkMqpM+KPDBs/zX1eQOr33SOFcMMLR0QTb9AU7ckDg0Y1caGaSWT54oUQjUqxtu2pacLlYqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oGtoYdsi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e1358dd3a1so1378610b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708115609; x=1708720409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06EzELwl5e32Yqe/vw0XPvWyfFS7JzU6b3Yejv18tuU=;
        b=oGtoYdsiLq6f3DssfuR47soEB33iBlz6u3/MleZAqouGcxjgyaemf+vbUUdfJRiOVi
         VARFxq3iQFQZk7lDQDHIWRwv98lCJIpYE6JRL3FnrHKAZZ1rvHHXCfKPcX3m5IshA7mh
         krDbZ5OcLZKFKmBhH6PmRNAYymEE2reUv67LrZkOGUefW1fXk7KpLtaFoAU5n6E6YUYE
         Ul0uRIQ9X4nhbwym20unCIjoaYpirf/NXFQHRMJclkwV0HuVigeZ5RBS8wSjQv5DRpfB
         uY3B6lviwpp+eF1wux036XwDYpeNKzVq/24GLgSQlSCFMutkj8K6gedgO/kQTS276pWM
         Xylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115609; x=1708720409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06EzELwl5e32Yqe/vw0XPvWyfFS7JzU6b3Yejv18tuU=;
        b=Ul1EMWSD8SqYA6eQt3pnAPIJAKKoc57AQ1HtezW7Wwj/UOzNr9xeoFvk4Xz9inE3UH
         wozlQRW4Ouldk60nJRQ82HDZJqr/204pmwDXPGFKm/VhQxXuuiubjMNfqRRn+NkQOcwC
         0SUhuux3Y7RRX+SEaY1xwpEAd/tuiPxW3XvuGgbaPYLn3MxswGonJ3dNy7h+UyOYBF0t
         u0r+lAxCrZ6u7oK7JkkxRNJZGqgPg4kYaVsjpRpY01niEafiQD7JbB8kyb85sO6DBivL
         cF/WbWD19mY9nEMo/GcbDqxSkm98cFNTwH0Rd9dwj7KkTUwFt6NCdmeW+/zmD63hcome
         OHfg==
X-Forwarded-Encrypted: i=1; AJvYcCXxCNSFa7c7ULMnlp2K2knppBPV85ndWQVSM1lcuN7Dzo6ovzbmBuVsERWHbI1x1ZPaXPSyQUf4ufRupGAxairBZAERpwv/9+XbIdiN
X-Gm-Message-State: AOJu0YyR0I3/YawyMlNCEK0IuMQAOnZB56PfRqgkk58KlBGR7LXK10U8
	ydY3ZAlCnDAK1Uvviypg3o9vQ0upzBtM/Eie1HX1JaC1Z5na+vtMfGkXn+xivsc=
X-Google-Smtp-Source: AGHT+IG7nyXrXuCNwNNtqNC+0V55MpkEaOMWwChKnPv4vaq2DaNXOFxGdn8jnlUcrf3C4dk2wZcDBg==
X-Received: by 2002:a05:6a00:3d44:b0:6e0:a026:913 with SMTP id lp4-20020a056a003d4400b006e0a0260913mr7036121pfb.12.1708115609016;
        Fri, 16 Feb 2024 12:33:29 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s32-20020a056a0017a000b006e091489776sm369918pfg.92.2024.02.16.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:28 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 16 Feb 2024 12:33:19 -0800
Subject: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
In-Reply-To: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708115604; l=29457;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BRU0ZPtfDJ93IUhr5hCXZSq5REacOWCi6I1cIVzywMM=;
 b=7y+v+vteurm8NrRxXG3TtKIhVOBzUluP0fqwWM9seuge2aEnmxA7EVLo61Vj+7zzkzu7KFOGM
 Jy6jHZKYsRFDyOAZOVell+HL8YFMGU2gbfCfJdFEJJyfd+RjQe3CyRr
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce Kconfig options to set the kernel unaligned access support.
These options provide a non-portable alternative to the runtime
unaligned access probe.

To support this, the unaligned access probing code is moved into it's
own file and gated behind a new RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT
option.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig                          |  58 +++++-
 arch/riscv/include/asm/cpufeature.h         |  30 +++-
 arch/riscv/kernel/Makefile                  |   6 +-
 arch/riscv/kernel/cpufeature.c              | 255 --------------------------
 arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++++++++
 arch/riscv/kernel/probe_emulated_access.c   |  64 +++++++
 arch/riscv/kernel/sys_hwprobe.c             |  25 +++
 arch/riscv/kernel/traps_misaligned.c        |  54 +-----
 8 files changed, 442 insertions(+), 315 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..3cf700adc43b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -690,25 +690,71 @@ config THREAD_SIZE_ORDER
 config RISCV_MISALIGNED
 	bool "Support misaligned load/store traps for kernel and userspace"
 	select SYSCTL_ARCH_UNALIGN_ALLOW
+	depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGNED_ACCESS
 	default y
 	help
 	  Say Y here if you want the kernel to embed support for misaligned
 	  load/store for both kernel and userspace. When disable, misaligned
 	  accesses will generate SIGBUS in userspace and panic in kernel.
 
+choice
+	prompt "Unaligned Accesses Support"
+	default RISCV_PROBE_UNALIGNED_ACCESS
+	help
+	  This selects the hardware support for unaligned accesses. This
+	  information is used by the kernel to perform optimizations. It is also
+	  exposed to user space via the hwprobe syscall. The hardware will be
+	  probed at boot by default.
+
+config RISCV_PROBE_UNALIGNED_ACCESS
+	bool "Probe for hardware unaligned access support"
+	help
+	  During boot, the kernel will run a series of tests to determine the
+	  speed of unaligned accesses. This is the only portable option. This
+	  probing will dynamically determine the speed of unaligned accesses on
+	  the boot hardware.
+
+config RISCV_EMULATED_UNALIGNED_ACCESS
+	bool "Assume the CPU expects emulated unaligned memory accesses"
+	depends on NONPORTABLE
+	select RISCV_MISALIGNED
+	help
+	  Assume that the CPU expects emulated unaligned memory accesses.
+	  When enabled, this option notifies the kernel and userspace that
+	  unaligned memory accesses will be emulated by the kernel. To enforce
+	  this expectation, RISCV_MISALIGNED is selected by this option.
+
+config RISCV_SLOW_UNALIGNED_ACCESS
+	bool "Assume the CPU supports slow unaligned memory accesses"
+	depends on NONPORTABLE
+	help
+	  Assume that the CPU supports slow unaligned memory accesses. When
+	  enabled, this option improves the performance of the kernel on such
+	  CPUs.  However, the kernel will run much more slowly, or will not be
+	  able to run at all, on CPUs that do not support unaligned memory
+	  accesses.
+
 config RISCV_EFFICIENT_UNALIGNED_ACCESS
 	bool "Assume the CPU supports fast unaligned memory accesses"
 	depends on NONPORTABLE
 	select DCACHE_WORD_ACCESS if MMU
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
-	  Say Y here if you want the kernel to assume that the CPU supports
-	  efficient unaligned memory accesses.  When enabled, this option
-	  improves the performance of the kernel on such CPUs.  However, the
-	  kernel will run much more slowly, or will not be able to run at all,
-	  on CPUs that do not support efficient unaligned memory accesses.
+	  Assume that the CPU supports fast unaligned memory accesses. When
+	  enabled, this option improves the performance of the kernel on such
+	  CPUs.  However, the kernel will run much more slowly, or will not be
+	  able to run at all, on CPUs that do not support efficient unaligned
+	  memory accesses.
+
+config RISCV_UNSUPPORTED_UNALIGNED_ACCESS
+	bool "Assume the CPU doesn't support unaligned memory accesses"
+	depends on NONPORTABLE
+	help
+	  Assume that the CPU doesn't support unaligned memory accesses. Only
+	  select this option if there is no registered trap handler to emulate
+	  unaligned accesses.
 
-	  If unsure what to do here, say N.
+endchoice
 
 endmenu # "Platform type"
 
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index eb3ac304fc42..928ad3384406 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -33,10 +33,26 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void riscv_user_isa_enable(void);
 
-#ifdef CONFIG_RISCV_MISALIGNED
+#if defined(CONFIG_RISCV_MISALIGNED)
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 bool unaligned_ctl_available(void);
 bool check_unaligned_access_emulated(int cpu);
 void unaligned_emulation_finish(void);
+#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
+static inline bool unaligned_ctl_available(void)
+{
+	return true;
+}
+
+static inline bool check_unaligned_access_emulated(int cpu)
+{
+	return true;
+}
+
+static inline void unaligned_emulation_finish(void) {}
+#else
+#error "CONFIG_RISCV_MISALIGNED is only supported if CONFIG_RISCV_PROBE_UNALIGNED_ACCESS or CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS is selected."
+#endif
 #else
 static inline bool unaligned_ctl_available(void)
 {
@@ -51,6 +67,7 @@ static inline bool check_unaligned_access_emulated(int cpu)
 static inline void unaligned_emulation_finish(void) {}
 #endif
 
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 DECLARE_PER_CPU(long, misaligned_access_speed);
 
 DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
@@ -59,6 +76,17 @@ static __always_inline bool has_fast_misaligned_accesses(void)
 {
 	return static_branch_likely(&fast_misaligned_access_speed_key);
 }
+#elif defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+static __always_inline bool has_fast_misaligned_accesses(void)
+{
+	return true;
+}
+#else
+static __always_inline bool has_fast_misaligned_accesses(void)
+{
+	return false;
+}
+#endif
 
 unsigned long riscv_get_elf_hwcap(void);
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..7a1646e01a86 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -38,7 +38,6 @@ extra-y += vmlinux.lds
 obj-y	+= head.o
 obj-y	+= soc.o
 obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
-obj-y	+= copy-unaligned.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
 obj-y	+= entry.o
@@ -62,6 +61,11 @@ obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
+ifeq ($(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS), y)
+obj-y	+= copy-unaligned.o
+obj-y	+= misaligned_access_speed.o
+obj-$(CONFIG_RISCV_MISALIGNED)	+= probe_emulated_access.o
+endif
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..319670af5704 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -11,7 +11,6 @@
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
-#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -21,20 +20,12 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwcap.h>
-#include <asm/hwprobe.h>
 #include <asm/patch.h>
 #include <asm/processor.h>
 #include <asm/vector.h>
 
-#include "copy-unaligned.h"
-
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
-#define MISALIGNED_ACCESS_JIFFIES_LG2 1
-#define MISALIGNED_BUFFER_SIZE 0x4000
-#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
-#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
-
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -43,11 +34,6 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
-/* Performance information */
-DEFINE_PER_CPU(long, misaligned_access_speed);
-
-static cpumask_t fast_misaligned_access;
-
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -706,247 +692,6 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-static int check_unaligned_access(void *param)
-{
-	int cpu = smp_processor_id();
-	u64 start_cycles, end_cycles;
-	u64 word_cycles;
-	u64 byte_cycles;
-	int ratio;
-	unsigned long start_jiffies, now;
-	struct page *page = param;
-	void *dst;
-	void *src;
-	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
-
-	if (check_unaligned_access_emulated(cpu))
-		return 0;
-
-	/* Make an unaligned destination buffer. */
-	dst = (void *)((unsigned long)page_address(page) | 0x1);
-	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
-	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
-	src += 2;
-	word_cycles = -1ULL;
-	/* Do a warmup. */
-	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-	preempt_disable();
-	start_jiffies = jiffies;
-	while ((now = jiffies) == start_jiffies)
-		cpu_relax();
-
-	/*
-	 * For a fixed amount of time, repeatedly try the function, and take
-	 * the best time in cycles as the measurement.
-	 */
-	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
-		start_cycles = get_cycles64();
-		/* Ensure the CSR read can't reorder WRT to the copy. */
-		mb();
-		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-		/* Ensure the copy ends before the end time is snapped. */
-		mb();
-		end_cycles = get_cycles64();
-		if ((end_cycles - start_cycles) < word_cycles)
-			word_cycles = end_cycles - start_cycles;
-	}
-
-	byte_cycles = -1ULL;
-	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-	start_jiffies = jiffies;
-	while ((now = jiffies) == start_jiffies)
-		cpu_relax();
-
-	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
-		start_cycles = get_cycles64();
-		mb();
-		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-		mb();
-		end_cycles = get_cycles64();
-		if ((end_cycles - start_cycles) < byte_cycles)
-			byte_cycles = end_cycles - start_cycles;
-	}
-
-	preempt_enable();
-
-	/* Don't divide by zero. */
-	if (!word_cycles || !byte_cycles) {
-		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
-			cpu);
-
-		return 0;
-	}
-
-	if (word_cycles < byte_cycles)
-		speed = RISCV_HWPROBE_MISALIGNED_FAST;
-
-	ratio = div_u64((byte_cycles * 100), word_cycles);
-	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
-		cpu,
-		ratio / 100,
-		ratio % 100,
-		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
-
-	per_cpu(misaligned_access_speed, cpu) = speed;
-
-	/*
-	 * Set the value of fast_misaligned_access of a CPU. These operations
-	 * are atomic to avoid race conditions.
-	 */
-	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
-		cpumask_set_cpu(cpu, &fast_misaligned_access);
-	else
-		cpumask_clear_cpu(cpu, &fast_misaligned_access);
-
-	return 0;
-}
-
-static void check_unaligned_access_nonboot_cpu(void *param)
-{
-	unsigned int cpu = smp_processor_id();
-	struct page **pages = param;
-
-	if (smp_processor_id() != 0)
-		check_unaligned_access(pages[cpu]);
-}
-
-DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
-
-static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
-{
-	if (cpumask_weight(mask) == weight)
-		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
-	else
-		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
-}
-
-static void set_unaligned_access_static_branches_except_cpu(int cpu)
-{
-	/*
-	 * Same as set_unaligned_access_static_branches, except excludes the
-	 * given CPU from the result. When a CPU is hotplugged into an offline
-	 * state, this function is called before the CPU is set to offline in
-	 * the cpumask, and thus the CPU needs to be explicitly excluded.
-	 */
-
-	cpumask_t fast_except_me;
-
-	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &fast_except_me);
-
-	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
-}
-
-static void set_unaligned_access_static_branches(void)
-{
-	/*
-	 * This will be called after check_unaligned_access_all_cpus so the
-	 * result of unaligned access speed for all CPUs will be available.
-	 *
-	 * To avoid the number of online cpus changing between reading
-	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
-	 * held before calling this function.
-	 */
-
-	cpumask_t fast_and_online;
-
-	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
-
-	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
-}
-
-static int lock_and_set_unaligned_access_static_branch(void)
-{
-	cpus_read_lock();
-	set_unaligned_access_static_branches();
-	cpus_read_unlock();
-
-	return 0;
-}
-
-arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
-
-static int riscv_online_cpu(unsigned int cpu)
-{
-	static struct page *buf;
-
-	/* We are already set since the last check */
-	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
-		goto exit;
-
-	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
-	if (!buf) {
-		pr_warn("Allocation failure, not measuring misaligned performance\n");
-		return -ENOMEM;
-	}
-
-	check_unaligned_access(buf);
-	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
-
-exit:
-	set_unaligned_access_static_branches();
-
-	return 0;
-}
-
-static int riscv_offline_cpu(unsigned int cpu)
-{
-	set_unaligned_access_static_branches_except_cpu(cpu);
-
-	return 0;
-}
-
-/* Measure unaligned access on all CPUs present at boot in parallel. */
-static int check_unaligned_access_all_cpus(void)
-{
-	unsigned int cpu;
-	unsigned int cpu_count = num_possible_cpus();
-	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
-				     GFP_KERNEL);
-
-	if (!bufs) {
-		pr_warn("Allocation failure, not measuring misaligned performance\n");
-		return 0;
-	}
-
-	/*
-	 * Allocate separate buffers for each CPU so there's no fighting over
-	 * cache lines.
-	 */
-	for_each_cpu(cpu, cpu_online_mask) {
-		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
-		if (!bufs[cpu]) {
-			pr_warn("Allocation failure, not measuring misaligned performance\n");
-			goto out;
-		}
-	}
-
-	/* Check everybody except 0, who stays behind to tend jiffies. */
-	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
-
-	/* Check core 0. */
-	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
-
-	/*
-	 * Setup hotplug callbacks for any new CPUs that come online or go
-	 * offline.
-	 */
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu, riscv_offline_cpu);
-
-out:
-	unaligned_emulation_finish();
-	for_each_cpu(cpu, cpu_online_mask) {
-		if (bufs[cpu])
-			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
-	}
-
-	kfree(bufs);
-	return 0;
-}
-
-arch_initcall(check_unaligned_access_all_cpus);
-
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
diff --git a/arch/riscv/kernel/misaligned_access_speed.c b/arch/riscv/kernel/misaligned_access_speed.c
new file mode 100644
index 000000000000..b725c07dd1af
--- /dev/null
+++ b/arch/riscv/kernel/misaligned_access_speed.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos Inc.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/jump_label.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+#include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
+
+#include "copy-unaligned.h"
+
+#define MISALIGNED_ACCESS_JIFFIES_LG2 1
+#define MISALIGNED_BUFFER_SIZE 0x4000
+#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
+#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
+
+DEFINE_PER_CPU(long, misaligned_access_speed);
+
+static cpumask_t fast_misaligned_access;
+
+static int check_unaligned_access(void *param)
+{
+	int cpu = smp_processor_id();
+	u64 start_cycles, end_cycles;
+	u64 word_cycles;
+	u64 byte_cycles;
+	int ratio;
+	unsigned long start_jiffies, now;
+	struct page *page = param;
+	void *dst;
+	void *src;
+	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
+
+	if (check_unaligned_access_emulated(cpu))
+		return 0;
+
+	/* Make an unaligned destination buffer. */
+	dst = (void *)((unsigned long)page_address(page) | 0x1);
+	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
+	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
+	src += 2;
+	word_cycles = -1ULL;
+	/* Do a warmup. */
+	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	preempt_disable();
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	/*
+	 * For a fixed amount of time, repeatedly try the function, and take
+	 * the best time in cycles as the measurement.
+	 */
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		/* Ensure the CSR read can't reorder WRT to the copy. */
+		mb();
+		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		/* Ensure the copy ends before the end time is snapped. */
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < word_cycles)
+			word_cycles = end_cycles - start_cycles;
+	}
+
+	byte_cycles = -1ULL;
+	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		mb();
+		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < byte_cycles)
+			byte_cycles = end_cycles - start_cycles;
+	}
+
+	preempt_enable();
+
+	/* Don't divide by zero. */
+	if (!word_cycles || !byte_cycles) {
+		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
+			cpu);
+
+		return 0;
+	}
+
+	if (word_cycles < byte_cycles)
+		speed = RISCV_HWPROBE_MISALIGNED_FAST;
+
+	ratio = div_u64((byte_cycles * 100), word_cycles);
+	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
+		cpu,
+		ratio / 100,
+		ratio % 100,
+		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
+
+	per_cpu(misaligned_access_speed, cpu) = speed;
+
+	/*
+	 * Set the value of fast_misaligned_access of a CPU. These operations
+	 * are atomic to avoid race conditions.
+	 */
+	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
+		cpumask_set_cpu(cpu, &fast_misaligned_access);
+	else
+		cpumask_clear_cpu(cpu, &fast_misaligned_access);
+
+	return 0;
+}
+
+static void check_unaligned_access_nonboot_cpu(void *param)
+{
+	unsigned int cpu = smp_processor_id();
+	struct page **pages = param;
+
+	if (smp_processor_id() != 0)
+		check_unaligned_access(pages[cpu]);
+}
+
+DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
+{
+	if (cpumask_weight(mask) == weight)
+		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
+	else
+		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
+}
+
+static void set_unaligned_access_static_branches_except_cpu(int cpu)
+{
+	/*
+	 * Same as set_unaligned_access_static_branches, except excludes the
+	 * given CPU from the result. When a CPU is hotplugged into an offline
+	 * state, this function is called before the CPU is set to offline in
+	 * the cpumask, and thus the CPU needs to be explicitly excluded.
+	 */
+
+	cpumask_t fast_except_me;
+
+	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &fast_except_me);
+
+	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
+}
+
+static void set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all CPUs will be available.
+	 *
+	 * To avoid the number of online cpus changing between reading
+	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
+	 * held before calling this function.
+	 */
+
+	cpumask_t fast_and_online;
+
+	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
+
+	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
+}
+
+static int lock_and_set_unaligned_access_static_branch(void)
+{
+	cpus_read_lock();
+	set_unaligned_access_static_branches();
+	cpus_read_unlock();
+
+	return 0;
+}
+
+arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
+
+static int riscv_online_cpu(unsigned int cpu)
+{
+	static struct page *buf;
+
+	/* We are already set since the last check */
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		goto exit;
+
+	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+	if (!buf) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return -ENOMEM;
+	}
+
+	check_unaligned_access(buf);
+	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
+
+exit:
+	set_unaligned_access_static_branches();
+
+	return 0;
+}
+
+static int riscv_offline_cpu(unsigned int cpu)
+{
+	set_unaligned_access_static_branches_except_cpu(cpu);
+
+	return 0;
+}
+
+/* Measure unaligned access on all CPUs present at boot in parallel. */
+static int check_unaligned_access_all_cpus(void)
+{
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
+	/*
+	 * Setup hotplug callbacks for any new CPUs that come online or go
+	 * offline.
+	 */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu, riscv_offline_cpu);
+
+out:
+	unaligned_emulation_finish();
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (bufs[cpu])
+			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
+	}
+
+	kfree(bufs);
+	return 0;
+}
+
+arch_initcall(check_unaligned_access_all_cpus);
diff --git a/arch/riscv/kernel/probe_emulated_access.c b/arch/riscv/kernel/probe_emulated_access.c
new file mode 100644
index 000000000000..5f65b31c7558
--- /dev/null
+++ b/arch/riscv/kernel/probe_emulated_access.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos Inc.
+ */
+
+#include <linux/cache.h>
+#include <linux/cpumask.h>
+#include <linux/types.h>
+#include <linux/percpu-defs.h>
+#include <linux/printk.h>
+#include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
+
+static bool unaligned_ctl __read_mostly;
+
+bool check_unaligned_access_emulated(int cpu)
+{
+	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
+	unsigned long tmp_var, tmp_val;
+	bool misaligned_emu_detected;
+
+	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+
+	__asm__ __volatile__ (
+		"       "REG_L" %[tmp], 1(%[ptr])\n"
+		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
+
+	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
+	/*
+	 * If unaligned_ctl is already set, this means that we detected that all
+	 * CPUS uses emulated misaligned access at boot time. If that changed
+	 * when hotplugging the new cpu, this is something we don't handle.
+	 */
+	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
+		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
+		while (true)
+			cpu_relax();
+	}
+
+	return misaligned_emu_detected;
+}
+
+void unaligned_emulation_finish(void)
+{
+	int cpu;
+
+	/*
+	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
+	 * accesses emulated since tasks requesting such control can run on any
+	 * CPU.
+	 */
+	for_each_present_cpu(cpu) {
+		if (per_cpu(misaligned_access_speed, cpu) !=
+					RISCV_HWPROBE_MISALIGNED_EMULATED) {
+			return;
+		}
+	}
+	unaligned_ctl = true;
+}
+
+bool unaligned_ctl_available(void)
+{
+	return unaligned_ctl;
+}
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..33a8abea1a3e 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -147,8 +147,10 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
 	return (pair.value & ext);
 }
 
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 static u64 hwprobe_misaligned(const struct cpumask *cpus)
 {
+	return RISCV_HWPROBE_MISALIGNED_FAST;
 	int cpu;
 	u64 perf = -1ULL;
 
@@ -169,6 +171,29 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 
 	return perf;
 }
+#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_EMULATED;
+}
+#elif defined(CONFIG_RISCV_SLOW_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_SLOW;
+}
+#elif defined(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_FAST;
+}
+#elif defined(CONFIG_RISCV_UNSUPPORTED_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_UNSUPPORTED;
+}
+#else
+#error "Invalid unaligned access speed selected. Please check RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT Kconfig."
+#endif
 
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			     const struct cpumask *cpus)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b..ba6763dd9895 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -398,8 +398,6 @@ union reg_data {
 	u64 data_u64;
 };
 
-static bool unaligned_ctl __read_mostly;
-
 /* sysctl hooks */
 int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
 
@@ -413,7 +411,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
+#endif
 
 	if (!unaligned_enabled)
 		return -1;
@@ -595,53 +595,3 @@ int handle_misaligned_store(struct pt_regs *regs)
 
 	return 0;
 }
-
-bool check_unaligned_access_emulated(int cpu)
-{
-	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
-	unsigned long tmp_var, tmp_val;
-	bool misaligned_emu_detected;
-
-	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
-
-	__asm__ __volatile__ (
-		"       "REG_L" %[tmp], 1(%[ptr])\n"
-		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
-
-	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
-	/*
-	 * If unaligned_ctl is already set, this means that we detected that all
-	 * CPUS uses emulated misaligned access at boot time. If that changed
-	 * when hotplugging the new cpu, this is something we don't handle.
-	 */
-	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
-		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
-		while (true)
-			cpu_relax();
-	}
-
-	return misaligned_emu_detected;
-}
-
-void unaligned_emulation_finish(void)
-{
-	int cpu;
-
-	/*
-	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
-	 * accesses emulated since tasks requesting such control can run on any
-	 * CPU.
-	 */
-	for_each_present_cpu(cpu) {
-		if (per_cpu(misaligned_access_speed, cpu) !=
-					RISCV_HWPROBE_MISALIGNED_EMULATED) {
-			return;
-		}
-	}
-	unaligned_ctl = true;
-}
-
-bool unaligned_ctl_available(void)
-{
-	return unaligned_ctl;
-}

-- 
2.43.0


