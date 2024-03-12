Return-Path: <linux-kernel+bounces-100605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88712879AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6AFB23FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E713A253;
	Tue, 12 Mar 2024 17:34:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC8D139596;
	Tue, 12 Mar 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264874; cv=none; b=V/4ElNAQS2VfSXwaMy4nSvfvmbgj+/vzqNdlVkzJcSCN+h773x9yG+DsB7w/tfxbGUVqjKK56cXEbfMqAu7f3o2JTxDGGFAs3WOIqRxCz9gXPHFLjdeMvkAvzm0X8E6NVpJm6DMx4SC+h59E2/Zg9TZIqJTD6KAOglBIsGRfY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264874; c=relaxed/simple;
	bh=/GfEJw6zB25TqgDGj1VUeKJo+8W9aPFMIn6BqDqMrLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cW7hjMRY0bppvc5zeCjaCLnCW4jTiAUCWB2C7gaLL7lvqmI9Q/rKbftlKqtcRAQ8UEi/r0PzBxGMqk3PNDZf/BN7Dm5Z/tDKfLZEfo5/52LwAaRAQCZLpNw2sdOH0e6yWndVdBOmGH9M4zgBc1+HyyhR/ZnJSBqY5NFWbXKc+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E89B1650;
	Tue, 12 Mar 2024 10:35:09 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E36593F762;
	Tue, 12 Mar 2024 10:34:29 -0700 (PDT)
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
Subject: [PATCH 03/10] drivers/perf: Use PERF_PMU_CAP_NO_COMMON_EVENTS
Date: Tue, 12 Mar 2024 17:34:05 +0000
Message-Id: <7043be8c1de4458927414cecc86445c805cd8820.1710257512.git.robin.murphy@arm.com>
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

