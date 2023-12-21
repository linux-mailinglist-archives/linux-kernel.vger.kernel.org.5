Return-Path: <linux-kernel+bounces-8970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C88281BEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E843E28441C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6E76DDB;
	Thu, 21 Dec 2023 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uw+8T81E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E974E15;
	Thu, 21 Dec 2023 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLGwCcV025257;
	Thu, 21 Dec 2023 18:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=20Nc00VE4jSaOKD2wldyfbvgbMNnRIV0lJhx/FKvGoM=; b=Uw
	+8T81EAEt1wkvKIYvcpD6uxe0kbpW62Y6q+1X2om3zfUFCaO5NBpkinfHLw7imdt
	PuYstGbCzuwcTBEWriDXTiv/tNBEu2R1gx1SqqGZqtYSinyHpMCpwmHUa6m/KNBZ
	BkM7xY8uIa//DcUJZf26JwRc2w1DBvIrIQqL9vzeZcyoYNB/WI8rV6/BFITTsCoW
	gOxd+f6yNRiWeDKe5VDs/ed5TV+9gGh7068cU0xGThu6VjzQOKdzBDTOC1MCrgWS
	z4GhKZosGTgXKug0Of706zRzHIzLD50jUpJyCkfm2PGBcRNtXb5o+i4Qx+fXVQUy
	pIKeP+DBJvGdHxuS5CYg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4ptggutk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLIx4eg005038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:04 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 10:59:04 -0800
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC: <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v8 6/7] leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT SDAM
Date: Thu, 21 Dec 2023 10:58:36 -0800
Message-ID: <20231221185838.28440-7-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231221185838.28440-1-quic_amelende@quicinc.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jUeGq9EBmzklWXPw1KtZkUuO-Rm-zcCc
X-Proofpoint-ORIG-GUID: jUeGq9EBmzklWXPw1KtZkUuO-Rm-zcCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210144

On PMICs such as PM8350C, the pattern lookup table (LUT) is stored in a
separate SDAM from the one where the lpg per-channel data is stored.

Add support for PPG with a dedicated LUT SDAM while maintaining backward
compatibility for those targets that use only a single SDAM.

Co-developed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 92 +++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 976eaac97f40..eec49027ccf1 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -42,6 +42,8 @@
 #define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
 
 #define SDAM_REG_PBS_SEQ_EN		0x42
+#define SDAM_PBS_TRIG_SET		0xe5
+#define SDAM_PBS_TRIG_CLR		0xe6
 
 #define TRI_LED_SRC_SEL		0x45
 #define TRI_LED_EN_CTL		0x46
@@ -60,8 +62,12 @@
 #define DEFAULT_TICK_DURATION_US	7800
 #define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) & 0xff)
 
+#define SDAM_MAX_DEVICES	2
 /* LPG common config settings for PPG */
+#define SDAM_START_BASE			0x40
 #define SDAM_REG_RAMP_STEP_DURATION		0x47
+
+#define SDAM_LUT_SDAM_LUT_PATTERN_OFFSET	0x45
 #define SDAM_LPG_SDAM_LUT_PATTERN_OFFSET	0x80
 
 /* LPG per channel config settings for PPG */
@@ -70,6 +76,8 @@
 #define SDAM_END_INDEX_OFFSET			0x3
 #define SDAM_START_INDEX_OFFSET		0x4
 #define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
+#define SDAM_PAUSE_HI_MULTIPLIER_OFFSET	0x8
+#define SDAM_PAUSE_LO_MULTIPLIER_OFFSET	0x9
 
 struct lpg_channel;
 struct lpg_data;
@@ -86,6 +94,7 @@ struct lpg_data;
  * @lut_bitmap:	allocation bitmap for LUT entries
  * @pbs_dev:	PBS device
  * @lpg_chan_sdam:	LPG SDAM peripheral device
+ * @lut_sdam:	LUT SDAM peripheral device
  * @pbs_en_bitmap:	bitmap for tracking PBS triggers
  * @triled_base: base address of the TRILED block (optional)
  * @triled_src:	power-source for the TRILED
@@ -110,6 +119,7 @@ struct lpg {
 
 	struct pbs_dev *pbs_dev;
 	struct nvmem_device *lpg_chan_sdam;
+	struct nvmem_device *lut_sdam;
 	unsigned long pbs_en_bitmap;
 
 	u32 triled_base;
@@ -249,6 +259,13 @@ static int lpg_clear_pbs_trigger(struct lpg *lpg, unsigned int lut_mask)
 		rc = nvmem_device_write(lpg->lpg_chan_sdam, SDAM_REG_PBS_SEQ_EN, 1, &val);
 		if (rc < 0)
 			return rc;
+
+		if (lpg->lut_sdam) {
+			val = PBS_SW_TRIG_BIT;
+			rc = nvmem_device_write(lpg->lpg_chan_sdam, SDAM_PBS_TRIG_CLR, 1, &val);
+			if (rc < 0)
+				return rc;
+		}
 	}
 
 	return 0;
@@ -264,9 +281,15 @@ static int lpg_set_pbs_trigger(struct lpg *lpg, unsigned int lut_mask)
 		if (rc < 0)
 			return rc;
 
-		rc = qcom_pbs_trigger_event(lpg->pbs_dev, val);
-		if (rc < 0)
-			return rc;
+		if (lpg->lut_sdam) {
+			rc = nvmem_device_write(lpg->lpg_chan_sdam, SDAM_PBS_TRIG_SET, 1, &val);
+			if (rc < 0)
+				return rc;
+		} else {
+			rc = qcom_pbs_trigger_event(lpg->pbs_dev, val);
+			if (rc < 0)
+				return rc;
+		}
 	}
 	lpg->pbs_en_bitmap |= lut_mask;
 
