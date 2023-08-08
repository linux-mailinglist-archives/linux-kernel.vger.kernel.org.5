Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AE2774032
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjHHRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjHHQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:58:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDA55901;
        Tue,  8 Aug 2023 09:00:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3786wDSB006364;
        Tue, 8 Aug 2023 10:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=lD6hjJMAqN8E6FnyY2yf36/AWoZiWhCTs0fWAqCMBIg=;
 b=c9y7MzImP2y9F0OFMwN5Nf/N06h0ApmIggjNANmIOGfwpe06iggRgiiBK33RM9FdWbDb
 T3NYTo+wEZJK19BdnkRlL3hWN97U0QKPHWojJRG2yzNI+g4luXdROzgvDtZd04oq8exH
 +HtTdD0eJCrYsPPkqgJ+2o4CYgZZJ+rdrvoNtl4rk8Ih9cA8DmZeRqOl7GlYstGdF7C6
 OXP/eQKWaBlVfeOkmya0rKF7/MXgp7c2U14Xu69vTX3wHgemoVu5xqfn9SgYvVc9X1UP
 8fmPm6w0+61Fn46fdWbWps95WCXZhb8w+eZdy6peK/RQ+IYnEXBR+nyOuuOTDqKfjcQg Fw== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbcacrtb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 10:00:14 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 378A0CYs025875;
        Tue, 8 Aug 2023 10:00:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3s9fgkpa3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 08 Aug 2023 10:00:12 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378A0CA7025868;
        Tue, 8 Aug 2023 10:00:12 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 378A0Cnr025861;
        Tue, 08 Aug 2023 10:00:12 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 4276A4C37; Tue,  8 Aug 2023 18:00:11 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2] bus: mhi: host: pci_generic: Add SDX75 based modem support
Date:   Tue,  8 Aug 2023 18:00:09 +0800
Message-Id: <1691488809-85310-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o0UXGTYf3JJx3F7FgGyk2IUXYRmWD09t
X-Proofpoint-ORIG-GUID: o0UXGTYf3JJx3F7FgGyk2IUXYRmWD09t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080089
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic info for SDX75 based modems. SDX75 takes longer than expected
(default, 8 seconds) to set ready after reboot. Hence add optional ready
timeout parameter to wait enough for device ready as part of power up
sequence.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
v1->v2: pass appropriate timeout value to mhi_poll_reg_field

 drivers/bus/mhi/host/init.c        |  1 +
 drivers/bus/mhi/host/internal.h    |  2 +-
 drivers/bus/mhi/host/main.c        |  5 +++--
 drivers/bus/mhi/host/pci_generic.c | 22 ++++++++++++++++++++++
 drivers/bus/mhi/host/pm.c          | 24 +++++++++++++++++-------
 include/linux/mhi.h                |  4 ++++
 6 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index f78aefd..65ceac1 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -881,6 +881,7 @@ static int parse_config(struct mhi_controller *mhi_cntrl,
 	if (!mhi_cntrl->timeout_ms)
 		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
 
+	mhi_cntrl->ready_timeout_ms = config->ready_timeout_ms;
 	mhi_cntrl->bounce_buf = config->use_bounce_buf;
 	mhi_cntrl->buffer_len = config->buf_len;
 	if (!mhi_cntrl->buffer_len)
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 2e139e7..30ac415 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -321,7 +321,7 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
 				    u32 *out);
 int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
 				    void __iomem *base, u32 offset, u32 mask,
-				    u32 val, u32 delayus);
+				    u32 val, u32 delayus, u32 timeout_ms);
 void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 		   u32 offset, u32 val);
 int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 74a7543..c0215d1 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -40,10 +40,11 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
 
 int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
 				    void __iomem *base, u32 offset,
-				    u32 mask, u32 val, u32 delayus)
+				    u32 mask, u32 val, u32 delayus,
+				    u32 timeout_ms)
 {
 	int ret;
-	u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;
+	u32 out, retry = (timeout_ms * 1000) / delayus;
 
 	while (retry--) {
 		ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, &out);
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index fcd80bc..9c601f0 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -269,6 +269,16 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
 	MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
 };
 
+static const struct mhi_controller_config modem_qcom_v2_mhiv_config = {
+	.max_channels = 128,
+	.timeout_ms = 8000,
+	.ready_timeout_ms = 50000,
+	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
+	.ch_cfg = modem_qcom_v1_mhi_channels,
+	.num_events = ARRAY_SIZE(modem_qcom_v1_mhi_events),
+	.event_cfg = modem_qcom_v1_mhi_events,
+};
+
 static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
 	.max_channels = 128,
 	.timeout_ms = 8000,
@@ -278,6 +288,16 @@ static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
 	.event_cfg = modem_qcom_v1_mhi_events,
 };
 
