Return-Path: <linux-kernel+bounces-124238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC189143D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3031EB2415B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435D54F95;
	Fri, 29 Mar 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Jj4ekp+9"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A640C0C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697104; cv=none; b=p2fhr/C2dfHySF8PFA0eaxJgS4n2DfFvH7esvrqQC2S1DKZci2oPCl7R5JhIz4XEvGS7QAvfYRxEKtrieNSrmUKs+ntxZpeWtLmKiEihgZv4S3kYOnPFI2zaD+ju3cfnYXLX2ZIpMCK+RSm2ICEZ1sXClYTGz4H3Cce+Mlsn9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697104; c=relaxed/simple;
	bh=TtGeb77JJjuHILekBexWTEYwU/KUewLYw7aWzpsPJ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd1NFiSy4/71JT83soJyTFomyZ1rErVRIrbl1pZWZ5Rm0yLvyS2ltoKjKCezyXSSHM1Wi1YVLKMUav42WQacH97RSTwCU5sgmFe4Z99FFfJvms5Kp3NQxDsAj4ENybQWak8Nfvpcf/noCUAjmbVq0TSGoa7rm8q09WcOA4GP+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Jj4ekp+9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1061345a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697103; x=1712301903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4EVp4FPE+/jeIRBNmVRsUyItk8Ntjq2i9UEb5o+3e0=;
        b=Jj4ekp+9sVIgnR+adfgY+DF6nS2bDq9KH3FUjBf81sSTgsouFXTyoHtwDm4sEt/olG
         m/vuhcoEmxC+TV4BwoQqcJG2EQPXjASM17p09AChtUCDNKDlkwLoPM/y2wTDVYYfy1Ej
         jaOpsYs3CkX0HrKGytftp4jemet43B+3BUvlhWV+kWt+uBjMRR8PAoW+Hhm2uWjALw1U
         WO2FJ+l2tdrBHFHB1zQFOxd5L9C3HnBt8YyjuVnAD0G68nyMTdT1DPKr7AdgaXFMFDLw
         05licDdCokMkkrgmxjD89Z0uG3vzcTNrZQPtbubXYw7/bjlZlKakh5JiLJ6qMZscVjvM
         vZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697103; x=1712301903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4EVp4FPE+/jeIRBNmVRsUyItk8Ntjq2i9UEb5o+3e0=;
        b=NDL1NSLBKsqWnm+VAxOA9QsaiUJIFrI+yVmepxLjbpBB8Qlb5XwvR5tat6KYW7Fq9C
         2/r3s2NNqVMAA80UTJCgq4Uh629uXnFhYXjUZEkAzEdgW8+OMAYWrEx5q14foy1dl7DO
         SZLM4psLVQMddLIxMZLrt1SKEJttMcyKzP/7d0c3jYKhRIqd0UUZRT67uPsa9ysdRK1Q
         PYCERYn34WyH2Z9t1KPw8qb+wBToMiPvP84Kw7kMA8u+54VjeHFA3Rdp4kJ08t8M1Jy0
         L8P08IN2CkLJiVB3oxguCofjIuEuWdiQ4LU4UqrY5r6VmD3KHc3WiVgbvLEYUGS+LbcY
         Z2og==
X-Gm-Message-State: AOJu0Yw6MFH69lSHHbEn7sSCEkFXEBO57dqVuyt9O0We5nUDW4hCLIOb
	ENLBKIs3TKz7sOzxXq4bmB9IKFatLpEzvvq801TQUdp1tYj09P0iA14u+lmkmn4=
X-Google-Smtp-Source: AGHT+IHObpmsfqDnVzwffSCR0G9zA2Nzm55W89HV7TW/i69TFVB/o13/9rds5tWd/Fn8feEYN1IDow==
X-Received: by 2002:a17:90a:f2ce:b0:29f:cbd8:ea11 with SMTP id gt14-20020a17090af2ce00b0029fcbd8ea11mr1691675pjb.15.1711697102774;
        Fri, 29 Mar 2024 00:25:02 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:25:02 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 11/15] riscv: Add support for kernel-mode FPU
Date: Fri, 29 Mar 2024 00:18:26 -0700
Message-ID: <20240329072441.591471-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is motivated by the amdgpu DRM driver, which needs floating-point
code to support recent hardware. That code is not performance-critical,
so only provide a minimal non-preemptible implementation for now.

Support is limited to riscv64 because riscv32 requires runtime (libgcc)
assistance to convert between doubles and 64-bit integers.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Limit riscv ARCH_HAS_KERNEL_FPU_SUPPORT to 64BIT

Changes in v2:
 - Remove RISC-V architecture-specific preprocessor check

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  3 +++
 arch/riscv/include/asm/fpu.h        | 16 ++++++++++++++++
 arch/riscv/kernel/Makefile          |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c | 28 ++++++++++++++++++++++++++++
 5 files changed, 49 insertions(+)
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..3bcd0d250810 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -27,6 +27,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if 64BIT && FPU
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MMIOWB
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 252d63942f34..76ff4033c854 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -84,6 +84,9 @@ KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64i
 
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
+# For C code built with floating-point support, exclude V but keep F and D.
+CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
+
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
diff --git a/arch/riscv/include/asm/fpu.h b/arch/riscv/include/asm/fpu.h
new file mode 100644
index 000000000000..91c04c244e12
--- /dev/null
+++ b/arch/riscv/include/asm/fpu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_RISCV_FPU_H
+#define _ASM_RISCV_FPU_H
+
+#include <asm/switch_to.h>
+
+#define kernel_fpu_available()	has_fpu()
+
+void kernel_fpu_begin(void);
+void kernel_fpu_end(void);
+
+#endif /* ! _ASM_RISCV_FPU_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 81d94a8ee10f..5b243d46f4b1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
 obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
 
 obj-$(CONFIG_FPU)		+= fpu.o
+obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
 obj-$(CONFIG_SMP)		+= smpboot.o
diff --git a/arch/riscv/kernel/kernel_mode_fpu.c b/arch/riscv/kernel/kernel_mode_fpu.c
new file mode 100644
index 000000000000..0ac8348876c4
--- /dev/null
+++ b/arch/riscv/kernel/kernel_mode_fpu.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#include <linux/export.h>
+#include <linux/preempt.h>
+
+#include <asm/csr.h>
+#include <asm/fpu.h>
+#include <asm/processor.h>
+#include <asm/switch_to.h>
+
+void kernel_fpu_begin(void)
+{
+	preempt_disable();
+	fstate_save(current, task_pt_regs(current));
+	csr_set(CSR_SSTATUS, SR_FS);
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+
+void kernel_fpu_end(void)
+{
+	csr_clear(CSR_SSTATUS, SR_FS);
+	fstate_restore(current, task_pt_regs(current));
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_end);
-- 
2.44.0


