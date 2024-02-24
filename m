Return-Path: <linux-kernel+bounces-79735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF778625F4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30FE28304B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7447A6F;
	Sat, 24 Feb 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=willian.wang header.i=@willian.wang header.b="xpgAxafK"
Received: from mail-200160.simplelogin.co (mail-200160.simplelogin.co [176.119.200.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137647F57
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708791121; cv=pass; b=kCg7Ee0vaIU/Uv4vT1JDNF0zmTiffxrxIumXdMRQIh7/UsCxHcelEyRetiKPgH64op84IiU9K1pgz96mlVgulS6JJzplcO/wEtaxXIrDooSjsJEWZaaOBNo6yYcPNTIhKAEOJs1fNFbK0rfagT4yycDSeyDEWAzCG6pr+Xpt1uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708791121; c=relaxed/simple;
	bh=U/wcljAf4AANc6QDw+IQ0KO00PBVdngL7aa7qn719J0=;
	h=Subject:Date:MIME-Version:From:To:Cc:Message-ID; b=m7NkUTK9+ai8JNW0MnrehbEYC5UHueSEnvP+cQhJM1PuolzPX42kcwNsjS1cUH77YrT22lSi2zFzZcvzuxfLBh6kHSAqI9Kg+zytQkVVnr8ca3NN+9uWSYYOVqknBXAHX8xnSOuUVbJ2N13gQL3fu5q9eWRUdWm08qXSjhPIhVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willian.wang; spf=pass smtp.mailfrom=willian.wang; dkim=pass (1024-bit key) header.d=willian.wang header.i=@willian.wang header.b=xpgAxafK; arc=pass smtp.client-ip=176.119.200.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willian.wang
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willian.wang
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1708791118;
	cv=none; b=dNeApRfHn0PNlCV8M6BJ9lLjVdyrRO/xAa0RqijoKYY68N3jsp5yyHoR0bOmSE4CSn5CdInqPYEASfqTjfTtOZESawDqh9v+NoqyYo9BxaHKsiCbkc4piaKNOrryDRSDRrooakNqvvsqiabUPXDuTn6oReMY8XT3YEIZO758JheYU+NlWf4099NvxlkKcvVb0C0lH4Eged8cPpHbv/rzrFDdJJ8RLOD4aKx/FQsKHUxGHK1jk7ZaPNHM6SsqKLOicIyd3lMg/SeyGO4S+W8vpMX/YSSArfcIuQM8BvdIhjbmMSuRiK2Mq9lWTIpXnguQrx9ZBC1KiCxxOtYaJh3SPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1708791118; c=relaxed/simple;
	bh=U/wcljAf4AANc6QDw+IQ0KO00PBVdngL7aa7qn719J0=;
	h=Subject:Date:From:To:Cc; b=1jR0Om+G9gKkAld5BCGDKroMyIyHpLff5Fu3oAIgwMYfwZWSQgckOYV7eOuvwZQr8fWFmQmzjmm4Oof8psrH7D9YMV6hsfr6cF4S0p30WukosLHUC84EqMvU5HcOaMS2LgxWqGyVpENSoW/XmPboqNZmtPGNFN+EUBHehJHAB8pSo0B9WLl6QT5WpG/6QmaDGTMsWUA+rg09LORcRhwfiPcyU6BA+t5OR+JiqLQUMR/i0IC8L3z4OK2TUZTwOA5NbWb9/ODjLORTRGbIdV7j2VoSYSjo8C3ZqwJMk9w1TovehMVxtCAYBQttZuyKPsf3AcaKcV+TVF+N2BcS/BH5Xw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willian.wang;
	s=dkim; t=1708791118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PbQ4SLsny4bFWDjPuLR76KvUDSBLgo9Lb0WGrwi11bY=;
	b=xpgAxafKolY3zX2kr0bAvYrk5dun8TyrOIADUi09tmvSNbIefSukYfX9dqWoTPRFVNeBJ5
	sdWc74FAo6/8VsFIwn46NT7P85IuO8IZbhtFpd/72uZqsDrdwVViVQq4m/ZyL8eQaL6IS4
	ZSW2rceFqM5ztMCT5OoKEDZVO0cDc0E=
Subject: [PATCH v3] ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8
Date: Sat, 24 Feb 2024 13:11:49 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Willian Wang <git@willian.wang>
To: linux-sound@vger.kernel.org
Cc: 
 linux-kernel@vger.kernel.org,tiwai@suse.com,perex@perex.cz,stable@vger.kernel.org
Message-ID: <170879111795.8.6687687359006700715.273812184@willian.wang>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 273812189
X-SimpleLogin-Want-Signing: yes

Lenovo Slim/Yoga Pro 9 14IRP8 requires a special fixup because there is
a collision of its PCI SSID (17aa:3802) with Lenovo Yoga DuetITL 2021
codec SSID.

Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555
Link: https://lore.kernel.org/all/d5b42e483566a3815d229270abd668131a0d9f3a.camel@irl.hu
Cc: stable@vger.kernel.org
Signed-off-by: Willian Wang <git@willian.wang>
---
 sound/pci/hda/patch_realtek.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec1312bffd5..f3b847f38153 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7444,6 +7444,7 @@ enum {
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC298_FIXUP_LENOVO_C940_DUET7,
+	ALC287_FIXUP_LENOVO_14IRP8_DUETITL,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -7495,6 +7496,26 @@ static void alc298_fixup_lenovo_c940_duet7(struct hda_codec *codec,
 	__snd_hda_apply_fixup(codec, id, action, 0);
 }
 
+/* A special fixup for Lenovo Slim/Yoga Pro 9 14IRP8 and Yoga DuetITL 2021;
+ * 14IRP8 PCI SSID will mistakenly be matched with the DuetITL codec SSID,
+ * so we need to apply a different fixup in this case. The only DuetITL codec
+ * SSID reported so far is the 17aa:3802 while the 14IRP8 has the 17aa:38be
+ * and 17aa:38bf. If it weren't for the PCI SSID, the 14IRP8 models would
+ * have matched correctly by their codecs.
+ */
+static void alc287_fixup_lenovo_14irp8_duetitl(struct hda_codec *codec,
+					      const struct hda_fixup *fix,
+					      int action)
+{
+	int id;
+
+	if (codec->core.subsystem_id == 0x17aa3802)
+		id = ALC287_FIXUP_YOGA7_14ITL_SPEAKERS; /* DuetITL */
+	else
+		id = ALC287_FIXUP_TAS2781_I2C; /* 14IRP8 */
+	__snd_hda_apply_fixup(codec, id, action, 0);
+}
+
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_GPIO2] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9379,6 +9400,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_lenovo_c940_duet7,
 	},
+	[ALC287_FIXUP_LENOVO_14IRP8_DUETITL] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_lenovo_14irp8_duetitl,
+	},
 	[ALC287_FIXUP_13S_GEN2_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -10247,7 +10272,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8 / DuetITL 2021", ALC287_FIXUP_LENOVO_14IRP8_DUETITL),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-- 
2.43.2



