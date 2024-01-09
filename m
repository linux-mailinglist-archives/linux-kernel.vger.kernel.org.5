Return-Path: <linux-kernel+bounces-21185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2D828B74
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19C4B2135D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F43B7A9;
	Tue,  9 Jan 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7p42TT/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF803B790;
	Tue,  9 Jan 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704822569; x=1736358569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9JaBJEThfVeRad1fTNZ0HBs7xNR4uGdV5+hV83rZ1mc=;
  b=F7p42TT/2CbL/oGaROGXG5bLtV8d/bAVHUlDbQlNdjD3QsxHtACvBInd
   cjWESVlI9TZ6kyopUkXVl4Ydv1osYYC2mF6zMvMzVyHPd5XDosyjXgE8T
   6SjnH11r6whFzbKhVFRQPVMzaiQbiKWOMzkDZ1zFjrgXYnHi2M49ISAYT
   pS4R89s+acQ4YL1eC7G8MwQC2Qi4QUjVxF8qE6MYRZyiz9kuObYoSY28M
   OJI2dslZEuVe3SbGiZQhAyrMyvJYKFtouZIipNuoG6sn5IE+lQdSJE78H
   gDWAs62pFrJIiALZeaeQaU5j7xFYlgr1EO5d6oikvhhhel+x5+Tgukrul
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5631083"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5631083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 09:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="16358727"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jan 2024 09:49:10 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Update Meteor Lake hybrid scaling factor
Date: Tue,  9 Jan 2024 09:48:48 -0800
Message-Id: <20240109174848.3373231-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some Meteor Lake platforms, maximum one core turbo frequency is not
observed. During hybrid performance to frequency conversion, the maximum
frequency is 100 MHz less. This results in requesting maximum frequency
100 MHz less.

For example when the max one core turbo is 4.9 GHz:
MSR HWP_CAPABILITIES shows highest performance ratio for P-core is 0x3E.
With the current scaling factor of 78741 (1.27x for converting frequency
to performance) results in max frequency of 4.8 GHz. This results in
capping the max scaling frequency as 4.8 GHz, which is 100 MHz less than
the desired.

Add capability to define per CPU model specific scaling factor and define
scaling factor of 80000 (1.25x for converting frequency to performance for
P-cores) for Meteor Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a534a1f7f1ee..843b3409f12b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -302,7 +302,10 @@ static bool hwp_forced __read_mostly;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
-#define HYBRID_SCALING_FACTOR	78741
+#define HYBRID_SCALING_FACTOR		78741
+#define HYBRID_SCALING_FACTOR_MTL	80000
+
+static int hybrid_scaling_factor = HYBRID_SCALING_FACTOR;
 
 static inline int core_get_scaling(void)
 {
@@ -422,7 +425,7 @@ static int intel_pstate_cppc_get_scaling(int cpu)
 	 */
 	if (!ret && cppc_perf.nominal_perf && cppc_perf.nominal_freq &&
 	    cppc_perf.nominal_perf * 100 != cppc_perf.nominal_freq)
-		return HYBRID_SCALING_FACTOR;
+		return hybrid_scaling_factor;
 
 	return core_get_scaling();
 }
@@ -1968,7 +1971,7 @@ static int hwp_get_cpu_scaling(int cpu)
 	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 	/* P-cores have a smaller perf level-to-freqency scaling factor. */
 	if (cpu_type == 0x40)
-		return HYBRID_SCALING_FACTOR;
+		return hybrid_scaling_factor;
 
 	/* Use default core scaling for E-cores */
 	if (cpu_type == 0x20)
@@ -3398,6 +3401,11 @@ static const struct x86_cpu_id intel_epp_balance_perf[] = {
 	{}
 };
 
+static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
+	{}
+};
+
 static int __init intel_pstate_init(void)
 {
 	static struct cpudata **_all_cpu_data;
@@ -3488,9 +3496,16 @@ static int __init intel_pstate_init(void)
 
 	if (hwp_active) {
 		const struct x86_cpu_id *id = x86_match_cpu(intel_epp_balance_perf);
+		const struct x86_cpu_id *hybrid_id = x86_match_cpu(intel_hybrid_scaling_factor);
 
 		if (id)
 			epp_values[EPP_INDEX_BALANCE_PERFORMANCE] = id->driver_data;
+
+		if (hybrid_id) {
+			hybrid_scaling_factor = hybrid_id->driver_data;
+			pr_debug("hybrid scaling factor:%d\n", hybrid_scaling_factor);
+		}
+
 	}
 
 	mutex_lock(&intel_pstate_driver_lock);
-- 
2.43.0


