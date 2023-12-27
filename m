Return-Path: <linux-kernel+bounces-11859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A57D81EC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B095B223C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D840863AE;
	Wed, 27 Dec 2023 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFQg8qCE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC0522C;
	Wed, 27 Dec 2023 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703658483; x=1735194483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3J1rY7OAYKzRe6JNvKbC7Xa6ZAlF+WUnw25g4mgFxQs=;
  b=WFQg8qCEtvzvZin0y7l6P4rvFS/nYTbxnuk8AQmolrcJr7t7Ruu4lsCh
   6YpW1A+//vMh1TERv0FwQbw1YVN+g690kVbDafnKZqJaxt4E6T20unJ2/
   K+c8bQkeeHlMMbcdn/nQMiCLvtu7ZizdC5OuFizMlgEDqbBNDYw6/b/Jl
   VCQrlLnuRlEyMzLwtOdqdhRESabkkIVLZcV+ZJMni1so28BAkD0bDzF3i
   3YcBe7ko5MaYoHVcC0xnt4u89Fybug9gaSZpK7SNJc0QFD2YWbljQ3xjY
   Qq3zs1LniQM04D2kRd4PFZceOFpd9uzwUwt4lETsR08gZgXmk+qHNFhBw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="427584072"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="427584072"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1025316082"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1025316082"
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
Subject: [PATCH 1/4] thermal: intel: hfi: Refactor enabling code into helper functions
Date: Tue, 26 Dec 2023 22:29:37 -0800
Message-Id: <20231227062940.10780-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In preparation to add a suspend notifier, wrap the logic to enable HFI and
program its memory buffer into helper functions. Both the CPU hotplug
callback and the suspend notifier will use it.

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
 drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++--------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index c69db6c90869..87ac7b196981 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -347,6 +347,25 @@ static void init_hfi_instance(struct hfi_instance *hfi_instance)
 	hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
 }
 
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
@@ -364,8 +383,6 @@ void intel_hfi_online(unsigned int cpu)
 {
 	struct hfi_instance *hfi_instance;
 	struct hfi_cpu_info *info;
-	phys_addr_t hw_table_pa;
-	u64 msr_val;
 	u16 die_id;
 
 	/* Nothing to do if hfi_instances are missing. */
@@ -403,14 +420,16 @@ void intel_hfi_online(unsigned int cpu)
 	/*
 	 * Hardware is programmed with the physical address of the first page
 	 * frame of the table. Hence, the allocated memory must be page-aligned.
+	 *
+	 * Some processors do not forget the initial address of the HFI table
+	 * even after having been reprogrammed. Keep using the same pages. Do
+	 * not free them.
 	 */
 	hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
 						   GFP_KERNEL | __GFP_ZERO);
 	if (!hfi_instance->hw_table)
 		goto unlock;
 
-	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
-
 	/*
 	 * Allocate memory to keep a local copy of the table that
 	 * hardware generates.
@@ -420,16 +439,6 @@ void intel_hfi_online(unsigned int cpu)
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
@@ -438,13 +447,8 @@ void intel_hfi_online(unsigned int cpu)
 
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


