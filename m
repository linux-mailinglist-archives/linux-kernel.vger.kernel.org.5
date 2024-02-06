Return-Path: <linux-kernel+bounces-54567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F584B0D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041741C21C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083912C81F;
	Tue,  6 Feb 2024 09:14:23 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C685B687;
	Tue,  6 Feb 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210862; cv=none; b=TUzaRRJj0/lF1aSA7PsdUisXCP1PEVL1vZLZP5KiF58TvEAx01s6pvWKuNU+HWfW5g6jXZjRw75v5d/LiqceG8hNKVEjxq2Mr2ILM5lIJNZVNlkkPxGh5oHKD/7KoSFjs2iiVmDO7M5y7rqggCslKrt8RZNK9SY9ozFaCWOSmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210862; c=relaxed/simple;
	bh=bEoN3M17mEv9B3162HEP9uHxhQ9Pp2M9knWH2/SA5EY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=kwF1dzDrNwRvXfKguHF6AkKS7nhvX7p+iwKCq626HIlHQcW37FH3u5QpQdxJy1lWMsMKEUTYXobq9M+rxzNw9OUgzg4kLdQG3hZ1/fSc/Dnj5onx1kAR51DjUn4DxC04gnY56ssGs9V79Akh2VISlhb6IQSxRl12RIDPzKZIxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e34:ec1e:c710:76bc:3b92:8186:7430] (unknown [IPv6:2a01:e34:ec1e:c710:76bc:3b92:8186:7430])
	(Authenticated sender: lagiraudiere@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0F4BA2005A5;
	Tue,  6 Feb 2024 10:14:04 +0100 (CET)
Message-ID: <eac660b7-5202-4ea1-836c-8d3cdb97c5d4@free.fr>
Date: Tue, 6 Feb 2024 10:14:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Jean-Lo=C3=AFc_Charroud?= <lagiraudiere+linux@free.fr>
Subject: [PATCH] ALSA: hda/realtek: cs35l41: Fix internal speaker support for
 ASUS UM3402 with missing DSD
To: Stefan Binding <sbinding@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
Content-Language: en-US, fr-FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
Add DSD values for "ASUS UM3402" to cs35l41_config_table[].
Reorder alc269_fixup_tbl[] by device id and remove duplicate QUIRK
entry for device {0x1043, 0x1f62, "ASUS UX7602ZM"}.

Signed-off-by: Jean-Loïc Charroud <lagiraudiere+linux@free.fr>
---
  sound/pci/hda/cs35l41_hda_property.c | 2 ++
  sound/pci/hda/patch_realtek.c        | 7 +++----
  2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c 
b/sound/pci/hda/cs35l41_hda_property.c
index 923c0813fa08..d8cd62ef6afc 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -102,6 +102,7 @@ static const struct cs35l41_config 
cs35l41_config_table[] = {
      { "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 
0, 1, -1, 1000, 4500, 24 },
      { "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 
1, 2, 0, 0, 0, 0 },
      { "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 
1, 2, 0, 0, 0, 0 },
+    { "10431E12", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 
0, 1, -1, 0, 0, 0 },
      { "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 
0, -1, -1, 0, 0, 0 },
      { "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 
0, 1, -1, 1000, 4500, 24 },
      { "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 
1, -1, 0, 0, 0, 0 },
@@ -485,6 +486,7 @@ static const struct cs35l41_prop_model 
cs35l41_prop_model_table[] = {
      { "CSC3551", "10431D1F", generic_dsd_config },
      { "CSC3551", "10431DA2", generic_dsd_config },
      { "CSC3551", "10431E02", generic_dsd_config },
+    { "CSC3551", "10431E12", generic_dsd_config },
      { "CSC3551", "10431EE2", generic_dsd_config },
      { "CSC3551", "10431F12", generic_dsd_config },
      { "CSC3551", "10431F1F", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7aa88ed04bde..16cb19eee589 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9893,6 +9893,7 @@ static const struct snd_pci_quirk 
alc269_fixup_tbl[] = {
      SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", 
ALC294_FIXUP_ASUS_DUAL_SPK),
      SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZI/ZJ/ZQ/ZU/ZV", 
ALC285_FIXUP_ASUS_HEADSET_MIC),
      SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", 
ALC287_FIXUP_CS35L41_I2C_2),
+    SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", 
ALC245_FIXUP_CS35L41_SPI_2),
      SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
      SND_PCI_QUIRK(0x1043, 0x16d3, "ASUS UX5304VA", 
ALC245_FIXUP_CS35L41_SPI_2),
      SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
@@ -9936,14 +9937,12 @@ static const struct snd_pci_quirk 
alc269_fixup_tbl[] = {
      SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
      SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", 
ALC245_FIXUP_CS35L41_SPI_2),
      SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", 
ALC245_FIXUP_CS35L41_SPI_2),
-    SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", 
ALC245_FIXUP_CS35L41_SPI_2),
-    SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", 
ALC245_FIXUP_CS35L41_SPI_2),
      SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", 
ALC289_FIXUP_ASUS_GA502),
-    SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM6702RA/RC", 
ALC287_FIXUP_CS35L41_I2C_2),
+    SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", 
ALC287_FIXUP_CS35L41_I2C_2),
      SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", 
ALC294_FIXUP_ASUS_GU502_PINS),
      SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", 
ALC294_FIXUP_ASUS_G513_PINS),
      SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", 
ALC289_FIXUP_ASUS_GA401),
-    SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM3402", 
ALC287_FIXUP_CS35L41_I2C_2),
+    SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", 
ALC287_FIXUP_CS35L41_I2C_2),
      SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", 
ALC289_FIXUP_ASUS_GA401),
      SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", 
ALC289_FIXUP_ASUS_GA401),
      SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", 
ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.40.1


