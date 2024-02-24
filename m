Return-Path: <linux-kernel+bounces-79732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EF18625EA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA5FB21588
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7E47A6B;
	Sat, 24 Feb 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=willian.wang header.i=@willian.wang header.b="QKwpnXoV"
Received: from mail-200166.simplelogin.co (mail-200166.simplelogin.co [176.119.200.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92C45028
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790683; cv=pass; b=sKCUcrWj0Yp3D3nrhgBhIq+mhQavGaCMMQjRprhA78dXcjHir3hc4NpS3g07ebODwMXwX9+mHhYfw55rcyelz06Hu6rT0Uv6/RZOmIWbRKVn+jqdsAN6oBnyZooeXCXvdlTiZjSifB35+1d9V61T1BaeOifWD2tx97bM3wOocCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790683; c=relaxed/simple;
	bh=h0hPeZexorvRjBOVCo9UBs0NdH+7IqeMM4uqu0E9a0k=;
	h=Subject:Date:MIME-Version:From:To:Cc:Message-ID; b=o2UMM4tcjFzPGC4xPU/MOnEd7irLG90fh1KoArEHhWE+B/pviP8W9A613wJPxqnw7i92sUsx16YV85nHBqQ/zLZGYW2GJkM9PfIdXML7LBL3k434cFajGg/Pd0UfVrjtl1prslzlrjbx/ibR+5fPYYxrgGJun0M6EJV/OsPBlGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willian.wang; spf=pass smtp.mailfrom=willian.wang; dkim=pass (1024-bit key) header.d=willian.wang header.i=@willian.wang header.b=QKwpnXoV; arc=pass smtp.client-ip=176.119.200.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willian.wang
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willian.wang
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1708790673;
	cv=none; b=J4ATsWzi0KVHJAXpXLQ/7cMhSdoiPVUCnw+CXI3/sVDoxMWHBL8TKq6djzhOROoBhcoRaWZLZhPesyF7VO9JsBXklf42hdF57mBNisaLl5Ly5Z5+/SLEvTxKPvxWbk3NAUEYd9g8Lvqem9xNXQ5VQU9nQHPATiidXno5y2d1NAik8x6ai8VVu2oAWMK4K1OAdYYfDIer+oKOhgw22gwjuiuc9MBcY0BU9FfnxDsDXqSIHMYeEwAEsDUr+7FCpOVJ+dGT++lAsaOY02rUhQRcTOwR+Adj6JltHz/M6n7SVMyHXDT4OzvoHKFW+u5jznkzsmgh2FOeQfILUxO67nipiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1708790673; c=relaxed/simple;
	bh=h0hPeZexorvRjBOVCo9UBs0NdH+7IqeMM4uqu0E9a0k=;
	h=Subject:Date:From:To:Cc; b=rTB3RGWsfCJN2pBfuNrH+9OMZpzcTroz2FSsdZkpWMzYz0rcuPUMIABXZ+JD+zFM8BMG+Rudt2ri8bMjjsUO4bVGY7Avsts6nhpIrm9Mxa4SoJS8rAVaHy/CgLea3O2iKADS6UFdMJALyjhHPZkjWMfgWWYjS9Oi6ZdPadipcwCNJPoP9QLaVt+TbTsqX47UksKv2qH0qFVbgf+/gYuY9stHJ0O7iRvM4v0YOmrvdik20msE13u/XkIPyn2mwtyGhnNga9Ez3mVSzQy8rBPx027hl4Eywu8Rvk5PSvyW3ehsjo+24f8o/HJRRoWvenBt33KymcE6155oll84t/wMNg==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willian.wang;
	s=dkim; t=1708790673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vxEt94OslLQARm0iOm4GJ/410eyItb+v7kq9UDLi6CA=;
	b=QKwpnXoV2G26NxNtNKR8fujQOwR5HNDzWQF2P3DipZ9D+Qj3Iq5+dAyO+zNJMHh5DZ/TFm
	Q+gyZ1VI1BQPDRhryTVG+67mA4fuqnIohQLH2YyKO/AkWWLDZoU8JeROiCyLTH0FtjcLTH
	rUFRkg5fTXMO6Le9vwlD5B8HFRcQvKo=
Subject: [PATCH v2] ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8
Date: Sat, 24 Feb 2024 13:04:25 -0300
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
Message-ID: <170879067313.7.13109583407458288321.273807771@willian.wang>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 273807773
X-SimpleLogin-Want-Signing: yes

Lenovo Slim/Yoga Pro 9 14IRP8 requires a special fixup because there is
a collision of its PCI SSID (17aa:3802) with Lenovo Yoga DuetITL 2021
codec SSID.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555
Link: https://lore.kernel.org/all/d5b42e483566a3815d229270abd668131a0d9f3a.camel@irl.hu
Signed-off-by: Willian Wang <git@willian.wang>
---
 sound/pci/hda/patch_realtek.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec1312bffd5..3f2541b61e8c 100644
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
+ * so we need to apply different fixup on this case. The only DuetITL codec
+ * SSID reported so far is the 17aa:3802, while the 14IRP8 has the 17aa:38be
+ * and 17aa:38bf. If it weren't for the PCI SSID, the 14IRP8 models would
+ * have matched correctly.
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



