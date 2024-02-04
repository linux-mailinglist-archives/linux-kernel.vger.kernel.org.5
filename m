Return-Path: <linux-kernel+bounces-51870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C831A849048
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D67B2211F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC525567;
	Sun,  4 Feb 2024 20:06:49 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38025558;
	Sun,  4 Feb 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077209; cv=none; b=uk5LMuteNNAlhFLfZcnp/zLA1D00O9v9MxetZiGslD0r+fhNWa9fB4jG702MRb7ECRKCYiUbR3OuF+MLaPEeRe2I/zptHy24nUtKVkfnAXEBrosc2Ag1FUn9Ln/N4V56RQU0hE6bkFfn8g3Ublwr+n3h5ZrASxFFpuFikzklo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077209; c=relaxed/simple;
	bh=tpbjTw4X23EhfXeKly94uyy0NFWMMOuT2ePsQRoyPa0=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=ZgslfUj0tW8w1rOP61nEEo1di2cuBRSBjF6OCimdXqHQptFSZyAsBG/3qz9aZLKCBKhXUjIq/YNfg9GIm9gTaYuLyAQOro49rPP72yFmHaNzmRciL+M97/SvC//zq4q9ZigLXjlk8QmRItzzXeHczAIW+6sE+MPbAvkMPUPm77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68916.dsl.pool.telekom.hu [::ffff:81.182.137.22])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007429F.0000000065BFED1F.001A84E5; Sun, 04 Feb 2024 21:01:35 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH] ASoC: tas2781: add module parameter to tascodec_init()
Date: Sun,  4 Feb 2024 21:01:17 +0100
Message-ID: <118dad922cef50525e5aab09badef2fa0eb796e5.1707076603.git.soyer@irl.hu>
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

The tascodec_init() of the snd-soc-tas2781-comlib module is called from
snd-soc-tas2781-i2c and snd-hda-scodec-tas2781-i2c modules. It calls
request_firmware_nowait() with parameter THIS_MODULE and a cont/callback
from the latter modules.

The latter modules can be removed while their callbacks are running,
resulting in a general protection failure.

Add module parameter to tascodec_init() so request_firmware_nowait() can
be called with the module of the callback.

Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781.h           | 1 +
 sound/pci/hda/tas2781_hda_i2c.c   | 2 +-
 sound/soc/codecs/tas2781-comlib.c | 3 ++-
 sound/soc/codecs/tas2781-i2c.c    | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index b00d65417c31..9aff384941de 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -142,6 +142,7 @@ struct tasdevice_priv {
 
 void tas2781_reset(struct tasdevice_priv *tas_dev);
 int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
+	struct module *module,
 	void (*cont)(const struct firmware *fw, void *context));
 struct tasdevice_priv *tasdevice_kzalloc(struct i2c_client *i2c);
 int tasdevice_init(struct tasdevice_priv *tas_priv);
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 2dd809de62e5..1bfb00102a77 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -710,7 +710,7 @@ static int tas2781_hda_bind(struct device *dev, struct device *master,
 
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 
-	ret = tascodec_init(tas_hda->priv, codec, tasdev_fw_ready);
+	ret = tascodec_init(tas_hda->priv, codec, THIS_MODULE, tasdev_fw_ready);
 	if (!ret)
 		comps->playback_hook = tas2781_hda_playback_hook;
 
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index b7e56ceb1acf..5d0e5348b361 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -267,6 +267,7 @@ void tas2781_reset(struct tasdevice_priv *tas_dev)
 EXPORT_SYMBOL_GPL(tas2781_reset);
 
 int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
+	struct module *module,
 	void (*cont)(const struct firmware *fw, void *context))
 {
 	int ret = 0;
@@ -280,7 +281,7 @@ int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 		tas_priv->dev_name, tas_priv->ndev);
 	crc8_populate_msb(tas_priv->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
 	tas_priv->codec = codec;
-	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+	ret = request_firmware_nowait(module, FW_ACTION_UEVENT,
 		tas_priv->rca_binaryname, tas_priv->dev, GFP_KERNEL, tas_priv,
 		cont);
 	if (ret)
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 32913bd1a623..b5abff230e43 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -566,7 +566,7 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 {
 	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
 
-	return tascodec_init(tas_priv, codec, tasdevice_fw_ready);
+	return tascodec_init(tas_priv, codec, THIS_MODULE, tasdevice_fw_ready);
 }
 
 static void tasdevice_deinit(void *context)

base-commit: d4ea2bd1bb502c54380cc44a4130660494679bb8
-- 
2.43.0


