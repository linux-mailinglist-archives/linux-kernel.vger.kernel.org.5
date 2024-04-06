Return-Path: <linux-kernel+bounces-133840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508289A999
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F84B21F51
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063422618;
	Sat,  6 Apr 2024 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vKjWQ0fM"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DD17758
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712389497; cv=none; b=NP3/OUsmqLUwYtwT2tofEq5gNq3TBbmE93IU856bcWNygYQLTduSuhLnCEUbKhWnmE3qKrlUC9UOHEPU65FBjHdI2s5UHfasiVPcBsQ20OsU4jQaCl1xx4aylCOg/KT7zWJp/UaQ1B7L7LCmdQSPo+14AnBUHkJPEYE8xY222+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712389497; c=relaxed/simple;
	bh=ag0L5s0NvNNpnK9VStcd/WfRuosPWnEvzhoE5NBpXEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=deCjrJmczYzQGRY5m90CPVwn3jXnXoL+bUCs0HHB9+qr3TIL7HK4jkBVz3o1qXitKkbrVZwi6oW5GBKzCId1xpHfSuyLk0GQMhUCew4P7VfNGMZqbsxtBPvfSUw5iD4eGnujSli7Y5z15lcTmDC/BnsWj4MF2m6YByHx2+0Zrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vKjWQ0fM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4367hjiX079199;
	Sat, 6 Apr 2024 02:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712389425;
	bh=JdMAmQ5cW5OCZ7m3+RZ4yQphAbO2Q/ZVztgpt0OA790=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=vKjWQ0fMJrsxak/iIrCmuuTc9Npo/S6tpRN2i51yTY+4gRLgadt8H3EZWW7s7fbvS
	 yv5aiR3LTlpq0ZNpyEdZaEYXHFmETAjuXIgBOHb8NX62A9npFyrD243aGg2FxF++iu
	 KWf4dSxJUrLygPEgw8LmKCbZwaavZcw1oFdNux3Y=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4367hj5t041997
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 6 Apr 2024 02:43:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 6
 Apr 2024 02:43:44 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.023; Sat, 6 Apr 2024 02:43:44 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>, "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "soyer@irl.hu" <soyer@irl.hu>, "Ding, Shenghao" <shenghao-ding@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1 6/8] ALSA: hda/tas2781: Add tas2781
 SPI-based driver
Thread-Topic: [EXTERNAL] Re: [PATCH v1 6/8] ALSA: hda/tas2781: Add tas2781
 SPI-based driver
Thread-Index: AQHafxpNE61C8ldTPEOmQsI0OzAt0LFKc6YAgBB5YUk=
Date: Sat, 6 Apr 2024 07:43:44 +0000
Message-ID: <54579b5779bd4493bd4d9cb8d582896c@ti.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-6-baojun.xu@ti.com>,<b4c5fb89-a43c-4c40-b729-a49a537f6179@linux.intel.com>
In-Reply-To: <b4c5fb89-a43c-4c40-b729-a49a537f6179@linux.intel.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Sent: 26 March 2024 23:05
> To: Xu, Baojun; tiwai@suse.de
> Cc: robh+dt@kernel.org; andriy.shevchenko@linux.intel.com; lgirdwood@gmai=
l.com; perex@perex.cz; Lu, Kevin; 13916275206@139.com; alsa-devel@alsa-proj=
ect.org; linux-kernel@vger.kernel.org; liam.r.girdwood@intel.com; yung-chua=
n.liao@linux.intel.com; broonie@kernel.org; soyer@irl.hu
> Subject: [EXTERNAL] Re: [PATCH v1 6/8] ALSA: hda/tas2781: Add tas2781 SPI=
-based driver
>=20
> > +enum device_catlog_id {
>=20
> catalog?
>=20
> > +     HP =3D 0,
> > +     OTHERS
> > +};
>=20
> Is there not a better way to identify solutions?
> You have ACPI IDs, no?

It support HP platform now only, will add other later.

Best Regards
Jim



