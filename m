Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61DB7605B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGYChe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGYCgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:36:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5DC1FFB;
        Mon, 24 Jul 2023 19:35:24 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P1r9Hj024643;
        Tue, 25 Jul 2023 02:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VqhXJFSjiWsnvgLSoGT9tEsoj6so2zENTVubPzFjaFc=;
 b=Rv74QOf4GCDPZO9q/mkyEAsiZVhFlaXkgPTphjdjf+qaWZM54DcwisXrSZtrCoc4X6dK
 wHc+y0VZGNbTf1BV5ht4eC/uwzGs6w72GBQNw8rMc5xq3Km6GHAPSM/RyX+qHPLqrd/X
 foZELz47TALmshfkRvGPh+0VhjRXAi8EmLwU0um5lp/KTYQZ3rqYlKW4plKX9heGzOL0
 4EC4PyvSc5SVCMbIK/wWMBvd2i6JKMdfu+z1aob+6nZOqjgMmYKPmI3oQRSd2/rFqwWE
 lMg5Ok82PgbTf3bf7jQ3oLO8cII9LpwaXg5iiAUmLJQQpLxgmlA+FdGmCuXd1MPeTwkI ew== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8h4ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P2Yn6k013008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:49 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 19:34:47 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <bgoswami@quicinc.com>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <quic_jackp@quicinc.com>, <pierre-louis.bossart@linux.intel.com>,
        <oneukum@suse.com>, <albertccwang@google.com>,
        <o-takashi@sakamocchi.jp>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4 27/32] sound: soc: qdsp6: Add SND kcontrol to select offload device
Date:   Mon, 24 Jul 2023 19:34:11 -0700
Message-ID: <20230725023416.11205-28-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230725023416.11205-1-quic_wcheng@quicinc.com>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4wdalCGz2uzVEsrzd3G0cdOEwm0impcn
X-Proofpoint-GUID: 4wdalCGz2uzVEsrzd3G0cdOEwm0impcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a kcontrol on the platform sound card, which will allow for
userspace to determine which USB card number and PCM device to offload.
This allows for userspace to potentially tag an alternate path for a
specific USB SND card and PCM device.  Previously, control was absent, and
the offload path would be enabled on the last USB SND device which was
connected.  This logic will continue to be applicable if no mixer input is
received for specific device selection.

An example to configure the offload device using tinymix:
tinymix -D 0 set 'Q6USB offload SND device select' 1 0

The above will set the Q6AFE device token to choose offload on card#1 and
pcm#0.  Device selection is made possible by setting the Q6AFE device
token.  The audio DSP utilizes this parameter, and will pass this field
back to the USB offload driver within the QMI stream requests.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 126 ++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index 2fb6159bd2a8..87e88dafd8ad 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -14,6 +14,7 @@
 #include <linux/dma-map-ops.h>
 
 #include <sound/pcm.h>
+#include <sound/control.h>
 #include <sound/soc.h>
 #include <sound/soc-usb.h>
 #include <sound/pcm_params.h>
@@ -35,9 +36,12 @@ struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
 	struct q6usb_offload priv;
+	struct mutex mutex;
 	unsigned long available_card_slot;
 	struct q6usb_status status[SNDRV_CARDS];
-	int active_idx;
+	bool idx_valid;
+	int sel_card_idx;
+	int sel_pcm_idx;
 };
 
 static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
@@ -53,10 +57,36 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct q6afe_port *q6usb_afe;
 	int direction = substream->stream;
+	int chip_idx;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	chip_idx = data->status[data->sel_card_idx].chip_index;
+
+	ret = snd_soc_usb_find_format(chip_idx, params, direction);
+	if (ret < 0)
+		goto out;
+
+	q6usb_afe = q6afe_port_get_from_id(cpu_dai->dev, USB_RX);
+	if (IS_ERR(q6usb_afe))
+		goto out;
+
+	ret = afe_port_send_usb_dev_param(q6usb_afe, data->sel_card_idx,
+						data->sel_pcm_idx);
+	if (ret < 0)
+		goto out;
+
+	data->status[data->sel_card_idx].pcm_index = data->sel_pcm_idx;
+out:
+	mutex_unlock(&data->mutex);
 
