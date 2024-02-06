Return-Path: <linux-kernel+bounces-55223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7584B96F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403E9B28711
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BE13D51F;
	Tue,  6 Feb 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="l402dICw"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3986132C3A;
	Tue,  6 Feb 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232462; cv=none; b=cHNd/Kr9chP1wRkg3KgQZGogyjiUW2ARj0x9mSux9yc/u5hdTQgRFwe/bBIf2htzdznVenJwXDF9LoKJ8gFApe7Yj6EQKmlnuX6Xd6KLqk/0uLR0d3VcgL0RYkvWZJ+cYOu9MMQYc27yUJvtyBwAbwRQpBIcs9v/8XSOBaHuYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232462; c=relaxed/simple;
	bh=EPeSj6f1QZiCdHf/0eB8Tu/HxRiJ7wNAmDTVeh8CVA0=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/7oH9zDA8yxvxd2LgGyypr50loVcPsRN1646opUVacplo37qfcaZvfwCyaFIwouR0B15dEY6L4DjEH8Wxq88ssxjLT08esgzQV+rQJ7bSqfNSyfbzqAf1/bOKCWFgbCvJ4336rcGH56PhnV70gRbz4hQyYwxAKuECyv0Nt7xqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=l402dICw; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416ASLPw031615;
	Tue, 6 Feb 2024 09:13:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=G7p/ujgjigJOBj0DMsg5N1d8ZSv4Oe/fO8U9pz5Hryc=; b=
	l402dICwxWEWJvKh+TQT2Ri4Ohlb44UJKh55J/LdQk3ezYfgJ3ULj1dNIN/mN/oS
	UUWvqMX7gIO6ZZtfe6Jh4tfHr9i54fIoF91pf1p2+2W116vlaYEJ6tLJoBz9G+1Y
	PCEXHwYBd+UI6mdiFegOaYJE8NDA118DBFQ2Nt+Nx4Wn7mvCv6Rv0Feb9DBVTFqG
	pL8FX+NkMRX/+EYrhxnT9NTidPmWu3fgBgvXo6yIPH2nc/ZF1UjbKWf1Hc9WHrbN
	9dIffE4bI+U7I0CiJdA3b5REyeBc4Nlz5b/JsAsknKLBXr/8uNRYbI2/ZFsjl2dz
	+rMu3pR92CwaUb2/b/1j5w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w1ks2bkee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:13:58 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 15:13:56 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 6 Feb 2024 15:13:56 +0000
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.64.158])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1A332820241;
	Tue,  6 Feb 2024 15:13:56 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: =?utf-8?Q?'Jean-Lo=C3=AFc_Charroud'?= <lagiraudiere+linux@free.fr>,
        'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai' <tiwai@suse.com>
CC: 'Richard Fitzgerald' <rf@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <eac660b7-5202-4ea1-836c-8d3cdb97c5d4@free.fr>
In-Reply-To: <eac660b7-5202-4ea1-836c-8d3cdb97c5d4@free.fr>
Subject: RE: [PATCH] ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD
Date: Tue, 6 Feb 2024 15:13:55 +0000
Message-ID: <000f01da590f$1a5af100$4f10d300$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIZBNFQCfMVKTgQiiU+9hTe2Y3XprCAFAyQ
X-Proofpoint-GUID: zlVCvnWLzN0FgqEA0_DSd6UiBxnLxOkI
X-Proofpoint-ORIG-GUID: zlVCvnWLzN0FgqEA0_DSd6UiBxnLxOkI
X-Proofpoint-Spam-Reason: safe

Hi,

Config looks ok to me.

Thanks,
Stefan

