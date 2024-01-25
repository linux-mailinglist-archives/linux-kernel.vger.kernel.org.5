Return-Path: <linux-kernel+bounces-38162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E283BBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711B32869D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD6E18B04;
	Thu, 25 Jan 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFObJbco"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6A1798A;
	Thu, 25 Jan 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171006; cv=none; b=PHIeHK3qgH5mc+KJKi7PBLxPMJ73A9MgRyY224louFfijX0NPfnOxTNqDtiOcN33P6FXPNJrHcoO/ocOv/AT2bLDIEBtSrF0JX7WLeyAXXzNE7uDTuX/KXXEN6vjoTF36/cW2vstIADK+fnh8uC3c4lY6CyA1qf3a2cim8l6U5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171006; c=relaxed/simple;
	bh=tDVjAd0aOw9tS20OeAHfcgi7HCiP4MDtxaMa6rF0AB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lr1M2aq+j8rBhxSfwgFIFmlzS/Zlwf4ih6XAMdnnmEdmSfS+KXEKYOCNJM78t/SnuAgnitGnTkRzZKuflN3TF6jIVNHyiZAY0P+6sJvJIfkt8kxNJZ1GWIkTnLRrTKsRJQHMRvc/wowLw+M5fpTxGPy+t/V0pTzf3JYjeDtRvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFObJbco; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706171005; x=1737707005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDVjAd0aOw9tS20OeAHfcgi7HCiP4MDtxaMa6rF0AB4=;
  b=QFObJbco1u9KkAbb/DJDLmjXbf4GhIQ1l1BKHvdSdGhHzAFGmpdsyiNM
   I7k3f8vpK9hGSj2X65ue76+RFTvZsUgpSoDHXre2AJ7W/QqKuM3/rPeDy
   /ktK0t9Zb/VeUr/bxmO2/H1S2RJbB6GNTTW/bf9oPfVmJHxYz4Dju27Dy
   uLyEnnilJXH09zxefhdnqDIeUMcnqs+9baFWpdL6d8kH3NRFHxuMYqxAm
   V1fe9H5XDY5WwfwujiuyGUXFiBrliHBkOQOEqQ4tX1L1DY33DnZED0ory
   Z38iFsSn42lH9ghoOkby6TAIPQuvJtspbTNVKOl+t+TCpHnnrwwxkyT47
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1987174"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1987174"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="876975926"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="876975926"
Received: from araj-ucode.jf.intel.com ([10.23.0.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:22 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	markgross@kernel.org
Cc: Jithu Joseph <jithu.joseph@intel.com>,
	rostedt@goodmis.org,
	ashok.raj@intel.com,
	tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	patches@lists.linux.dev,
	pengfei.xu@intel.com
Subject: [PATCH 2/5] platform/x86/intel/ifs: Trace on all HT threads when executing a test
Date: Thu, 25 Jan 2024 00:22:51 -0800
Message-Id: <20240125082254.424859-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125082254.424859-1-ashok.raj@intel.com>
References: <20240125082254.424859-1-ashok.raj@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the trace function on all HT threads.  Currently, the trace is
called from some arbitrary CPU where the test was invoked.

This change gives visibility to the exact errors as seen by each
participating HT threads, and not just what was seen from the primary
thread.

Sample output below.

#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
     migration/0-18      [000] d..1. 527287.084668: start: 0000, stop: 007f, status: 0000000000007f80
   migration/128-785     [128] d..1. 527287.084669: start: 0000, stop: 007f, status: 0000000000007f80

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/intel_ifs.h         |  9 ++---
 drivers/platform/x86/intel/ifs/runtest.c | 46 +++++++++++++++++-------
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index af0af3f1d9b7..8462dfb7a020 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -10,26 +10,23 @@
 
 TRACE_EVENT(ifs_status,
 
-	TP_PROTO(int cpu, int start, int stop, u64 status),
+	TP_PROTO(int start, int stop, u64 status),
 
-	TP_ARGS(cpu, start, stop, status),
+	TP_ARGS(start, stop, status),
 
 	TP_STRUCT__entry(
 		__field(	u64,	status	)
-		__field(	int,	cpu	)
 		__field(	u16,	start	)
 		__field(	u16,	stop	)
 	),
 
 	TP_fast_assign(
-		__entry->cpu	= cpu;
 		__entry->start	= start;
 		__entry->stop	= stop;
 		__entry->status	= status;
 	),
 
-	TP_printk("cpu: %d, start: %.4x, stop: %.4x, status: %.16llx",
-		__entry->cpu,
+	TP_printk("start: %.4x, stop: %.4x, status: %.16llx",
 		__entry->start,
 		__entry->stop,
 		__entry->status)
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 13ecd55c6668..c8352ffb9195 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -23,6 +23,12 @@
 /* Max retries on the same chunk */
 #define MAX_IFS_RETRIES  5
 
+struct run_params {
+	struct ifs_data *ifsd;
+	union ifs_scan *activate;
+	union ifs_status status;
+};
+
 /*
  * Number of TSC cycles that a logical CPU will wait for the other
  * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
@@ -140,10 +146,22 @@ static bool can_restart(union ifs_status status)
  */
 static int doscan(void *data)
 {
-	int cpu = smp_processor_id();
-	u64 *msrs = data;
+	int cpu = smp_processor_id(), start, stop;
+	struct run_params *params = data;
+	union ifs_status status;
+	struct ifs_data *ifsd;
 	int first;
 
+	ifsd = params->ifsd;
+
+	if (ifsd->generation) {
+		start = params->activate->gen2.start;
+		stop = params->activate->gen2.stop;
+	} else {
+		start = params->activate->gen0.start;
+		stop = params->activate->gen0.stop;
+	}
+
 	/* Only the first logical CPU on a core reports result */
 	first = cpumask_first(cpu_smt_mask(cpu));
 
@@ -155,12 +173,14 @@ static int doscan(void *data)
 	 * take up to 200 milliseconds (in the case where all chunks
 	 * are processed in a single pass) before it retires.
 	 */
-	wrmsrl(MSR_ACTIVATE_SCAN, msrs[0]);
+	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
+	rdmsrl(MSR_SCAN_STATUS, status.data);
 
-	if (cpu == first) {
-		/* Pass back the result of the scan */
-		rdmsrl(MSR_SCAN_STATUS, msrs[1]);
-	}
+	trace_ifs_status(start, stop, status.data);
+
+	/* Pass back the result of the scan */
+	if (cpu == first)
+		params->status = status;
 
 	return 0;
 }
@@ -179,7 +199,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 	struct ifs_data *ifsd;
 	int to_start, to_stop;
 	int status_chunk;
-	u64 msrvals[2];
+	struct run_params params;
 	int retries;
 
 	ifsd = ifs_get_data(dev);
@@ -190,6 +210,8 @@ static void ifs_test_core(int cpu, struct device *dev)
 	to_start = 0;
 	to_stop = ifsd->valid_chunks - 1;
 
+	params.ifsd = ifs_get_data(dev);
+
 	if (ifsd->generation) {
 		activate.gen2.start = to_start;
 		activate.gen2.stop = to_stop;
@@ -207,12 +229,10 @@ static void ifs_test_core(int cpu, struct device *dev)
 			break;
 		}
 
-		msrvals[0] = activate.data;
-		stop_core_cpuslocked(cpu, doscan, msrvals);
-
-		status.data = msrvals[1];
+		params.activate = &activate;
+		stop_core_cpuslocked(cpu, doscan, &params);
 
-		trace_ifs_status(cpu, to_start, to_stop, status.data);
+		status = params.status;
 
 		/* Some cases can be retried, give up for others */
 		if (!can_restart(status))
-- 
2.39.2