-	return snd_soc_usb_find_format(data->active_idx, params, direction);
+	return ret;
 }
+
 static const struct snd_soc_dai_ops q6usb_ops = {
 	.hw_params = q6usb_hw_params,
 };
@@ -85,6 +115,89 @@ static struct snd_soc_dai_driver q6usb_be_dais[] = {
 	},
 };
 
+static int q6usb_get_offload_dev(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int pcm_idx;
+	int card_idx;
+
+	mutex_lock(&data->mutex);
+	if (!data->idx_valid) {
+		card_idx = -1;
+		pcm_idx = -1;
+	} else {
+		card_idx = data->sel_card_idx;
+		pcm_idx = data->sel_pcm_idx;
+	}
+
+	ucontrol->value.integer.value[0] = card_idx;
+	ucontrol->value.integer.value[1] = pcm_idx;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int changed = 0;
+	int pcmidx;
+	int cardidx;
+
+	cardidx = ucontrol->value.integer.value[0];
+	pcmidx = ucontrol->value.integer.value[1];
+
+	mutex_lock(&data->mutex);
+	if ((cardidx >= 0 && test_bit(cardidx, &data->available_card_slot))) {
+		data->sel_card_idx = cardidx;
+		changed = 1;
+	}
+
+	if ((pcmidx >= 0 && pcmidx < data->status[cardidx].num_pcm)) {
+		data->sel_pcm_idx = pcmidx;
+		data->idx_valid = true;
+		changed = 1;
+	}
+	mutex_unlock(&data->mutex);
+
+	return changed;
+}
+
+static int q6usb_offload_dev_info(struct snd_kcontrol *kcontrol,
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
+static const struct snd_kcontrol_new q6usb_offload_dev_ctrl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.name = "Q6USB offload SND device select",
+	.info = q6usb_offload_dev_info,
+	.get = q6usb_get_offload_dev,
+	.put = q6usb_put_offload_dev,
+};
+
+/* Build a mixer control for a UAC connector control (jack-detect) */
+static void q6usb_connector_control_init(struct snd_soc_component *component)
+{
+	int ret;
+
+	ret = snd_ctl_add(component->card->snd_card,
+				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
+	if (ret < 0)
+		return;
+}
+
 static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
 					const struct of_phandle_args *args,
 					const char **dai_name)
@@ -113,10 +226,12 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 	dapm = snd_soc_component_get_dapm(usb->component);
 	data = dev_get_drvdata(usb->component->dev);
 
+	mutex_lock(&data->mutex);
 	if (connected) {
 		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
 		/* We only track the latest USB headset plugged in */
-		data->active_idx = card_idx;
+		if (!data->idx_valid || data->sel_card_idx < 0)
+			data->sel_card_idx = card_idx;
 
 		set_bit(card_idx, &data->available_card_slot);
 		data->status[card_idx].num_pcm = num_pcm;
@@ -129,6 +244,7 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
 	}
 	snd_soc_dapm_sync(dapm);
+	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -141,6 +257,8 @@ static int q6usb_component_probe(struct snd_soc_component *component)
 	snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
 	snd_soc_dapm_sync(dapm);
 
+	q6usb_connector_control_init(component);
+
 	data->usb = snd_soc_usb_add_port(component->dev, &data->priv, q6usb_alsa_connection_cb);
 	if (IS_ERR(data->usb)) {
 		dev_err(component->dev, "failed to add usb port\n");
@@ -189,6 +307,8 @@ static int q6usb_dai_dev_probe(struct platform_device *pdev)
 
 	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
 
+	mutex_init(&data->mutex);
+
 	data->priv.dev = dev;
 	dev_set_drvdata(dev, data);
 
