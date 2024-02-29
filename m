Return-Path: <linux-kernel+bounces-86155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD0486C08B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F4E289B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E43BBF0;
	Thu, 29 Feb 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l4N6D40y"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B13BBF4;
	Thu, 29 Feb 2024 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709186831; cv=fail; b=g68XL3NVfDfsKGkWJnfMuZ8RSvYWCHeDxukFA6QxdVNKmxtQImar0YEHpiyIhyB1AmUlPfL8UVpr7KfVcCkdXLmnD1JJpNIXnF0AMv5B/3MhN8U7qA/qCbjjUH3L93PHFxqqLknZuCKJAxtjCj6dYJurVu/4bFxutjtu7KIhlVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709186831; c=relaxed/simple;
	bh=+iiMhsfJAmXAUeuS5c9YNw/0EcMFo5CwBf+beSBUxQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OE7yHqXuaVso7ctaMgaFg5jNKLUj1+GyeAi3g+OX8iaLl9hzWd39Q7QqXqtzHD3w3yI7yKS5+sdUrYRRy+7GaKRyT6qT/C7Zt2BCD1O88QMJxlcmzMaA2Ja6u/jIzRxPP39M3wnk6IbOm+JEVMhHwkXDdr+CreGvnp/mtEQxTLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l4N6D40y; arc=fail smtp.client-ip=40.107.15.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcCnz4oKly+CvEF9P/6SwccSdH7YWxGmPvoxxJW+hi047nu64YhBCfIcSBmCeZBBwlCqQzKv8BqzEZEe/HXWFHcX1yYfHqJeAjY48QsUjjgK9rhpnK5Hy3rFTILYM+zgYMdvXQBw/u2vCGt/ffC+z2Sy9fFw3XMOajj9bMhQ96R40EqTUfSnpyT7SZTWVqCFJ32wusEiWg/d/aj7Mgn1zQDg2NGq36p4cRFAcrJrr4ldvdenIDa31IIgmDu8ZR+tNBHfUfyxHSIvwJwLBBA1TaS9Va6/A145zCGBvb8h80yGKZ1SVrC6DPlSpTeFsq1DIo6pJ/4YZEnF/UGyoONlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNFHA0RIz02aSe6eAxFM6z/lUoAxwESkh+stFat24Qw=;
 b=SuQi7aWpX+FvPMmtUGaALYM4ZX9OPGgzaUceAOvYOBoCst5puNCK9FIsq3GyFcczpSBSZR6QBcHQjNRmSmkpa94GB8u49cBDVrSoXy7KVceD6LJjDGp8rz/FMDD2zTXeMBviDerxVXb7QtTFocjXvyJF1dLKnDWW6cQLeel4pOHGDpzQV5sxCL4MbzdNH2KECqCD98cwof9Eexs438fNjD3gRjOmEpZPy/ztXpmS8lXzxoUqgEf8LBSEbLxnqZpd7U20u/2e1y6oOKfATvx/rjXr+6/uoZQsEobsw7sDgl7qpAV+3DK660tGuAuvVvFmp1rr2xGA6wIOAxJM5J+mEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNFHA0RIz02aSe6eAxFM6z/lUoAxwESkh+stFat24Qw=;
 b=l4N6D40yIPpo8akm4SWx1BueecSV91H62o+gpGuIu+tZkLTY8DWwg5Ar9w1pgp7ET1Xr7GrhZoJyGCRFx1jq8j41fcsAVqBOtapoTALZOp04ECubIrRu+9ftNkc8xydBgca3g1GWNNRpH6MkEIeO0SJS1nGwEV7/jSmMKFS9RMw=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 06:07:05 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 06:07:04 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Will Deacon <will@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v4 2/6] perf: imx_perf: refactor driver for
 imx93
Thread-Topic: [EXT] Re: [PATCH v4 2/6] perf: imx_perf: refactor driver for
 imx93
Thread-Index: AQHaVAmW7Yq7ArBlhEOdhoctfv64r7EWanQAgAF77lA=
Date: Thu, 29 Feb 2024 06:07:04 +0000
Message-ID:
 <DU2PR04MB88229A527F3A0FB0328B17758C5F2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-2-xu.yang_2@nxp.com>
 <20240222121838.GA8308@willie-the-truck>
