Return-Path: <linux-kernel+bounces-100608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A03879AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E282A1C2147F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424D1386CB;
	Tue, 12 Mar 2024 17:34:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F279113A882;
	Tue, 12 Mar 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264881; cv=none; b=P9X7QClROD1fVwIbXYl+oEWVE22z0MJ6sU9zY8t88p604VS89FEAbiGA0EynaNRVRc03tCjjIUndoeUGsIUkDrqllcnZx1UmXgWNKhj8EJ1lsQzwa00XYmQe2HPyOdRhrEC5XqoVl/chnXQRVZ0siFbilBwPVAA3fWLnekN/OgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264881; c=relaxed/simple;
	bh=RaSs6kuPPiFYwd0/wGwDdI6DqyKHpAh2TLMSAZ6DhVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABKbrZP7u0ioZ2YM+YrXhpVMsvik5K3cnd2qbUPCOp5+ovVRbYujPT0kzf+8VuNLfx5DnMuZ2zq38kUeghcK2sKN8Aw2goFn5jXz4KKPwDR9szMDNrz3ZefEvd0zkegnr51As6m7zxoz2KTjcA1ZsUF0vVCOEiu/nKDc9LNP52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8607615DB;
	Tue, 12 Mar 2024 10:35:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 551FD3F762;
	Tue, 12 Mar 2024 10:34:37 -0700 (PDT)
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
Subject: [PATCH 06/10] drivers/perf: Clean up redundant per-task checks
Date: Tue, 12 Mar 2024 17:34:08 +0000
Message-Id: <c5839e5a43a747d661be86cd1a55f0e92289e2b6.1710257512.git.robin.murphy@arm.com>
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

It turns out that a while back, perf_event_alloc() grew the ability
to properly refuse all per-task and cgroup events on behalf of
uncore/system PMUs using perf_invalid_context, so that's a whole load
more inconsistent boilerplate which can also go from our drivers. This
includes a couple more cases of drivers foolishly checking event->cpu
*after* overriding it with their own (necessarily valid) CPU...

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c     |  5 -----
 drivers/perf/amlogic/meson_ddr_pmu_core.c |  6 ------
 drivers/perf/arm-cci.c                    |  6 ------
 drivers/perf/arm-ccn.c                    |  4 ----
 drivers/perf/arm-cmn.c                    |  5 -----
 drivers/perf/arm_cspmu/arm_cspmu.c        | 10 ----------
 drivers/perf/arm_dmc620_pmu.c             | 12 ------------
 drivers/perf/arm_dsu_pmu.c                |  6 ------
 drivers/perf/arm_smmuv3_pmu.c             |  5 -----
 drivers/perf/cxl_pmu.c                    |  2 --
 drivers/perf/dwc_pcie_pmu.c               |  4 ----
 drivers/perf/fsl_imx8_ddr_perf.c          |  8 --------
 drivers/perf/fsl_imx9_ddr_perf.c          |  8 --------
 drivers/perf/hisilicon/hisi_pcie_pmu.c    |  3 ---
 drivers/perf/hisilicon/hisi_uncore_pmu.c  | 15 ---------------
 drivers/perf/hisilicon/hns3_pmu.c         |  3 ---
 drivers/perf/marvell_cn10k_ddr_pmu.c      |  5 -----
 drivers/perf/qcom_l2_pmu.c                |  6 ------
 drivers/perf/qcom_l3_pmu.c                |  7 -------
 drivers/perf/thunderx2_pmu.c              | 10 ----------
 drivers/perf/xgene_pmu.c                  |  9 ---------
 21 files changed, 139 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index eadf4118d1ec..42172939721b 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -535,11 +535,6 @@ static int ali_drw_pmu_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	struct device *dev = drw_pmu->pmu.dev;
 
