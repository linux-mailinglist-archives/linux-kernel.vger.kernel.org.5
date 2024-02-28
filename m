Return-Path: <linux-kernel+bounces-84499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C16886A788
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B607AB24951
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804BE208C5;
	Wed, 28 Feb 2024 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hKlLDuX6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA26200B7;
	Wed, 28 Feb 2024 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094083; cv=none; b=AtCllGPWwbwY2JOLM3TNWkUPfD0M7LjjPUFGGbQe9Cn+peuGM8V+vujWZRz1wCMZrSoTmUm50m+DNUmi54I9C2Uvfa4UTcgqHFeiwd6LtBA6USIVuwRg3ddMzNU+0lkp1/yiYXlqLy36jwRIgWvvuvCBykIOfr6SZpxMF3vjZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094083; c=relaxed/simple;
	bh=GOCUVgAMDlle60BoR7sNQosdbFDfBSfBPT0RnoIs77M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=engEjqGUSX5PF0ZpSyo3oQmyGMdFmcD+9VDWRzDPd1EY0d9ka2Ja/OwWLGwxXKAQBIQz8aiDN2fWjXLqbbZ/lw1jLS2NWPxXbSco+FrThydVEtGvb/KflxfDTYsYA+8Dsc1YiX/gk/uI+EZswwjaabzjTVF/GB0+48eWjw9YPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hKlLDuX6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41S4KGtC029588;
	Tue, 27 Feb 2024 22:20:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709094017;
	bh=CFxBGIuGEGLV5Sv2+ezuvF/B5vZFGbm0mj7FaZp5VSs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=hKlLDuX68iuI0TfP7Pgnj52FuB2HR6e7H9YyBSKEV0fMGrEl4Bmapy5dugnHI5V6h
	 GZSmbgCQ+YtfkP/XOiUcnh1BXwf4mbkb1yubssbimNHJgQIxjes4Fr9c3BG53Ljs98
	 XWGCA+1bXrmn9+fIq6ZnfM9L2ru9TFmE5N4lzkGw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41S4KGST017439
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 22:20:16 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 22:20:16 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Tue, 27 Feb 2024 22:20:16 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "Chawla, Mohit" <mohit.chawla@ti.com>, "soyer@irl.hu"
	<soyer@irl.hu>,
        "Huang, Jonathan" <jkhuang3@ti.com>, "tiwai@suse.de"
	<tiwai@suse.de>,
        "Djuandi, Peter" <pdjuandi@ti.com>,
        "Agrawal, Manisha"
	<manisha.agrawal@ti.com>,
        "Hari, Raj" <s-hari@ti.com>, "Yashar, Avi"
	<aviel@ti.com>,
        "Nagalla, Hari" <hnagalla@ti.com>,
        "Bajjuri, Praneeth"
	<praneeth@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v6 1/4] ASoc: PCM6240: Create PCM6240
 Family driver code
Thread-Topic: [EXTERNAL] Re: [PATCH v6 1/4] ASoc: PCM6240: Create PCM6240
 Family driver code
Thread-Index: AQHaZlUvaWdne5oqDU27e+oocVjRwrEewCOAgABmq6A=
Date: Wed, 28 Feb 2024 04:20:16 +0000
Message-ID: <3e0ebab7835040ff81775f43b71d3b99@ti.com>
References: <20240223123809.503-1-shenghao-ding@ti.com>
 <0cba2632-5d79-488a-9eec-dbed4208971b@sirena.org.uk>
