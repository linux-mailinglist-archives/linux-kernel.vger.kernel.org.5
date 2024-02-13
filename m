Return-Path: <linux-kernel+bounces-64568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D685405B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8656A1F24190
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4806633E8;
	Tue, 13 Feb 2024 23:51:13 +0000 (UTC)
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426556312D;
	Tue, 13 Feb 2024 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868273; cv=none; b=I/qiLdxlgbbUu3z+wKXREyqpkWFOk0ooUQoGPkKZRZqW+GiKtm5hq0kQNBwLMAzxR3BMBoNDUmZWNjZIijoLg87AlZsmdpayfks32R+D4mEq8B+kEI/wBwaa6+qHs1v5VQ1dPSzwMR2QgET/j7G05JC9jIRl1aNI8ZmZRHc2OuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868273; c=relaxed/simple;
	bh=cLpnxpYC4wwNyrZga77ocn0n0Iy1TqrtB5RbWeVXp4I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jXERRWL56w7RYQscXgaLnIKMg6RCYCRs2l3h8mSZCcBLHtoMIEGsP7oroWpfxouDlrBCi09+hB07Wnzsck55SRyb/7i0SfW70xiCYefD4csaDiXk15Zy+2S86koWI43SuRv8p7eGNXhm+Lu5Dg5CzZU4MssLXWHi5s8ZffTxI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7C632DF87F0;
	Wed, 14 Feb 2024 00:42:20 +0100 (CET)
Received: from zimbra-e1-03.priv.proxad.net (unknown [172.20.243.151])
	by smtp2-g21.free.fr (Postfix) with ESMTP id DAC002003CA;
	Wed, 14 Feb 2024 00:42:12 +0100 (CET)
Date: Wed, 14 Feb 2024 00:42:12 +0100 (CET)
From: =?utf-8?Q?Jean-Lo=C3=AFc?= Charroud <lagiraudiere+linux@free.fr>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
	Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound <linux-sound@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	patches <patches@opensource.cirrus.com>
Message-ID: <1656546983.650349575.1707867732866.JavaMail.zimbra@free.fr>
In-Reply-To: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
References: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
Subject: [PATCH v3 2/3] ALSA: hda/realtek: cs35l41: Fix device ID / model
 name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_1337 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_1337)
Thread-Topic: ALSA: hda/realtek: cs35l41: Fix device ID / model name
Thread-Index: b1DHXbQj7eN1w6/I0T0Clij1GRQ0gGm3MHNu

The patch 51d976079976c800ef19ed1b542602fcf63f0edb ("ALSA: hda/realtek:
Add quirks for ASUS Zenbook 2022 Models") modified the entry 1043:1e2e
from "ASUS UM3402" to "ASUS UM6702RA/RC" and added another entry for
"ASUS UM3402" with 104e:1ee2.
The first entry was correct, while the new one corresponds to model
"ASUS UM6702RA/RC"
Fix the model names for both devices.

Signed-off-by: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7aa88ed04bde..fe81a628d7c8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9939,11 +9939,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[=
] =3D {
 =09SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI=
_2),
 =09SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI=
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


