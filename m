Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC1A7BEA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378183AbjJITPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378336AbjJITPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:15:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292EDA4;
        Mon,  9 Oct 2023 12:15:06 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399HddU2030352;
        Mon, 9 Oct 2023 19:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=FCCxoje8kg6jXSsVtFFxcsmOhpr+5T91c0+ubbqsFgs=;
 b=J84vq+N/xaD6B+CmLttXvw/IhFC5XBbXb1C8tv0gkqX34uuRVz6uqz8ZWJmUb2fl0XAY
 8gKUTXsc7NNP1JmiX36U6Q4mGXpLwLaigIciuau8YhV0/CKS1AoogmQStXmh5RqOMBIE
 NSUa5VFNG9mHDASuXHiXqh5LMEne7Zvt+ilws+gGXCokcNSwxGJUmZWN/hpUpIkqhQ8T
 5EpXcfvDGkgfceWJlmBDDGJfeNAEdQ/JLs374G6CY4VjIx0C2PeJKwTDdV6NAiWvQsiU
 ZX23bjJJNg7d7kvlL0dmxtsau8HyYGzT764Zfusr0viQd2o6TnJMj13qD6nhlk8Sjg+F YA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmj2prugs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 19:14:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399JEuNl023728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 19:14:56 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 9 Oct 2023 12:14:56 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v6 2/2] firmware: arm_scmi: Add qcom smc/hvc transport support
Date:   Mon, 9 Oct 2023 12:14:37 -0700
Message-ID: <20231009191437.27926-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231009191437.27926-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231009191437.27926-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e5u8-HKKd0LbDuYecvFMURSQqJWHE1S0
X-Proofpoint-GUID: e5u8-HKKd0LbDuYecvFMURSQqJWHE1S0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_17,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the support for SCMI message exchange on Qualcomm
virtual platforms.

The hypervisor associates an object-id also known as capability-id
with each smc/hvc doorbell object. The capability-id is used to
identify the doorbell from the VM's capability namespace, similar
to a file-descriptor.

The hypervisor, in addition to the function-id, expects the capability-id
to be passed in x1 register when SMC/HVC call is invoked.

The capability-id is allocated by the hypervisor on bootup and is stored in
the shmem region by the firmware before starting Linux.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c |  1 +
 drivers/firmware/arm_scmi/smc.c    | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 87383c05424b..09371f40d61f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2915,6 +2915,7 @@ static const struct of_device_id scmi_of_match[] = {
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
 	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
+	{ .compatible = "qcom,scmi-smc", .data = &scmi_smc_desc},
 #endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 8eba60a41975..7611e9665038 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/limits.h>
 #include <linux/processor.h>
 #include <linux/slab.h>
 
@@ -50,6 +51,8 @@
  * @func_id: smc/hvc call function id
  * @param_page: 4K page number of the shmem channel
  * @param_offset: Offset within the 4K page of the shmem channel
+ * @cap_id: smc/hvc doorbell's capability id to be used on Qualcomm virtual
+ *	    platforms
  */
 
 struct scmi_smc {
@@ -63,6 +66,7 @@ struct scmi_smc {
 	unsigned long func_id;
 	unsigned long param_page;
 	unsigned long param_offset;
+	unsigned long cap_id;
 };
 
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
@@ -124,6 +128,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx)
 {
 	struct device *cdev = cinfo->dev;
+	unsigned long cap_id = ULONG_MAX;
 	struct scmi_smc *scmi_info;
 	resource_size_t size;
 	struct resource res;
@@ -162,6 +167,18 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (of_device_is_compatible(dev->of_node, "qcom,scmi-smc")) {
+		void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
+		/* The capability-id is kept in last 8 bytes of shmem.
+		 *     +-------+ <-- 0
+		 *     | shmem |
+		 *     +-------+ <-- size - 8
+		 *     | capId |
+		 *     +-------+ <-- size
+		 */
+		memcpy_fromio(&cap_id, ptr, sizeof(cap_id));
+	}
+
 	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
 		scmi_info->param_page = SHMEM_PAGE(res.start);
 		scmi_info->param_offset = SHMEM_OFFSET(res.start);
@@ -184,6 +201,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	}
 
 	scmi_info->func_id = func_id;
+	scmi_info->cap_id = cap_id;
 	scmi_info->cinfo = cinfo;
 	smc_channel_lock_init(scmi_info);
 	cinfo->transport_info = scmi_info;
@@ -220,8 +238,13 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param_page,
-			     scmi_info->param_offset, 0, 0, 0, 0, 0, &res);
+	if (scmi_info->cap_id != ULONG_MAX)
+		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
+				     0, 0, 0, 0, 0, &res);
+	else
+		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param_page,
+				     scmi_info->param_offset, 0, 0, 0, 0, 0,
+				     &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-- 
2.17.1

