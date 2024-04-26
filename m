Return-Path: <linux-kernel+bounces-159500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3549C8B2F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1182B1C21502
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213082890;
	Fri, 26 Apr 2024 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvAsLR2D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7582498
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105499; cv=none; b=YBp8Vi6/rfHZK8hKg/F4mtvf25R5chkJtEKOZqpUQhKHqwa7Q9+e73KmzHomckdj6FYFYQuBd3y85gTgtb3pjvt7VVIduIt+z0oml4SKfxWR03xZHeLHkQKcQjxMGaKw/Yvs9WbOB2An/5DtWMTzgqYOKDBZtHgvEubERoRX9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105499; c=relaxed/simple;
	bh=oqPPwXD1qFSn8hAJXO23HwvJ2xp/7r9gtfSILVNBa8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B42kgKN2iPOAtC7/dAB0SC5vKvA7VUb7WrJ8/BeaKVKXoqWpflEqg0rRb+UNip/tpmPH6qB0cxTaiecXoVG5+cGeRGujDk8oi95ZbDWJHOR0dtdQkuYP1AeaMMdfiNHSryRD3IZrQZMIUsudGDEOx4+9ZQ4ydsqjB0R49wmAq9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvAsLR2D; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714105498; x=1745641498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqPPwXD1qFSn8hAJXO23HwvJ2xp/7r9gtfSILVNBa8g=;
  b=KvAsLR2DuwcqpLmDj3vBeArowW5a8tPoKf3MaWDmP6Ayd+SDYlf/ftew
   9Kr25MHQpePCWl15e5GYrl98kuWH9gz6Zbu7TZ+FEuwL+7dO8j35HoEmB
   yvROoQK12VTNPN2NrAunxXhRh2xSizHAD+AbbB+TnCTueiemh9buB/BMA
   hdrkD5fcr61qGgWtbvBF+3nHdnxGgiP8QHG2vtRizxs0TlZs7H/bV2dN+
   MiMy/gb3XbwfS3DLS0aH28fWV4lrIcxHSgGZjE3qlcxrk2DvYCvLHMxeu
   704077U4zAaKEz7J/Py8TQQisqx3Fx1f4oVR08rLUFYRNVAyLe0nl9df/
   A==;
X-CSE-ConnectionGUID: Ux5xvbKtQyWGtng5WGcIZQ==
X-CSE-MsgGUID: XIsEBG42SxKx0yp6LIjPIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13613174"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="13613174"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:24:56 -0700
X-CSE-ConnectionGUID: NlKKnzarS2Ct7bc4Ph8e9g==
X-CSE-MsgGUID: Juc/ycf6QSa8teNInjl+mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="30099340"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:24:56 -0700
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/pconfig: Remove unused MKTME pconfig code
Date: Thu, 25 Apr 2024 21:24:53 -0700
Message-Id: <029c84dd5743c8d56734593455ae3d576387f72b.1713929290.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713929290.git.alison.schofield@intel.com>
References: <cover.1713929290.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Code supporting Intel PCONFIG targets was an early piece of enabling
for MKTME (Multi-Key Total Memory Encryption).

Since MKTME feature enablement did not follow into the kernel, remove
the unused PCONFIG code.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/include/asm/intel_pconfig.h | 65 ---------------------
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/intel_pconfig.c  | 84 ----------------------------
 3 files changed, 1 insertion(+), 150 deletions(-)
 delete mode 100644 arch/x86/include/asm/intel_pconfig.h
 delete mode 100644 arch/x86/kernel/cpu/intel_pconfig.c

