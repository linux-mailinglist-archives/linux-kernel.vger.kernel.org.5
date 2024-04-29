Return-Path: <linux-kernel+bounces-163152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B98B6665
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F4B1F22B43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9BE1A0AF5;
	Mon, 29 Apr 2024 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7ygC37/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5F19DF4B;
	Mon, 29 Apr 2024 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433715; cv=none; b=eCHWNfnrwSeXrzMm+eBjpyZlYqBMeJA9kRJSxUXEZHu2qQA5hOvX3D5UOmbLhd4hFzp75w135I32oOKaLhFfN8gScYb7JSl5nshRb9hYA16xCKobbMTspL5LmikZt3Q1uspu+5MbtyKJLOopvDOvsyLnSoQhYKIEY1htWrWiuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433715; c=relaxed/simple;
	bh=J/IFFBDpfs1UKr0DRJtcmxEW5FMJCuZ1wc9KBNX67UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KH4CUxxzEceHJtCCDmMPAOd2JukJfmMaQ/WFXJt1UjSkJFmhSlJ2Bbc3qHqBncFDNoyY/x1zAJWs29MI84PAUzSP8YxjD78B8pi1SOwMZ9XuMQy7jlq4XPosAtbZiwVxPXa0++54J5f1Q4jEfkp/BW5kYdojn6nPBj3k4Yw7nIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7ygC37/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433714; x=1745969714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=J/IFFBDpfs1UKr0DRJtcmxEW5FMJCuZ1wc9KBNX67UI=;
  b=h7ygC37/WuIdzbvwscH8/EkeHjbTVHni+PEYxXUsQVAF2ntbzhrcaVeZ
   2ETcNmtiSc6/CFAITJGHV39/DjEpk6JwWtp7E7eP9KCP8LwwY0gwIsqVS
   8cbbMc6XYPA+aSYxQNqC4l0N7Vdsohg7ZLMZGjUsqiJpViudSLVxv9wvP
   GQ2K45BfC6+viFzInHyZaSGMsMXrIh9rifqZC+U7UEcKuiA/mu29i5Ptd
   xCvh0R755a4iq3HxmVRo3lrd0EyAcO3uWyyNYGk/jKpCfNIurUYsBoBTd
   DTJNsbD87NALmPIMRpbzHTBRDe4QLFwVnTt5owHmtoJWKm/yOuDfkEelL
   A==;
X-CSE-ConnectionGUID: a0JxQcpfQzabiSPqvUSkjA==
X-CSE-MsgGUID: 66JydA49QGWhC9yiVQQ5Jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10274513"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10274513"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:35:09 -0700
X-CSE-ConnectionGUID: AzDskLe8T3eZte+HLZbnTA==
X-CSE-MsgGUID: cw+k+tOsS7Cu1RywwhMU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26200142"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 16:35:09 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 4/4] thermal: intel: hfi: Tune the number of CPU capabilities per netlink event
Date: Mon, 29 Apr 2024 16:41:52 -0700
Message-Id: <20240429234152.16230-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The number of updated CPU capabilities per netlink event is hard-coded to
16. On systems with more than 16 it takes more than one thermal netlink
event to relay all the new capabilities when processing an HFI interrupt.
This adds unnecessary overhead.

Make the number of updated capabilities per event tuneable via debugfs.
Users can then experiment with different values.

We already take the hfi_instance_lock when submitting thermal netlink
updates. Use it to serialize debugfs accesses to hfi_therm_notify_count.

Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/intel/intel_hfi.c | 34 ++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index d6d3544509fc..d5163b9766c0 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -175,6 +175,7 @@ static struct workqueue_struct *hfi_updates_wq;
 
 /* Keep this variable 8-byte aligned to get atomic accesses. */
 static unsigned long hfi_update_delay = HFI_UPDATE_DELAY;
+static int hfi_thermnl_caps_per_event = HFI_THERMNL_CAPS_PER_EVENT;
 
 #ifdef CONFIG_DEBUG_FS
 static int hfi_update_delay_get(void *data, u64 *val)
@@ -205,6 +206,25 @@ static int hfi_update_delay_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hfi_update_delay_fops, hfi_update_delay_get,
 			 hfi_update_delay_set, "%llu\n");
 
+static int hfi_thermnl_caps_per_event_get(void *data, u64 *val)
+{
+	mutex_lock(&hfi_instance_lock);
+	*val = hfi_thermnl_caps_per_event;
+	mutex_unlock(&hfi_instance_lock);
+	return 0;
+}
+
+static int hfi_thermnl_caps_per_event_set(void *data, u64 val)
+{
+	mutex_lock(&hfi_instance_lock);
+	hfi_thermnl_caps_per_event = val;
+	mutex_unlock(&hfi_instance_lock);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hfi_thermnl_caps_per_event_fops,
+			 hfi_thermnl_caps_per_event_get,
+			 hfi_thermnl_caps_per_event_set, "%llu\n");
 static struct dentry *hfi_debugfs_dir;
 
 static void hfi_debugfs_unregister(void)
@@ -226,6 +246,11 @@ static void hfi_debugfs_register(void)
 	if (!f)
 		goto err;
 
+	f = debugfs_create_file("thermnl_caps_per_event", 0644, hfi_debugfs_dir,
+				NULL, &hfi_thermnl_caps_per_event_fops);
+	if (!f)
+		goto err;
+
 	return;
 err:
 	hfi_debugfs_unregister();
@@ -286,16 +311,15 @@ static void update_capabilities(struct hfi_instance *hfi_instance)
 
 	get_hfi_caps(hfi_instance, cpu_caps);
 
-	if (cpu_count < HFI_THERMNL_CAPS_PER_EVENT)
+	if (cpu_count < hfi_thermnl_caps_per_event)
 		goto last_cmd;
 
 	/* Process complete chunks of HFI_THERMNL_CAPS_PER_EVENT capabilities. */
 	for (i = 0;
-	     (i + HFI_THERMNL_CAPS_PER_EVENT) <= cpu_count;
-	     i += HFI_THERMNL_CAPS_PER_EVENT)
-		thermal_genl_cpu_capability_event(HFI_THERMNL_CAPS_PER_EVENT,
+	     (i + hfi_thermnl_caps_per_event) <= cpu_count;
+	     i += hfi_thermnl_caps_per_event)
+		thermal_genl_cpu_capability_event(hfi_thermnl_caps_per_event,
 						  &cpu_caps[i]);
-
 	cpu_count = cpu_count - i;
 
 last_cmd:
-- 
2.34.1


