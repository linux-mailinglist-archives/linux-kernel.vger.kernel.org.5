Return-Path: <linux-kernel+bounces-11860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055281EC99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5E81F22D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0306563BA;
	Wed, 27 Dec 2023 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2tO3DFc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F26538D;
	Wed, 27 Dec 2023 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703658483; x=1735194483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1cYYK5ByGwjzQSWbNjPnL+R1+DM1//XjIOt7Mqw3UFE=;
  b=E2tO3DFcnLK85DXklMGcpvgRKpo8+BbpjN4dninGgTJQKC0OMPzVnn4Y
   XLXEffo89izAH16QUWjmTTlEglOpSHatN792s4kB3PlddKRWM23TXcF0z
   4Zesse4uKlnvvHuuda4Wp1BkoI4I46EDDl8FL+7lT/g3IYL/M9bwpAN+6
   ISGu9V2kxkmlzBUUk79jCum9yfaSYlpKWa+grA28+beBW9e+DPztbPFH7
   C31NHSOAjdUPgg/LVW0018EffiWoS+fivfLzjWFy74fwq3cnIAWtktqv9
   vYrPIT5O9uu3JRcjPeY118lXO9HZIKxViXAjChYhWjQiZ2JQA7ILSW5Wv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="427584073"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="427584073"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1025316085"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1025316085"
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
Subject: [PATCH 2/4] thermal: intel: hfi: Enable an HFI instance from its first online CPU
Date: Tue, 26 Dec 2023 22:29:38 -0800
Message-Id: <20231227062940.10780-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 87ac7b196981..15c8c3b841d2 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -409,13 +409,12 @@ void intel_hfi_online(unsigned int cpu)
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
@@ -445,10 +444,14 @@ void intel_hfi_online(unsigned int cpu)
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


