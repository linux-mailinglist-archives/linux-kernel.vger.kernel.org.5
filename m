Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36AA807CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441821AbjLGAFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjLGAEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:04:42 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F30E10C2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:04:39 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716FB.0000000065710C15.001190CD; Thu, 07 Dec 2023 01:04:37 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 12/16] ASoC: tas2781: move set_drv_data outside tasdevice_init
Date:   Thu,  7 Dec 2023 01:04:28 +0100
Message-ID: <bb94a9560f8a7453a77ba736f4d99d3fa90259e7.1701906455.git.soyer@irl.hu>
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

allow driver specific driver data in tas2781-hda-ic2c and tas2781-i2c

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c   | 2 ++
 sound/soc/codecs/tas2781-comlib.c | 2 --
 sound/soc/codecs/tas2781-i2c.c    | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index f28383597ca8..290c41194139 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -734,6 +734,8 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	if (!tas_priv)
 		return -ENOMEM;
 
+	dev_set_drvdata(&clt->dev, tas_priv);
+
 	if (strstr(dev_name(&clt->dev), "TIAS2781")) {
 		device_name = "TIAS2781";
 		tas_priv->load_calibration = load_calibration_efi_1;
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 635f97db033b..0c04735dd575 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -316,8 +316,6 @@ int tasdevice_init(struct tasdevice_priv *tas_priv)
 		tas_priv->tasdevice[i].cur_conf = -1;
 	}
 
-	dev_set_drvdata(tas_priv->dev, tas_priv);
-
 	mutex_init(&tas_priv->codec_lock);
 
 out:
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 55cd5e3c23a5..917b1c15f71d 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -689,6 +689,8 @@ static int tasdevice_i2c_probe(struct i2c_client *i2c)
 	if (!tas_priv)
 		return -ENOMEM;
 
+	dev_set_drvdata(&i2c->dev, tas_priv);
+
 	if (ACPI_HANDLE(&i2c->dev)) {
 		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
 				&i2c->dev);
-- 
2.43.0