In-Reply-To: <0cba2632-5d79-488a-9eec-dbed4208971b@sirena.org.uk>
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
> Sent: Tuesday, February 27, 2024 11:46 PM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: linux-kernel@vger.kernel.org; lgirdwood@gmail.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; linux-sound@vger.kernel.org;
> devicetree@vger.kernel.org; perex@perex.cz; tiwai@suse.com;
> 13916275206@139.com; Chawla, Mohit <mohit.chawla@ti.com>;
> soyer@irl.hu; Huang, Jonathan <jkhuang3@ti.com>; tiwai@suse.de; Djuandi,
> Peter <pdjuandi@ti.com>; Agrawal, Manisha <manisha.agrawal@ti.com>;
> Hari, Raj <s-hari@ti.com>; Yashar, Avi <aviel@ti.com>; Nagalla, Hari
> <hnagalla@ti.com>; Bajjuri, Praneeth <praneeth@ti.com>
> Subject: [EXTERNAL] Re: [PATCH v6 1/4] ASoc: PCM6240: Create PCM6240
> Family driver code
>=20
> On Fri, Feb 23, 2024 at 08:38:04PM +0800, Shenghao Ding wrote:
>=20
> > +static const char *const pcmdev_ctrl_name[] =3D {
> > +	"%s-i2c-%d-dev%d-ch%d-ana-gain",
> > +	"%s-i2c-%d-dev%d-ch%d-digi-gain",
> > +	"%s-i2c-%d-dev%d-ch%d-fine-gain",
> > +};
>=20
> So, I see why you're doing this naming thing for the per-device controls
> - the device can (and is designed to) allow controlling multiple amps wit=
h a
> single I2C write.  However this is resulting in something that's really a=
wkward
> from an ALSA point of view, the names that are being generated are very
> much not idiomatic for control names and probably aren't going to be
> terribly meaningful for end users since they're not associated with where=
 the
> relevant outputs physically are.  We could require machines to provide
> names for everything but that's probably going to be a miserable experien=
ce
> on x86 and is unhelpful even with DT so having a default seems to make
> sense.
>=20
> I think these should look more like ALSA names, so "I2C %d Device %d..."
> though that does make things a bit longer.
Hi Mark
For only single one device, all these seems redundant and makes uncomfortab=
le
Many of my customers will have such cases as
Four pieces of Pcm6240s and three pieces of pcm6360s in the same i2c bus.
The chip name can help them identify the chip and set the right chip and th=
e right channel.
>=20
> > +static const char *const pcmdev_ctrl_name_with_prefix[] =3D {
> > +	"%s-dev%d-ch%d-ana-gain",
> > +	"%s-dev%d-ch%d-digi-gain",
> > +	"%s-dev%d-ch%d-fine-gain",
> > +};
>=20
> For these I'm not clear why we don't just use the name, what's the goal i=
n
> having the device number in there?
>=20
> I think it would make sense to do a version the driver with no user visib=
le
> controls (or at least none that need this name generation stuff) and then
> make the controls an incremental patch, the driver would obviously need
> both bits to be properly useful but it'd mean that the simple bit could g=
et
> reviewed and possibly merged separately to the complicated bit which woul=
d
> probably be easier.

You means to remove the kcontrols first. After the patch was accepted, add =
these
Kcontrols, right?
>=20
> Please also send the output of mixer-test from a machine with this driver=
 in it
> as part of the cover letter, it'll make it easier to tell what's going on=
.
>=20
> > +	if (comp->name_prefix) {
> > +	/* There's name_prefix defined in DTS. Bin file name will be
> > +	 * name_prefix.bin stores the firmware including register setting and
> > +	 * params for different filters inside chips, it must be copied into
>=20
> The comment should be indented like it's inside the if ().
>=20
> > +	} else {
> > +	/* There's NO name_prefix defined in DTS. Bin file name will be
> > +	 * device-name[defined in pcmdevice_i2c_id]-i2c-bus_id[0,1,...,N]-
> > +	 * sum[1,...,4]dev.bin stores the firmware including register setting
> > +	 * and params for different filters inside chips, it must be copied
> > +	 * into firmware folder. The same types of pcmdevices sitting on the
> > +	 * same i2c bus will be aggregated as one single codec, all of them
> > +	 * share the same bin file.
> > +	 */
> > +		scnprintf(pcm_dev->bin_name,
> PCMDEVICE_BIN_FILENAME_LEN,
> > +			"%s-i2c-%d-%udev.bin", pcm_dev->dev_name, adap-
> >nr,
> > +			pcm_dev->ndev);
> > +	}
>=20
> You could also do this as a fallback (ie, try the specified name first th=
en fall
> bakc to the bus based numbering), that way if a name is added later it wo=
n't
> break people's installs on upgrade.
>=20
> > +static const struct regmap_config pcmdevice_i2c_regmap =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.cache_type =3D REGCACHE_MAPLE,
> > +	.ranges =3D pcmdevice_ranges,
> > +	.num_ranges =3D ARRAY_SIZE(pcmdevice_ranges),
> > +	.max_register =3D 256 * 128,
> > +};
>=20
> Shouldn't there be some volatile registers if we have interrupts?

