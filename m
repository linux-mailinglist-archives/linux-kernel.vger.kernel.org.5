Return-Path: <linux-kernel+bounces-7574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36DD81AA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F070282913
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C55BF8B;
	Wed, 20 Dec 2023 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FIpwqz4X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CA4F610;
	Wed, 20 Dec 2023 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKMQBME023008;
	Wed, 20 Dec 2023 22:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=E7ozCBUEd5eMhyDHRgWt
	lAvFMDO6aFPFBgk1S/Zoj9c=; b=FIpwqz4Xzvv9iNDGSe1IgtciosNrxmky7yxD
	wmnSMflHPVCC3CA2XmN6qPtHN0uYxklMPNNVSbem41u+iYORAo8CRBTew6vehxV1
	KUTIsnfTRKKx2YEUZfIeZmicP61hqbjEf8TqS7LtCKu4STD38oWw+jQiQfePQR1w
	A/ptvpo/xZl2e4IsyUKDANOo75TIV1pqo6Ou61Ka3ilPZ0bnQdcwPVOteetPnisv
	gLnL8oTr4/PdDqfymZDQhw+f80lbHIIp+BTZPnVqfim9BevNW/M79h/1ZTnmjn6G
	nP3KsHNuaIBIb3zExNbiJeDVUJQnjZI6G71bJ/5Frul6HPj3Ag==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3v33a5py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:46:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKMk0hh013982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:46:00 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Dec 2023 14:45:59 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v11 20/41] ALSA: usb-audio: Check for support for requested audio format
Date: Wed, 20 Dec 2023 14:45:23 -0800
Message-ID: <20231220224544.18031-21-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220224544.18031-1-quic_wcheng@quicinc.com>
References: <20231220224544.18031-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yHRJu1Ug90JYo7bmi8nl4ZNfD5TfDBKe
X-Proofpoint-GUID: yHRJu1Ug90JYo7bmi8nl4ZNfD5TfDBKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200162

Allow for checks on a specific USB audio device to see if a requested PCM
format is supported.  This is needed for support when playback is
initiated by the ASoC USB backend path.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/usb/card.h | 11 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index c0b312e264bf..11b827b7a2a5 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -162,6 +162,46 @@ int snd_usb_unregister_platform_ops(void)
 }
 EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
 
+/*
+ * Checks to see if requested audio profile, i.e sample rate, # of
+ * channels, etc... is supported by the substream associated to the
+ * USB audio device.
+ */
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction)
+{
+	struct snd_usb_audio *chip;
+	struct snd_usb_substream *subs;
+	struct snd_usb_stream *as;
+	const struct audioformat *fmt;
+
+	/*
+	 * Register mutex is held when populating and clearing usb_chip
+	 * array.
+	 */
+	mutex_lock(&register_mutex);
+	chip = usb_chip[card_idx];
+	if (!chip) {
+		mutex_unlock(&register_mutex);
+		return NULL;
+	}
+
+	if (enable[card_idx]) {
+		list_for_each_entry(as, &chip->pcm_list, list) {
+			subs = &as->substream[direction];
+			fmt = snd_usb_find_substream_format(subs, params);
+			if (fmt) {
+				mutex_unlock(&register_mutex);
+				return as;
+			}
+		}
+	}
+	mutex_unlock(&register_mutex);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
+
 /*
  * disconnect streams
  * called from usb_audio_disconnect()
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 02e4ea898db5..ed4a664e24e5 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -217,4 +217,15 @@ struct snd_usb_platform_ops {
 
 int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
 int snd_usb_unregister_platform_ops(void);
+
+#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction);
+#else
+static struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction)
+{
+	return NULL;
+}
+#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
 #endif /* __USBAUDIO_CARD_H */

