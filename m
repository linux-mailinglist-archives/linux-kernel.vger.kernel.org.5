Return-Path: <linux-kernel+bounces-96482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B52875CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8982822A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3482C1BA;
	Fri,  8 Mar 2024 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JbTslvAk"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630B23775;
	Fri,  8 Mar 2024 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868970; cv=fail; b=q7axBEM+01L8G8LKTlN43yni6T7Vw5wVVT57N0g8ZbByN0OOvmO0EJ81xz6W51rd1ilkCGYBbToIG0b6gbenJKFOLET/n56W5hp0oiYSgOUMshndfmtragdT/y1n8AFd36DyPd91PvU9T4I0KS9WZRawlEXou/0eEk+J4UPLwFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868970; c=relaxed/simple;
	bh=bIdr1k+/SyFiZyeN4eU9oMppMkHaMQOGIjfOcHxcoDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K2NMHlC+jAlddz5gcMamfnhgAzA4AaxygCDYzHaeDwtVw0ffad26eMs1xSTffL9AOHwMAZ7ZC2Nd3oY3/hOh8iivxOPMXtUXUJ6om2tDaa1pck6nlg3cctx4BUm72n/mDpNVHcq44znAA09VE7ZEZQ8GspRuQHqvj/nbulm1QTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JbTslvAk; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAK1VpC1sviRsGKvJqlpKp3PthQ6Ig5i8QUqK+7ZJOMCZRVj/x6Byu8yhg6TjVGP09I4MSHfKYRSwGuAG5wNyUqGYRhmpU/lmXhRjPO9FOKWm1DXc96IIgMGGsor18gK8c0GvJ94Em4rLeL2xba3mSlFTju1KiwDEmjJ7zjwbPajCmmD8ilJWc1yD//DfYyOwfWUDJdus4ujnpzHvueoIyXhQLejgMcCoJST7GCVgKKiPNblrOeFGVC9gLf5vfzAU37OIzC2FLXQfoONsg8hRKmCbVtrXAZCvd9ywKcbzgtcOUO+q48SGA+FctUHcSOi8e6yfVAHv4N/AsTKOFTVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hQlY70UagQHl+IBbsIAD/LrHggsfr9UnPcNrKGin8o=;
 b=jgnVHHiZgmqpVBrZ6iBmZjLq1YnSZkuXxDxFOPNOuWqt0lEohL7C9fJ/1nufud3OAlJq5B14ltnn3GCW2rcQm89SMYLGehgDS3KMTxj7MFt13YxBRO1bEgwSHxSAByKW6ojoxxp0mNou3r4OV0b+Yv3sD6LW/qsUo0oLWBu9SBrT0UIArc0zwi55PdXl4SYhcEA8qUh2bRf7qNXlceiplg6B5HFKtPZf72xxsxYLegoCLrWrs86lC8XFRLwQmOuk27zfEv/yrLZDBJWN6LqrT/eZZNJBCXpntSxJbWPT5XETMBsPdjVWV3lub5jaO2meZnvYZuHFpAXRYMRrVENm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hQlY70UagQHl+IBbsIAD/LrHggsfr9UnPcNrKGin8o=;
 b=JbTslvAkKWoXbwAMowf8jC5CKpV8emgYuJxAc7noBOCGsihi0I7Ko05/ilQtrylssYTd2FON6jjj04ZHqRe9PkLrxM7IPzfgX6osOHmcqVfJEE5fgAb7zLylk9vhrz5C+HWN8D9CduCXpOqFrTVwRNh7xuOpNpXzTeawWLOEbmY=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 03:36:05 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 03:36:05 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "will@kernel.org" <will@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"mike.leach@linaro.org" <mike.leach@linaro.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v6 2/7] perf: imx_perf: add macro definitions for parsing
 config attr
Thread-Topic: [PATCH v6 2/7] perf: imx_perf: add macro definitions for parsing
 config attr
Thread-Index: AQHacHXeU0pTCoFFP0+C3lSU2gJvhbEse/UAgAC2VxA=
Date: Fri, 8 Mar 2024 03:36:05 +0000
Message-ID:
 <DU2PR04MB882259EC13676F32F24EB58B8C272@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
 <20240307095730.3792680-2-xu.yang_2@nxp.com>
 <ZenudMDnq9bGzKbI@lizhi-Precision-Tower-5810>
