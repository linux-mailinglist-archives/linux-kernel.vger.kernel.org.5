Return-Path: <linux-kernel+bounces-82629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D286876C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7E61F24F54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48461B962;
	Tue, 27 Feb 2024 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DD8kG0bt"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CEA199B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002390; cv=none; b=WiXyIECzx2nRKkCNYnPS/qZFeE2AIT7gVVkj1026wG/9RnKpGEQzQsVFnEzPDDo477aesRydNp62lNG9bAUbvILzG0KM6Op72xiP2DAixPzVL267lm4Fo26cvJ8HfEwazcv22pNzaDo+r7BXi/QVj9PZDJrvRD2Sx3gz69jjZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002390; c=relaxed/simple;
	bh=hbUZKLUjm+PEoUk6BKzGqAXQH0+r6FQQGT75e88gpNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ek27VTXQe9Hm68h+CIB0rWqcBuvMw5aJ/tnGs4p3XulUxyxH0Nj6naa27ovki8szBdKs6cbfjcqUGJSxso0LeAVxhfRMtL1+7MKk2bCEfS4wzd9f57iUH4ZalqEBT3fPCr+1ORqfmuGTkK0SSbDmdRR8IoWjhFe4GxPLkt9UhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DD8kG0bt; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41R2q2QM023240;
	Mon, 26 Feb 2024 20:52:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709002322;
	bh=gJR9T0Vhs1h4uIV0Y++2+wjoNT7eKO2elGBMd/wxGpU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=DD8kG0btcG1L1hYr72PTbYEAVhJR61Mcrl69yPUS1FxiD76U7UGaN9Bv61/osaNdT
	 ms8hsT6pxY4a8Tv9b6LZwJX+opC00/Y+w8b0mar/mPeQoXHZz2TxSJ6ooA8ZO4KVSL
	 QvTFtwVg5KYvymq4hclI1UBqTWkjGRvnuDqmHiuA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41R2q2rB114775
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Feb 2024 20:52:02 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 20:52:01 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Mon, 26 Feb 2024 20:52:01 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "13916275206@139.com" <13916275206@139.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "bard.liao@intel.com" <bard.liao@intel.com>,
        "mengdong.lin@intel.com"
	<mengdong.lin@intel.com>,
        "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>,
        "Xu, Baojun" <baojun.xu@ti.com>, "Lu,
 Kevin" <kevin-lu@ti.com>,
        "tiwai@suse.de" <tiwai@suse.de>, "soyer@irl.hu"
	<soyer@irl.hu>,
        "Navada Kanyana, Mukund" <navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v9] ASoc: tas2783: Add tas2783 codec driver
Thread-Topic: [EXTERNAL] Re: [PATCH v9] ASoc: tas2783: Add tas2783 codec
 driver
Thread-Index: AQHaZWJdzl/3F/uZLk2mYU9psTSIi7EXdCuAgABAqsCAAN4VgIAE745Q
Date: Tue, 27 Feb 2024 02:52:00 +0000
Message-ID: <748cc67e04204e3d95de7891cc13ff4d@ti.com>
References: <20240222074000.659-1-shenghao-ding@ti.com>
 <10f53a13-a0ff-40f9-b089-f5baacdb76b6@linux.intel.com>
 <5c7127256bf54fcd921fc1ec83f3e527@ti.com>
 <ZdjTyccCDoD9QYpi@finisterre.sirena.org.uk>
In-Reply-To: <ZdjTyccCDoD9QYpi@finisterre.sirena.org.uk>
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
> Sent: Saturday, February 24, 2024 1:20 AM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>;
> andriy.shevchenko@linux.intel.com; lgirdwood@gmail.com; perex@perex.cz;
> 13916275206@139.com; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; liam.r.girdwood@intel.com; bard.liao@intel.com;
> mengdong.lin@intel.com; yung-chuan.liao@linux.intel.com; Xu, Baojun
> <baojun.xu@ti.com>; Lu, Kevin <kevin-lu@ti.com>; tiwai@suse.de;
> soyer@irl.hu
> Subject: Re: [EXTERNAL] Re: [PATCH v9] ASoc: tas2783: Add tas2783 codec
> driver
>=20
> On Fri, Feb 23, 2024 at 10:12:49AM +0000, Ding, Shenghao wrote:
> > Hi Pierre-Louis
> >
> > > In the SoundWire spec, the unique_id is *LINK SPECIFIC*, and only
> > > used at the bus level within the context of a link to help avoid
> > > enumeration conflicts
>=20
> > > If you are using the unique_id as a SYSTEM-UNIQUE value to lookup
> > > EFI data, this is a TI-specific requirement that needs to be document=
ed.
> > > That also means you need to double-check for errors so make sure
> > > there are no board configurations where the same unique_id is used
> > > in multiple links, or by devices other than tas2783.
>=20
> > This code only covers the tas2783s sitting in the same bus link. As to
> > cases of the different SWD links, customer will be required to have
> > the secondary development on current code. I'm sure my customers have
> much knowledge to handle this.
>=20
> As Pierre says I think we really should have some sort of defensive
> programming here, even if you're going to leave multi-link systems to fut=
ure
> work people will still have older versions in distributions or whtaever. =
 While
> I'm not sure the consequences of getting things wrong are likely to be th=
at
> bad (I'm expecting bad quality audio) it's also going to be kind of hard =
to
> figure out if we just silently pick the wrong calibration, especially if =
it's
> actually a valid calibration for another device in the system.  Other ven=
dors
> (eg, Cirrus) seem to have figured out a scheme here?
Thanks for your comments, Mark & Pierre. I will discuss with my customers o=
n=20
how to find a compromise between new solution and current solution already=
=20
released to market.

