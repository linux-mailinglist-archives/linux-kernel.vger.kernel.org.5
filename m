Return-Path: <linux-kernel+bounces-97411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89069876A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E56281444
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868D3BBE0;
	Fri,  8 Mar 2024 17:42:19 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF955E78;
	Fri,  8 Mar 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919739; cv=none; b=TaScpy6uIfIjyNxpr4ubbT6qMMyNXUoYgsgAzaohYROaxV9i5drZSBJzq98eqKlT4Kj7rYe3APhpaF8BxLtg0tBjB29v+8LvSKF3gmT4Tq6A9IKCnoBaeQ3KV0CP/R2rV4yjA4GV7QFNEApA6XYS9QRRoJq7M0AUlB279eshw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919739; c=relaxed/simple;
	bh=Ig+eLq/Swz8NEyZK0Zsi8AZ2yOZH+1AjIHTvSRnoLgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b7WGHNk5FuY+k1RDKJ4KQoRe0hAyRjbdjsonloIrstOzkKl6TJ4DYJdzP3Tm6wLHNoi/gJf2wZhMtUdyCrKkYCrUflL/TOSW7oAyiVyXuaYVxNbmTpWzZ+Z4iHrfD+jDRIoeAWTwFJZm77jPY3UqhKqsEu1cH6DwEnGMnCSCyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076817.0000000065EB4DF1.0020A5E5; Fri, 08 Mar 2024 18:42:09 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 5/5] ALSA: hda/tas2781: restore power state after system_resume
Date: Fri,  8 Mar 2024 18:41:44 +0100
Message-ID: <1742b61901781826f6e6212ffe1d21af542d134a.1709918447.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709918447.git.soyer@irl.hu>
References: <cover.1709918447.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

After system_resume the amplifers will remain off, even if they were on
before system_suspend.

Use playback_started bool to save the playback state, and restore power
state based on it.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index a99f490c6a23..7aef93126ed0 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -160,11 +160,13 @@ static void tas2781_hda_playback_hook(struct device *dev, int action)
 		pm_runtime_get_sync(dev);
 		mutex_lock(&tas_hda->priv->codec_lock);
 		tasdevice_tuning_switch(tas_hda->priv, 0);
+		tas_hda->priv->playback_started = true;
 		mutex_unlock(&tas_hda->priv->codec_lock);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		mutex_lock(&tas_hda->priv->codec_lock);
 		tasdevice_tuning_switch(tas_hda->priv, 1);
+		tas_hda->priv->playback_started = false;
 		mutex_unlock(&tas_hda->priv->codec_lock);
 
 		pm_runtime_mark_last_busy(dev);
@@ -666,6 +668,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tasdevice_save_calibration(tas_priv);
 
 	tasdevice_tuning_switch(tas_hda->priv, 0);
+	tas_hda->priv->playback_started = true;
 
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
@@ -837,6 +840,9 @@ static int tas2781_runtime_suspend(struct device *dev)
 
 	mutex_lock(&tas_hda->priv->codec_lock);
 
+	/* The driver powers up the amplifiers at module load time.
+	 * Stop the playback if it's unused.
+	 */
 	if (tas_hda->priv->playback_started) {
 		tasdevice_tuning_switch(tas_hda->priv, 1);
 		tas_hda->priv->playback_started = false;
@@ -876,7 +882,8 @@ static int tas2781_system_suspend(struct device *dev)
 	mutex_lock(&tas_hda->priv->codec_lock);
 
 	/* Shutdown chip before system suspend */
-	tasdevice_tuning_switch(tas_hda->priv, 1);
+	if (tas_hda->priv->playback_started)
+		tasdevice_tuning_switch(tas_hda->priv, 1);
 
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
@@ -908,6 +915,10 @@ static int tas2781_system_resume(struct device *dev)
 	 * calibrated data inside algo.
 	 */
 	tasdevice_apply_calibration(tas_hda->priv);
+
+	if (tas_hda->priv->playback_started)
+		tasdevice_tuning_switch(tas_hda->priv, 0);
+
 	mutex_unlock(&tas_hda->priv->codec_lock);
 
 	return 0;
-- 
2.44.0


