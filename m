Return-Path: <linux-kernel+bounces-5443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39393818AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E7B1C24351
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFCB1C691;
	Tue, 19 Dec 2023 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAvdPHqP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD41A727
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702998087; x=1734534087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x/hOouRnXHqzAJhY4XZBKUTZlHJR4Hnky5lSeqocgM8=;
  b=aAvdPHqPXQMAiRd6SL70E5sRR4RmUvJqp6mczCwLTUbEW6K3cRJT+r85
   s+Loe2VsZJ3haIaq7T0rFyhAqUNMOuzD+bef9UOrglEkwt9G+z8qATkZh
   reVmiyLzYAI4g7bVxTdbIXQO62acAX5Jn/Mpz4yPdno+K/mMbGzO/cTIu
   MAh/EUvIYtFzMohOJu+LQz4Zi4inxh/RUN/8QDERlcr8MvabKPP5wCHdS
   R8V5j0GCh1hKyj9BNLRmdDwqx7khgXYc/pWod8yCJwPa8oLeJZBm6mcRK
   mtDwV5a97c+a/dJiOXmvvHLbf7Mm5nC6IBEAmXi0HNcSiZNnhF/cWN8/J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="394548505"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="394548505"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="769266333"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="769266333"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2023 07:01:26 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org
Cc: alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	joe.jin@oracle.com,
	likexu@tencent.com,
	linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH V2] perf/x86/intel: Hide Topdown metrics events if the feature is not enumerated
Date: Tue, 19 Dec 2023 07:01:09 -0800
Message-Id: <20231219150109.1596634-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The below error is observed on Ice Lake VM.

$ perf stat
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (slots).
/bin/dmesg | grep -i perf may provide additional information.

In a virtualization env, the Topdown metrics and the slots event haven't
been supported yet. The guest CPUID doesn't enumerate them. However, the
current kernel unconditionally exposes the slots event and the Topdown
metrics events to sysfs, which misleads the perf tool and triggers the
error.

Hide the perf-metrics topdown events and the slots event if the
perf-metrics feature is not enumerated.

The big core of a hybrid platform can also supports the perf-metrics
feature. Fix the hybrid platform as well.

Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Closes: https://lore.kernel.org/lkml/CAM9d7cj8z+ryyzUHR+P1Dcpot2jjW+Qcc4CPQpfafTXN=LEU0Q@mail.gmail.com/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rebase on top of the 6.7-rc
- Use the intel_cap.perf_metrics to repace the slots event to check
  the enumeration of the perf metrics feature
 
 arch/x86/events/intel/core.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e068a96aeb54..e0822ede9ccb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5699,8 +5699,22 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.version >= 2 ? attr->mode : 0;
 }
 
+static umode_t
+td_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	/*
+	 * Hide the perf metrics topdown events
+	 * if the feature is not enumerated.
+	 */
+	if (x86_pmu.num_topdown_events)
+		return x86_pmu.intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
+	.is_visible = td_is_visible,
 };
 
 static struct attribute_group group_events_mem = {
@@ -5902,9 +5916,27 @@ static umode_t hybrid_format_is_visible(struct kobject *kobj,
 	return (cpu >= 0) && (pmu->pmu_type & pmu_attr->pmu_type) ? attr->mode : 0;
 }
 
+static umode_t hybrid_td_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct x86_hybrid_pmu *pmu =
+		 container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	if (!is_attr_for_this_pmu(kobj, attr))
+		return 0;
+
+
+	/* Only the big core supports perf metrics */
+	if (pmu->pmu_type == hybrid_big)
+		return pmu->intel_cap.perf_metrics ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute_group hybrid_group_events_td  = {
 	.name		= "events",
-	.is_visible	= hybrid_events_is_visible,
+	.is_visible	= hybrid_td_is_visible,
 };
 
 static struct attribute_group hybrid_group_events_mem = {
-- 
2.35.1


