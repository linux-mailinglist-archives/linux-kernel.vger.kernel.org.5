Return-Path: <linux-kernel+bounces-31097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CD8328D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65B6286AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09C4CB2D;
	Fri, 19 Jan 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o6tF/fIY"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FF4CB21;
	Fri, 19 Jan 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663954; cv=none; b=REZYCrleSqbVojHZordLeyGwVzGGCTGY9OUyIeuhHdPgdr9l7vNv2bKKK2LG5G4znb8knN6N1Jk4uq+VKLIJpgI5rZMD5Jlo3rf9fh4lOwLf7CPYV3dfRI4aYWiM4sqpBa4dNmzuXL9J2rV7ITCBXQon+j8lOxTYwYVccAwYsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663954; c=relaxed/simple;
	bh=94cJkGpzXv6vX96hN3F/qDrT623BbZXlhB7kP/KCPU0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM1f0Tx7EhqtPd0B5eu+C9aVIO8WGRaG69dv5USyG5Y/n4SQ2H3pn/LMy1pseRvSvuQQWo1uIPT6VnTtt4V/BG2zFzRIe9b7hz4GgxfQm8CCFznf62/LKp3xY0pQy7bnUGedX5fkWbTZvxy7fnZ1MZRMjdNWxa226hsxevOkGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o6tF/fIY; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J6NCSU030958;
	Fri, 19 Jan 2024 05:32:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=25MQFMZS3s1zoH4
	I19/D63xOUNBz77KwvoFalDdc0a0=; b=o6tF/fIYvb7vFMsjrKz3mp2tpRdMal4
	oo8qWqjcKtso9AGdx+aXToJbbVKtp3hkAN/lo4rIkqU++7yhk6oZYeoW9A25wRXD
	040XZ/Mw7KZTkUoyIdr/zO/vQo/E8IGTXgEIc5Kw3CQu52d29xA8+i72RZy7Ps5u
	1EU3af4/QMa99F1kQ8xDHZgmjuVlrD0Y9U/U1Qbv4laMAXU4wNQmi1Si4vSG3384
	JeJSAuyPhKi1FvUVQ73kTD7URZpXA/sI63ec8ICj9LGeBlxfQEUppsHmZOjgrjkX
	KDH8EcqxrE2zHMhOjqdKSdJGIsUbV2jq4xGjS/vQ/83ZOxU+GYv1FeA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vkrt1gkqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 05:32:05 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 11:32:03 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 19 Jan 2024 11:32:03 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3734211CA;
	Fri, 19 Jan 2024 11:32:03 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:32:03 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/6] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <20240119113203.GA16899@ediswmail.ad.cirrus.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-4-ckeepax@opensource.cirrus.com>
 <ZalU8r1OvqKOLHrf@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZalU8r1OvqKOLHrf@surfacebook.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: flSMt1ucqoIAeIcEfECS-rqrffURSsu7
X-Proofpoint-ORIG-GUID: flSMt1ucqoIAeIcEfECS-rqrffURSsu7
X-Proofpoint-Spam-Reason: safe

