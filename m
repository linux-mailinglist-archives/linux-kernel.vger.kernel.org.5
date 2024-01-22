Return-Path: <linux-kernel+bounces-33294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB4583680C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF6F1C22C94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED1241774;
	Mon, 22 Jan 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8Q39pps"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB55D72B;
	Mon, 22 Jan 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935675; cv=none; b=q+EXg/h7p7KUkR2KD606R+dcEC1YsIBIWHfKpPS3tIkGfjuYd146GwwI2qMu8sYxp+Ub6TuahswOozdIVU60EWO96HEWVrYss3EPisTWUYq1k6MFOXbYWdtjxlfddnllkUGkKLN35MeAQnvzqgQ2VVPF1Ih8BafjVHDsmr16+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935675; c=relaxed/simple;
	bh=jMt1X1UPSGWztS6fWUz+xylWbP0lQWWMOLDrSFZxAZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiRn24l/RqZDhIJmEsmMPbEDhndzod2HoNCYy97UxAZaH6vIElNkO/JQEvpeSBozi2TEbLA/8nxqeZCFZ4M969rIcEG25wp5yrfkXvVxjLKnbjNvrSywdVwzMDj0gBNld5PyHzwQr4pQK0N+aPL7QXJhKsomAvP+dO8LvqwboFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8Q39pps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA12C433F1;
	Mon, 22 Jan 2024 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935674;
	bh=jMt1X1UPSGWztS6fWUz+xylWbP0lQWWMOLDrSFZxAZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8Q39ppsM/YaOVhAZ+2uRn/5CxSu2GYc30UsCt6XjnxgUo84H9kpleyqJxYQmDZDL
	 Wut4D56+waMHf8yf8PipaErC8HSOpywwXrK5VOdGjaMi4DYyN5QT/ErwEcs2gzfr8/
	 Tj4+uKn/gh2+ue09M+OEs2eijy1MWJXpU/m+fpOBK9/GMCgg+5WwYmpw8Vy28wgK3P
	 +9uJQC0l3yD114RXKxYDD8CybK/jSud2thqzoSm9dGNYZ4BlKk90EcPeyxa9SdJBdJ
	 4n0X5HULSdUf1tOpTNyI9ww9Wzj+vE2KZ/17/IYNEwHTKF7lQoErMyoWDVjEOpALx0
	 QvqZqbtI3hzRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 72/88] ALSA: hda/tas2781: add fixup for Lenovo 14ARB7
Date: Mon, 22 Jan 2024 09:51:45 -0500
Message-ID: <20240122145608.990137-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit b5cb53fd32779f3a971c45bcd997ae2608aa1086 ]

The 14ARB7 has two tas2563 amplifier on i2c.
Connect it to the tas2781 driver.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/abce9ee55689523562feb72383377171a489ddc7.1703891777.git.soyer@irl.hu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 70b17b08d4ff..9606f2448fda 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6984,6 +6984,12 @@ static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
 }
 
+static void yoga7_14arb7_fixup_i2c(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	 tas2781_generic_fixup(cdc, action, "i2c", "INT8866");
+}
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -7454,6 +7460,7 @@ enum {
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 	ALC287_FIXUP_TAS2781_I2C,
+	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
@@ -9568,6 +9575,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
+	[ALC287_FIXUP_YOGA7_14ARB7_I2C] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = yoga7_14arb7_fixup_i2c,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
+	},
 	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_mute_led_coefbit,
@@ -10221,6 +10234,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_TAS2781_I2C),
-- 
2.43.0


