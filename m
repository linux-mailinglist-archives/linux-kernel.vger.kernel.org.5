Return-Path: <linux-kernel+bounces-94944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06170874702
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562ACB21DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672C5171A4;
	Thu,  7 Mar 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RZcwJTdm"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7E14F7F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783884; cv=none; b=mMbDdoqTFknnlQ/p6PsGsUAw5e4j92xMuEZK0wsB2YklWpYlebuW2AoyRed1a76BEYKstXP76Kp+qL4vcHZSteS70rIlrN1CYS7q4gFaP3WE+LxomBi5ZybsnisU62nYx+RA7HN0XEbnU/F8ZV1v3rcCvuGBSwHbvPWalwmXhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783884; c=relaxed/simple;
	bh=60LNj6IGYfVZoj/gyXjOZf0QfdP/hyNETqINZbDOM9c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r/Etr5PVA1c1HQC4ujaigjsx+SW3IISbzYE7sFc3hB1NP2Xqkjw4dvxeeh2C4wCgw35bQibnUEKfT+1BSjNnWWc0SW/5fWDeQPTS5FhkT4Hj79C+IGudThLNSoftS1KOgEFT0inmRF9Vrn0csc+JSkm3TK91LazY1bUeKKfxqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RZcwJTdm; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4273ufAm048912;
	Wed, 6 Mar 2024 21:56:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709783801;
	bh=ehmInrd2KsR/7lA/FjYVpc2p7JwpKwG8Gj2BdP6Ou14=;
	h=From:To:CC:Subject:Date;
	b=RZcwJTdmuWFbWgS33QGjugd4CfHqcHBBYu5wWUoFcmqXBIHl8VK/bq3aOhAODYsfQ
	 dvYSeMswMwyncV9yusf3IM/nQleVlKbvU/iAwV9ETPkZn7Lfuk3k6NO5hnpuq/W9J4
	 WYRehLwnlhYxdTh7dfR1rY0841y9UUskNybWnFfs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4273ufki092782
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Mar 2024 21:56:41 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 21:56:41 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 6 Mar 2024 21:56:40 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "bard.liao@intel.com" <bard.liao@intel.com>,
        "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "Xu,
 Baojun" <baojun.xu@ti.com>, "Lu, Kevin" <kevin-lu@ti.com>,
        "tiwai@suse.de"
	<tiwai@suse.de>, "soyer@irl.hu" <soyer@irl.hu>,
        "Baojun.Xu@fpt.com"
	<Baojun.Xu@fpt.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v10] The tas2783 is a smart audio amplifier
 with integrated MIPI SoundWire interface (Version 1.2.1 compliant), I2C, and
 I2S/TDM interfaces designed for portable applications. An on-chip DSP
 supports Texas Instruments SmartAmp sp
Thread-Topic: [EXTERNAL] Re: [PATCH v10] The tas2783 is a smart audio
 amplifier with integrated MIPI SoundWire interface (Version 1.2.1 compliant),
 I2C, and I2S/TDM interfaces designed for portable applications. An on-chip
 DSP supports Texas Instruments SmartAmp sp
