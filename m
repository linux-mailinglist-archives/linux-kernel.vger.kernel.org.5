Return-Path: <linux-kernel+bounces-9190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B481C21B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29D41C2388C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CE7949F;
	Thu, 21 Dec 2023 23:49:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879E78E9D;
	Thu, 21 Dec 2023 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b681e3.dsl.pool.telekom.hu [::ffff:81.182.129.227])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000710DA.000000006584CEFF.0013B0FB; Fri, 22 Dec 2023 00:49:19 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/tas2781: do not use regcache
Date: Fri, 22 Dec 2023 00:48:56 +0100
Message-ID: <491aeed0e2eecc3b704ec856f815db21bad3ba0e.1703202126.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

There are two problems with using regcache in this module.

The amplifier has 3 addressing levels (BOOK, PAGE, REG). The firmware
contains blocks that must be written to BOOK 0x8C. The regcache doesn't
know anything about BOOK, so regcache_sync writes invalid values to the
actual BOOK.

The module handles 2 or more separate amplifiers. The amplifiers have
different register values, and the module uses only one regmap/regcache
for all the amplifiers. The regcache_sync only writes the last amplifier
used.

The module successfully restores all the written register values (RC
profile, program, configuration, calibration) without regcache.

Remove regcache functions and set regmap cache_type to REGCACHE_NONE.

Link: https://lore.kernel.org/r/21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu/

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c   | 17 +----------------
 sound/soc/codecs/tas2781-comlib.c |  2 +-
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 2fb1a7037c82..e4c54b2a012c 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -717,8 +717,6 @@ static int tas2781_runtime_suspend(struct device *dev)
 		tas_priv->tasdevice[i].cur_conf = -1;
 	}
 
-	regcache_cache_only(tas_priv->regmap, true);
-	regcache_mark_dirty(tas_priv->regmap);
 
 	mutex_unlock(&tas_priv->codec_lock);
 
@@ -730,20 +728,11 @@ static int tas2781_runtime_resume(struct device *dev)
 	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
 	unsigned long calib_data_sz =
 		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
-	int ret;
 
 	dev_dbg(tas_priv->dev, "Runtime Resume\n");
 
 	mutex_lock(&tas_priv->codec_lock);
 
-	regcache_cache_only(tas_priv->regmap, false);
-	ret = regcache_sync(tas_priv->regmap);
-	if (ret) {
-		dev_err(tas_priv->dev,
-			"Failed to restore register cache: %d\n", ret);
-		goto out;
-	}
-
 	tasdevice_prmg_load(tas_priv, tas_priv->cur_prog);
 
 	/* If calibrated data occurs error, dsp will still works with default
@@ -752,10 +741,9 @@ static int tas2781_runtime_resume(struct device *dev)
 	if (tas_priv->cali_data.total_sz > calib_data_sz)
 		tas2781_apply_calib(tas_priv);
 
-out:
 	mutex_unlock(&tas_priv->codec_lock);
 
-	return ret;
+	return 0;
 }
 
 static int tas2781_system_suspend(struct device *dev)
@@ -770,10 +758,7 @@ static int tas2781_system_suspend(struct device *dev)
 		return ret;
 
 	/* Shutdown chip before system suspend */
-	regcache_cache_only(tas_priv->regmap, false);
 	tasdevice_tuning_switch(tas_priv, 1);
-	regcache_cache_only(tas_priv->regmap, true);
-	regcache_mark_dirty(tas_priv->regmap);
 
 	/*
 	 * Reset GPIO may be shared, so cannot reset here.
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index ffb26e4a7e2f..933cd008e9f5 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -39,7 +39,7 @@ static const struct regmap_range_cfg tasdevice_ranges[] = {
 static const struct regmap_config tasdevice_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_NONE,
 	.ranges = tasdevice_ranges,
 	.num_ranges = ARRAY_SIZE(tasdevice_ranges),
 	.max_register = 256 * 128,

base-commit: 916d051730ae48aef8b588fd096fefca4bc0590a
-- 
2.43.0


