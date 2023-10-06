Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E0E7BBD1B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjJFQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjJFQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:43:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C41B4;
        Fri,  6 Oct 2023 09:42:49 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396DNswK011104;
        Fri, 6 Oct 2023 16:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kB8eOZJBMvny52vQeYnm+Wv5EpaqlsdgYlz93kNPdOw=;
 b=iVTJOX+0DQZv/ghNbI/p5AAFznz6zmJ8QQaCQgIYKZl1tRzqk8EIOGSJt3eNVICdqTCQ
 Zwb/aTMmNBBKLY2YZQDiWac/zu+yHeSnEW9nRFY8YB3SrcsUJLdYo6FkxHLV0SBSw3Qe
 OuHCAIMZF6t/Rvjiy3WZU/bGwIISRkt1oZEQF2BVtS7fBxuXxYp3sU5nwX+S7NHUYfop
 +/DVPPOz0j95pH9pkWFZ2gFJf864/RO7SSIqajAsetSgzt2+dpcjJEqEUBXGADrnRC2j
 v60T/7yXJ60zI1r2/BWvtwvuRH5meQ76zOBGeYXgRDUQCqqtuaWOAZIspRW6Os0QRr0M 1A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thrjduv17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 16:42:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 396GgOd2017744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 16:42:25 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 09:42:24 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v5 2/2] firmware: arm_scmi: Add qcom smc/hvc transport support
Date:   Fri, 6 Oct 2023 09:42:06 -0700
Message-ID: <20231006164206.40710-3-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231006164206.40710-1-quic_nkela@quicinc.com>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FOxYL3WpXLFpz8jxYFS1weZUFJ0vQZzL
X-Proofpoint-GUID: FOxYL3WpXLFpz8jxYFS1weZUFJ0vQZzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060125
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
with each smc/hvc doorbell object. The capability-id is used to
identify the doorbell from the VM's capability namespace, similar
to a file-descriptor.

The hypervisor, in addition to the function-id, expects the capability-id
to be passed in x1 register when SMC/HVC call is invoked.

The capability-id is allocated by the hypervisor on bootup and is stored in
the shmem region by the firmware before starting Linux.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/driver.c |  1 +
 drivers/firmware/arm_scmi/smc.c    | 33 ++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

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
index c193516a254d..3d594d65ab14 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -50,6 +50,8 @@
  * @func_id: smc/hvc call function id
  * @param_page: 4K page number of the shmem channel
  * @param_offset: Offset within the 4K page of the shmem channel
+ * @cap_id: smc/hvc doorbell's capability id to be used on Qualcomm virtual
+ *	    platforms
  */
 
 struct scmi_smc {
@@ -63,6 +65,7 @@ struct scmi_smc {
 	u32 func_id;
 	u32 param_page;
 	u32 param_offset;
+	s64 cap_id;
 };
 
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
@@ -128,6 +131,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	resource_size_t size;
 	struct resource res;
 	struct device_node *np;
+	s64 cap_id = -EINVAL;
 	u32 func_id;
 	int ret;
 
@@ -162,6 +166,25 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (of_device_is_compatible(dev->of_node, "qcom,scmi-smc")) {
+		/* The capability-id is kept in last 8 bytes of shmem.
+		 *     +-------+
+		 *     |       |
+		 *     | shmem |
+		 *     |       |
+		 *     |       |
+		 *     +-------+ <-- (size - 8)
+		 *     | capId |
+		 *     +-------+ <-- size
+		 */
+
+#ifdef CONFIG_64BIT
+		cap_id = ioread64((void *)scmi_info->shmem + size - 8);
+#else
+		cap_id = ioread32((void *)scmi_info->shmem + size - 8);
+#endif
+	}
+
 	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param")) {
 		scmi_info->param_page = SHMEM_PAGE(res.start);
 		scmi_info->param_offset = SHMEM_OFFSET(res.start);
@@ -184,6 +207,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	}
 
 	scmi_info->func_id = func_id;
+	scmi_info->cap_id = cap_id;
 	scmi_info->cinfo = cinfo;
 	smc_channel_lock_init(scmi_info);
 	cinfo->transport_info = scmi_info;
@@ -213,6 +237,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	struct arm_smccc_res res;
 	unsigned long page = scmi_info->param_page;
 	unsigned long offset = scmi_info->param_offset;
+	long cap_id = (long)scmi_info->cap_id;
 
 	/*
 	 * Channel will be released only once response has been
@@ -222,8 +247,12 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 
 	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
 
-	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
-			     &res);
+	if (cap_id >= 0)
+		arm_smccc_1_1_invoke(scmi_info->func_id, cap_id, 0, 0, 0, 0, 0,
+				     0, &res);
+	else
+		arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0,
+				     0, 0, &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-- 
2.17.1

