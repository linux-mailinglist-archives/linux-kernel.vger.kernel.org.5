Return-Path: <linux-kernel+bounces-42174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15083FD6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77690B24047
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548743C49D;
	Mon, 29 Jan 2024 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SJCfLiTs"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B844205B;
	Mon, 29 Jan 2024 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504703; cv=none; b=k0SuJhxtL1DLzjR5FrAZ6uH0knVg7pOIfyOAYFxtZ8wmnmr3r+ipd8vqphS7DOHuKosj+NpZs5JFh4ZYLNQVZn0L+xXY4fiJ94o9snzVZXNdf7HyyHoHGqDpb7re0BtMF+K6550UqaPQPx0fiwhX0aIuejKh21W5VJBQYOVbq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504703; c=relaxed/simple;
	bh=gdcFV7cCGcJoPRZxnKmdremOTbOEcHlPX45FVYJgp9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sdbE13vg+K+oolyoroccOeTOrpK3voLK2TkxCousn/bJDuOcVX3bUpF4dgiHfqommVPpy7JVPDm22c41Bzv46nhJzm32ouxq1p/Us4AYfFb9QZVtj4Ls6rMJh7VDFO/mIgcjCqP5PLDtDJBOBxyYwefyJncJjBPELw+Q6W70iII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SJCfLiTs; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40T53nWv049220;
	Sun, 28 Jan 2024 23:03:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706504629;
	bh=5idWkJXaLnMUDvKQz5gujybZwzqE7FxYrR/YhL0M8zs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=SJCfLiTsfNYe9XApgy1gesFiolhCWDlovM2IkTleQi4FspMohACW9laoevYyZ2xjS
	 wPZqCs07ysb7u+YevPrYvD9rKFzLd4LLYzUjBPmPBkwq4yumbrKIKx5FENetwGJGQK
	 BFL9FHuMjs5Sam/bO4/wy1cHYkrHA1BzKodLIkBw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40T53nlE040132
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 28 Jan 2024 23:03:49 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 28
 Jan 2024 23:03:48 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Sun, 28 Jan 2024 23:03:48 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "Lu,
 Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "P O, Vijeth"
	<v-po@ti.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "Chawla, Mohit" <mohit.chawla@ti.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "soyer@irl.hu"
	<soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
        "tiwai@suse.de"
	<tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
        "McPherson, Jeff"
	<j-mcpherson@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/4] ASoc: PCM6240: Create PCM6240
 Family driver code
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/4] ASoc: PCM6240: Create PCM6240
 Family driver code
Thread-Index: AQHaUAwDhKXb/0jDP0G32CaDTkwY+7Dsja0AgAOvM+A=
Date: Mon, 29 Jan 2024 05:03:48 +0000
Message-ID: <39804840911a44c8b9da9478f7b4c05d@ti.com>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
 <6c1d04be-c558-4aa4-96a3-ac21ae36bfae@sirena.org.uk>
In-Reply-To: <6c1d04be-c558-4aa4-96a3-ac21ae36bfae@sirena.org.uk>
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
> Sent: Friday, January 26, 2024 10:33 PM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: conor+dt@kernel.org; krzysztof.kozlowski@linaro.org;
> robh+dt@kernel.org; andriy.shevchenko@linux.intel.com; Lu, Kevin <kevin-
> lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>; devicetree@vger.kernel.org; P
> O, Vijeth <v-po@ti.com>; lgirdwood@gmail.com; perex@perex.cz; pierre-
> louis.bossart@linux.intel.com; 13916275206@139.com; Chawla, Mohit
> <mohit.chawla@ti.com>; linux-sound@vger.kernel.org; linux-
> kernel@vger.kernel.org; liam.r.girdwood@intel.com; soyer@irl.hu; Huang,
> Jonathan <jkhuang3@ti.com>; tiwai@suse.de; Djuandi, Peter
> <pdjuandi@ti.com>; McPherson, Jeff <j-mcpherson@ti.com>; Navada
> Kanyana, Mukund <navada@ti.com>
> Subject: [EXTERNAL] Re: [PATCH v2 1/4] ASoc: PCM6240: Create PCM6240
> Family driver code
>=20
> On Fri, Jan 26, 2024 at 11:58:51AM +0800, Shenghao Ding wrote:
>=20
> This looks mostly good - I've got a few comments that are mainly stylisti=
c or
> otherwise very minor, there's one issue with validation of profile IDs th=
at
> does look like it's important to fix though.
.............................
>=20
> > +	val =3D (val >> shift) & mask;
> > +	val =3D (val > max) ? max : val;
> > +	val =3D mc->invert ? max - val : val;
> > +	ucontrol->value.integer.value[0] =3D val;
>=20
> There's the FIELD_GET() macro (and FIELD_SET() for writing values) - the =
core
> predates them and hence doesn't use them, we might want to update some
> time.
Hi, Mark. FIELD_GET seemed not suitable in this, because mask in not the co=
nst.=20
it will cause compile error.
>=20
> > +static int pcmdevice_codec_probe(struct snd_soc_component *codec) {
>=20
> > +	ret =3D request_firmware_nowait(THIS_MODULE,
> FW_ACTION_UEVENT,
> > +		pcm_dev->regbin_name, pcm_dev->dev, GFP_KERNEL,
> pcm_dev,
> > +		pcmdev_regbin_ready);
> > +	if (ret) {
> > +		dev_err(pcm_dev->dev, "load %s error =3D %d\n",
> > +			pcm_dev->regbin_name, ret);
> > +		goto out;
> > +	}
>=20
> It might be better to request the firmware in the I2C probe rather than i=
n the
> ASoC level probe, that way there's more time for the firmware to be loade=
d
> before we actually need it.  That does mean you can't register the contro=
ls
> immediately though so it may be more trouble than it's worth.

I once put request_firmware_nowait in i2c_probe, but it sometimes returned=
=20
error in some platforms. So my customer suggest that it would be moved into=
=20
the codec_probe. It seemed filesystem is not completely ready in some=20
platform during calling the i2c_probe.
>=20
> Similarly for the reset, if we reset as early as possible that seems bett=
er.

As to reset, it is also from my customers' suggestion. they found the issue=
 that=20
i2c access error in i2c_probe in some platform. So they put it into codec_p=
robe.