-	if (event->attach_state & PERF_ATTACH_TASK) {
-		dev_err(dev, "Per-task counter cannot allocate!\n");
-		return -EOPNOTSUPP;
-	}
-
 	event->cpu = drw_pmu->irq->cpu;
 
 	if (event->group_leader != event &&
diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index 3bc887cde163..6fcd37b11dd8 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -121,12 +121,6 @@ static int meson_ddr_perf_event_init(struct perf_event *event)
 	u64 config1 = event->attr.config1;
 	u64 config2 = event->attr.config2;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
-	if (event->cpu < 0)
-		return -EOPNOTSUPP;
-
 	/* check if the number of parameters is too much */
 	if (event->attr.config != ALL_CHAN_COUNTER_ID &&
 	    hweight64(config1) + hweight64(config2) > MAX_AXI_PORTS_OF_CHANNEL)
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index cf8fa2474bed..2ccce0e66ada 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1312,10 +1312,6 @@ static int cci_pmu_event_init(struct perf_event *event)
 	atomic_t *active_events = &cci_pmu->active_events;
 	int err = 0;
 
-	/* Shared by all CPUs, no meaningful state to sample */
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
 	/*
 	 * Following the example set by other "uncore" PMUs, we accept any CPU
 	 * and rewrite its affinity dynamically rather than having perf core
@@ -1325,8 +1321,6 @@ static int cci_pmu_event_init(struct perf_event *event)
 	 * the event being installed into its context, so the PMU's CPU can't
 	 * change under our feet.
 	 */
-	if (event->cpu < 0)
-		return -EINVAL;
 	event->cpu = cci_pmu->cpu;
 
 	event->destroy = hw_perf_event_destroy;
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 4114349e62dd..2adb6a1d136f 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -720,10 +720,6 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 
 	ccn = pmu_to_arm_ccn(event->pmu);
 
-	if (event->cpu < 0) {
-		dev_dbg(ccn->dev, "Can't provide per-task data!\n");
-		return -EOPNOTSUPP;
-	}
 	/*
 	 * Many perf core operations (eg. events rotation) operate on a
 	 * single CPU context. This is obvious for CPU PMUs, where one
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index e1f151f04c9f..26ede1db1f72 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1696,12 +1696,7 @@ static int arm_cmn_event_init(struct perf_event *event)
 	bool bynodeid;
 	u16 nodeid, eventid;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
 	event->cpu = cmn->cpu;
-	if (event->cpu < 0)
-		return -EINVAL;
 
 	type = CMN_EVENT_TYPE(event);
 	/* DTC events (i.e. cycles) already have everything they need */
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index c5c7198e6921..b007e1fdd336 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -676,16 +676,6 @@ static int arm_cspmu_event_init(struct perf_event *event)
 
 	cspmu = to_arm_cspmu(event->pmu);
 
-	/*
-	 * Following other "uncore" PMUs, we do not support sampling mode or
-	 * attach to a task (per-process mode).
-	 */
-	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
-		dev_dbg(cspmu->pmu.dev,
-			"Can't support per-task counters\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * Make sure the CPU assignment is on one of the CPUs associated with
 	 * this PMU.
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 47d3a166bccc..98e7c2333cc6 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -515,16 +515,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	/*
-	 * DMC 620 PMUs are shared across all cpus and cannot
-	 * support task bound and sampling events.
-	 */
-	if (event->attach_state & PERF_ATTACH_TASK) {
-		dev_dbg(dmc620_pmu->pmu.dev,
-			"Can't support per-task counters\n");
-		return -EOPNOTSUPP;
-	}
-
 	/*
 	 * Many perf core operations (eg. events rotation) operate on a
 	 * single CPU context. This is obvious for CPU PMUs, where one
@@ -535,8 +525,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 	 * processor.
 	 */
 	event->cpu = dmc620_pmu->irq->cpu;
-	if (event->cpu < 0)
-		return -EINVAL;
 
 	/*
 	 * We can't atomically disable all HW counters so only one event allowed,
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 3424d165795c..740f8c958976 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -544,12 +544,6 @@ static int dsu_pmu_event_init(struct perf_event *event)
 {
 	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
 
-	/* We cannot support task bound events */
-	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
-		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
-		return -EINVAL;
-	}
-
 	if (!cpumask_test_cpu(event->cpu, &dsu_pmu->associated_cpus)) {
 		dev_dbg(dsu_pmu->pmu.dev,
 			 "Requested cpu is not associated with the DSU\n");
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 8206ba0c1637..f4e22ff179b9 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -401,11 +401,6 @@ static int smmu_pmu_event_init(struct perf_event *event)
 	int group_num_events = 1;
 	u16 event_id;
 
-	if (event->cpu < 0) {
-		dev_dbg(dev, "Per-task mode not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	/* Verify specified event is supported on this PMU */
 	event_id = get_event(event);
 	if (event_id < SMMU_PMCG_ARCH_MAX_EVENTS &&
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 41afbbd221a9..e78f8db8ef52 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -571,8 +571,6 @@ static int cxl_pmu_event_init(struct perf_event *event)
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(event->pmu);
 	int rc;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
 	/* TODO: Validation of any filter */
 
 	/*
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 638ad527f252..c2c4a7673e58 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -366,10 +366,6 @@ static int dwc_pcie_pmu_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	u32 lane;
 
-	/* We cannot support task bound events */
-	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
 	if (event->group_leader != event &&
 	    !is_software_event(event->group_leader))
 		return -EINVAL;
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 0070f2bd4d88..612216277ea5 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -398,14 +398,6 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
-	if (event->cpu < 0) {
-		dev_warn(pmu->dev, "Can't provide per-task data!\n");
-		return -EOPNOTSUPP;
-	}
-
 	/*
 	 * We must NOT create groups containing mixed PMUs, although software
 	 * events are acceptable (for example to create a CCN group
diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 83822abf8031..80b4703bef89 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -416,14 +416,6 @@ static int ddr_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_event *sibling;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
-	if (event->cpu < 0) {
-		dev_warn(pmu->dev, "Can't provide per-task data!\n");
-		return -EOPNOTSUPP;
-	}
-
 	/*
 	 * We must NOT create groups containing mixed PMUs, although software
 	 * events are acceptable (for example to create a CCN group
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 7579b93dc462..d37c65d40a30 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -358,9 +358,6 @@ static int hisi_pcie_pmu_event_init(struct perf_event *event)
 	else
 		hwc->event_base = HISI_PCIE_CNT;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
 	if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu))
 		return -EINVAL;
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 7718b031f671..5de53e76e42f 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -186,21 +186,6 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct hisi_pmu *hisi_pmu;
 
-	/*
-	 * We do not support sampling as the counters are all
-	 * shared by all CPU cores in a CPU die(SCCL). Also we
-	 * do not support attach to a task(per-process mode)
-	 */
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
-	/*
-	 *  The uncore counters not specific to any CPU, so cannot
-	 *  support per-task
-	 */
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	/*
 	 * Validate if the events in group does not exceed the
 	 * available counters in hardware.
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 3d089df22c01..09bf38e56909 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1236,9 +1236,6 @@ static int hns3_pmu_event_init(struct perf_event *event)
 	int idx;
 	int ret;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EOPNOTSUPP;
-
 	event->cpu = hns3_pmu->on_cpu;
 
 	idx = hns3_pmu_get_event_idx(hns3_pmu);
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index bb16a193ff36..ebafa39a6b24 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -325,11 +325,6 @@ static int cn10k_ddr_perf_event_init(struct perf_event *event)
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (event->cpu < 0) {
-		dev_warn(pmu->dev, "Can't provide per-task data!\n");
-		return -EOPNOTSUPP;
-	}
-
 	/*  We must NOT create groups containing mixed PMUs */
 	if (event->group_leader->pmu != event->pmu &&
 	    !is_software_event(event->group_leader))
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 3f7837632988..d85f11c9261f 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -442,12 +442,6 @@ static int l2_cache_event_init(struct perf_event *event)
 	struct perf_event *sibling;
 	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(event->pmu);
 
-	if (event->cpu < 0) {
-		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
-				    "Per-task mode not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (((L2_EVT_GROUP(event->attr.config) > L2_EVT_GROUP_MAX) ||
 	     ((event->attr.config & ~L2_EVT_MASK) != 0)) &&
 	    (event->attr.config != L2CYCLE_CTR_RAW_CODE)) {
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 54fde33802f4..733067fa68e5 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -480,13 +480,6 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
 	struct l3cache_pmu *l3pmu = to_l3cache_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	/*
-	 * Task mode not available, we run the counters as socket counters,
-	 * not attributable to any CPU and therefore cannot attribute per-task.
-	 */
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	/* Validate the group */
 	if (!qcom_l3_cache__validate_event_group(event))
 		return -EINVAL;
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 06b589799536..d9da3070f27c 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -574,16 +574,6 @@ static int tx2_uncore_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct tx2_uncore_pmu *tx2_pmu;
 
-	/*
-	 * SOC PMU counters are shared across all cores.
-	 * Therefore, it does not support per-process mode.
-	 */
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	tx2_pmu = pmu_to_tx2_pmu(event->pmu);
 	if (tx2_pmu->cpu >= nr_cpu_ids)
 		return -EINVAL;
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 7f753b8f4e93..b2d855866354 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -888,15 +888,6 @@ static int xgene_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hw = &event->hw;
 	struct perf_event *sibling;
 
-	/*
-	 * SOC PMU counters are shared across all cores.
-	 * Therefore, it does not support per-process mode.
-	 */
-	if (event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
-	if (event->cpu < 0)
-		return -EINVAL;
 	/*
 	 * Many perf core operations (eg. events rotation) operate on a
 	 * single CPU context. This is obvious for CPU PMUs, where one
-- 
2.39.2.101.g768bb238c484.dirty


