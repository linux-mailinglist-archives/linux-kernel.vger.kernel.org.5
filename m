Return-Path: <linux-kernel+bounces-68022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5E857512
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43C51C222EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B531446BC;
	Fri, 16 Feb 2024 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HqYH6VnB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7021B956;
	Fri, 16 Feb 2024 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056004; cv=none; b=OGL9KA++eJg84B/RwgEv4MJ5oaGzhHmieWvEQDtM7JgORSZF0g8Sofl/qJ6w4I2PGZ9Pkz5XyohqqedleeyIFkhJyw99tB/FZCyhdjSFvPnQ8TZH9hbfywM1KQ4OPbwZJOtrdc47nM2fXAWyzFyj1ARyQPlu3kfS3PjraNva8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056004; c=relaxed/simple;
	bh=33Zg5zw3fxZ7wahtgBR0Q27vNAZ0XPaE3HaZF0WTq8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ME8p3sY7o9sejP3DS9IOKRMnLcwcngMuH7SheWfA+LoxBPLNq7NyMxv7VusjUPkobBq98bq5RAdqR+ALn5VOGZKLJxKmyuzOkS5NbKJB8YqhVaOOmzO+dtdYTXtmsXcdfbaXgkl6D1s7cvsC9gPyYJdv3WAl2bSOOCs8rdgPn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HqYH6VnB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G2UjdZ025187;
	Fri, 16 Feb 2024 03:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=7LHx5mPbRdJI+O/gwe1D
	uRgaOL7m8QxXbjipzO7sAEI=; b=HqYH6VnBmcCU64G5/xj4bwFR8sGm/4E2M6bB
	ii+x99ZAfJrNXvt1trBwV+lNqMnjv1ewtPZiP6NJCCQhj+KurmQWXZnRHaY2wmOI
	OBVNuQwRwBzQEohmgXXuXloqFdIIWAeEm+u/Nak9JbYybsOjG/9WqKzMi/sBHHRV
	+dd7aaOe5ponEkA9tqNvgFbFuXhVkHk33bfpKlU4vGlRDmHHISzag91Ug5nxGgJQ
	LrR+fPJpkr+79Sywr55hVZ3seUx6Wss6w7wFiV/kSx07L2PUUdP6EnX8/jsQ/UwH
	CzP9oY/e6dWkITPFN1x0KAF2l1FwBKh9P47dnPZ0RDW3hYpI6Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfap33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xhhd020560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:43 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:43 -0800
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
Subject: [PATCH v16 38/50] ASoC: qcom: qdsp6: Add support to track available USB PCM devices
Date: Thu, 15 Feb 2024 19:59:11 -0800
Message-ID: <20240216035923.23392-39-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216035923.23392-1-quic_wcheng@quicinc.com>
References: <20240216035923.23392-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: loXIc7OEAK0mBTrrRj9e4LVfgejCf7yl
X-Proofpoint-GUID: loXIc7OEAK0mBTrrRj9e4LVfgejCf7yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160029

The USB backend should know about which sound resources are being shared
between the ASoC and USB SND paths.  This can be utilized to properly
select and maintain the offloading devices.

Change-Id: I577297699961a3092f6e908f081fecce30128e94
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index 833a57deb321..e539b411c35e 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -27,11 +27,18 @@
 
 #define Q6_USB_SID_MASK	0xF
 
+struct q6usb_status {
+	struct snd_soc_usb_device *sdev;
+	unsigned int pcm_index;
+};
+
 struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
 	struct q6usb_offload priv;
 	int active_usb_chip_idx;
+	unsigned long available_card_slot;
+	struct q6usb_status status[SNDRV_CARDS];
 };
 
 static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
@@ -113,6 +120,12 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 	if (connected) {
 		/* We only track the latest USB headset plugged in */
 		data->active_usb_chip_idx = sdev->card_idx;
+
+		set_bit(sdev->card_idx, &data->available_card_slot);
+		data->status[sdev->card_idx].sdev = sdev;
+	} else {
+		clear_bit(sdev->card_idx, &data->available_card_slot);
+		data->status[sdev->card_idx].sdev = NULL;
 	}
 
 	return 0;

