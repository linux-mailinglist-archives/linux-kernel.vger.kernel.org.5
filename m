Return-Path: <linux-kernel+bounces-50860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A3A847F8B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBD31F245E8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667FC53E37;
	Sat,  3 Feb 2024 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OXZ5DASa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80286210E0;
	Sat,  3 Feb 2024 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927879; cv=none; b=qqc4RkIWIZHHeErIBGlXR5wt8bBj258Ziccfwgk3AjYnX6FzojEnZ6NCWZrMYxoxKXtX8Gc6UjDTlWTKEq3ZFUl1mo8ESS55vwNUfmC0dIBzIAT41Q8lCQSUXCo0olJUZdr5TGDTNDK+yb6my0u9q5BQlvPsvR2+vxyE/LA2+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927879; c=relaxed/simple;
	bh=INx7prBwTCttt9ewnnpDW+hd8zJyPL3YkoMtJKT37Rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLAZsej2Tihu4c9bUp8RpWlwZvOfCsfnhizrq4R0iGe/mmtWshQZnPADJqEiYnSa/s9R/BU2BGF2VygEbX1socub5hNeVk7ib3bUrI0QS4M8vIinBrT3N+6GVPxhKYPUQCD+fZUhRHpnw2Sddtb3XOFrAS2Kqeqe7QlMgPi8ZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OXZ5DASa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4132QI1T011884;
	Sat, 3 Feb 2024 02:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=2epZr9ZtYhWfEyi+rsjA
	ogaNtlPRCGTpOp6RI1gYLko=; b=OXZ5DASaPXqxrML6Kug8dVn7eo9LZk2Hn+7p
	iHSxNP2hbAkRQtbMGWE36abcQ7iallxzdO5pReA+42+gm4gF2lO7Bxjq6ZoC8Hqu
	WZ5+lSwZiRQ1KsDUzukVA3BUCW9zGrwDaWxj2BrW/KPpYrTOuFLoNnwIMsJo7syH
	Pt4N4gxvHvSsmgDjjJviUUAvSI1H2s9GzCJSa0TC4DkrFCxDPLhSBFLXrFLlogrw
	bftZrzTr7ORWVFXZxpVL7uZn8S6NVEZQwZfqt7/gi5b2yMFrqY+lQ49qDwz9Qz55
	8s9EehVWM8z9neqAcm0M8zZo496USwjJSsuWcmfEwkLX5Wgw7Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1cgcg0rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 02:37:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4132bWWR003621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 02:37:32 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 18:37:32 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v13 49/53] ALSA: usb-audio: qcom: Use card and PCM index from QMI request
Date: Fri, 2 Feb 2024 18:36:41 -0800
Message-ID: <20240203023645.31105-50-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203023645.31105-1-quic_wcheng@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yK-SZ6FY05AdblRbdaH6mfmd-cJb1zeM
X-Proofpoint-ORIG-GUID: yK-SZ6FY05AdblRbdaH6mfmd-cJb1zeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402030015

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
index 17cee0cf2ff5..08af82ec22ad 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -106,8 +106,6 @@ struct uaudio_qmi_dev {
 	bool er_mapped;
 	/* reference count to number of possible consumers */
 	atomic_t qdev_in_use;
-	/* idx to last udev card number plugged in */
-	unsigned int last_card_num;
 };
 
 struct uaudio_dev {
@@ -1243,7 +1241,7 @@ static int prepare_qmi_response(struct snd_usb_substream *subs,
 
 	pcm_dev_num = (req_msg->usb_token & QMI_STREAM_REQ_DEV_NUM_MASK) >> 8;
 	xfer_buf_len = req_msg->xfer_buff_size;
-	card_num = uaudio_qdev->last_card_num;
+	card_num = (req_msg->usb_token & QMI_STREAM_REQ_CARD_NUM_MASK) >> 16;
 
 	if (!uadev[card_num].ctrl_intf) {
 		dev_err(&subs->dev->dev, "audio ctrl intf info not cached\n");
@@ -1436,8 +1434,7 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
 
 	direction = (req_msg->usb_token & QMI_STREAM_REQ_DIRECTION);
 	pcm_dev_num = (req_msg->usb_token & QMI_STREAM_REQ_DEV_NUM_MASK) >> 8;
-	pcm_card_num = req_msg->enable ? uaudio_qdev->last_card_num :
-				ffs(uaudio_qdev->card_slot) - 1;
+	pcm_card_num = (req_msg->usb_token & QMI_STREAM_REQ_CARD_NUM_MASK) >> 16;
 	if (pcm_card_num >= SNDRV_CARDS) {
 		ret = -EINVAL;
 		goto response;
@@ -1645,7 +1642,6 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
 	sdev->num_capture = usb_qmi_get_pcm_num(chip, 1);
 	uadev[chip->card->number].sdev = sdev;
 
-	uaudio_qdev->last_card_num = chip->card->number;
 	snd_soc_usb_connect(usb_get_usb_backend(udev), sdev);
 
 	mutex_unlock(&chip->mutex);

