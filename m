Return-Path: <linux-kernel+bounces-33395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1794783692E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA6A28A5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF904BAB7;
	Mon, 22 Jan 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEkQxgR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A114BAAF;
	Mon, 22 Jan 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936130; cv=none; b=JOf0KM6NGmyLJ6/Rvi9JplYEyLQ/DNz3AYksUnns86dxEwaxo6afJ3X8MqkHt3/l1GEM6z8+gAZA19YeXHpQkmFDA2h13bHvJ3Y6AQZ0LahCTM8vzovy032UQLjofVRS22EcgGrFinhLNDdp09hOlj96SBHiK9V6tHPGSrLs2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936130; c=relaxed/simple;
	bh=v5lblB5HIWBpKL1xZFHrgqsw1lO2Xc8IWd4GEe+xRJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoUbt4t+Q69A9vi5KNFE6b5UX41KsAM3fuUnKUEcCYnzqlnj4hj4bD77PlmfzoH3Ceeo7cGfwYEH2bObMSL2ie7DR7A7AyQfKLcBFH7q6lF/MFjZW9t6O1x+C0/odEVc896sjScqejeKM7VjpOZXOqGYm3HvQJIdDbTM527ba2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEkQxgR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C72C43394;
	Mon, 22 Jan 2024 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936129;
	bh=v5lblB5HIWBpKL1xZFHrgqsw1lO2Xc8IWd4GEe+xRJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEkQxgR2DHcwiSBAFnseUTh/2UDSuHfogYR8+ZpdLip2GQz0ZNvdyG6fcBn18Fk6i
	 VzgL+UWiw321s4PYiG6wOPn22faRADa9kb8ucR8tJyHJNnfoL7pBnb230PmFxlHzwV
	 jYix0FOStp0unIDz+PuuGoYp+FvjQ4kcSA6wwawyUx8M0VMTRFSzBNSgmaL5mAI1gK
	 yKoGkXXI5xsWx5llr1ZPvElbgVidVLHlsZ/Mva7ESN9JyGlgF8Gs6J6/bXif+rxLg0
	 C+Y2Ap+zOSMIzMV99KF1c8ea6i6ku8CKFXmK0oHS/fkRMR5rCiXZP77DCUMD3UF8xu
	 EsxUrUBFwc2nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: bo liu <bo.liu@senarytech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 70/73] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
Date: Mon, 22 Jan 2024 10:02:24 -0500
Message-ID: <20240122150432.992458-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: bo liu <bo.liu@senarytech.com>

[ Upstream commit 7aeb259086487417f0fecf66e325bee133e8813a ]

When OMTP headset plugin the headset jack of CX8070 and SN6160 sound cards,
the headset type detection circuit will recognize the headset type as CTIA.
At this point, plugout and plugin the headset will get the correct headset
type as OMTP.
The reason for the failure of headset type recognition is that the sound
card creation will enable the VREF voltage of the headset mic, which
interferes with the headset type automatic detection circuit. Plugout and
plugin the headset will restart the headset detection and get the correct
headset type.
The patch is disable the VREF voltage when the headset is not present, and
will enable the VREF voltage when the headset is present.

Signed-off-by: bo liu <bo.liu@senarytech.com>
Link: https://lore.kernel.org/r/20240108110235.3867-1-bo.liu@senarytech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 115 ++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a889cccdd607..e8819e8a9876 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -21,6 +21,12 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
+enum {
+	CX_HEADSET_NOPRESENT = 0,
+	CX_HEADSET_PARTPRESENT,
+	CX_HEADSET_ALLPRESENT,
+};
+
 struct conexant_spec {
 	struct hda_gen_spec gen;
 
@@ -42,7 +48,8 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
-
+	unsigned int headset_present_flag;
+	bool is_cx8070_sn6140;
 };
 
 
@@ -164,6 +171,27 @@ static void cxt_init_gpio_led(struct hda_codec *codec)
 	}
 }
 