@@ -313,8 +336,15 @@ static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *pattern,
 
 	for (i = 0; i < len; i++) {
 		brightness = pattern[i].brightness;
-		addr = SDAM_LPG_SDAM_LUT_PATTERN_OFFSET + i + idx;
-		rc = nvmem_device_write(lpg->lpg_chan_sdam, addr, 1, &brightness);
+
+		if (lpg->lut_sdam) {
+			addr = SDAM_LUT_SDAM_LUT_PATTERN_OFFSET + i + idx;
+			rc = nvmem_device_write(lpg->lut_sdam, addr, 1, &brightness);
+		} else {
+			addr = SDAM_LPG_SDAM_LUT_PATTERN_OFFSET + i + idx;
+			rc = nvmem_device_write(lpg->lpg_chan_sdam, addr, 1, &brightness);
+		}
+
 		if (rc < 0)
 			return rc;
 	}
@@ -581,13 +611,28 @@ static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
 	struct nvmem_device *lpg_chan_sdam = chan->lpg->lpg_chan_sdam;
 	unsigned int lo_idx = chan->pattern_lo_idx;
 	unsigned int hi_idx = chan->pattern_hi_idx;
-	u8 val = 0, conf = 0;
+	u8 val = 0, conf = 0, lut_offset = 0;
+	unsigned int hi_pause, lo_pause;
+	struct lpg *lpg = chan->lpg;
 
 	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
 		return;
 
+	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, chan->ramp_tick_ms);
+	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, chan->ramp_tick_ms);
+
 	if (!chan->ramp_oneshot)
 		conf |= LPG_PATTERN_CONFIG_REPEAT;
+	if (chan->ramp_hi_pause_ms && lpg->lut_sdam)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_HI;
+	if (chan->ramp_lo_pause_ms && lpg->lut_sdam)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_LO;
+
+	if (lpg->lut_sdam) {
+		lut_offset = SDAM_LUT_SDAM_LUT_PATTERN_OFFSET - SDAM_START_BASE;
+		hi_idx += lut_offset;
+		lo_idx += lut_offset;
+	}
 
 	nvmem_device_write(lpg_chan_sdam, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 1, &val);
 	nvmem_device_write(lpg_chan_sdam, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, 1, &conf);
@@ -596,6 +641,12 @@ static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
 
 	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
 	nvmem_device_write(lpg_chan_sdam, SDAM_REG_RAMP_STEP_DURATION, 1, &val);
+
+	if (lpg->lut_sdam) {
+		nvmem_device_write(lpg_chan_sdam, SDAM_PAUSE_HI_MULTIPLIER_OFFSET + chan->sdam_offset, 1, &hi_pause);
+		nvmem_device_write(lpg_chan_sdam, SDAM_PAUSE_LO_MULTIPLIER_OFFSET + chan->sdam_offset, 1, &lo_pause);
+	}
+
 }
 
 static void lpg_apply_lut_control(struct lpg_channel *chan)
@@ -979,7 +1030,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
 	 * last in the programmed pattern) determines the "high pause".
 	 *
-	 * SDAM-based devices do not support "ping-pong", "low pause" or "high pause"
+	 * SDAM-based devices do not support "ping pong", and only supports
+	 * "low pause" and "high pause" with a dedicated SDAM LUT.
 	 */
 
 	/* Detect palindromes and use "ping pong" to reduce LUT usage */
@@ -1024,9 +1076,10 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 
 	/*
 	 * Find "low pause" and "high pause" in the pattern in the LUT case.
-	 * SDAM-based devices require equal duration of all steps
+	 * SDAM-based devices without dedicated LUT SDAM require equal
+	 * duration of all steps.
 	 */
-	if (lpg->lut_base) {
+	if (lpg->lut_base || lpg->lut_sdam) {
 		lo_pause = pattern[0].delta_t;
 		hi_pause = pattern[actual_len - 1].delta_t;
 	} else {
@@ -1491,17 +1544,28 @@ static int lpg_init_sdam(struct lpg *lpg)
 	sdam_count = of_property_count_strings(lpg->dev->of_node, "nvmem-names");
 	if (sdam_count <= 0)
 		return 0;
+	if (sdam_count > SDAM_MAX_DEVICES)
+		return -EINVAL;
 
-	/* Get the SDAM device for LPG/LUT config */
+	/* Get the 1st SDAM device for LPG/LUT config */
 	lpg->lpg_chan_sdam = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
 	if (IS_ERR(lpg->lpg_chan_sdam))
 		return dev_err_probe(lpg->dev, PTR_ERR(lpg->lpg_chan_sdam),
 				"Failed to get LPG chan SDAM device\n");
 
-	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
-	if (IS_ERR(lpg->pbs_dev))
-		return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
-				"Failed to get PBS client device\n");
+	if (sdam_count == 1) {
+		/* Get PBS device node if single SDAM device */
+		lpg->pbs_dev = get_pbs_client_device(lpg->dev);
+		if (IS_ERR(lpg->pbs_dev))
+			return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
+					"Failed to get PBS client device\n");
+	} else if (sdam_count == 2) {
+		/* Get the 2nd SDAM device for LUT pattern */
+		lpg->lut_sdam = devm_nvmem_device_get(lpg->dev, "lut_sdam");
+		if (IS_ERR(lpg->lut_sdam))
+			return dev_err_probe(lpg->dev, PTR_ERR(lpg->lut_sdam),
+					"Failed to get LPG LUT SDAM device\n");
+	}
 
 	for (i = 0; i < lpg->num_channels; i++) {
 		struct lpg_channel *chan = &lpg->channels[i];
-- 
2.41.0


