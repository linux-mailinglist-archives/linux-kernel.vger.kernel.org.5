Return-Path: <linux-kernel+bounces-100607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E32879AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B8A1F23285
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23E1386C3;
	Tue, 12 Mar 2024 17:34:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7A13A279;
	Tue, 12 Mar 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264879; cv=none; b=fVcKTtZGsZ/6c62pxVWoCAFwfhk3/f1E8UBKh6UVmr67hDz5AuQ1L6YW8DRoyG2AjSEP21M5RBbI3hS9rdHUgR2GaVpnoNlkRUazMDpY5kmokA9pKok0YHXI+Vfz8ldW9R7ZYkgHNRaLzqtLUh6+jaKctFZ70x9Y4My2T6c3HrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264879; c=relaxed/simple;
	bh=7moC6d9m4ZjglLfhbpvlbuJJHrdfbQlKhLM46UMhzJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q19aN0hSjz4qqVmdY6monsRr6sO8y3Wg8+yu4J49x9hJpBVVzEe1Dhn8W7uS/lQiifKu4gqi15nWCAGFg67qDZjuQI6xPV/if+Q3dc08PHTTeBm2BIVJ4CHHNpxon5PCgPR+qZ2I4roPswe+NR4YTzUEm6deWxhDgeVesNHwvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 273761570;
	Tue, 12 Mar 2024 10:35:14 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBFEA3F762;
	Tue, 12 Mar 2024 10:34:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH 05/10] drivers/perf: Use PERF_PMU_CAP_NO_SAMPLING consistently
Date: Tue, 12 Mar 2024 17:34:07 +0000
Message-Id: <5622df31e5f4874c2c085d1ce930f5bbad889181.1710257512.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1710257512.git.robin.murphy@arm.com>
References: <cover.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our system PMUs fundamentally cannot support the current notion of
sampling events, so now that the core capability has been clarified,
apply it consistently and purge yet more boilerplate.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c     |  6 +-----
 drivers/perf/amlogic/meson_ddr_pmu_core.c |  3 ++-
 drivers/perf/arm-cci.c                    |  3 ++-
 drivers/perf/arm-ccn.c                    | 12 +-----------
 drivers/perf/arm-cmn.c                    |  3 ++-
 drivers/perf/arm_cspmu/arm_cspmu.c        | 17 ++++-------------
 drivers/perf/arm_dmc620_pmu.c             |  4 ++--
 drivers/perf/arm_dsu_pmu.c                | 12 +-----------
 drivers/perf/arm_smmuv3_pmu.c             |  6 +-----
 drivers/perf/cxl_pmu.c                    |  3 ++-
 drivers/perf/dwc_pcie_pmu.c               |  5 +----
 drivers/perf/fsl_imx8_ddr_perf.c          |  3 ++-
 drivers/perf/fsl_imx9_ddr_perf.c          |  3 ++-
 drivers/perf/hisilicon/hisi_pcie_pmu.c    |  4 ++--
 drivers/perf/hisilicon/hisi_uncore_pmu.c  |  3 ++-
 drivers/perf/hisilicon/hns3_pmu.c         |  4 ++--
 drivers/perf/marvell_cn10k_ddr_pmu.c      |  6 +-----
 drivers/perf/qcom_l2_pmu.c                |  7 +------
 drivers/perf/qcom_l3_pmu.c                |  7 +------
 drivers/perf/thunderx2_pmu.c              |  4 ++--
 drivers/perf/xgene_pmu.c                  |  4 ++--
 21 files changed, 36 insertions(+), 83 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 606c2301bd11..eadf4118d1ec 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -535,11 +535,6 @@ static int ali_drw_pmu_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	struct device *dev = drw_pmu->pmu.dev;
 
