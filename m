Return-Path: <linux-kernel+bounces-146355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6F8A6411
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A1328454F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78547EEFD;
	Tue, 16 Apr 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gMiCH8m/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551A6D1B2;
	Tue, 16 Apr 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249433; cv=none; b=DFPv1e8EHEQ7YDHW6SSEqCM84l5QsKtR0+0/pXHzV/LlfH7tCgAJKUNN4Pu2QT7Sgld0cHBWYH5wXNGZs9w0vjGeh1OPXoeSu5puBPLEfw4ZVAeBBlqRBmvFh6UI0VaETkEsGwxw6LPoQ84uN7CkRX0ccxMJYrQ9dnjOPUTy3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249433; c=relaxed/simple;
	bh=G4tpxH+0lucGo5TSlVJ0JRbQR4AHNTruNZT6ApnNiGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHZZOUyxCxnA/YFP/kb42c8mR82SSLSdfH/Zq4R5AczmxV1o74Nt7V7Oe79aOQKWvgHkD2cD/yevgaCY1ZvV73OrO0uoFfNf7DQNAzsJSrMD7SXq9Q1g1fk9rBn/ZEepM/u6m54pkQHtIw+QtPmuaWvzixLdMvQxLjKh8hYZVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gMiCH8m/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G1eii8003716;
	Tue, 16 Apr 2024 06:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=VMXd+y6huteUQPqhvJ+tXiTYJZIU+p1Mba7/QH5XmMY=; b=gM
	iCH8m/4HzE4lPWXOWzK1WPz4JT+YHWIBIjWdh+YS/fYqo5Ib1cKgFjmplRTXFf1F
	NBng1OoBJXpY/8RVWn0qgYbXKzj38LBUkMCaf0ElumY+OBfK6XqkU0GUqBOQdR6V
	Dg7B4PxwSC7TA/7zQWxjYRCWJ9BSmAZQpnqW3a3eSCy3gvHssi3bJxC/SwaPbDYO
	cfQtm6ws+s9yUzTums1sWydES7a/lMejUxvxebdm3nDCS7XJF9XvWr4326oxnIMi
	MDlCZvgbbsuqGTMSEqcCNYLVXs+5dKYuDZDp5ycIm2to2pOULlWkoDTr6h0WDr/2
	S07+X+JaG4JLZoohFgTg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh8g49gsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:36:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G6avo2028684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:36:57 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Apr 2024 23:36:52 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v2 5/8] ASoC: codecs: wcd937x: add basic controls
Date: Tue, 16 Apr 2024 12:05:57 +0530
Message-ID: <20240416063600.309747-6-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416063600.309747-1-quic_mohs@quicinc.com>
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: itEH6fpX2w08FmUGQWJfi4WYBBrVE9BP
X-Proofpoint-GUID: itEH6fpX2w08FmUGQWJfi4WYBBrVE9BP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_03,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=870 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404160037

From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>

This patch adds basic controls found in wcd937x codec.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
---
 sound/soc/codecs/wcd937x.c | 212 +++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index b2d5d29303b6..be63662a52be 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -121,6 +121,9 @@ struct wcd937x_priv {
 	atomic_t ana_clk_count;
 };
 
