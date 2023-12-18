Return-Path: <linux-kernel+bounces-3438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C5816C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE561C229C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03217199C7;
	Mon, 18 Dec 2023 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HHwPggij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5091A727;
	Mon, 18 Dec 2023 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIArv0A012855;
	Mon, 18 Dec 2023 11:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=/cCJZyuRsfh7Pp2thDUrqC1Vjur5pNpx8OcU5IE0yu4=; b=HH
	wPggijAubWFaot9K8AKI0mqt5u5ZDHKkcq1IeVLSTz5ye96hKl6cXhjAio2MvGnW
	DtyTb3u21bOhJHu2zvnyKigEZW2e6Yj8LQqTBk0RmXwqkNXylrLioOQPDe9LmqYx
	C4G+x0c3BkiscXqkyABH5vqtHwJCJi9xcE/XQ7KPpeljjWLYPR5yipN+CI0/UP3j
	r6gYDX1n/BBfpK96I1mPELaWne6BE5Io7wmEo7fB6LdcghTsLgBuWt6EDXXcuJxd
	f/acwdQt5PNhkSCZCQirElRtSLBDnG1xSRJ5syxBZ9yz4kQv8+9A2Owrn+8z7AKd
	DEBHm8bmBTgwkQCYUxSA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0gb9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7xI030045;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyhq-1;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7pP030023;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6B5029967;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 308CA22D0; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 07/34] media: iris: initialize power resources
Date: Mon, 18 Dec 2023 17:02:02 +0530
Message-Id: <1702899149-21321-8-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mpnP_L6Zh2IFbIFYHUa1mah8F_DXeVza
X-Proofpoint-GUID: mpnP_L6Zh2IFbIFYHUa1mah8F_DXeVza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support for initializing Iris "resources", which are clocks,
interconnects, power domains, reset clocks, and clock frequencies
used for Iris hardware.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   3 +-
 .../media/platform/qcom/vcodec/iris/iris_core.h    |  16 ++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |   8 +
 .../media/platform/qcom/vcodec/iris/resources.c    | 232 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/resources.h    |  36 ++++
 5 files changed, 294 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/resources.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 5536ae0..0748819 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -1,3 +1,4 @@
-iris-objs += iris_probe.o
+iris-objs += iris_probe.o \
+             resources.o
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index ab7fcee..c2bc95d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -19,6 +19,14 @@
  * @vdev_dec: iris video device structure for decoder
  * @v4l2_file_ops: iris v4l2 file ops
  * @v4l2_ioctl_ops: iris v4l2 ioctl ops
