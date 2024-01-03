Return-Path: <linux-kernel+bounces-15146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819518227C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F7F284D01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2B1799E;
	Wed,  3 Jan 2024 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzZMtPhY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144E13AD4;
	Wed,  3 Jan 2024 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704255203; x=1735791203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HLaUTmc9YSFTpejEbbvpqy8nCYPF8Cl7OXfIVS5N6NY=;
  b=jzZMtPhYxdfpC2/Dt2ZGMQSklLtaJ7o908LZzJ4pCN3OcsFK4WLZ6yHi
   KcpAQI6lBb5dAyE33miXFaAoHKnSnpPPY89CiUwI2J5NzLzi3XshxhmJJ
   6UgY3pmGivxnsg+B31FYgXS4tO8Xj0Pq51Fubu9YxTYxiCf8+tFYwjZGP
   F3EPNEobvLyXqr8coYkGNeJfSmzqiG703E4bLP73W3+yZw9dNYuHzgK3a
   imHNMiV0Q8fuXABxSdkQc9O+GswFyVX5khE0UCPtgwEJHG2zOytKIFvoU
   JA3/6uk1V8p5fxmX5lzUODb5rtVt67ppX9Oh3dE5i76Nc6M6d3NediHg0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463357396"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="463357396"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 20:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1026957003"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1026957003"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jan 2024 20:13:21 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] thermal: intel: hfi: Refactor enabling code into helper functions
Date: Tue,  2 Jan 2024 20:14:56 -0800
Message-Id: <20240103041459.11113-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In preparation for the addition of a suspend notifier, wrap the logic to
enable HFI and program its memory buffer into helper functions. Both the
CPU hotplug callback and the suspend notifier will use them.

This refactoring does not introduce functional changes.

Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org    # 6.1
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Warned callers of hfi_enable() to hold hfi_instance_lock.
 * Relocated comment about not freeing the HFI pages to the patch that
   introduces hfi_disable(). (Rafael)
 * Updated the changeset description to clarify that there are no
   functional changes. (Rafael)
---
 drivers/thermal/intel/intel_hfi.c | 43 ++++++++++++++++---------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index c69db6c90869..820613e293cd 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -347,6 +347,26 @@ static void init_hfi_instance(struct hfi_instance *hfi_instance)
 	hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
 }
 
+/* Caller must hold hfi_instance_lock. */
+static void hfi_enable(void)
+{
+	u64 msr_val;
+
+	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+}
+
+static void hfi_set_hw_table(struct hfi_instance *hfi_instance)
+{
+	phys_addr_t hw_table_pa;
+	u64 msr_val;
+
+	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
+	msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
+}
+
 /**
  * intel_hfi_online() - Enable HFI on @cpu
  * @cpu:	CPU in which the HFI will be enabled
@@ -364,8 +384,6 @@ void intel_hfi_online(unsigned int cpu)
 {
 	struct hfi_instance *hfi_instance;
 	struct hfi_cpu_info *info;
-	phys_addr_t hw_table_pa;
-	u64 msr_val;
 	u16 die_id;
 
 	/* Nothing to do if hfi_instances are missing. */
@@ -409,8 +427,6 @@ void intel_hfi_online(unsigned int cpu)
 	if (!hfi_instance->hw_table)
 		goto unlock;
 
-	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
-
 	/*
 	 * Allocate memory to keep a local copy of the table that
 	 * hardware generates.
@@ -420,16 +436,6 @@ void intel_hfi_online(unsigned int cpu)
 	if (!hfi_instance->local_table)
 		goto free_hw_table;
 
-	/*
-	 * Program the address of the feedback table of this die/package. On
-	 * some processors, hardware remembers the old address of the HFI table
-	 * even after having been reprogrammed and re-enabled. Thus, do not free
-	 * the pages allocated for the table or reprogram the hardware with a
-	 * new base address. Namely, program the hardware only once.
-	 */
-	msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
-	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
-
 	init_hfi_instance(hfi_instance);
 
 	INIT_DELAYED_WORK(&hfi_instance->update_work, hfi_update_work_fn);
@@ -438,13 +444,8 @@ void intel_hfi_online(unsigned int cpu)
 
 	cpumask_set_cpu(cpu, hfi_instance->cpus);
 
-	/*
-	 * Enable the hardware feedback interface and never disable it. See
-	 * comment on programming the address of the table.
-	 */
-	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
-	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
-	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	hfi_set_hw_table(hfi_instance);
+	hfi_enable();
 
 unlock:
 	mutex_unlock(&hfi_instance_lock);
-- 
2.25.1


