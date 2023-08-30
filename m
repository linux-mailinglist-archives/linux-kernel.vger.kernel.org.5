Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB4B78DCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbjH3SrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbjH3SHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:07:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B64193;
        Wed, 30 Aug 2023 11:07:13 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UEe2K7000717;
        Wed, 30 Aug 2023 18:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=HXvkedBCApx0zXKyUnlMWTND4KP1H+MC6F2bJckaFyw=;
 b=bLe1pD1+80oA5+Xk8UU8Uki6WUXjuya5gGMkQIaCMOu2AAbZAZrLpug4tFLDnP6pLc1m
 NtH4/XLQE30LGNzyD0Es04QjNaY8Kyed9CCNz+8iFChxQRnX10OSf+7Ac492TU7v2lgZ
 FRmHTA7zd8wDv0RhDR7k5q13yCg0yPY4IC3aEE3JI/c6YfsQwU2/9trSzZwJPcNxXL4a
 c1lF3uN9CJ0iV4gX4cnSkLw/BFWbngUWNTJ31ZNXqmDssEHRbxkDGlPvKjduzlEDLKpn
 vzisEQQoT39ErtJNUx8+BpiwNAk6SCUnKU1VfBl4s3Tp1MWVnv5S1j4Du6nK+y7LZ71/ Bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st159sb8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:06:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UI6qMS023911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:06:52 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 11:06:50 -0700
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
Subject: [PATCH v4 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
Date:   Wed, 30 Aug 2023 11:05:59 -0700
Message-ID: <20230830180600.1865-7-quic_amelende@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OaWdJ0_OXd-5V9FLEiaRli4m7_naRqg3
X-Proofpoint-GUID: OaWdJ0_OXd-5V9FLEiaRli4m7_naRqg3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308300165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some PMICs like pmi632, the pattern look up table (LUT) and LPG
configuration can be stored in a single SDAM module instead of LUT
peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 298 ++++++++++++++++++++++++++++---
 1 file changed, 274 insertions(+), 24 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 59581b3e25ca..90dc27d5eb7c 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -8,12 +8,14 @@
 #include <linux/bitfield.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/soc/qcom/qcom-pbs.h>
 
 #define LPG_SUBTYPE_REG		0x05
 #define  LPG_SUBTYPE_LPG	0x2
@@ -40,6 +42,8 @@
 #define PWM_SEC_ACCESS_REG	0xd0
 #define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
 
+#define SDAM_REG_PBS_SEQ_EN		0x42
+
 #define TRI_LED_SRC_SEL		0x45
 #define TRI_LED_EN_CTL		0x46
 #define TRI_LED_ATC_CTL		0x47
@@ -49,9 +53,25 @@
 
 #define LPG_RESOLUTION_9BIT	BIT(9)
 #define LPG_RESOLUTION_15BIT	BIT(15)
+#define PPG_MAX_LED_BRIGHTNESS	255
+
 #define LPG_MAX_M		7
 #define LPG_MAX_PREDIV		6
 
+#define DEFAULT_TICK_DURATION_US	7800
+#define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) & 0xff)
+
+/* LPG common config settings for PPG */
+#define SDAM_REG_RAMP_STEP_DURATION		0x47
+#define SDAM_LUT_COUNT_MAX			64
+
+/* LPG per channel config settings for PPG */
+#define SDAM_LUT_EN_OFFSET			0x0
+#define SDAM_PATTERN_CONFIG_OFFSET		0x1
+#define SDAM_END_INDEX_OFFSET			0x3
+#define SDAM_START_INDEX_OFFSET		0x4
+#define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
+
 struct lpg_channel;
 struct lpg_data;
 
@@ -65,7 +85,11 @@ struct lpg_data;
  * @lut_base:	base address of the LUT block (optional)
  * @lut_size:	number of entries in the LUT block
  * @lut_bitmap:	allocation bitmap for LUT entries
- * @triled_base: base address of the TRILED block (optional)
+ * @pbs_dev:	PBS device
+ * @lpg_chan_nvmem:	LPG nvmem peripheral device
+ * @pbs_en_bitmap:	bitmap for tracking PBS triggers
+ * @lut_sdam_base:	offset where LUT pattern begins in nvmem
+ * @triled_base:	base address of the TRILED block (optional)
  * @triled_src:	power-source for the TRILED
  * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
  * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
@@ -86,6 +110,11 @@ struct lpg {
 	u32 lut_size;
 	unsigned long *lut_bitmap;
 
+	struct pbs_dev *pbs_dev;
+	struct nvmem_device *lpg_chan_nvmem;
+	unsigned long pbs_en_bitmap;
+	u32 lut_sdam_base;
+
 	u32 triled_base;
 	u32 triled_src;
 	bool triled_has_atc_ctl;
@@ -102,6 +131,8 @@ struct lpg {
  * @triled_mask: mask in TRILED to enable this channel
  * @lut_mask:	mask in LUT to start pattern generator for this channel
  * @subtype:	PMIC hardware block subtype
+ * @sdam_offset:	Channel offset in LPG nvmem
+ * @lpg_idx:	index of the channel
  * @in_use:	channel is exposed to LED framework
  * @color:	color of the LED attached to this channel
  * @dtest_line:	DTEST line for output, or 0 if disabled
@@ -113,6 +144,7 @@ struct lpg {
  * @pre_div_sel: divider selector of the reference clock
  * @pre_div_exp: exponential divider of the reference clock
  * @pwm_resolution_sel:	pwm resolution selector
+ * @pattern_set: true when setting pattern
  * @ramp_enabled: duty cycle is driven by iterating over lookup table
  * @ramp_ping_pong: reverse through pattern, rather than wrapping to start
  * @ramp_oneshot: perform only a single pass over the pattern
@@ -130,6 +162,8 @@ struct lpg_channel {
 	unsigned int triled_mask;
 	unsigned int lut_mask;
 	unsigned int subtype;
+	u32 sdam_offset;
+	u32 lpg_idx;
 
 	bool in_use;
 
@@ -147,6 +181,7 @@ struct lpg_channel {
 	unsigned int pre_div_exp;
 	unsigned int pwm_resolution_sel;
 
+	bool pattern_set;
 	bool ramp_enabled;
 	bool ramp_ping_pong;
 	bool ramp_oneshot;
@@ -181,10 +216,12 @@ struct lpg_led {
  * struct lpg_channel_data - per channel initialization data
  * @base:		base address for PWM channel registers
  * @triled_mask:	bitmask for controlling this channel in TRILED
+ * @sdam_offset:	Channel offset in LPG nvmem
  */
 struct lpg_channel_data {
 	unsigned int base;
 	u8 triled_mask;
+	unsigned int sdam_offset;
 };
 
 /**
@@ -192,6 +229,7 @@ struct lpg_channel_data {
  * @lut_base:		base address of LUT block
  * @lut_size:		number of entries in LUT
  * @triled_base:	base address of TRILED
+ * @lut_sdam_base:	base address where LUT pattern begins in nvmem device
  * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
  * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
  * @num_channels:	number of channels in LPG
@@ -201,12 +239,90 @@ struct lpg_data {
 	unsigned int lut_base;
 	unsigned int lut_size;
 	unsigned int triled_base;
+	unsigned int lut_sdam_base;
 	bool triled_has_atc_ctl;
 	bool triled_has_src_sel;
 	int num_channels;
 	const struct lpg_channel_data *channels;
 };
 
+static int lpg_sdam_write(struct lpg *lpg, u16 addr, u8 val)
+{
+	int rc;
+
+	rc = nvmem_device_write(lpg->lpg_chan_nvmem, addr, 1, &val);
+	if (rc < 0) {
+		dev_err(lpg->dev, "writing %u to SDAM addr %#x failed, rc=%d\n",
+			val, addr, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+#define PBS_SW_TRIG_BIT		BIT(0)
+
+static int lpg_clear_pbs_trigger(struct lpg_channel *chan)
+{
+	int rc;
+
+	clear_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
+	if (!chan->lpg->pbs_en_bitmap) {
+		rc = lpg_sdam_write(chan->lpg, SDAM_REG_PBS_SEQ_EN, 0);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int lpg_set_pbs_trigger(struct lpg_channel *chan)
+{
+	int rc;
+
+	if (!chan->lpg->pbs_en_bitmap) {
+		rc = lpg_sdam_write(chan->lpg, SDAM_REG_PBS_SEQ_EN, PBS_SW_TRIG_BIT);
+		if (rc < 0)
+			return rc;
+
+		rc = qcom_pbs_trigger_event(chan->lpg->pbs_dev, PBS_SW_TRIG_BIT);
+		if (rc < 0)
+			return rc;
+	}
+	set_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
+
+	return 0;
+}
+
+static int lpg_sdam_configure_triggers(struct lpg_channel *chan, bool set_trig)
+{
+	int rc;
+
+	if (chan->lpg->lut_base)
+		return 0;
+
+	if (set_trig) {
+		rc = lpg_sdam_write(chan->lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 1);
+		if (rc < 0)
+			return rc;
+
+		rc = lpg_set_pbs_trigger(chan);
+		if (rc < 0)
+			return rc;
+		chan->pattern_set = false;
+	} else {
+		rc = lpg_sdam_write(chan->lpg, SDAM_LUT_EN_OFFSET + chan->sdam_offset, 0);
+		if (rc < 0)
+			return rc;
+
+		rc = lpg_clear_pbs_trigger(chan);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
 static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
 {
 	/* Skip if we don't have a triled block */
@@ -217,6 +333,41 @@ static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
 				  mask, enable);
 }
 
+static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *pattern,
+			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
+{
+	u8 brightness;
+	u16 addr;
+	unsigned int idx;
+	int i, rc;
+
+	if (len > SDAM_LUT_COUNT_MAX) {
+		dev_err(lpg->dev, "Pattern length (%zu) exceeds maximum pattern length (%d)\n",
+			len, SDAM_LUT_COUNT_MAX);
+		return -EINVAL;
+	}
+
+	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
+					 0, len, 0);
+	if (idx >= lpg->lut_size)
+		return -ENOSPC;
+
+	for (i = 0; i < len; i++) {
+		brightness = pattern[i].brightness;
+		addr = lpg->lut_sdam_base + i + idx;
+		rc = lpg_sdam_write(lpg, addr, brightness);
+		if (rc < 0)
+			return rc;
+	}
+
+	bitmap_set(lpg->lut_bitmap, idx, len);
+
+	*lo_idx = idx;
+	*hi_idx = idx + len - 1;
+
+	return 0;
+}
+
 static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
 			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
 {
@@ -463,6 +614,26 @@ static void lpg_apply_pwm_value(struct lpg_channel *chan)
 #define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
 #define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
 
+static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
+{
+	u8 val, conf = 0;
+	struct lpg *lpg = chan->lpg;
+
+	if (!chan->ramp_oneshot)
+		conf |= LPG_PATTERN_CONFIG_REPEAT;
+
+	lpg_sdam_write(lpg, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 0);
+	lpg_sdam_write(lpg, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, conf);
+
+	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset, chan->pattern_hi_idx);
+	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset, chan->pattern_lo_idx);
+
+	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
+	if (val > 0)
+		val--;
+	lpg_sdam_write(lpg, SDAM_REG_RAMP_STEP_DURATION, val);
+}
+
 static void lpg_apply_lut_control(struct lpg_channel *chan)
 {
 	struct lpg *lpg = chan->lpg;
@@ -476,6 +647,9 @@ static void lpg_apply_lut_control(struct lpg_channel *chan)
 	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
 		return;
 
+	if (lpg->lpg_chan_nvmem)
+		return lpg_sdam_apply_lut_control(chan);
+
 	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, step);
 	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, step);
 
@@ -643,6 +817,9 @@ static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
 		triled_mask |= chan->triled_mask;
 
 		lpg_apply(chan);
+
+		if (chan->pattern_set)
+			lpg_sdam_configure_triggers(chan, true);
 	}
 
 	/* Toggle triled lines */
@@ -775,7 +952,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	unsigned int lo_idx;
 	unsigned int hi_idx;
 	unsigned int i;
-	bool ping_pong = true;
+	bool ping_pong = false;
 	int ret = -EINVAL;
 
 	/* Hardware only support oneshot or indefinite loops */
@@ -824,7 +1001,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * used to stretch the first delay of the pattern and a "high pause"
 	 * the last one.
 	 *
-	 * In order to save space the pattern can be played in "ping pong"
+	 * In order to save space for the pattern can be played in "ping pong"
 	 * mode, in which the pattern is first played forward, then "high
 	 * pause" is applied, then the pattern is played backwards and finally
 	 * the "low pause" is applied.
@@ -837,16 +1014,22 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * If the specified pattern is a palindrome the ping pong mode is
 	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
 	 * last in the programmed pattern) determines the "high pause".
