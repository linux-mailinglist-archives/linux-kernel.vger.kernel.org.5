Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E779829F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbjIHGqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbjIHGqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:46:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198551BE9;
        Thu,  7 Sep 2023 23:45:52 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388671B3017468;
        Fri, 8 Sep 2023 06:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FkcGwsY0MEmCxawmlqMaX7nMuXMG23ARigiLuYqtETI=;
 b=HmIf8TUupFqspoYEeEup/xQXmp94lvDnYrO34lN6ig+3FupGLVHv/A8+l1qKZMKDmx2Z
 8Ipfo5pkCoADen0BdC0KKNVeWAuXC2FhF5HJqya11jDKeLQS/CzbkvJDqGKPuGwOeFBJ
 F49rtTav9BSccUfqkndbJC5yAv50m1NZVcaSbzoFnLaztBWn3qld4pcQfIN0oEPXLOwq
 EO9G1hQxEudSfp4t1x+cHho04+EZuPZP8SxqntIp2S6b4E69ry1NmQiAhpGy2Wgtfo6w
 N8+eoJZ+suJp+4DOPnHIcQLcwQkvA44OF+Vh5kcQYA6vrljvZanWGxP9W2cZzOplXKl3 jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syf5c1xyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:45:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886jHoX012707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:45:17 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:45:06 -0700
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 2/3] interconnect: qcom: Add SM4450 interconnect provider driver
Date:   Fri, 8 Sep 2023 14:44:26 +0800
Message-ID: <20230908064427.26999-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230908064427.26999-1-quic_tengfan@quicinc.com>
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5BUSRpWLC7QzKmmTLpcFgJBuVI9yaUmV
X-Proofpoint-ORIG-GUID: 5BUSRpWLC7QzKmmTLpcFgJBuVI9yaUmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in SM4450 based
platforms. The topology consists of several NoCs that are controlled
by a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/sm4450.c | 1848 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm4450.h |  152 +++
 4 files changed, 2011 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sm4450.c
 create mode 100644 drivers/interconnect/qcom/sm4450.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 825b647d9169..5a463379d3df 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -182,6 +182,15 @@ config INTERCONNECT_QCOM_SDX65
 	  This is a driver for the Qualcomm Network-on-Chip on sdx65-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SM4450
+	tristate "Qualcomm SM4450 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sm4450-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM6350
 	tristate "Qualcomm SM6350 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 80d9d2da95d1..96228a7e4aa5 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -23,6 +23,7 @@ qnoc-sdm670-objs			:= sdm670.o
 qnoc-sdm845-objs			:= sdm845.o
 qnoc-sdx55-objs				:= sdx55.o
 qnoc-sdx65-objs				:= sdx65.o
+qnoc-sm4450-objs			:= sm4450.o
 qnoc-sm6350-objs			:= sm6350.o
 qnoc-sm8150-objs			:= sm8150.o
 qnoc-sm8250-objs			:= sm8250.o
