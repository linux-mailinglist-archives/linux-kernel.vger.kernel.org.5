Return-Path: <linux-kernel+bounces-115974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3658898EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC0D29FAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB8170A3A;
	Mon, 25 Mar 2024 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URl9U3rI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4015E20C;
	Sun, 24 Mar 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322264; cv=none; b=sUF0a/1sEaNl7lPDB93UM0Txpq8JT05Tev879WBT4ZiB/RuScZDlAqLSX4MLL5ZsXWWzH9hanDUN8I+0/G0d3NTBKZBkleByb7zYMUrJTYngOaEJZFI6h/FamZmqZw1k8GWk4RDSs1I9OSzPLHaEKdxNfOj73pXVVG7ilczjtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322264; c=relaxed/simple;
	bh=yN8UXu+jWveTwk/oPq7r1Nie8LnpyaY4PVFIfLK2RaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqkiIcqvxUvZ10esxFyEWuhQAnNTgfwoKo6oNCYLTcYnZMaqlGPvakAeNORUifToyTO7sYKw8ycdNP3FWLz85v5Mh67fBc1eTKRV784id1QJfBCExiDrwE831UjAhAa/38Y/CgEfS1Nc8wyLhZ/570oC1oEzOC4y03oYzsIW5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URl9U3rI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE182C433C7;
	Sun, 24 Mar 2024 23:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322264;
	bh=yN8UXu+jWveTwk/oPq7r1Nie8LnpyaY4PVFIfLK2RaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URl9U3rI0ec+JFAyhVNM4vEazg9IY/4BT+4w9RyJk9fW/fch4C/ZjeuA5x2CrE+b1
	 MnDxFzDsWVoD8t2BFsc9TXXE1CcK72lW1JOh5c3or63kka6bI+26Fi/gnoTmLiIU/s
	 XVnnXWhhAsxZnjAR++8na0yj2la6ZN0VOBzVzyZty+BXX0HXDGX2PfawUGAabMbNBw
	 n5Fby+nZ2Ojex8RDvdFEAbg3VpAdgkrRo5IfMBZpz4kEel10Ll4OZgBJFLXT3OBe/i
	 32yZaaKrKX53t5NmMgKE4qCYxIVCKBjUzcMVPiaAY7xWiHuAYNRfCLGIJqt5JECS9n
	 R4APQLKJM+FDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 347/451] ALSA: hda/realtek: fix ALC285 issues on HP Envy x360 laptops
Date: Sun, 24 Mar 2024 19:10:23 -0400
Message-ID: <20240324231207.1351418-348-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Athaariq Ardhiansyah <foss@athaariq.my.id>

[ Upstream commit c062166995c9e57d5cd508b332898f79da319802 ]

Realtek codec on HP Envy laptop series are heavily modified by vendor.
Therefore, need intervention to make it work properly. The patch fixes:

- B&O soundbar speakers (between lid and keyboard) activation
- Enable LED on mute button
- Add missing process coefficient which affects the output amplifier
- Volume control synchronization between B&O soundbar and side speakers
- Unmute headset output on several HP Envy models
- Auto-enable headset mic when plugged

This patch was tested on HP Envy x360 13-AR0107AU with Realtek ALC285

The only unsolved problem is output amplifier of all built-in speakers
is too weak, which causes volume of built-in speakers cannot be loud
as vendor's proprietary driver due to missing _DSD parameter in the
firmware. The solution is currently on research. Expected to has another
patch in the future.

Potential fix to related issues, need test before close those issues:

- https://bugzilla.kernel.org/show_bug.cgi?id=189331
- https://bugzilla.kernel.org/show_bug.cgi?id=216632
- https://bugzilla.kernel.org/show_bug.cgi?id=216311
- https://bugzilla.kernel.org/show_bug.cgi?id=213507

Signed-off-by: Athaariq Ardhiansyah <foss@athaariq.my.id>
Message-ID: <20240310140249.3695-1-foss@athaariq.my.id>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 63 +++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ede3f8b273d79..6e759032eba2e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6693,6 +6693,60 @@ static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
 	}
 }
 
+static void alc285_fixup_hp_envy_x360(struct hda_codec *codec,
+				      const struct hda_fixup *fix,
+				      int action)
+{
+	static const struct coef_fw coefs[] = {
+		WRITE_COEF(0x08, 0x6a0c), WRITE_COEF(0x0d, 0xa023),
+		WRITE_COEF(0x10, 0x0320), WRITE_COEF(0x1a, 0x8c03),
+		WRITE_COEF(0x25, 0x1800), WRITE_COEF(0x26, 0x003a),
+		WRITE_COEF(0x28, 0x1dfe), WRITE_COEF(0x29, 0xb014),
+		WRITE_COEF(0x2b, 0x1dfe), WRITE_COEF(0x37, 0xfe15),
+		WRITE_COEF(0x38, 0x7909), WRITE_COEF(0x45, 0xd489),
+		WRITE_COEF(0x46, 0x00f4), WRITE_COEF(0x4a, 0x21e0),
+		WRITE_COEF(0x66, 0x03f0), WRITE_COEF(0x67, 0x1000),
+		WRITE_COEF(0x6e, 0x1005), { }
+	};
+
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x12, 0xb7a60130 },  /* Internal microphone*/
+		{ 0x14, 0x90170150 },  /* B&O soundbar speakers */
+		{ 0x17, 0x90170153 },  /* Side speakers */
+		{ 0x19, 0x03a11040 },  /* Headset microphone */
+		{ }
+	};
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
+
+		/* Fixes volume control problem for side speakers */
+		alc295_fixup_disable_dac3(codec, fix, action);
+
+		/* Fixes no sound from headset speaker */
+		snd_hda_codec_amp_stereo(codec, 0x21, HDA_OUTPUT, 0, -1, 0);
+
+		/* Auto-enable headset mic when plugged */
+		snd_hda_jack_set_gating_jack(codec, 0x19, 0x21);
+
+		/* Headset mic volume enhancement */
+		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREF50);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		alc_process_coef_fw(codec, coefs);
+		break;
+	case HDA_FIXUP_ACT_BUILD:
+		rename_ctl(codec, "Bass Speaker Playback Volume",
+			   "B&O-Tuned Playback Volume");
+		rename_ctl(codec, "Front Playback Switch",
+			   "B&O Soundbar Playback Switch");
+		rename_ctl(codec, "Bass Speaker Playback Switch",
+			   "Side Speaker Playback Switch");
+		break;
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -7131,6 +7185,7 @@ enum {
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
 	ALC285_FIXUP_HP_SPECTRE_X360_EB1,
+	ALC285_FIXUP_HP_ENVY_X360,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13,
@@ -9054,6 +9109,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_eb1
 	},
+	[ALC285_FIXUP_HP_ENVY_X360] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_envy_x360,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_HP_GPIO_AMP_INIT,
+	},
 	[ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_ideapad_s740_coef,
@@ -9595,6 +9656,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
@@ -10249,6 +10311,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360_EB1, .name = "alc285-hp-spectre-x360-eb1"},
+	{.id = ALC285_FIXUP_HP_ENVY_X360, .name = "alc285-hp-envy-x360"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN, .name = "alc287-yoga9-bass-spk-pin"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
-- 
2.43.0


