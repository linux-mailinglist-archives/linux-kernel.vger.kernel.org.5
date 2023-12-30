Return-Path: <linux-kernel+bounces-13295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C684E82031F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3971F23046
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F89A5C;
	Sat, 30 Dec 2023 00:10:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8747F5;
	Sat, 30 Dec 2023 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b6838a.dsl.pool.telekom.hu [::ffff:81.182.131.138])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071EE1.00000000658F5FCF.0014D495; Sat, 30 Dec 2023 01:09:50 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 1/4] ALSA: hda/tas2781: add ptrs to calibration functions
Date: Sat, 30 Dec 2023 01:09:42 +0100
Message-ID: <5859c77ffef752b8a9784713b412d815d7e2688c.1703891777.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703891777.git.soyer@irl.hu>
References: <cover.1703891777.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Make calibration functions configurable to support different calibration
data storage modes.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781.h           |  5 +++++
 sound/pci/hda/tas2781_hda_i2c.c   | 25 +++++++++++--------------
 sound/soc/codecs/tas2781-comlib.c | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index a6c808b22318..e17ceab4fead 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -131,6 +131,9 @@ struct tasdevice_priv {
 		const struct firmware *fmw, int offset);
 	int (*tasdevice_load_block)(struct tasdevice_priv *tas_priv,
 		struct tasdev_blk *block);
+
+	int (*save_calibration)(struct tasdevice_priv *tas_priv);
+	void (*apply_calibration)(struct tasdevice_priv *tas_priv);
 };
 
 void tas2781_reset(struct tasdevice_priv *tas_dev);
@@ -139,6 +142,8 @@ int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 struct tasdevice_priv *tasdevice_kzalloc(struct i2c_client *i2c);
 int tasdevice_init(struct tasdevice_priv *tas_priv);
 void tasdevice_remove(struct tasdevice_priv *tas_priv);
+int tasdevice_save_calibration(struct tasdevice_priv *tas_priv);
+void tasdevice_apply_calibration(struct tasdevice_priv *tas_priv);
 int tasdevice_dev_read(struct tasdevice_priv *tas_priv,
 	unsigned short chn, unsigned int reg, unsigned int *value);
 int tasdevice_dev_write(struct tasdevice_priv *tas_priv,
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index dfe281b57aa6..0f8d5f947f54 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -479,7 +479,7 @@ static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
 		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
 			tm->tm_year, tm->tm_mon, tm->tm_mday,
 			tm->tm_hour, tm->tm_min, tm->tm_sec);
-		tas2781_apply_calib(tas_priv);
+		tasdevice_apply_calibration(tas_priv);
 	} else
 		tas_priv->cali_data.total_sz = 0;
 
@@ -582,7 +582,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	tas2781_save_calibration(tas_priv);
+	tasdevice_save_calibration(tas_priv);
 
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
@@ -683,10 +683,6 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	const char *device_name;
 	int ret;
 
-	if (strstr(dev_name(&clt->dev), "TIAS2781"))
-		device_name = "TIAS2781";
-	else
-		return -ENODEV;
 
 	tas_hda = devm_kzalloc(&clt->dev, sizeof(*tas_hda), GFP_KERNEL);
 	if (!tas_hda)
@@ -699,6 +695,13 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	if (!tas_hda->priv)
 		return -ENOMEM;
 
+	if (strstr(dev_name(&clt->dev), "TIAS2781")) {
+		device_name = "TIAS2781";
+		tas_hda->priv->save_calibration = tas2781_save_calibration;
+		tas_hda->priv->apply_calibration = tas2781_apply_calib;
+	} else
+		return -ENODEV;
+
 	tas_hda->priv->irq_info.irq = clt->irq;
 	ret = tas2781_read_acpi(tas_hda->priv, device_name);
 	if (ret)
@@ -765,8 +768,6 @@ static int tas2781_runtime_suspend(struct device *dev)
 static int tas2781_runtime_resume(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	unsigned long calib_data_sz =
-		tas_hda->priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 
 	dev_dbg(tas_hda->dev, "Runtime Resume\n");
 
@@ -777,8 +778,7 @@ static int tas2781_runtime_resume(struct device *dev)
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_hda->priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_hda->priv);
+	tasdevice_apply_calibration(tas_hda->priv);
 
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
@@ -809,8 +809,6 @@ static int tas2781_system_suspend(struct device *dev)
 static int tas2781_system_resume(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	unsigned long calib_data_sz =
-		tas_hda->priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 	int i, ret;
 
 	dev_info(tas_hda->priv->dev, "System Resume\n");
@@ -832,8 +830,7 @@ static int tas2781_system_resume(struct device *dev)
 	/* If calibrated data occurs error, dsp will still work with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_hda->priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_hda->priv);
+	tasdevice_apply_calibration(tas_hda->priv);
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
 	return 0;
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 00e35169ae49..b7e56ceb1acf 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -412,6 +412,21 @@ void tasdevice_remove(struct tasdevice_priv *tas_priv)
 }
 EXPORT_SYMBOL_GPL(tasdevice_remove);
 
+int tasdevice_save_calibration(struct tasdevice_priv *tas_priv)
+{
+	if (tas_priv->save_calibration)
+		return tas_priv->save_calibration(tas_priv);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(tasdevice_save_calibration);
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


