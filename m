Return-Path: <linux-kernel+bounces-15149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89228227C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A9C1C21A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1D18049;
	Wed,  3 Jan 2024 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXms+410"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B11774E;
	Wed,  3 Jan 2024 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704255205; x=1735791205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HGzNCG5g7llZWM6V7G5bX9v6oQIYTajXgZNc9d2qMM4=;
  b=cXms+410UF1oo/eQEHOqLsd7IDeqDIgkzP0edTUDPnq3+wLrtk6fKnmV
   sHagjRq/fld5WDKoZhDCeN2nUZcVInKKip9E4hol8xnxncEf8796HTC90
   /cYTvXeJndFzwD+mEP7J4t/GQVt2n0uAry4YyUcYFSKDPhZUTEJvovgcc
   NlZCkriGWxjfXApC7iGxwlkqdvzH0mrx7x9ZdMiHhEXkI3LMdjgflV0Ol
   u2L5SCks5eoz5YgdDc031tS9i6FhfEX7g+ldF4yLvKhz5ESGXX8zeCPdh
   Z+sKrP5Hb9xQmdCtdlu61/bwL14OilYwtnuWmUbySS9Fk8tPaOn50bZ6C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463357399"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="463357399"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 20:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1026957015"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="1026957015"
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
Subject: [PATCH v2 4/4] thermal: intel: hfi: Add a suspend notifier
Date: Tue,  2 Jan 2024 20:14:59 -0800
Message-Id: <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kernel gives the HFI hardware a memory region that the latter uses to
provide updates to the HFI table. The kernel allocates this memory region
at boot. It remains constant throughout runtime time.

When resuming from suspend or hibernation, the restore kernel allocates a
second memory buffer and reprograms the HFI hardware with the new location
as part of a normal boot. The location of the second memory buffer may
differ from the one allocated by the image kernel. Subsequently, when the
restore kernel transfers control to the image kernel, the second buffer
becomes invalid, potentially leading to memory corruption if the hardware
writes to it (hardware continues using the buffer from the restore kernel).

Add a suspend notifier to disable all HFI instances before jumping to the
image kernel and enable them once the image kernel has been restored. Use
the memory buffer that the image kernel allocated.

For non-boot CPUs, rely on the CPU hotplug callbacks as CPUs are disabled
and enabled during suspend and resume, respectively.

The CPU hotplug callbacks do not cover the boot CPU. Handle the HFI
instance of the boot CPU from the suspend notifier callback.

Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org    # 6.1
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
--
Changes since v1:
 * Moved registration of the suspend notifier towards the end of
   intel_hfi_init(). (Stan)
 * Renamed hfi_do_pm_[enable|disable]() to hfi_do_[enable|disable](). Stan
   will use these functions outside the suspend notifier. (Stan)
 * Added locking to calls to hfi_[enable|disable]() from the suspend
   notifier. (Rafael)
---
 drivers/thermal/intel/intel_hfi.c | 62 +++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 22445403b520..8d6e4f8dc67a 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -30,11 +30,13 @@
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/processor.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/string.h>
 #include <linux/topology.h>
 #include <linux/workqueue.h>
@@ -571,6 +573,60 @@ static __init int hfi_parse_features(void)
 	return 0;
 }
 
+static void hfi_do_enable(void *info)
+{
+	struct hfi_instance *hfi_instance = info;
+
+	hfi_set_hw_table(hfi_instance);
+	hfi_enable();
+}
+
+static void hfi_do_disable(void *info)
+{
+	hfi_disable();
+}
+
+static int hfi_pm_notify(struct notifier_block *nb,
+			 unsigned long mode, void *unused)
+{
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
+	struct hfi_instance *hfi = info->hfi_instance;
+	int ret = 0;
+
+	/* HFI may not be in use. */
+	if (!hfi)
+		return ret;
+
+	mutex_lock(&hfi_instance_lock);
+	/*
+	 * Only handle the HFI instance of the package of the boot CPU. The
+	 * instances of other packages are handled in the CPU hotplug callbacks.
+	 */
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		ret = smp_call_function_single(0, hfi_do_disable, NULL, true);
+		break;
+
+	case PM_POST_RESTORE:
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		ret = smp_call_function_single(0, hfi_do_enable, hfi, true);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_unlock(&hfi_instance_lock);
+
+	return ret;
+}
+
+static struct notifier_block hfi_pm_nb = {
+	.notifier_call = hfi_pm_notify,
+};
+
 void __init intel_hfi_init(void)
 {
 	struct hfi_instance *hfi_instance;
@@ -602,8 +658,14 @@ void __init intel_hfi_init(void)
 	if (!hfi_updates_wq)
 		goto err_nomem;
 
+	if (register_pm_notifier(&hfi_pm_nb))
+		goto err_pm_notif;
+
 	return;
 
+err_pm_notif:
+	destroy_workqueue(hfi_updates_wq);
+
 err_nomem:
 	for (j = 0; j < i; ++j) {
 		hfi_instance = &hfi_instances[j];
-- 
2.25.1


