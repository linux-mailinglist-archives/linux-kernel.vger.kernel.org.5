Return-Path: <linux-kernel+bounces-50904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FE848019
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C747C1C22A4B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF012E6D;
	Sat,  3 Feb 2024 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhkgxMV4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69B10A21;
	Sat,  3 Feb 2024 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933049; cv=none; b=ddCNTjHSERtq4ShEqG1lKr4+m50gsa1FoEKo8J2DAjznnlFz7+T4ySFZsPMof/Tj5Jv5eLEvJY8WmPlbf1eQQa2wYqhLhvRKUjaLgxhlpCHqKnyK2B2eUEooYRHsw7ceUJGtbLqZ+HTxzcZ6oz9KaesrrHw1l/x5E0D5wlhbXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933049; c=relaxed/simple;
	bh=IlogMVxWMm4Bo2Pqh8c/KfMxkwWVK/uFmsNIQCeHpVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tVxKC5haXVQPxGuXNovBrkZZe4ag9R9NwsSaV9GT2xWJU6nsVb50d/QwADrR+H/+wpwPM9dDvlt+Wo7TJuKt8hDGOQLW+mg/qUw6c2coSYbBFZ66gaoywkaD/K903aGPUjmNpyVEneBTOuVTr+E/9UrlXFyGOJPUZrOtMScB8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhkgxMV4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933048; x=1738469048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IlogMVxWMm4Bo2Pqh8c/KfMxkwWVK/uFmsNIQCeHpVw=;
  b=MhkgxMV42y+JBsXc+KOk88jYniwaFTMaKk3dUBin4fQjKKxodtQB5Ak3
   99LwE2MI1IWFbXK4eHvc4U759v8VpLmzBTRYndXoVUxt/uITBy8Lotnpu
   flRlr4wdecaarMxO5MIVqSRg5gITfcxBfbinfHVWnXfW2Sy4jvk3wJLB4
   II2UyIAxJEp1qqcmWhUa4Xi0+2hFvpl/hdlhQsq65ry5/kDA1tPBTEDaV
   cFSqR8XypNCjbtPdOt/UPNMn1ve3FlP8CJf1yvkhDDmH3dt3DLaDqoaAM
   bRV8BGWIWYQdzt23L8z3N61t8rmZTKBZ3lOHtqXjeStcLNLUA+KqO5dsE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181423"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181423"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382522"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382522"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:04 -0800
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
Subject: [PATCH 6/9] thermal: intel: hfi: Enable Intel Thread Director
Date: Fri,  2 Feb 2024 20:05:12 -0800
Message-Id: <20240203040515.23947-7-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable Intel Thread Director (ITD) from the CPU hotplug callback: globally
from CPU0 and then enable the thread-classification hardware in each
logical processor individually.

Also, initialize the number of classes supported.

Currently, a bare-metal machine does not use ITD, but KVM uses the
attributes of the bare-metal machine to virtualize HFI.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> # intel_hfi.c
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Discussion:

This patch conflicts with a patchset from Stanislaw Gruszka to enable HFI
only if there are user space entities listening to the thermal netlink
events. ITD requires that HFI is enabled to function. ITD needs to be
unconditionally enabled for virtual machines.

Options to resolve this conflict include a command-line argument for users
wanting to virtualize HFI or a CONFIG_ option for the same effect. QEMU
could also learn to listen to thermal netlink event. A blunter option is
to unconditionally enable HFI when KVM is enabled at build time.
---
Patch cherry-picked from the IPC classes patchset.
---
---
 arch/x86/include/asm/hfi.h        |  9 ++++++
 arch/x86/include/asm/msr-index.h  |  6 ++++
 drivers/thermal/intel/intel_hfi.c | 52 +++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hfi.h b/arch/x86/include/asm/hfi.h
index 02ee56dbaeb6..b7fda3e0e8c8 100644
--- a/arch/x86/include/asm/hfi.h
+++ b/arch/x86/include/asm/hfi.h
@@ -23,6 +23,15 @@ union cpuid6_edx {
 	u32 full;
 };
 
