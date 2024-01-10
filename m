Return-Path: <linux-kernel+bounces-21671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C7982929F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C062894A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B59428E8;
	Wed, 10 Jan 2024 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ko93EGdJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727A1871;
	Wed, 10 Jan 2024 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704855930; x=1736391930;
  h=from:to:cc:subject:date:message-id;
  bh=pHu+JjwxmcBrvbDLReMh07daUmBXGKOvaUBLbr2Vdns=;
  b=ko93EGdJE30AdGTe4KRDlnSCg0qfxOc/skxgkFlPUReIVbkrx7JkPGNF
   KB1nFsGPLpLutYryBBNTnOHOon997mzwqTpZlDUJEhMPd9n+2t95dtWn2
   lNnF2cIn3JAbbVCA3LWQEe+5OvSPG4bHy9lVPzVbhMQ6JxvFl7sVmWn2V
   XlBJuFFNxfrrxyvTSeOXJMqlWzw1vAfBBU3SNo9qHESum9UxmKHl4JXgp
   dv3iy0iWTVRBue95KYaAJ5j2qKZgUH1dY33zLydxC22L09Ze3SAX5CMcd
   eA3r0vjsoIaaeTWwD5T88b4yrPMEumceaECtkDJc0zILRAA+eOuph6kC1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397244704"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397244704"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 19:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1029002690"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1029002690"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2024 19:05:29 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] thermal: intel: hfi: Add syscore callbacks
Date: Tue,  9 Jan 2024 19:07:04 -0800
Message-Id: <20240110030704.11305-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kernel allocates a memory buffer and provides its location to the
hardware, which uses it to update the HFI table. This allocation occurs
during boot and remains constant throughout runtime.

When resuming from hibernation, the restore kernel allocates a second
memory buffer and reprograms the HFI hardware with the new location as part
of a normal boot. The location of the second memory buffer may differ from
the one allocated by the image kernel. When the restore kernel transfers
control to the image kernel, the second buffer becomes invalid, potentially
leading to memory corruption if the hardware writes to it (the hardware
continues using the buffer from the restore kernel).

It is also possible that the hardware forgets the address of the memory
buffer when resuming from "deep" suspend. Memory corruption may also occur
in such a scenario.

To prevent the described memory corruption, disable HFI when preparing to
suspend or hibernate. Enable it when resuming.

Add syscore callbacks to handle the package of the boot CPU (packages of
non-boot CPUs are handled via CPU offline). Syscore ops always run on the
boot CPU. Additionally, HFI only needs to be disabled during "deep" suspend
and hibernation. Syscore ops only run in these cases.

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
This is v3 of the patch [4/4] of [1]. Rafael has already accepted the
first three patches. Thanks!

I tested this patch on the testing branch of Rafael on Jan 9th. 2024. I
tested it on a Meteor Lake system. It completed 1000 hibernation-resume
cycles.

[1]. https://lore.kernel.org/all/20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com/

---
Changes since v2:
 * Switched to syscore ops instead of a suspend notifier as it is a better
   fit: we only need to handle the boot CPU, disabling HFI is only needed
   for "deep" suspend and hibernation. (Rafael)
 * Removed incorrect statement about the suspend flow in the commit
   message. (Rafael)

Changes since v1:
 * Moved registration of the suspend notifier towards the end of
   intel_hfi_init(). (Stan)
 * Renamed hfi_do_pm_[enable|disable]() to hfi_do_[enable|disable](). Stan
   will use these functions outside the suspend notifier. (Stan)
 * Added locking to calls to hfi_[enable|disable]() from the suspend
   notifier. (Rafael)
---
 drivers/thermal/intel/intel_hfi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 22445403b520..768cd5f9eb32 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -35,7 +35,9 @@
 #include <linux/processor.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/string.h>
+#include <linux/syscore_ops.h>
 #include <linux/topology.h>
 #include <linux/workqueue.h>
 
@@ -571,6 +573,30 @@ static __init int hfi_parse_features(void)
 	return 0;
 }
 
+static void hfi_do_enable(void)
+{
+	/* If we are here, we are on the boot CPU */
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, 0);
+	struct hfi_instance *hfi_instance = info->hfi_instance;
+
+	/* No locking needed. There is no concurrency with CPU online. */
+	hfi_set_hw_table(hfi_instance);
+	hfi_enable();
+}
+
+static int hfi_do_disable(void)
+{
+	/* No locking needed. There is no concurrency with CPU offline. */
+	hfi_disable();
+
+	return 0;
+}
+
+static struct syscore_ops hfi_pm_ops = {
+	.resume = hfi_do_enable,
+	.suspend = hfi_do_disable,
+};
+
 void __init intel_hfi_init(void)
 {
 	struct hfi_instance *hfi_instance;
@@ -602,6 +628,8 @@ void __init intel_hfi_init(void)
 	if (!hfi_updates_wq)
 		goto err_nomem;
 
+	register_syscore_ops(&hfi_pm_ops);
+
 	return;
 
 err_nomem:
-- 
2.25.1


