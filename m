Return-Path: <linux-kernel+bounces-7569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8181AA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9DF1C2288C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73759B78;
	Wed, 20 Dec 2023 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JvGNs+J7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0894F8A1;
	Wed, 20 Dec 2023 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKMUaJY031540;
	Wed, 20 Dec 2023 22:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=7sqlF3lfk8wdZ6Q0jCNq
	vTIEHuVLALHHp/uM/yniut0=; b=JvGNs+J7HLrYtJoUNONrYb3Ko3KKuROAsapH
	npF9ZJ/C1gtjMBYCZsG2IpKSPmwgsEhSN+rpr74nhdC4O7jKLk3b2DsRYJz9YjWz
	7ZPysbd81MKmyQJ01piiGTWPImKg4hdOhNU9z3l8vGk4Txkl+N8ivnhBD61EJilp
	k3g1xj6kSvrcxHAnO2R4jDB1buQ5cgvR7D0+DlgtV9FTVZMd+eJDJN/m59oKa/KW
	dy1B+2nM4jZuKAxWMw0Q8saERCkVeWczQXctZi1URhmEO8KrNFhBkxn9njxFyZtO
	KXHDeJVXSm4HpLuy4qzfcpBJiXSAbhtGxT2Dbmz3kuuTgTzzIg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4234h7gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:45:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKMju1a013933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:45:56 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Dec 2023 14:45:55 -0800
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
Subject: [PATCH v11 08/41] ASoC: qcom: qdsp6: Introduce USB AFE port to q6dsp
Date: Wed, 20 Dec 2023 14:45:11 -0800
Message-ID: <20231220224544.18031-9-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QsJ70nketPAqaoFHqm0WNtieeg94k10O
X-Proofpoint-GUID: QsJ70nketPAqaoFHqm0WNtieeg94k10O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200163

The QC ADSP is able to support USB playback endpoints, so that the main
application processor can be placed into lower CPU power modes.  This adds
the required AFE port configurations and port start command to start an
audio session.

Specifically, the QC ADSP can support all potential endpoints that are
exposed by the audio data interface.  This includes, feedback endpoints
(both implicit and explicit) as well as the isochronous (data) endpoints.
The size of audio samples sent per USB frame (microframe) will be adjusted
based on information received on the feedback endpoint.

Some pre-requisites are needed before issuing the AFE port start command,
such as setting the USB AFE dev_token.  This carries information about the
available USB SND cards and PCM devices that have been discovered on the
USB bus.  The dev_token field is used by the audio DSP to notify the USB
offload driver of which card and PCM index to enable playback on.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c         |  60 +++++++
 sound/soc/qcom/qdsp6/q6afe.c             | 191 ++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6afe.h             |  36 ++++-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c |  23 +++
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h |   1 +
 sound/soc/qcom/qdsp6/q6routing.c         |   9 ++
 6 files changed, 318 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index a9c4f896a7df..80b22d1a24d0 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -92,6 +92,39 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int q6afe_usb_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	int channels = params_channels(params);
+	int rate = params_rate(params);
+	struct q6afe_usb_cfg *usb = &dai_data->port_config[dai->id].usb_audio;
+
+	usb->sample_rate = rate;
+	usb->num_channels = channels;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U16_LE:
+	case SNDRV_PCM_FORMAT_S16_LE:
+		usb->bit_width = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		usb->bit_width = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		usb->bit_width = 32;
+		break;
+	default:
+		dev_err(dai->dev, "%s: invalid format %d\n",
+			__func__, params_format(params));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int q6i2s_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -392,6 +425,10 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 		q6afe_cdc_dma_port_prepare(dai_data->port[dai->id],
 					   &dai_data->port_config[dai->id].dma_cfg);
 		break;
+	case USB_RX:
+		q6afe_usb_port_prepare(dai_data->port[dai->id],
+				       &dai_data->port_config[dai->id].usb_audio);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -618,6 +655,9 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"TX_CODEC_DMA_TX_5", NULL, "TX_CODEC_DMA_TX_5 Capture"},
 	{"RX_CODEC_DMA_RX_6 Playback", NULL, "RX_CODEC_DMA_RX_6"},
 	{"RX_CODEC_DMA_RX_7 Playback", NULL, "RX_CODEC_DMA_RX_7"},
