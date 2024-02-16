Return-Path: <linux-kernel+bounces-68035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59145857534
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AB1C224F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF453E18;
	Fri, 16 Feb 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="arolHU7V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A749200D6;
	Fri, 16 Feb 2024 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056008; cv=none; b=d7uqSgA80oqRKRNaQncqg5E6ppCJN6XTZP/v4fZo+QFJqpX0T8u1SuPLmbyiZ6/YNalB5qt0eh4Xl7tAn6Dh3g8C9P1Lv+K5PH4zAdkXYwgPli9TzlVQZKIB1kaFA/UqgxnX2V2LMR8kHrYutAwSsAhtdLOe8FGuIH2QcwEE8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056008; c=relaxed/simple;
	bh=H5Sl/P9pUah/xjHPxQD+XBx66kHr7HZdEBDuxeoN1Uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+vXoVwnKB9wvWwJeypnHyZuHEAFw2NVW27PMH/zBSi4w/Fyr/FWHTvgnfjwTznSprzV1j4zniPZW6zdO8EOv84ie2WaTbPQXMmsZ5Uo1eznwp88yqnC87GvraDEYz5t4wvnq/sdm/eRgUL4bTKDxpTdc6mvEnYZHggRloUTsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=arolHU7V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G3CI0f003264;
	Fri, 16 Feb 2024 03:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=qwYUF9LXCKfwIpIsif1D
	2yHLibpyuDMROwitO6LjKVs=; b=arolHU7VaQNSjGB6tDupW24X7IPIgeD0qXVC
	ild95Vce/Bl6jTb86By85Jf189eHDSEtxGMTNHZApNJyZlwjJNLg46VKpnt7bHDU
	ouROuZnexRqvK2qfun7KJsmAuoKcewi8o+gwmDUimJ8ucLF4LYtxv00uw1HCctcC
	yKX8Puz4F0BW1muRi3SxGC22WWOieZlKBMdsB5ULXWOTfCAEwgsjqeyAi5OEZRR3
	z/xsUR5BF0cMFIuBJPiA1Gz8MbamX+0n5bnYBGBHcSmxpZ7pXJTCdPd5YuJElH6r
	tbJoK2bO5gD3IKutEmsWAMkK1lEgmCkXgdKkDbSfqLWI2Wd8AA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9gv7jce8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xiD1014734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:44 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:44 -0800
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
Subject: [PATCH v16 40/50] ASoC: qcom: qdsp6: Add SOC USB offload select get/put callbacks
Date: Thu, 15 Feb 2024 19:59:13 -0800
Message-ID: <20240216035923.23392-41-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: X4iAcrrXzlLE3qOGhZ2tB3nzMNx7NXYK
X-Proofpoint-ORIG-GUID: X4iAcrrXzlLE3qOGhZ2tB3nzMNx7NXYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_03,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160031

In order for device selection to be supported, the Q6USB backend DAI link
will need to be notified about the device to start the offloading session
on. Device selection is made possible by setting the Q6AFE device token.
The audio DSP utilizes this parameter, and will pass this field back to
the USB offload driver within the QMI stream requests.

Change-Id: Ibe948c73e100b899f08ae6951ec2ed8e2f9e70d1
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 115 +++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index e539b411c35e..72ec7d45f916 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -36,9 +36,12 @@ struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
 	struct q6usb_offload priv;
-	int active_usb_chip_idx;
+	struct mutex mutex;
 	unsigned long available_card_slot;
 	struct q6usb_status status[SNDRV_CARDS];
