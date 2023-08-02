Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49476CF98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHBOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjHBOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:07:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930522D76;
        Wed,  2 Aug 2023 07:07:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372Cr2N8006885;
        Wed, 2 Aug 2023 14:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=pkON1+Bnn8esEwE5+H2rsC3LFGLcCInqH3LHPvEdBXE=;
 b=RFBeEjBAhcLHFAKVMw/Xp5KBCn2Qf1TxMvgkY5uYh657XfjdjUdtLE7nAJwYvxZbnhUK
 AXdcIxTj0MlU7G+J5iMXzUT7yETh7xeAfrq6x7DPN6ehlaKhdCObVcHkiZEhpbjrYVZ8
 IcSuBZdTabDmLS7bKfJjYDJEA1KfTyrHFBITw/7aN45N2rdI6OSw7OzS4ctCzS/nZOUB
 ooLvVN93bbjH7o1MoSi0rxHxYiXWJUddfUhKgMcI+SDYVBBNiLX65kzByu4Rnu1gMdB7
 hl4RqHxnVp1Fqj9bx3S61oN4T3tfJNoo7o1SRDUV3RKQ5fi4Rc9RH7HRDCsxMwuPHaOv zw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s760c2g2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 14:07:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372E7K2H009497
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 14:07:20 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 07:07:13 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <kvalo@kernel.org>,
        <quic_mmanikan@quicinc.com>, <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
Subject: [PATCH v5 07/11] firmware: qcom_scm: ipq5332: add msa lock/unlock support
Date:   Wed, 2 Aug 2023 19:36:02 +0530
Message-ID: <20230802140606.2041889-8-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
References: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q03FPkwOjgvKNB4DAH79Hk6dk-scz9hj
X-Proofpoint-ORIG-GUID: Q03FPkwOjgvKNB4DAH79Hk6dk-scz9hj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020125
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
Changes in v5:
	- Moved to EXPORT_SYMBOL_GPL() because scm driver moved to
	  using EXPORT_SYMBOL_GPL() now.

Changes in v4:
	- Rebased on linux-next

 drivers/firmware/qcom_scm.c            | 78 ++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.h            |  2 +
 include/linux/firmware/qcom/qcom_scm.h |  2 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 5e1ff137ab52..ae5c6e495e19 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -676,6 +676,84 @@ bool qcom_scm_pas_supported(u32 peripheral)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_supported);
 
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
+EXPORT_SYMBOL_GPL(qcom_scm_msa_lock);
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
+EXPORT_SYMBOL_GPL(qcom_scm_msa_unlock);
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
index 0c091a3f6d49..58c476941e71 100644
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

