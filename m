Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6A7929FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353665AbjIEQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350183AbjIEE7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:59:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E63CCB;
        Mon,  4 Sep 2023 21:59:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3854xfFC027125;
        Tue, 5 Sep 2023 04:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=m1baVapMu7p3QLJfVKIyJwW7DmTtc8YPb08q31i8XNk=;
 b=MXkens9aIqkD3iCllkSleyTHuAq8tEKGWGjbz6l/T7rIibCziyIY/ZL3KwLEkgdwfhK1
 9aazqkxM8Gi2e/z13hydfqRYlsxp4smgMUvuDlnSZnnpVvsiws4k8TWbHj+weMkInHe4
 eqB0KThw4it2pi7FmQ0dqxr0vnxU5Rpt04szzvqWIWni81uyI2jJscB/cvjPK4ZKMiXb
 bBVmjL6uC8dMWuyou74DYb4YjjrmvRMYl+NqjOAkhaL5uQbGtyDC0Ctp+XncjH0zCT4M
 s+sXyjAayCUoL68VSgnb1q/kZa4Gm1qzHwWKLwBw4KrEh+0fbbTlTClwoIa4NMBlxTfo SA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sweb51fqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 04:59:41 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3854xbwF027998;
        Tue, 5 Sep 2023 04:59:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kawcp-1;
        Tue, 05 Sep 2023 04:59:37 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3854xb2s027973;
        Tue, 5 Sep 2023 04:59:37 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3854xb4N027985;
        Tue, 05 Sep 2023 04:59:37 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 987AE1D1C; Tue,  5 Sep 2023 10:29:36 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 2/2] interconnect: qcom: Add SDX75 interconnect provider driver
Date:   Tue,  5 Sep 2023 10:29:35 +0530
Message-Id: <1693889975-19122-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693889975-19122-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1693889975-19122-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FtmH02ZpnhvMbJSBhYQEpGYPaBvodnm2
X-Proofpoint-GUID: FtmH02ZpnhvMbJSBhYQEpGYPaBvodnm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050043
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in SDX75.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/sdx75.c  | 1134 ++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sdx75.h  |   97 +++
 4 files changed, 1242 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sdx75.c
 create mode 100644 drivers/interconnect/qcom/sdx75.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 825b647..62b516d 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -182,6 +182,15 @@ config INTERCONNECT_QCOM_SDX65
 	  This is a driver for the Qualcomm Network-on-Chip on sdx65-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SDX75
+	tristate "Qualcomm SDX75 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on sdx75-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM6350
 	tristate "Qualcomm SM6350 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index ab98892..55cd503 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -23,6 +23,7 @@ qnoc-sdm670-objs			:= sdm670.o
 qnoc-sdm845-objs			:= sdm845.o
 qnoc-sdx55-objs				:= sdx55.o
 qnoc-sdx65-objs				:= sdx65.o
+qnoc-sdx75-objs				:= sdx75.o
 qnoc-sm6350-objs			:= sm6350.o
 qnoc-sm8150-objs			:= sm8150.o
 qnoc-sm8250-objs			:= sm8250.o