+	bool idx_valid;
+	int sel_card_idx;
+	int sel_pcm_idx;
 };
 
 static const struct snd_soc_dapm_widget q6usb_dai_widgets[] = {
@@ -54,10 +57,34 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct q6afe_port *q6usb_afe;
 	int direction = substream->stream;
+	int chip_idx;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	chip_idx = data->status[data->sel_card_idx].sdev->chip_idx;
+
+	ret = snd_soc_usb_find_format(chip_idx, params, direction);
+	if (ret < 0)
+		goto out;
+
+	q6usb_afe = q6afe_port_get_from_id(cpu_dai->dev, USB_RX);
+	if (IS_ERR(q6usb_afe))
+		goto out;
 
-	return snd_soc_usb_find_format(data->active_usb_chip_idx, params,
-					direction);
+	ret = afe_port_send_usb_dev_param(q6usb_afe, data->sel_card_idx,
+						data->sel_pcm_idx);
+	if (ret < 0)
+		goto out;
+
+	data->status[data->sel_card_idx].pcm_index = data->sel_pcm_idx;
+out:
+	mutex_unlock(&data->mutex);
+
+	return ret;
 }
 
 static const struct snd_soc_dai_ops q6usb_ops = {
@@ -88,6 +115,70 @@ static struct snd_soc_dai_driver q6usb_be_dais[] = {
 	},
 };
 
+static int q6usb_get_offload_dev(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol,
+				 enum snd_soc_usb_kctl type)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int idx;
+
+	mutex_lock(&data->mutex);
+
+	if (!data->available_card_slot) {
+		idx = -1;
+	} else {
+		if (type == SND_SOC_USB_KCTL_CARD_ROUTE)
+			idx = data->sel_card_idx;
+		else
+			idx = data->sel_pcm_idx;
+	}
+
+	ucontrol->value.integer.value[0] = idx;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol,
+				 enum snd_soc_usb_kctl type)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
+	int changed = 0;
+	int idx;
+
+	idx = ucontrol->value.integer.value[0];
+
+	mutex_lock(&data->mutex);
+	switch (type) {
+	case SND_SOC_USB_KCTL_CARD_ROUTE:
+		if (idx >= 0 && test_bit(idx, &data->available_card_slot)) {
+			data->sel_card_idx = idx;
+			changed = 1;
+		}
+		break;
+	case SND_SOC_USB_KCTL_PCM_ROUTE:
+		if (idx >= 0 && data->sel_card_idx >= 0 &&
+		    idx < data->status[data->sel_card_idx].sdev->num_playback) {
+			data->sel_pcm_idx = idx;
+			changed = 1;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (changed)
+		data->idx_valid = true;
+
+out:
+	mutex_unlock(&data->mutex);
+
+	return changed;
+}
+
 static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
 					const struct of_phandle_args *args,
 					const char **dai_name)
@@ -117,16 +208,28 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 
 	data = dev_get_drvdata(usb->component->dev);
 
+	mutex_lock(&data->mutex);
 	if (connected) {
 		/* We only track the latest USB headset plugged in */
-		data->active_usb_chip_idx = sdev->card_idx;
+		if (!data->idx_valid) {
+			data->sel_card_idx = sdev->card_idx;
+			data->sel_pcm_idx = 0;
+		}
 
 		set_bit(sdev->card_idx, &data->available_card_slot);
 		data->status[sdev->card_idx].sdev = sdev;
 	} else {
 		clear_bit(sdev->card_idx, &data->available_card_slot);
 		data->status[sdev->card_idx].sdev = NULL;
+
+		if (data->sel_card_idx == sdev->card_idx) {
+			data->idx_valid = false;
+			data->sel_card_idx = data->available_card_slot ?
+					ffs(data->available_card_slot) - 1 : 0;
+			data->sel_pcm_idx = 0;
+		}
 	}
+	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -142,6 +245,8 @@ static int q6usb_component_probe(struct snd_soc_component *component)
 		return -ENOMEM;
 
 	usb->connection_status_cb = q6usb_alsa_connection_cb;
+	usb->put_offload_dev = q6usb_put_offload_dev;
+	usb->get_offload_dev = q6usb_get_offload_dev;
 
 	ret = snd_soc_usb_add_port(usb);
 	if (ret < 0) {
@@ -205,6 +310,8 @@ static int q6usb_dai_dev_probe(struct platform_device *pdev)
 
 	data->priv.domain = iommu_get_domain_for_dev(&pdev->dev);
 
+	mutex_init(&data->mutex);
+
 	data->priv.dev = dev;
 	dev_set_drvdata(dev, data);
 

