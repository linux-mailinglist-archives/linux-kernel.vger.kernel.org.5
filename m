Return-Path: <linux-kernel+bounces-115530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21958889415
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAA41F2C90E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C62429E3;
	Mon, 25 Mar 2024 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV40omRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E461ED728;
	Sun, 24 Mar 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320993; cv=none; b=e2kDPiqUEHUrdvQNmHY9Gy64QVaNhhn+i7p2UAbfrGaNPe2hww0y2q1209E0nL1uxiP2MrVRGGPjTx9bM6uIDDTO4RupdvWDYAUuO3Njaov/hmOitGDdLTbjrIsn2dMRP+UC7OhBZCxaRFmupBFSAUs+1kcceTOS38epkf7xLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320993; c=relaxed/simple;
	bh=CzuQnAE+kjH3T/uAch/fuVdQVF0vpHp6kXOpSJSIq2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR46b1WGKNww85P7+5c2ck5W5wnKujD/1dvl50BnETytC2IYSMchnYSb+DXX+s/nQEIttwM8BB0so4k3b65VMHh9vaoNpxIwXmEe95K5AzS6X3DZbkvpYSC93OQ4uM3vznw+CdXmYsrMyegoUarpnoPlNGfsFFNlVlS+uG4jQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV40omRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC9FC43399;
	Sun, 24 Mar 2024 22:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320993;
	bh=CzuQnAE+kjH3T/uAch/fuVdQVF0vpHp6kXOpSJSIq2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cV40omRVPuVlZAsbK0Ko8d3cESa/jK46mWv19cWIBX0Ed4tRPzDEEQop9kyJcFsle
	 IfkKC3EWf0UG0Ye/XP2fq/TiRaheFcknEIqzigtspwwW1kquY1qWzrICWYl3usrtW8
	 aIDUjgC0Rn1AWrZLaZG5NP4EKUgxh7Irr8EOs3E1ev8L2W7kvtFnlXjqw6XmX4nPz0
	 jvdcwysKLm8oHVVYUf0ggaSx1DPP+IrddRIGNWpLPwkMfh+uOVhmRqI+s1rvrtPq12
	 2Hfc7P6a1KQ8NIltt5E38XecfBFTokP+a9MHvFDn8MSITE838v9Box1SxWQsIRukIa
	 m6TQAlgQC/HJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 555/713] ALSA: hda/realtek: fix ALC285 issues on HP Envy x360 laptops
Date: Sun, 24 Mar 2024 18:44:41 -0400
Message-ID: <20240324224720.1345309-556-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index baf550b5a7c49..0c746613c5ae0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6696,6 +6696,60 @@ static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
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
 
@@ -7291,6 +7345,7 @@ enum {
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
 	ALC285_FIXUP_HP_SPECTRE_X360_EB1,
+	ALC285_FIXUP_HP_ENVY_X360,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13,
@@ -9266,6 +9321,12 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -9848,6 +9909,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
@@ -10541,6 +10603,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360_EB1, .name = "alc285-hp-spectre-x360-eb1"},
+	{.id = ALC285_FIXUP_HP_ENVY_X360, .name = "alc285-hp-envy-x360"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN, .name = "alc287-yoga9-bass-spk-pin"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
-- 
2.43.0


