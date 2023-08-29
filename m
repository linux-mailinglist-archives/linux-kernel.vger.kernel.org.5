Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550F78CE16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbjH2VHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbjH2VHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:07:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10E1BC;
        Tue, 29 Aug 2023 14:07:28 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TKtaMt024224;
        Tue, 29 Aug 2023 21:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NgFRCjD+M3RMckZvCB/SpYfm7rt+sDlhC1ZUQSS17hI=;
 b=d6DI4kuC7nIwa75+3sF4+1LoD7oHxaAK4PLCBhBi7iQF09gW66TCpwxChhgTtPrH8ycH
 +UtD/O/AstDCpA4108CWuBoCC0qVkDt5T+OgTdamCe9eUWahQxaemygkpGfXQrxP9X40
 xNeI21PmpP0/m1SOl53pr2aIzoF5jWjQRTt0ZmCCgWF/8GLASmX+OXMOT7wEAVR/IXnV
 X3dQJJqt0AGRq/hcwj06SnhE76ddzFUlvsGg+LzmJdnR/DcJkr2uWBXs/VjjHoFvmBUC
 RboryL2f6+s+Sgcavxhy4JGtd7Vh2twcIrnZ1rhZFY+8l0r2We7VWygkNkWKKBu0pUiF Tg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssbm2swb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:07:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TL7F1S005894
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:07:15 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 14:07:15 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v5 26/32] sound: Pass USB SND card and PCM information to SOC USB
Date:   Tue, 29 Aug 2023 14:06:51 -0700
Message-ID: <20230829210657.9904-27-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230829210657.9904-1-quic_wcheng@quicinc.com>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -OgoLBX0nK8JyC-ew7Gw6vzhSfgQksZ8
X-Proofpoint-ORIG-GUID: -OgoLBX0nK8JyC-ew7Gw6vzhSfgQksZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_14,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 mlxlogscore=788 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only the index to the USB SND card array is passed to the USB
backend.  Pass through more information, specifically the USB SND card
number and the number of PCM devices available.  The USB backend should
know about which sound resources are being shared between the ASoC and USB
SND paths.  This can be utilized to properly select and maintain the
offloading devices.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c      | 19 ++++++++++++++++++-
 sound/usb/qcom/qc_audio_offload.c | 21 ++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index e7b9c34fd5bd..1b2c72397570 100644
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
 
@@ -106,10 +114,19 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 
 	data = dev_get_drvdata(usb->component->dev);
 
-	if (connected)
+	if (connected) {
 		/* We only track the latest USB headset plugged in */
 		data->active_idx = sdev->card_idx;
 
+		set_bit(sdev->card_idx, &data->available_card_slot);
+		data->status[sdev->card_idx].num_pcm = sdev->num_playback;
+		data->status[sdev->card_idx].chip_index = sdev->chip_idx;
+	} else {
+		clear_bit(sdev->card_idx, &data->available_card_slot);
+		data->status[sdev->card_idx].num_pcm = 0;
+		data->status[sdev->card_idx].chip_index = 0;
+	}
+
 	return 0;
 }
 
diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 7076f2bd1089..7d98ede94c0d 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -175,6 +175,21 @@ enum usb_qmi_audio_format {
 	USB_QMI_PCM_FORMAT_U32_BE,
 };
 
+static int usb_qmi_get_pcm_num(struct snd_usb_audio *chip, int direction)
+{
+	struct snd_usb_substream *subs = NULL;
+	struct snd_usb_stream *as;
+	int count = 0;
+
+	list_for_each_entry(as, &chip->pcm_list, list) {
+		subs = &as->substream[direction];
+		if (subs->ep_num)
+			count++;
+	}
+
+	return count;
+}
+
 static enum usb_qmi_audio_device_speed_enum_v01
 get_speed_info(enum usb_device_speed udev_speed)
 {
@@ -1574,6 +1589,8 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
 
 	sdev->card_idx = chip->card->number;
 	sdev->chip_idx = chip->index;
+	sdev->num_playback = usb_qmi_get_pcm_num(chip, 0);
+	sdev->num_capture = usb_qmi_get_pcm_num(chip, 1);
 	uadev[chip->card->number].sdev = sdev;
 
 	uaudio_qdev->last_card_num = chip->card->number;
@@ -1674,10 +1691,8 @@ static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
 	mutex_unlock(&chip->mutex);
 
 	atomic_dec(&uaudio_qdev->qdev_in_use);
-	if (!atomic_read(&uaudio_qdev->qdev_in_use)) {
-		snd_soc_usb_disconnect(usb_get_usb_backend(udev));
+	if (!atomic_read(&uaudio_qdev->qdev_in_use))
 		qc_usb_audio_cleanup_qmi_dev();
-	}
 	mutex_unlock(&qdev_mutex);
 
 	xhci_sideband_unregister(dev->sb);
