Return-Path: <linux-kernel+bounces-100610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0C879AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51091C20F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E012FB2C;
	Tue, 12 Mar 2024 17:34:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99513B29B;
	Tue, 12 Mar 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264886; cv=none; b=cRhn7kR973sxYbbqlGv9RXtt2hDxxM0/2a0faWvf8HJPW3PdJzZLTe42v16QhIWuj2vxAPm8268tysEbmSXyMNTtyeSeTz4cqOVc9Fv+azzm34W0cx2O0VrIe71U5TNEGCiqj6RoGL/Fw8wGCVV4SThKy7Wn3Fm8wmSnSv52afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264886; c=relaxed/simple;
	bh=N2jXvmloCVFQbL6+Vb3DnGt/iNl7WwTUKjV6MPRxljA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0m9VVgZ/5srUFvmMAEQs/ki8LSOcUnCtT8xXpNKeoyZN1no/tgNxJF4PVTpoDyY892FkAqad0zICjT/nJHvHJqX/MJXmRWtyyfZKgLGqF3p/keTKj3nomPUYajZNaqioGTsMju2ZTOWzn0VrWrRST24AY3qT3TDKEMxjG9wJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 599381650;
	Tue, 12 Mar 2024 10:35:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28AB03F762;
	Tue, 12 Mar 2024 10:34:42 -0700 (PDT)
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
Subject: [PATCH 08/10] drivers/perf: Use common uncore capabilities
Date: Tue, 12 Mar 2024 17:34:10 +0000
Message-Id: <c32c988afe9c9a3005b5b7c448bcf56735b5549b.1710257512.git.robin.murphy@arm.com>
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

Now that we've ratified it, adopt PERF_PMU_UNCORE_CAPS.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c     | 4 +---
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 4 +---
 drivers/perf/arm-cci.c                    | 4 +---
 drivers/perf/arm-ccn.c                    | 4 +---
 drivers/perf/arm-cmn.c                    | 4 +---
 drivers/perf/arm_cspmu/arm_cspmu.c        | 4 +---
 drivers/perf/arm_dmc620_pmu.c             | 4 +---
 drivers/perf/arm_dsu_pmu.c                | 4 +---
 drivers/perf/arm_smmuv3_pmu.c             | 4 +---
 drivers/perf/cxl_pmu.c                    | 4 +---
 drivers/perf/dwc_pcie_pmu.c               | 4 +---
 drivers/perf/fsl_imx8_ddr_perf.c          | 4 +---
 drivers/perf/fsl_imx9_ddr_perf.c          | 4 +---
 drivers/perf/hisilicon/hisi_pcie_pmu.c    | 4 +---
 drivers/perf/hisilicon/hisi_uncore_pmu.c  | 4 +---
 drivers/perf/hisilicon/hns3_pmu.c         | 4 +---
 drivers/perf/marvell_cn10k_ddr_pmu.c      | 4 +---
 drivers/perf/marvell_cn10k_tad_pmu.c      | 4 +---
 drivers/perf/qcom_l2_pmu.c                | 4 +---
 drivers/perf/qcom_l3_pmu.c                | 4 +---
 drivers/perf/thunderx2_pmu.c              | 4 +---
 drivers/perf/xgene_pmu.c                  | 4 +---
 22 files changed, 22 insertions(+), 66 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index 42172939721b..9bacb79a86c4 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -696,9 +696,7 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
 		.stop		= ali_drw_pmu_stop,
 		.read		= ali_drw_pmu_read,
 		.attr_groups	= ali_drw_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	ret = perf_pmu_register(&drw_pmu->pmu, name, -1);
diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index 6fcd37b11dd8..e6370ea08231 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -483,9 +483,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
 	*pmu = (struct ddr_pmu) {
 		.pmu = {
 			.module		= THIS_MODULE,
-			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-					  PERF_PMU_CAP_NO_SAMPLING |
-					  PERF_PMU_CAP_NO_COMMON_EVENTS,
+			.capabilities	= PERF_PMU_UNCORE_CAPS,
 			.task_ctx_nr	= perf_invalid_context,
 			.attr_groups	= attr_groups,
 			.event_init	= meson_ddr_perf_event_init,
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 2ccce0e66ada..916e9881adf9 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1407,9 +1407,7 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 		.stop		= cci_pmu_stop,
 		.read		= pmu_read,
 		.attr_groups	= pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	cci_pmu->plat_device = pdev;
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 2adb6a1d136f..3f2f41ee476e 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1257,9 +1257,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 		.read = arm_ccn_pmu_event_read,
 		.pmu_enable = arm_ccn_pmu_enable,
 		.pmu_disable = arm_ccn_pmu_disable,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
-				PERF_PMU_CAP_NO_SAMPLING |
-				PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities = PERF_PMU_UNCORE_CAPS,
 	};
 
 	/* No overflow interrupt? Have to use a timer instead. */
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 26ede1db1f72..e779da94351a 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2463,9 +2463,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.attr_groups = arm_cmn_attr_groups,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
-				PERF_PMU_CAP_NO_SAMPLING |
-				PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities = PERF_PMU_UNCORE_CAPS,
 		.task_ctx_nr = perf_invalid_context,
 		.pmu_enable = arm_cmn_pmu_enable,
 		.pmu_disable = arm_cmn_pmu_disable,
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index b007e1fdd336..2d9cb2ac0213 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1179,9 +1179,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 		.stop		= arm_cspmu_stop,
 		.read		= arm_cspmu_read,
 		.attr_groups	= (const struct attribute_group **)attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	/* Hardware counter init */
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 98e7c2333cc6..047bff8733c4 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -657,9 +657,7 @@ static int dmc620_pmu_device_probe(struct platform_device *pdev)
 
 	dmc620_pmu->pmu = (struct pmu) {
 		.module = THIS_MODULE,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 		.task_ctx_nr	= perf_invalid_context,
 		.event_init	= dmc620_pmu_event_init,
 		.add		= dmc620_pmu_add,
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 740f8c958976..8d97ef86f9a8 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -742,9 +742,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 		.read		= dsu_pmu_read,
 
 		.attr_groups	= dsu_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index f4e22ff179b9..34669d1314a4 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -857,9 +857,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.stop		= smmu_pmu_event_stop,
 		.read		= smmu_pmu_event_read,
 		.attr_groups	= smmu_pmu_attr_grps,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index e78f8db8ef52..8b7548192245 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -864,9 +864,7 @@ static int cxl_pmu_probe(struct device *dev)
 		.read = cxl_pmu_read,
 		.task_ctx_nr = perf_invalid_context,
 		.attr_groups = cxl_pmu_attr_groups,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
-				PERF_PMU_CAP_NO_SAMPLING |
-				PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities = PERF_PMU_UNCORE_CAPS,
 	};
 
 	if (info->irq <= 0)
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index c2c4a7673e58..bb8d77b470ce 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -625,9 +625,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 		.parent		= &pdev->dev,
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 		.task_ctx_nr	= perf_invalid_context,
 		.event_init	= dwc_pcie_pmu_event_init,
 		.add		= dwc_pcie_pmu_event_add,
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 612216277ea5..1f250ff3075b 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -640,9 +640,7 @@ static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 	*pmu = (struct ddr_pmu) {
 		.pmu = (struct pmu) {
 			.module	      = THIS_MODULE,
-			.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
-					PERF_PMU_CAP_NO_SAMPLING |
-					PERF_PMU_CAP_NO_COMMON_EVENTS,
+			.capabilities = PERF_PMU_UNCORE_CAPS,
 			.task_ctx_nr = perf_invalid_context,
 			.attr_groups = attr_groups,
 			.event_init  = ddr_perf_event_init,
diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 80b4703bef89..a9156f17886b 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -517,9 +517,7 @@ static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 	*pmu = (struct ddr_pmu) {
 		.pmu = (struct pmu) {
 			.module       = THIS_MODULE,
-			.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
-					PERF_PMU_CAP_NO_SAMPLING |
-					PERF_PMU_CAP_NO_COMMON_EVENTS,
+			.capabilities = PERF_PMU_UNCORE_CAPS,
 			.task_ctx_nr  = perf_invalid_context,
 			.attr_groups  = attr_groups,
 			.event_init   = ddr_perf_event_init,
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index d37c65d40a30..35f0407f4e10 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -805,9 +805,7 @@ static int hisi_pcie_alloc_pmu(struct pci_dev *pdev, struct hisi_pcie_pmu *pcie_
 		.read		= hisi_pcie_pmu_read,
 		.task_ctx_nr	= perf_invalid_context,
 		.attr_groups	= hisi_pcie_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	return 0;
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 5de53e76e42f..25d1e704ea25 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -530,9 +530,7 @@ void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
 	pmu->stop               = hisi_uncore_pmu_stop;
 	pmu->read               = hisi_uncore_pmu_read;
 	pmu->attr_groups        = hisi_pmu->pmu_events.attr_groups;
-	pmu->capabilities       = PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS;
+	pmu->capabilities       = PERF_PMU_UNCORE_CAPS;
 }
 EXPORT_SYMBOL_GPL(hisi_pmu_init);
 
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 09bf38e56909..34b1ca3f0bb6 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1422,9 +1422,7 @@ static int hns3_pmu_alloc_pmu(struct pci_dev *pdev, struct hns3_pmu *hns3_pmu)
 		.read		= hns3_pmu_read,
 		.task_ctx_nr	= perf_invalid_context,
 		.attr_groups	= hns3_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	return 0;
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index ebafa39a6b24..ee69077a9320 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -643,9 +643,7 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 
 	ddr_pmu->pmu = (struct pmu) {
 		.module	      = THIS_MODULE,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE |
-				PERF_PMU_CAP_NO_SAMPLING |
-				PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities = PERF_PMU_UNCORE_CAPS,
 		.task_ctx_nr = perf_invalid_context,
 		.attr_groups = cn10k_attr_groups,
 		.event_init  = cn10k_ddr_perf_event_init,
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index aaedb5715d69..c83924a094dc 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -317,9 +317,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 
 		.module		= THIS_MODULE,
 		.attr_groups	= tad_pmu_attr_groups,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 		.task_ctx_nr	= perf_invalid_context,
 
 		.event_init	= tad_pmu_event_init,
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index d85f11c9261f..67e69e0293aa 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -897,9 +897,7 @@ static int l2_cache_pmu_probe(struct platform_device *pdev)
 		.stop		= l2_cache_event_stop,
 		.read		= l2_cache_event_read,
 		.attr_groups	= l2_cache_pmu_attr_grps,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	l2cache_pmu->num_counters = get_num_counters();
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 733067fa68e5..f545c01aa671 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -741,9 +741,7 @@ static int qcom_l3_cache_pmu_probe(struct platform_device *pdev)
 		.read		= qcom_l3_cache__event_read,
 
 		.attr_groups	= qcom_l3_cache_pmu_attr_grps,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	l3pmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index d9da3070f27c..c1e2372f57c5 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -722,9 +722,7 @@ static int tx2_uncore_pmu_register(
 		.start		= tx2_uncore_event_start,
 		.stop		= tx2_uncore_event_stop,
 		.read		= tx2_uncore_event_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index b2d855866354..8cc6989857e8 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1098,9 +1098,7 @@ static int xgene_init_perf(struct xgene_pmu_dev *pmu_dev, char *name)
 		.start		= xgene_perf_start,
 		.stop		= xgene_perf_stop,
 		.read		= xgene_perf_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
-				  PERF_PMU_CAP_NO_SAMPLING |
-				  PERF_PMU_CAP_NO_COMMON_EVENTS,
+		.capabilities	= PERF_PMU_UNCORE_CAPS,
 	};
 
 	/* Hardware counter init */
-- 
2.39.2.101.g768bb238c484.dirty


