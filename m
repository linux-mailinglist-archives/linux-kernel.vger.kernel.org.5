Return-Path: <linux-kernel+bounces-49560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1C846BDA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E621F25285
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337C17555;
	Fri,  2 Feb 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YInG+27o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5957CF07;
	Fri,  2 Feb 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865735; cv=none; b=A2nmTZ9VfsJdOzNOnTh2KBPn8BLovGKeJ1iHJzsTkT1EMFR2HQUuGM0a+r1Z0orzJ7oLXVniIOZUE26vJ8t/790UjruMk4tW7u8/XM4O4wDuqbvVHBrsJ4Ryw8fC3N98igidVKICc1ru5+/aO0H1UBsCXXMRTL8KNRWBt5WR7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865735; c=relaxed/simple;
	bh=ObzYZjjPuoaArfY2LHC47nxAkH4bnA054skyvxsUans=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBG14hfcMVr5HsWlvVX7TvKo15rjZKjPM4aNUY2wKRrOEjhFqq0wnPrRB2Sd/lyQghg0mUDBLPCcQETbCsn3raxPC14/QvEBFquSw4feFocSi6j7v0j+I3oP8md+q562iMlWCjoNSutvU9p79MfR1uArJeDUD+vOKMl9xvvHgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YInG+27o; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865734; x=1738401734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ObzYZjjPuoaArfY2LHC47nxAkH4bnA054skyvxsUans=;
  b=YInG+27oeZ8h64cMaKvryMKLqYnZ6spbGhrF0Df8YtDFMZM+Bnjua9nS
   wKfBN8m8wewDdQcgZtPtFPczcWlqqaLDc1Wd2hSPpb0mS9QA6Ie/U6RLE
   pUn1L71D/S1N1cg1kD6pWGdhUL6hGKZwvBFNJk1VGxgPdluEZyNTKXztm
   BGKuSWmoG3mYdcfMdCOHF9VuaUIYLCCG428OXXnoVR53JDZSN69FqSme7
   DFxkhTfY5QWqJFGQRAunbuW+rXzzm4eA6uyfZhfnd+FTV6Dmw5quSPc4p
   p5XUSP35W5qDc+MxiNj3saqRromRVoa9SsyovsbBQb7p+ZZJ8Z2FGbtWC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483077"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483077"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639739"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:11 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/11] hwmon: (coretemp) Remove redundant pdata->cpu_map[]
Date: Fri,  2 Feb 2024 17:21:40 +0800
Message-Id: <20240202092144.71180-8-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202092144.71180-1-rui.zhang@intel.com>
References: <20240202092144.71180-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pdata->cpu_map[] saves the mapping between cpu core id and the index in
pdata->core_data[]. This is used to find the temp_data structure using
cpu_core_id, by traversing the pdata->cpu_map[] array. But the same goal
can be achieved by traversing the pdata->core_temp[] array directly.

Remove redundant pdata->cpu_map[].

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index cdd1e069d5c1..29ee8e0c0fe9 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -96,7 +96,6 @@ struct temp_data {
 struct platform_data {
 	struct device		*hwmon_dev;
 	u16			pkg_id;
-	u16			cpu_map[NUM_REAL_CORES];
 	struct ida		ida;
 	struct cpumask		cpumask;
 	struct temp_data	*core_data[MAX_CORE_DATA];
@@ -517,7 +516,6 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		if (index < 0)
 			return index;
 
-		pdata->cpu_map[index] = topology_core_id(cpu);
 		index += BASE_SYSFS_ATTR_NO;
 	}
 
@@ -696,7 +694,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	struct platform_data *pd;
 	struct temp_data *tdata;
-	int i, indx = -1, target;
+	int i, target;
 
 	/* No need to tear down any interfaces for suspend */
 	if (cpuhp_tasks_frozen)
@@ -707,18 +705,16 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	if (!pd->hwmon_dev)
 		return 0;
 
-	for (i = 0; i < NUM_REAL_CORES; i++) {
-		if (pd->cpu_map[i] == topology_core_id(cpu)) {
-			indx = i + BASE_SYSFS_ATTR_NO;
+	for (i = BASE_SYSFS_ATTR_NO; i < MAX_CORE_DATA; i++) {
+		if (pd->core_data[i] && pd->core_data[i]->cpu_core_id == topology_core_id(cpu))
 			break;
-		}
 	}
 
 	/* Too many cores and this core is not populated, just return */
-	if (indx < 0)
+	if (i == MAX_CORE_DATA)
 		return 0;
 
-	tdata = pd->core_data[indx];
+	tdata = pd->core_data[i];
 
 	cpumask_clear_cpu(cpu, &pd->cpumask);
 
@@ -729,7 +725,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 */
 	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
 	if (target >= nr_cpu_ids) {
-		coretemp_remove_core(pd, indx);
+		coretemp_remove_core(pd, i);
 	} else if (tdata && tdata->cpu == cpu) {
 		mutex_lock(&tdata->update_lock);
 		tdata->cpu = target;
-- 
2.34.1


