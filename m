Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7530B75C7AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjGUNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjGUNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:22:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFB3A86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:21:43 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L7lwWn024208;
        Fri, 21 Jul 2023 08:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Y0FsS/F592BrpwtwBJ2U63TCIVJW6zTIBhdO8/8fa8s=; b=
        YSfbZBU1VfPv2CWPfSzKe2Sl0eVpz/HiL+1ZgGdMTM9kASbZJxjuYOjjVNTCT1eW
        ox/cDmRJ/M6V40JDDEzgzbQZBmVjEhubrrgmfB1o4/gQG91g7PXezNHpRqmowLyX
        nvViWYn0ZpB/6+ipc2YqMCAMpUP32X6oe0FAHrCvYw0o3GF5eLdsjadM+6M2a+3C
        /L6eAYaERvWvg8FNVd/n8xc7jHfL8I+Om0GUM3riX5Q8cenf4mE/PViJT8AsvYQi
        rYT+a+duiaDHA25mVdJb2UT6z3RS93b5RmkYjOhZHOI/XGfHEBAc62jazoCWu8iX
        acmJkXfN8AB/tUSR44Oh1g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gyj2u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:21:27 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 14:21:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Fri, 21 Jul 2023 14:21:25 +0100
Received: from work-debian.ad.cirrus.com (unknown [198.61.64.172])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EF9B7356C;
        Fri, 21 Jul 2023 13:21:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v5 04/11] ASoC: cs35l56: Move utility functions to shared file
Date:   Fri, 21 Jul 2023 14:21:13 +0100
Message-ID: <20230721132120.5523-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230721132120.5523-1-rf@opensource.cirrus.com>
References: <20230721132120.5523-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R88KsQqCNOmkQMbFGeKN7T-bdddB11mv
X-Proofpoint-GUID: R88KsQqCNOmkQMbFGeKN7T-bdddB11mv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

Move the cs35l56 utility functions into the shared file so they are
available for use in HDA.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/sound/cs35l56.h           |   7 +
 sound/soc/codecs/cs35l56-shared.c | 208 ++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 203 -----------------------------
 3 files changed, 215 insertions(+), 203 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 532796efdaa5..3d2875094a21 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -274,6 +274,13 @@ extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
 int cs35l56_set_patch(struct cs35l56_base *cs35l56_base);