In-Reply-To: <20240222121838.GA8308@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS8PR04MB8215:EE_
x-ms-office365-filtering-correlation-id: 83a22389-fc5e-4b33-ff9a-08dc38eca73f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JiTAnplEGKHhCxx5hSep2NKGCwiqyAzMmALS10ZRN0UpP27HbUvwqZfnhsLUF5K0wcv0k4NpHABFqwMKvQ8eh6y7vHEKHJ4pYt0tAf/v7XMBpC0nhicKwBDaDG8B94w7F2wjqPxgWCai3RyDGkkkMzKosMf1bFDTlBLbhVYbLn0zGkVb+S/N4h0ANBe/LJ5WjWVULmyOsi8fq2H2iM9283QuyntnImd76dN1QpV0uOTv+ajXFqlMp9i4AfgfmQ137fIAkxN16UP9V6+IE6EOYm5hKyKcp1a7rObPTzLEgfC4fjb255wrXSCxjYOVgxaqmaiWu3l3f1WSMJsiCFO7vomNvhSn1U48JjFow+2IqKC7b2tYW19eIXhS44qzUZkCl/p1hyZjMC2DmY3yDYpMjJ7dej6uEs5G8Yp6dZcHc5L0KeMyNkqcXYsKYpim3kvYO6HLObzH2+U84SJdJpWemLYPI7RAnWNC4f3U86c4DxlkaUMEEUiO48DdBwFXqfu6YJmbQAbFLJMLUrDmWxXvHFaRYv9SkfhTwfoPMVHolIETUV2EXu4XLAXw4rY7rSa4NlogM8zcAD1TdYcz05Q2pohfUriaGSe+8sILTSiEYJauBbRdHCHlH8LUiIikesL5RIrovT61oovGBlpZl3kuYoW2n/N1VjvBc2XLenjgOFzjcewNuKpeFJ1jfXplLGI2i4WCUguHf/D7FAp7P1YzWw2Qm+r+n+mlwrNIXj8NLUc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0Dvmny+GxKTr1wuajyi8Z91LzyR7noHaA61VX338WxZDtW0MukSOEzz77bxX?=
 =?us-ascii?Q?YpckvW3OaEsjePsW6lAexRQIaUQly9vscTJNr2Tq9RTnZ9sxIZipw8ZZPeLW?=
 =?us-ascii?Q?cnfuKquUaSk2EsowOK28kN5AjV8/Xh39+a9G+75wgXwfHAn3VviYbUlU5x2L?=
 =?us-ascii?Q?Iv81NImKFwGUWQgJYIyYsxmOCpNrg+TRvlxuqePkio7i483dFnjDQ9we4qiN?=
 =?us-ascii?Q?tT7nbtIrtmNAZHz0JAKKJa9Ppg2bzqP9hi3tsu0QfinxNsXnlrXdCkm9RzzP?=
 =?us-ascii?Q?f/XiZMtOKFo9FBwZP+aq99jnTe46/ksQG3BGUJxIaf+OuD4iOh6Tp2/UC+Hm?=
 =?us-ascii?Q?1Y11Gpobb1Tq7q3w1FbzgUtuoDItHorv8jeO4q4NjdYJy5DZ3qk1GO/Wsvw+?=
 =?us-ascii?Q?Hfidx9YZomRUnL2XZypxqh6e6sENNphFlqnZIQraNetOenEwy9zvYRsGh2i4?=
 =?us-ascii?Q?7bB4ptfPODiihofsJ5cHSEqSWgTvXh2Ux7diM0oX1FMRXXqsQDvLPrIm0gtq?=
 =?us-ascii?Q?ArUGipL0jiXV59ACh8rOwDIIE9xlKkS0GB7HmW98uf45dgW8EBHrFWZUT9JK?=
 =?us-ascii?Q?68YwomgQ/YPFi/0bivggXULipycZ3kDX5tHR6kssx72KnyqM/QnlZy5wo2aS?=
 =?us-ascii?Q?c6PMNM68w+kvG0nwQ1X9mB5KYV48xVics4Hwy3WRS1GouSECHiv+nH4N6amr?=
 =?us-ascii?Q?KLeczGcTpDeAfABW7MG7v3i+LxsUzdJGzbgiX/WNvxiRPUzu33IHkkFj4UMB?=
 =?us-ascii?Q?+A1sjpcaivRD02i8QSPLUOd6nWkG6E0ymDID5ryOq5EPd91rDBXcw70dG00t?=
 =?us-ascii?Q?3DZ/do6V25RolRaYYmDYBecQ2KaJG9I6bEk6xn+mqUnIfNSaL3MMD8N8k+/r?=
 =?us-ascii?Q?3yf7OXuaeCfJf3mmGIDqyRxDPq9pl1KpRpyg4yhA4wItoqirQW1Zy+b1MYP+?=
 =?us-ascii?Q?UO6VOriSOuADdZ8Nj1A1XVdasb0LJJHM/vv3WC8cTflCbz2CMlfm64X8vEW2?=
 =?us-ascii?Q?54JCjtnorAmmRrcPEdBoz8adgiuuEA1WmyHNlnd5mZYN9ztiHXOuelB4hSYE?=
 =?us-ascii?Q?fUQiy8qhID2S7n2R31UFxjwXwUTrLd+9/9v6iU6G4Ld5xe+8b4SfYQYR5Vkj?=
 =?us-ascii?Q?Rdyia9cVfpiSPOOBTWNOFGl6PG42oO+jEx4N4egV3CzrLi34TNNlqOcksEtO?=
 =?us-ascii?Q?5eBp+MxG01n2RUuahqAK2EW3TI3o7in4JqxwzI8i660nGli5JEig+w5ElhnL?=
 =?us-ascii?Q?rtmO/wbmF2mTYGObdrcyya/U1c9kcHjdaXko9FFLmYu8ffDiUXXEkVZ/IYp/?=
 =?us-ascii?Q?YwOppS1F1cwteTpGnmvBdW2p0eDpLAaQ/6UuX49Nb3J9Yztin817S2BhoomS?=
 =?us-ascii?Q?yDE7fs1z6/kvLjKlqs0Z6Cj8czvRBs2vYIs1g/fkUtviXcJPkM60JWGsYr6t?=
 =?us-ascii?Q?Q1Su4sq7ouknkY27Pqib32QUfltQIXaNB8BNLRzv/fFFf6ve655PdQGcTHuP?=
 =?us-ascii?Q?3CYrfbj/wdWNzTjD9OlyeQQa+WTw9l7z3NvuDcovdJ7PjLmEey5AN0L2t4v9?=
 =?us-ascii?Q?dCPDdwhyJxkKF3hAUsw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a22389-fc5e-4b33-ff9a-08dc38eca73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 06:07:04.8586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmP3UijlT0abgXC8aVvOHi0uEjAonbZX6uxLHZQWIkbgn16zk+We5diZW1SQMXweQ5YogFthvC3NMXm3VDjrWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Hi Will,