@@ -51,6 +52,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM670) += qnoc-sdm670.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) += qnoc-sdx55.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) += qnoc-sdx65.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SDX75) += qnoc-sdx75.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) += qnoc-sm6350.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
new file mode 100644
index 0000000..4a2ab0c
--- /dev/null
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -0,0 +1,1134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,sdx75.h>
+
+#include "bcm-voter.h"
+#include "icc-common.h"
+#include "icc-rpmh.h"
+#include "sdx75.h"
+
+static struct qcom_icc_node qpic_core_master = {
+	.name = "qpic_core_master",
+	.id = SDX75_MASTER_QPIC_CORE,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_QPIC_CORE },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SDX75_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.id = SDX75_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 4,
+	.links = { SDX75_SLAVE_LAGG_CFG, SDX75_SLAVE_MCCC_MASTER,
+		   SDX75_SLAVE_GEM_NOC_CFG, SDX75_SLAVE_SNOOP_BWMON },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SDX75_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SDX75_MASTER_APPSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
+		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cfg = {
+	.name = "qnm_gemnoc_cfg",
+	.id = SDX75_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_SERVICE_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.id = SDX75_MASTER_MSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
+		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SDX75_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SDX75_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
+		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SDX75_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node xm_ipa2pcie = {
+	.name = "xm_ipa2pcie",
+	.id = SDX75_MASTER_IPA_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SDX75_MASTER_LLCC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SDX75_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SDX75_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_2 = {
+	.name = "xm_pcie3_2",
+	.id = SDX75_MASTER_PCIE_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node qhm_audio = {
+	.name = "qhm_audio",
+	.id = SDX75_MASTER_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qhm_gic = {
+	.name = "qhm_gic",
+	.id = SDX75_MASTER_GIC_AHB,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qhm_pcie_rscc = {
+	.name = "qhm_pcie_rscc",
+	.id = SDX75_MASTER_PCIE_RSCC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 31,
+	.links = { SDX75_SLAVE_ETH0_CFG, SDX75_SLAVE_ETH1_CFG,
+		   SDX75_SLAVE_AUDIO, SDX75_SLAVE_CLK_CTL,
+		   SDX75_SLAVE_CRYPTO_0_CFG, SDX75_SLAVE_IMEM_CFG,
+		   SDX75_SLAVE_IPA_CFG, SDX75_SLAVE_IPC_ROUTER_CFG,
+		   SDX75_SLAVE_CNOC_MSS, SDX75_SLAVE_ICBDI_MVMSS_CFG,
+		   SDX75_SLAVE_PCIE_0_CFG, SDX75_SLAVE_PCIE_1_CFG,
+		   SDX75_SLAVE_PCIE_2_CFG, SDX75_SLAVE_PDM,
+		   SDX75_SLAVE_PRNG, SDX75_SLAVE_QDSS_CFG,
+		   SDX75_SLAVE_QPIC, SDX75_SLAVE_QUP_0,
+		   SDX75_SLAVE_SDCC_1, SDX75_SLAVE_SDCC_4,
+		   SDX75_SLAVE_SPMI_VGI_COEX, SDX75_SLAVE_TCSR,
+		   SDX75_SLAVE_TLMM, SDX75_SLAVE_USB3,
+		   SDX75_SLAVE_USB3_PHY_CFG, SDX75_SLAVE_DDRSS_CFG,
+		   SDX75_SLAVE_SNOC_CFG, SDX75_SLAVE_PCIE_ANOC_CFG,
+		   SDX75_SLAVE_IMEM, SDX75_SLAVE_QDSS_STM,
+		   SDX75_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SDX75_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhm_qpic = {
+	.name = "qhm_qpic",
+	.id = SDX75_MASTER_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SDX75_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qnm_aggre_noc = {
+	.name = "qnm_aggre_noc",
+	.id = SDX75_MASTER_ANOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SDX75_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 32,
+	.links = { SDX75_SLAVE_ETH0_CFG, SDX75_SLAVE_ETH1_CFG,
+		   SDX75_SLAVE_AUDIO, SDX75_SLAVE_CLK_CTL,
+		   SDX75_SLAVE_CRYPTO_0_CFG, SDX75_SLAVE_IMEM_CFG,
+		   SDX75_SLAVE_IPA_CFG, SDX75_SLAVE_IPC_ROUTER_CFG,
+		   SDX75_SLAVE_CNOC_MSS, SDX75_SLAVE_ICBDI_MVMSS_CFG,
+		   SDX75_SLAVE_PCIE_0_CFG, SDX75_SLAVE_PCIE_1_CFG,
+		   SDX75_SLAVE_PCIE_2_CFG, SDX75_SLAVE_PCIE_RSC_CFG,
+		   SDX75_SLAVE_PDM, SDX75_SLAVE_PRNG,
+		   SDX75_SLAVE_QDSS_CFG, SDX75_SLAVE_QPIC,
+		   SDX75_SLAVE_QUP_0, SDX75_SLAVE_SDCC_1,
+		   SDX75_SLAVE_SDCC_4, SDX75_SLAVE_SPMI_VGI_COEX,
+		   SDX75_SLAVE_TCSR, SDX75_SLAVE_TLMM,
+		   SDX75_SLAVE_USB3, SDX75_SLAVE_USB3_PHY_CFG,
+		   SDX75_SLAVE_DDRSS_CFG, SDX75_SLAVE_SNOC_CFG,
+		   SDX75_SLAVE_PCIE_ANOC_CFG, SDX75_SLAVE_IMEM,
+		   SDX75_SLAVE_QDSS_STM, SDX75_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SDX75_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SDX75_SLAVE_PCIE_0, SDX75_SLAVE_PCIE_1,
+		   SDX75_SLAVE_PCIE_2 },
+};
+
+static struct qcom_icc_node qnm_system_noc_cfg = {
+	.name = "qnm_system_noc_cfg",
+	.id = SDX75_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_system_noc_pcie_cfg = {
+	.name = "qnm_system_noc_pcie_cfg",
+	.id = SDX75_MASTER_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_SERVICE_PCIE_ANOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SDX75_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SDX75_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qxm_mvmss = {
+	.name = "qxm_mvmss",
+	.id = SDX75_MASTER_MVMSS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node xm_emac_0 = {
+	.name = "xm_emac_0",
+	.id = SDX75_MASTER_EMAC_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node xm_emac_1 = {
+	.name = "xm_emac_1",
+	.id = SDX75_MASTER_EMAC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node xm_qdss_etr0 = {
+	.name = "xm_qdss_etr0",
+	.id = SDX75_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node xm_qdss_etr1 = {
+	.name = "xm_qdss_etr1",
+	.id = SDX75_MASTER_QDSS_ETR_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SDX75_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SDX75_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node xm_usb3 = {
+	.name = "xm_usb3",
+	.id = SDX75_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_SLAVE_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qpic_core_slave = {
+	.name = "qpic_core_slave",
+	.id = SDX75_SLAVE_QPIC_CORE,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SDX75_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_lagg = {
+	.name = "qhs_lagg",
+	.id = SDX75_SLAVE_LAGG_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mccc_master = {
+	.name = "qhs_mccc_master",
+	.id = SDX75_SLAVE_MCCC_MASTER,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc = {
+	.name = "qns_gemnoc",
+	.id = SDX75_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_snoop_bwmon = {
+	.name = "qss_snoop_bwmon",
+	.id = SDX75_SLAVE_SNOOP_BWMON,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc_cnoc = {
+	.name = "qns_gemnoc_cnoc",
+	.id = SDX75_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SDX75_SLAVE_LLCC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX75_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SDX75_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX75_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_gemnoc = {
+	.name = "srvc_gemnoc",
+	.id = SDX75_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SDX75_SLAVE_EBI1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_pcie_gemnoc = {
+	.name = "qns_pcie_gemnoc",
+	.id = SDX75_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX75_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node ps_eth0_cfg = {
+	.name = "ps_eth0_cfg",
+	.id = SDX75_SLAVE_ETH0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node ps_eth1_cfg = {
+	.name = "ps_eth1_cfg",
+	.id = SDX75_SLAVE_ETH1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_audio = {
+	.name = "qhs_audio",
+	.id = SDX75_SLAVE_AUDIO,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SDX75_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto_cfg = {
+	.name = "qhs_crypto_cfg",
+	.id = SDX75_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SDX75_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SDX75_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SDX75_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SDX75_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mvmss_cfg = {
+	.name = "qhs_mvmss_cfg",
+	.id = SDX75_SLAVE_ICBDI_MVMSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SDX75_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SDX75_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie2_cfg = {
+	.name = "qhs_pcie2_cfg",
+	.id = SDX75_SLAVE_PCIE_2_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie_rscc = {
+	.name = "qhs_pcie_rscc",
+	.id = SDX75_SLAVE_PCIE_RSC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SDX75_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SDX75_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SDX75_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qpic = {
+	.name = "qhs_qpic",
+	.id = SDX75_SLAVE_QPIC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SDX75_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SDX75_SLAVE_SDCC_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SDX75_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_spmi_vgi_coex = {
+	.name = "qhs_spmi_vgi_coex",
+	.id = SDX75_SLAVE_SPMI_VGI_COEX,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SDX75_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SDX75_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3 = {
+	.name = "qhs_usb3",
+	.id = SDX75_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_phy = {
+	.name = "qhs_usb3_phy",
+	.id = SDX75_SLAVE_USB3_PHY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_a1noc = {
+	.name = "qns_a1noc",
+	.id = SDX75_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SDX75_MASTER_ANOC_SNOC },
+};
+
+static struct qcom_icc_node qns_ddrss_cfg = {
+	.name = "qns_ddrss_cfg",
+	.id = SDX75_SLAVE_DDRSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SDX75_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SDX75_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_system_noc_cfg = {
+	.name = "qns_system_noc_cfg",
+	.id = SDX75_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qns_system_noc_pcie_cfg = {
+	.name = "qns_system_noc_pcie_cfg",
+	.id = SDX75_SLAVE_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SDX75_MASTER_PCIE_ANOC_CFG },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SDX75_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_pcie_system_noc = {
+	.name = "srvc_pcie_system_noc",
+	.id = SDX75_SLAVE_SERVICE_PCIE_ANOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_system_noc = {
+	.name = "srvc_system_noc",
+	.id = SDX75_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SDX75_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SDX75_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_2 = {
+	.name = "xs_pcie_2",
+	.id = SDX75_SLAVE_PCIE_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SDX75_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SDX75_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
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
+	.num_nodes = 39,
+	.nodes = { &qhm_pcie_rscc, &qnm_gemnoc_cnoc,
+		   &ps_eth0_cfg, &ps_eth1_cfg,
+		   &qhs_audio, &qhs_clk_ctl,
+		   &qhs_crypto_cfg, &qhs_imem_cfg,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_mss_cfg, &qhs_mvmss_cfg,
+		   &qhs_pcie0_cfg, &qhs_pcie1_cfg,
+		   &qhs_pcie2_cfg, &qhs_pcie_rscc,
+		   &qhs_pdm, &qhs_prng,
+		   &qhs_qdss_cfg, &qhs_qpic,
+		   &qhs_qup0, &qhs_sdc1,
+		   &qhs_sdc4, &qhs_spmi_vgi_coex,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_usb3, &qhs_usb3_phy,
+		   &qns_ddrss_cfg, &qns_system_noc_cfg,
+		   &qns_system_noc_pcie_cfg, &qxs_imem,
+		   &srvc_pcie_system_noc, &srvc_system_noc,
+		   &xs_pcie_0, &xs_pcie_1,
+		   &xs_pcie_2, &xs_qdss_stm,
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
+static struct qcom_icc_bcm bcm_qp0 = {
+	.name = "QP0",
+	.num_nodes = 1,
+	.nodes = { &qpic_core_slave },
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
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.num_nodes = 10,
+	.nodes = { &alm_sys_tcu, &chm_apps,
+		   &qnm_gemnoc_cfg, &qnm_mdsp,
+		   &qnm_snoc_sf, &xm_gic,
+		   &xm_ipa2pcie, &qns_gemnoc_cnoc,
+		   &qns_pcie, &srvc_gemnoc },
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
+	.num_nodes = 21,
+	.nodes = { &xm_pcie3_0, &xm_pcie3_1,
+		   &xm_pcie3_2, &qhm_audio,
+		   &qhm_gic, &qhm_qdss_bam,
+		   &qhm_qpic, &qhm_qup0,
+		   &qnm_gemnoc_pcie, &qnm_system_noc_cfg,
+		   &qnm_system_noc_pcie_cfg, &qxm_crypto,
+		   &qxm_ipa, &qxm_mvmss,
+		   &xm_emac_0, &xm_emac_1,
+		   &xm_qdss_etr0, &xm_qdss_etr1,
+		   &xm_sdc1, &xm_sdc4,
+		   &xm_usb3 },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 2,
+	.nodes = { &qnm_aggre_noc, &qns_a1noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 2,
+	.nodes = { &qnm_pcie, &qns_pcie_gemnoc },
+};
+
+static struct qcom_icc_bcm *clk_virt_bcms[] = {
+	&bcm_qp0,
+	&bcm_qup0,
+};
+
+static struct qcom_icc_node *clk_virt_nodes[] = {
+	[MASTER_QPIC_CORE] = &qpic_core_master,
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[SLAVE_QPIC_CORE] = &qpic_core_slave,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+};
+
+static struct qcom_icc_desc sdx75_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm *dc_noc_bcms[] = {
+};
+
+static struct qcom_icc_node *dc_noc_nodes[] = {
+	[MASTER_CNOC_DC_NOC] = &qnm_cnoc,
+	[SLAVE_LAGG_CFG] = &qhs_lagg,
+	[SLAVE_MCCC_MASTER] = &qhs_mccc_master,
+	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
+	[SLAVE_SNOOP_BWMON] = &qss_snoop_bwmon,
+};
+
+static struct qcom_icc_desc sdx75_dc_noc = {
+	.nodes = dc_noc_nodes,
+	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
+	.bcms = dc_noc_bcms,
+	.num_bcms = ARRAY_SIZE(dc_noc_bcms),
+};
+
+static struct qcom_icc_bcm *gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node *gem_noc_nodes[] = {
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GEM_NOC_CFG] = &qnm_gemnoc_cfg,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_GIC] = &xm_gic,
+	[MASTER_IPA_PCIE] = &xm_ipa2pcie,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gemnoc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+	[SLAVE_SERVICE_GEM_NOC] = &srvc_gemnoc,
+};
+
+static struct qcom_icc_desc sdx75_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm *mc_virt_bcms[] = {
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node *mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static struct qcom_icc_desc sdx75_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm *pcie_anoc_bcms[] = {
+	&bcm_sn1,
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node *pcie_anoc_nodes[] = {
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[MASTER_PCIE_2] = &xm_pcie3_2,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_gemnoc,
+};
+
+static struct qcom_icc_desc sdx75_pcie_anoc = {
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+};
+
+static struct qcom_icc_bcm *system_noc_bcms[] = {
+	&bcm_ce0,
+	&bcm_cn0,
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+};
+
+static struct qcom_icc_node *system_noc_nodes[] = {
+	[MASTER_AUDIO] = &qhm_audio,
+	[MASTER_GIC_AHB] = &qhm_gic,
+	[MASTER_PCIE_RSCC] = &qhm_pcie_rscc,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QPIC] = &qhm_qpic,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_ANOC_SNOC] = &qnm_aggre_noc,
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[MASTER_SNOC_CFG] = &qnm_system_noc_cfg,
+	[MASTER_PCIE_ANOC_CFG] = &qnm_system_noc_pcie_cfg,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_MVMSS] = &qxm_mvmss,
+	[MASTER_EMAC_0] = &xm_emac_0,
+	[MASTER_EMAC_1] = &xm_emac_1,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr1,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_SDCC_4] = &xm_sdc4,
+	[MASTER_USB3_0] = &xm_usb3,
+	[SLAVE_ETH0_CFG] = &ps_eth0_cfg,
+	[SLAVE_ETH1_CFG] = &ps_eth1_cfg,
+	[SLAVE_AUDIO] = &qhs_audio,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_ICBDI_MVMSS_CFG] = &qhs_mvmss_cfg,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PCIE_2_CFG] = &qhs_pcie2_cfg,
+	[SLAVE_PCIE_RSC_CFG] = &qhs_pcie_rscc,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QPIC] = &qhs_qpic,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_SDCC_1] = &qhs_sdc1,
+	[SLAVE_SDCC_4] = &qhs_sdc4,
+	[SLAVE_SPMI_VGI_COEX] = &qhs_spmi_vgi_coex,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_USB3] = &qhs_usb3,
+	[SLAVE_USB3_PHY_CFG] = &qhs_usb3_phy,
+	[SLAVE_A1NOC_CFG] = &qns_a1noc,
+	[SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+	[SLAVE_SNOC_CFG] = &qns_system_noc_cfg,
+	[SLAVE_PCIE_ANOC_CFG] = &qns_system_noc_pcie_cfg,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_system_noc,
+	[SLAVE_SERVICE_SNOC] = &srvc_system_noc,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+	[SLAVE_PCIE_2] = &xs_pcie_2,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static struct qcom_icc_desc sdx75_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = qcom_icc_rpmh_probe(pdev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to register ICC provider\n");
+
+	return ret;
+}
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sdx75-clk-virt",
+	  .data = &sdx75_clk_virt
+	},
+	{ .compatible = "qcom,sdx75-dc-noc",
+	  .data = &sdx75_dc_noc
+	},
+	{ .compatible = "qcom,sdx75-gem-noc",
+	  .data = &sdx75_gem_noc
+	},
+	{ .compatible = "qcom,sdx75-mc-virt",
+	  .data = &sdx75_mc_virt
+	},
+	{ .compatible = "qcom,sdx75-pcie-anoc",
+	  .data = &sdx75_pcie_anoc
+	},
+	{ .compatible = "qcom,sdx75-system-noc",
+	  .data = &sdx75_system_noc
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qnoc_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sdx75",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
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
+
+MODULE_DESCRIPTION("SDX75 NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/sdx75.h b/drivers/interconnect/qcom/sdx75.h
new file mode 100644
index 0000000..24e8871
--- /dev/null
+++ b/drivers/interconnect/qcom/sdx75.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX75_H
+#define __DRIVERS_INTERCONNECT_QCOM_SDX75_H
+
+#define SDX75_MASTER_ANOC_PCIE_GEM_NOC		0
+#define SDX75_MASTER_ANOC_SNOC			1
+#define SDX75_MASTER_APPSS_PROC			2
+#define SDX75_MASTER_AUDIO			3
+#define SDX75_MASTER_CNOC_DC_NOC		4
+#define SDX75_MASTER_CRYPTO			5
+#define SDX75_MASTER_EMAC_0			6
+#define SDX75_MASTER_EMAC_1			7
+#define SDX75_MASTER_GEM_NOC_CFG		8
+#define SDX75_MASTER_GEM_NOC_CNOC		9
+#define SDX75_MASTER_GEM_NOC_PCIE_SNOC		10
+#define SDX75_MASTER_GIC			11
+#define SDX75_MASTER_GIC_AHB			12
+#define SDX75_MASTER_IPA			13
+#define SDX75_MASTER_IPA_PCIE			14
+#define SDX75_MASTER_LLCC			15
+#define SDX75_MASTER_MSS_PROC			16
+#define SDX75_MASTER_MVMSS			17
+#define SDX75_MASTER_PCIE_0			18
+#define SDX75_MASTER_PCIE_1			19
+#define SDX75_MASTER_PCIE_2			20
+#define SDX75_MASTER_PCIE_ANOC_CFG		21
+#define SDX75_MASTER_PCIE_RSCC			22
+#define SDX75_MASTER_QDSS_BAM			23
+#define SDX75_MASTER_QDSS_ETR			24
+#define SDX75_MASTER_QDSS_ETR_1			25
+#define SDX75_MASTER_QPIC			26
+#define SDX75_MASTER_QPIC_CORE			27
+#define SDX75_MASTER_QUP_0			28
+#define SDX75_MASTER_QUP_CORE_0			29
+#define SDX75_MASTER_SDCC_1			30
+#define SDX75_MASTER_SDCC_4			31
+#define SDX75_MASTER_SNOC_CFG			32
+#define SDX75_MASTER_SNOC_SF_MEM_NOC		33
+#define SDX75_MASTER_SYS_TCU			34
+#define SDX75_MASTER_USB3_0			35
+#define SDX75_SLAVE_A1NOC_CFG			36
+#define SDX75_SLAVE_ANOC_PCIE_GEM_NOC		37
+#define SDX75_SLAVE_AUDIO			38
+#define SDX75_SLAVE_CLK_CTL			39
+#define SDX75_SLAVE_CRYPTO_0_CFG		40
+#define SDX75_SLAVE_CNOC_MSS			41
+#define SDX75_SLAVE_DDRSS_CFG			42
+#define SDX75_SLAVE_EBI1			43
+#define SDX75_SLAVE_ETH0_CFG			44
+#define SDX75_SLAVE_ETH1_CFG			45
+#define SDX75_SLAVE_GEM_NOC_CFG			46
+#define SDX75_SLAVE_GEM_NOC_CNOC		47
+#define SDX75_SLAVE_ICBDI_MVMSS_CFG		48
+#define SDX75_SLAVE_IMEM			49
+#define SDX75_SLAVE_IMEM_CFG			50
+#define SDX75_SLAVE_IPA_CFG			51
+#define SDX75_SLAVE_IPC_ROUTER_CFG		52
+#define SDX75_SLAVE_LAGG_CFG			53
+#define SDX75_SLAVE_LLCC			54
+#define SDX75_SLAVE_MCCC_MASTER			55
+#define SDX75_SLAVE_MEM_NOC_PCIE_SNOC		56
+#define SDX75_SLAVE_PCIE_0			57
+#define SDX75_SLAVE_PCIE_1			58
+#define SDX75_SLAVE_PCIE_2			59
+#define SDX75_SLAVE_PCIE_0_CFG			60
+#define SDX75_SLAVE_PCIE_1_CFG			61
+#define SDX75_SLAVE_PCIE_2_CFG			62
+#define SDX75_SLAVE_PCIE_ANOC_CFG		63
+#define SDX75_SLAVE_PCIE_RSC_CFG		64
+#define SDX75_SLAVE_PDM				65
+#define SDX75_SLAVE_PRNG			66
+#define SDX75_SLAVE_QDSS_CFG			67
+#define SDX75_SLAVE_QDSS_STM			68
+#define SDX75_SLAVE_QPIC			69
+#define SDX75_SLAVE_QPIC_CORE			70
+#define SDX75_SLAVE_QUP_0			71
+#define SDX75_SLAVE_QUP_CORE_0			72
+#define SDX75_SLAVE_SDCC_1			73
+#define SDX75_SLAVE_SDCC_4			74
+#define SDX75_SLAVE_SERVICE_GEM_NOC		75
+#define SDX75_SLAVE_SERVICE_PCIE_ANOC		76
+#define SDX75_SLAVE_SERVICE_SNOC		77
+#define SDX75_SLAVE_SNOC_CFG			78
+#define SDX75_SLAVE_SNOC_GEM_NOC_SF		79
+#define SDX75_SLAVE_SNOOP_BWMON			80
+#define SDX75_SLAVE_SPMI_VGI_COEX		81
+#define SDX75_SLAVE_TCSR			82
+#define SDX75_SLAVE_TCU				83
+#define SDX75_SLAVE_TLMM			84
+#define SDX75_SLAVE_USB3			85
+#define SDX75_SLAVE_USB3_PHY_CFG		86
+
+#endif
-- 
2.7.4

