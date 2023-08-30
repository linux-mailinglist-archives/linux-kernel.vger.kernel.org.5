Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E278DEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjH3TJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbjH3SHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:07:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A4193;
        Wed, 30 Aug 2023 11:07:20 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UHIhTd017458;
        Wed, 30 Aug 2023 18:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=isqS23Sh8FKsv3T4eVwswaP33f1DQoGq4G0HbD6exi4=;
 b=YWOa3HZcpnS6hDKoHENTMsxpNRvC6pRkTBbns3npVar6fRjWMJu/mvu/AOONySoEqyai
 QAHmRkWin+kzcpT3xQn094tFM56908/+Nbrs1eJh7wbX1VVt1K2koHY3i2isQeVSRnv+
 9TOFsg+Q6TrOaSEPu8OOL7KW5YoMg9j6RkUTMd6D2bm8EXSkIpo1vHCEgS5uUjTNTm29
 aCxshcvx1CZXvqr3FPcnHCKViTuvMvA2zGQ2QlELuCNQp9IOMURdgRrMt99STOxuxNjw
 MduRSPiWQ1LzFzmfGnxROt8TgzWp4U1RMV99I0jyBX8sC6OimNb2Z5pM6+gjPEOgJ3Uh /A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st0tasbkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:07:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UI6xRT007353
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:06:59 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 11:06:57 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v4 6/7] leds: rgb: leds-qcom-lpg: Include support for dedicated LUT SDAM PPG Scheme
Date:   Wed, 30 Aug 2023 11:06:01 -0700
Message-ID: <20230830180600.1865-9-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830180600.1865-2-quic_amelende@quicinc.com>
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g8EgRBBJRPzDmJFz0CzIMTYYAPAcL0nD
X-Proofpoint-ORIG-GUID: g8EgRBBJRPzDmJFz0CzIMTYYAPAcL0nD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PMICs such as PM8350C, the lookup table containing the pattern data
is stored in a separate SDAM from the one where the per-channel
data is stored.

Add support for the dedicated LUT SDAM while maintaining backward
compatibility for those targets that use only a single SDAM.

Co-developed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 102 ++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 23 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 0b37d3b539f8..9f1580e81ab0 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -43,6 +43,8 @@
 #define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
 
 #define SDAM_REG_PBS_SEQ_EN		0x42
+#define SDAM_PBS_TRIG_SET		0xe5
+#define SDAM_PBS_TRIG_CLR		0xe6
 
 #define TRI_LED_SRC_SEL		0x45
 #define TRI_LED_EN_CTL		0x46
@@ -62,6 +64,7 @@
 #define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) & 0xff)
 
 /* LPG common config settings for PPG */
+#define SDAM_START_BASE			0x40
 #define SDAM_REG_RAMP_STEP_DURATION		0x47
 #define SDAM_LUT_COUNT_MAX			64
 
@@ -71,6 +74,8 @@
 #define SDAM_END_INDEX_OFFSET			0x3
 #define SDAM_START_INDEX_OFFSET		0x4
 #define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
+#define SDAM_PAUSE_HI_MULTIPLIER_OFFSET	0x8
+#define SDAM_PAUSE_LO_MULTIPLIER_OFFSET	0x9
 
 struct lpg_channel;
 struct lpg_data;
@@ -87,6 +92,7 @@ struct lpg_data;
  * @lut_bitmap:	allocation bitmap for LUT entries
  * @pbs_dev:	PBS device
  * @lpg_chan_nvmem:	LPG nvmem peripheral device
+ * @lut_nvmem:	LUT nvmem peripheral device
  * @pbs_en_bitmap:	bitmap for tracking PBS triggers
  * @lut_sdam_base:	offset where LUT pattern begins in nvmem
  * @triled_base:	base address of the TRILED block (optional)
@@ -112,6 +118,7 @@ struct lpg {
 
 	struct pbs_dev *pbs_dev;
 	struct nvmem_device *lpg_chan_nvmem;
+	struct nvmem_device *lut_nvmem;
 	unsigned long pbs_en_bitmap;
 	u32 lut_sdam_base;
 
@@ -271,6 +278,12 @@ static int lpg_clear_pbs_trigger(struct lpg_channel *chan)
 		rc = lpg_sdam_write(chan->lpg, SDAM_REG_PBS_SEQ_EN, 0);
 		if (rc < 0)
 			return rc;
+
+		if (chan->lpg->lut_nvmem) {
+			rc = lpg_sdam_write(chan->lpg, SDAM_PBS_TRIG_CLR, PBS_SW_TRIG_BIT);
+			if (rc < 0)
+				return rc;
+		}
 	}
 
 	return 0;
@@ -285,9 +298,15 @@ static int lpg_set_pbs_trigger(struct lpg_channel *chan)
 		if (rc < 0)
 			return rc;
 
-		rc = qcom_pbs_trigger_event(chan->lpg->pbs_dev, PBS_SW_TRIG_BIT);
-		if (rc < 0)
-			return rc;
+		if (chan->lpg->lut_nvmem) {
+			rc = lpg_sdam_write(chan->lpg, SDAM_PBS_TRIG_SET, PBS_SW_TRIG_BIT);
+			if (rc < 0)
+				return rc;
+		} else {
+			rc = qcom_pbs_trigger_event(chan->lpg->pbs_dev, PBS_SW_TRIG_BIT);
+			if (rc < 0)
+				return rc;
+		}
 	}
 	set_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
 
@@ -355,7 +374,12 @@ static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *pattern,
 	for (i = 0; i < len; i++) {
 		brightness = pattern[i].brightness;
 		addr = lpg->lut_sdam_base + i + idx;
-		rc = lpg_sdam_write(lpg, addr, brightness);
+
+		if (lpg->lut_nvmem)
+			rc = nvmem_device_write(lpg->lut_nvmem, addr, 1, &brightness);
+		else
+			rc = lpg_sdam_write(lpg, addr, brightness);
+
 		if (rc < 0)
 			return rc;
 	}
