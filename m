Return-Path: <linux-kernel+bounces-50907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1984801E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E631F2AE86
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7D171D2;
	Sat,  3 Feb 2024 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5IAEj6c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96912B60;
	Sat,  3 Feb 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933051; cv=none; b=CtUy9XbI8Ca8AswS82SpYv478PgkLggsHsLEqKAg1Qyf/8Itq7FJSz3Y5yGumweO/ll/H0n0mkdV4PX/VQtED2GGD86JekZsXMfQHyJJA2Ey1VLKDPLZvoNZHZlCT1V3oHUIQlZTZq7CCNRu9YaQYAPMiZR+j0p/ngXSPSFOt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933051; c=relaxed/simple;
	bh=jJ7cQQxTyIeHFxzXpC9coCnefq+U00MraPSXDdxbmwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X7C3C6MTUjnSsWmhyfQhwtuVFvpuVBR95Cz51MBj/LN2J9X33aNweaHasYbzoeZV0Z4bcQpGeVnsuI9TRuEyxL7A5rXRoCTX9uDN9ujvsJ9NDRJAwRDvXi6mWOjep0kxCkoWxvAGYnemI4xF7QTcPquOn10EZtvZxpxL4tUU19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5IAEj6c; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933050; x=1738469050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jJ7cQQxTyIeHFxzXpC9coCnefq+U00MraPSXDdxbmwE=;
  b=G5IAEj6cyNfUeUb4Eey9F6TvwsSh0P70Rr5op+aWnED/3GZSZn0pTkv3
   U6TBvVbQwciai1/9scahZgt+hzivyFmPYUGggM5Rrx32RKbzwGO6CV797
   RQp0Fgf9teXWc88QjI1E82ysmQaArSopOEncD/u0l5e9MAGyT/OB6FeHt
   IaDx3d07rNP2JMzu2cHvfSCPTmQQLMpGsuXllYe/cfeM/mDW4t2Wee7X3
   8QK3/ZsNB4N6JWKH6V/a0yRIBNcOzsdF74oBkeA7kUgRtGHO19wHxMmQ+
   eN96FtO4NYJggKTgg4X09t2UyT1fA+qPIfIz6gA6FiD/A+rlPmtkM5ni1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181429"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181429"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382531"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382531"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:05 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH 9/9] x86/cpu: Introduce interface to reset hardware history
Date: Fri,  2 Feb 2024 20:05:15 -0800
Message-Id: <20240203040515.23947-10-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

KVM needs an interface to reset the history of vCPU at context switch.
When called, hardware will start the classification of the next task
from scratch.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Patch cherry-picked from the IPC classes patchset. Removed calls to
reset_hardware_history() from context switch. Now KVM will call it
directly when needed.
---
 * Measurements of the cost of the HRESET instruction

   Methodology:
   I created a tight loop with interrupts and preemption disabled. I
   recorded the value of the TSC counter before and after executing
   HRESET or RDTSC. I repeated the measurement 100,000 times.
   I performed the experiment using an Alder Lake S system. I set the
   frequency of the CPUs at a fixed value.

   The table below compares the cost of HRESET with RDTSC (expressed in
   the elapsed TSC count). The cost of the two instructions is
   comparable.

                              PCore      ECore
        Frequency (GHz)        5.0        3.8
        HRESET (avg)          28.5       44.7
        HRESET (stdev %)       3.6        2.3
        RDTSC  (avg)          25.2       35.7
        RDTSC  (stdev %)       3.9        2.6
---
 arch/x86/include/asm/hreset.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c  |  8 ++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/x86/include/asm/hreset.h

diff --git a/arch/x86/include/asm/hreset.h b/arch/x86/include/asm/hreset.h
new file mode 100644
index 000000000000..d68ca2fb8642
--- /dev/null
+++ b/arch/x86/include/asm/hreset.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HRESET_H
+
+/**
+ * HRESET - History reset. Available since binutils v2.36.
+ *
+ * Request the processor to reset the history of task classification on the
+ * current logical processor. The history components to be
+ * reset are specified in %eax. Only bits specified in CPUID(0x20).EBX
+ * and enabled in the IA32_HRESET_ENABLE MSR can be selected.
+ *
+ * The assembly code looks like:
+ *
+ *	hreset %eax
+ *
+ * The corresponding machine code looks like:
+ *
+ *	F3 0F 3A F0 ModRM Imm
+ *
+ * The value of ModRM is 0xc0 to specify %eax register addressing.
+ * The ignored immediate operand is set to 0.
+ *
+ * The instruction is documented in the Intel SDM.
+ */
+
+#define __ASM_HRESET  ".byte 0xf3, 0xf, 0x3a, 0xf0, 0xc0, 0x0"
+
+void reset_hardware_history(void);
+
+#endif /* _ASM_X86_HRESET_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bce8719b47c9..ab9809520164 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -57,6 +57,7 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/cacheinfo.h>
+#include <asm/hreset.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/intel-family.h>
@@ -383,6 +384,13 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 
 static u32 hardware_history_features __ro_after_init;
 
+void reset_hardware_history(void)
+{
+	asm_inline volatile (ALTERNATIVE("", __ASM_HRESET, X86_FEATURE_HRESET)
+			     : : "a" (hardware_history_features) : "memory");
+}
+EXPORT_SYMBOL(reset_hardware_history);
+
 static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
-- 
2.25.1


