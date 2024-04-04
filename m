Return-Path: <linux-kernel+bounces-131567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A6898996
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767671F2C650
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DAE129E8C;
	Thu,  4 Apr 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndSaCvjO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AF12FB02
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239675; cv=none; b=nCZCkR1bbOnk7VY9vxVeEsUgAL1OHfGbrpR8+YoRgB8uWL2AML1IL+TvFxFxGjm7+IH9isFMGOs5r3z4KHRRMiARZLgxH6BQWyzynS/7N/wFdf/Ix0FzvlsD36B0wWwT2kA532DUJG2Tyb2XdhV3cVOiyOQB+8mObU6VcSbqpPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239675; c=relaxed/simple;
	bh=INMehXiNkY8h1DgCIxYeiur3SdYay6xbbigl+Wo4uiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6Q+7PRMeqcxe6KMLrTYsg3XgyE3mzeXOzzxJ02ruIZSKK4uDEM3Q4RZQ6hP++Sw2lhs1QkGIZNs9RFATcI623ngyRbBWj39iL61ELSaNJ1NWpqCuV6jDP3DalzlYWGc1/h7iRn1fsv9y9c/U0QmrDh1kz9KHwchZJy1VGmsIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndSaCvjO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712239673; x=1743775673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INMehXiNkY8h1DgCIxYeiur3SdYay6xbbigl+Wo4uiU=;
  b=ndSaCvjOPTHAAQzydePVu08LA9auwVenIGibWcuNWD3gYMVkjrf9OjxM
   UWTjypGd4+6ndrS2mZ+7OapnJ6aaErm8XWjoFLvvOhQVJKv66KL1ed+qZ
   cEl7G0r9ICWP28nkCoHctQ3xEQEB5rI3Wog8fYnoIPa8DRAwln6c4X0IC
   CAD9I+C2NT2Z8vmK/lIMuj0/WBpF8vF82H5XLXHgRHNtQ2rPvvYj1X7CL
   OZJMgaGyYGEhPtAOY91CfYpP0M5AjE/oa0ztgbTuv3xrCGoVjNnl8Ld3J
   lqo3GEJK0/8/B9V+HKLm/4nuGr8kNPYV/OEGM/IDBIeClNo2+P6onhT6h
   g==;
X-CSE-ConnectionGUID: Px/mAs78SjW2iC1ud4IADA==
X-CSE-MsgGUID: WQ6yaaQNSzac0ZrtLP2qsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11346575"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11346575"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:07:53 -0700
X-CSE-ConnectionGUID: gps4f6BiR8OvhuSP5pkaWQ==
X-CSE-MsgGUID: Rd4uzX9vTfGHIKbXO5nOUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23258933"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 07:07:53 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 12/12] perf/x86/intel: Support RDPMC metrics clear mode
Date: Thu,  4 Apr 2024 07:06:37 -0700
Message-Id: <20240404140637.1232635-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404140637.1232635-1-kan.liang@linux.intel.com>
References: <20240404140637.1232635-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The new RDPMC enhancement, metrics clear mode, is to clear the
PERF_METRICS-related resources as well as the fixed-function performance
monitoring counter 3 after the read is performed. It is available for
ring 3. The feature is enumerated by the
IA32_PERF_CAPABILITIES.RDPMC_CLEAR_METRICS[bit 19]. To enable the
feature, the IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[bit 14] must be set.

Two ways were considered to enable the feature.
- Expose a knob in the sysfs globally. One user may affect the
  measurement of other users when changing the knob. The solution is
  dropped.
- Introduce a new event format, metrics_clear, for the slots event to
  disable/enable the feature only for the current process. Users can
  utilize the feature as needed.
The latter solution is implemented in the patch.

The current KVM doesn't support the perf metrics yet. For
virtualization, the feature can be enabled later separately.

Update the document of perf metrics.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c         | 20 +++++++++++++++++++-
 arch/x86/events/perf_event.h         |  1 +
 arch/x86/include/asm/perf_event.h    |  4 ++++
 tools/perf/Documentation/topdown.txt |  9 +++++++--
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d05a8dfc0f8e..fc32a9c0eeca 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,6 +2822,9 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 			return;
 
 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+
+		if (event->attr.config1 & INTEL_TD_CFG_METRIC_CLEAR)
+			bits |= INTEL_FIXED_3_METRICS_CLEAR;
 	}
 
 	intel_set_masks(event, idx);
@@ -4086,7 +4089,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * is used in a metrics group, it too cannot support sampling.
 	 */
 	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
-		if (event->attr.config1 || event->attr.config2)
+		/* The metrics_clear can only be set for the slots event */
+		if (event->attr.config1 &&
+		    (!is_slots_event(event) || (event->attr.config1 & ~INTEL_TD_CFG_METRIC_CLEAR)))
+			return -EINVAL;
+
+		if (event->attr.config2)
 			return -EINVAL;
 
 		/*
@@ -4673,6 +4681,8 @@ PMU_FORMAT_ATTR(in_tx,  "config:32"	);
 PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
 PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
 
+PMU_FORMAT_ATTR(metrics_clear,	"config1:0"); /* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+
 static ssize_t umask2_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *page)
@@ -4692,6 +4702,7 @@ static struct device_attribute format_attr_umask2  =
 static struct attribute *format_evtsel_ext_attrs[] = {
 	&format_attr_umask2.attr,
 	&format_attr_eq.attr,
+	&format_attr_metrics_clear.attr,
 	NULL
 };
 
@@ -4719,6 +4730,13 @@ evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	if (i == 1)
 		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
 
+	/* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+	if (i == 2) {
+		union perf_capabilities intel_cap = hybrid(dev_get_drvdata(dev), intel_cap);
+
+		return intel_cap.rdpmc_metrics_clear ? attr->mode : 0;
+	}
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 51d934d49585..0d4d3c2259ba 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -624,6 +624,7 @@ union perf_capabilities {
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
 		u64	anythread_deprecated:1;
+		u64	rdpmc_metrics_clear:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 6465cee82c9f..573adabf086d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -41,6 +41,7 @@
 #define INTEL_FIXED_0_USER				(1ULL << 1)
 #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
 #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+#define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
 
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
@@ -378,6 +379,9 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
 #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
 #define INTEL_TD_METRIC_NUM			8
 
+#define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
+#define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
+
 static inline bool is_metric_idx(int idx)
 {
 	return (unsigned)(idx - INTEL_PMC_IDX_METRIC_BASE) < INTEL_TD_METRIC_NUM;
diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index ae0aee86844f..f36c8ca1dc53 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -280,8 +280,13 @@ with no longer interval than a few seconds
 
 	perf stat -I 1000 --topdown ...
 
-For user programs using RDPMC directly the counter can
-be reset explicitly using ioctl:
+Starting from the Lunar Lake p-core, a RDPMC metrics clear mode is
+introduced. The metrics and the fixed counter 3 are automatically
+cleared after the read is performed. It is recommended to always enable
+the mode. To enable the mode, the config1 of slots event is set to 1.
+
+On the previous platforms, for user programs using RDPMC directly, the
+counter has to be reset explicitly using ioctl:
 
 	ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);
 
-- 
2.35.1


