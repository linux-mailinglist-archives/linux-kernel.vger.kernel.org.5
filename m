Return-Path: <linux-kernel+bounces-108171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9634880710
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7125D285611
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762746026B;
	Tue, 19 Mar 2024 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U+jIAuF4"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF685FDB2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885566; cv=none; b=GgVMR7D/Q56+5lIxlR76Vevi8Zw+LNhHkDMuiq8rFiZVsHwdQOtwk4pRGgbaR1Ce5QYiifnpILspugnVuHogdHqyqdKPJsp2Jg4tbbyTmJIq/KLHB3wk3paxjws9HFT8MGjsEa3jE4/dMnxqqHiaI/dQWyrgOp/nOYehRP2I7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885566; c=relaxed/simple;
	bh=GLEEiARS0U+uCt/Rx278XJ8ykFDykdXHhXPEV6xk8dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8caw8sZJbLWg05gz6E74PriQG8trF0mAygYx8NUN7n3SHdi5P0lpcpNoaFFhTmuI0L2ocp/H8Gsuj2KNVwSTVRyWFc5fV//rfXxwnRcu5gc2phYmi+VJmVqOXFct9tj2QYQUdgk4ZKp9kqIVVApuEbhhHb5ybqpOQYCeVOAFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U+jIAuF4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6c8823519so5850648b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710885564; x=1711490364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9YnfDFlIzM6IgPNouej5vSECO3AYIq38694OD5b58U=;
        b=U+jIAuF4lNfO/bWKwFnLWus+BedPeSR3qQeBmWYC0S91jMc1NOA6pVhL9z2knyFgPJ
         J+pAjdTnkGKbPQjqmVnyis2ZHfhj2FTD8X1l8tiFStdkwZPrKMPh/SaagPVwASyWdnZc
         8fWOE2LQ7nzAIYkDvZPoVZkTGPa9Pp36DE7yqs1gYKxW95N8gnzd1e10tUjuUYjtaPfC
         6bZi0MDFqRwFwvRL9bnOuhMdo+K4MyLDbzgN7+qLzORprqvvYUcxUHgs55wwiIkTXxVp
         LQVRxTx4VElvZLu19j5Wci2onIdLKWMflq5MMCBXGcTpV7Us4/iiq5o4An2miX/EzpyW
         4ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710885564; x=1711490364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9YnfDFlIzM6IgPNouej5vSECO3AYIq38694OD5b58U=;
        b=dUm9U8KtmbCoXoRbC66sE2NgZdcX9CNmvqjC8/tW9AhtsA8ns1QbbbOPFQilj44CzZ
         iZU4hA6c6mqBXZNsxIU+4uZ7IfI70Ogi+vSRzHBKaIiZKxzfXnZEOyRguXpcuJjHL/yN
         2r4caU0WpwhFgN/ClZbiY7ohlpR8YoUNKdg6muT8YluQvH61Etcjr1aSNm0dx2oYZCg8
         eRfvrMKqygldl5rgvIPY0/ks3GVWBMjxGXlao8UAc2Zu7ItMhBEK+baw1MVU+BXNLDt1
         wVOAye5PDzE5nLEmI5WRXeTJfDiMM16YniQo/eJ29qTb7a5l/6RQLhMdKZ0SBseKFC1y
         6sww==
X-Forwarded-Encrypted: i=1; AJvYcCXYmxUUVVdEomTI8Z+FTDYQLC8PDCAqAlxezLfE9xDoy9okW3ZA8VPIZ0u128/ofXAL4goIEs5fFbSpa9hNgVwuPQHmi1l3nF3n81Xd
X-Gm-Message-State: AOJu0YzmczMz7ZcmnZ7gdZZWqaUk2MO1N918MEHFZOiMBc23G5GGZxqa
	ykc1s6EUqWURtqV+P21aIckQRjAUjNq9ZkwZPUviXWW3nyvkjrEFd3c+Eeypv6M=
X-Google-Smtp-Source: AGHT+IHrqGWm4HKmgxz4QikODSsEmQwi2ndyv1CO9uxCpMgdQukkIvJsZM3/zryU+sLiBqD988H0gQ==
X-Received: by 2002:a05:6a21:350d:b0:1a3:7efc:81f4 with SMTP id zc13-20020a056a21350d00b001a37efc81f4mr1954693pzb.16.1710885564420;
        Tue, 19 Mar 2024 14:59:24 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020aa785d9000000b006e6c61b264bsm10273892pfn.32.2024.03.19.14.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:59:24 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	tech-j-ext@lists.risc-v.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Stefan Roesch <shr@devkernel.io>
