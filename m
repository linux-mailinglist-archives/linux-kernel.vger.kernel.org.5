Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEB807CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441864AbjLGAAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjLFX77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:59:59 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7372DD44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:00:05 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716E7.0000000065710B03.00119029; Thu, 07 Dec 2023 01:00:03 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
Date:   Thu,  7 Dec 2023 00:59:44 +0100
Message-ID: <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
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

The amp has 3 level addressing (BOOK, PAGE, REG).
The regcache couldn't handle it.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c   | 17 +----------------
 sound/soc/codecs/tas2781-comlib.c |  2 +-
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 077a01521eef..d272d3d08b29 100644
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
-- 
2.43.0