+union cpuid6_ecx {
+	struct {
+		u32	dont_care0:8;
+		u32	nr_classes:8;
+		u32	dont_care1:16;
+	} split;
+	u32 full;
+};
+
 /**
  * struct hfi_hdr - Header of the HFI table
  * @perf_updated:	Hardware updated performance capabilities
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 46983fb0b5b3..d74932a0778d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1148,6 +1148,12 @@
 
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
 #define HW_FEEDBACK_CONFIG_HFI_ENABLE   BIT_ULL(0)
+#define HW_FEEDBACK_CONFIG_ITD_ENABLE   BIT_ULL(1)
+
+#define MSR_IA32_HW_FEEDBACK_THREAD_CONFIG 0x17d4
+#define HW_FEEDBACK_THREAD_CONFIG_ENABLE BIT_ULL(0)
+
+#define MSR_IA32_HW_FEEDBACK_CHAR       0x17d2
 
 /* x2APIC locked status */
 #define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 3c399f3d059f..b69fa234b317 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -33,6 +33,7 @@
 #include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
+#include <linux/sched/topology.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
@@ -298,6 +299,10 @@ static void hfi_enable(void)
 
 	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE;
+
+	if (cpu_feature_enabled(X86_FEATURE_ITD))
+		msr_val |= HW_FEEDBACK_CONFIG_ITD_ENABLE;
+
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 }
 
@@ -319,6 +324,10 @@ static void hfi_disable(void)
 
 	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 	msr_val &= ~HW_FEEDBACK_CONFIG_HFI_ENABLE;
+
+	if (cpu_feature_enabled(X86_FEATURE_ITD))
+		msr_val &= ~HW_FEEDBACK_CONFIG_ITD_ENABLE;
+
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 
 	/*
@@ -337,6 +346,30 @@ static void hfi_disable(void)
 	}
 }
 
+static void hfi_enable_itd_classification(void)
+{
+	u64 msr_val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ITD))
+		return;
+
+	rdmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+	msr_val |= HW_FEEDBACK_THREAD_CONFIG_ENABLE;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+}
+
+static void hfi_disable_itd_classification(void)
+{
+	u64 msr_val;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ITD))
+		return;
+
+	rdmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+	msr_val &= ~HW_FEEDBACK_THREAD_CONFIG_ENABLE;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_THREAD_CONFIG, msr_val);
+}
+
 /**
  * intel_hfi_online() - Enable HFI on @cpu
  * @cpu:	CPU in which the HFI will be enabled
@@ -377,6 +410,8 @@ void intel_hfi_online(unsigned int cpu)
 
 	init_hfi_cpu_index(info);
 
+	hfi_enable_itd_classification();
+
 	/*
 	 * Now check if the HFI instance of the package/die of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
@@ -460,6 +495,8 @@ void intel_hfi_offline(unsigned int cpu)
 	if (!hfi_instance->local_table.hdr)
 		return;
 
+	hfi_disable_itd_classification();
+
 	mutex_lock(&hfi_instance_lock);
 	cpumask_clear_cpu(cpu, hfi_instance->cpus);
 
@@ -505,8 +542,14 @@ static __init int hfi_parse_features(void)
 	 */
 	hfi_features.class_stride = nr_capabilities;
 
-	/* For now, use only one class of the HFI table */
-	hfi_features.nr_classes = 1;
+	if (cpu_feature_enabled(X86_FEATURE_ITD)) {
+		union cpuid6_ecx ecx;
+
+		ecx.full = cpuid_ecx(CPUID_HFI_LEAF);
+		hfi_features.nr_classes = ecx.split.nr_classes;
+	} else {
+		hfi_features.nr_classes = 1;
+	}
 
 	/*
 	 * The header contains change indications for each supported feature.
@@ -535,11 +578,16 @@ static void hfi_do_enable(void)
 	/* No locking needed. There is no concurrency with CPU online. */
 	hfi_set_hw_table(hfi_instance);
 	hfi_enable();
+
+	hfi_enable_itd_classification();
 }
 
 static int hfi_do_disable(void)
 {
 	/* No locking needed. There is no concurrency with CPU offline. */
+
+	hfi_disable_itd_classification();
+
 	hfi_disable();
 
 	return 0;
-- 
2.25.1


