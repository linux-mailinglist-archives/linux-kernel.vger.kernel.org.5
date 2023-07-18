Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447CB757B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGRMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjGRMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:06:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCC1E75;
        Tue, 18 Jul 2023 05:06:23 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I8bPae008258;
        Tue, 18 Jul 2023 12:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=89PMC3uMaAzZYyOh9GbfqpkOLPRQTXDVrosnns8+W8M=;
 b=UnTA7F0MHM19qONLo1IeS7c0QuoC4UA+lzj3BgP8QQV1eKfyiJktNbowYO/kLK6INbdg
 jWSkflKSRP/UH5cEz8RJ/f8jOcxg6QHyHyiCwo+TVa89LZc4iPkmRWQK2ARxi0PseJl8
 BrvBzrN1BfFjhScCVN7mDAOUAQ5Dm/paKe/AUFnOurYRHzxiStozO1xjdI2E8sPs5aaK
 mxw7ShgV3WyLbP4f9aOSAUa5hrR/rGHapwIFCsa/VmVb4eIutoZqqAXTIJ6QPwzXOEUT
 qj+YDfQEZmLXHgpOB3nSZQ5WqrrYcotOdduzPk5kd9wTjSfNPgiNLIQCncHMHdkCx/Yq 9Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwfj79epv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:06:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IC6IHJ006944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:06:18 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 05:06:11 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [V3,07/11] firmware: qcom_scm: ipq5332: add msa lock/unlock support
Date:   Tue, 18 Jul 2023 17:34:57 +0530
Message-ID: <20230718120501.3205661-8-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
References: <20230718120501.3205661-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H4iKHfParW9wB009IOwq7iWwBnP6XOVV
X-Proofpoint-ORIG-GUID: H4iKHfParW9wB009IOwq7iWwBnP6XOVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_08,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5332 user pd remoteproc firmwares need to be locked
with MSA(modem secure access) features. This patch add
support to lock/unlock MSA features.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 drivers/firmware/qcom_scm.c            | 78 ++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h            |  2 +
 include/linux/firmware/qcom/qcom_scm.h |  2 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 5553201e4599..accb8d112980 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -680,6 +680,84 @@ bool qcom_scm_pas_supported(u32 peripheral)
 }
 EXPORT_SYMBOL(qcom_scm_pas_supported);
 
+/**
+ * qcom_scm_msa_lock() - Lock given peripheral firmware region as MSA
+ *
+ * @peripheral:	peripheral id
+ *
+ * Return 0 on success.
+ */
+int qcom_scm_msa_lock(u32 peripheral)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_MSA_LOCK,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
+					  QCOM_SCM_MSA_LOCK))
+		return 0;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	qcom_scm_bw_disable();
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+EXPORT_SYMBOL(qcom_scm_msa_lock);
+
+/**
+ * qcom_scm_msa_unlock() - Unlock given peripheral MSA firmware region
+ *
+ * @peripheral:	peripheral id
+ *
+ * Return 0 on success.
+ */
+int qcom_scm_msa_unlock(u32 peripheral)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_MSA_UNLOCK,
+		.arginfo = QCOM_SCM_ARGS(1),
+		.args[0] = peripheral,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	struct qcom_scm_res res;
+
+	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
+					  QCOM_SCM_MSA_UNLOCK))
+		return 0;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	qcom_scm_bw_disable();
+	qcom_scm_clk_disable();
+
+	return ret ? : res.result[0];
+}
+EXPORT_SYMBOL(qcom_scm_msa_unlock);
+
 static int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 6ab5e7c77e8d..9480b0b57c3d 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -97,6 +97,8 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_PIL_PAS_SHUTDOWN	0x06
 #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
 #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
+#define QCOM_SCM_MSA_LOCK		0x24
+#define QCOM_SCM_MSA_UNLOCK		0x25
 
 #define QCOM_SCM_SVC_IO			0x05
 #define QCOM_SCM_IO_READ		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 250ea4efb7cb..a150e2914483 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -81,6 +81,8 @@ extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
 extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
 extern int qcom_scm_pas_shutdown(u32 peripheral);
 extern bool qcom_scm_pas_supported(u32 peripheral);
+extern int qcom_scm_msa_lock(u32 peripheral);
+extern int qcom_scm_msa_unlock(u32 peripheral);
 
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
-- 
2.34.1

