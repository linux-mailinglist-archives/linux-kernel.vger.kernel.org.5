Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4CC79B306
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350779AbjIKVlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbjIKToe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:44:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0459193;
        Mon, 11 Sep 2023 12:44:29 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BItcaL010300;
        Mon, 11 Sep 2023 19:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=dXwgTS0Ny2g6neMSgxKdQVcCV0LjZUdNUt2cZfL22BE=;
 b=VqyYXp8ScPWdHqxOz7JvPyR9IH3PzQ0i1qzpGzwtPt6qjFf/y6ZCO20NUuv4xW8aSCD7
 eI0Yle6CEWsvMTcGoC45tjx+gWee4GExiSNPdju5Rq0NNqa+7v7reM5Ri0gw6JrPHm0X
 noGpWoolFv7udF1s/pJKZnQNFGtUs6lSnEpJMQxq+E9XHra5kPkbw2XXG6WL6VG42wmN
 kydjSpfEaxxkzvLU2/kUdBCMHVDTdmLc/M4zTSXlqKq1wfDSXJczBGf26PexDGTqLWhP
 oDfi804rVDQdmwEy/lnVkBVACwPjjO3i+1oYl1C3zf294X8kMr36yhyONWbqnsrsBVEW lQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t25yx0hjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BJiKEb017325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 19:44:20 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 12:44:19 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 1/4] firmware: arm_scmi: Add polling support for completion in smc
Date:   Mon, 11 Sep 2023 12:43:56 -0700
Message-ID: <20230911194359.27547-2-quic_nkela@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lrtdTWT63XNV9I3c9CssayZBTRrk_Q3r
X-Proofpoint-GUID: lrtdTWT63XNV9I3c9CssayZBTRrk_Q3r
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

Currently, the return from the smc call assumes the completion of
the scmi request. However this may not be true in virtual platforms
that are using hvc doorbell.

This change adds a Kconfig to enable the polling for the request
completion.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 drivers/firmware/arm_scmi/Kconfig | 14 ++++++++++++++
 drivers/firmware/arm_scmi/smc.c   | 15 ++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index ea0f5083ac47..771d60f8319f 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -125,6 +125,20 @@ config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
 	  in atomic context too, at the price of using a number of busy-waiting
 	  primitives all over instead. If unsure say N.
 
+config ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION
+	bool "Enable polling support for SCMI SMC transport"
+	depends on ARM_SCMI_TRANSPORT_SMC
+	help
+	  Enable completion polling support for SCMI SMC based transport.
+
+	  If you want the SCMI SMC based transport to poll for the completion,
+	  answer Y.
+	  Enabling completion polling might be desired in the absence of the a2p
+	  irq when the return from smc/hvc call doesn't indicate the completion
+	  of the SCMI requests. This might be useful for instances used in
+	  virtual platforms.
+	  If unsure say N.
+
 config ARM_SCMI_TRANSPORT_VIRTIO
 	bool "SCMI transport based on VirtIO"
 	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index c193516a254d..0a0b7e401159 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -250,6 +250,16 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 	smc_channel_lock_release(scmi_info);
 }
 
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION
+static bool
+smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
+{
+	struct scmi_smc *scmi_info = cinfo->transport_info;
+
+	return shmem_poll_done(scmi_info->shmem, xfer);
+}
+#endif
+
 static const struct scmi_transport_ops scmi_smc_ops = {
 	.chan_available = smc_chan_available,
 	.chan_setup = smc_chan_setup,
@@ -257,6 +267,9 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 	.send_message = smc_send_message,
 	.mark_txdone = smc_mark_txdone,
 	.fetch_response = smc_fetch_response,
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION
+	.poll_done = smc_poll_done,
+#endif
 };
 
 const struct scmi_desc scmi_smc_desc = {
@@ -272,6 +285,6 @@ const struct scmi_desc scmi_smc_desc = {
 	 * for the issued command will be immmediately ready to be fetched
 	 * from the shared memory area.
 	 */
-	.sync_cmds_completed_on_ret = true,
+	.sync_cmds_completed_on_ret = !IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_POLL_COMPLETION),
 	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
 };
-- 
2.17.1