Now that we have a core capability for refusing common event types, make
use of it to purge the -ENOENT boilerplate from our system PMU drivers.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c     |  6 ++----
 drivers/perf/amlogic/meson_ddr_pmu_core.c |  6 ++----
 drivers/perf/arm-cci.c                    | 10 ++--------
 drivers/perf/arm-ccn.c                    |  6 ++----
 drivers/perf/arm-cmn.c                    |  6 ++----
 drivers/perf/arm_cspmu/arm_cspmu.c        |  6 ++----
 drivers/perf/arm_dmc620_pmu.c             |  6 ++----
 drivers/perf/arm_dsu_pmu.c                |  6 ++----
 drivers/perf/arm_smmuv3_pmu.c             |  6 ++----
 drivers/perf/arm_spe_pmu.c                |  7 ++-----
 drivers/perf/cxl_pmu.c                    |  7 ++-----
 drivers/perf/dwc_pcie_pmu.c               |  6 ++----
 drivers/perf/fsl_imx8_ddr_perf.c          |  6 ++----
 drivers/perf/fsl_imx9_ddr_perf.c          |  6 ++----
 drivers/perf/hisilicon/hisi_pcie_pmu.c    |  7 ++-----
 drivers/perf/hisilicon/hisi_uncore_pmu.c  |  6 ++----
 drivers/perf/hisilicon/hns3_pmu.c         |  6 ++----
 drivers/perf/marvell_cn10k_ddr_pmu.c      |  6 ++----
 drivers/perf/marvell_cn10k_tad_pmu.c      |  6 ++----
 drivers/perf/qcom_l2_pmu.c                | 10 +++-------
 drivers/perf/qcom_l3_pmu.c                |  9 ++-------
 drivers/perf/thunderx2_pmu.c              |  7 ++-----
 drivers/perf/xgene_pmu.c                  |  7 ++-----
 23 files changed, 47 insertions(+), 107 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index b37e9794823a..606c2301bd11 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -535,9 +535,6 @@ static int ali_drw_pmu_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	struct device *dev = drw_pmu->pmu.dev;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (is_sampling_event(event)) {
 		dev_err(dev, "Sampling not supported!\n");
 		return -EOPNOTSUPP;
@@ -709,7 +706,8 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
 		.stop		= ali_drw_pmu_stop,
 		.read		= ali_drw_pmu_read,
 		.attr_groups	= ali_drw_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	ret = perf_pmu_register(&drw_pmu->pmu, name, -1);
diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index bbc7285fd934..c19b682297f3 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -121,9 +121,6 @@ static int meson_ddr_perf_event_init(struct perf_event *event)
 	u64 config1 = event->attr.config1;
 	u64 config2 = event->attr.config2;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
@@ -492,7 +489,8 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
 	*pmu = (struct ddr_pmu) {
 		.pmu = {
 			.module		= THIS_MODULE,
-			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+					  PERF_PMU_CAP_NO_COMMON_EVENTS,
 			.task_ctx_nr	= perf_invalid_context,
 			.attr_groups	= attr_groups,
 			.event_init	= meson_ddr_perf_event_init,
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 61de861eaf91..f157bfd4b923 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -815,10 +815,6 @@ static int pmu_map_event(struct perf_event *event)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
 
-	if (event->attr.type < PERF_TYPE_MAX ||
-			!cci_pmu->model->validate_hw_event)
-		return -ENOENT;
-
 	return	cci_pmu->model->validate_hw_event(cci_pmu, event->attr.config);
 }
 
@@ -1316,9 +1312,6 @@ static int cci_pmu_event_init(struct perf_event *event)
 	atomic_t *active_events = &cci_pmu->active_events;
 	int err = 0;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/* Shared by all CPUs, no meaningful state to sample */
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
@@ -1420,7 +1413,8 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 		.stop		= cci_pmu_stop,
 		.read		= pmu_read,
 		.attr_groups	= pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	cci_pmu->plat_device = pdev;
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 728d13d8e98a..ce26bb773a56 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -719,9 +719,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 	int i;
 	struct perf_event *sibling;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	ccn = pmu_to_arm_ccn(event->pmu);
 
 	if (hw->sample_period) {
@@ -1275,7 +1272,8 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 		.read = arm_ccn_pmu_event_read,
 		.pmu_enable = arm_ccn_pmu_enable,
 		.pmu_disable = arm_ccn_pmu_disable,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	/* No overflow interrupt? Have to use a timer instead. */
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c584165b13ba..717dd90417d6 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1696,9 +1696,6 @@ static int arm_cmn_event_init(struct perf_event *event)
 	bool bynodeid;
 	u16 nodeid, eventid;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
@@ -2471,7 +2468,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.attr_groups = arm_cmn_attr_groups,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr = perf_invalid_context,
 		.pmu_enable = arm_cmn_pmu_enable,
 		.pmu_disable = arm_cmn_pmu_disable,
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 50b89b989ce7..d408cbb84ed7 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -676,9 +676,6 @@ static int arm_cspmu_event_init(struct perf_event *event)
 
 	cspmu = to_arm_cspmu(event->pmu);
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/*
 	 * Following other "uncore" PMUs, we do not support sampling mode or
 	 * attach to a task (per-process mode).
@@ -1186,7 +1183,8 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 	if (ret)
 		return ret;
 
-	capabilities = PERF_PMU_CAP_NO_EXCLUDE;
+	capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+		       PERF_PMU_CAP_NO_COMMON_EVENTS;
 	if (cspmu->irq == 0)
 		capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 30cea6859574..dc0b5269edc1 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -515,9 +515,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/*
 	 * DMC 620 PMUs are shared across all cpus and cannot
 	 * support task bound and sampling events.
@@ -673,7 +670,8 @@ static int dmc620_pmu_device_probe(struct platform_device *pdev)
 
 	dmc620_pmu->pmu = (struct pmu) {
 		.module = THIS_MODULE,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr	= perf_invalid_context,
 		.event_init	= dmc620_pmu_event_init,
 		.add		= dmc620_pmu_add,
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 7ec4498e312f..f5ea5acaf2f3 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -544,9 +544,6 @@ static int dsu_pmu_event_init(struct perf_event *event)
 {
 	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/* We don't support sampling */
 	if (is_sampling_event(event)) {
 		dev_dbg(dsu_pmu->pmu.dev, "Can't support sampling events\n");
@@ -762,7 +759,8 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 		.read		= dsu_pmu_read,
 
 		.attr_groups	= dsu_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 6303b82566f9..ccecde79adb4 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -401,9 +401,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
 	int group_num_events = 1;
 	u16 event_id;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (hwc->sample_period) {
 		dev_dbg(dev, "Sampling not supported\n");
 		return -EOPNOTSUPP;
@@ -870,7 +867,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.stop		= smmu_pmu_event_stop,
 		.read		= smmu_pmu_event_read,
 		.attr_groups	= smmu_pmu_attr_grps,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b622d75d8c9e..290e98247bba 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -699,10 +699,6 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
 
-	/* This is, of course, deeply driver-specific */
-	if (attr->type != event->pmu->type)
-		return -ENOENT;
-
 	if (event->cpu >= 0 &&
 	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
 		return -ENOENT;
@@ -932,7 +928,8 @@ static int arm_spe_pmu_perf_init(struct arm_spe_pmu *spe_pmu)
 
 	spe_pmu->pmu = (struct pmu) {
 		.module = THIS_MODULE,
-		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
+		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.attr_groups	= arm_spe_pmu_attr_groups,
 		/*
 		 * We hitch a ride on the software context here, so that
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 365d964b0f6a..57954d102a75 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -571,10 +571,6 @@ static int cxl_pmu_event_init(struct perf_event *event)
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
 	int rc;
 
-	/* Top level type sanity check - is this a Hardware Event being requested */
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 	/* TODO: Validation of any filter */
@@ -870,7 +866,8 @@ static int cxl_pmu_probe(struct device *dev)
 		.read = cxl_pmu_read,
 		.task_ctx_nr = perf_invalid_context,
 		.attr_groups = cxl_pmu_attr_groups,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	if (info->irq <= 0)
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 957058ad0099..161faa98f627 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -366,9 +366,6 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	u32 lane;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/* We don't support sampling */
 	if (is_sampling_event(event))
 		return -EINVAL;
@@ -636,7 +633,8 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 		.parent		= &pdev->dev,
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr	= perf_invalid_context,
 		.event_init	= dwc_pcie_pmu_event_init,
 		.add		= dwc_pcie_pmu_event_add,
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 7dbfaee372c7..021d637aea06 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -398,9 +398,6 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
@@ -651,7 +648,8 @@ static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 	*pmu = (struct ddr_pmu) {
 		.pmu = (struct pmu) {
 			.module	      = THIS_MODULE,
-			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+					PERF_PMU_CAP_NO_COMMON_EVENTS,
 			.task_ctx_nr = perf_invalid_context,
 			.attr_groups = attr_groups,
 			.event_init  = ddr_perf_event_init,
diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 9685645bfe04..ec03e1e69568 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -416,9 +416,6 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
 
@@ -528,7 +525,8 @@ static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 	*pmu = (struct ddr_pmu) {
 		.pmu = (struct pmu) {
 			.module       = THIS_MODULE,
-			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+					PERF_PMU_CAP_NO_COMMON_EVENTS,
 			.task_ctx_nr  = perf_invalid_context,
 			.attr_groups  = attr_groups,
 			.event_init   = ddr_perf_event_init,
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index b90ba8aca3fa..5a301a7db7ae 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -353,10 +353,6 @@ static int hisi_pcie_pmu_event_init(struct perf_event *event)
 	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	/* Check the type first before going on, otherwise it's not our event */
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (EXT_COUNTER_IS_USED(hisi_pcie_get_event(event)))
 		hwc->event_base = HISI_PCIE_EXT_CNT;
 	else
@@ -813,7 +809,8 @@ static int hisi_pcie_alloc_pmu(struct pci_dev *pdev, struct hisi_pcie_pmu *pcie_
 		.read		= hisi_pcie_pmu_read,
 		.task_ctx_nr	= perf_invalid_context,
 		.attr_groups	= hisi_pcie_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	return 0;
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 04031450d5fe..0908ddd992b7 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -186,9 +186,6 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct hisi_pmu *hisi_pmu;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/*
 	 * We do not support sampling as the counters are all
 	 * shared by all CPU cores in a CPU die(SCCL). Also we
@@ -548,7 +545,8 @@ void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
 	pmu->stop               = hisi_uncore_pmu_stop;
 	pmu->read               = hisi_uncore_pmu_read;
 	pmu->attr_groups        = hisi_pmu->pmu_events.attr_groups;
-	pmu->capabilities       = PERF_PMU_CAP_NO_EXCLUDE;
+	pmu->capabilities       = PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS;
 }
 EXPORT_SYMBOL_GPL(hisi_pmu_init);
 
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 16869bf5bf4c..300345edd211 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1236,9 +1236,6 @@ static int hns3_pmu_event_init(struct perf_event *event)
 	int idx;
 	int ret;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/* Sampling is not supported */
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EOPNOTSUPP;
@@ -1429,7 +1426,8 @@ static int hns3_pmu_alloc_pmu(struct pci_dev *pdev, struct hns3_pmu *hns3_pmu)
 		.read		= hns3_pmu_read,
 		.task_ctx_nr	= perf_invalid_context,
 		.attr_groups	= hns3_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	return 0;
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 524ba82bfce2..baa0a3fbad31 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -325,9 +325,6 @@ static int cn10k_ddr_perf_event_init(struct perf_event *event)
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (is_sampling_event(event)) {
 		dev_info(pmu->dev, "Sampling not supported!\n");
 		return -EOPNOTSUPP;
@@ -656,7 +653,8 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 
 	ddr_pmu->pmu = (struct pmu) {
 		.module	      = THIS_MODULE,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
+				PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr = perf_invalid_context,
 		.attr_groups = cn10k_attr_groups,
 		.event_init  = cn10k_ddr_perf_event_init,
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index fec8e82edb95..bc2d642e87e8 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -140,9 +140,6 @@ static int tad_pmu_event_init(struct perf_event *event)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
 
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	if (!event->attr.disabled)
 		return -EINVAL;
 
@@ -321,7 +318,8 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.module		= THIS_MODULE,
 		.attr_groups	= tad_pmu_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_INTERRUPT,
+				  PERF_PMU_CAP_NO_INTERRUPT |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 		.task_ctx_nr	= perf_invalid_context,
 
 		.event_init	= tad_pmu_event_init,
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 3f9a98c17a89..8b2617ad4bdc 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -440,12 +440,7 @@ static int l2_cache_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct cluster_pmu *cluster;
 	struct perf_event *sibling;
-	struct l2cache_pmu *l2cache_pmu;
-
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
-	l2cache_pmu = to_l2cache_pmu(event->pmu);
+	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(event->pmu);
 
 	if (hwc->sample_period) {
 		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
@@ -914,7 +909,8 @@ static int l2_cache_pmu_probe(struct platform_device *pdev)
 		.stop		= l2_cache_event_stop,
 		.read		= l2_cache_event_read,
 		.attr_groups	= l2_cache_pmu_attr_grps,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	l2cache_pmu->num_counters = get_num_counters();
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index f16783d03db7..72610777567d 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -480,12 +480,6 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
 	struct l3cache_pmu *l3pmu = to_l3cache_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	/*
-	 * Is the event for this PMU?
-	 */
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/*
 	 * Sampling not supported since these events are not core-attributable.
 	 */
@@ -760,7 +754,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 		.read		= qcom_l3_cache__event_read,
 
 		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	l3pmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 1edb9c03704f..8c7a2c6113be 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -574,10 +574,6 @@ static int tx2_uncore_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct tx2_uncore_pmu *tx2_pmu;
 
-	/* Test the event attr type check for PMU enumeration */
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/*
 	 * SOC PMU counters are shared across all cores.
 	 * Therefore, it does not support per-process mode.
@@ -737,7 +733,8 @@ static int tx2_uncore_pmu_register(
 		.start		= tx2_uncore_event_start,
 		.stop		= tx2_uncore_event_stop,
 		.read		= tx2_uncore_event_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 7ce344248dda..16bb3dfb1636 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -888,10 +888,6 @@ static int xgene_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hw = &event->hw;
 	struct perf_event *sibling;
 
-	/* Test the event attr type check for PMU enumeration */
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
 	/*
 	 * SOC PMU counters are shared across all cores.
 	 * Therefore, it does not support per-process mode.
@@ -1112,7 +1108,8 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 		.start		= xgene_perf_start,
 		.stop		= xgene_perf_stop,
 		.read		= xgene_perf_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_COMMON_EVENTS,
 	};
 
 	/* Hardware counter init */
-- 
2.39.2.101.g768bb238c484.dirty


