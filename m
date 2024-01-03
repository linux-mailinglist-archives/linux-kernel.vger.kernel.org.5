Return-Path: <linux-kernel+bounces-15147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6988227C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71B5B22AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165DD179A4;
	Wed,  3 Jan 2024 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="im7aiPi3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4A156E3;
	Wed,  3 Jan 2024 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704255203; x=1735791203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CMWiWQHsGMeXJZcs0I9WskDpudEecU/JyNdOptgKYhM=;
  b=im7aiPi3WLW9Pc925krT2FdwOJ6GUePucUt2vFej4lASF0CG5tWyPudI
   Ej7XAD9It1747SEyPWGdLu6fAfvOU3dDQlgGPk/ehmdiB3XmELtVRdFMD
   n1DqqC75mdNsihd6i0sgPNXW6Hi9AU+ZQHsEkzZsVtKdGJp7/6NPMqiKw
   VFKt8yGYEGPh5QfkZG9n9PgrQxPnb7FDNjl7pBEuihbQ0QV/WJ6b5VkHZ
   kqBuyJHa4lbwrVn+uHTDwazM/VfUfQWwzsWvfMrM1zFWtaA/hBUYYtWXB
   eQ0BY18W5eVWaRUnaqlPjtkyyVj6BPuM/f2qR776ch/i4Xw8RYPtie56P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463357397"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="463357397"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 20:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1026957006"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1026957006"
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
Subject: [PATCH v2 2/4] thermal: intel: hfi: Enable an HFI instance from its first online CPU
Date: Tue,  2 Jan 2024 20:14:57 -0800
Message-Id: <20240103041459.11113-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Previously, HFI instances were never disabled once enabled. A CPU in an
instance only had to check during boot whether another CPU had previously
initialized the instance and its corresponding data structure.

A subsequent changeset will add functionality to disable instances
to support hibernation. Such change will also make possible to disable an
HFI instance during runtime via CPU hotplug.

Enable an HFI instance from the first of its CPUs that comes online. This
covers the boot, CPU hotplug, and resume-from-suspend cases. It also covers
systems with one or more HFI instances (i.e., packages).

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
 * None
---
 drivers/thermal/intel/intel_hfi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 820613e293cd..713da8befd40 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -410,13 +410,12 @@ void intel_hfi_online(unsigned int cpu)
 	/*
 	 * Now check if the HFI instance of the package/die of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
-	 * do is to add @cpu to this instance's cpumask.
+	 * do is to add @cpu to this instance's cpumask and enable the instance
+	 * if needed.
 	 */
 	mutex_lock(&hfi_instance_lock);
-	if (hfi_instance->hdr) {
-		cpumask_set_cpu(cpu, hfi_instance->cpus);
-		goto unlock;
-	}
+	if (hfi_instance->hdr)
+		goto enable;
 
 	/*
 	 * Hardware is programmed with the physical address of the first page
@@ -442,10 +441,14 @@ void intel_hfi_online(unsigned int cpu)
 	raw_spin_lock_init(&hfi_instance->table_lock);
 	raw_spin_lock_init(&hfi_instance->event_lock);
 
+enable:
 	cpumask_set_cpu(cpu, hfi_instance->cpus);
 
-	hfi_set_hw_table(hfi_instance);
-	hfi_enable();
+	/* Enable this HFI instance if this is its first online CPU. */
+	if (cpumask_weight(hfi_instance->cpus) == 1) {
+		hfi_set_hw_table(hfi_instance);
+		hfi_enable();
+	}
 
 unlock:
 	mutex_unlock(&hfi_instance_lock);
-- 
2.25.1


