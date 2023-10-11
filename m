Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E907C4626
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbjJKAXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbjJKAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:23:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E71A7;
        Tue, 10 Oct 2023 17:23:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B07DPd015540;
        Wed, 11 Oct 2023 00:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Kd7JVRVp+I+Xk7DXDTAeHHZpvD4f/oHbrP3CUMWtwu0=;
 b=ERFtQT+0LF5IwCzJrXmDXQnr8PGlgusd4hEfjkR7SXgmVA3I7Q6G0Eh53RzY7LUwyaGV
 BOEAJ4M1kvcft5sZX25tlTtCuvP+4eWFukoaiqkcSrC6qc9CkHfiGfwToyeR18/PsB5B
 PHQTOaTKakkj2f62v30MQNxeWCLbUZpLPz1op9LDrsOvAUISxh+6l+2mraRxmffbdG1M
 cfjgfADc+dS6/Ev9M65SGucsiPUZNED8DJX+QZPCUY6Pm/Tl5VkW2jKCDMyNDoDRnQ0B
 TRNoeB8zom9RSwKHcEpXQXOJnrAONUNKdrx4/2JBCu2EmH8lUA6Q7/WJVDf5TyaXR8CG FQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tngtp80th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 00:22:38 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B0McbG027119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 00:22:38 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 17:22:37 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v8 28/34] ASoC: qcom: qdsp6: Add support to track available USB PCM devices
Date:   Tue, 10 Oct 2023 17:21:40 -0700
Message-ID: <20231011002146.1821-29-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011002146.1821-1-quic_wcheng@quicinc.com>
References: <20231011002146.1821-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IMgp9ClWIU2C5ToHwLQPnf6iHUqLTXvy
X-Proofpoint-GUID: IMgp9ClWIU2C5ToHwLQPnf6iHUqLTXvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=900
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB backend should know about which sound resources are being shared
between the ASoC and USB SND paths.  This can be utilized to properly
select and maintain the offloading devices.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index 329a7d4a3c01..d697cbe7f184 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -25,10 +25,18 @@
 
 #define SID_MASK	0xF
 
+struct q6usb_status {
+	unsigned int num_pcm;
+	unsigned int chip_index;
+	unsigned int pcm_index;
+};
+
 struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
 	struct q6usb_offload priv;
+	unsigned long available_card_slot;
+	struct q6usb_status status[SNDRV_CARDS];
 	int active_idx;
 };
 
@@ -110,6 +118,14 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 	if (connected) {
 		/* We only track the latest USB headset plugged in */
 		data->active_idx = sdev->card_idx;
+
+		set_bit(sdev->card_idx, &data->available_card_slot);
+		data->status[sdev->card_idx].num_pcm = sdev->num_playback;
+		data->status[sdev->card_idx].chip_index = sdev->chip_idx;
+	} else {
+		clear_bit(sdev->card_idx, &data->available_card_slot);
+		data->status[sdev->card_idx].num_pcm = 0;
+		data->status[sdev->card_idx].chip_index = 0;
 	}
 
 	return 0;
