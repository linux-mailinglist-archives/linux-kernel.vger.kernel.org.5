Return-Path: <linux-kernel+bounces-55351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52E84BB94
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293831C23C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB3611B;
	Tue,  6 Feb 2024 17:06:13 +0000 (UTC)
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D796D51D;
	Tue,  6 Feb 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239172; cv=none; b=jAMM8IeakMVRUSo35WbIXmfcoFgYbf7W1P4PsYW/HzhA6SPGuFSy9H7HM+2AMr+cjYNTuwKulMRtPgVPlt5Lrx1knGU92q4XpzUPQnG8ACYisEkaZcgjbERbisGz6oGUE4wJXY6B0vWP8LtOhhUCBXCkeoKYb5I9+yI7Ozn3TEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239172; c=relaxed/simple;
	bh=/SJzBE/l9/HRQYdjO25GdAcjKLkwXspjpaOOc+6xQJ0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=bAK1JITfSoK0vLj1LMzaB4MI/EiISIekz2f3QIwlfZa4pv3kuklGd9lhYgwfH1ycpB7pdDR8niYCY1FdEUOOTjABbLcMoxWEVovQDwRN04OZwxvf0BG2iRqdi6cs0un0DbhAHtniB4hxLJeWAOXChBVOw1tHkomkBH0YobWWEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id ACA7C4D153;
	Tue,  6 Feb 2024 18:06:01 +0100 (CET)
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp4-g21.free.fr (Postfix) with ESMTP id E894E19F738;
	Tue,  6 Feb 2024 18:05:53 +0100 (CET)
Date: Tue, 6 Feb 2024 18:05:53 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>, 
	Stefan Binding <sbinding@opensource.cirrus.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com
Message-ID: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr>
Subject: Re: [PATCH v2] ALSA: hda/realtek: cs35l41: Fix internal speaker
 support for ASUS UM3402 with missing DSD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_1337 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_1337)
Thread-Index: QSromOq1WhBGWcizfa0FVmBVLqOw2Q==
Thread-Topic: ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD

Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
Add _DSD values for "ASUS UM3402" to cs35l41_config_table[].
Reorder alc269_fixup_tbl[] by device id and remove duplicate QUIRK
entry for device {0x1043, 0x1f62, "ASUS UX7602ZM"}.

Signed-off-by: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 7 +++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_h=
da_property.c
index 923c0813fa08..d8cd62ef6afc 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -102,6 +102,7 @@ static const struct cs35l41_config cs35l41_config_table=
[] =3D {
 =09{ "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 1000, 4500, 24 },
 =09{ "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2,=
 0, 0, 0, 0 },
 =09{ "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2,=
 0, 0, 0, 0 },
+=09{ "10431E12", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 0, 0, 0 },
 =09{ "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1=
, -1, 0, 0, 0 },
 =09{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1,=
 -1, 1000, 4500, 24 },
 =09{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1=
, 0, 0, 0, 0 },
@@ -485,6 +486,7 @@ static const struct cs35l41_prop_model cs35l41_prop_mod=
el_table[] =3D {
 =09{ "CSC3551", "10431D1F", generic_dsd_config },
 =09{ "CSC3551", "10431DA2", generic_dsd_config },
 =09{ "CSC3551", "10431E02", generic_dsd_config },
+=09{ "CSC3551", "10431E12", generic_dsd_config },
 =09{ "CSC3551", "10431EE2", generic_dsd_config },
 =09{ "CSC3551", "10431F12", generic_dsd_config },
 =09{ "CSC3551", "10431F1F", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7aa88ed04bde..16cb19eee589 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9893,6 +9893,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 =09SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SP=
K),
 =09SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZI/ZJ/ZQ/ZU/ZV", ALC285_FIXUP_=
ASUS_HEADSET_MIC),
 =09SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2=
C_2),
+=09SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 =09SND_PCI_QUIRK(0x1043, 0x16d3, "ASUS UX5304VA", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
@@ -9936,14 +9937,12 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
 =09SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 =09SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_=
SPI_2),
 =09SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI=
_2),
-=09SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI=
_2),
-=09SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA=
502),
-=09SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_=
I2C_2),
+=09SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2=
),
 =09SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU=
502_PINS),
 =09SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_=
G513_PINS),
 =09SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA=
401),
-=09SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2=
),
+=09SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_=
I2C_2),
 =09SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_AS=
US_GA401),
 =09SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA=
401),
 =09SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", ALC287_FIXUP_CS35L41_I2C_2=
),
--=20
2.40.1