+
+	/* USB playback AFE port receives data for playback, hence use the RX port */
+	{"USB Playback", NULL, "USB_RX"},
 };
 
 static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
@@ -645,6 +685,23 @@ static int msm_dai_q6_dai_remove(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static const struct snd_soc_dai_ops q6afe_usb_ops = {
+	.probe		= msm_dai_q6_dai_probe,
+	.prepare	= q6afe_dai_prepare,
+	.hw_params	= q6afe_usb_hw_params,
+	/*
+	 * Shutdown callback required to stop the USB AFE port, which is enabled
+	 * by the prepare() stage.  This stops the audio traffic on the USB AFE
+	 * port on the Q6DSP.
+	 */
+	.shutdown	= q6afe_dai_shutdown,
+	/*
+	 * Startup callback not needed, as AFE port start command passes the PCM
+	 * parameters within the AFE command, which is provided by the PCM core
+	 * during the prepare() stage.
+	 */
+};
+
 static const struct snd_soc_dai_ops q6hdmi_ops = {
 	.probe			= msm_dai_q6_dai_probe,
 	.remove			= msm_dai_q6_dai_remove,
@@ -943,6 +1000,8 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 		0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("RX_CODEC_DMA_RX_7", "NULL",
 		0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_AIF_IN("USB_RX", NULL, 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_component_driver q6afe_dai_component = {
@@ -1057,6 +1116,7 @@ static int q6afe_dai_dev_probe(struct platform_device *pdev)
 	cfg.q6i2s_ops = &q6i2s_ops;
 	cfg.q6tdm_ops = &q6tdm_ops;
 	cfg.q6dma_ops = &q6dma_ops;
+	cfg.q6usb_ops = &q6afe_usb_ops;
 	dais = q6dsp_audio_ports_set_config(dev, &cfg, &num_dais);
 
 	return devm_snd_soc_register_component(dev, &q6afe_dai_component, dais, num_dais);
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 91d39f6ad0bd..8e0d2d583c9c 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -35,6 +35,8 @@
 #define AFE_MODULE_TDM			0x0001028A
 
 #define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
+#define AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS    0x000102A5
+#define AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT 0x000102AA
 
 #define AFE_PARAM_ID_LPAIF_CLK_CONFIG	0x00010238
 #define AFE_PARAM_ID_INT_DIGITAL_CDC_CLK_CONFIG	0x00010239
@@ -44,6 +46,7 @@
 #define AFE_PARAM_ID_TDM_CONFIG	0x0001029D
 #define AFE_PARAM_ID_PORT_SLOT_MAPPING_CONFIG	0x00010297
 #define AFE_PARAM_ID_CODEC_DMA_CONFIG	0x000102B8
+#define AFE_PARAM_ID_USB_AUDIO_CONFIG    0x000102A4
 #define AFE_CMD_REMOTE_LPASS_CORE_HW_VOTE_REQUEST	0x000100f4
 #define AFE_CMD_RSP_REMOTE_LPASS_CORE_HW_VOTE_REQUEST   0x000100f5
 #define AFE_CMD_REMOTE_LPASS_CORE_HW_DEVOTE_REQUEST	0x000100f6
@@ -72,12 +75,16 @@
 #define AFE_PORT_CONFIG_I2S_WS_SRC_INTERNAL	0x1
 #define AFE_LINEAR_PCM_DATA				0x0
 
+#define AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG 0x1
 
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
 #define AFE_PORT_ID_HDMI_OVER_DP_RX	0x6020
 
+/* USB AFE port */
+#define AFE_PORT_ID_USB_RX                       0x7000
+
 #define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
 /* Clock set API version */
 #define AFE_API_VERSION_CLOCK_SET 1
@@ -513,12 +520,96 @@ struct afe_param_id_cdc_dma_cfg {
 	u16	active_channels_mask;
 } __packed;
 
+struct afe_param_id_usb_cfg {
+/* Minor version used for tracking USB audio device configuration.
+ * Supported values: AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ */
+	u32                  cfg_minor_version;
+/* Sampling rate of the port.
+ * Supported values:
+ * - AFE_PORT_SAMPLE_RATE_8K
+ * - AFE_PORT_SAMPLE_RATE_11025
+ * - AFE_PORT_SAMPLE_RATE_12K
+ * - AFE_PORT_SAMPLE_RATE_16K
+ * - AFE_PORT_SAMPLE_RATE_22050
+ * - AFE_PORT_SAMPLE_RATE_24K
+ * - AFE_PORT_SAMPLE_RATE_32K
+ * - AFE_PORT_SAMPLE_RATE_44P1K
+ * - AFE_PORT_SAMPLE_RATE_48K
+ * - AFE_PORT_SAMPLE_RATE_96K
+ * - AFE_PORT_SAMPLE_RATE_192K
+ */
+	u32                  sample_rate;
+/* Bit width of the sample.
+ * Supported values: 16, 24
+ */
+	u16                  bit_width;
+/* Number of channels.
+ * Supported values: 1 and 2
+ */
+	u16                  num_channels;
+/* Data format supported by the USB. The supported value is
+ * 0 (#AFE_USB_AUDIO_DATA_FORMAT_LINEAR_PCM).
+ */
+	u16                  data_format;
+/* this field must be 0 */
+	u16                  reserved;
+/* device token of actual end USB audio device */
+	u32                  dev_token;
+/* endianness of this interface */
+	u32                   endian;
+/* service interval */
+	u32                  service_interval;
+} __packed;
+
+/**
+ * struct afe_param_id_usb_audio_dev_params
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @dev_token: device token of actual end USB audio device
+ **/
+struct afe_param_id_usb_audio_dev_params {
+	u32	cfg_minor_version;
+	u32	dev_token;
+} __packed;
+
+/**
+ * struct afe_param_id_usb_audio_dev_lpcm_fmt
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @endian: endianness of this interface
+ **/
+struct afe_param_id_usb_audio_dev_lpcm_fmt {
+	u32	cfg_minor_version;
+	u32	endian;
+} __packed;
+
+#define AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL     0x000102B7
+
+/**
+ * struct afe_param_id_usb_audio_svc_interval
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @svc_interval: service interval
+ **/
+struct afe_param_id_usb_audio_svc_interval {
+	u32	cfg_minor_version;
+	u32	svc_interval;
+} __packed;
+
 union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
 	struct afe_param_id_slimbus_cfg           slim_cfg;
 	struct afe_param_id_i2s_cfg	i2s_cfg;
 	struct afe_param_id_tdm_cfg	tdm_cfg;
 	struct afe_param_id_cdc_dma_cfg	dma_cfg;
+	struct afe_param_id_usb_cfg usb_cfg;
 } __packed;
 
 
@@ -833,6 +924,7 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				RX_CODEC_DMA_RX_6, 1, 1},
 	[RX_CODEC_DMA_RX_7] = { AFE_PORT_ID_RX_CODEC_DMA_RX_7,
 				RX_CODEC_DMA_RX_7, 1, 1},
+	[USB_RX] = { AFE_PORT_ID_USB_RX, USB_RX, 1, 1},
 };
 
 static void q6afe_port_free(struct kref *ref)
@@ -1290,6 +1382,100 @@ void q6afe_tdm_port_prepare(struct q6afe_port *port,
 }
 EXPORT_SYMBOL_GPL(q6afe_tdm_port_prepare);
 
+/**
+ * afe_port_send_usb_dev_param() - Send USB dev token
+ *
+ * @port: Instance of afe port
+ * @cardidx: USB SND card index to reference
+ * @pcmidx: USB SND PCM device index to reference
+ *
+ * The USB dev token carries information about which USB SND card instance and
+ * PCM device to execute the offload on.  This information is carried through
+ * to the stream enable QMI request, which is handled by the offload class
+ * driver.  The information is parsed to determine which USB device to query
+ * the required resources for.
+ */
+int afe_port_send_usb_dev_param(struct q6afe_port *port, int cardidx, int pcmidx)
+{
+	struct afe_param_id_usb_audio_dev_params usb_dev;
+	int ret;
+
+	memset(&usb_dev, 0, sizeof(usb_dev));
+
+	usb_dev.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	usb_dev.dev_token = (cardidx << 16) | (pcmidx << 8);
+	ret = q6afe_port_set_param_v2(port, &usb_dev,
+				AFE_PARAM_ID_USB_AUDIO_DEV_PARAMS,
+				AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(usb_dev));
+	if (ret)
+		dev_err(port->afe->dev, "%s: AFE device param cmd failed %d\n",
+			__func__, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(afe_port_send_usb_dev_param);
+
+static int afe_port_send_usb_params(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+	struct afe_param_id_usb_audio_dev_lpcm_fmt lpcm_fmt;
+	struct afe_param_id_usb_audio_svc_interval svc_int;
+	int ret;
+
+	if (!pcfg) {
+		dev_err(port->afe->dev, "%s: Error, no configuration data\n", __func__);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	memset(&lpcm_fmt, 0, sizeof(lpcm_fmt));
+	memset(&svc_int, 0, sizeof(svc_int));
+
+	lpcm_fmt.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	lpcm_fmt.endian = pcfg->usb_cfg.endian;
+	ret = q6afe_port_set_param_v2(port, &lpcm_fmt,
+				      AFE_PARAM_ID_USB_AUDIO_DEV_LPCM_FMT,
+				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(lpcm_fmt));
+	if (ret) {
+		dev_err(port->afe->dev, "%s: AFE device param cmd LPCM_FMT failed %d\n",
+			__func__, ret);
+		goto exit;
+	}
+
+	svc_int.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	svc_int.svc_interval = pcfg->usb_cfg.service_interval;
+	ret = q6afe_port_set_param_v2(port, &svc_int,
+				      AFE_PARAM_ID_USB_AUDIO_SVC_INTERVAL,
+				      AFE_MODULE_AUDIO_DEV_INTERFACE, sizeof(svc_int));
+	if (ret)
+		dev_err(port->afe->dev, "%s: AFE device param cmd svc_interval failed %d\n",
+			__func__, ret);
+
+exit:
+	return ret;
+}
+
+/**
+ * q6afe_usb_port_prepare() - Prepare usb afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: USB configuration for the afe port
+ *
+ */
+void q6afe_usb_port_prepare(struct q6afe_port *port,
+			     struct q6afe_usb_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+
+	pcfg->usb_cfg.cfg_minor_version = AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG;
+	pcfg->usb_cfg.sample_rate = cfg->sample_rate;
+	pcfg->usb_cfg.num_channels = cfg->num_channels;
+	pcfg->usb_cfg.bit_width = cfg->bit_width;
+
+	afe_port_send_usb_params(port, cfg);
+}
+EXPORT_SYMBOL_GPL(q6afe_usb_port_prepare);
+
 /**
  * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
  *
@@ -1612,7 +1798,10 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 		break;
 	case AFE_PORT_ID_WSA_CODEC_DMA_RX_0 ... AFE_PORT_ID_RX_CODEC_DMA_RX_7:
 		cfg_type = AFE_PARAM_ID_CODEC_DMA_CONFIG;
-	break;
+		break;
+	case AFE_PORT_ID_USB_RX:
+		cfg_type = AFE_PARAM_ID_USB_AUDIO_CONFIG;
+		break;
 	default:
 		dev_err(dev, "Invalid port id 0x%x\n", port_id);
 		return ERR_PTR(-EINVAL);
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 65d0676075e1..04c70f904b86 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -3,7 +3,7 @@
 #ifndef __Q6AFE_H__
 #define __Q6AFE_H__
 
-#define AFE_PORT_MAX		129
+#define AFE_PORT_MAX		137
 
 #define MSM_AFE_PORT_TYPE_RX 0
 #define MSM_AFE_PORT_TYPE_TX 1
@@ -203,6 +203,36 @@ struct q6afe_cdc_dma_cfg {
 	u16	active_channels_mask;
 };
 
+/**
+ * struct q6afe_usb_cfg
+ * @cfg_minor_version: Minor version used for tracking USB audio device
+ * configuration.
+ * Supported values:
+ *     AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
+ * @sample_rate: Sampling rate of the port
+ *    Supported values:
+ *      AFE_PORT_SAMPLE_RATE_8K
+ *      AFE_PORT_SAMPLE_RATE_11025
+ *      AFE_PORT_SAMPLE_RATE_12K
+ *      AFE_PORT_SAMPLE_RATE_16K
+ *      AFE_PORT_SAMPLE_RATE_22050
+ *      AFE_PORT_SAMPLE_RATE_24K
+ *      AFE_PORT_SAMPLE_RATE_32K
+ *      AFE_PORT_SAMPLE_RATE_44P1K
+ *      AFE_PORT_SAMPLE_RATE_48K
+ *      AFE_PORT_SAMPLE_RATE_96K
+ *      AFE_PORT_SAMPLE_RATE_192K
+ * @bit_width: Bit width of the sample.
+ *    Supported values: 16, 24
+ * @num_channels: Number of channels
+ *    Supported values: 1, 2
+ **/
+struct q6afe_usb_cfg {
+	u32	cfg_minor_version;
+	u32     sample_rate;
+	u16	bit_width;
+	u16	num_channels;
+};
 
 struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
@@ -210,6 +240,7 @@ struct q6afe_port_config {
 	struct q6afe_i2s_cfg i2s_cfg;
 	struct q6afe_tdm_cfg tdm;
 	struct q6afe_cdc_dma_cfg dma_cfg;
+	struct q6afe_usb_cfg usb_audio;
 };
 
 struct q6afe_port;
@@ -219,6 +250,8 @@ int q6afe_port_start(struct q6afe_port *port);
 int q6afe_port_stop(struct q6afe_port *port);
 void q6afe_port_put(struct q6afe_port *port);
 int q6afe_get_port_id(int index);
+void q6afe_usb_port_prepare(struct q6afe_port *port,
+			     struct q6afe_usb_cfg *cfg);
 void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
 void q6afe_slim_port_prepare(struct q6afe_port *port,
@@ -228,6 +261,7 @@ void q6afe_tdm_port_prepare(struct q6afe_port *port, struct q6afe_tdm_cfg *cfg);
 void q6afe_cdc_dma_port_prepare(struct q6afe_port *port,
 				struct q6afe_cdc_dma_cfg *cfg);
 
+int afe_port_send_usb_dev_param(struct q6afe_port *port, int cardidx, int pcmidx);
 int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 			  int clk_src, int clk_root,
 			  unsigned int freq, int dir);
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
index 4919001de08b..4a96b11f7fd1 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
@@ -97,6 +97,26 @@
 	}
 
 static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
+	{
+		.playback = {
+			.stream_name = "USB Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+					SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
+					SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+					SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
+					SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
+					SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |
+					SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
+					SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_U24_BE,
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min =	8000,
+			.rate_max = 192000,
+		},
+		.id = USB_RX,
+		.name = "USB_RX",
+	},
 	{
 		.playback = {
 			.stream_name = "HDMI Playback",
@@ -624,6 +644,9 @@ struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
 		case WSA_CODEC_DMA_RX_0 ... RX_CODEC_DMA_RX_7:
 			q6dsp_audio_fe_dais[i].ops = cfg->q6dma_ops;
 			break;
+		case USB_RX:
+			q6dsp_audio_fe_dais[i].ops = cfg->q6usb_ops;
+			break;
 		default:
 			break;
 		}
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
index 7f052c8a1257..d8dde6dd0aca 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h
@@ -11,6 +11,7 @@ struct q6dsp_audio_port_dai_driver_config {
 	const struct snd_soc_dai_ops *q6i2s_ops;
 	const struct snd_soc_dai_ops *q6tdm_ops;
 	const struct snd_soc_dai_ops *q6dma_ops;
+	const struct snd_soc_dai_ops *q6usb_ops;
 };
 
 struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 81fde0681f95..45811f0f0d44 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -515,6 +515,9 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static const struct snd_kcontrol_new usb_mixer_controls[] = {
+	Q6ROUTING_RX_MIXERS(USB_RX) };
+
 static const struct snd_kcontrol_new hdmi_mixer_controls[] = {
 	Q6ROUTING_RX_MIXERS(HDMI_RX) };
 
@@ -950,6 +953,10 @@ static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
 	SND_SOC_DAPM_MIXER("MultiMedia8 Mixer", SND_SOC_NOPM, 0, 0,
 		mmul8_mixer_controls, ARRAY_SIZE(mmul8_mixer_controls)),
 
+	SND_SOC_DAPM_MIXER("USB Mixer", SND_SOC_NOPM, 0, 0,
+			   usb_mixer_controls,
+			   ARRAY_SIZE(usb_mixer_controls)),
+
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -1043,6 +1050,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
 	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
 	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
+
+	Q6ROUTING_RX_DAPM_ROUTE("USB Mixer", "USB_RX"),
 };
 
 static int routing_hw_params(struct snd_soc_component *component,

