Return-Path: <linux-kernel+bounces-144871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D148A4C07
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB0C1C21D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB547A7F;
	Mon, 15 Apr 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gyjukiG6"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4043383AB;
	Mon, 15 Apr 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174949; cv=none; b=NVHp5LnH+4uvdOoVlJlyv51yZQ3qBM+jsuYTtIGRtqFEQumllY/xFfpp2blqcoi8u+zGUF5mAwKPxK48q1ym9c8AGjq7ftfko/0+xvZGszm55XQ5V4p94rrOGOlz+UNNlesjVbAN7RHSe6H/V1udyAAaVHDympMbDbNwoNYjpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174949; c=relaxed/simple;
	bh=wgnWob0U0it2pt49v4HUo2NpgVz49OnBg25dDc4SfVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDRPZoF1anvNwvrYba+CBrL39vu/pKR2XmFn5lvj/LXJjOO4fnswtpPweJHo9w6g0Z2a/Qjj4rCicnSuC8qmcS0MDXBSfxJn5gHbOfUCwBgr90c9+tTGoMsSqgZpM/yA+583QSrTyryK7zgXQow4HyyJ0fP4WAlG35lQfC3DXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gyjukiG6; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43F5v4hC010751;
	Mon, 15 Apr 2024 04:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=dD2f35q/bj7/4mecENnnmx6W7Luy5F3/B8pXNDHxuXc=; b=
	gyjukiG65Lp60cgWIK1Pv1R16O+wj4+jepOwsjp5chQr8QisKAAUbH1RdULUIA/I
	GM1q9WIzPgICAWNMjyRafpHIRl2yyo6QStZl/EqmD+rsaLXOeU9SCBBTR2rUddJw
	/q95XJUvpxAhx40ACMSSajaZv0IuPLnzQoEVAuw7QcAGltjQV6wwY/EFo/WI5jgX
	Pdd7zpO2koPB1xfR/X10hE/oUgV7txmdOEP+y5mKfFd7XSZOXVaIBhqRsEOW+/ZA
	6bWYxleR9xBk0JNrDsRAzLMEZfWboQG9CJa3XqZCFbDnuiOy6T1OD5wHcV86I6KT
	ZjNUOF2h26SWTp1h3byFaQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhsc61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 04:55:36 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 10:55:34 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 15 Apr 2024 10:55:34 +0100
Received: from [198.61.64.201] (LONN2DGDQ73.ad.cirrus.com [198.61.64.201])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2E119820244;
	Mon, 15 Apr 2024 09:55:34 +0000 (UTC)
Message-ID: <335eb6d4-424e-43e5-8990-3d87ad579e7c@opensource.cirrus.com>
Date: Mon, 15 Apr 2024 10:55:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/realtek: Fix internal speakers for Legion
 Y9000X 2022 IAH7
To: ArcticLampyrid <ArcticLampyrid@outlook.com>, <james.schulman@cirrus.com>,
        <david.rhodes@cirrus.com>, <rf@opensource.cirrus.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-GB
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gCCHhkjIpZ91svqh6lWf59MI3n11FZnv
X-Proofpoint-GUID: gCCHhkjIpZ91svqh6lWf59MI3n11FZnv
X-Proofpoint-Spam-Reason: safe

Hi,

On 13/04/2024 14:07, ArcticLampyrid wrote:
> This fixes the sound not working from internal speakers on
> Lenovo Legion Y9000X 2022 IAH7 models.
>
> Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
> Cc: <stable@vger.kernel.org>
> ---
>   sound/pci/hda/cs35l41_hda_property.c | 17 +++++++++++++++++
>   sound/pci/hda/patch_realtek.c        |  1 +
>   2 files changed, 18 insertions(+)
>
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index 8fb688e41..244e41d51 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -109,6 +109,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>   	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
>   	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
>   	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },

According to the ACPI that I have access to, this is not correct - the 
Speaker ID is on index 2 not index 1.
Index 1 has a reference to the interrupt line. Therefore this should be:

	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },

>   	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
>   	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
>   	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
> @@ -414,6 +415,21 @@ static int lenovo_legion_no_acpi(struct cs35l41_hda *cs35l41, struct device *phy
>   	return 0;
>   }
>   
> +/*
> + * Some devices just have a single interrupt line for multiple amps, for which we
> + * should just register the interrupt for the first amp. Otherwise, we would meet EBUSY
> + * when registering the interrupt for the second amp.
> + */
> +static int single_interrupt_dsd_config(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
> +			       const char *hid)
> +{
> +	generic_dsd_config(cs35l41, physdev, id, hid);
> +	if (id != 0x40) {
> +		cs35l41->hw_cfg.gpio2.func = CS35L41_NOT_USED;
> +	}
> +	return 0;
> +}
> +

According to the schematics I have access to, both amps have a reset 
line. The reason for any issue you see may be
because you have assigned the speaker id for the interrupt gpio in ACPI 
as mentioned above.

Thanks,

Stefan

>   struct cs35l41_prop_model {
>   	const char *hid;
>   	const char *ssid;
> @@ -500,6 +516,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>   	{ "CSC3551", "10431F1F", generic_dsd_config },
>   	{ "CSC3551", "10431F62", generic_dsd_config },
>   	{ "CSC3551", "10433A60", generic_dsd_config },
> +	{ "CSC3551", "17AA386E", single_interrupt_dsd_config },
>   	{ "CSC3551", "17AA386F", generic_dsd_config },
>   	{ "CSC3551", "17AA3877", generic_dsd_config },
>   	{ "CSC3551", "17AA3878", generic_dsd_config },
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index cdcb28aa9..ac729187f 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10382,6 +10382,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
>   	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
>   	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
> +	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7", ALC287_FIXUP_CS35L41_I2C_2),
>   	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
>   	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
>   	SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),