@@ -616,22 +640,40 @@ static void lpg_apply_pwm_value(struct lpg_channel *chan)
 
 static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
 {
-	u8 val, conf = 0;
+	u8 val, conf = 0, lut_offset = 0;
+	unsigned int hi_pause, lo_pause;
 	struct lpg *lpg = chan->lpg;
 
+	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, chan->ramp_tick_ms);
+	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, chan->ramp_tick_ms);
+
 	if (!chan->ramp_oneshot)
 		conf |= LPG_PATTERN_CONFIG_REPEAT;
+	if (chan->ramp_hi_pause_ms && lpg->lut_nvmem)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_HI;
+	if (chan->ramp_lo_pause_ms && lpg->lut_nvmem)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_LO;
+	if (lpg->lut_nvmem)
+		lut_offset = chan->lpg->lut_sdam_base - SDAM_START_BASE;
 
 	lpg_sdam_write(lpg, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 0);
 	lpg_sdam_write(lpg, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, conf);
 
-	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset, chan->pattern_hi_idx);
-	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset, chan->pattern_lo_idx);
+	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset,
+			chan->pattern_hi_idx + lut_offset);
+	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset,
+			chan->pattern_lo_idx + lut_offset);
 
 	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
 	if (val > 0)
 		val--;
 	lpg_sdam_write(lpg, SDAM_REG_RAMP_STEP_DURATION, val);
+
+	if (lpg->lut_nvmem || lpg->lut_base) {
+		lpg_sdam_write(lpg, SDAM_PAUSE_HI_MULTIPLIER_OFFSET + chan->sdam_offset, hi_pause);
+		lpg_sdam_write(lpg, SDAM_PAUSE_LO_MULTIPLIER_OFFSET + chan->sdam_offset, lo_pause);
+	}
+
 }
 
 static void lpg_apply_lut_control(struct lpg_channel *chan)
@@ -1015,8 +1057,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
 	 * last in the programmed pattern) determines the "high pause".
 	 *
-	 * NVMEM devices supporting LUT do not support "low pause", "high pause"
-	 * or "ping pong"
+	 * SDAM-based devices do not support "ping pong", and only supports
+	 * "low pause" and "high pause" with a dedicated SDAM LUT.
 	 */
 
 	/* Detect palindromes and use "ping pong" to reduce LUT usage */
@@ -1043,12 +1085,12 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * Validate that all delta_t in the pattern are the same, with the
 	 * exception of the middle element in case of ping_pong.
 	 */
-	if (lpg->lpg_chan_nvmem) {
-		i = 1;
-		delta_t = pattern[0].delta_t;
-	} else {
+	if (lpg->lut_base || lpg->lut_nvmem) {
 		i = 2;
 		delta_t = pattern[1].delta_t;
+	} else {
+		i = 1;
+		delta_t = pattern[0].delta_t;
 	}
 
 	for (; i < len; i++) {
@@ -1057,7 +1099,9 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 			 * Allow last entry in the full or shortened pattern to
 			 * specify hi pause. Reject other variations.
 			 */
-			if (i != actual_len - 1 || lpg->lpg_chan_nvmem)
+			if (lpg->lpg_chan_nvmem && !lpg->lut_nvmem)
+				goto out_free_pattern;
+			if (i != actual_len - 1)
 				goto out_free_pattern;
 		}
 	}
@@ -1066,8 +1110,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	if (delta_t >= BIT(9))
 		goto out_free_pattern;
 
-	/* Find "low pause" and "high pause" in the pattern if not an NVMEM device*/
-	if (lpg->lut_base) {
+	/* Find "low pause" and "high pause" in the pattern if not a single NVMEM device*/
+	if (lpg->lut_base || lpg->lut_nvmem) {
 		lo_pause = pattern[0].delta_t;
 		hi_pause = pattern[actual_len - 1].delta_t;
 	}
@@ -1530,16 +1574,28 @@ static int lpg_init_sdam(struct lpg *lpg)
 	if (nvmem_count <= 0)
 		return 0;
 
-	/* get the nvmem device for LPG/LUT config */
+	if (nvmem_count > 2)
+		return -EINVAL;
+
+	/* get the 1st nvmem device for LPG/LUT config */
 	lpg->lpg_chan_nvmem = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
 	if (IS_ERR(lpg->lpg_chan_nvmem))
 		return dev_err_probe(lpg->dev, PTR_ERR(lpg->lpg_chan_nvmem),
-				"Failed to get nvmem device\n");
-
-	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
-	if (IS_ERR(lpg->pbs_dev))
-		return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
-				"Failed to get PBS client device\n");
+				"Failed to get lpg_chan_sdam device\n");
+
+	if (nvmem_count == 1) {
+		/* get PBS device node if single NVMEM device */
+		lpg->pbs_dev = get_pbs_client_device(lpg->dev);
+		if (IS_ERR(lpg->pbs_dev))
+			return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
+					"Failed to get PBS client device\n");
+	} else if (nvmem_count == 2) {
+		/* get the 2nd nvmem device for LUT pattern */
+		lpg->lut_nvmem = devm_nvmem_device_get(lpg->dev, "lut_sdam");
+		if (IS_ERR(lpg->lut_nvmem))
+			return dev_err_probe(lpg->dev, PTR_ERR(lpg->lut_nvmem),
+					"Failed to get lut_sdam device\n");
+	}
 
 	for (i = 0; i < lpg->num_channels; i++) {
 		chan = &lpg->channels[i];
-- 
2.41.0

