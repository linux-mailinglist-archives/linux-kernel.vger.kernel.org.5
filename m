Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1867B8352
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbjJDPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243131AbjJDPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DDC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4064e3c7c07so3944685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432470; x=1697037270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hHT3aIZuw8Lkm84JjKEOwJDf1f+gUckXFbeev3RO+4=;
        b=RQmVcm56mq3BNJ9ABwbqJ4e0fbojI0FXUVr0s8AwYYNbUuNoJlKghI/U0HQrq8nsO/
         VB9hKdjA55UgATs+tMoG7Oe3QfMI3Y7l2sosFgQMpByBNxts5hclVT3JtrGpgIyBBFxp
         M2mkSdXQTSKMb7Kvn12qTGT6fJYXzoKVIr2vng5a2M1smyEEZjhFjP6nrmFIRVpeaZbl
         4XXV+jdRN3sWevZdA9RA+7cy5COSSH6DvA/c5d4TcSdkPAz55bPCBWZzqzEHHDTh7/Zl
         QCe2MfDLUGDo+pMhx9qxb933pl0eV6qSeBsS0HAp0rUFa+mGcXR36juQ7WDOsPWJHHzn
         C4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432470; x=1697037270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hHT3aIZuw8Lkm84JjKEOwJDf1f+gUckXFbeev3RO+4=;
        b=UzdI5gu+j7a6bHD4dSvz9jvvwIvbTC7hD1gtGXBqRtfpqF5mPRAfwC14lGkfHPIhB/
         c9HjqvQhIz7CxAX4rGyl9r0b5lMeQQ9SditLtUPCldeTPYpFcyrOtAUxNE5RhuLcoJG8
         hK8eIhiNgoBdRF8KEE8Qj+K990Ky4PsJrJCazsQIVnpDPk2gzX/GLbw3oPj0B1sHYRhF
         7P6XMeE+NS44Bhsk3Fbq88CkOYf8EHyy8oMrb0QuScuB3+q4GZ9Xpy2SDXfeAAFlN2JG
         ofBBnWa604snR02Yf/ziTMYqW71K6Vgd9zoC+TZQr55FQsYucFOYdiEKb9nOukSkTS2e
         Ax6A==
X-Gm-Message-State: AOJu0YwPvagPzgCMQpgXJdatkfEG3M07cdeQ843LzO+gHMkreTj/yYMJ
        GYMf4G36QIw5/uacRSJvuHy3+Q==
X-Google-Smtp-Source: AGHT+IFuCL5rZpZGHOb8V9eEdhrWiMLhtRej1ZZTIPCC1LRN7LnAQEvfCLQ6zr3FZUky7FDjfHrZTw==
X-Received: by 2002:a05:600c:5192:b0:405:1ba2:4fcf with SMTP id fa18-20020a05600c519200b004051ba24fcfmr2488327wmb.4.1696432470736;
        Wed, 04 Oct 2023 08:14:30 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:30 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 7/8] riscv: report misaligned accesses emulation to hwprobe
Date:   Wed,  4 Oct 2023 17:14:04 +0200
Message-ID: <20231004151405.521596-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwprobe provides a way to report if misaligned access are emulated. In
order to correctly populate that feature, we can check if it actually
traps when doing a misaligned access. This can be checked using an
exception table entry which will actually be used when a misaligned
access is done from kernel mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h  | 18 +++++++++
 arch/riscv/kernel/cpufeature.c       |  4 ++
 arch/riscv/kernel/smpboot.c          |  2 +-
 arch/riscv/kernel/traps_misaligned.c | 56 ++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index d0345bd659c9..e4ae6af51876 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -32,4 +32,22 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void check_unaligned_access(int cpu);
 
+#ifdef CONFIG_RISCV_MISALIGNED
+bool unaligned_ctl_available(void);
+bool check_unaligned_access_emulated(int cpu);
+void unaligned_emulation_finish(void);
+#else
+static inline bool unaligned_ctl_available(void)
+{
+	return false;
+}
+
+static inline bool check_unaligned_access_emulated(int cpu)
+{
+	return false;
+}
+
+static inline void unaligned_emulation_finish(void) {}
+#endif
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 356e5677eeb1..fbbde800bc21 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -568,6 +568,9 @@ void check_unaligned_access(int cpu)
 	void *src;
 	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
 
+	if (check_unaligned_access_emulated(cpu))
+		return;
+
 	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
 	if (!page) {
 		pr_warn("Can't alloc pages to measure memcpy performance");
@@ -648,6 +651,7 @@ void check_unaligned_access(int cpu)
 static int __init check_unaligned_access_boot_cpu(void)
 {
 	check_unaligned_access(0);
+	unaligned_emulation_finish();
 	return 0;
 }
 
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1b8da4e40a4d..5d9858d6ad26 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -245,8 +245,8 @@ asmlinkage __visible void smp_callin(void)
 	riscv_ipi_enable();
 
 	numa_add_cpu(curr_cpuid);
-	set_cpu_online(curr_cpuid, 1);
 	check_unaligned_access(curr_cpuid);
+	set_cpu_online(curr_cpuid, 1);
 
 	if (has_vector()) {
 		if (riscv_v_setup_vsize())
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b5fb1ff078e3..d99b95084b6c 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -14,6 +14,8 @@
 #include <asm/ptrace.h>
 #include <asm/csr.h>
 #include <asm/entry-common.h>
+#include <asm/hwprobe.h>
+#include <asm/cpufeature.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -396,6 +398,8 @@ union reg_data {
 	u64 data_u64;
 };
 
+static bool unaligned_ctl __read_mostly;
+
 /* sysctl hooks */
 int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
 
@@ -409,6 +413,8 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
+
 	if (!unaligned_enabled)
 		return -1;
 
@@ -585,3 +591,53 @@ int handle_misaligned_store(struct pt_regs *regs)
 
 	return 0;
 }
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
+void __init unaligned_emulation_finish(void)
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
-- 
2.42.0