+	 *
+	 * NVMEM devices supporting LUT do not support "low pause", "high pause"
+	 * or "ping pong"
 	 */
 
 	/* Detect palindromes and use "ping pong" to reduce LUT usage */
-	for (i = 0; i < len / 2; i++) {
-		brightness_a = pattern[i].brightness;
-		brightness_b = pattern[len - i - 1].brightness;
-
-		if (brightness_a != brightness_b) {
-			ping_pong = false;
-			break;
+	if (lpg->lut_base) {
+		ping_pong = true;
+		for (i = 0; i < len / 2; i++) {
+			brightness_a = pattern[i].brightness;
+			brightness_b = pattern[len - i - 1].brightness;
+
+			if (brightness_a != brightness_b) {
+				ping_pong = false;
+				break;
+			}
 		}
 	}
 
@@ -860,14 +1043,21 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * Validate that all delta_t in the pattern are the same, with the
 	 * exception of the middle element in case of ping_pong.
 	 */
-	delta_t = pattern[1].delta_t;
-	for (i = 2; i < len; i++) {
+	if (lpg->lpg_chan_nvmem) {
+		i = 1;
+		delta_t = pattern[0].delta_t;
+	} else {
+		i = 2;
+		delta_t = pattern[1].delta_t;
+	}
+
+	for (; i < len; i++) {
 		if (pattern[i].delta_t != delta_t) {
 			/*
 			 * Allow last entry in the full or shortened pattern to
 			 * specify hi pause. Reject other variations.
 			 */
-			if (i != actual_len - 1)
+			if (i != actual_len - 1 || lpg->lpg_chan_nvmem)
 				goto out_free_pattern;
 		}
 	}
@@ -876,12 +1066,19 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	if (delta_t >= BIT(9))
 		goto out_free_pattern;
 
-	/* Find "low pause" and "high pause" in the pattern */
-	lo_pause = pattern[0].delta_t;
-	hi_pause = pattern[actual_len - 1].delta_t;
+	/* Find "low pause" and "high pause" in the pattern if not an NVMEM device*/
+	if (lpg->lut_base) {
+		lo_pause = pattern[0].delta_t;
+		hi_pause = pattern[actual_len - 1].delta_t;
+	}
 
 	mutex_lock(&lpg->lock);
-	ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+
+	if (lpg->lpg_chan_nvmem)
+		ret = lpg_lut_store_sdam(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+	else
+		ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
+
 	if (ret < 0)
 		goto out_unlock;
 
@@ -897,6 +1094,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 
 		chan->pattern_lo_idx = lo_idx;
 		chan->pattern_hi_idx = hi_idx;
+
+		chan->pattern_set = true;
 	}
 
 out_unlock:
@@ -954,6 +1153,7 @@ static int lpg_pattern_clear(struct lpg_led *led)
 
 	for (i = 0; i < led->num_channels; i++) {
 		chan = led->channels[i];
+		lpg_sdam_configure_triggers(chan, false);
 		chan->pattern_lo_idx = 0;
 		chan->pattern_hi_idx = 0;
 	}
@@ -1190,8 +1390,8 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		cdev->brightness_set_blocking = lpg_brightness_mc_set;
 		cdev->blink_set = lpg_blink_mc_set;
 
-		/* Register pattern accessors only if we have a LUT block */
-		if (lpg->lut_base) {
+		/* Register pattern accessors if we have a LUT block or when using PPG */
+		if (lpg->lut_base || lpg->lpg_chan_nvmem) {
 			cdev->pattern_set = lpg_pattern_mc_set;
 			cdev->pattern_clear = lpg_pattern_mc_clear;
 		}
@@ -1204,15 +1404,19 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		cdev->brightness_set_blocking = lpg_brightness_single_set;
 		cdev->blink_set = lpg_blink_single_set;
 
-		/* Register pattern accessors only if we have a LUT block */
-		if (lpg->lut_base) {
+		/* Register pattern accessors if we have a LUT block or when using PPG */
+		if (lpg->lut_base || lpg->lpg_chan_nvmem) {
 			cdev->pattern_set = lpg_pattern_single_set;
 			cdev->pattern_clear = lpg_pattern_single_clear;
 		}
 	}
 
 	cdev->default_trigger = of_get_property(np, "linux,default-trigger", NULL);
-	cdev->max_brightness = LPG_RESOLUTION_9BIT - 1;
+
+	if (lpg->lpg_chan_nvmem)
+		cdev->max_brightness = PPG_MAX_LED_BRIGHTNESS;
+	else
+		cdev->max_brightness = LPG_RESOLUTION_9BIT - 1;
 
 	if (!of_property_read_string(np, "default-state", &state) &&
 	    !strcmp(state, "on"))
@@ -1253,6 +1457,8 @@ static int lpg_init_channels(struct lpg *lpg)
 		chan->base = data->channels[i].base;
 		chan->triled_mask = data->channels[i].triled_mask;
 		chan->lut_mask = BIT(i);
+		chan->sdam_offset = data->channels[i].sdam_offset;
+		chan->lpg_idx = i;
 
 		regmap_read(lpg->map, chan->base + LPG_SUBTYPE_REG, &chan->subtype);
 	}
@@ -1299,10 +1505,13 @@ static int lpg_init_lut(struct lpg *lpg)
 {
 	const struct lpg_data *data = lpg->data;
 
-	if (!data->lut_base)
+	if (data->lut_base)
+		lpg->lut_base = data->lut_base;
+	else if (lpg->lpg_chan_nvmem)
+		lpg->lut_sdam_base = data->lut_sdam_base;
+	else
 		return 0;
 
-	lpg->lut_base = data->lut_base;
 	lpg->lut_size = data->lut_size;
 
 	lpg->lut_bitmap = devm_bitmap_zalloc(lpg->dev, lpg->lut_size, GFP_KERNEL);
@@ -1312,6 +1521,43 @@ static int lpg_init_lut(struct lpg *lpg)
 	return 0;
 }
 
+static int lpg_init_sdam(struct lpg *lpg)
+{
+	struct lpg_channel *chan;
+	int i, nvmem_count, rc;
+
+	nvmem_count = of_property_count_strings(lpg->dev->of_node, "nvmem-names");
+	if (nvmem_count <= 0)
+		return 0;
+
+	/* get the nvmem device for LPG/LUT config */
+	lpg->lpg_chan_nvmem = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
+	if (IS_ERR(lpg->lpg_chan_nvmem))
+		return dev_err_probe(lpg->dev, PTR_ERR(lpg->lpg_chan_nvmem),
+				"Failed to get nvmem device\n");
+
+	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
+	if (IS_ERR(lpg->pbs_dev))
+		return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
+				"Failed to get PBS client device\n");
+
+	for (i = 0; i < lpg->num_channels; i++) {
+		chan = &lpg->channels[i];
+		if (chan->sdam_offset) {
+			rc = lpg_sdam_write(lpg,
+				SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 0);
+			if (rc < 0)
+				return rc;
+
+			rc = lpg_sdam_configure_triggers(chan, false);
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
 static int lpg_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -1348,6 +1594,10 @@ static int lpg_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	ret = lpg_init_sdam(lpg);
+	if (ret < 0)
+		return ret;
+
 	ret = lpg_init_lut(lpg);
 	if (ret < 0)
 		return ret;
-- 
2.41.0