Subject: [RFC PATCH 6/9] riscv: Add support for userspace pointer masking
Date: Tue, 19 Mar 2024 14:58:32 -0700
Message-ID: <20240319215915.832127-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240319215915.832127-1-samuel.holland@sifive.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V supports pointer masking with a variable number of tag bits
("PMLEN") and which is configured at the next higher privilege level.

Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
so userspace can request a minimum number of tag bits and determine the
actual number of tag bits. As with PR_TAGGED_ADDR_ENABLE, the pointer
masking configuration is thread-scoped, inherited on clone() and fork()
and cleared on exec().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig                 |   8 +++
 arch/riscv/include/asm/processor.h |   8 +++
 arch/riscv/kernel/process.c        | 107 +++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h         |   3 +
 4 files changed, 126 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e3142ce531a0..a1a1585120f0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -479,6 +479,14 @@ config RISCV_ISA_C
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_POINTER_MASKING
+	bool "Smmpm, Smnpm, and Ssnpm extensions for pointer masking"
+	depends on 64BIT
+	default y
+	help
+	  Add support to dynamically detect the presence of the Smmpm, Smnpm,
+	  and Ssnpm extensions (pointer masking) and enable their usage.
+
 config RISCV_ISA_SVNAPOT
 	bool "Svnapot extension support for supervisor mode NAPOT pages"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 06b87402a4d8..64b34e839802 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -185,6 +185,14 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
 
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
+long get_tagged_addr_ctrl(struct task_struct *task);
+#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
+#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 92922dbd5b5c..3578e75f4aa4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/bitfield.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -154,6 +155,18 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 #endif
 }
 
+static void flush_tagged_addr_state(void)
+{
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SxNPM))
+		return;
+
+	current->thread.envcfg &= ~ENVCFG_PMM;
+
+	sync_envcfg(current);
+#endif
+}
+
 void flush_thread(void)
 {
 #ifdef CONFIG_FPU
@@ -173,6 +186,7 @@ void flush_thread(void)
 	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
 	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
 #endif
+	flush_tagged_addr_state();
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -236,3 +250,96 @@ void __init arch_task_cache_init(void)
 {
 	riscv_v_setup_ctx_cache();
 }
+
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+static bool have_user_pmlen_7;
+static bool have_user_pmlen_16;
+
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
+{
+	unsigned long valid_mask = PR_PMLEN_MASK;
+	struct thread_info *ti = task_thread_info(task);
+	u8 pmlen;
+
+	if (is_compat_thread(ti))
+		return -EINVAL;
+
+	if (arg & ~valid_mask)
+		return -EINVAL;
+
+	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
+	if (pmlen > 16) {
+		return -EINVAL;
+	} else if (pmlen > 7) {
+		if (have_user_pmlen_16)
+			pmlen = 16;
+		else
+			return -EINVAL;
+	} else if (pmlen > 0) {
+		/*
+		 * Prefer the smallest PMLEN that satisfies the user's request,
+		 * in case choosing a larger PMLEN has a performance impact.
+		 */
+		if (have_user_pmlen_7)
+			pmlen = 7;
+		else if (have_user_pmlen_16)
+			pmlen = 16;
+		else
+			return -EINVAL;
+	}
+
+	task->thread.envcfg &= ~ENVCFG_PMM;
+	if (pmlen == 7)
+		task->thread.envcfg |= ENVCFG_PMM_PMLEN_7;
+	else if (pmlen == 16)
+		task->thread.envcfg |= ENVCFG_PMM_PMLEN_16;
+
+	if (task == current)
+		sync_envcfg(current);
+
+	return 0;
+}
+
+long get_tagged_addr_ctrl(struct task_struct *task)
+{
+	struct thread_info *ti = task_thread_info(task);
+	long ret = 0;
+
+	if (is_compat_thread(ti))
+		return -EINVAL;
+
+	switch (task->thread.envcfg & ENVCFG_PMM) {
+	case ENVCFG_PMM_PMLEN_7:
+		ret |= FIELD_PREP(PR_PMLEN_MASK, 7);
+		break;
+	case ENVCFG_PMM_PMLEN_16:
+		ret |= FIELD_PREP(PR_PMLEN_MASK, 16);
+		break;
+	}
+
+	return ret;
+}
+
+static bool try_to_set_pmm(unsigned long value)
+{
+	csr_set(CSR_ENVCFG, value);
+	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
+}
+
+static int __init tagged_addr_init(void)
+{
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SxNPM))
+		return 0;
+
+	/*
+	 * envcfg.PMM is a WARL field. Detect which values are supported.
+	 * Assume the supported PMLEN values are the same on all harts.
+	 */
+	csr_clear(CSR_ENVCFG, ENVCFG_PMM);
+	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
+	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
+
+	return 0;
+}
+core_initcall(tagged_addr_init);
+#endif	/* CONFIG_RISCV_ISA_POINTER_MASKING */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..488b0d8e8495 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -244,6 +244,9 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* RISC-V pointer masking tag length */
+# define PR_PMLEN_SHIFT			24
+# define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
 
 /* Control reclaim behavior when allocating memory */
 #define PR_SET_IO_FLUSHER		57
-- 
2.43.1


