Return-Path: <linux-kernel+bounces-7588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09981AAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3DF1F23C85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE66D1DD;
	Wed, 20 Dec 2023 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IXpuPkrR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8C5639A;
	Wed, 20 Dec 2023 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKMYspX010994;
	Wed, 20 Dec 2023 22:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=stAiXgiZLWnUoOZSbmcO
	JMyOgAinxvDhRKyJag3GBy4=; b=IXpuPkrRttvh9OmQrQikrMMzntrgwJNrH9yq
	10Rta/PswWeaYX6uMQBWONaLUP3ohSkGwh4+ajnz8TVvjqcfY91ivuIznqXs58Kg
	0YmBwoRxqZkxjOSDv5XWSVb8ApKUUxTXyUCmxsFFExnx6iLXED0VG9eFuqnwRHUx
	5PbTF8y0p+e8GtuBsKK9hhn0HYfPoS8QXpZIn2OU/kg8nPo9iEpRJ5JhrC111+Ht
	RHP1yc1tBxieEww1Q5isrHDUsi6Amzm7POZq/tSVkXP2cDb3PUfoUiu90oXZlfG1
	chLby7tyMfilET6zaef3IubzAjf7egr9FjICeO2D1MkW0xJl/A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v37vxw2st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:46:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKMk4Kf032024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:46:04 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Dec 2023 14:46:04 -0800
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
Subject: [PATCH v11 34/41] ASoC: qcom: qdsp6: Add headphone jack for offload connection status
Date: Wed, 20 Dec 2023 14:45:37 -0800
Message-ID: <20231220224544.18031-35-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: z2_SjXiMdvnawvP8tl5k2BAJ6zUN6mEM
X-Proofpoint-GUID: z2_SjXiMdvnawvP8tl5k2BAJ6zUN6mEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200163

The headphone jack framework has a well defined infrastructure for
notifying userspace entities through input devices.  Expose a jack device
that carries information about if an offload capable device is connected.
Applications can further identify specific offloading information through
other SND kcontrols.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/common.c      | 19 +++++++++++++++++++
 sound/soc/qcom/common.h      |  3 ++-
 sound/soc/qcom/qdsp6/q6usb.c | 20 ++++++++++++++++++++
 sound/soc/qcom/sm8250.c      | 11 ++++++++++-
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 483bbf53a541..2645436b08c4 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -5,6 +5,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/jack.h>
+#include <sound/soc-usb.h>
 #include <linux/input-event-codes.h>
 #include "common.h"
 
@@ -239,4 +240,22 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
+
+int qcom_snd_usb_offload_jack_setup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_soc_jack *jack, bool *jack_setup)
+{
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+
+	if (cpu_dai->id != USB_RX)
+		return 0;
+
+	if (!*jack_setup)
+		snd_soc_usb_setup_offload_jack(codec_dai->component, jack);
+
+	*jack_setup = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_usb_offload_jack_setup);
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index d7f80ee5ae26..fca3046c8674 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -9,5 +9,6 @@
 int qcom_snd_parse_of(struct snd_soc_card *card);
 int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_soc_jack *jack, bool *jack_setup);
-
+int qcom_snd_usb_offload_jack_setup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_soc_jack *jack, bool *jack_setup);
 #endif
diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index fd4da457d834..f1d25d53e8db 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 
 #include <sound/asound.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/q6usboffload.h>
@@ -38,6 +39,7 @@ struct q6usb_status {
 struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
+	struct snd_soc_jack *hs_jack;
 	struct q6usb_offload priv;
 	struct mutex mutex;
 	unsigned long available_card_slot;
@@ -245,6 +247,9 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 
 	mutex_lock(&data->mutex);
 	if (connected) {
+		if (!data->available_card_slot)
+			snd_jack_report(data->hs_jack->jack, 1);
+
 		/*
 		 * Update the latest USB headset plugged in, if session is
 		 * idle.
@@ -267,12 +272,26 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 					ffs(data->available_card_slot) - 1 : 0;
 			data->sel_pcm_idx = 0;
 		}
+
+		if (!data->available_card_slot)
+			snd_jack_report(data->hs_jack->jack, 0);
 	}
 	mutex_unlock(&data->mutex);
 
 	return 0;
 }
 
+static int q6usb_component_set_jack(struct snd_soc_component *component,
+			struct snd_soc_jack *jack, void *data)
+{
+	struct q6usb_port_data *priv = dev_get_drvdata(component->dev);
+
+	priv->hs_jack = jack;
+	snd_jack_report(jack->jack, priv->available_card_slot ? 1 : 0);
+
+	return 0;
+}
+
 static int q6usb_component_probe(struct snd_soc_component *component)
 {
 	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
@@ -313,6 +332,7 @@ static void q6usb_component_remove(struct snd_soc_component *component)
 
 static const struct snd_soc_component_driver q6usb_dai_component = {
 	.probe = q6usb_component_probe,
+	.set_jack = q6usb_component_set_jack,
 	.remove = q6usb_component_remove,
 	.name = "q6usb-dai-component",
 	.dapm_widgets = q6usb_dai_widgets,
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 9cc869fd70ac..c33a7c5fb8ad 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -22,14 +22,23 @@ struct sm8250_snd_data {
 	struct snd_soc_card *card;
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 	struct snd_soc_jack jack;
+	struct snd_soc_jack usb_offload_jack;
+	bool usb_offload_jack_setup;
 	bool jack_setup;
 };
 
 static int sm8250_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	int ret;
 
-	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
+	if (cpu_dai->id == USB_RX)
+		ret = qcom_snd_usb_offload_jack_setup(rtd, &data->usb_offload_jack,
+						&data->usb_offload_jack_setup);
+	else
+		ret = qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
+	return ret;
 }
 
 static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,

