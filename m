Return-Path: <linux-kernel+bounces-86547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507D86C6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36BBB27EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6EB60873;
	Thu, 29 Feb 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k2AxSKa0"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B964AB6;
	Thu, 29 Feb 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202429; cv=fail; b=HpF0BlAwy0ZZ9gf5X9mfNxdoCSH861WqST5gSFdsdl++b+SVVk7NKz0icUcLDbTBG11TwtmVYF559Q7gjXcAu4B5/YdoKELr/EpgMVkCe0AuVw8IZlCK+BYr7S/swzrKUQ4EjJr1FOBWyJ6BM5uJhPULwY0DntQj5KFALT0bihU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202429; c=relaxed/simple;
	bh=YTKAfTqQr4mehLGB32WNOnsj7fULVCUaqFcPdo7uP1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCU2BfMrWhcOAp7lpchfcVMgkSWNy26Cww43oqSZrjltRm2v8SCj5lUTzbBsEU7slv08LqivN9gWnUl2DB6yabSDTauyZX6aPjsS8+qGEcbh9iKuCPTbBOm7Uq31YO0nSp6myi3vwSrOe9D7XD+zR5fRhubSnC33Ya93kQbZAaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=k2AxSKa0; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYu+5HF1gUVC9L0d3roV+6JoekQXxcTpasipFYQGXfPGQht5Hw4jnPVXsU7YXcCPupa6dfHfal7E2XvFLnhnK/euLkbufpzJL7h6qv/ShZedd+5/uBhh9UJ61EHejVzGIfEymv3h8qOTl6GbDpbg7Ds6ca7J/N7A4m+E1eyPlGBYBaNOzTAJFvAjISI2niuu6JAZwxSU0Nb1oZ+ALTiyxhEn+TjqkKhVDA4V+3Dp1vCyKZrgYaKk2F4xO7bKd3J4EgeDL7sdXttJEprP9zLTFTab8cT4BdmAf+lFqt6YuArRUqkYe7TMwolYSoU4oubn++wIEZLSZNbzQAA9Bqb//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K50rJ63DeWNVIhulhbnKkIHiA0RFX4EfMikMJS8Jd4o=;
 b=e/Lb/wMeE4o12Pix/y17MrhKg2eRHliinH1yYo73+RDISV+QcZbeZedaWEwQ7DKEpdG4ctro/Py1j0rHoHeFzqR+Mm1WzgNiTET17lUHDxg4IjXHIWK02Y2BNXk/c+BQyODH2+Meg+R8S8RIC/bjHX85R/hE8JWCC6aDpNAU9WV0aw4m/mOGW7vGqAzP8MlkRtgMWduqlhl0tbB7VSAJW0IfGxAuPs1IiHeAEKJj4AyWs601E4koL7IF2sH9DuEYXZxvHGZxxe7ETAkmfZt7CFIXOVvxUBFwpVRCVjEB+U63giYgzHHa3dc7IreYtt6ed5adWpGZZGnqqyLDtfQ7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K50rJ63DeWNVIhulhbnKkIHiA0RFX4EfMikMJS8Jd4o=;
 b=k2AxSKa01+wV719Xo1QKFYA7edMm3BxXOYgYpRqalq6hkHzbhQoLxEK2kt3HDmwsh151Hi3PJSM5+mi1J3EbSkHgn+ySzcvjBu3Emxjv+y42a0/1ep+6NDvWDIiwtoa20cer4hllbKn5xIG+xxwForiHXrGhvJau8IfFcVd+Nx8=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8360.eurprd04.prod.outlook.com (2603:10a6:20b:3f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 10:27:04 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:27:03 +0000
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
Subject: RE: [EXT] Re: [PATCH v4 3/6] perf: imx_perf: add support for i.MX95
 platform
Thread-Topic: [EXT] Re: [PATCH v4 3/6] perf: imx_perf: add support for i.MX95
 platform
Thread-Index: AQHaVAmbPv/9ruMYiUqsh+Jjk7/Y+7EWa6UAgArfnqA=
Date: Thu, 29 Feb 2024 10:27:03 +0000
Message-ID:
 <DU2PR04MB882256B6BA4330F319CF61EB8C5F2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-3-xu.yang_2@nxp.com>
 <20240222122253.GB8308@willie-the-truck>
In-Reply-To: <20240222122253.GB8308@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AS8PR04MB8360:EE_
x-ms-office365-filtering-correlation-id: ffa584d5-2f73-42ad-932f-08dc3910f8fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lF9chpMVz1OFgkw4Mfhd1KMt5xXooxdaBCubjdLLsiX7WSfXiSJemZgAKy3UqCm7rJfrPFbrnwhEwgObh9RkZJ+cZuLGD0VqEmeirJHMKPvL7C9jUJopLNjxl/mWheKhzozDfR6ri3BCZdv0BbhfjZqv94kMEaT3t+eJgDo0b/EzfAOcPi4GHf5tLcRSyMiCRmoSrJ+22r5P0htTB0zPEa800D8z10bLDV3+tH/VxcrDSMuuharmcxssikLCF6ANqnFGMQJIbtkMRSDvagl3zqCCP+/gpjbY/BI4VQRDOxDyursIbd2zR/3DVhm+ENIDScT39OIbLOagaGlUnNro0XmY7LX448c5Y35PxL1Sx29Ssynl7gAjWKje0XoLI5+dHCcu1i0gKS4AZE85OWCLpOf2eHa2IUo346yJe5NtvBjorK47wwPOkuKs32QcHplg86IFRVuTYtQW3wXosbVmuzgyRe1VXPNsfBb3TjJbteQEqpsuZKW3EO4NPRJGWNl4gTasd1KD6XwV5xh+Or1Xb40B4ff6jiV2qsEKwYJzHd7j3zm4oDQoxLwVEsysg9QtDEgDSvxMPg3UYxFENIpLXYQQE+nxZEEMAbBfykVMwxPJehHSUfsggwyXhsPhQkQfD9MFm6Hy7s3ElIl0xjQD/1ha6ST6CSJBqXdI/A8sgufFpGZCN3yekPbKYdMojg6M0txpIb9zKcC4C/wAz393IF1WDlgRTCh4H2SaV/vy2sk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rAxZKl5gEIYMigAO5R8iA6oJkQYZQCQ6uRX5hOCKoNaZpxdagGlEbKWE3efx?=
 =?us-ascii?Q?CpP35a88O+gLK72DfCPGroYQyzT2NnpQOjD8hyZIwODaK9HjmB2/ui9K7XH9?=
 =?us-ascii?Q?BpC9vfoEbREprxMM5dPDCBoKVDjuttqHXXOUhUrt6gUsLmSKWipPdHP/rIKh?=
 =?us-ascii?Q?AKpQnJAi4xuFTPZ0XAwEpYbz/7mitm/NPSQs+guly9p13PMfCxBWS7M+DUh2?=
 =?us-ascii?Q?guccJqrYgvVp3HhzWlmLcLdQiXZFpyfrNcIY1TB+SVsI9EDmkc6nswo70ZOQ?=
 =?us-ascii?Q?YFg+66gqAnM0TozKAFHo+4aO8zzOTYJNj74LPaggK1XSiA+P5KgCkut9qLe8?=
 =?us-ascii?Q?HowBwwg5qNYDDyWgpLw51PuUcxX93E3+rf4R69TpwQRhf9dzlJsp2Lc0nVvM?=
 =?us-ascii?Q?G7DyWao9cXPXRBWMGDAovVWIejTD6/alx9+muC3d9/Pu5C4PuEF0mMf96FIf?=
 =?us-ascii?Q?393xsz292KD46SP11OEo6BX6vPPbadktG1JxhU3Yr+G8SZV8O2yxsqCf+EnK?=
 =?us-ascii?Q?6U3ZXzWZ1pWWQXq8p4llwKuzqUbq28rj72aWgztLo1UJ10CdEHEX0oXSKLMK?=
 =?us-ascii?Q?hsgx8W1Vq85vOf6BJKS6fKMapHMRI9OowJTmKAZ5VEuv3RL0s9i9u6D/n8ju?=
 =?us-ascii?Q?I+/gDjnXeMG1bKRsX63SunOhN7xSHKdzTz2cmHR3ieogNRQh5RHWLmAQSvt6?=
 =?us-ascii?Q?1uzSm3ALafrFgUgKB9RZSOZAyHi7KiR4POx6wf/CRDEE2BCJYz8z5nxsOPOX?=
 =?us-ascii?Q?2kars4z1p8hvoqIwe4DsBb/r2BkO0xHZripm5vkoT/JX4JRD/incwIY6SVCX?=
 =?us-ascii?Q?iYXeqGCrRpjITvRvuT2xvf+aZ8T3RuwIaq6qSkatAi0EVmcgCi+wR7b5OJ+m?=
 =?us-ascii?Q?Ltfi/6hhMz/+ro/4gmbIyLdIND9zOlUKlo0E+QMdgsM5AP9uRS2jS1qkOWNt?=
 =?us-ascii?Q?B09z4KHd6WGCjHE9TLZPWvFPRIXRKgwhZswLDKg/Mrfn2huqKzTcbX4x6vj/?=
 =?us-ascii?Q?NldXVPkU9lIcJkkyIQSaNon9aHTj3pOMombjfsV9zjv8k2UfPekXTnt40AtD?=
 =?us-ascii?Q?WbYnwGp/0dOsrxWHEZHI5IyTS70NS+qPd0+QXU4zNID7OSXH+nADEldzWRvN?=
 =?us-ascii?Q?WcTfGrm8TckycuYuTdURTxqiE0KwBg9WshpfOgY1vgXLi4D1Lq+y6FknYXDQ?=
 =?us-ascii?Q?J+utVTYUUw5380NSpFbJm71vQg8VIq9FUtC8RCEmSk0Dv5CnNFBUXvG5mM0Y?=
 =?us-ascii?Q?gf6uFFd2LWEwllFvCErX4NB7DOJVxEXPxMew/x99LwSCF3hzxpJmR8EEMb8E?=
 =?us-ascii?Q?jSG8aEuBcRujQVN2a9pE0TP+nu989vUP3eHgPeabHVg7dE+euxXUCl8evw7S?=
 =?us-ascii?Q?Q+huEQv6k5ImYAh0BnR6PMeRLlT69V4un71xO0W+eunNcoZENB/DF7ngy5lq?=
 =?us-ascii?Q?WaBe9PWVbV8U15z2LiHSKtB2RJVv+NKJqIgbxgZkgxRCQw65HJievaayx7zf?=
 =?us-ascii?Q?4sUpOhTL2ZyRHx7Wxu1kFA/FpayFdZAur+qefaPmFMsIUHUL/RLDKtSLIHyd?=
 =?us-ascii?Q?sB40W7MR2CT1SZSfotA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa584d5-2f73-42ad-932f-08dc3910f8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 10:27:03.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJ9Wxs0Jj30wpTnh1wu6VS2BSiy3CTRi8057612Y4gLnlOm4xT6QodoHJP/U7y2tiaOJc4tGN6k4A0C/ysiNIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8360

Hi Will,

>=20
> On Wed, Jan 31, 2024 at 01:58:08PM +0800, Xu Yang wrote:
> > i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> > read beat and write beat filter capabilities. This will add support for
> > i.MX95 and enhance the driver to support specific filter handling for i=
t.
> >
> > Usage:
> >
> > For read beat:
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3D=
3,axi_mask=3DID_MASK,axi_id=3DID/
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=3D=
4,axi_mask=3DID_MASK,axi_id=3DID/
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D=
5,axi_mask=3DID_MASK,axi_id=3DID/
> > eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt=
0,counter=3D5,axi_mask=3D0x00f,axi_id=3D0x00c/
> >
> > For write beat:
> > ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2=
,axi_mask=3DID_MASK,axi_id=3DID/
> > eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt=
,counter=3D2,axi_mask=3D0x00f,axi_id=3D0x00c/
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - put soc spefific axi filter events to drvdata according
> >    to franks suggestions.
> >  - adjust pmcfg axi_id and axi_mask config
> > Changes in v3:
> >  - no changes
> > Changes in v4:
> >  - only contain imx95 parts
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 86 +++++++++++++++++++++++++++++++-
> >  1 file changed, 84 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index b1a58e9e1617..85aaaef7212f 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -17,9 +17,19 @@
> >  #define MX93_PMCFG1_RD_BT_FILT_EN    BIT(29)
> >  #define MX93_PMCFG1_ID_MASK          GENMASK(17, 0)
> >
> > +#define MX95_PMCFG1_WR_BEAT_FILT_EN  BIT(31)
> > +#define MX95_PMCFG1_RD_BEAT_FILT_EN  BIT(30)
> > +
> >  #define PMCFG2                               0x04
> >  #define MX93_PMCFG2_ID                       GENMASK(17, 0)
> >
> > +#define PMCFG3                               0x08
> > +#define PMCFG4                               0x0C
> > +#define PMCFG5                               0x10
> > +#define PMCFG6                               0x14
> > +#define MX95_PMCFG_ID_MASK           GENMASK(9, 0)
> > +#define MX95_PMCFG_ID                        GENMASK(25, 16)
> > +
> >  /* Global control register affects all counters and takes priority ove=
r local control registers */
> >  #define PMGC0                0x40
> >  /* Global control register bits */
> > @@ -240,6 +250,18 @@ static struct attribute *imx93_ddr_perf_events_att=
rs[] =3D {
> >       NULL,
> >  };
> >
> > +static struct attribute *imx95_ddr_perf_events_attrs[] =3D {
> > +     /* counter2 specific events */
> > +     IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
> > +     /* counter3 specific events */
> > +     IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
> > +     /* counter4 specific events */
> > +     IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
> > +     /* counter5 specific events */
> > +     IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
> > +     NULL,
> > +};
> > +
> >  PMU_FORMAT_ATTR(event, "config:0-7");
> >  PMU_FORMAT_ATTR(counter, "config:8-15");
> >  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> > @@ -271,8 +293,14 @@ static const struct imx_ddr_devtype_data imx93_dev=
type_data =3D {
> >       .attrs =3D imx93_ddr_perf_events_attrs,
> >  };
> >
> > +static const struct imx_ddr_devtype_data imx95_devtype_data =3D {
> > +     .identifier =3D "imx95",
> > +     .attrs =3D imx95_ddr_perf_events_attrs,
> > +};
> > +
> >  static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
> >       { .compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_d=
ata },
> > +     { .compatible =3D "fsl,imx95-ddr-pmu", .data =3D &imx95_devtype_d=
ata },
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> > @@ -410,6 +438,56 @@ static void imx93_ddr_perf_monitor_config(struct d=
dr_pmu *pmu, int cfg, int cfg1
> >       writel(pmcfg2, pmu->base + PMCFG2);
> >  }
> >
> > +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg=
, int cfg1, int cfg2)
> > +{
> > +     u32 pmcfg1, pmcfg, offset =3D 0;
> > +     int event, counter;
> > +
> > +     event =3D cfg & 0x000000FF;
> > +     counter =3D (cfg & 0x0000FF00) >> 8;
> > +
> > +     pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
> > +
> > +     if (counter =3D=3D 2 && event =3D=3D 73) {
> > +             pmcfg1 |=3D MX95_PMCFG1_WR_BEAT_FILT_EN;
> > +             offset =3D PMCFG3;
> > +     } else if (counter =3D=3D 2 && event !=3D 73) {
> > +             pmcfg1 &=3D ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> > +     }
> > +
> > +     if (counter =3D=3D 3 && event =3D=3D 73) {
> > +             pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +             offset =3D PMCFG4;
> > +     } else if (counter =3D=3D 3 && event !=3D 73) {
> > +             pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +     }
> > +
> > +     if (counter =3D=3D 4 && event =3D=3D 73) {
> > +             pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +             offset =3D PMCFG5;
> > +     } else if (counter =3D=3D 4 && event !=3D 73) {
> > +             pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +     }
> > +
> > +     if (counter =3D=3D 5 && event =3D=3D 73) {
> > +             pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +             offset =3D PMCFG6;
> > +     } else if (counter =3D=3D 5 && event !=3D 73) {
> > +             pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> > +     }
>=20
> I think this would be much easier to read if you rewrote it as:
>=20
>         switch (counter) {
>         case 2:
>                 ...
>                 break;
>         case 3:
>=20
>=20
> etc.

Okay, I will improve this.

>=20
> > +     writel(pmcfg1, pmu->base + PMCFG1);
>=20
> writel_relaxed()? (since you're already using readl_relaxed()).

Okay.

>=20
> > +
> > +     if (offset) {
> > +             pmcfg =3D readl_relaxed(pmu->base + offset);
> > +             pmcfg &=3D ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> > +                        FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> > +             pmcfg |=3D (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
> > +                       FIELD_PREP(MX95_PMCFG_ID, cfg1));
> > +             writel(pmcfg, pmu->base + offset);
>=20
> Similarly.

Okay.

Thanks,
Xu Yang