diff --git a/arch/x86/include/asm/intel_pconfig.h b/arch/x86/include/asm/intel_pconfig.h
deleted file mode 100644
index 994638ef171b..000000000000
--- a/arch/x86/include/asm/intel_pconfig.h
+++ /dev/null
@@ -1,65 +0,0 @@
-#ifndef	_ASM_X86_INTEL_PCONFIG_H
-#define	_ASM_X86_INTEL_PCONFIG_H
-
-#include <asm/asm.h>
-#include <asm/processor.h>
-
-enum pconfig_target {
-	INVALID_TARGET	= 0,
-	MKTME_TARGET	= 1,
-	PCONFIG_TARGET_NR
-};
-
-int pconfig_target_supported(enum pconfig_target target);
-
-enum pconfig_leaf {
-	MKTME_KEY_PROGRAM	= 0,
-	PCONFIG_LEAF_INVALID,
-};
-
-#define PCONFIG ".byte 0x0f, 0x01, 0xc5"
-
-/* Defines and structure for MKTME_KEY_PROGRAM of PCONFIG instruction */
-
-/* mktme_key_program::keyid_ctrl COMMAND, bits [7:0] */
-#define MKTME_KEYID_SET_KEY_DIRECT	0
-#define MKTME_KEYID_SET_KEY_RANDOM	1
-#define MKTME_KEYID_CLEAR_KEY		2
-#define MKTME_KEYID_NO_ENCRYPT		3
-
-/* mktme_key_program::keyid_ctrl ENC_ALG, bits [23:8] */
-#define MKTME_AES_XTS_128	(1 << 8)
-
-/* Return codes from the PCONFIG MKTME_KEY_PROGRAM */
-#define MKTME_PROG_SUCCESS	0
-#define MKTME_INVALID_PROG_CMD	1
-#define MKTME_ENTROPY_ERROR	2
-#define MKTME_INVALID_KEYID	3
-#define MKTME_INVALID_ENC_ALG	4
-#define MKTME_DEVICE_BUSY	5
-
-/* Hardware requires the structure to be 256 byte aligned. Otherwise #GP(0). */
-struct mktme_key_program {
-	u16 keyid;
-	u32 keyid_ctrl;
-	u8 __rsvd[58];
-	u8 key_field_1[64];
-	u8 key_field_2[64];
-} __packed __aligned(256);
-
-static inline int mktme_key_program(struct mktme_key_program *key_program)
-{
-	unsigned long rax = MKTME_KEY_PROGRAM;
-
-	if (!pconfig_target_supported(MKTME_TARGET))
-		return -ENXIO;
-
-	asm volatile(PCONFIG
-		: "=a" (rax), "=b" (key_program)
-		: "0" (rax), "1" (key_program)
-		: "memory", "cc");
-
-	return rax;
-}
-
-#endif	/* _ASM_X86_INTEL_PCONFIG_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index eb4dbcdf41f1..ecd78a61da2e 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_PROC_FS)			+= proc.o
 
 obj-$(CONFIG_IA32_FEAT_CTL)		+= feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
-obj-y					+= intel.o intel_pconfig.o tsx.o
+obj-y					+= intel.o tsx.o
 obj-$(CONFIG_PM)			+= intel_epb.o
 endif
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
diff --git a/arch/x86/kernel/cpu/intel_pconfig.c b/arch/x86/kernel/cpu/intel_pconfig.c
deleted file mode 100644
index 5be2b1790282..000000000000
--- a/arch/x86/kernel/cpu/intel_pconfig.c
+++ /dev/null
@@ -1,84 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Intel PCONFIG instruction support.
- *
- * Copyright (C) 2017 Intel Corporation
- *
- * Author:
- *	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
- */
-#include <linux/bug.h>
-#include <linux/limits.h>
-
-#include <asm/cpufeature.h>
-#include <asm/intel_pconfig.h>
-
-#define	PCONFIG_CPUID			0x1b
-
-#define PCONFIG_CPUID_SUBLEAF_MASK	((1 << 12) - 1)
-
-/* Subleaf type (EAX) for PCONFIG CPUID leaf (0x1B) */
-enum {
-	PCONFIG_CPUID_SUBLEAF_INVALID	= 0,
-	PCONFIG_CPUID_SUBLEAF_TARGETID	= 1,
-};
-
-/* Bitmask of supported targets */
-static u64 targets_supported __read_mostly;
-
-int pconfig_target_supported(enum pconfig_target target)
-{
-	/*
-	 * We would need to re-think the implementation once we get > 64
-	 * PCONFIG targets. Spec allows up to 2^32 targets.
-	 */
-	BUILD_BUG_ON(PCONFIG_TARGET_NR >= 64);
-
-	if (WARN_ON_ONCE(target >= 64))
-		return 0;
-	return targets_supported & (1ULL << target);
-}
-
-static int __init intel_pconfig_init(void)
-{
-	int subleaf;
-
-	if (!boot_cpu_has(X86_FEATURE_PCONFIG))
-		return 0;
-
-	/*
-	 * Scan subleafs of PCONFIG CPUID leaf.
-	 *
-	 * Subleafs of the same type need not to be consecutive.
-	 *
-	 * Stop on the first invalid subleaf type. All subleafs after the first
-	 * invalid are invalid too.
-	 */
-	for (subleaf = 0; subleaf < INT_MAX; subleaf++) {
-		struct cpuid_regs regs;
-
-		cpuid_count(PCONFIG_CPUID, subleaf,
-				&regs.eax, &regs.ebx, &regs.ecx, &regs.edx);
-
-		switch (regs.eax & PCONFIG_CPUID_SUBLEAF_MASK) {
-		case PCONFIG_CPUID_SUBLEAF_INVALID:
-			/* Stop on the first invalid subleaf */
-			goto out;
-		case PCONFIG_CPUID_SUBLEAF_TARGETID:
-			/* Mark supported PCONFIG targets */
-			if (regs.ebx < 64)
-				targets_supported |= (1ULL << regs.ebx);
-			if (regs.ecx < 64)
-				targets_supported |= (1ULL << regs.ecx);
-			if (regs.edx < 64)
-				targets_supported |= (1ULL << regs.edx);
-			break;
-		default:
-			/* Unknown CPUID.PCONFIG subleaf: ignore */
-			break;
-		}
-	}
-out:
-	return 0;
-}
-arch_initcall(intel_pconfig_init);
-- 
2.37.3


