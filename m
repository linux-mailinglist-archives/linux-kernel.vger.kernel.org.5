Return-Path: <linux-kernel+bounces-14149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F31982186A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1F11F21F98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269D4C94;
	Tue,  2 Jan 2024 08:34:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m127207.xmail.ntesmail.com (mail-m127207.xmail.ntesmail.com [115.236.127.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499D5382;
	Tue,  2 Jan 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by mail-m12756.qiye.163.com (Hmail) with ESMTPA id 5D363DC083C;
	Tue,  2 Jan 2024 14:05:08 +0800 (CST)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH] ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
Date: Tue,  2 Jan 2024 14:04:57 +0800
Message-Id: <20240102060457.4917-1-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkJCVkMYH0pCHR4ZSEwYSFUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8cc8c69c0cb223kuuu5d363dc083c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6Tio*SzwyEUk6DUw3K0Ma
	TUoKCzFVSlVKTEtPSkxOTktCSU1PVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBTk9CTjcG

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
 sound/pci/hda/patch_conexant.c | 72 +++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a889cccdd607..e24befa1fad9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -166,6 +166,7 @@ static void cxt_init_gpio_led(struct hda_codec *codec)
 
 static int cx_auto_init(struct hda_codec *codec)
 {
+	unsigned int mic_persent;
 	struct conexant_spec *spec = codec->spec;
 	snd_hda_gen_init(codec);
 	if (!spec->dynamic_eapd)
@@ -174,6 +175,22 @@ static int cx_auto_init(struct hda_codec *codec)
 	cxt_init_gpio_led(codec);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
 
+	switch (codec->core.vendor_id) {
+	case 0x14f11f86:
+	case 0x14f11f87:
+		/* fix some headset type recognize fail issue, such as EDIFIER headset */
+		snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
+		snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
+		snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
+		/* fix reboot headset type recognize fail issue */
+		mic_persent = snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
+		if (mic_persent&0x80000000)
+			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
+		else
+			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x20);
+		break;
+	}
+
 	return 0;
 }
 
@@ -192,6 +209,58 @@ static void cx_auto_free(struct hda_codec *codec)
 	snd_hda_gen_free(codec);
 }
 
+static int headset_present_flag;
+static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	unsigned int val, phone_present, mic_persent, phone_tag, mic_tag;
+	unsigned int count = 0;
+
+	switch (codec->core.vendor_id) {
+	case 0x14f11f86:
+	case 0x14f11f87:
+		/* check hp&mic tag to process headset pulgin&plugout */
+		phone_tag = snd_hda_codec_read(codec, 0x16, 0, 0xf08, 0x0);
+		mic_tag = snd_hda_codec_read(codec, 0x19, 0, 0xf08, 0x0);
+		if ((phone_tag&(res>>26)) || (mic_tag&(res>>26))) {
+			phone_present = snd_hda_codec_read(codec, 0x16, 0, 0xf09, 0x0);
+			if (!(phone_present&0x80000000)) {/* headphone plugout */
+				headset_present_flag = 0;
+				snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x20);
+				break;
+			}
+			if (headset_present_flag == 0) {
+				headset_present_flag = 1;
+			} else if (headset_present_flag == 1) {
+				mic_persent = snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
+				/* headset is present */
+				if ((phone_present&0x80000000) && (mic_persent&0x80000000)) {
+					/* wait headset detect done */
+					do {
+						msleep(20);
+						val = snd_hda_codec_read(codec, 0x1c,
+									0, 0xca0, 0x0);
+						count += 1;
+					} while ((count > 3) || (val&0x080));
+					val = snd_hda_codec_read(codec, 0x1c, 0, 0xcb0, 0x0);
+					if (val&0x800) {
+						codec_dbg(codec, "headset plugin, type is CTIA\n");
+						snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
+					} else if (val&0x400) {
+						codec_dbg(codec, "headset plugin, type is OMTP\n");
+						snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
+					} else {
+						codec_dbg(codec, "headphone plugin\n");
+					}
+					headset_present_flag = 2;
+				}
+			}
+		}
+		break;
+	}
+
+	snd_hda_jack_unsol_event(codec, res);
+}
+
 #ifdef CONFIG_PM
 static int cx_auto_suspend(struct hda_codec *codec)
 {
@@ -205,7 +274,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = snd_hda_jack_unsol_event,
+	.unsol_event = cx_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
@@ -1042,6 +1111,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	codec->spec = spec;
 	codec->patch_ops = cx_auto_patch_ops;
 
+	headset_present_flag = 0;
 	cx_auto_parse_eapd(codec);
 	spec->gen.own_eapd_ctl = 1;
 
-- 
2.34.1


