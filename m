Return-Path: <linux-kernel+bounces-50900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1EE848011
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C7328A386
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A27510A3B;
	Sat,  3 Feb 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Utd78SGz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C270F9E5;
	Sat,  3 Feb 2024 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933047; cv=none; b=fAxET8hPq4Kb1mo4vO8fVWwZiGfGjHpM/ilwHyAKKUoIApjcE+4W6Je6164KUC99ZcXldBAM9j8Uw/kfu1hFUlWzJ48QqTUs667nRVcP3Z1Dk+fMCcy2mb68ST8woVlZJMkJaLShX91+4JBmdTvEtTLIejkxoxrrFMMtEoNVtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933047; c=relaxed/simple;
	bh=z1W8+46dFSMzS7P+ODJHug2hSnG5Nh7Cru/GHZYPbV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hBiBL0k2hLXZSAeb5CZ3KonZLgoMde9Tkszf0kwZt0Sy0/bN4z5o+IYvB7o6uVjfcXeIcNqDU1YSfMdKLNZDHWLLrWHQmsu0RUwnbnkm1HQjhltOODVfISbDmtraotvmhGOIWCfDmm5JazjyJQDiqyRRPhVAQoNwYmZs4kd9aNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Utd78SGz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933046; x=1738469046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=z1W8+46dFSMzS7P+ODJHug2hSnG5Nh7Cru/GHZYPbV8=;
  b=Utd78SGzVZLPDE6/3vkRaH+wii6D0kyU3gJqtSaS9NViZ+Y565/ElL7l
   pgWj+Eca71nJrjJV+t5WQBN4/JjZM/t+wN625ibVbXW4nuGgKbYlHp/6l
   FIQEDcZ1+XKEUNqpq15e0kztn5c2ZJJkVjXlbI7ns1ymE3HDuh3/bNpel
   qEKa/FEdJ9VdnpG5fE4dwpWr9f7anjjWWn5Bx50yY/LGW70llL162N3GB
   XkuXPsRte+ULIOorSrAfLdc930HAre73Qv2/TgWYySLF/JtxAiqdaS/bq
   AWB+ZaX0fDLjnsAoaMLSE6DW5dzZv8kI+SkBV1ujyapKP/QoACmg3iptI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181415"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181415"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382506"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382506"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:03 -0800
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
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 2/9] thermal: intel: hfi: Introduce the hfi_table structure
Date: Fri,  2 Feb 2024 20:05:08 -0800
Message-Id: <20240203040515.23947-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Zhao Liu <zhao1.liu@intel.com>

The virtualization of HFI requires to parse the HFI table of the host
system. Instead of exposing several pointers to the various section of the
table, create a single data structure that describes the table and can be
shared more cleanly.

A separate data structure that represents an HFI table improves readability
as it makes it clear that the table is one of several attributes of an HFI
instance.

No functional changes.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 47 ++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 9aaca74bdfa3..eeabdf072efd 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -97,12 +97,25 @@ struct hfi_hdr {
 } __packed;
 
 /**
- * struct hfi_instance - Representation of an HFI instance (i.e., a table)
- * @local_table:	Base of the local copy of the HFI table
+ * struct hfi_table - Representation of an HFI table
+ * @base_addr:		Base address of the local copy of the HFI table
  * @timestamp:		Timestamp of the last update of the local table.
  *			Located at the base of the local table.
  * @hdr:		Base address of the header of the local table
  * @data:		Base address of the data of the local table
+ */
+struct hfi_table {
+	union {
+		void			*base_addr;
+		u64			*timestamp;
+	};
+	void			*hdr;
+	void			*data;
+};
+
+/**
+ * struct hfi_instance - Representation of an HFI instance (i.e., a table)
+ * @local_table:	Local copy of HFI table for this instance
  * @cpus:		CPUs represented in this HFI table instance
  * @hw_table:		Pointer to the HFI table of this instance
  * @update_work:	Delayed work to process HFI updates
@@ -112,12 +125,7 @@ struct hfi_hdr {
  * A set of parameters to parse and navigate a specific HFI table.
  */
 struct hfi_instance {
-	union {
-		void			*local_table;
-		u64			*timestamp;
-	};
-	void			*hdr;
-	void			*data;
+	struct hfi_table	local_table;
 	cpumask_var_t		cpus;
 	void			*hw_table;
 	struct delayed_work	update_work;
@@ -175,7 +183,7 @@ static void get_hfi_caps(struct hfi_instance *hfi_instance,
 		s16 index;
 
 		index = per_cpu(hfi_cpu_info, cpu).index;
-		caps = hfi_instance->data + index * hfi_features.cpu_stride;
+		caps = hfi_instance->local_table.data + index * hfi_features.cpu_stride;
 		cpu_caps[i].cpu = cpu;
 
 		/*
@@ -292,7 +300,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	 * where a lagging CPU entered the locked region.
 	 */
 	new_timestamp = *(u64 *)hfi_instance->hw_table;
-	if (*hfi_instance->timestamp == new_timestamp) {
+	if (*hfi_instance->local_table.timestamp == new_timestamp) {
 		thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
 		raw_spin_unlock(&hfi_instance->event_lock);
 		return;
@@ -304,7 +312,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	 * Copy the updated table into our local copy. This includes the new
 	 * timestamp.
 	 */
-	memcpy(hfi_instance->local_table, hfi_instance->hw_table,
+	memcpy(hfi_instance->local_table.base_addr, hfi_instance->hw_table,
 	       hfi_features.nr_table_pages << PAGE_SHIFT);
 
 	/*
@@ -339,11 +347,12 @@ static void init_hfi_cpu_index(struct hfi_cpu_info *info)
 static void init_hfi_instance(struct hfi_instance *hfi_instance)
 {
 	/* The HFI header is below the time-stamp. */
-	hfi_instance->hdr = hfi_instance->local_table +
-			    sizeof(*hfi_instance->timestamp);
+	hfi_instance->local_table.hdr = hfi_instance->local_table.base_addr +
+					sizeof(*hfi_instance->local_table.timestamp);
 
 	/* The HFI data starts below the header. */
-	hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
+	hfi_instance->local_table.data = hfi_instance->local_table.hdr +
+					 hfi_features.hdr_size;
 }
 
 /* Caller must hold hfi_instance_lock. */
@@ -439,7 +448,7 @@ void intel_hfi_online(unsigned int cpu)
 	 * if needed.
 	 */
 	mutex_lock(&hfi_instance_lock);
-	if (hfi_instance->hdr)
+	if (hfi_instance->local_table.hdr)
 		goto enable;
 
 	/*
@@ -459,9 +468,9 @@ void intel_hfi_online(unsigned int cpu)
 	 * Allocate memory to keep a local copy of the table that
 	 * hardware generates.
 	 */
-	hfi_instance->local_table = kzalloc(hfi_features.nr_table_pages << PAGE_SHIFT,
-					    GFP_KERNEL);
-	if (!hfi_instance->local_table)
+	hfi_instance->local_table.base_addr = kzalloc(hfi_features.nr_table_pages << PAGE_SHIFT,
+						      GFP_KERNEL);
+	if (!hfi_instance->local_table.base_addr)
 		goto free_hw_table;
 
 	init_hfi_instance(hfi_instance);
@@ -512,7 +521,7 @@ void intel_hfi_offline(unsigned int cpu)
 	if (!hfi_instance)
 		return;
 
-	if (!hfi_instance->hdr)
+	if (!hfi_instance->local_table.hdr)
 		return;
 
 	mutex_lock(&hfi_instance_lock);
-- 
2.25.1


