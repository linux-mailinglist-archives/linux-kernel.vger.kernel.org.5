Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C35A7AEF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjIZPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbjIZPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257BF10A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405d70d19bcso6057335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695740637; x=1696345437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTRkIgCqvbOvq5WltvgZniNquXqWMppNcycuOTnJ1ME=;
        b=x79bgUMJe5UqQP4AUlj+09IEnJWhjCCeCBQu2ZsIN/vtaylYZUGwDHtOkcr9mtmqws
         vHvrCQKLHay24gpPqrv6akdx6jbziOJj1q/vg/rZ/3/Niyuzk3o/ShaJ45tnYVSrWLVF
         mc0xJbHd1XN43TgAIUU6PVtnBFdZm/aDDtiD9t3LT+sIl0EL/RaoUX/eNi0a1Yinvnvn
         nu8dy5JNnd0GFnwA/av6f/GzRD7uK7+CiVvMg1ipkZToLlkJigglqzYwolqBpzgE5Bj1
         H4cVUTkzTLATbTM9fewbYePqpHCOQhGVMqxwHNznNxMvDRJek4ZjjBsB/3L0g96JUdy6
         ZBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740637; x=1696345437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTRkIgCqvbOvq5WltvgZniNquXqWMppNcycuOTnJ1ME=;
        b=KmGX7405fznQcHu5QYXPl94elu0JTRs8A+LJppmGFre5YnVpNt6RnqUGbmcUY+9qIW
         hy+TlHD4ioY2bWj/qYEF0HQlsm2TLDNvoAio3y6C36/tznEGKJMnrt0gsZ5WRc7wu+Xx
         GnkL75HngatuawGkO201n+P9Cxm21zWQ7QtX9FZuAl417Qe8/26e2IphOppX9vHn+N8h
         S9VgGR0UP+9bt+QN9MOMwHY52XGgsloAJDdqD7peC9ZMvEc2uzu5E+MPbxk7fgpoRJJF
         wvoNa3GRGY7hMOvNldZUJxyQOiasQ6v26SxwwkuvOt5VtJ77UMB2l7TkuFu1srvV9rwZ
         gNfQ==
X-Gm-Message-State: AOJu0YytXLQ/FQU2pZKs1OW2RrmIkIX/xLKEYFwkm4yFmGX7HLaNyIql
        fyQXEO+2BrSwxa6amGbzT1Jm7g==
X-Google-Smtp-Source: AGHT+IF3tl133AyKMYwdf3JEZLgsj3bubF0UkQguDXYTyEpNjLdmnD+OMwVORcOYpBaWMoc41tZGgQ==
X-Received: by 2002:adf:e945:0:b0:31a:e29f:5eab with SMTP id m5-20020adfe945000000b0031ae29f5eabmr8963359wrn.7.1695740637664;
        Tue, 26 Sep 2023 08:03:57 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2b3d:6c70:9dbf:5ede])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm14926060wru.41.2023.09.26.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:03:57 -0700 (PDT)
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
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: [PATCH 6/7] riscv: report misaligned accesses emulation to hwprobe
Date:   Tue, 26 Sep 2023 17:03:15 +0200
Message-Id: <20230926150316.1129648-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/riscv/include/asm/cpufeature.h  |  6 +++
 arch/riscv/kernel/cpufeature.c       |  6 ++-
 arch/riscv/kernel/setup.c            |  1 +
 arch/riscv/kernel/traps_misaligned.c | 63 +++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index d0345bd659c9..c1f0ef02cd7d 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <asm/hwcap.h>
+#include <asm/hwprobe.h>
 
 /*
  * These are probed via a device_initcall(), via either the SBI or directly
@@ -32,4 +33,9 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void check_unaligned_access(int cpu);
 
+bool unaligned_ctl_available(void);
+
+bool check_unaligned_access_emulated(int cpu);
+void unaligned_emulation_finish(void);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..fbbde800bc21 100644
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
@@ -645,9 +648,10 @@ void check_unaligned_access(int cpu)
 	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
 }
 
-static int check_unaligned_access_boot_cpu(void)
+static int __init check_unaligned_access_boot_cpu(void)
 {
 	check_unaligned_access(0);
+	unaligned_emulation_finish();
 	return 0;
 }
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index e600aab116a4..3af6ad4df7cf 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -26,6 +26,7 @@
 #include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b5fb1ff078e3..fa81f6952fa4 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -9,11 +9,14 @@
 #include <linux/perf_event.h>
 #include <linux/irq.h>
 #include <linux/stringify.h>
+#include <linux/prctl.h>
 
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
 #include <asm/entry-common.h>
+#include <asm/hwprobe.h>
+#include <asm/cpufeature.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -396,8 +399,10 @@ union reg_data {
 	u64 data_u64;
 };
 
+static bool unaligned_ctl __read_mostly;
+
 /* sysctl hooks */
-int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
+int unaligned_enabled __read_mostly;
 
 int handle_misaligned_load(struct pt_regs *regs)
 {
@@ -412,6 +417,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 	if (!unaligned_enabled)
 		return -1;
 
+	if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -511,6 +519,9 @@ int handle_misaligned_store(struct pt_regs *regs)
 	if (!unaligned_enabled)
 		return -1;
 
+	if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -585,3 +596,53 @@ int handle_misaligned_store(struct pt_regs *regs)
 
 	return 0;
 }
+
+bool check_unaligned_access_emulated(int cpu)
+{
+	unsigned long emulated = 1, tmp_var;
+
+	/* Use a fixup to detect if misaligned access triggered an exception */
+	__asm__ __volatile__ (
+		"1:\n"
+		"	"REG_L" %[tmp], 1(%[ptr])\n"
+		"	li %[emulated], 0\n"
+		"2:\n"
+		_ASM_EXTABLE(1b, 2b)
+	: [emulated] "+r" (emulated), [tmp] "=r" (tmp_var)
+	: [ptr] "r" (&tmp_var)
+	: "memory");
+
+	if (!emulated)
+		return false;
+
+	per_cpu(misaligned_access_speed, cpu) =
+		RISCV_HWPROBE_MISALIGNED_EMULATED;
+
+	return true;
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
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(misaligned_access_speed, cpu) !=
+		    RISCV_HWPROBE_MISALIGNED_EMULATED) {
+			goto out;
+		}
+	}
+	unaligned_ctl = true;
+
+out:
+	unaligned_enabled = 1;
+}
+
+bool unaligned_ctl_available(void)
+{
+	return unaligned_ctl;
+}
-- 
2.40.1