+static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
+static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
+
 struct wcd937x_mbhc_zdet_param {
 	u16 ldo_ctl;
 	u16 noff;
@@ -477,6 +480,169 @@ static int wcd937x_connect_port(struct wcd937x_sdw_priv *wcd, u8 port_idx, u8 ch
 	return 0;
 }
 
+static int wcd937x_rx_hph_mode_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = wcd937x->hph_mode;
+	return 0;
+}
+
+static int wcd937x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+				snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	u32 mode_val;
+
+	mode_val = ucontrol->value.enumerated.item[0];
+	if (!mode_val) {
+		dev_warn(component->dev, "Invalid HPH Mode, default to class_AB\n");
+		mode_val = CLS_AB;
+	}
+
+	wcd937x->hph_mode = mode_val;
+
+	return 0;
+}
+
+static int wcd937x_ear_pa_gain_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	u8 ear_pa_gain;
+
+	ear_pa_gain = snd_soc_component_read(component, WCD937X_ANA_EAR_COMPANDER_CTL);
+
+	ucontrol->value.integer.value[0] = FIELD_GET(WCD937X_EAR_GAIN_MASK, ear_pa_gain);
+
+	return 0;
+}
+
+static int wcd937x_ear_pa_gain_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	u8 ear_pa_gain = 0;
+
+	ear_pa_gain = ucontrol->value.integer.value[0] << 2;
+
+	if (!wcd937x->comp1_enable) {
+		snd_soc_component_update_bits(component,
+					      WCD937X_ANA_EAR_COMPANDER_CTL,
+					      0x7c, ear_pa_gain);
+	}
+
+	return 0;
+}
+
+static int wcd937x_get_compander(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc;
+	bool hphr;
+
+	mc = (struct soc_mixer_control *)(kcontrol->private_value);
+	hphr = mc->shift;
+
+	ucontrol->value.integer.value[0] = hphr ? wcd937x->comp2_enable :
+						  wcd937x->comp1_enable;
+	return 0;
+}
+
+static int wcd937x_set_compander(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
+	struct wcd937x_sdw_priv *wcd = wcd937x->sdw_priv[AIF1_PB];
+	int value = ucontrol->value.integer.value[0];
+	struct soc_mixer_control *mc;
+	int portidx;
+	bool hphr;
+
+	mc = (struct soc_mixer_control *)(kcontrol->private_value);
+	hphr = mc->shift;
+
+	if (hphr)
+		wcd937x->comp2_enable = value;
+	else
+		wcd937x->comp1_enable = value;
+
+	portidx = wcd->ch_info[mc->reg].port_num;
+
+	wcd937x_connect_port(wcd, portidx, mc->reg, !!value);
+
+	return 1;
+}
+
+static int wcd937x_get_swr_port(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(comp);
+	struct wcd937x_sdw_priv *wcd;
+	int dai_id = mixer->shift;
+	int ch_idx = mixer->reg;
+	int portidx;
+
+	wcd = wcd937x->sdw_priv[dai_id];
+	portidx = wcd->ch_info[ch_idx].port_num;
+
+	ucontrol->value.integer.value[0] = wcd->port_enable[portidx];
+
+	return 0;
+}
+
+static int wcd937x_set_swr_port(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(comp);
+	struct wcd937x_sdw_priv *wcd;
+	int dai_id = mixer->shift;
+	int ch_idx = mixer->reg;
+	int portidx;
+	bool enable;
+
+	wcd = wcd937x->sdw_priv[dai_id];
+
+	portidx = wcd->ch_info[ch_idx].port_num;
+
+	enable = !!ucontrol->value.integer.value[0];
+
+	wcd->port_enable[portidx] = enable;
+	wcd937x_connect_port(wcd, portidx, ch_idx, enable);
+
+	return 1;
+}
+
+static const char * const rx_hph_mode_mux_text[] = {
+	"CLS_H_INVALID", "CLS_H_HIFI", "CLS_H_LP", "CLS_AB", "CLS_H_LOHIFI",
+	"CLS_H_ULP", "CLS_AB_HIFI",
+};
+
+static const char * const wcd937x_ear_pa_gain_text[] = {
+	"G_6_DB", "G_4P5_DB", "G_3_DB", "G_1P5_DB", "G_0_DB",
+	"G_M1P5_DB", "G_M3_DB", "G_M4P5_DB",
+	"G_M6_DB", "G_7P5_DB", "G_M9_DB",
+	"G_M10P5_DB", "G_M12_DB", "G_M13P5_DB",
+	"G_M15_DB", "G_M16P5_DB", "G_M18_DB",
+};
+
+static const struct soc_enum rx_hph_mode_mux_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text), rx_hph_mode_mux_text);
+
+static SOC_ENUM_SINGLE_EXT_DECL(wcd937x_ear_pa_gain_enum, wcd937x_ear_pa_gain_text);
+
 /* MBHC related */
 static void wcd937x_mbhc_clk_setup(struct snd_soc_component *component,
 				   bool enable)
@@ -1151,6 +1317,50 @@ static void wcd937x_mbhc_deinit(struct snd_soc_component *component)
 
 /* END MBHC */
 
+static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
+	SOC_ENUM_EXT("EAR PA GAIN", wcd937x_ear_pa_gain_enum,
+		     wcd937x_ear_pa_gain_get, wcd937x_ear_pa_gain_put),
+	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
+		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
+
+	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
+		       wcd937x_get_compander, wcd937x_set_compander),
+	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
+		       wcd937x_get_compander, wcd937x_set_compander),
+
+	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD937X_HPH_R_EN, 0, 20, 1, line_gain),
+	SOC_SINGLE_TLV("ADC1 Volume", WCD937X_ANA_TX_CH1, 0, 20, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", WCD937X_ANA_TX_CH2, 0, 20, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", WCD937X_ANA_TX_CH3, 0, 20, 0, analog_gain),
+
+	SOC_SINGLE_EXT("HPHL Switch", WCD937X_HPH_L, 0, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("HPHR Switch", WCD937X_HPH_R, 0, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+
+	SOC_SINGLE_EXT("ADC1 Switch", WCD937X_ADC1, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("ADC2 Switch", WCD937X_ADC2, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("ADC3 Switch", WCD937X_ADC3, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC0 Switch", WCD937X_DMIC0, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC1 Switch", WCD937X_DMIC1, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("MBHC Switch", WCD937X_MBHC, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC2 Switch", WCD937X_DMIC2, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC3 Switch", WCD937X_DMIC3, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC4 Switch", WCD937X_DMIC4, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+	SOC_SINGLE_EXT("DMIC5 Switch", WCD937X_DMIC5, 1, 1, 0,
+		       wcd937x_get_swr_port, wcd937x_set_swr_port),
+};
+
 static int wcd937x_set_micbias_data(struct wcd937x_priv *wcd937x)
 {
 	int vout_ctl[3];
@@ -1317,6 +1527,8 @@ static const struct snd_soc_component_driver soc_codec_dev_wcd937x = {
 	.name = "wcd937x_codec",
 	.probe = wcd937x_soc_codec_probe,
 	.remove = wcd937x_soc_codec_remove,
+	.controls = wcd937x_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd937x_snd_controls),
 	.set_jack = wcd937x_codec_set_jack,
 	.endianness = 1,
 };
-- 
2.25.1


