Return-Path: <linux-kernel+bounces-72213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF3685B0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A709B221FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6231755E47;
	Tue, 20 Feb 2024 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+IFeDQQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D54643B;
	Tue, 20 Feb 2024 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395986; cv=none; b=t0iIFh1JTdJjFdJ+Rp9G8MoVF5smMTCP6UKq1zO4rhpUEpautuq+iF8ptN36kAOLHFQTdbHIy3UbuOkt9ELtnKf1ddeLyCneGLdTPywfqCamMjwoLeOAKBXwL3N1Y+5Yyh5ZxMMk50AWHdgYCkCBNsDBlv2j4Fj9kE8yAMhlFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395986; c=relaxed/simple;
	bh=Bme66kQZn5iFnqrDzIxlPq1Wo0zL52KG3q8PFROn4IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QitWMhcRJDKtsrPq4XTTNCqU9y6uaHhnxaa3Fs2IlR+2eAwDGQR+Vo4/qopA587BvpAyuLggYtygUox987kVz7TlfGmKQ81secKgfKI/yQI+K2S22RVbG6JwnZnRryU4qlqxA77GKON/vwPOqoh9kVe755EV7WYI8oo/WW6htgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+IFeDQQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708395985; x=1739931985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bme66kQZn5iFnqrDzIxlPq1Wo0zL52KG3q8PFROn4IQ=;
  b=O+IFeDQQziqyA1amwp7bfzdH7cgk7cTrFX2kSAoVmntG8fL/t8ss+386
   wyFXasihSR+iFdH7NF9dSHh3hlQEz2OABgwZjCXskUkzWlmPbWBcT+YRG
   5SUQifhKdLmfRZhTEgmjsQZEFCsrKO3G2Rjzk5IT+xaZ6x60XBb1X8jsg
   /3lLZNu/VHvp533WrLAsy6zDesWV6YqCsVXBAFZNV9hj8/zOJFVzE70e7
   LcNSNJ65M00ls7pPQsFIKzNYwGcLJUF12sOqVeaJwABKH5my96JhKta1G
   e1/MYWvYOf7nTzLSzOqNx05yAMDWgCguMAA4Ymhq5rDxv/SmXYeEA85yc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2357354"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2357354"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 18:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4538215"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa007.fm.intel.com with ESMTP; 19 Feb 2024 18:26:22 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Allow model specific EPPs
Date: Mon, 19 Feb 2024 18:26:06 -0800
Message-Id: <20240220022607.485129-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240220022607.485129-1-srinivas.pandruvada@linux.intel.com>
References: <20240220022607.485129-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation allows model specific EPP override for
balanced_performance. Add feature to allow model specific EPP for all
predefined EPP strings. For example for some CPU models, even changing
performance EPP has benefits

Use a mask of EPPs as driver_data instead of just balanced_performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 41 +++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ca94e60e705a..9a11228dd871 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -25,6 +25,7 @@
 #include <linux/acpi.h>
 #include <linux/vmalloc.h>
 #include <linux/pm_qos.h>
+#include <linux/bitfield.h>
 #include <trace/events/power.h>
 
 #include <asm/cpu.h>
@@ -3404,14 +3405,29 @@ static bool intel_pstate_hwp_is_enabled(void)
 	return !!(value & 0x1);
 }
 
-static const struct x86_cpu_id intel_epp_balance_perf[] = {
+#define POWERSAVE_MASK			GENMASK(7, 0)
+#define BALANCE_POWER_MASK		GENMASK(15, 8)
+#define BALANCE_PERFORMANCE_MASK	GENMASK(23, 16)
+#define PERFORMANCE_MASK		GENMASK(31, 24)
+
+#define HWP_SET_EPP_VALUES(powersave, balance_power, balance_perf, performance) \
+	(FIELD_PREP_CONST(POWERSAVE_MASK, powersave) |\
+	 FIELD_PREP_CONST(BALANCE_POWER_MASK, balance_power) |\
+	 FIELD_PREP_CONST(BALANCE_PERFORMANCE_MASK, balance_perf) |\
+	 FIELD_PREP_CONST(PERFORMANCE_MASK, performance))
+
+#define HWP_SET_DEF_BALANCE_PERF_EPP(balance_perf) \
+	(HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE, HWP_EPP_BALANCE_POWERSAVE,\
+	 balance_perf, HWP_EPP_PERFORMANCE))
+
+static const struct x86_cpu_id intel_epp_default[] = {
 	/*
 	 * Set EPP value as 102, this is the max suggested EPP
 	 * which can result in one core turbo frequency for
 	 * AlderLake Mobile CPUs.
 	 */
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 102),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 32),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
 	{}
 };
 
@@ -3509,11 +3525,24 @@ static int __init intel_pstate_init(void)
 	intel_pstate_sysfs_expose_params();
 
 	if (hwp_active) {
-		const struct x86_cpu_id *id = x86_match_cpu(intel_epp_balance_perf);
+		const struct x86_cpu_id *id = x86_match_cpu(intel_epp_default);
 		const struct x86_cpu_id *hybrid_id = x86_match_cpu(intel_hybrid_scaling_factor);
 
-		if (id)
-			epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = id->driver_data;
+		if (id) {
+			epp_values[EPP_INDEX_POWERSAVE] =
+					FIELD_GET(POWERSAVE_MASK, id->driver_data);
+			epp_values[EPP_INDEX_BALANCE_POWERSAVE] =
+					FIELD_GET(BALANCE_POWER_MASK, id->driver_data);
+			epp_values[EPP_INDEX_BALANCE_PERFORMANCE] =
+					FIELD_GET(BALANCE_PERFORMANCE_MASK, id->driver_data);
+			epp_values[EPP_INDEX_PERFORMANCE] =
+					FIELD_GET(PERFORMANCE_MASK, id->driver_data);
+			pr_debug("Updated EPPs powersave:%x balanced power:%x balanced perf:%x performance:%x\n",
+				 epp_values[EPP_INDEX_POWERSAVE],
+				 epp_values[EPP_INDEX_BALANCE_POWERSAVE],
+				 epp_values[EPP_INDEX_BALANCE_PERFORMANCE],
+				 epp_values[EPP_INDEX_PERFORMANCE]);
+		}
 
 		if (hybrid_id) {
 			hybrid_scaling_factor = hybrid_id->driver_data;
-- 
2.43.0


