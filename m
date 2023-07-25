Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E9760598
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGYChI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGYCgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:36:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98C1FEC;
        Mon, 24 Jul 2023 19:35:24 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P2H9BD028396;
        Tue, 25 Jul 2023 02:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1K6mTWm02w/WVnpqp+hBl8rcxxwmoOZzcj/DI5dZs3I=;
 b=FGfsXIA8Fmsas94yHucqsawLaIE70Y0Zk6CRN96bqPLqX79I8GdcaJnvyx7uLRTP1CFI
 mPUqzaz4mxJUV3eTZd9IqkuJM66wiRnDA7NLJ4oE+gVS4oOsbt0YNTvndYqLUf9zeErn
 04NyCfA2SOsaAq4QBopc4K/CToSkpRX23foSh9FNyS1Q+qo6Y4EnYVyHNqTrUUqVSoaH
 P/c7VK/UxVfZ1hQvf3mAHGLHe3X0Sma+m5KnWfGbQUSgu3gEuql6m046LfX9RB6BYs9e
 fiAQP/qZYELow0rSVCi/9Fa0dUuhipq0WaRcUZx9/7YS+FnHyMWw0CrqjXC1xZjIdH+K Ow== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qassvyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P2YnxL015301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:49 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 19:34:48 -0700
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
Subject: [PATCH v4 28/32] sound: soc: qdsp6: Add SND kcontrol for fetching offload status
Date:   Mon, 24 Jul 2023 19:34:12 -0700
Message-ID: <20230725023416.11205-29-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xeXeNRvkAVTLJPKCYytV-G97zQz2Iim2
X-Proofpoint-GUID: xeXeNRvkAVTLJPKCYytV-G97zQz2Iim2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kcontrol to the platform sound card to fetch the current offload
status.  This can allow for userspace to ensure/check which USB SND
resources are actually busy versus having to attempt opening the USB SND
devices, which will result in an error if offloading is active.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 104 ++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index 87e88dafd8ad..e4ccb9d912b0 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -30,6 +30,8 @@ struct q6usb_status {
 	unsigned int num_pcm;
 	unsigned int chip_index;
 	unsigned int pcm_index;
+	bool prepared;
+	bool running;
 };
 
 struct q6usb_port_data {
@@ -52,6 +54,17 @@ static const struct snd_soc_dapm_route q6usb_dapm_routes[] = {
 	{"USB Playback", NULL, "USB_RX_BE"},
 };
 
+static int q6usb_find_running(struct q6usb_port_data *data)
+{
+	int i;
+
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (data->status[i].running)
+			return i;
+	}
+	return -ENODEV;
+}
+
 static int q6usb_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -81,14 +94,40 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 		goto out;
 
 	data->status[data->sel_card_idx].pcm_index = data->sel_pcm_idx;
+	data->status[data->sel_card_idx].prepared = true;
 out:
 	mutex_unlock(&data->mutex);
 
 	return ret;
 }
 
+static int q6usb_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+
+	mutex_lock(&data->mutex);
+	data->status[data->sel_card_idx].running = true;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static void q6usb_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+
+	mutex_lock(&data->mutex);
+	data->status[data->sel_card_idx].running = false;
+	data->status[data->sel_card_idx].prepared = false;
+	mutex_unlock(&data->mutex);
+}
+
 static const struct snd_soc_dai_ops q6usb_ops = {
 	.hw_params = q6usb_hw_params,
+	.prepare = q6usb_prepare,
+	.shutdown = q6usb_shutdown,
 };
 
 static struct snd_soc_dai_driver q6usb_be_dais[] = {
@@ -148,10 +187,15 @@ static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
 	int pcmidx;
 	int cardidx;
 
+	mutex_lock(&data->mutex);
+
+	/* Don't allow changes to the offloading devices if session is busy */
+	if (data->sel_card_idx >= 0 && data->status[data->sel_card_idx].prepared)
+		goto out;
+
 	cardidx = ucontrol->value.integer.value[0];
 	pcmidx = ucontrol->value.integer.value[1];
 
-	mutex_lock(&data->mutex);
 	if ((cardidx >= 0 && test_bit(cardidx, &data->available_card_slot))) {
 		data->sel_card_idx = cardidx;
 		changed = 1;
@@ -162,6 +206,8 @@ static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
 		data->idx_valid = true;
 		changed = 1;
 	}
+
+out:
 	mutex_unlock(&data->mutex);
 
 	return changed;
@@ -187,11 +233,59 @@ static const struct snd_kcontrol_new q6usb_offload_dev_ctrl = {
 	.put = q6usb_put_offload_dev,
 };
 
+static int q6usb_mixer_get_offload_status(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int running;
+	int card_idx;
+	int pcm_idx;
+
+	running = q6usb_find_running(data);
+	if (running < 0) {
+		card_idx = -1;
+		pcm_idx = -1;
+	} else {
+		card_idx = running;
+		pcm_idx = data->status[running].pcm_index;
+	}
+
+	ucontrol->value.integer.value[0] = card_idx;
+	ucontrol->value.integer.value[1] = pcm_idx;
+	return 0;
+}
+
+static int q6usb_offload_ctl_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = SNDRV_CARDS;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new q6usb_offload_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.name = "Q6USB offload status",
+	.info = q6usb_offload_ctl_info,
+	.get = q6usb_mixer_get_offload_status,
+	.put = NULL,
+};
+
 /* Build a mixer control for a UAC connector control (jack-detect) */
 static void q6usb_connector_control_init(struct snd_soc_component *component)
 {
 	int ret;
 
+	ret = snd_ctl_add(component->card->snd_card,
+				snd_ctl_new1(&q6usb_offload_control, component));
+	if (ret < 0)
+		return;
+
 	ret = snd_ctl_add(component->card->snd_card,
 				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
 	if (ret < 0)
@@ -229,8 +323,12 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 	mutex_lock(&data->mutex);
 	if (connected) {
 		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
-		/* We only track the latest USB headset plugged in */
-		if (!data->idx_valid || data->sel_card_idx < 0)
+		/*
+		 * Update the latest USB headset plugged in, if session is
+		 * idle.
+		 */
+		if ((!data->idx_valid || data->sel_card_idx < 0) &&
+			!data->status[data->sel_card_idx].prepared)
 			data->sel_card_idx = card_idx;
 
 		set_bit(card_idx, &data->available_card_slot);
