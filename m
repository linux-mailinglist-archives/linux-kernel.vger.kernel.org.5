Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159297E2233
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjKFMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjKFMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:46:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87511173D;
        Mon,  6 Nov 2023 04:46:39 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6ChXrS018285;
        Mon, 6 Nov 2023 12:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=LFHsw2CHqWkE2Ruz0s0m3+LE0ckb3BJXWQ2uWgj8osk=;
 b=AgOJhm40rscia+NbsIG8TBaSRo9Q+NUgdxDitFhePCDQVQlWjbzO+sG1jf1cSsixOD76
 J/4p54b1o+2GPNQgNCbO2EuZp4XxqiH7QWQGB/68Gh5tgrwlQdgacg+1sNGom5PdZiYA
 wchAdi56C+RVJJ36ruW85KFZUaJQlZ3vUihVV7tGoAC3VT0X8ahkoOFOhZOXknAZn8O7
 WcxlkP8GQhapF/8vCITcvHkWA38j58vSR1FpyzmxrByrA98Wb5UPjlcPViTY3UgjUQFq
 PTCDgkstPiEPV19SbhnsS2IYIL1DIxEFfEbgDkFas3lwFduMhHBzWXSn3upiA01KsatU lQ== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5exhv3n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:46:32 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A6CkTna027841;
        Mon, 6 Nov 2023 12:46:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3u5f1m2j4d-1;
        Mon, 06 Nov 2023 12:46:29 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6CkTSg027830;
        Mon, 6 Nov 2023 12:46:29 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3A6CkTnL027824;
        Mon, 06 Nov 2023 12:46:29 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 8F1A1543A; Mon,  6 Nov 2023 20:46:28 +0800 (CST)
From:   Qiang Yu <qianyu@qti.qualcomm.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 2/2] bus: mhi: host: pci_generic: Add SDX75 based modem support
Date:   Mon,  6 Nov 2023 20:46:26 +0800
Message-Id: <1699274786-73881-3-git-send-email-qianyu@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699274786-73881-1-git-send-email-qianyu@qti.qualcomm.com>
References: <1699274786-73881-1-git-send-email-qianyu@qti.qualcomm.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JF5FBQq8lCLtuJfy_8Jmic98BWcOKKO4
X-Proofpoint-GUID: JF5FBQq8lCLtuJfy_8Jmic98BWcOKKO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiang Yu <quic_qianyu@quicinc.com>

Add generic info for SDX75 based modems. SDX75 takes longer to set ready
during power up. Hence use separate configuration.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/host/pci_generic.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 08f3f03..cd6cd14 100644
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
@@ -600,6 +620,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
+		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx75_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
-- 
2.7.4