+int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command);
+int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base);
+void cs35l56_wait_min_reset_pulse(void);
+void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire);
+int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq);
+irqreturn_t cs35l56_irq(int irq, void *data);
+int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 47b915f33f52..d22aede1ee8d 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -195,6 +195,214 @@ static bool cs35l56_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
+{
+	unsigned int val;
+	int ret;
+
+	regmap_write(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
+				       val, (val == 0),
+				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
+	if (ret) {
+		dev_warn(cs35l56_base->dev, "MBOX command %#x failed: %d\n", command, ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_mbox_send, SND_SOC_CS35L56_SHARED);
+
+int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
+{
+	unsigned int reg;
+	unsigned int val;
+	int ret;
+
+	if (cs35l56_base->rev < CS35L56_REVID_B0)
+		reg = CS35L56_DSP1_HALO_STATE_A1;
+	else
+		reg = CS35L56_DSP1_HALO_STATE;
+
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap, reg,
+				       val,
+				       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
+				       CS35L56_HALO_STATE_POLL_US,
+				       CS35L56_HALO_STATE_TIMEOUT_US);
+
+	if ((ret < 0) && (ret != -ETIMEDOUT)) {
+		dev_err(cs35l56_base->dev, "Failed to read HALO_STATE: %d\n", ret);
+		return ret;
+	}
+
+	if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
+		dev_err(cs35l56_base->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_wait_for_firmware_boot, SND_SOC_CS35L56_SHARED);
+
+void cs35l56_wait_min_reset_pulse(void)
+{
+	/* Satisfy minimum reset pulse width spec */
+	usleep_range(CS35L56_RESET_PULSE_MIN_US, 2 * CS35L56_RESET_PULSE_MIN_US);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_wait_min_reset_pulse, SND_SOC_CS35L56_SHARED);
+
+static const struct reg_sequence cs35l56_system_reset_seq[] = {
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
+};
+
+void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
+{
+	/*
+	 * Must enter cache-only first so there can't be any more register
+	 * accesses other than the controlled system reset sequence below.
+	 */
+	regcache_cache_only(cs35l56_base->regmap, true);
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+					cs35l56_system_reset_seq,
+					ARRAY_SIZE(cs35l56_system_reset_seq));
+
+	/* On SoundWire the registers won't be accessible until it re-enumerates. */
+	if (is_soundwire)
+		return;
+
+	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
+	regcache_cache_only(cs35l56_base->regmap, false);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_system_reset, SND_SOC_CS35L56_SHARED);
+
+int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq)
+{
+	int ret;
+
+	if (!irq)
+		return 0;
+
+	ret = devm_request_threaded_irq(cs35l56_base->dev, irq, NULL, cs35l56_irq,
+					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
+					"cs35l56", cs35l56_base);
+	if (!ret)
+		cs35l56_base->irq = irq;
+	else
+		dev_err(cs35l56_base->dev, "Failed to get IRQ: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_irq_request, SND_SOC_CS35L56_SHARED);
+
+irqreturn_t cs35l56_irq(int irq, void *data)
+{
+	struct cs35l56_base *cs35l56_base = data;
+	unsigned int status1 = 0, status8 = 0, status20 = 0;
+	unsigned int mask1, mask8, mask20;
+	unsigned int val;
+	int rv;
+
+	irqreturn_t ret = IRQ_NONE;
+
+	if (!cs35l56_base->init_done)
+		return IRQ_NONE;
+
+	mutex_lock(&cs35l56_base->irq_lock);
+
+	rv = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (rv < 0) {
+		dev_err(cs35l56_base->dev, "irq: failed to get pm_runtime: %d\n", rv);
+		goto err_unlock;
+	}
+
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_STATUS, &val);
+	if ((val & CS35L56_IRQ1_STS_MASK) == 0) {
+		dev_dbg(cs35l56_base->dev, "Spurious IRQ: no pending interrupt\n");
+		goto err;
+	}
+
+	/* Ack interrupts */
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, &status1);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_1, &mask1);
+	status1 &= ~mask1;
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, status1);
+
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, &status8);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_8, &mask8);
+	status8 &= ~mask8;
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, status8);
+
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_20, &status20);
+	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, &mask20);
+	status20 &= ~mask20;
+	/* We don't want EINT20 but they default to unmasked: force mask */
+	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
+
+	dev_dbg(cs35l56_base->dev, "%s: %#x %#x\n", __func__, status1, status8);
+
+	/* Check to see if unmasked bits are active */
+	if (!status1 && !status8 && !status20)
+		goto err;
+
+	if (status1 & CS35L56_AMP_SHORT_ERR_EINT1_MASK)
+		dev_crit(cs35l56_base->dev, "Amp short error\n");
+
+	if (status8 & CS35L56_TEMP_ERR_EINT1_MASK)
+		dev_crit(cs35l56_base->dev, "Overtemp error\n");
+
+	ret = IRQ_HANDLED;
+
+err:
+	pm_runtime_put(cs35l56_base->dev);
+err_unlock:
+	mutex_unlock(&cs35l56_base->irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_irq, SND_SOC_CS35L56_SHARED);
+
+int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
+{
+	unsigned int val;
+	int ret;
+
+	/* Nothing to re-patch if we haven't done any patching yet. */
+	if (!cs35l56_base->fw_patched)
+		return false;
+
+	/*
+	 * If we have control of RESET we will have asserted it so the firmware
+	 * will need re-patching.
+	 */
+	if (cs35l56_base->reset_gpio)
+		return true;
+
+	/*
+	 * In secure mode FIRMWARE_MISSING is cleared by the BIOS loader so
+	 * can't be used here to test for memory retention.
+	 * Assume that tuning must be re-loaded.
+	 */
+	if (cs35l56_base->secured)
+		return true;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "Failed to runtime_get: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_PROTECTION_STATUS, &val);
+	if (ret)
+		dev_err(cs35l56_base->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+	else
+		ret = !!(val & CS35L56_FIRMWARE_MISSING);
+
+	pm_runtime_put_autosuspend(cs35l56_base->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_is_fw_reload_needed, SND_SOC_CS35L56_SHARED);
+
 const struct cs_dsp_region cs35l56_dsp1_regions[] = {
 	{ .type = WMFW_HALO_PM_PACKED,	.base = CS35L56_DSP1_PMEM_0 },
 	{ .type = WMFW_HALO_XM_PACKED,	.base = CS35L56_DSP1_XMEM_PACKED_0 },
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 87e2f618850b..5598000187a7 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -34,23 +34,6 @@
 static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event);
 
-static int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
-{
-	unsigned int val;
-	int ret;
-
-	regmap_write(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, command);
-	ret = regmap_read_poll_timeout(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1,
-				       val, (val == 0),
-				       CS35L56_MBOX_POLL_US, CS35L56_MBOX_TIMEOUT_US);
-	if (ret) {
-		dev_warn(cs35l56_base->dev, "MBOX command %#x failed: %d\n", command, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static void cs35l56_wait_dsp_ready(struct cs35l56_private *cs35l56)
 {
 	/* Wait for patching to complete */
@@ -315,92 +298,6 @@ static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
 	return wm_adsp_event(w, kcontrol, event);
 }
 
-irqreturn_t cs35l56_irq(int irq, void *data)
-{
-	struct cs35l56_base *cs35l56_base = data;
-	unsigned int status1 = 0, status8 = 0, status20 = 0;
-	unsigned int mask1, mask8, mask20;
-	unsigned int val;
-	int rv;
-
-	irqreturn_t ret = IRQ_NONE;
-
-	if (!cs35l56_base->init_done)
-		return IRQ_NONE;
-
-	mutex_lock(&cs35l56_base->irq_lock);
-
-	rv = pm_runtime_resume_and_get(cs35l56_base->dev);
-	if (rv < 0) {
-		dev_err(cs35l56_base->dev, "irq: failed to get pm_runtime: %d\n", rv);
-		goto err_unlock;
-	}
-
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_STATUS, &val);
-	if ((val & CS35L56_IRQ1_STS_MASK) == 0) {
-		dev_dbg(cs35l56_base->dev, "Spurious IRQ: no pending interrupt\n");
-		goto err;
-	}
-
-	/* Ack interrupts */
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, &status1);
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_1, &mask1);
-	status1 &= ~mask1;
-	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_1, status1);
-
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, &status8);
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_8, &mask8);
-	status8 &= ~mask8;
-	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_8, status8);
-
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_EINT_20, &status20);
-	regmap_read(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, &mask20);
-	status20 &= ~mask20;
-	/* We don't want EINT20 but they default to unmasked: force mask */
-	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
-
-	dev_dbg(cs35l56_base->dev, "%s: %#x %#x\n", __func__, status1, status8);
-
-	/* Check to see if unmasked bits are active */
-	if (!status1 && !status8 && !status20)
-		goto err;
-
-	if (status1 & CS35L56_AMP_SHORT_ERR_EINT1_MASK)
-		dev_crit(cs35l56_base->dev, "Amp short error\n");
-
-	if (status8 & CS35L56_TEMP_ERR_EINT1_MASK)
-		dev_crit(cs35l56_base->dev, "Overtemp error\n");
-
-	ret = IRQ_HANDLED;
-
-err:
-	pm_runtime_put(cs35l56_base->dev);
-err_unlock:
-	mutex_unlock(&cs35l56_base->irq_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(cs35l56_irq, SND_SOC_CS35L56_CORE);
-
-int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq)
-{
-	int ret;
-
-	if (!irq)
-		return 0;
-
-	ret = devm_request_threaded_irq(cs35l56_base->dev, irq, NULL, cs35l56_irq,
-					IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW,
-					"cs35l56", cs35l56_base);
-	if (!ret)
-		cs35l56_base->irq = irq;
-	else
-		dev_err(cs35l56_base->dev, "Failed to get IRQ: %d\n", ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS_GPL(cs35l56_irq_request, SND_SOC_CS35L56_CORE);
-
 static int cs35l56_asp_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(codec_dai->component);
@@ -762,65 +659,6 @@ static struct snd_soc_dai_driver cs35l56_dai[] = {
 	}
 };
 
-static int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
-{
-	unsigned int reg;
-	unsigned int val;
-	int ret;
-
-	if (cs35l56_base->rev < CS35L56_REVID_B0)
-		reg = CS35L56_DSP1_HALO_STATE_A1;
-	else
-		reg = CS35L56_DSP1_HALO_STATE;
-
-	ret = regmap_read_poll_timeout(cs35l56_base->regmap, reg,
-				       val,
-				       (val < 0xFFFF) && (val >= CS35L56_HALO_STATE_BOOT_DONE),
-				       CS35L56_HALO_STATE_POLL_US,
-				       CS35L56_HALO_STATE_TIMEOUT_US);
-
-	if ((ret < 0) && (ret != -ETIMEDOUT)) {
-		dev_err(cs35l56_base->dev, "Failed to read HALO_STATE: %d\n", ret);
-		return ret;
-	}
-
-	if ((ret == -ETIMEDOUT) || (val != CS35L56_HALO_STATE_BOOT_DONE)) {
-		dev_err(cs35l56_base->dev, "Firmware boot fail: HALO_STATE=%#x\n", val);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static inline void cs35l56_wait_min_reset_pulse(void)
-{
-	/* Satisfy minimum reset pulse width spec */
-	usleep_range(CS35L56_RESET_PULSE_MIN_US, 2 * CS35L56_RESET_PULSE_MIN_US);
-}
-
-static const struct reg_sequence cs35l56_system_reset_seq[] = {
-	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
-};
-
-static void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
-{
-	/*
-	 * Must enter cache-only first so there can't be any more register
-	 * accesses other than the controlled system reset sequence below.
-	 */
-	regcache_cache_only(cs35l56_base->regmap, true);
-	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
-					cs35l56_system_reset_seq,
-					ARRAY_SIZE(cs35l56_system_reset_seq));
-
-	/* On SoundWire the registers won't be accessible until it re-enumerates. */
-	if (is_soundwire)
-		return;
-
-	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
-	regcache_cache_only(cs35l56_base->regmap, false);
-}
-
 static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
 {
 	int ret;
@@ -1137,47 +975,6 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
 
-static int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
-{
-	unsigned int val;
-	int ret;
-
-	/* Nothing to re-patch if we haven't done any patching yet. */
-	if (!cs35l56_base->fw_patched)
-		return false;
-
-	/*
-	 * If we have control of RESET we will have asserted it so the firmware
-	 * will need re-patching.
-	 */
-	if (cs35l56_base->reset_gpio)
-		return true;
-
-	/*
-	 * In secure mode FIRMWARE_MISSING is cleared by the BIOS loader so
-	 * can't be used here to test for memory retention.
-	 * Assume that tuning must be re-loaded.
-	 */
-	if (cs35l56_base->secured)
-		return true;
-
-	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
-	if (ret) {
-		dev_err(cs35l56_base->dev, "Failed to runtime_get: %d\n", ret);
-		return ret;
-	}
-
-	ret = regmap_read(cs35l56_base->regmap, CS35L56_PROTECTION_STATUS, &val);
-	if (ret)
-		dev_err(cs35l56_base->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
-	else
-		ret = !!(val & CS35L56_FIRMWARE_MISSING);
-
-	pm_runtime_put_autosuspend(cs35l56_base->dev);
-
-	return ret;
-}
-
 int cs35l56_system_suspend(struct device *dev)
 {
 	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
-- 
2.30.2