+ * @bus_tbl: table of iris buses
+ * @bus_count: count of iris buses
+ * @power_domain_tbl: table of iris power domains
+ * @pd_count: count of iris power domains
+ * @clock_tbl: table of iris clocks
+ * @clk_count: count of iris clocks
+ * @reset_tbl: table of iris reset clocks
+ * @reset_count: count of iris reset clocks
  */
 
 struct iris_core {
@@ -29,6 +37,14 @@ struct iris_core {
 	struct video_device			*vdev_dec;
 	const struct v4l2_file_operations	*v4l2_file_ops;
 	const struct v4l2_ioctl_ops		*v4l2_ioctl_ops;
+	struct bus_info				*bus_tbl;
+	u32					bus_count;
+	struct power_domain_info		*power_domain_tbl;
+	u32					pd_count;
+	struct clock_info			*clock_tbl;
+	u32					clk_count;
+	struct reset_info			*reset_tbl;
+	u32					reset_count;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 2e93118..7bb9c92 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 
 #include "iris_core.h"
+#include "resources.h"
 
 static int iris_register_video_device(struct iris_core *core)
 {
@@ -73,6 +74,13 @@ static int iris_probe(struct platform_device *pdev)
 	if (core->irq < 0)
 		return core->irq;
 
+	ret = init_resources(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: init resource failed with %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/resources.c b/drivers/media/platform/qcom/vcodec/iris/resources.c
new file mode 100644
index 0000000..5aebbe4
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/resources.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/clock/qcom,sm8550-gcc.h>
+#include <dt-bindings/clock/qcom,sm8450-videocc.h>
+
+#include <linux/clk.h>
+#include <linux/interconnect.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/sort.h>
+
+#include "iris_core.h"
+#include "resources.h"
+
+static const struct bus_info plat_bus_table[] = {
+	{ NULL, "iris-cnoc", 1000, 1000     },
+	{ NULL, "iris-ddr",  1000, 15000000 },
+};
+
+static const char * const plat_pd_table[] = { "iris-ctl", "vcodec", NULL };
+#define PD_COUNT 2
+
+static const char * const plat_opp_pd_table[] = { "mxc", "mmcx", NULL };
+#define OPP_PD_COUNT 2
+
+static const struct clock_info plat_clk_table[] = {
+	{ NULL, "gcc_video_axi0", GCC_VIDEO_AXI0_CLK, 0, 0 },
+	{ NULL, "core_clk",       VIDEO_CC_MVS0C_CLK, 0, 0 },
+	{ NULL, "vcodec_core",    VIDEO_CC_MVS0_CLK,  1, 0 },
+};
+
+static const char * const plat_clk_reset_table[] = { "video_axi_reset", NULL };
+#define RESET_COUNT 1
+
+static void iris_pd_release(void *res)
+{
+	struct device *pd = (struct device *)res;
+
+	dev_pm_domain_detach(pd, true);
+}
+
+static int iris_pd_get(struct iris_core *core, struct power_domain_info *pdinfo)
+{
+	int ret;
+
+	pdinfo->genpd_dev = dev_pm_domain_attach_by_name(core->dev, pdinfo->name);
+	if (IS_ERR_OR_NULL(pdinfo->genpd_dev))
+		ret = PTR_ERR(pdinfo->genpd_dev) ? : -ENODATA;
+
+	ret = devm_add_action_or_reset(core->dev, iris_pd_release, (void *)pdinfo->genpd_dev);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static void iris_opp_dl_release(void *res)
+{
+	struct device_link *link = (struct device_link *)res;
+
+	device_link_del(link);
+}
+
+static int iris_opp_dl_get(struct device *dev, struct device *supplier)
+{
+	u32 flag = DL_FLAG_RPM_ACTIVE | DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS;
+	struct device_link *link = NULL;
+	int ret;
+
+	link = device_link_add(dev, supplier, flag);
+	if (!link)
+		return -EINVAL;
+
+	ret = devm_add_action_or_reset(dev, iris_opp_dl_release, (void *)link);
+
+	return ret;
+}
+
+static int init_bus(struct iris_core *core)
+{
+	struct bus_info *binfo = NULL;
+	u32 i = 0;
+
+	core->bus_count = ARRAY_SIZE(plat_bus_table);
+	core->bus_tbl = devm_kzalloc(core->dev,
+				     sizeof(struct bus_info) * core->bus_count,
+				     GFP_KERNEL);
+	if (!core->bus_tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < core->bus_count; i++) {
+		binfo = &core->bus_tbl[i];
+		binfo->name = plat_bus_table[i].name;
+		binfo->bw_min_kbps = plat_bus_table[i].bw_min_kbps;
+		binfo->bw_max_kbps = plat_bus_table[i].bw_max_kbps;
+		binfo->icc = devm_of_icc_get(core->dev, binfo->name);
+		if (IS_ERR(binfo->icc)) {
+			dev_err(core->dev,
+				"%s: failed to get bus: %s\n", __func__, binfo->name);
+			return PTR_ERR(binfo->icc);
+		}
+	}
+
+	return 0;
+}
+
+static int init_power_domains(struct iris_core *core)
+{
+	struct power_domain_info *pdinfo = NULL;
+	struct device **opp_vdevs = NULL;
+	int ret;
+	u32 i;
+
+	core->pd_count = PD_COUNT;
+	core->power_domain_tbl = devm_kzalloc(core->dev,
+					      sizeof(struct power_domain_info) * core->pd_count,
+					      GFP_KERNEL);
+	if (!core->power_domain_tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < core->pd_count; i++) {
+		pdinfo = &core->power_domain_tbl[i];
+		pdinfo->name = plat_pd_table[i];
+		ret = iris_pd_get(core, pdinfo);
+		if (ret) {
+			dev_err(core->dev,
+				"%s: failed to get pd: %s\n", __func__, pdinfo->name);
+			return ret;
+		}
+	}
+
+	ret = devm_pm_opp_attach_genpd(core->dev, plat_opp_pd_table, &opp_vdevs);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < OPP_PD_COUNT; i++) {
+		ret = iris_opp_dl_get(core->dev, opp_vdevs[i]);
+		if (ret) {
+			dev_err(core->dev, "%s: failed to create dl: %s\n",
+				__func__, dev_name(opp_vdevs[i]));
+			return ret;
+		}
+	}
+
+	ret = devm_pm_opp_of_add_table(core->dev);
+	if (ret) {
+		dev_err(core->dev, "%s: failed to add opp table\n", __func__);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int init_clocks(struct iris_core *core)
+{
+	struct clock_info *cinfo = NULL;
+	u32 i;
+
+	core->clk_count = ARRAY_SIZE(plat_clk_table);
+	core->clock_tbl = devm_kzalloc(core->dev,
+				       sizeof(struct clock_info) * core->clk_count,
+				       GFP_KERNEL);
+	if (!core->clock_tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < core->clk_count; i++) {
+		cinfo = &core->clock_tbl[i];
+		cinfo->name = plat_clk_table[i].name;
+		cinfo->clk_id = plat_clk_table[i].clk_id;
+		cinfo->has_scaling = plat_clk_table[i].has_scaling;
+		cinfo->clk = devm_clk_get(core->dev, cinfo->name);
+		if (IS_ERR(cinfo->clk)) {
+			dev_err(core->dev,
+				"%s: failed to get clock: %s\n", __func__, cinfo->name);
+			return PTR_ERR(cinfo->clk);
+		}
+	}
+
+	return 0;
+}
+
+static int init_reset_clocks(struct iris_core *core)
+{
+	struct reset_info *rinfo = NULL;
+	u32 i = 0;
+
+	core->reset_count = RESET_COUNT;
+	core->reset_tbl = devm_kzalloc(core->dev,
+				       sizeof(struct reset_info) * core->reset_count,
+				       GFP_KERNEL);
+	if (!core->reset_tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < core->reset_count; i++) {
+		rinfo = &core->reset_tbl[i];
+		rinfo->name = plat_clk_reset_table[i];
+		rinfo->rst = devm_reset_control_get(core->dev, rinfo->name);
+		if (IS_ERR(rinfo->rst)) {
+			dev_err(core->dev,
+				"%s: failed to get reset clock: %s\n", __func__, rinfo->name);
+			return PTR_ERR(rinfo->rst);
+		}
+	}
+
+	return 0;
+}
+
+int init_resources(struct iris_core *core)
+{
+	int ret;
+
+	ret = init_bus(core);
+	if (ret)
+		return ret;
+
+	ret = init_power_domains(core);
+	if (ret)
+		return ret;
+
+	ret = init_clocks(core);
+	if (ret)
+		return ret;
+
+	ret = init_reset_clocks(core);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/resources.h b/drivers/media/platform/qcom/vcodec/iris/resources.h
new file mode 100644
index 0000000..d21bcc7e
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/resources.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _RESOURCES_H_
+#define _RESOURCES_H_
+
+struct bus_info {
+	struct icc_path		*icc;
+	const char		*name;
+	u32			bw_min_kbps;
+	u32			bw_max_kbps;
+};
+
+struct power_domain_info {
+	struct device	*genpd_dev;
+	const char	*name;
+};
+
+struct clock_info {
+	struct clk	*clk;
+	const char	*name;
+	u32		clk_id;
+	bool		has_scaling;
+	u64		prev;
+};
+
+struct reset_info {
+	struct reset_control	*rst;
+	const char		*name;
+};
+
+int init_resources(struct iris_core *core);
+
+#endif
-- 
2.7.4


