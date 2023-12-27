Return-Path: <linux-kernel+bounces-11861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0A81EC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F221C2230F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC76FC3;
	Wed, 27 Dec 2023 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SU4c8Umk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36E566F;
	Wed, 27 Dec 2023 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703658485; x=1735194485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UBcg3tvQxTk+X28iZS6swUBYQTo6XZRYHj3J6Mm2IvM=;
  b=SU4c8UmkYxzr35uIZX/Szsr+cABZNs2z964wSqLR279KkLpsxNMnWL5J
   M1gVMkglYPt0tvBQJwxQE1RZuZ9A34H+vfmC9EJHZ3dpIpt+720xNQ3a+
   +BBnmlG0h2T3LoNtgDrKNi/gu94ij2Uvs7cLqg2DbgPNaq95tLcdfeakj
   MOd7t9u8SGuI+3MScrkvvPVpBX4oyUtssFTOn5mQgBYKvGaQkqKu5kbh9
   9zjlDjjXVaMYQIXzqIA47iIdW7mRwj2k/XjPRd4GtNtUN9SahSaHeKWXH
   Qdl24aa7Wt/EeRxceIabyv9oGmNaWOAzoWphZT6Zb1kl/lNfwPxhM0Puk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="427584074"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="427584074"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1025316088"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1025316088"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 26 Dec 2023 22:28:00 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	stable@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH 3/4] thermal: intel: hfi: Disable an HFI instance when all its CPUs go offline
Date: Tue, 26 Dec 2023 22:29:39 -0800
Message-Id: <20231227062940.10780-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In preparation to support hibernation, add functionality to disable an HFI
instance during CPU offline. The last CPU of an instance that goes offline
will disable such instance.

The Intel Software Development Manual states that the operating system must
wait for the hardware to set MSR_IA32_PACKAGE_THERM_STATUS[26] after
disabling an HFI instance to ensure that it will no longer write on the HFI
memory. Some processors, however, do not ever set such bit. Wait a minimum
of 2ms to give time hardware to complete any pending memory writes.

Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 15c8c3b841d2..d2c874f43786 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -24,6 +24,7 @@
 #include <linux/bitops.h>
 #include <linux/cpufeature.h>
 #include <linux/cpumask.h>
+#include <linux/delay.h>
 #include <linux/gfp.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -366,6 +367,31 @@ static void hfi_set_hw_table(struct hfi_instance *hfi_instance)
 	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
 }
 
+static void hfi_disable(void)
+{
+	u64 msr_val;
+	int i;
+
+	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	msr_val &= ~HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+
+	/*
+	 * Wait for hardware to acknowledge the disabling of HFI. Some
+	 * processors may not do it. Wait for ~2ms. This is a reasonable
+	 * time for hardware to complete any pending actions on the HFI
+	 * memory.
+	 */
+	for (i = 0; i < 2000; i++) {
+		rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
+		if (msr_val & PACKAGE_THERM_STATUS_HFI_UPDATED)
+			break;
+
+		udelay(1);
+		cpu_relax();
+	}
+}
+
 /**
  * intel_hfi_online() - Enable HFI on @cpu
  * @cpu:	CPU in which the HFI will be enabled
@@ -491,6 +517,10 @@ void intel_hfi_offline(unsigned int cpu)
 
 	mutex_lock(&hfi_instance_lock);
 	cpumask_clear_cpu(cpu, hfi_instance->cpus);
+
+	if (!cpumask_weight(hfi_instance->cpus))
+		hfi_disable();
+
 	mutex_unlock(&hfi_instance_lock);
 }
 
-- 
2.25.1