> -----Original Message-----
> From: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
> Sent: Tuesday, February 6, 2024 9:14 AM
> To: Stefan Binding <sbinding@opensource.cirrus.com>; Jaroslav Kysela
> <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>; linux-
> sound@vger.kernel.org; linux-kernel@vger.kernel.org;
> patches@opensource.cirrus.com
> Subject: [PATCH] ALSA: hda/realtek: cs35l41: Fix internal speaker =
support
> for ASUS UM3402 with missing DSD
>=20
> Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
> Add DSD values for "ASUS UM3402" to cs35l41_config_table[].
> Reorder alc269_fixup_tbl[] by device id and remove duplicate QUIRK
> entry for device {0x1043, 0x1f62, "ASUS UX7602ZM"}.
>=20
> Signed-off-by: Jean-Lo=C3=AFc Charroud <lagiraudiere+linux@free.fr>
> ---
>   sound/pci/hda/cs35l41_hda_property.c | 2 ++
>   sound/pci/hda/patch_realtek.c        | 7 +++----
>   2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/pci/hda/cs35l41_hda_property.c
> b/sound/pci/hda/cs35l41_hda_property.c
> index 923c0813fa08..d8cd62ef6afc 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -102,6 +102,7 @@ static const struct cs35l41_config
> cs35l41_config_table[] =3D {
>       { "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 =
},
> 0, 1, -1, 1000, 4500, 24 },
>       { "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 =
},
> 1, 2, 0, 0, 0, 0 },
>       { "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 =
},
> 1, 2, 0, 0, 0, 0 },
> +    { "10431E12", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> 0, 1, -1, 0, 0, 0 },
>       { "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 =
},
> 0, -1, -1, 0, 0, 0 },
>       { "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 =
},
> 0, 1, -1, 1000, 4500, 24 },
>       { "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 =
},
> 1, -1, 0, 0, 0, 0 },
> @@ -485,6 +486,7 @@ static const struct cs35l41_prop_model
> cs35l41_prop_model_table[] =3D {
>       { "CSC3551", "10431D1F", generic_dsd_config },
>       { "CSC3551", "10431DA2", generic_dsd_config },
>       { "CSC3551", "10431E02", generic_dsd_config },
> +    { "CSC3551", "10431E12", generic_dsd_config },
>       { "CSC3551", "10431EE2", generic_dsd_config },
>       { "CSC3551", "10431F12", generic_dsd_config },
>       { "CSC3551", "10431F1F", generic_dsd_config },
> diff --git a/sound/pci/hda/patch_realtek.c
> b/sound/pci/hda/patch_realtek.c
> index 7aa88ed04bde..16cb19eee589 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9893,6 +9893,7 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] =3D {
>       SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH",
> ALC294_FIXUP_ASUS_DUAL_SPK),
>       SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZI/ZJ/ZQ/ZU/ZV",
> ALC285_FIXUP_ASUS_HEADSET_MIC),
>       SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR",
> ALC287_FIXUP_CS35L41_I2C_2),
> +    SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA",
> ALC245_FIXUP_CS35L41_SPI_2),
>       SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603",
> ALC289_FIXUP_ASUS_GA401),
>       SND_PCI_QUIRK(0x1043, 0x16d3, "ASUS UX5304VA",
> ALC245_FIXUP_CS35L41_SPI_2),
>       SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50",
> ALC269_FIXUP_STEREO_DMIC),
> @@ -9936,14 +9937,12 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] =3D {
>       SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420",
> ALC256_FIXUP_ASUS_HPE),
>       SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD",
> ALC245_FIXUP_CS35L41_SPI_2),
>       SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA",
> ALC245_FIXUP_CS35L41_SPI_2),
> -    SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA",
> ALC245_FIXUP_CS35L41_SPI_2),
> -    SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM",
> ALC245_FIXUP_CS35L41_SPI_2),
>       SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15",
> ALC289_FIXUP_ASUS_GA502),
> -    SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM6702RA/RC",
> ALC287_FIXUP_CS35L41_I2C_2),
> +    SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402",
> ALC287_FIXUP_CS35L41_I2C_2),
>       SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15",
> ALC294_FIXUP_ASUS_GU502_PINS),
>       SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513",
> ALC294_FIXUP_ASUS_G513_PINS),
>       SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15",
> ALC289_FIXUP_ASUS_GA401),
> -    SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM3402",
> ALC287_FIXUP_CS35L41_I2C_2),
> +    SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC",
> ALC287_FIXUP_CS35L41_I2C_2),
>       SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022",
> ALC289_FIXUP_ASUS_GA401),
>       SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14",
> ALC289_FIXUP_ASUS_GA401),
>       SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302",
> ALC287_FIXUP_CS35L41_I2C_2),
> --
> 2.40.1



