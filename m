Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76C879B596
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbjIKV3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbjIKTom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:44:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3018D;
        Mon, 11 Sep 2023 12:44:37 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BFumkc012994;
        Mon, 11 Sep 2023 19:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mgi3HTFjixu9MZpChz8Nvq4m/bMxQQbtlB2jCrztIyo=;
 b=j5nQZ8nqVmdsJwiShQBDI2T2RS/xm3MJkfDl3YVEWFxVqNmA0WV2SE7XuCHDpRLH9+g4
 6bcRtVyzB4NYGwLy3JhzXxS9hpC9HXh7Z+Ut+iGpEEqLxj3m2b4HnYvf3GhHl2rvX8Sj
 OTPIehKpoXod7aDgQgdmmSubP98wzqfqe76El42A+tUPhxph8oKk9MXLu6TRerKS0zES
 8fOZiBT0dFhN+XaTpKSnxy8FKj4Tq6Z2snlwR6VnzJG6LRQA2lFPCHwMQr7yU1vuSzxO
 xtriTQ7WB6CHrF9741fS/wl9Z7EioGawWvehL/9oLiTrgMxoRhgHrbjBYaeLSPw2hFlv Ig== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t25yx0hk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BJiS9s015364
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:28 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 12:44:28 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport support
Date:   Mon, 11 Sep 2023 12:43:59 -0700
Message-ID: <20230911194359.27547-5-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230911194359.27547-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cWCo3C-4s9oE985TCAboIMaTT-9qrCzp
X-Proofpoint-GUID: cWCo3C-4s9oE985TCAboIMaTT-9qrCzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the support for SCMI message exchange on Qualcomm
virtual platforms.

The hypervisor associates an object-id also known as capability-id
with each hvc doorbell object. The capability-id is used to identify the
doorbell from the VM's capability namespace, similar to a file-descriptor.

The hypervisor, in addition to the function-id, expects the capability-id
to be passed in x1 register when HVC call is invoked.

The function-id & capability-id are allocated by the hypervisor on bootup
and are stored in the shmem region by the firmware before starting Linux.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/driver.c |  1 +
 drivers/firmware/arm_scmi/smc.c    | 47 ++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 87383c05424b..ea344bc6ae49 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2915,6 +2915,7 @@ static const struct of_device_id scmi_of_match[] = {
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
 	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
+	{ .compatible = "qcom,scmi-hvc-shmem", .data = &scmi_smc_desc},
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 0a0b7e401159..94ec07fdc14a 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -50,6 +50,9 @@
  * @func_id: smc/hvc call function id
  * @param_page: 4K page number of the shmem channel
  * @param_offset: Offset within the 4K page of the shmem channel
+ * @cap_id: hvc doorbell's capability id to be used on Qualcomm virtual
+ *	    platforms
+ * @qcom_xport: Flag to indicate the transport on Qualcomm virtual platforms
  */
 
 struct scmi_smc {
@@ -63,6 +66,8 @@ struct scmi_smc {
 	u32 func_id;
 	u32 param_page;
 	u32 param_offset;
+	u64 cap_id;
+	bool qcom_xport;
 };
 
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
@@ -129,6 +134,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct resource res;
 	struct device_node *np;
 	u32 func_id;
+	u64 cap_id;
 	int ret;
 
 	if (!tx)
@@ -158,9 +164,34 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 		return -EADDRNOTAVAIL;
 	}
 
-	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
-	if (ret < 0)
-		return ret;
+	if (of_device_is_compatible(dev->of_node, "qcom,scmi-hvc-shmem")) {
+		scmi_info->qcom_xport = true;
+
+		/* The func-id & capability-id are kept in last 16 bytes of shmem.
+		 *     +-------+
+		 *     |       |
+		 *     | shmem |
+		 *     |       |
+		 *     |       |
+		 *     +-------+ <-- (size - 16)
+		 *     | funcId|
+		 *     +-------+ <-- (size - 8)
+		 *     | capId |
+		 *     +-------+ <-- size
+		 */
+
+		func_id = readl((void __iomem *)(scmi_info->shmem) + size - 16);
+#ifdef CONFIG_ARM64
+		cap_id = readq((void __iomem *)(scmi_info->shmem) + size - 8);
+#else
+		/* capability-id is 32 bit wide on 32bit machines */
+		cap_id = readl((void __iomem *)(scmi_info->shmem) + size - 8);
+#endif
+	} else {
+		ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
 		scmi_info->param_page = SHMEM_PAGE(res.start);
@@ -184,6 +215,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	}
 
 	scmi_info->func_id = func_id;
+	scmi_info->cap_id = cap_id;
 	scmi_info->cinfo = cinfo;
 	smc_channel_lock_init(scmi_info);
 	cinfo->transport_info = scmi_info;
@@ -213,6 +245,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	struct arm_smccc_res res;
 	unsigned long page = scmi_info->param_page;
 	unsigned long offset = scmi_info->param_offset;
+	unsigned long cap_id = (unsigned long)scmi_info->cap_id;
 
 	/*
 	 * Channel will be released only once response has been
@@ -222,8 +255,12 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
-			     &res);
+	if (scmi_info->qcom_xport)
+		arm_smccc_1_1_hvc(scmi_info->func_id, cap_id, 0, 0, 0, 0, 0, 0,
+				  &res);
+	else
+		arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0,
+				     0, 0, &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-- 
2.17.1