Thread-Index: AQHabzH/b3I/bWWVFUK0e05J8vV+lrErpzBQ
Date: Thu, 7 Mar 2024 03:56:40 +0000
Message-ID: <dff90323b41a4e3a8e0e8540fbb32154@ti.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, March 6, 2024 3:19 AM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: andriy.shevchenko@linux.intel.com; lgirdwood@gmail.com;
> perex@perex.cz; pierre-louis.bossart@linux.intel.com;
> 13916275206@139.com; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; liam.r.girdwood@intel.com; bard.liao@intel.com;
> mengdong.lin@intel.com; yung-chuan.liao@linux.intel.com; Xu, Baojun
> <baojun.xu@ti.com>; Lu, Kevin <kevin-lu@ti.com>; tiwai@suse.de;
> soyer@irl.hu; Baojun.Xu@fpt.com; Navada Kanyana, Mukund
> <navada@ti.com>
> Subject: [EXTERNAL] Re: [PATCH v10] The tas2783 is a smart audio amplifie=
r
> with integrated MIPI SoundWire interface (Version 1.2.1 compliant), I2C, =
and
> I2S/TDM interfaces designed for portable applications. An on-chip DSP
> supports Texas Instruments SmartAmp spe...
>=20
> On Tue, Mar 05, 2024 at 04:43:35PM +0800, Shenghao Ding wrote:
> > The ASoC component provides the majority of the functionality of the
> > device, all the audio functions.
>=20
> > +static const struct reg_default tas2783_reg_defaults[] =3D {
> > +	/* Default values for ROM mode. Activated. */
> > +	{ 0x8002, 0x1a },	/* AMP inactive. */
> > +	{ 0x8097, 0xc8 },
> > +	{ 0x80b5, 0x74 },
> > +	{ 0x8099, 0x20 },
> > +	{ 0xfe8d, 0x0d },
> > +	{ 0xfebe, 0x4a },
> > +	{ 0x8230, 0x00 },
> > +	{ 0x8231, 0x00 },
> > +	{ 0x8232, 0x00 },
> > +	{ 0x8233, 0x01 },
> > +	{ 0x8418, 0x00 },	/* Set volume to 0 dB. */
> > +	{ 0x8419, 0x00 },
> > +	{ 0x841a, 0x00 },
> > +	{ 0x841b, 0x00 },
> > +	{ 0x8428, 0x40 },	/* Unmute channel */
> > +	{ 0x8429, 0x00 },
> > +	{ 0x842a, 0x00 },
> > +	{ 0x842b, 0x00 },
> > +	{ 0x8548, 0x00 },	/* Set volume to 0 dB. */
> > +	{ 0x8549, 0x00 },
> > +	{ 0x854a, 0x00 },
> > +	{ 0x854b, 0x00 },
> > +	{ 0x8558, 0x40 },	/* Unmute channel */
> > +	{ 0x8559, 0x00 },
> > +	{ 0x855a, 0x00 },
> > +	{ 0x855b, 0x00 },
> > +	{ 0x800a, 0x3a },	/* Enable both channel */
>=20
> These comments sound like this register default table is not actually the
> physical default register values that the chip has...
>=20
> > +static const struct regmap_config tasdevice_regmap =3D {
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 8,
> > +	.readable_reg =3D tas2783_readable_register,
> > +	.volatile_reg =3D tas2783_volatile_register,
> > +	.max_register =3D 0x44ffffff,
> > +	.reg_defaults =3D tas2783_reg_defaults,
> > +	.num_reg_defaults =3D ARRAY_SIZE(tas2783_reg_defaults),
>=20
> ...but this is set as the register defaults.  This will cause problems wi=
th things
> like cache sync where we don't write values out if they're not the defaul=
ts.
> We also try to keep default settings from the silicon except in the most
> obvious cases, it avoids issues with trying to work out what to set and
> accomodate different use cases for different systems.
>=20
> If you do need to set non-default values then either just regular writes =
during
> probe or a regmap patch would do it.

So, can I remove=20
".reg_defaults =3D tas2783_reg_defaults," and tas2783_reg_defaults from the=
 code?

>=20
> > +	.cache_type =3D REGCACHE_RBTREE,
> > +	.use_single_read =3D true,
> > +	.use_single_write =3D true,
>=20
> REGCACHE_MAPLE is generally the most sensible choice for modern devices
> - it's a newer and fancier data structure underlying it and there's only =
a few
> cases with low end devices, mostly doing block I/O which this doesn't
> support, where the RBTREE cache is still better.

Accept

>=20
> > +	u16 dev_info;
> > +	int ret;
> > +
> > +	if (!tas_dev->sdw_peripheral) {
> > +		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
> > +			__func__);
> > +		return;
> > +	}
> > +
> > +	dev_info =3D tas_dev->sdw_peripheral->bus->link_id |
> > +		tas_dev->sdw_peripheral->id.unique_id << 16;
>=20
> I'm kind of surprised dev_info works as a variable name without something
> getting upset that it aliases the function of the same name.

Accept

