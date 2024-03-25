Return-Path: <linux-kernel+bounces-118034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3288B2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1711C3D8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFE66F07B;
	Mon, 25 Mar 2024 21:26:01 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD896D1CC;
	Mon, 25 Mar 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401961; cv=none; b=Dr0GCZPfRg22dAniXMaz/TxQtUiZHoOnjo7tdH6Gd0wIj1c+uxr4wCvMPKG2lKBX4Z3h/GUlCr+4NA5y5Oa+hwVvLGyvfiCABINlATAMUnh0+EyZ4LMJlAc7xHjXjHk16/j8un1SwBXEYUr/pHZWSYUHUfEVwSzSEdqS+TCsL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401961; c=relaxed/simple;
	bh=AJHi0yEoUy7xt9EwDVeVmYbzGiFayqXL/wNoZ+TUfYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FH3VM2IPH1a+N2FvtPTbwIpHOFSBx3wH7E4rUB7idf+7MPbknjHqC5XLbYw+kU/ZTMzrYFNEARQagx4elUxzw/PH0zS53ItR6odIx5l2TTuj5CcTO/3CaGNqzU9OYZ0KsTo9zid0sOO2Lc1ogTLvvFFwwgdIzyIbM4TMvGZ4wv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000770AE.000000006601EBE5.0023A884; Mon, 25 Mar 2024 22:25:49 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH 1/3] ALSA: hda/tas2781: remove digital gain kcontrol
Date: Mon, 25 Mar 2024 22:25:33 +0100
Message-ID: <313e00499eb2caadd23a92284fdec418b650b7f4.1711401621.git.soyer@irl.hu>
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

The "Speaker Digital Gain" kcontrol controls the TAS2781_DVC_LVL (0x1A)
register. Unfortunately the tas2563 does not have DVC_LVL, but has
INT_MASK0 in 0x1A, which has been misused so far.

Since commit c1947ce61ff4 ("ALSA: hda/realtek: tas2781: enable subwoofer
volume control") the volume of the tas2781 amplifiers can be controlled
by the master volume, so this digital gain kcontrol is not needed.

Remove it.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
CC: stable@vger.kernel.org
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781-tlv.h     |  1 -
 sound/pci/hda/tas2781_hda_i2c.c | 37 +--------------------------------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index 4038dd421150..a29bcfb5bb2b 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -15,7 +15,6 @@
 #ifndef __TAS2781_TLV_H__
 #define __TAS2781_TLV_H__
 
-static const DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
 
 #endif
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 4475cea8e9f7..5acb475c10a7 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -89,7 +89,7 @@ struct tas2781_hda {
 	struct snd_kcontrol *dsp_prog_ctl;
 	struct snd_kcontrol *dsp_conf_ctl;
 	struct snd_kcontrol *prof_ctl;
-	struct snd_kcontrol *snd_ctls[3];
+	struct snd_kcontrol *snd_ctls[2];
 };
 
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
@@ -294,27 +294,6 @@ static int tasdevice_config_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-/*
- * tas2781_digital_getvol - get the volum control
- * @kcontrol: control pointer
- * @ucontrol: User data
- * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
- * depends on internal regmap mechanism.
- * tas2781 contains book and page two-level register map, especially
- * book switching will set the register BXXP00R7F, after switching to the
- * correct book, then leverage the mechanism for paging to access the
- * register.
- */
-static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-
-	return tasdevice_digital_getvol(tas_priv, ucontrol, mc);
-}
-
 static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -325,17 +304,6 @@ static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
 	return tasdevice_amp_getvol(tas_priv, ucontrol, mc);
 }
 
-static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-
-	/* The check of the given value is in tasdevice_digital_putvol. */
-	return tasdevice_digital_putvol(tas_priv, ucontrol, mc);
-}
-
 static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -381,9 +349,6 @@ static const struct snd_kcontrol_new tas2781_snd_controls[] = {
 	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
 		1, 0, 20, 0, tas2781_amp_getvol,
 		tas2781_amp_putvol, amp_vol_tlv),
-	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
-		0, 0, 200, 1, tas2781_digital_getvol,
-		tas2781_digital_putvol, dvc_tlv),
 	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
 		tas2781_force_fwload_get, tas2781_force_fwload_put),
 };
-- 
2.44.0