+static void cx_fixup_headset_recog(struct hda_codec *codec)
+{
+	unsigned int mic_persent;
+
+	/* fix some headset type recognize fail issue, such as EDIFIER headset */
+	/* set micbiasd output current comparator threshold from 66% to 55%. */
+	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
+	/* set OFF voltage for DFET from -1.2V to -0.8V, set headset micbias registor
+	 * value adjustment trim from 2.2K ohms to 2.0K ohms.
+	 */
+	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
+	/* fix reboot headset type recognize fail issue */
+	mic_persent = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+	if (mic_persent & AC_PINSENSE_PRESENCE)
+		/* enable headset mic VREF */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	else
+		/* disable headset mic VREF */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+}
+
 static int cx_auto_init(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
@@ -174,6 +202,9 @@ static int cx_auto_init(struct hda_codec *codec)
 	cxt_init_gpio_led(codec);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 
+	if (spec->is_cx8070_sn6140)
+		cx_fixup_headset_recog(codec);
+
 	return 0;
 }
 
@@ -192,6 +223,77 @@ static void cx_auto_free(struct hda_codec *codec)
 	snd_hda_gen_free(codec);
 }
 
+static void cx_process_headset_plugin(struct hda_codec *codec)
+{
+	unsigned int val;
+	unsigned int count = 0;
+
+	/* Wait headset detect done. */
+	do {
+		val = snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);
+		if (val & 0x080) {
+			codec_dbg(codec, "headset type detect done!\n");
+			break;
+		}
+		msleep(20);
+		count++;
+	} while (count < 3);
+	val = snd_hda_codec_read(codec, 0x1c, 0, 0xcb0, 0x0);
+	if (val & 0x800) {
+		codec_dbg(codec, "headset plugin, type is CTIA\n");
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	} else if (val & 0x400) {
+		codec_dbg(codec, "headset plugin, type is OMTP\n");
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	} else {
+		codec_dbg(codec, "headphone plugin\n");
+	}
+}
+
+static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
+{
+	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
+	struct conexant_spec *spec = codec->spec;
+
+	/* In cx8070 and sn6140, the node 16 can only be config to headphone or disabled,
+	 * the node 19 can only be config to microphone or disabled.
+	 * Check hp&mic tag to process headset pulgin&plugout.
+	 */
+	phone_tag = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
+	mic_tag = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
+	if ((phone_tag & (res >> AC_UNSOL_RES_TAG_SHIFT)) ||
+	    (mic_tag & (res >> AC_UNSOL_RES_TAG_SHIFT))) {
+		phone_present = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+		if (!(phone_present & AC_PINSENSE_PRESENCE)) {/* headphone plugout */
+			spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+			snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+			return;
+		}
+		if (spec->headset_present_flag == CX_HEADSET_NOPRESENT) {
+			spec->headset_present_flag = CX_HEADSET_PARTPRESENT;
+		} else if (spec->headset_present_flag == CX_HEADSET_PARTPRESENT) {
+			mic_persent = snd_hda_codec_read(codec, 0x19, 0,
+							 AC_VERB_GET_PIN_SENSE, 0x0);
+			/* headset is present */
+			if ((phone_present & AC_PINSENSE_PRESENCE) &&
+			    (mic_persent & AC_PINSENSE_PRESENCE)) {
+				cx_process_headset_plugin(codec);
+				spec->headset_present_flag = CX_HEADSET_ALLPRESENT;
+			}
+		}
+	}
+}
+
+static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	if (spec->is_cx8070_sn6140)
+		cx_update_headset_mic_vref(codec, res);
+
+	snd_hda_jack_unsol_event(codec, res);
+}
+
 #ifdef CONFIG_PM
 static int cx_auto_suspend(struct hda_codec *codec)
 {
@@ -205,7 +307,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = snd_hda_jack_unsol_event,
+	.unsol_event = cx_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
@@ -1042,6 +1144,15 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	codec->spec = spec;
 	codec->patch_ops = cx_auto_patch_ops;
 
+	/* init cx8070/sn6140 flag and reset headset_present_flag */
+	switch (codec->core.vendor_id) {
+	case 0x14f11f86:
+	case 0x14f11f87:
+		spec->is_cx8070_sn6140 = true;
+		spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+		break;
+	}
+
 	cx_auto_parse_eapd(codec);
 	spec->gen.own_eapd_ctl = 1;
 
-- 
2.43.0