-	if (is_sampling_event(event)) {
-		dev_err(dev, "Sampling not supported!\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (event->attach_state & PERF_ATTACH_TASK) {
 		dev_err(dev, "Per-task counter cannot allocate!\n");
 		return -EOPNOTSUPP;
@@ -707,6 +702,7 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
 		.read		= ali_drw_pmu_read,
 		.attr_groups	= ali_drw_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index c19b682297f3..3bc887cde163 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -121,7 +121,7 @@ static int meson_ddr_perf_event_init(struct perf_event *event)
 	u64 config1 = event->attr.config1;
 	u64 config2 = event->attr.config2;
 
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
 	if (event->cpu < 0)
@@ -490,6 +490,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
 		.pmu = {
 			.module		= THIS_MODULE,
 			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+					  PERF_PMU_CAP_NO_SAMPLING |
 					  PERF_PMU_CAP_NO_COMMON_EVENTS,
 			.task_ctx_nr	= perf_invalid_context,
 			.attr_groups	= attr_groups,
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index f157bfd4b923..cf8fa2474bed 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1313,7 +1313,7 @@ static int cci_pmu_event_init(struct perf_event *event)
 	int err = 0;
 
 	/* Shared by all CPUs, no meaningful state to sample */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
 	/*
@@ -1414,6 +1414,7 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 		.read		= pmu_read,
 		.attr_groups	= pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index ce26bb773a56..4114349e62dd 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -713,7 +713,6 @@ static void arm_ccn_pmu_event_release(struct perf_event *event)
 static int arm_ccn_pmu_event_init(struct perf_event *event)
 {
 	struct arm_ccn *ccn;
-	struct hw_perf_event *hw = &event->hw;
 	u32 node_xp, type, event_id;
 	int valid;
 	int i;
@@ -721,16 +720,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 
 	ccn = pmu_to_arm_ccn(event->pmu);
 
-	if (hw->sample_period) {
-		dev_dbg(ccn->dev, "Sampling not supported!\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (has_branch_stack(event)) {
-		dev_dbg(ccn->dev, "Can't exclude execution levels!\n");
-		return -EINVAL;
-	}
-
 	if (event->cpu < 0) {
 		dev_dbg(ccn->dev, "Can't provide per-task data!\n");
 		return -EOPNOTSUPP;
@@ -1273,6 +1262,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 		.pmu_enable = arm_ccn_pmu_enable,
 		.pmu_disable = arm_ccn_pmu_disable,
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_SAMPLING |
 				PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 717dd90417d6..e1f151f04c9f 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1696,7 +1696,7 @@ static int arm_cmn_event_init(struct perf_event *event)
 	bool bynodeid;
 	u16 nodeid, eventid;
 
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
 	event->cpu = cmn->cpu;
@@ -2469,6 +2469,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 		.module = THIS_MODULE,
 		.attr_groups = arm_cmn_attr_groups,
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_SAMPLING |
 				PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr = perf_invalid_context,
 		.pmu_enable = arm_cmn_pmu_enable,
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 32ffea50cd7a..c5c7198e6921 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -680,12 +680,6 @@ static int arm_cspmu_event_init(struct perf_event *event)
 	 * Following other "uncore" PMUs, we do not support sampling mode or
 	 * attach to a task (per-process mode).
 	 */
-	if (is_sampling_event(event)) {
-		dev_dbg(cspmu->pmu.dev,
-			"Can't support sampling events\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
 		dev_dbg(cspmu->pmu.dev,
 			"Can't support per-task counters\n");
@@ -1171,7 +1165,7 @@ static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
 
 static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 {
-	int ret, capabilities;
+	int ret;
 	struct attribute_group **attr_groups;
 
 	attr_groups = arm_cspmu_alloc_attr_group(cspmu);
@@ -1183,11 +1177,6 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 	if (ret)
 		return ret;
 
-	capabilities = PERF_PMU_CAP_NO_EXCLUDE |
-		       PERF_PMU_CAP_NO_COMMON_EVENTS;
-	if (cspmu->irq == 0)
-		capabilities |= PERF_PMU_CAP_NO_SAMPLING;
-
 	cspmu->pmu = (struct pmu){
 		.task_ctx_nr	= perf_invalid_context,
 		.module		= cspmu->impl.module,
@@ -1200,7 +1189,9 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 		.stop		= arm_cspmu_stop,
 		.read		= arm_cspmu_read,
 		.attr_groups	= (const struct attribute_group **)attr_groups,
-		.capabilities	= capabilities,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	/* Hardware counter init */
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index dc0b5269edc1..47d3a166bccc 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -519,8 +519,7 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 	 * DMC 620 PMUs are shared across all cpus and cannot
 	 * support task bound and sampling events.
 	 */
-	if (is_sampling_event(event) ||
-		event->attach_state & PERF_ATTACH_TASK) {
+	if (event->attach_state & PERF_ATTACH_TASK) {
 		dev_dbg(dmc620_pmu->pmu.dev,
 			"Can't support per-task counters\n");
 		return -EOPNOTSUPP;
@@ -671,6 +670,7 @@ static int dmc620_pmu_device_probe(struct platform_device *pdev)
 	dmc620_pmu->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr	= perf_invalid_context,
 		.event_init	= dmc620_pmu_event_init,
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index f5ea5acaf2f3..3424d165795c 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -544,23 +544,12 @@ static int dsu_pmu_event_init(struct perf_event *event)
 {
 	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
 
-	/* We don't support sampling */
-	if (is_sampling_event(event)) {
-		dev_dbg(dsu_pmu->pmu.dev, "Can't support sampling events\n");
-		return -EOPNOTSUPP;
-	}
-
 	/* We cannot support task bound events */
 	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
 		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
 		return -EINVAL;
 	}
 
-	if (has_branch_stack(event)) {
-		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
-		return -EINVAL;
-	}
-
 	if (!cpumask_test_cpu(event->cpu, &dsu_pmu->associated_cpus)) {
 		dev_dbg(dsu_pmu->pmu.dev,
 			 "Requested cpu is not associated with the DSU\n");
@@ -760,6 +749,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 
 		.attr_groups	= dsu_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index ccecde79adb4..8206ba0c1637 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -401,11 +401,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
 	int group_num_events = 1;
 	u16 event_id;
 
-	if (hwc->sample_period) {
-		dev_dbg(dev, "Sampling not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (event->cpu < 0) {
 		dev_dbg(dev, "Per-task mode not supported\n");
 		return -EOPNOTSUPP;
@@ -868,6 +863,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.read		= smmu_pmu_event_read,
 		.attr_groups	= smmu_pmu_attr_grps,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 57954d102a75..41afbbd221a9 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -571,7 +571,7 @@ static int cxl_pmu_event_init(struct perf_event *event)
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
 	int rc;
 
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 	/* TODO: Validation of any filter */
 
@@ -867,6 +867,7 @@ static int cxl_pmu_probe(struct device *dev)
 		.task_ctx_nr = perf_invalid_context,
 		.attr_groups = cxl_pmu_attr_groups,
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_SAMPLING |
 				PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 161faa98f627..638ad527f252 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -366,10 +366,6 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	u32 lane;
 
-	/* We don't support sampling */
-	if (is_sampling_event(event))
-		return -EINVAL;
-
 	/* We cannot support task bound events */
 	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
@@ -634,6 +630,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr	= perf_invalid_context,
 		.event_init	= dwc_pcie_pmu_event_init,
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 021d637aea06..0070f2bd4d88 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -398,7 +398,7 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
 	if (event->cpu < 0) {
@@ -649,6 +649,7 @@ static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 		.pmu = (struct pmu) {
 			.module	      = THIS_MODULE,
 			.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+					PERF_PMU_CAP_NO_SAMPLING |
 					PERF_PMU_CAP_NO_COMMON_EVENTS,
 			.task_ctx_nr = perf_invalid_context,
 			.attr_groups = attr_groups,
diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index ec03e1e69568..83822abf8031 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -416,7 +416,7 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
 	if (event->cpu < 0) {
@@ -526,6 +526,7 @@ static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 		.pmu = (struct pmu) {
 			.module       = THIS_MODULE,
 			.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+					PERF_PMU_CAP_NO_SAMPLING |
 					PERF_PMU_CAP_NO_COMMON_EVENTS,
 			.task_ctx_nr  = perf_invalid_context,
 			.attr_groups  = attr_groups,
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 5a301a7db7ae..7579b93dc462 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -358,8 +358,7 @@ static int hisi_pcie_pmu_event_init(struct perf_event *event)
 	else
 		hwc->event_base = HISI_PCIE_CNT;
 
-	/* Sampling is not supported. */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
 	if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu))
@@ -810,6 +809,7 @@ static int hisi_pcie_alloc_pmu(struct pci_dev *pdev, struct hisi_pcie_pmu *pcie_
 		.task_ctx_nr	= perf_invalid_context,
 		.attr_groups	= hisi_pcie_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 0908ddd992b7..7718b031f671 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -191,7 +191,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 	 * shared by all CPU cores in a CPU die(SCCL). Also we
 	 * do not support attach to a task(per-process mode)
 	 */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
 	/*
@@ -546,6 +546,7 @@ void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
 	pmu->read               = hisi_uncore_pmu_read;
 	pmu->attr_groups        = hisi_pmu->pmu_events.attr_groups;
 	pmu->capabilities       = PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS;
 }
 EXPORT_SYMBOL_GPL(hisi_pmu_init);
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 300345edd211..3d089df22c01 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1236,8 +1236,7 @@ static int hns3_pmu_event_init(struct perf_event *event)
 	int idx;
 	int ret;
 
-	/* Sampling is not supported */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
 	event->cpu = hns3_pmu->on_cpu;
@@ -1427,6 +1426,7 @@ static int hns3_pmu_alloc_pmu(struct pci_dev *pdev, struct hns3_pmu *hns3_pmu)
 		.task_ctx_nr	= perf_invalid_context,
 		.attr_groups	= hns3_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index baa0a3fbad31..bb16a193ff36 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -325,11 +325,6 @@ static int cn10k_ddr_perf_event_init(struct perf_event *event)
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (is_sampling_event(event)) {
-		dev_info(pmu->dev, "Sampling not supported!\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (event->cpu < 0) {
 		dev_warn(pmu->dev, "Can't provide per-task data!\n");
 		return -EOPNOTSUPP;
@@ -654,6 +649,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 	ddr_pmu->pmu = (struct pmu) {
 		.module	      = THIS_MODULE,
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_SAMPLING |
 				PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr = perf_invalid_context,
 		.attr_groups = cn10k_attr_groups,
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 8b2617ad4bdc..3f7837632988 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -442,12 +442,6 @@ static int l2_cache_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(event->pmu);
 
-	if (hwc->sample_period) {
-		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
-				    "Sampling not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (event->cpu < 0) {
 		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
 				    "Per-task mode not supported\n");
@@ -910,6 +904,7 @@ static int l2_cache_pmu_probe(struct platform_device *pdev)
 		.read		= l2_cache_event_read,
 		.attr_groups	= l2_cache_pmu_attr_grps,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 72610777567d..54fde33802f4 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -480,12 +480,6 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
 	struct l3cache_pmu *l3pmu = to_l3cache_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	/*
-	 * Sampling not supported since these events are not core-attributable.
-	 */
-	if (hwc->sample_period)
-		return -EINVAL;
-
 	/*
 	 * Task mode not available, we run the counters as socket counters,
 	 * not attributable to any CPU and therefore cannot attribute per-task.
@@ -755,6 +749,7 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 
 		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 8c7a2c6113be..06b589799536 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -577,9 +577,8 @@ static int tx2_uncore_event_init(struct perf_event *event)
 	/*
 	 * SOC PMU counters are shared across all cores.
 	 * Therefore, it does not support per-process mode.
-	 * Also, it does not support event sampling mode.
 	 */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
 	if (event->cpu < 0)
@@ -734,6 +733,7 @@ static int tx2_uncore_pmu_register(
 		.stop		= tx2_uncore_event_stop,
 		.read		= tx2_uncore_event_read,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 16bb3dfb1636..7f753b8f4e93 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -891,9 +891,8 @@ static int xgene_perf_event_init(struct perf_event *event)
 	/*
 	 * SOC PMU counters are shared across all cores.
 	 * Therefore, it does not support per-process mode.
-	 * Also, it does not support event sampling mode.
 	 */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
 	if (event->cpu < 0)
@@ -1109,6 +1108,7 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 		.stop		= xgene_perf_stop,
 		.read		= xgene_perf_read,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_SAMPLING |
 				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
-- 
2.39.2.101.g768bb238c484.dirty


