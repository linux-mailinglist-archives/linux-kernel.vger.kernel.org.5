Return-Path: <linux-kernel+bounces-118036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A0B88B2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC1B1C3C6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0A7173A;
	Mon, 25 Mar 2024 21:26:08 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7736FE2A;
	Mon, 25 Mar 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401968; cv=none; b=Vrjb33XOzDrSQNK8Di5QArcdG1gN6B5Foo6VaSbU4hCpv8vQZimD8eVj42hrnX5iYYOrFP44/Qc2Z3uIea7lpTWlbMKpb7MxemPFuyYVyK/cyqGxp0wPA4EdW3IyX8ErpeXrJ3UwiD6oGzQHSuSS5qgxlos6HSAKsV8S0rlZjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401968; c=relaxed/simple;
	bh=7tKjUPBeypTJx3dhjiPVGtY+r3oYW9ckUbJZzdlsjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k/6Jflculyxgx5KZlQrsLfRI5kZ1yt22ZmP80hhzpAXfeSPsNPkM6h8IQ7pyoYGUtPJQLRaYSEmge3Pur+5PWNeq2Ihh7XaCXMRImsyRoj5NuR/io3CIuM4Na8sWo7liJl8k3KYqgpbmLPQAkDItt/Lx65zHz9jDom0pyxHx7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000770B0.000000006601EBEE.0023A89D; Mon, 25 Mar 2024 22:26:03 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 3/3] ALSA: hda/tas2781: add debug statements to kcontrols
Date: Mon, 25 Mar 2024 22:25:35 +0100
Message-ID: <cbdc337b911bee0f80f805b936041fd59c1db54a.1711401621.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711401621.git.soyer@irl.hu>
References: <cover.1711401621.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Sometimes it is useful to examine the timing of kcontrol events.

Add debug statements to each kcontrol.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 9a43f563bb9e..b60ce4c2c090 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -189,6 +189,9 @@ static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
 
 	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
 
+	dev_dbg(tas_priv->dev, "%s: %d\n", __func__,
+		tas_priv->rcabin.profile_cfg_id);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return 0;
@@ -206,6 +209,9 @@ static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: %d -> %d\n", __func__,
+		tas_priv->rcabin.profile_cfg_id, val);
+
 	if (tas_priv->rcabin.profile_cfg_id != val) {
 		tas_priv->rcabin.profile_cfg_id = val;
 		ret = 1;
@@ -253,6 +259,8 @@ static int tasdevice_program_get(struct snd_kcontrol *kcontrol,
 
 	ucontrol->value.integer.value[0] = tas_priv->cur_prog;
 
+	dev_dbg(tas_priv->dev, "%s: %d\n", __func__, tas_priv->cur_prog);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return 0;
@@ -271,6 +279,9 @@ static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: %d -> %d\n", __func__,
+		tas_priv->cur_prog, val);
+
 	if (tas_priv->cur_prog != val) {
 		tas_priv->cur_prog = val;
 		ret = 1;
@@ -290,6 +301,8 @@ static int tasdevice_config_get(struct snd_kcontrol *kcontrol,
 
 	ucontrol->value.integer.value[0] = tas_priv->cur_conf;
 
+	dev_dbg(tas_priv->dev, "%s: %d\n", __func__, tas_priv->cur_conf);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return 0;
@@ -308,6 +321,9 @@ static int tasdevice_config_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: %d -> %d\n", __func__,
+		tas_priv->cur_conf, val);
+
 	if (tas_priv->cur_conf != val) {
 		tas_priv->cur_conf = val;
 		ret = 1;
@@ -330,6 +346,9 @@ static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
 
 	ret = tasdevice_amp_getvol(tas_priv, ucontrol, mc);
 
+	dev_dbg(tas_priv->dev, "%s: %ld\n", __func__,
+		ucontrol->value.integer.value[0]);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return ret;
@@ -345,6 +364,9 @@ static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: %ld\n", __func__,
+		ucontrol->value.integer.value[0]);
+
 	/* The check of the given value is in tasdevice_amp_putvol. */
 	ret = tasdevice_amp_putvol(tas_priv, ucontrol, mc);
 
-- 
2.44.0


