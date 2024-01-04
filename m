Return-Path: <linux-kernel+bounces-16566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A949824055
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5378B282E54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53C210ED;
	Thu,  4 Jan 2024 11:11:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com [101.71.155.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68588210E3;
	Thu,  4 Jan 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by mail-m12756.qiye.163.com (Hmail) with ESMTPA id 95295DC0733;
	Thu,  4 Jan 2024 19:10:49 +0800 (CST)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
Date: Thu,  4 Jan 2024 19:10:44 +0800
Message-Id: <20240104111044.5880-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQklMVhpNSR1DThoYQx8dH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpMSk9OTVVKS0tVSkJLS1kG
X-HM-Tid: 0a8cd42b3162b223kuuu95295dc0733
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6Cyo*HjwdCDpIEQgDQitD
	GVYwCjdVSlVKTEtPSE1NTU5LSElOVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBTUNKSzcG

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
---
 sound/pci/hda/patch_conexant.c | 108 ++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a889cccdd607..29c62181dbc3 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -42,7 +42,8 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
-
+	unsigned int headset_present_flag;
+	bool is_cx8070_sn6140;
 };
 
 
@@ -164,6 +165,22 @@ static void cxt_init_gpio_led(struct hda_codec *codec)
 	}
 }
 
+static void cx_fixup_headset_recog(struct hda_codec *codec)
+{
+	unsigned int mic_persent;
+
+	/* fix some headset type recognize fail issue, such as EDIFIER headset */
+	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
+	snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
+	snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
+	/* fix reboot headset type recognize fail issue */
+	mic_persent = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+	if (mic_persent&0x80000000)
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	else
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+}
+
 static int cx_auto_init(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
@@ -174,6 +191,9 @@ static int cx_auto_init(struct hda_codec *codec)
 	cxt_init_gpio_led(codec);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 
+	if (spec->is_cx8070_sn6140)
+		cx_fixup_headset_recog(codec);
+
 	return 0;
 }
 
@@ -192,6 +212,81 @@ static void cx_auto_free(struct hda_codec *codec)
 	snd_hda_gen_free(codec);
 }
 
+enum {
+	CX_HEADSET_NOPRESENT = 0,
+	CX_HEADSET_PARTPRESENT,
+	CX_HEADSET_ALLPRESENT,
+};
+
+static void cx_process_headset_plugin(struct hda_codec *codec)
+{
+	unsigned int val;
+	unsigned int count = 0;
+
+	/* Wait headset detect done. */
+	do {
+		val = snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);
+		if (val&0x080) {
+			codec_dbg(codec, "headset type detect done!\n");
+			break;
+		}
+		msleep(20);
+		count++;
+	} while (count < 3);
+	val = snd_hda_codec_read(codec, 0x1c, 0, 0xcb0, 0x0);
+	if (val&0x800) {
+		codec_dbg(codec, "headset plugin, type is CTIA\n");
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24);
+	} else if (val&0x400) {
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
+	/* In cx8070 and sn6140, headset is fixed to use node 16 and node 19.
+	 * Check hp and mic tag to process headset pulgin and plugout.
+	 */
+	phone_tag = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
+	mic_tag = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
+	if ((phone_tag&(res>>AC_UNSOL_RES_TAG_SHIFT)) || (mic_tag&(res>>AC_UNSOL_RES_TAG_SHIFT))) {
+		phone_present = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+		if (!(phone_present&AC_PINSENSE_PRESENCE)) {/* headphone plugout */
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
+			if ((phone_present&AC_PINSENSE_PRESENCE) &&
+			    (mic_persent&AC_PINSENSE_PRESENCE)) {
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
@@ -205,7 +300,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = snd_hda_jack_unsol_event,
+	.unsol_event = cx_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
@@ -1042,6 +1137,15 @@ static int patch_conexant_auto(struct hda_codec *codec)
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
2.34.1