+static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
+	.name = "qcom-sdx75m",
+	.fw = "qcom/sdx75m/xbl.elf",
+	.edl = "qcom/sdx75m/edl.mbn",
+	.config = &modem_qcom_v2_mhiv_config,
+	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
+	.dma_data_width = 32,
+	.sideband_wake = false,
+};
+
 static const struct mhi_pci_dev_info mhi_qcom_sdx65_info = {
 	.name = "qcom-sdx65m",
 	.fw = "qcom/sdx65m/xbl.elf",
@@ -597,6 +617,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 8a4362d..a2f2fee 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -163,6 +163,7 @@ int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
 	enum mhi_pm_state cur_state;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
+	u32 timeout_ms;
 	int ret, i;
 
 	/* Check if device entered error state */
@@ -173,14 +174,18 @@ int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
 
 	/* Wait for RESET to be cleared and READY bit to be set by the device */
 	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				 MHICTRL_RESET_MASK, 0, interval_us);
+				 MHICTRL_RESET_MASK, 0, interval_us,
+				 mhi_cntrl->timeout_ms);
 	if (ret) {
 		dev_err(dev, "Device failed to clear MHI Reset\n");
 		return ret;
 	}
 
+	timeout_ms = mhi_cntrl->ready_timeout_ms ?
+		mhi_cntrl->ready_timeout_ms : mhi_cntrl->timeout_ms;
 	ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHISTATUS,
-				 MHISTATUS_READY_MASK, 1, interval_us);
+				 MHISTATUS_READY_MASK, 1, interval_us,
+				 timeout_ms);
 	if (ret) {
 		dev_err(dev, "Device failed to enter MHI Ready\n");
 		return ret;
@@ -479,7 +484,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 
 		/* Wait for the reset bit to be cleared by the device */
 		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				 MHICTRL_RESET_MASK, 0, 25000);
+				 MHICTRL_RESET_MASK, 0, 25000, mhi_cntrl->timeout_ms);
 		if (ret)
 			dev_err(dev, "Device failed to clear MHI Reset\n");
 
@@ -492,8 +497,8 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 		if (!MHI_IN_PBL(mhi_get_exec_env(mhi_cntrl))) {
 			/* wait for ready to be set */
 			ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs,
-						 MHISTATUS,
-						 MHISTATUS_READY_MASK, 1, 25000);
+						 MHISTATUS, MHISTATUS_READY_MASK,
+						 1, 25000, mhi_cntrl->timeout_ms);
 			if (ret)
 				dev_err(dev, "Device failed to enter READY state\n");
 		}
@@ -1111,7 +1116,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 	if (state == MHI_STATE_SYS_ERR) {
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
 		ret = mhi_poll_reg_field(mhi_cntrl, mhi_cntrl->regs, MHICTRL,
-				 MHICTRL_RESET_MASK, 0, interval_us);
+				 MHICTRL_RESET_MASK, 0, interval_us,
+				 mhi_cntrl->timeout_ms);
 		if (ret) {
 			dev_info(dev, "Failed to reset MHI due to syserr state\n");
 			goto error_exit;
@@ -1202,14 +1208,18 @@ EXPORT_SYMBOL_GPL(mhi_power_down);
 int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
 {
 	int ret = mhi_async_power_up(mhi_cntrl);
+	u32 timeout_ms;
 
 	if (ret)
 		return ret;
 
+	/* Some devices need more time to set ready during power up */
+	timeout_ms = mhi_cntrl->ready_timeout_ms ?
+		mhi_cntrl->ready_timeout_ms : mhi_cntrl->timeout_ms;
 	wait_event_timeout(mhi_cntrl->state_event,
 			   MHI_IN_MISSION_MODE(mhi_cntrl->ee) ||
 			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+			   msecs_to_jiffies(timeout_ms));
 
 	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -ETIMEDOUT;
 	if (ret)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index e065101..129964c 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -266,6 +266,7 @@ struct mhi_event_config {
  * struct mhi_controller_config - Root MHI controller configuration
  * @max_channels: Maximum number of channels supported
  * @timeout_ms: Timeout value for operations. 0 means use default
+ * @ready_timeout_ms: Timeout value for waiting device to be ready (optional)
  * @buf_len: Size of automatically allocated buffers. 0 means use default
  * @num_channels: Number of channels defined in @ch_cfg
  * @ch_cfg: Array of defined channels
@@ -277,6 +278,7 @@ struct mhi_event_config {
 struct mhi_controller_config {
 	u32 max_channels;
 	u32 timeout_ms;
+	u32 ready_timeout_ms;
 	u32 buf_len;
 	u32 num_channels;
 	const struct mhi_channel_config *ch_cfg;
@@ -331,6 +333,7 @@ struct mhi_controller_config {
  * @pm_mutex: Mutex for suspend/resume operation
  * @pm_lock: Lock for protecting MHI power management state
  * @timeout_ms: Timeout in ms for state transitions
+ * @ready_timeout_ms: Timeout in ms for waiting device to be ready (optional)
  * @pm_state: MHI power management state
  * @db_access: DB access states
  * @ee: MHI device execution environment
@@ -420,6 +423,7 @@ struct mhi_controller {
 	struct mutex pm_mutex;
 	rwlock_t pm_lock;
 	u32 timeout_ms;
+	u32 ready_timeout_ms;
 	u32 pm_state;
 	u32 db_access;
 	enum mhi_ee_type ee;
-- 
2.7.4