In-Reply-To: <ZenudMDnq9bGzKbI@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DU2PR04MB8552:EE_
x-ms-office365-filtering-correlation-id: c6014148-4fd4-4431-c004-08dc3f20e279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oeI8/wkP6/oD81NZ8k0qCKpSKM5R3rz3NeR2K/MCs/wwCt4pUS/TS6NhzE3LudLxImPJN3qTJSocEpaHKAB6rZMfE2te7ch9a6TydqvLRioUhgHlqAgNOM2qQIwxKYVV3tdVqRCNJ6xzHYdu+Fgb8nbzlwQfkBhe04DQ97HX+b2sJv0fX9Byq5dbeTJ4IBPdPoF1UKvRFjcwQeMxGzLI3Nim1sn64oLZju3C5d/DHFNFXTHC19sAKmUoDcOaQ+jqOuIWiWfLJtkQbtS054A3edJWfareN/nSNnCo/kvSUlqVVjnnWsNI0lsu8TmansZAz3BuJl4a7yPj8X1o454a0lass5bxNDaYVgf3u2Re65k0MghVuV/vagiWIg7M1SQcWWBVpwvalUbnSBmgc5N8Xw8GVdjgPvhT+NMHZQL5LiAoGGfZkHODAqF0GHXXH1ZiCGrDIuMa91NyStFFQlY202uW0CKDC6rg/hMK73itghw+oao2mJjidpY0WK4dDmPj+/Hnt4wE1ThvbHm8wP7uhpIn0e6u2/lmdHcCaedk8o2u5w7s5/d4OpeIElmqGSCJuuB0wwP+jr0M023fpR1GuyQy2t70fnZMJXtIFMNDmIIDiSMlQ7v+2r/dz6sUcE4jL92RkAHEiUapCc+NOyvDHcidlAK/s2tn4iHkgcoJbXt5+17JXMbtw82odRZatwKSS+TerlEv0QsYo+sB4QYXWmjfiA9P5Ngcguptk2mqTQE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S4wZgdYViKJaFT+KpY+KSN/nCFqYGSbIUuE3xP5Wk0zdcK90ugoi/mXQ8Hjj?=
 =?us-ascii?Q?XU9ftjcZQWyf+RttrhaTcSVPBXUkjw1o8qHMpALAfcwarM0+FcyPsvQ6Y/rI?=
 =?us-ascii?Q?ttWUREmpdaAMc+3Qa3Q7ERuh6RwPJ31egXX8P2LKMro5g8PbMfioIaBlaQsn?=
 =?us-ascii?Q?P2Ut61q23maowTgJrvloC9zkPJzbFHWE9PpJ2fGlgKnDtkBoz/QpDZJXW+Qp?=
 =?us-ascii?Q?46neqltFXRwVdJeNSjqSHPO3vM7hzu7z621B4LVCicoYrdk+gMh1Z+1utJHn?=
 =?us-ascii?Q?zNDWDk/eXoJrktSK3KGZirCWKfUieaERDy0jB+5SkWDqkv8Qr7EtUcHtQCZN?=
 =?us-ascii?Q?CMVPDuQfas6PWFM56G0ntOa3iwKZ+U2RXF5VRbPtEdFw6KEeyef8Mz3x87OC?=
 =?us-ascii?Q?YRxIftv646vIPR+zSXbHONTdDnrRDm/Ve7WxwcLiJrnQwAyINTLTbgQR5UMz?=
 =?us-ascii?Q?o46VRT5IJwxmBHFDJa5Q8EUwK7/fLm1PJJcorcsP3hp6XHnsfvY5+kRP+2dK?=
 =?us-ascii?Q?145i0u1cujzxRKJRRe3e5LqRjFHpBUjX5bYO3b07FxfvbS7pn6P7m3637JPX?=
 =?us-ascii?Q?Ev72ApwZ7/NwpgiBuBnsog/EgXA7MyDDm6Fl8nzUjFK2c+uXXbJMKR7H36BJ?=
 =?us-ascii?Q?CuAZQ9Z/l4nLolBVih9+e3HolhjosMCCtK+EhW1rL31lrot3GyMdVTtUJA5u?=
 =?us-ascii?Q?Mii3O7U1VaVWQBo/mJDWt/5ocmettUPaja+PlvRHudp6eEBPdHnUPQ3ElJMP?=
 =?us-ascii?Q?ab9uO9Yb3wqf5VEb3LJ/4dlxLqDH5+HRrFJcs13R64gDxyYy5vwTXkPzJO8w?=
 =?us-ascii?Q?MZ76OaC+8L0+Pj0IfFpqYRl1/QhU+Po/jietyCLwPfe6BMv5bEY/BD0JmAnT?=
 =?us-ascii?Q?cMiTBPrrXalDbEsMzaUYyCoYxN5d/qJ5vTOslks8xMhcX+KxANWrHDZxkeQ9?=
 =?us-ascii?Q?5CIHDb6KsJ2FxhKfl4u/Ltdx7/LiMAU/ianagWXaW+6WiR2khWB8EKJvQc93?=
 =?us-ascii?Q?PNXzD6qyCeATAqLTcWF8G0Bq3BdFK9dGTBvbOrOOw7tAKuLIFME9ABey9vSt?=
 =?us-ascii?Q?Oi1ioYohgcwd7J6GGlDcqjcw2o7eCRGbUJd03If+lAQqk3GZrfYF95i+Zmj4?=
 =?us-ascii?Q?mFA+rY1xcio27sBU38FAXkMMJppjGNXxz515pM3TXvklH6BpvwyWQcHebT3m?=
 =?us-ascii?Q?/I2CbwQM7aOdHeKpr9uY+C6qQmxPo3uVFQrLcsM2wHz8lYkSCDA0oLFw/cJu?=
 =?us-ascii?Q?eceT+KH4QRKB6SPzLSJph0t5MQ6XCGdgRAj3BSkSajZ1Ob3LWGr37mYHmquK?=
 =?us-ascii?Q?qPZbjflLQaKeOjhWgk2UHZFqeJPyjqt5b5FF1gvWHK1Iz4ngNsDc+E025kb5?=
 =?us-ascii?Q?wvaUWtG+3khPDQJWAoapEe8MTN2BYAmHYb9TK880vNYSyfdxixAWMN5CPz2J?=
 =?us-ascii?Q?yM9j1xHQH/vQt5lbYypys02fpNVa4D9QUXHniaCuwR5aiMeMH1xibsBMT+qe?=
 =?us-ascii?Q?rdwZ60Cyly4lwk32UpdOYZwwSoHqa1VwNWs0VZLGpOiZxczSEyeiqKD5nGuO?=
 =?us-ascii?Q?rmFe84cS2XiYGuGvkaA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6014148-4fd4-4431-c004-08dc3f20e279
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 03:36:05.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cLuolk6gPVxe//6BXHBdbM6lQ3h38ZVtroim8GNrHUvuQpndz+fIhr65rYdmhWxOtLG774UhvT8sOSxGtFbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

