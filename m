Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8B37A2B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbjIPALn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbjIPALH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:11:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15B2102;
        Fri, 15 Sep 2023 17:11:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38G09xS1008860;
        Sat, 16 Sep 2023 00:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=e0W9a3ggrYIVw0XCJb6rDIkBiGQl97APIxzQ9iCtvxI=;
 b=mr61o6yIdsqy1bFBi6NU/KMAIoa0FsKEB4dvFbaaA1VlRQWzgTeWZIwbc0fObaL9iIy1
 S6xxr/MN4j3N6Sap4pFnLTCbmFmXMHAKssxMQ4ciohLAO2ML8B7bNz4vfns3VXkOiccu
 r0alCKt4xz/IR4EmWaZ9TXPmFPlnL8FT12k8PUbjPV1h6QF/mnxGxy9jW0cBwn5dJGG7
 4KnlFAqpt1n0I+EJLN7SZItKWNr82Chm5GSNlur3oEfwjrg9WhOYWb4RG47w90c7OuU3
 pLzZfdSeQYj15JxZbeQV7jR47CGZcziV+RBqzbn9cx0a0PXlk/ij0HpjbRMjHJgvsFo+ +Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g5tjcwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 00:10:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38G0AknO026038
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 00:10:46 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 17:10:45 -0700
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
Subject: [PATCH v6 31/33] ALSA: usb-audio: qcom: Use card and PCM index from QMI request
Date:   Fri, 15 Sep 2023 17:10:24 -0700
Message-ID: <20230916001026.315-32-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230916001026.315-1-quic_wcheng@quicinc.com>
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -InQ5DTDMPFDTxIGb4-97kPLOh-3CPOI
X-Proofpoint-GUID: -InQ5DTDMPFDTxIGb4-97kPLOh-3CPOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309160000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the card and PCM index coming from the USB QMI stream request.
This field follows what is set by the ASoC USB backend, and could
potentially carry information about a specific device selected through the
ASoC USB backend.  The backend also has information about the last USB
sound device plugged in, so it can choose to select the last device plugged
in, accordingly.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/qcom/qc_audio_offload.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 2dffe7e99e01..e482e62d5f37 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -109,8 +109,6 @@ struct uaudio_qmi_dev {
 	bool er_mapped;
 	/* reference count to number of possible consumers */
 	atomic_t qdev_in_use;
-	/* idx to last udev card number plugged in */
-	unsigned int last_card_num;
 };
 
 struct uaudio_dev {
@@ -987,7 +985,7 @@ static int prepare_qmi_response(struct snd_usb_substream *subs,
 	assoc = iface->intf_assoc;
 	pcm_dev_num = (req_msg->usb_token & QMI_STREAM_REQ_DEV_NUM_MASK) >> 8;
 	xfer_buf_len = req_msg->xfer_buff_size;
-	card_num = uaudio_qdev->last_card_num;
+	card_num = (req_msg->usb_token & QMI_STREAM_REQ_CARD_NUM_MASK) >> 16;
 
 	alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
 	altsd = get_iface_desc(alts);
@@ -1388,8 +1386,7 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
 
 	direction = (req_msg->usb_token & QMI_STREAM_REQ_DIRECTION);
 	pcm_dev_num = (req_msg->usb_token & QMI_STREAM_REQ_DEV_NUM_MASK) >> 8;
-	pcm_card_num = req_msg->enable ? uaudio_qdev->last_card_num :
-				ffs(uaudio_qdev->card_slot) - 1;
+	pcm_card_num = (req_msg->usb_token & QMI_STREAM_REQ_CARD_NUM_MASK) >> 16;
 	if (pcm_card_num >= SNDRV_CARDS) {
 		ret = -EINVAL;
 		goto response;
@@ -1598,7 +1595,6 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
 	sdev->num_capture = usb_qmi_get_pcm_num(chip, 1);
 	uadev[chip->card->number].sdev = sdev;
 
-	uaudio_qdev->last_card_num = chip->card->number;
 	snd_soc_usb_connect(usb_get_usb_backend(udev), sdev);
 	mutex_unlock(&chip->mutex);
 