On Thu, Jan 18, 2024 at 06:42:26PM +0200, andy.shevchenko@gmail.com wrote:
> Fri, Aug 04, 2023 at 11:45:59AM +0100, Charles Keepax kirjoitti:
> > The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> > (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> > for portable applications. It provides a high dynamic range, stereo
> > DAC for headphone output, two integrated Class D amplifiers for
> > loudspeakers, and two ADCs for wired headset microphone input or
> > stereo line input. PDM inputs are provided for digital microphones.
> > 
> > The MFD component registers and initialises the device and provides
> > PM/system power management.
> 

Full disclosure probably not going to fix everything here, few
almost entirely stylistic things and the patch was like merged 4
month ago. But happy to spin through and do a few fix ups.

> ...
> 
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> 
> It seems errno is not used (as Linux kernel error codes, otherwise err.h
> already includes necessary header).
> 
> Also seems array_size.h, mod_devicetable.h are missing (at least).
> 
> ...

Thanks for spotting these will spin through and tidy the headers
up.

> 
> > +#if IS_ENABLED(CONFIG_OF)
> 
> We are trying hard to get rid of this ugly ifdefferies (ACPI as well) along
> with respective macros that are often the PITA for CIs.
> 

Fair enough, but what is the expected alternative here? Is it now
preferred to just always include both in the driver? That does
come at a small cost in driver size, but it doesn't really bother
me.

> > +static const struct of_device_id cs42l43_of_match[] = {
> > +	{ .compatible = "cirrus,cs42l43", },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, cs42l43_of_match);
> > +#endif
> > +
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +static const struct acpi_device_id cs42l43_acpi_match[] = {
> > +	{ "CSC4243", 0 },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, cs42l43_acpi_match);
> > +#endif
> > +

..

> > +	cs42l43->regmap = devm_regmap_init_sdw(sdw, &cs42l43_sdw_regmap);
> > +	if (IS_ERR(cs42l43->regmap)) {
> > +		ret = PTR_ERR(cs42l43->regmap);
> > +		dev_err(cs42l43->dev, "Failed to allocate regmap: %d\n", ret);
> > +		return ret;
> > +	}
> 
> Can be simplified as
> 
> 	cs42l43->regmap = devm_regmap_init_sdw(sdw, &cs42l43_sdw_regmap);
> 	if (IS_ERR(cs42l43->regmap))
> 		dev_err_probe(cs42l43->dev, PTR_ERR(cs42l43->regmap),
> 			      "Failed to allocate regmap: %d\n", ret);
> 

Oops, yeah looks like I missed the ones in sdw and i2c, will fix
those up.

> > +#define CS42L43_RESET_DELAY			20
> > +
> > +#define CS42L43_SDW_ATTACH_TIMEOUT		500
> > +#define CS42L43_SDW_DETACH_TIMEOUT		100
> > +
> > +#define CS42L43_MCU_POLL			5000
> > +#define CS42L43_MCU_CMD_TIMEOUT			20000
> 
> > +#define CS42L43_MCU_UPDATE_TIMEOUT		500000
> 
> > +#define CS42L43_VDDP_DELAY			50
> > +#define CS42L43_VDDD_DELAY			1000
> > +
> > +#define CS42L43_AUTOSUSPEND_TIME		250
> 
> Usually we use units for the macro names as suffixes...
> E.g., _US (for microseconds).
> 

Can add those, does make it clearer.
> ...
> 
> > +struct cs42l43_patch_header {
> > +	__le16 version;
> > +	__le16 size;
> > +	u8 reserved;
> > +	u8 secure;
> 
> Seems to me that __u8 is appropriate as patch is external to the kernel and
> it's kinda firmware interface.
> 

Sure.

> > +	irq_flags = irqd_get_trigger_type(irq_data);
> > +	switch (irq_flags) {
> > +	case IRQF_TRIGGER_LOW:
> > +	case IRQF_TRIGGER_HIGH:
> > +	case IRQF_TRIGGER_RISING:
> > +	case IRQF_TRIGGER_FALLING:
> > +		break;
> > +	case IRQ_TYPE_NONE:
> 
> Are you sure it's a right place to interpret no type flags as a default?
> 

I mean... no... but I might need more to go on. The chip
generates an active low IRQ by default so it seems reasonable if
nothing is specified to assume the chip is doing what it normally
would.

> > +	default:
> > +		irq_flags = IRQF_TRIGGER_LOW;
> > +		break;
> > +	}

..

> > +EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> > +	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> > +};
> 
> Why do you need SET_*() versions of those macros? They are not supposed to be
> used with the new macros such as EXPORT_NS_GPL_DEV_PM_OPS().
> 

Yeah fixed that up already in an earlier fixup patch.

Thanks,
Charles

