Return-Path: <linux-kernel+bounces-119442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902988C8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B37C1C3565C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73B13CC4A;
	Tue, 26 Mar 2024 16:19:04 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9B13C9A2;
	Tue, 26 Mar 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469943; cv=none; b=YGtSFdtLq33zQcgDvf0WvXaq8l/Abp/QsmWcWFkBpWiekDQxPH70e4x9ou/2LkWivbKoBqn0vfky6/7hukwpSJMm4DFrwpJ92Qi28oOoLe84PLnJAThdV9NL5ZSJVQq3B1BB08VklLkImNPw+1LiiO4ymahiPA/5f3dW/48XdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469943; c=relaxed/simple;
	bh=L+q8Bz8ds3vFmEIewe+gxAJPjDaqpzMYghNPAeRyPt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NIEpQf/Rv/ZuKDvFjEEx8RjAlp5QT7bf8lNyqzuWIytIZijm+umR8NwRR59qIUGhjNcuWAAKnzniURzRrxO00wUMgTVflTCcUH1N+6uisCjp9JawWyCl+txU/oKOiP3LklmNobAteKRJrD6cX46CDWh3wThXJrrbx1InAe3Tub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007733D.000000006602F573.0023D3BC; Tue, 26 Mar 2024 17:18:59 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 3/4] ALSA: hda/tas2781: add debug statements to kcontrols
Date: Tue, 26 Mar 2024 17:18:47 +0100
Message-ID: <18ff4b0caab90a2dacf907e62346fd5079a9eb1a.1711469583.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711469583.git.soyer@irl.hu>
References: <cover.1711469583.git.soyer@irl.hu>
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
 sound/pci/hda/tas2781_hda_i2c.c | 35 +++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 9a43f563bb9e..f495caee38e1 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -189,6 +189,9 @@ static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
 
 	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d\n",
+		__func__, kcontrol->id.name, tas_priv->rcabin.profile_cfg_id);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return 0;
@@ -206,6 +209,10 @@ static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d -> %d\n",
+		__func__, kcontrol->id.name,
+		tas_priv->rcabin.profile_cfg_id, val);
+
 	if (tas_priv->rcabin.profile_cfg_id != val) {
 		tas_priv->rcabin.profile_cfg_id = val;
 		ret = 1;
@@ -253,6 +260,9 @@ static int tasdevice_program_get(struct snd_kcontrol *kcontrol,
 
 	ucontrol->value.integer.value[0] = tas_priv->cur_prog;
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d\n",
+		__func__, kcontrol->id.name, tas_priv->cur_prog);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return 0;
@@ -271,6 +281,9 @@ static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d -> %d\n",
+		__func__, kcontrol->id.name, tas_priv->cur_prog, val);
+
 	if (tas_priv->cur_prog != val) {
 		tas_priv->cur_prog = val;
 		ret = 1;
@@ -290,6 +303,9 @@ static int tasdevice_config_get(struct snd_kcontrol *kcontrol,
 
 	ucontrol->value.integer.value[0] = tas_priv->cur_conf;
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d\n",
+		__func__, kcontrol->id.name, tas_priv->cur_conf);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return 0;
@@ -308,6 +324,9 @@ static int tasdevice_config_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d -> %d\n",
+		__func__, kcontrol->id.name, tas_priv->cur_conf, val);
+
 	if (tas_priv->cur_conf != val) {
 		tas_priv->cur_conf = val;
 		ret = 1;
@@ -330,6 +349,9 @@ static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
 
 	ret = tasdevice_amp_getvol(tas_priv, ucontrol, mc);
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %ld\n",
+		__func__, kcontrol->id.name, ucontrol->value.integer.value[0]);
+
 	mutex_unlock(&tas_priv->codec_lock);
 
 	return ret;
@@ -345,6 +367,9 @@ static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: -> %ld\n",
+		__func__, kcontrol->id.name, ucontrol->value.integer.value[0]);
+
 	/* The check of the given value is in tasdevice_amp_putvol. */
 	ret = tasdevice_amp_putvol(tas_priv, ucontrol, mc);
 
@@ -361,8 +386,8 @@ static int tas2781_force_fwload_get(struct snd_kcontrol *kcontrol,
 	mutex_lock(&tas_priv->codec_lock);
 
 	ucontrol->value.integer.value[0] = (int)tas_priv->force_fwload_status;
-	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
-			tas_priv->force_fwload_status ? "ON" : "OFF");
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d\n",
+		__func__, kcontrol->id.name, tas_priv->force_fwload_status);
 
 	mutex_unlock(&tas_priv->codec_lock);
 
@@ -377,14 +402,16 @@ static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&tas_priv->codec_lock);
 
+	dev_dbg(tas_priv->dev, "%s: kcontrol %s: %d -> %d\n",
+		__func__, kcontrol->id.name,
+		tas_priv->force_fwload_status, val);
+
 	if (tas_priv->force_fwload_status == val)
 		change = false;
 	else {
 		change = true;
 		tas_priv->force_fwload_status = val;
 	}
-	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
-		tas_priv->force_fwload_status ? "ON" : "OFF");
 
 	mutex_unlock(&tas_priv->codec_lock);
 
-- 
2.44.0