>=20
>=20
> On Wed, Jan 31, 2024 at 01:58:07PM +0800, Xu Yang wrote:
> > This driver is initinally used to support imx93 Soc and now it's time t=
o
> > add support for imx95 Soc. However, some macro definitions and events a=
re
> > different on these two Socs. For preparing imx95 supports, this will
> > refactor driver for imx93.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v4:
> >  - new patch
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 121 ++++++++++++++++++++++---------
> >  1 file changed, 87 insertions(+), 34 deletions(-)
>=20
> [...]
>=20
> > @@ -476,12 +490,12 @@ static int ddr_perf_event_add(struct perf_event *=
event, int flags)
> >       hwc->idx =3D counter;
> >       hwc->state |=3D PERF_HES_STOPPED;
> >
> > +     /* read trans, write trans, read beat */
> > +     imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> > +
> >       if (flags & PERF_EF_START)
> >               ddr_perf_event_start(event, flags);
> >
> > -     /* read trans, write trans, read beat */
> > -     ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> > -
> >       return 0;
>=20
> This change looks like more than just refactoring and should probably be =
a
> separate patch. Is it a bug fix for the existing code?

Yes, I found the order has an impact. I will create a patch for it.

>=20
> > +static int ddr_perf_add_events(struct ddr_pmu *pmu)
> > +{
> > +     int i, ret;
> > +     struct attribute **attrs =3D pmu->devtype_data->attrs;
> > +     struct device *pmu_dev =3D pmu->pmu.dev;
> > +
> > +     if (!attrs)
> > +             return 0;
> > +
> > +     for (i =3D 0; attrs[i]; i++) {
> > +             ret =3D sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i],=
 "events");
> > +             if (ret) {
> > +                     dev_warn(pmu->dev, "i.MX9 DDR Perf add events fai=
led (%d)\n", ret);
> > +                     return ret;
>=20
> Can you use the '.is_visible' callback in 'struct attribute_group' to avo=
id
> having to manipulate sysfs directly like this? For example, create separa=
te
> groups for the imx93 and imx95-specific events and only make them visible
> if we're on the appropriate hardware.

Yes, I will try your suggestion.

Thanks,
Xu Yang

