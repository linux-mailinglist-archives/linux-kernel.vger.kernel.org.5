Return-Path: <linux-kernel+bounces-62809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A535385267F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC791C24383
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8E604D0;
	Tue, 13 Feb 2024 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VnG7ZAlv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB454BD4;
	Tue, 13 Feb 2024 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785705; cv=none; b=jFZN92BcuchuAWbSq8RyHozBqZnnya7RFp6YQIE17btgRol2YY5iad8ZCRgs5soGnftawtH6Jgs5NHvu3qw2wQ3Qe1EqLIdcjE6dWdWfkrxFYFq6JsqHJnHLTTkc2KjQreRkdE7cV8SXWSXNjoLxivkpQ1EvhTgYvZVtFAgOao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785705; c=relaxed/simple;
	bh=rkRwkloXLH0NBDDjwKKTUt3p6SyUAZaYvxUn2f86zKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ84PV8f7SA41HNI6nzZFs0Zxdu8PsyIL4V3Mpfpa1PB5bTxkvY89vgqaD5vnEr1+M7JprJYvz0MEU5p1uya320JzZqmepft6YQpg5QqMqpFaAoHLZzu/MeIcNOVucpkGmYmKl+djK53D6BGFY/nbpX8gXY9QF/ZA7z8iQzSZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VnG7ZAlv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D0VGfh023525;
	Tue, 13 Feb 2024 00:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=b5WcYA4M++5hMV1+dtL2
	ECGuhzTzBXFt95TLOE5PGsc=; b=VnG7ZAlvZsGVW0FmO7tQ7+PhFRMe9dAmKrJQ
	qbWV+huWUHCzdeMroCjvodDt7H20OU3cP/5nP+1UxJOVTgpnnfMbjuuKoA/zjp5a
	qm8d/4Sv9X6BRZihnulhHAjSR5ieUu4/MAIdsUIQs+1m6b4ES4BUemIX5RH5r+7F
	WZMeAqGQ7pDHlr72ZXD/MT0ZJe3LzEXt1EkG7Bi31x7FBej5TwjXWM8ZjCuv7cN0
	pY8gnGx5SS8k52GbKprQu6y4r4tsbwGY5sh/OadxNYYkofzwzDmw2hiRhHwIXJdR
	OFrHu6DoQSwsujv7+pDSF0DFxPNPJ5O67hDJmpVJm9UQVJxXjw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7nk9150k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D0shGx026840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:43 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:54:43 -0800
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
Subject: [PATCH v15 39/50] ASoC: Introduce SND kcontrols to select sound card and PCM device
Date: Mon, 12 Feb 2024 16:54:11 -0800
Message-ID: <20240213005422.3121-40-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213005422.3121-1-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: oRCiRXLe4PkUsoS5oC8awhJlcA5FVkrF
X-Proofpoint-ORIG-GUID: oRCiRXLe4PkUsoS5oC8awhJlcA5FVkrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130005

Add SND kcontrol to SOC USB, which will allow for userpsace to determine
which USB card number and PCM device to offload.  This allows for userspace
to potentially tag an alternate path for a specific USB SND card and PCM
device.  Previously, control was absent, and the offload path would be
enabled on the last USB SND device which was connected.  This logic will
continue to be applicable if no mixer input is received for specific device
selection.

An example to configure the offload device using tinymix:
tinymix -D 0 set 'USB Offload Playback Route Select' 1 0

The above command will configure the offload path to utilize card#1 and PCM
stream#0.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/sound/soc-usb.h |  7 ++++-
 sound/soc/soc-usb.c     | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
index 2790b51d979e..7b0531f975c2 100644
--- a/include/sound/soc-usb.h
+++ b/include/sound/soc-usb.h
@@ -26,14 +26,19 @@ struct snd_soc_usb_device {
  * @dev - USB backend device reference
  * @component - reference to ASoC component
  * @connection_status_cb - callback to notify connection events
+ * @put_offload_dev - callback to select USB sound card/PCM device
+ * @get_offload_dev - callback to fetch selected USB sound card/PCM device
  * @priv_data - driver data
  **/
 struct snd_soc_usb {
 	struct list_head list;
-	struct device *dev;
 	struct snd_soc_component *component;
 	int (*connection_status_cb)(struct snd_soc_usb *usb,
 			struct snd_soc_usb_device *sdev, bool connected);
+	int (*put_offload_dev)(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol);
+	int (*get_offload_dev)(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol);
 	void *priv_data;
 };
 
diff --git a/sound/soc/soc-usb.c b/sound/soc/soc-usb.c
index e3556c397b39..a55d1c509297 100644
--- a/sound/soc/soc-usb.c
+++ b/sound/soc/soc-usb.c
@@ -15,6 +15,9 @@ static struct device_node *snd_soc_find_phandle(struct device *dev)
 {
 	struct device_node *node;
 
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
 	node = of_parse_phandle(dev->of_node, "usb-soc-be", 0);
 	if (!node)
 		return ERR_PTR(-ENODEV);
@@ -38,6 +41,64 @@ static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device_node *node)
 	return NULL;
 }
 
+/* SOC USB sound kcontrols */
+static int soc_usb_put_offload_dev(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_usb *ctx = snd_soc_usb_find_priv_data(component->dev);
+	int ret = 0;
+
+	mutex_lock(&ctx_mutex);
+	if (ctx && ctx->put_offload_dev)
+		ret = ctx->put_offload_dev(kcontrol, ucontrol);
+	mutex_unlock(&ctx_mutex);
+
+	return ret;
+}
+
+static int soc_usb_get_offload_dev(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_usb *ctx = snd_soc_usb_find_priv_data(component->dev);
+	int ret = 0;
+
+	mutex_lock(&ctx_mutex);
+	if (ctx && ctx->get_offload_dev)
+		ret = ctx->get_offload_dev(kcontrol, ucontrol);
+	mutex_unlock(&ctx_mutex);
+
+	return ret;
+
+}
+
+static int soc_usb_offload_dev_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = -1;
+	uinfo->value.integer.max = SNDRV_CARDS;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new soc_usb_dev_ctrl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.name = "USB Offload Playback Route Select",
+	.info = soc_usb_offload_dev_info,
+	.get = soc_usb_get_offload_dev,
+	.put = soc_usb_put_offload_dev,
+};
+
+static int snd_soc_usb_control_init(struct snd_soc_component *component)
+{
+	return snd_ctl_add(component->card->snd_card,
+				snd_ctl_new1(&soc_usb_dev_ctrl, component));
+}
+
 /**
  * snd_soc_usb_get_components_tag() - Retrieve SOC USB component tag
  * @playback: direction of audio stream
@@ -157,6 +218,12 @@ EXPORT_SYMBOL_GPL(snd_soc_usb_free_port);
  */
 int snd_soc_usb_add_port(struct snd_soc_usb *usb)
 {
+	int ret;
+
+	ret = snd_soc_usb_control_init(usb->component);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&ctx_mutex);
 	list_add_tail(&usb->list, &usb_ctx_list);
 	mutex_unlock(&ctx_mutex);