>=20
> On Thu, Mar 07, 2024 at 05:57:25PM +0800, Xu Yang wrote:
> > The user can set event and counter in cmdline and the driver need to pa=
rse
> > it using 'config' attr value. This will add macro definitions to avoid
> > hard-code in driver.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v4:
> >  - new patch
> > Changes in v5:
> >  - move this patch earlier
> > Changes in v6:
> >  - no changes
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_d=
dr_perf.c
> > index 9685645bfe04..d1c566e661d8 100644
> > --- a/drivers/perf/fsl_imx9_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> > @@ -42,6 +42,11 @@
> >  #define NUM_COUNTERS		11
> >  #define CYCLES_COUNTER		0
> >
> > +#define CONFIG_EVENT_MASK	0x00FF
> > +#define CONFIG_EVENT_OFFSET	0
>=20
> Needn't need OFFSET if use FIELD_*

Okay, I will use FIELD_*.

>=20
> > +#define CONFIG_COUNTER_MASK	0xFF00
> > +#define CONFIG_COUNTER_OFFSET	8
>=20
> The same
>=20
> > +
> >  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
> >
> >  #define DDR_PERF_DEV_NAME	"imx9_ddr"
> > @@ -339,8 +344,10 @@ static void ddr_perf_counter_local_config(struct d=
dr_pmu *pmu, int config,
> >  				    int counter, bool enable)
> >  {
> >  	u32 ctrl_a;
> > +	int event;
> >
> >  	ctrl_a =3D readl_relaxed(pmu->base + PMLCA(counter));
> > +	event =3D (config & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
>=20
> FIELD_GET(CONFIG_EVENT_MASK, config);
>=20
> same below all code about config.

Okay.

Thanks,
Xu Yang

>=20
> >
> >  	if (enable) {
> >  		ctrl_a |=3D PMLCA_FC;
> > @@ -352,7 +359,7 @@ static void ddr_perf_counter_local_config(struct dd=
r_pmu *pmu, int config,
> >  		ctrl_a &=3D ~PMLCA_FC;
> >  		ctrl_a |=3D PMLCA_CE;
> >  		ctrl_a &=3D ~FIELD_PREP(PMLCA_EVENT, 0x7F);
> > -		ctrl_a |=3D FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
> > +		ctrl_a |=3D FIELD_PREP(PMLCA_EVENT, event);
> >  		writel(ctrl_a, pmu->base + PMLCA(counter));
> >  	} else {
> >  		/* Freeze counter. */
> > @@ -366,8 +373,8 @@ static void ddr_perf_monitor_config(struct ddr_pmu =
*pmu, int cfg, int cfg1, int
> >  	u32 pmcfg1, pmcfg2;
> >  	int event, counter;
> >
> > -	event =3D cfg & 0x000000FF;
> > -	counter =3D (cfg & 0x0000FF00) >> 8;
> > +	event =3D (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
> > +	counter =3D (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
> >
> >  	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
> >
> > @@ -469,7 +476,7 @@ static int ddr_perf_event_add(struct perf_event *ev=
ent, int flags)
> >  	int cfg2 =3D event->attr.config2;
> >  	int counter;
> >
> > -	counter =3D (cfg & 0x0000FF00) >> 8;
> > +	counter =3D (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
> >
> >  	pmu->events[counter] =3D event;
> >  	pmu->active_events++;
> > --
> > 2.34.1
> >

