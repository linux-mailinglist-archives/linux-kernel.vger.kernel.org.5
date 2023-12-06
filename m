Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C375807CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441898AbjLGAAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441822AbjLGAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:01 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D21A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:00:07 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716F0.0000000065710B04.00119059; Thu, 07 Dec 2023 01:00:04 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 06/16] ASoC: tas2781: add ptrs to calibration functions
Date:   Thu,  7 Dec 2023 00:59:47 +0100
Message-ID: <e069d578aebb8d5aa1c09abae2a0f240b3dedec2.1701906455.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rename save_calibration to load_calibration

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781.h           |  5 +++++
 sound/pci/hda/tas2781_hda_i2c.c   | 28 ++++++++++++----------------
 sound/soc/codecs/tas2781-comlib.c | 15 +++++++++++++++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index a6c808b22318..1d3c71d7e68d 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -131,6 +131,9 @@ struct tasdevice_priv {
 		const struct firmware *fmw, int offset);
 	int (*tasdevice_load_block)(struct tasdevice_priv *tas_priv,
 		struct tasdev_blk *block);
+
+	int (*load_calibration)(struct tasdevice_priv *tas_priv);
+	void (*apply_calibration)(struct tasdevice_priv *tas_priv);
 };
 
 void tas2781_reset(struct tasdevice_priv *tas_dev);
@@ -139,6 +142,8 @@ int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 struct tasdevice_priv *tasdevice_kzalloc(struct i2c_client *i2c);
 int tasdevice_init(struct tasdevice_priv *tas_priv);
 void tasdevice_remove(struct tasdevice_priv *tas_priv);
+int tasdevice_load_calibration(struct tasdevice_priv *tas_priv);
+void tasdevice_apply_calibration(struct tasdevice_priv *tas_priv);
 int tasdevice_dev_read(struct tasdevice_priv *tas_priv,
 	unsigned short chn, unsigned int reg, unsigned int *value);
 int tasdevice_dev_write(struct tasdevice_priv *tas_priv,
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 70085177230e..2b5031e4dda3 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -395,7 +395,7 @@ static const struct snd_kcontrol_new tas2781_dsp_conf_ctrl = {
 	.put = tasdevice_config_put,
 };
 
-static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
+static void tas2781_apply_calibration(struct tasdevice_priv *tas_priv)
 {
 	static const unsigned char page_array[CALIB_MAX] = {
 		0x17, 0x18, 0x18, 0x0d, 0x18
@@ -426,7 +426,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
  * by Algo for calcucating the speaker temperature, speaker membrane excursion
  * and f0 in real time during playback.
  */
-static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
+static int load_calibration_efi_1(struct tasdevice_priv *tas_priv)
 {
 	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
 		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
@@ -547,7 +547,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	tas2781_save_calibration(tas_priv);
+	tasdevice_load_calibration(tas_priv);
 
 out:
 	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
@@ -650,15 +650,17 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	const char *device_name;
 	int ret;
 
-	if (strstr(dev_name(&clt->dev), "TIAS2781"))
-		device_name = "TIAS2781";
-	else
-		return -ENODEV;
-
 	tas_priv = tasdevice_kzalloc(clt);
 	if (!tas_priv)
 		return -ENOMEM;
 
+	if (strstr(dev_name(&clt->dev), "TIAS2781")) {
+		device_name = "TIAS2781";
+		tas_priv->load_calibration = load_calibration_efi_1;
+		tas_priv->apply_calibration = tas2781_apply_calibration;
+	} else
+		return -ENODEV;
+
 	tas_priv->irq_info.irq = clt->irq;
 	ret = tas2781_read_acpi(tas_priv, device_name);
 	if (ret)
@@ -726,8 +728,6 @@ static int tas2781_runtime_suspend(struct device *dev)
 static int tas2781_runtime_resume(struct device *dev)
 {
 	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
-	unsigned long calib_data_sz =
-		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 
 	dev_dbg(tas_priv->dev, "Runtime Resume\n");
 
@@ -738,8 +738,7 @@ static int tas2781_runtime_resume(struct device *dev)
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_priv);
+	tasdevice_apply_calibration(tas_priv);
 
 	mutex_unlock(&tas_priv->codec_lock);
 
@@ -770,8 +769,6 @@ static int tas2781_system_suspend(struct device *dev)
 static int tas2781_system_resume(struct device *dev)
 {
 	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
-	unsigned long calib_data_sz =
-		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 	int i, ret;
 
 	dev_dbg(tas_priv->dev, "System Resume\n");
@@ -793,8 +790,7 @@ static int tas2781_system_resume(struct device *dev)
 	/* If calibrated data occurs error, dsp will still work with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_priv);
+	tasdevice_apply_calibration(tas_priv);
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return 0;
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 933cd008e9f5..f914123c7284 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -414,6 +414,21 @@ void tasdevice_remove(struct tasdevice_priv *tas_priv)
 }
 EXPORT_SYMBOL_GPL(tasdevice_remove);
 
+int tasdevice_load_calibration(struct tasdevice_priv *tas_priv)
+{
+	if (tas_priv->load_calibration)
+		return tas_priv->load_calibration(tas_priv);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(tasdevice_load_calibration);
+
+void tasdevice_apply_calibration(struct tasdevice_priv *tas_priv)
+{
+	if (tas_priv->apply_calibration && tas_priv->cali_data.total_sz)
+		tas_priv->apply_calibration(tas_priv);
+}
+EXPORT_SYMBOL_GPL(tasdevice_apply_calibration);
+
 static int tasdevice_clamp(int val, int max, unsigned int invert)
 {
 	if (val > max)
-- 
2.43.0

