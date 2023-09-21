Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0485E7AA3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjIUVx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjIUVxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:53:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA682D63;
        Thu, 21 Sep 2023 14:49:39 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LLjc1k010925;
        Thu, 21 Sep 2023 21:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NmQu8MFx2lZ7/sy3a7JXrsNnPwmoH+GDE19rppIQVy8=;
 b=dLwLErETigAiw6VM9ji1hY8Mk+oxEbWTxpRVueloA8mRaGarGWhoq6oy9IrPRymWsi5q
 aerUjw3Yoyj3U4ZDVfkSfZl19XwJM/jdZLjI5ZS++AKckL8jD3xBoVWfJBKGhljqFFz7
 glI/1tQj+CM6O8vaGX+SxmNmEo1awrvyAeWYHaIfn3BwBbl2xAmD0i0nLQh48HEggLSG
 3x22EsNcV1UJuIXPXfo2oyTfwx9yV/g2wgDK/fWui9xNLafbqvzOZqUoVoLJjqS4+DwV
 PEnSrIcopCo4LU8+ShossEmIbqFdvDrU4FuDz3YszyGPWFkehOEtEJh3tHDHk3UT3T2b GA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8txpgc0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:49:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LLn1Nb031102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:49:01 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 21 Sep 2023 14:49:00 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v7 26/33] ALSA: usb-audio: qcom: Populate PCM and USB chip information
Date:   Thu, 21 Sep 2023 14:48:36 -0700
Message-ID: <20230921214843.18450-27-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921214843.18450-1-quic_wcheng@quicinc.com>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xkjOQ3Atu-mQnKB-HPI3o_fltUXGJtlf
X-Proofpoint-GUID: xkjOQ3Atu-mQnKB-HPI3o_fltUXGJtlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=644 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only the index to the USB SND card array is passed to the USB
backend.  Pass through more information, specifically the USB SND card
number and the number of PCM devices available.  This allows for the DPCM
backend to determine what USB resources are available during situations,
such as USB audio offloading.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/qcom/qc_audio_offload.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 2ce39aa26906..2dffe7e99e01 100644
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
@@ -1579,6 +1594,8 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
 
 	sdev->card_idx = chip->card->number;
 	sdev->chip_idx = chip->index;
+	sdev->num_playback = usb_qmi_get_pcm_num(chip, 0);
+	sdev->num_capture = usb_qmi_get_pcm_num(chip, 1);
 	uadev[chip->card->number].sdev = sdev;
 
 	uaudio_qdev->last_card_num = chip->card->number;
@@ -1693,10 +1710,8 @@ static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
 	mutex_unlock(&chip->mutex);
 
 	atomic_dec(&uaudio_qdev->qdev_in_use);
-	if (!atomic_read(&uaudio_qdev->qdev_in_use)) {
-		snd_soc_usb_disconnect(usb_get_usb_backend(udev));
+	if (!atomic_read(&uaudio_qdev->qdev_in_use))
 		qc_usb_audio_cleanup_qmi_dev();
-	}
 	mutex_unlock(&qdev_mutex);
 }
 