@@ -51,6 +52,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM670) += qnoc-sdm670.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) += qnoc-sdx65.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM4450) += qnoc-sm4450.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) += qnoc-sm6350.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
diff --git a/drivers/interconnect/qcom/sm4450.c b/drivers/interconnect/qcom/sm4450.c
new file mode 100644
index 000000000000..9cd154939cda
--- /dev/null
+++ b/drivers/interconnect/qcom/sm4450.c
@@ -0,0 +1,1848 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/interconnect/qcom,sm4450.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+#include "icc-rpmh.h"
+#include "sm4450.h"
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SM4450_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a1noc_cfg = {
+	.name = "qnm_a1noc_cfg",
+	.id = SM4450_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM4450_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM4450_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SM4450_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_a2noc_cfg = {
+	.name = "qnm_a2noc_cfg",
+	.id = SM4450_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qnm_cnoc_datapath = {
+	.name = "qnm_cnoc_datapath",
+	.id = SM4450_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM4450_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM4450_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_wcss = {
+	.name = "qxm_wcss",
+	.id = SM4450_MASTER_WLAN,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.id = SM4450_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.id = SM4450_MASTER_QDSS_ETR_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SM4450_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM4450_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM4450_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SM4450_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SM4450_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qnm_cnoc3_cnoc2 = {
+	.name = "qnm_cnoc3_cnoc2",
+	.id = SM4450_MASTER_CNOC3_CNOC2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 38,
+	.links = { SM4450_SLAVE_AHB2PHY_SOUTH, SM4450_SLAVE_AHB2PHY_NORTH,
+		   SM4450_SLAVE_ANOC_THROTTLE_CFG, SM4450_SLAVE_CAMERA_CFG,
+		   SM4450_SLAVE_CLK_CTL, SM4450_SLAVE_RBCPR_CX_CFG,
+		   SM4450_SLAVE_RBCPR_MX_CFG, SM4450_SLAVE_CRYPTO_0_CFG,
+		   SM4450_SLAVE_CX_RDPM, SM4450_SLAVE_DISPLAY_CFG,
+		   SM4450_SLAVE_GFX3D_CFG, SM4450_SLAVE_IMEM_CFG,
+		   SM4450_SLAVE_IPA_CFG, SM4450_SLAVE_IPC_ROUTER_CFG,
+		   SM4450_SLAVE_LPASS, SM4450_SLAVE_CNOC_MSS,
+		   SM4450_SLAVE_MX_RDPM, SM4450_SLAVE_PCIE_0_CFG,
+		   SM4450_SLAVE_PDM, SM4450_SLAVE_PIMEM_CFG,
+		   SM4450_SLAVE_PMU_WRAPPER_CFG, SM4450_SLAVE_PRNG,
+		   SM4450_SLAVE_QUP_0, SM4450_SLAVE_QUP_1,
+		   SM4450_SLAVE_SDC1, SM4450_SLAVE_SDCC_2,
+		   SM4450_SLAVE_TCSR, SM4450_SLAVE_TLMM,
+		   SM4450_SLAVE_UFS_MEM_CFG, SM4450_SLAVE_USB3_0,
+		   SM4450_SLAVE_VENUS_CFG, SM4450_SLAVE_VSENSE_CTRL_CFG,
+		   SM4450_SLAVE_A1NOC_CFG, SM4450_SLAVE_A2NOC_CFG,
+		   SM4450_SLAVE_CNOC_MNOC_CFG, SM4450_SLAVE_PCIE_ANOC_CFG,
+		   SM4450_SLAVE_SNOC_CFG, SM4450_SLAVE_VIDEO_ANOC_CFG },
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SM4450_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 39,
+	.links = { SM4450_SLAVE_AHB2PHY_SOUTH, SM4450_SLAVE_AHB2PHY_NORTH,
+		   SM4450_SLAVE_ANOC_THROTTLE_CFG, SM4450_SLAVE_CAMERA_CFG,
+		   SM4450_SLAVE_CLK_CTL, SM4450_SLAVE_RBCPR_CX_CFG,
+		   SM4450_SLAVE_RBCPR_MX_CFG, SM4450_SLAVE_CRYPTO_0_CFG,
+		   SM4450_SLAVE_CX_RDPM, SM4450_SLAVE_DISPLAY_CFG,
+		   SM4450_SLAVE_GFX3D_CFG, SM4450_SLAVE_IMEM_CFG,
+		   SM4450_SLAVE_IPA_CFG, SM4450_SLAVE_IPC_ROUTER_CFG,
+		   SM4450_SLAVE_LPASS, SM4450_SLAVE_CNOC_MSS,
+		   SM4450_SLAVE_MX_RDPM, SM4450_SLAVE_PCIE_0_CFG,
+		   SM4450_SLAVE_PDM, SM4450_SLAVE_PIMEM_CFG,
+		   SM4450_SLAVE_PMU_WRAPPER_CFG, SM4450_SLAVE_PRNG,
+		   SM4450_SLAVE_QUP_0, SM4450_SLAVE_QUP_1,
+		   SM4450_SLAVE_SDC1, SM4450_SLAVE_SDCC_2,
+		   SM4450_SLAVE_TCSR, SM4450_SLAVE_TLMM,
+		   SM4450_SLAVE_UFS_MEM_CFG, SM4450_SLAVE_USB3_0,
+		   SM4450_SLAVE_VENUS_CFG, SM4450_SLAVE_VSENSE_CTRL_CFG,
+		   SM4450_SLAVE_A1NOC_CFG, SM4450_SLAVE_A2NOC_CFG,
+		   SM4450_SLAVE_CNOC2_CNOC3, SM4450_SLAVE_CNOC_MNOC_CFG,
+		   SM4450_SLAVE_PCIE_ANOC_CFG, SM4450_SLAVE_SNOC_CFG,
+		   SM4450_SLAVE_VIDEO_ANOC_CFG },
+};
+
+static struct qcom_icc_node qnm_cnoc2_cnoc3 = {
+	.name = "qnm_cnoc2_cnoc3",
+	.id = SM4450_MASTER_CNOC2_CNOC3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 11,
+	.links = { SM4450_SLAVE_AOSS, SM4450_SLAVE_APPSS,
+		   SM4450_SLAVE_QDSS_CFG, SM4450_SLAVE_TME_CFG,
+		   SM4450_SLAVE_WLAN, SM4450_SLAVE_CNOC_A2NOC,
+		   SM4450_SLAVE_BOOT_IMEM, SM4450_SLAVE_IMEM,
+		   SM4450_SLAVE_PIMEM, SM4450_SLAVE_QDSS_STM,
+		   SM4450_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SM4450_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 11,
+	.links = { SM4450_SLAVE_AOSS, SM4450_SLAVE_APPSS,
+		   SM4450_SLAVE_QDSS_CFG, SM4450_SLAVE_TME_CFG,
+		   SM4450_SLAVE_WLAN, SM4450_SLAVE_CNOC3_CNOC2,
+		   SM4450_SLAVE_BOOT_IMEM, SM4450_SLAVE_IMEM,
+		   SM4450_SLAVE_PIMEM, SM4450_SLAVE_QDSS_STM,
+		   SM4450_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SM4450_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_PCIE_0 },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SM4450_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SM4450_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SM4450_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC,
+		   SM4450_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SM4450_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.id = SM4450_MASTER_MSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC,
+		   SM4450_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM4450_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM4450_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SM4450_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM4450_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM4450_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC,
+		   SM4450_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qxm_wlan_q6 = {
+	.name = "qxm_wlan_q6",
+	.id = SM4450_MASTER_WLAN_Q6,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SM4450_SLAVE_GEM_NOC_CNOC, SM4450_SLAVE_LLCC,
+		   SM4450_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhm_config_noc = {
+	.name = "qhm_config_noc",
+	.id = SM4450_MASTER_CNOC_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 6,
+	.links = { SM4450_SLAVE_LPASS_CORE_CFG, SM4450_SLAVE_LPASS_LPI_CFG,
+		   SM4450_SLAVE_LPASS_MPU_CFG, SM4450_SLAVE_LPASS_TOP_CFG,
+		   SM4450_SLAVE_SERVICES_LPASS_AML_NOC, SM4450_SLAVE_SERVICE_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qxm_lpass_dsp = {
+	.name = "qxm_lpass_dsp",
+	.id = SM4450_MASTER_LPASS_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 4,
+	.links = { SM4450_SLAVE_LPASS_TOP_CFG, SM4450_SLAVE_LPASS_SNOC,
+		   SM4450_SLAVE_SERVICES_LPASS_AML_NOC, SM4450_SLAVE_SERVICE_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM4450_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SM4450_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = SM4450_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = SM4450_MASTER_CAMNOC_SF,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.id = SM4450_MASTER_MDP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_cfg = {
+	.name = "qnm_mnoc_cfg",
+	.id = SM4450_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qnm_video0 = {
+	.name = "qnm_video0",
+	.id = SM4450_MASTER_VIDEO_P0_MMNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cpu = {
+	.name = "qnm_video_cpu",
+	.id = SM4450_MASTER_VIDEO_PROC_MMNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_pcie_anoc_cfg = {
+	.name = "qnm_pcie_anoc_cfg",
+	.id = SM4450_MASTER_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SERVICE_PCIE_ANOC },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SM4450_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node qhm_gic = {
+	.name = "qhm_gic",
+	.id = SM4450_MASTER_GIC_AHB,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM4450_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM4450_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_lpass_noc = {
+	.name = "qnm_lpass_noc",
+	.id = SM4450_MASTER_LPASS_ANOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_snoc_cfg = {
+	.name = "qnm_snoc_cfg",
+	.id = SM4450_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SM4450_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM4450_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qnm_video_anoc_cfg = {
+	.name = "qnm_video_anoc_cfg",
+	.id = SM4450_MASTER_VIDEO_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_SERVICE_SRVC_VIDEO_ANOC },
+};
+
+static struct qcom_icc_node qxm_video_0 = {
+	.name = "qxm_video_0",
+	.id = SM4450_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_VIDEO_0_ANOC_MMNOC },
+};
+
+static struct qcom_icc_node qxm_video_1 = {
+	.name = "qxm_video_1",
+	.id = SM4450_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_VIDEO_1_ANOC_MMNOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf_disp = {
+	.name = "qnm_mnoc_hf_disp",
+	.id = SM4450_MASTER_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node qnm_pcie_disp = {
+	.name = "qnm_pcie_disp",
+	.id = SM4450_MASTER_ANOC_PCIE_GEM_NOC_DISP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_LLCC_DISP },
+};
+
+static struct qcom_icc_node llcc_mc_disp = {
+	.name = "llcc_mc_disp",
+	.id = SM4450_MASTER_LLCC_DISP,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_EBI1_DISP },
+};
+
+static struct qcom_icc_node qnm_mdp_disp = {
+	.name = "qnm_mdp_disp",
+	.id = SM4450_MASTER_MDP_DISP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_SLAVE_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM4450_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SM4450_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM4450_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SM4450_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SM4450_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SM4450_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SM4450_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SM4450_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_anoc_throttle_cfg = {
+	.name = "qhs_anoc_throttle_cfg",
+	.id = SM4450_SLAVE_ANOC_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM4450_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM4450_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM4450_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SM4450_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM4450_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SM4450_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM4450_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM4450_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM4450_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM4450_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SM4450_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_cfg = {
+	.name = "qhs_lpass_cfg",
+	.id = SM4450_SLAVE_LPASS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_MASTER_CNOC_LPASS_AG_NOC },
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SM4450_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.id = SM4450_SLAVE_MX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SM4450_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SM4450_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SM4450_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pmu_wrapper_cfg = {
+	.name = "qhs_pmu_wrapper_cfg",
+	.id = SM4450_SLAVE_PMU_WRAPPER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SM4450_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SM4450_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SM4450_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SM4450_SLAVE_SDC1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM4450_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM4450_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SM4450_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM4450_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM4450_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM4450_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM4450_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_a1_noc_cfg = {
+	.name = "qns_a1_noc_cfg",
+	.id = SM4450_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qns_a2_noc_cfg = {
+	.name = "qns_a2_noc_cfg",
+	.id = SM4450_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qns_cnoc2_cnoc3 = {
+	.name = "qns_cnoc2_cnoc3",
+	.id = SM4450_SLAVE_CNOC2_CNOC3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_MASTER_CNOC2_CNOC3 },
+};
+
+static struct qcom_icc_node qns_mnoc_cfg = {
+	.name = "qns_mnoc_cfg",
+	.id = SM4450_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qns_pcie_anoc_cfg = {
+	.name = "qns_pcie_anoc_cfg",
+	.id = SM4450_SLAVE_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_MASTER_PCIE_ANOC_CFG },
+};
+
+static struct qcom_icc_node qns_snoc_cfg = {
+	.name = "qns_snoc_cfg",
+	.id = SM4450_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qns_video_anoc_cfg = {
+	.name = "qns_video_anoc_cfg",
+	.id = SM4450_SLAVE_VIDEO_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM4450_MASTER_VIDEO_ANOC_CFG },
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM4450_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SM4450_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM4450_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.id = SM4450_SLAVE_TME_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_wcss = {
+	.name = "qhs_wcss",
+	.id = SM4450_SLAVE_WLAN,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_cnoc3_cnoc2 = {
+	.name = "qns_cnoc3_cnoc2",
+	.id = SM4450_SLAVE_CNOC3_CNOC2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_MASTER_CNOC3_CNOC2 },
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = SM4450_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.id = SM4450_SLAVE_BOOT_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM4450_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SM4450_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SM4450_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM4450_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM4450_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SM4450_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM4450_SLAVE_LLCC,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SM4450_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qhs_lpass_core = {
+	.name = "qhs_lpass_core",
+	.id = SM4450_SLAVE_LPASS_CORE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_lpi = {
+	.name = "qhs_lpass_lpi",
+	.id = SM4450_SLAVE_LPASS_LPI_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_mpu = {
+	.name = "qhs_lpass_mpu",
+	.id = SM4450_SLAVE_LPASS_MPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lpass_top = {
+	.name = "qhs_lpass_top",
+	.id = SM4450_SLAVE_LPASS_TOP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_sysnoc = {
+	.name = "qns_sysnoc",
+	.id = SM4450_SLAVE_LPASS_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_MASTER_LPASS_ANOC },
+};
+
+static struct qcom_icc_node srvc_niu_aml_noc = {
+	.name = "srvc_niu_aml_noc",
+	.id = SM4450_SLAVE_SERVICES_LPASS_AML_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_niu_lpass_agnoc = {
+	.name = "srvc_niu_lpass_agnoc",
+	.id = SM4450_SLAVE_SERVICE_LPASS_AG_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM4450_SLAVE_EBI1,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM4450_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SM4450_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SM4450_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SM4450_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_pcie_aggre_noc = {
+	.name = "srvc_pcie_aggre_noc",
+	.id = SM4450_SLAVE_SERVICE_PCIE_ANOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM4450_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM4450_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SM4450_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_video_0 = {
+	.name = "qns_video_0",
+	.id = SM4450_SLAVE_VIDEO_0_ANOC_MMNOC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_MASTER_VIDEO_P0_MMNOC },
+};
+
+static struct qcom_icc_node qns_video_1 = {
+	.name = "qns_video_1",
+	.id = SM4450_SLAVE_VIDEO_1_ANOC_MMNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM4450_MASTER_VIDEO_PROC_MMNOC },
+};
+
+static struct qcom_icc_node srvc_video_aggre_noc = {
+	.name = "srvc_video_aggre_noc",
+	.id = SM4450_SLAVE_SERVICE_SRVC_VIDEO_ANOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_llcc_disp = {
+	.name = "qns_llcc_disp",
+	.id = SM4450_SLAVE_LLCC_DISP,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM4450_MASTER_LLCC_DISP },
+};
+
+static struct qcom_icc_node ebi_disp = {
+	.name = "ebi_disp",
+	.id = SM4450_SLAVE_EBI1_DISP,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf_disp = {
+	.name = "qns_mem_noc_hf_disp",
+	.id = SM4450_SLAVE_MNOC_HF_MEM_NOC_DISP,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM4450_MASTER_MNOC_HF_MEM_NOC_DISP },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 57,
+	.nodes = { &qnm_cnoc3_cnoc2, &xm_qdss_dap,
+		   &qhs_ahb2phy0, &qhs_ahb2phy1,
+		   &qhs_anoc_throttle_cfg, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_cpr_cx,
+		   &qhs_cpr_mx, &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm, &qhs_display_cfg,
+		   &qhs_gpuss_cfg, &qhs_imem_cfg,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_lpass_cfg, &qhs_mss_cfg,
+		   &qhs_mx_rdpm, &qhs_pcie0_cfg,
+		   &qhs_pdm, &qhs_pimem_cfg,
+		   &qhs_pmu_wrapper_cfg, &qhs_prng,
+		   &qhs_qup0, &qhs_qup1,
+		   &qhs_sdc1, &qhs_sdc2,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_ufs_mem_cfg, &qhs_usb3_0,
+		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+		   &qns_a1_noc_cfg, &qns_a2_noc_cfg,
+		   &qns_cnoc2_cnoc3, &qns_mnoc_cfg,
+		   &qns_pcie_anoc_cfg, &qns_snoc_cfg,
+		   &qns_video_anoc_cfg, &qnm_cnoc2_cnoc3,
+		   &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
+		   &qhs_aoss, &qhs_apss,
+		   &qhs_qdss_cfg, &qhs_tme_cfg,
+		   &qhs_wcss, &qns_cnoc3_cnoc2,
+		   &qns_cnoc_a2noc, &qxs_boot_imem,
+		   &qxs_imem, &qxs_pimem,
+		   &xs_pcie_0, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.num_nodes = 8,
+	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
+		   &qnm_camnoc_sf, &qnm_mdp,
+		   &qnm_mnoc_cfg, &qnm_video0,
+		   &qnm_video_cpu, &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.num_nodes = 9,
+	.nodes = { &chm_apps, &qnm_gpu,
+		   &qnm_mdsp, &qnm_mnoc_sf,
+		   &qnm_pcie, &qnm_snoc_gc,
+		   &qnm_snoc_sf, &qns_gem_noc_cnoc,
+		   &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.num_nodes = 4,
+	.nodes = { &qhm_gic, &qxm_pimem,
+		   &xm_gic, &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 3,
+	.nodes = { &qnm_aggre1_noc, &qns_video_0,
+		   &qns_video_1 },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 2,
+	.nodes = { &qxm_lpass_dsp, &qnm_lpass_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_acv_disp = {
+	.name = "ACV",
+	.num_nodes = 1,
+	.nodes = { &ebi_disp },
+};
+
+static struct qcom_icc_bcm bcm_mc0_disp = {
+	.name = "MC0",
+	.num_nodes = 1,
+	.nodes = { &ebi_disp },
+};
+
+static struct qcom_icc_bcm bcm_mm0_disp = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf_disp },
+};
+
+static struct qcom_icc_bcm bcm_mm1_disp = {
+	.name = "MM1",
+	.num_nodes = 1,
+	.nodes = { &qnm_mdp_disp },
+};
+
+static struct qcom_icc_bcm bcm_sh0_disp = {
+	.name = "SH0",
+	.num_nodes = 1,
+	.nodes = { &qns_llcc_disp },
+};
+
+static struct qcom_icc_bcm bcm_sh1_disp = {
+	.name = "SH1",
+	.num_nodes = 1,
+	.nodes = { &qnm_pcie_disp },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_A1NOC_CFG] = &qnm_a1noc_cfg,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
+};
+
+static const struct qcom_icc_desc sm4450_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
+	[MASTER_CNOC_A2NOC] = &qnm_cnoc_datapath,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_WLAN] = &qxm_wcss,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+};
+
+static const struct qcom_icc_desc sm4450_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+};
+
+static const struct qcom_icc_desc sm4450_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc2_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc2_nodes[] = {
+	[MASTER_CNOC3_CNOC2] = &qnm_cnoc3_cnoc2,
+	[MASTER_QDSS_DAP] = &xm_qdss_dap,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_ANOC_THROTTLE_CFG] = &qhs_anoc_throttle_cfg,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_LPASS] = &qhs_lpass_cfg,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
+	[SLAVE_PMU_WRAPPER_CFG] = &qhs_pmu_wrapper_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_SDC1] = &qhs_sdc1,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_A1NOC_CFG] = &qns_a1_noc_cfg,
+	[SLAVE_A2NOC_CFG] = &qns_a2_noc_cfg,
+	[SLAVE_CNOC2_CNOC3] = &qns_cnoc2_cnoc3,
+	[SLAVE_CNOC_MNOC_CFG] = &qns_mnoc_cfg,
+	[SLAVE_PCIE_ANOC_CFG] = &qns_pcie_anoc_cfg,
+	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
+	[SLAVE_VIDEO_ANOC_CFG] = &qns_video_anoc_cfg,
+};
+
+static const struct qcom_icc_desc sm4450_cnoc2 = {
+	.nodes = cnoc2_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
+	.bcms = cnoc2_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc2_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc3_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc3_nodes[] = {
+	[MASTER_CNOC2_CNOC3] = &qnm_cnoc2_cnoc3,
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_APPSS] = &qhs_apss,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_WLAN] = &qhs_wcss,
+	[SLAVE_CNOC3_CNOC2] = &qns_cnoc3_cnoc2,
+	[SLAVE_CNOC_A2NOC] = &qns_cnoc_a2noc,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sm4450_cnoc3 = {
+	.nodes = cnoc3_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
+	.bcms = cnoc3_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc3_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+	&bcm_sh0_disp,
+	&bcm_sh1_disp,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_WLAN_Q6] = &qxm_wlan_q6,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+	[MASTER_MNOC_HF_MEM_NOC_DISP] = &qnm_mnoc_hf_disp,
+	[MASTER_ANOC_PCIE_GEM_NOC_DISP] = &qnm_pcie_disp,
+	[SLAVE_LLCC_DISP] = &qns_llcc_disp,
+};
+
+static const struct qcom_icc_desc sm4450_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
+	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
+	[SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
+	[SLAVE_LPASS_LPI_CFG] = &qhs_lpass_lpi,
+	[SLAVE_LPASS_MPU_CFG] = &qhs_lpass_mpu,
+	[SLAVE_LPASS_TOP_CFG] = &qhs_lpass_top,
+	[SLAVE_LPASS_SNOC] = &qns_sysnoc,
+	[SLAVE_SERVICES_LPASS_AML_NOC] = &srvc_niu_aml_noc,
+	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
+};
+
+static const struct qcom_icc_desc sm4450_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms = lpass_ag_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+	&bcm_acv_disp,
+	&bcm_mc0_disp,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+	[MASTER_LLCC_DISP] = &llcc_mc_disp,
+	[SLAVE_EBI1_DISP] = &ebi_disp,
+};
+
+static const struct qcom_icc_desc sm4450_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+	&bcm_mm0_disp,
+	&bcm_mm1_disp,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
+	[MASTER_VIDEO_P0_MMNOC] = &qnm_video0,
+	[MASTER_VIDEO_PROC_MMNOC] = &qnm_video_cpu,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+	[MASTER_MDP_DISP] = &qnm_mdp_disp,
+	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
+};
+
+static const struct qcom_icc_desc sm4450_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn7,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_ANOC_CFG] = &qnm_pcie_anoc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
+};
+
+static const struct qcom_icc_desc sm4450_pcie_anoc = {
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_GIC_AHB] = &qhm_gic,
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_LPASS_ANOC] = &qnm_lpass_noc,
+	[MASTER_SNOC_CFG] = &qnm_snoc_cfg,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
+};
+
+static const struct qcom_icc_desc sm4450_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const video_aggre_noc_bcms[] = {
+	&bcm_sn2,
+};
+
+static struct qcom_icc_node * const video_aggre_noc_nodes[] = {
+	[MASTER_VIDEO_ANOC_CFG] = &qnm_video_anoc_cfg,
+	[MASTER_VIDEO_P0] = &qxm_video_0,
+	[MASTER_VIDEO_PROC] = &qxm_video_1,
+	[SLAVE_VIDEO_0_ANOC_MMNOC] = &qns_video_0,
+	[SLAVE_VIDEO_1_ANOC_MMNOC] = &qns_video_1,
+	[SLAVE_SERVICE_SRVC_VIDEO_ANOC] = &srvc_video_aggre_noc,
+};
+
+static const struct qcom_icc_desc sm4450_video_aggre_noc = {
+	.nodes = video_aggre_noc_nodes,
+	.num_nodes = ARRAY_SIZE(video_aggre_noc_nodes),
+	.bcms = video_aggre_noc_bcms,
+	.num_bcms = ARRAY_SIZE(video_aggre_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sm4450-aggre1-noc",
+	  .data = &sm4450_aggre1_noc},
+	{ .compatible = "qcom,sm4450-aggre2-noc",
+	  .data = &sm4450_aggre2_noc},
+	{ .compatible = "qcom,sm4450-clk-virt",
+	  .data = &sm4450_clk_virt},
+	{ .compatible = "qcom,sm4450-cnoc2",
+	  .data = &sm4450_cnoc2},
+	{ .compatible = "qcom,sm4450-cnoc3",
+	  .data = &sm4450_cnoc3},
+	{ .compatible = "qcom,sm4450-gem-noc",
+	  .data = &sm4450_gem_noc},
+	{ .compatible = "qcom,sm4450-lpass-ag-noc",
+	  .data = &sm4450_lpass_ag_noc},
+	{ .compatible = "qcom,sm4450-mc-virt",
+	  .data = &sm4450_mc_virt},
+	{ .compatible = "qcom,sm4450-mmss-noc",
+	  .data = &sm4450_mmss_noc},
+	{ .compatible = "qcom,sm4450-pcie-anoc",
+	  .data = &sm4450_pcie_anoc},
+	{ .compatible = "qcom,sm4450-system-noc",
+	  .data = &sm4450_system_noc},
+	{ .compatible = "qcom,sm4450-video-aggre-noc",
+	  .data = &sm4450_video_aggre_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sm4450",
+		.of_match_table = qnoc_of_match,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("sm4450 NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/sm4450.h b/drivers/interconnect/qcom/sm4450.h
new file mode 100644
index 000000000000..388c6837e9bd
--- /dev/null
+++ b/drivers/interconnect/qcom/sm4450.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM4450_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM4450_H
+
+#define SM4450_MASTER_GPU_TCU				0
+#define SM4450_MASTER_SYS_TCU				1
+#define SM4450_MASTER_APPSS_PROC				2
+#define SM4450_MASTER_LLCC				3
+#define SM4450_MASTER_CNOC_LPASS_AG_NOC				4
+#define SM4450_MASTER_GIC_AHB				5
+#define SM4450_MASTER_QDSS_BAM				6
+#define SM4450_MASTER_QUP_0				7
+#define SM4450_MASTER_QUP_1				8
+#define SM4450_MASTER_A1NOC_CFG				9
+#define SM4450_MASTER_A2NOC_CFG				10
+#define SM4450_MASTER_A1NOC_SNOC				11
+#define SM4450_MASTER_A2NOC_SNOC				12
+#define SM4450_MASTER_CAMNOC_HF				13
+#define SM4450_MASTER_CAMNOC_ICP				14
+#define SM4450_MASTER_CAMNOC_SF				15
+#define SM4450_MASTER_CNOC2_CNOC3				16
+#define SM4450_MASTER_CNOC3_CNOC2				17
+#define SM4450_MASTER_CNOC_A2NOC				18
+#define SM4450_MASTER_GEM_NOC_CNOC				19
+#define SM4450_MASTER_GEM_NOC_PCIE_SNOC				20
+#define SM4450_MASTER_GFX3D				21
+#define SM4450_MASTER_LPASS_ANOC				22
+#define SM4450_MASTER_MDP				23
+#define SM4450_MASTER_MSS_PROC				24
+#define SM4450_MASTER_CNOC_MNOC_CFG				25
+#define SM4450_MASTER_MNOC_HF_MEM_NOC				26
+#define SM4450_MASTER_MNOC_SF_MEM_NOC				27
+#define SM4450_MASTER_ANOC_PCIE_GEM_NOC				28
+#define SM4450_MASTER_PCIE_ANOC_CFG				29
+#define SM4450_MASTER_SNOC_CFG				30
+#define SM4450_MASTER_SNOC_GC_MEM_NOC				31
+#define SM4450_MASTER_SNOC_SF_MEM_NOC				32
+#define SM4450_MASTER_VIDEO_P0_MMNOC				33
+#define SM4450_MASTER_VIDEO_ANOC_CFG				34
+#define SM4450_MASTER_VIDEO_PROC_MMNOC				35
+#define SM4450_MASTER_QUP_CORE_0				36
+#define SM4450_MASTER_QUP_CORE_1				37
+#define SM4450_MASTER_CRYPTO				38
+#define SM4450_MASTER_IPA				39
+#define SM4450_MASTER_LPASS_PROC				40
+#define SM4450_MASTER_PIMEM				41
+#define SM4450_MASTER_VIDEO_P0				42
+#define SM4450_MASTER_VIDEO_PROC				43
+#define SM4450_MASTER_WLAN				44
+#define SM4450_MASTER_WLAN_Q6				45
+#define SM4450_MASTER_GIC				46
+#define SM4450_MASTER_PCIE_0				47
+#define SM4450_MASTER_QDSS_DAP				48
+#define SM4450_MASTER_QDSS_ETR				49
+#define SM4450_MASTER_QDSS_ETR_1				50
+#define SM4450_MASTER_SDCC_1				51
+#define SM4450_MASTER_SDCC_2				52
+#define SM4450_MASTER_UFS_MEM				53
+#define SM4450_MASTER_USB3_0				54
+#define SM4450_SLAVE_EBI1				512
+#define SM4450_SLAVE_AHB2PHY_SOUTH				513
+#define SM4450_SLAVE_AHB2PHY_NORTH				514
+#define SM4450_SLAVE_ANOC_THROTTLE_CFG				515
+#define SM4450_SLAVE_AOSS				516
+#define SM4450_SLAVE_APPSS				517
+#define SM4450_SLAVE_CAMERA_CFG				518
+#define SM4450_SLAVE_CLK_CTL				519
+#define SM4450_SLAVE_RBCPR_CX_CFG				520
+#define SM4450_SLAVE_RBCPR_MX_CFG				521
+#define SM4450_SLAVE_CRYPTO_0_CFG				522
+#define SM4450_SLAVE_CX_RDPM				523
+#define SM4450_SLAVE_DISPLAY_CFG				524
+#define SM4450_SLAVE_GFX3D_CFG				525
+#define SM4450_SLAVE_IMEM_CFG				526
+#define SM4450_SLAVE_IPA_CFG				527
+#define SM4450_SLAVE_IPC_ROUTER_CFG				528
+#define SM4450_SLAVE_LPASS				529
+#define SM4450_SLAVE_LPASS_CORE_CFG				530
+#define SM4450_SLAVE_LPASS_LPI_CFG				531
+#define SM4450_SLAVE_LPASS_MPU_CFG				532
+#define SM4450_SLAVE_LPASS_TOP_CFG				533
+#define SM4450_SLAVE_CNOC_MSS				534
+#define SM4450_SLAVE_MX_RDPM				535
+#define SM4450_SLAVE_PCIE_0_CFG				536
+#define SM4450_SLAVE_PDM				537
+#define SM4450_SLAVE_PIMEM_CFG				538
+#define SM4450_SLAVE_PMU_WRAPPER_CFG				539
+#define SM4450_SLAVE_PRNG				540
+#define SM4450_SLAVE_QDSS_CFG				541
+#define SM4450_SLAVE_QUP_0				542
+#define SM4450_SLAVE_QUP_1				543
+#define SM4450_SLAVE_SDC1				544
+#define SM4450_SLAVE_SDCC_2				545
+#define SM4450_SLAVE_TCSR				546
+#define SM4450_SLAVE_TLMM				547
+#define SM4450_SLAVE_TME_CFG				548
+#define SM4450_SLAVE_UFS_MEM_CFG				549
+#define SM4450_SLAVE_USB3_0				550
+#define SM4450_SLAVE_VENUS_CFG				551
+#define SM4450_SLAVE_VSENSE_CTRL_CFG				552
+#define SM4450_SLAVE_WLAN				553
+#define SM4450_SLAVE_A1NOC_CFG				554
+#define SM4450_SLAVE_A1NOC_SNOC				555
+#define SM4450_SLAVE_A2NOC_CFG				556
+#define SM4450_SLAVE_A2NOC_SNOC				557
+#define SM4450_SLAVE_CNOC2_CNOC3				558
+#define SM4450_SLAVE_CNOC3_CNOC2				559
+#define SM4450_SLAVE_CNOC_A2NOC				560
+#define SM4450_SLAVE_GEM_NOC_CNOC				561
+#define SM4450_SLAVE_SNOC_GEM_NOC_GC				562
+#define SM4450_SLAVE_SNOC_GEM_NOC_SF				563
+#define SM4450_SLAVE_LLCC				564
+#define SM4450_SLAVE_MNOC_HF_MEM_NOC				565
+#define SM4450_SLAVE_MNOC_SF_MEM_NOC				566
+#define SM4450_SLAVE_CNOC_MNOC_CFG				567
+#define SM4450_SLAVE_MEM_NOC_PCIE_SNOC				568
+#define SM4450_SLAVE_PCIE_ANOC_CFG				569
+#define SM4450_SLAVE_ANOC_PCIE_GEM_NOC				570
+#define SM4450_SLAVE_SNOC_CFG				571
+#define SM4450_SLAVE_LPASS_SNOC				572
+#define SM4450_SLAVE_VIDEO_0_ANOC_MMNOC				573
+#define SM4450_SLAVE_VIDEO_1_ANOC_MMNOC				574
+#define SM4450_SLAVE_VIDEO_ANOC_CFG				575
+#define SM4450_SLAVE_QUP_CORE_0				576
+#define SM4450_SLAVE_QUP_CORE_1				577
+#define SM4450_SLAVE_BOOT_IMEM				578
+#define SM4450_SLAVE_IMEM				579
+#define SM4450_SLAVE_PIMEM				580
+#define SM4450_SLAVE_SERVICE_A1NOC				581
+#define SM4450_SLAVE_SERVICE_A2NOC				582
+#define SM4450_SLAVE_SERVICE_MNOC				583
+#define SM4450_SLAVE_SERVICES_LPASS_AML_NOC				584
+#define SM4450_SLAVE_SERVICE_LPASS_AG_NOC				585
+#define SM4450_SLAVE_SERVICE_PCIE_ANOC				586
+#define SM4450_SLAVE_SERVICE_SNOC				587
+#define SM4450_SLAVE_SERVICE_SRVC_VIDEO_ANOC				588
+#define SM4450_SLAVE_PCIE_0				589
+#define SM4450_SLAVE_QDSS_STM				590
+#define SM4450_SLAVE_TCU				591
+#define SM4450_MASTER_LLCC_DISP				1000
+#define SM4450_MASTER_MDP_DISP				1001
+#define SM4450_MASTER_MNOC_HF_MEM_NOC_DISP				1002
+#define SM4450_MASTER_ANOC_PCIE_GEM_NOC_DISP				1003
+#define SM4450_SLAVE_EBI1_DISP				1512
+#define SM4450_SLAVE_LLCC_DISP				1513
+#define SM4450_SLAVE_MNOC_HF_MEM_NOC_DISP				1514
+
+#endif
-- 
2.17.1

