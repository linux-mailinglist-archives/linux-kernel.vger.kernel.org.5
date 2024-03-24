Return-Path: <linux-kernel+bounces-113901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7B888743
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1158EB21112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4236153572;
	Sun, 24 Mar 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLRh9yry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9312BEB1;
	Sun, 24 Mar 2024 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320998; cv=none; b=dqz8og1huKtR9i6YfEJ60QL1SsrHWzu7g+3xuVvMbzhxqNVkTOZyHIjx2j3vAdnfem5TdyFD9zzLaObmgHMuYC7+3Qn6hD1GSaqkkKe51h/ZtUVMn4yXn+kYjMWqQaccCEwnJEsrF0adBsLgAj5sR6iW8JdTAVoCvXnrDdMIoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320998; c=relaxed/simple;
	bh=O1E3hKAryL4U0bcVbUJUULwoULTDCa0K4xgRaVLeFaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTUQuipFikr0J+tbJZSG1UbjYhnyw0xENfl8DFajwbxWIVTUUcLn23jZ25Olilvc7Q/Zj77BmKP28QgCgZ0aNbl5Y5rBigmB6T3Dmr8otnBSF1Hc+X0QtPBm6c6CuYgznUeBgc45af+7tszZEQbRfgTVkhYnZEVkMQqB1MROrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLRh9yry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814BCC43390;
	Sun, 24 Mar 2024 22:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320997;
	bh=O1E3hKAryL4U0bcVbUJUULwoULTDCa0K4xgRaVLeFaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLRh9yry8/hadbmDVtKs3D+V7t3QQIi2otEytox2+KNpg5g+oJzd4/HppQ1tf9+Yb
	 0ctCedjIgc8CZ4y1G7w4nm8nb7ADH8U36+d6DhrXcGzG34K7oAW/Spbud975oqB4Yw
	 R5jH/3DSZPvFD2DqKjrJLAMNXlNIdwkLeQLg7JP1Zd/jumQfFVAP/5W3Yvo0xJGDdn
	 hEFmxBfYXo0fiQRTNhmWrmytupn36C3DpNiv9thmOaBuWjmKBxWT56bF/WoCz/ro75
	 ICgxIq6IZ1K9LGNFtfFIG3ib7TtIIe28jM14U+mRD9fjc7pjn7vpg53I+GafJQSqCK
	 2DsXWLKB3HsRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 559/713] ALSA: hda/tas2781: add ptrs to calibration functions
Date: Sun, 24 Mar 2024 18:44:45 -0400
Message-ID: <20240324224720.1345309-560-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit 76f5f55c45b906710c9565a7e68c8d782c46b394 ]

Make calibration functions configurable to support different calibration
data storage modes.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/5859c77ffef752b8a9784713b412d815d7e2688c.1703891777.git.soyer@irl.hu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 5f51de7e30c7 ("ALSA: hda/tas2781: do not call pm_runtime_force_* in system_resume/suspend")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/tas2781.h           |  5 +++++
 sound/pci/hda/tas2781_hda_i2c.c   | 25 +++++++++++--------------
 sound/soc/codecs/tas2781-comlib.c | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 475294c853aa4..be58d870505a4 100644
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
@@ -140,6 +143,8 @@ int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 struct tasdevice_priv *tasdevice_kzalloc(struct i2c_client *i2c);
 int tasdevice_init(struct tasdevice_priv *tas_priv);
 void tasdevice_remove(struct tasdevice_priv *tas_priv);
+int tasdevice_save_calibration(struct tasdevice_priv *tas_priv);
+void tasdevice_apply_calibration(struct tasdevice_priv *tas_priv);
 int tasdevice_dev_read(struct tasdevice_priv *tas_priv,
 	unsigned short chn, unsigned int reg, unsigned int *value);
 int tasdevice_dev_write(struct tasdevice_priv *tas_priv,
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 04539abf9e716..167ee2f89e9d0 100644
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
@@ -758,8 +761,6 @@ static int tas2781_runtime_suspend(struct device *dev)
 static int tas2781_runtime_resume(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	unsigned long calib_data_sz =
-		tas_hda->priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 
 	dev_dbg(tas_hda->dev, "Runtime Resume\n");
 
@@ -770,8 +771,7 @@ static int tas2781_runtime_resume(struct device *dev)
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_hda->priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_hda->priv);
+	tasdevice_apply_calibration(tas_hda->priv);
 
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
@@ -806,8 +806,6 @@ static int tas2781_system_suspend(struct device *dev)
 static int tas2781_system_resume(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
-	unsigned long calib_data_sz =
-		tas_hda->priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
 	int i, ret;
 
 	dev_dbg(tas_hda->priv->dev, "System Resume\n");
@@ -829,8 +827,7 @@ static int tas2781_system_resume(struct device *dev)
 	/* If calibrated data occurs error, dsp will still work with default
 	 * calibrated data inside algo.
 	 */
-	if (tas_hda->priv->cali_data.total_sz > calib_data_sz)
-		tas2781_apply_calib(tas_hda->priv);
+	tasdevice_apply_calibration(tas_hda->priv);
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
 	return 0;
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index add16302f711e..5d0e5348b361a 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -413,6 +413,21 @@ void tasdevice_remove(struct tasdevice_priv *tas_priv)
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


