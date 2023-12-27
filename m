Return-Path: <linux-kernel+bounces-11862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4DD81ECA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B571F1F22D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495B7483;
	Wed, 27 Dec 2023 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUqWbrR7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A75C9C;
	Wed, 27 Dec 2023 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703658485; x=1735194485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Opg1f7F6WAG9qwnC6IpMUubGNjOktSJX+l64W9VgPXc=;
  b=gUqWbrR7gnU2G+7RQjoklWd44Nrd6mn2wYPmwyEnpe8e60kH27FXLASk
   gN9bnKPkXRhsoEWBjScjwdJBiLb4w8RUcQD5xxlidU1YtfEe8bGxNWqe5
   LtZm+uOZT09XNlc3n/+7fSWrOHHWKYVHBMaXbN6UFzbmlyJbH9AgVEF6w
   71gSpo+0XwStEF+Oe95E4FNaSKPh5z1iHLn8/Miy9eORFpI6p5pu5Wr2m
   qrxB8uixe8lm1eL/ZqmIAhi2N8FIoUK5OUmWWqJ3aAW9vIhF6jx17Fody
   /Ds5IXde49p0NhZL7bNJtRhWFwipH36tf3bC8WH9usH8vP+0LZjZiGXnw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="427584075"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="427584075"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 22:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="1025316091"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1025316091"
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
Subject: [PATCH 4/4] thermal: intel: hfi: Add a suspend notifier
Date: Tue, 26 Dec 2023 22:29:40 -0800
Message-Id: <20231227062940.10780-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index d2c874f43786..965c245e5e78 100644
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
@@ -569,11 +571,62 @@ static __init int hfi_parse_features(void)
 	return 0;
 }
 
+static void hfi_do_pm_enable(void *info)
+{
+	struct hfi_instance *hfi_instance = info;
+
+	hfi_set_hw_table(hfi_instance);
+	hfi_enable();
+}
+
+static void hfi_do_pm_disable(void *info)
+{
+	hfi_disable();
+}
+
+static int hfi_pm_notify(struct notifier_block *nb,
+			 unsigned long mode, void *unused)
+{
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
+	struct hfi_instance *hfi_instance = info->hfi_instance;
+
+	/* HFI may not be in use. */
+	if (!hfi_instance)
+		return 0;
+
+	/*
+	 * Only handle the HFI instance of the package of the boot CPU. The
+	 * instances of other packages are handled in the CPU hotplug callbacks.
+	 */
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		return smp_call_function_single(0, hfi_do_pm_disable,
+						NULL, true);
+
+	case PM_POST_RESTORE:
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+		return smp_call_function_single(0, hfi_do_pm_enable,
+						hfi_instance, true);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct notifier_block hfi_pm_nb = {
+	.notifier_call = hfi_pm_notify,
+};
+
 void __init intel_hfi_init(void)
 {
 	struct hfi_instance *hfi_instance;
 	int i, j;
 
+	if (register_pm_notifier(&hfi_pm_nb))
+		return;
+
 	if (hfi_parse_features())
 		return;
 
-- 
2.25.1


