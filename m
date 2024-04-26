Return-Path: <linux-kernel+bounces-159373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D18B2DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C750283EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77CC23B0;
	Fri, 26 Apr 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hh9eYZsa"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A96196;
	Fri, 26 Apr 2024 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714089645; cv=fail; b=fr5ElovWW+WfJlc1hGTyY0kieKj9zirDsXLvTO4+zE7yYpEKi46KQ8dmiyFDf6QJq2A1Eywl5MFSjhSMmIu6DeShhVv9rxaIUcWKMXyj6ebgmHiv82bp2lrUab56FSpWYiFPRTfMhnFQzDvCEebhDpLyIh58YQctOTgRLhgJTCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714089645; c=relaxed/simple;
	bh=zXSeMQFGO/K/jcw3DBDLG/ZccM85csiqYD/GnxAlEhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fMsaB0BuZnp7ZHUtZL+/WZidw5hUm+3aN4e/2i3Rhy5vVL4oXNrjMtMCSA/jdw2B32ATD29j9fkALNDmy56KnbpjLngyYoYR1kDsovCZHtXMvFS4w6rlEexlT6tZv1EGsXGcEI1BLTaIVh1HHasys28ZWOuwUhvMP1G56r+zBsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hh9eYZsa; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQmsqnhR9t8DJWiW7UGWKgAha2azpa2Vvhzz1g8AIk2b2ys10CslVoMxgQ7E/mM5pDDAw9q7kyeJqr2PleEAAFi0ko1IcSa0Wrk5Q/aRoMX9SK1IpoV34QneON/XtlFCxALArk1p3bWYME3XVh4YEOhytd3BqI3PfZpEJTAukdi+i/93s3mUKIJYj+RZRCjFwQ870faXg5vEZ9eUIKVbC161G2FR2zPAHBkSSwY2PvDGuexOMtizdwyz/Ck9x0V7wNqQEnQIxLUGa6kmx8QsOxRXC4ShKfvQdX61olk6sekIdak5qJ6Kjrmt8c+haxSdtNq21dJcM87NaY3KWI9zpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjeeqokNn7K8EgERMbFZF9th8PgCaRckaOcdfI+gbDw=;
 b=F4uqZF8/kjmPDcSQ2WbK9D61wabpUrwHbmNTi7s181TYNz2xEpsqG4NbIy4DL+7kMn5k+qcv3cRHNasZbmIbxAWTSbQeFuvki6YUR6BxIwMadYvmrNi8OX51EBMMGYDXJ07ZHmRbpjjVrUBJ04oio71yXG6R7W0vnkRs5NnF2ibL1OMbZaCcwilMATzvx6HTE1ZqEEu6u2jXNGVQpMns0U9mXnH73YOKZGvD5+U8BKQSVW0B+HaohCA6xEPhp0pzbYoWbopZYgPTxrArxCaBQBLsmBtOOEOcRivopZXcVqXN1xFML1khOyzeN9sHxwKv6YGFq8v5O6qdE6VSk6pFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjeeqokNn7K8EgERMbFZF9th8PgCaRckaOcdfI+gbDw=;
 b=hh9eYZsaMo/BhbV7PtBSyhDlyMYG+1PMvtm631yKszXGgxflHiMCO7MRE2g0fB7YNMIdaCd7s5/OcEBzRiGGbYYrV6kiuzmslFEY7FYfvOplGmjZIK5F/xIjAhtxLB4wpk9nm8NdSb81r2S/Km0wWM6p3nG93M9BcwhGtsjpq7g=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8597.eurprd04.prod.outlook.com (2603:10a6:10:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 00:00:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 00:00:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Linus Walleij
	<linus.walleij@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Topic: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Index: AQHakTp0F0gZzKwEJ0KLehvuXBXWtLF32SuAgADPKOCAAICOAIAAbbtw
Date: Fri, 26 Apr 2024 00:00:37 +0000
Message-ID:
 <DU0PR04MB9417CC2150FF2F038202433F88162@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
 <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
 <20240424193007.GA329896-robh@kernel.org>
 <DU0PR04MB9417C67342B1DD6CC299B4CE88172@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240425153140.GA2556348-robh@kernel.org>
In-Reply-To: <20240425153140.GA2556348-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8597:EE_
x-ms-office365-filtering-correlation-id: 4191f3fc-9bd0-4fd2-f47c-08dc6583e71d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yBleLm5/9bgCkLhW8axCIBD72xoebnjZynqN7SQ51d1Q02uapCaTECwLbK3C?=
 =?us-ascii?Q?oIiAoWHAkJdWisXPia/DKLus8QznAYuDciG772+yABOjzYyhyLIIsRoH7w4i?=
 =?us-ascii?Q?s3XY+ki8AbQ2GPovLXG6ccoHE7ZRAjsKz8XolJQobI05AGmSRDgtfoUaOEVK?=
 =?us-ascii?Q?+Yjx0h0zShPKiche1wZhQXXbSZEM/n0R9n0TlvUfGyJlHqHwvT9wUUBi3ApI?=
 =?us-ascii?Q?PCNbrItArB7fpKiz/R5Moa1rUKaXAEaI/SAz3vxsbnqhJchzNGM2ANFJZbpM?=
 =?us-ascii?Q?anDPxy409ych+OkQ7nBCt6tLOGQ8Nbwxwid1bM1uLfiwImpeDBLrFiQnxs44?=
 =?us-ascii?Q?HYdS2lMcY3wN47Yc5ZBZXaY+gb8vvEtmOqy4q/BxyGBGHWwIpW0MdAX1XWnG?=
 =?us-ascii?Q?Ujl7fWd8NJIrrdf+5gSmUsG6tE0AFNa05trE1u9E98TPEY+C5ok+rGLTgV3H?=
 =?us-ascii?Q?p96lPd2CgRUlyY59KDtfe3w7EpiW/iyaVb9HZclxx+4GEguOYM1dhDq+nh1P?=
 =?us-ascii?Q?Z1cGMZze9T7Y8zC9Def0oEM+ypEfW491yAU27TGcOTAgLYyjP5pD8ZBDZDhG?=
 =?us-ascii?Q?w3hci2sk9JrF7W0kf/erhqkWmXU5AWqir0zMgsslHwrM0xZ21UR/NJGkTlfp?=
 =?us-ascii?Q?0v/elYB6OxqPVJ48doZ4Af7clymCqROIMSdz9xLXBk6df12W1HVRtFtDv6gG?=
 =?us-ascii?Q?PUXG0Tyi9u4xCFfHUFSiUunFsdyLbiTZHvY3McIqkSht111Wx5vEeXxbeEPV?=
 =?us-ascii?Q?kfaW9GTilu/qb61/ritzF9JDvQ5wkN5eVnUGRhV8oyQiNDHL6i15LNC8JCpx?=
 =?us-ascii?Q?74PnFWm3kVE6WZm4h40XEqHRmMLXDFpXnA+VUsQBAbdhmZK46SD0QP/028Jw?=
 =?us-ascii?Q?44K6GQloPf8qxVEooL1GReuKYLwHSRHjUjOmbrfmUFygQ0xVEqyCvXw2CYR5?=
 =?us-ascii?Q?93esGh2v+ejpNL8mWPGKaDCd9U/lD6qpEMkiEyTNPnaR56oNouvzBLjENwiC?=
 =?us-ascii?Q?l2YtRZ0B/MOSsZI6ZyaWIbCLUMDsbA53MS56hz0nDrTFMtXDw1YvoYDNgGZN?=
 =?us-ascii?Q?4mzPcatyFezAQkirZ+O3OxPiAkfMl40SKd0txSf7Iq1rUiWff8SI9IKcGGDE?=
 =?us-ascii?Q?tfzSYJySFrYVWHr8jDbba+BF8ronkkx99pkOBH2KTANZZWZLVliGIQF5KoL9?=
 =?us-ascii?Q?OgYLQ/dVo34vqzA4Yc6Rq7L1xojtBRKmKqqg7fajA9SZvkBrLsS8X2x022eS?=
 =?us-ascii?Q?rb98os08VDsAnNMs4ZO0+UuJCN20OolD7syhnCrpaAIsLLplGfAowrUVabRX?=
 =?us-ascii?Q?74UOvGryPJXTVTPKRmD/IJJSq/A3EN/q3hp5PEm1Ji25RA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NLGOl/y89Ifmza24Yi4QcOndROEDvtV2HLJq4aaDabvrd1d9EtA85KPgG8u7?=
 =?us-ascii?Q?sKAIXZIM2IYW1HwLn/7Tc3zKdCoKQ/JH97IPEORaMeapdUokKasBPexL9FnO?=
 =?us-ascii?Q?aWi5W5uE5hOMfS1RrbOO8RWF35OQ7pgxlEJ++LF1n0RWFYDmmCbvyI7tiVnV?=
 =?us-ascii?Q?1T9vMHmSg8YjPB93FXVOUvMLICXCHPv7YA2Hykb+K7AwG1OdDLeocoqYRUYL?=
 =?us-ascii?Q?hPnxASyGlQ0lXHjH6QbyJHX+2nPwsG+kJOd277CHwbWR+eyz6WeEKDLGI0KF?=
 =?us-ascii?Q?VHUgzPz4fvY9f/vsH90jAsOQM03mEcD6AhVIawqL1TTYdNoc11lyfLQykrmi?=
 =?us-ascii?Q?StIyKElP0aLoZZWBTTDWNvotqxav9BiFfFbRjbBzXnAV5luCW0ifZX5FP3u4?=
 =?us-ascii?Q?NKyhgKm6rsvvNtw+OK1AUBqejEQhZIeHti8gQCnPxpDaW/79wLGXiQnHwhaK?=
 =?us-ascii?Q?7SOaCNcqFH3p4CDIrVhkZus5ZVFzcjOq3MgNh70nMHO8JpGbttesvtEXp6Zb?=
 =?us-ascii?Q?R1S1eHP52FwpNu9XtZfZBEufw83gi7edmbCK/F3Qul/EEfPqXw7ejR8T+bWz?=
 =?us-ascii?Q?YcJk2d0gZO9wUwIujrGDfT8//+FrunuoCpY8OCMZAsi0ghnghrCHiWqdtt6e?=
 =?us-ascii?Q?ZNXkLWQQC7Hnq0+6oXKFonMI6DG8v96FC5p6nX6zQYFCBOj/6c3NHwe4L+4U?=
 =?us-ascii?Q?QV3UcKu4DMr480cGNxKuQr9fPA81QNgCJxEfrU0/rDYzX37HbZO8Ap5h71iP?=
 =?us-ascii?Q?sqOtjbiUFIdfvJw3mafvyfQMcR0OdHoRDAE0zNJ6AzYs6NYiWweRszkE2mVx?=
 =?us-ascii?Q?gCpLW0FQtxRa8EwUFG4IrAU0xVznkdFgWp0q0ogZIZNR3pHkh+jxMWQX12yG?=
 =?us-ascii?Q?wCOpVDa0DzBpepmPeIleCvMgAEVEirHtVB3f3zKSGh8I2QLvAI4J1Z7Q0+0w?=
 =?us-ascii?Q?ZkDQhk2mIcdgZwiMSQLamxBFQZtAGqNPLYH01+pdHo+isOHVM5MgWby1c4GM?=
 =?us-ascii?Q?y9LmX7mTii75vdWNJ3Clpyqm7DvHTXEB7OPxhxVGl8TxIRBx0rbIJAfsdyx+?=
 =?us-ascii?Q?STlLfg5c28WCHLQQSBpDSx0UBS8jN4hua40pYDuRAE2dlelHNqvvztsLJPKr?=
 =?us-ascii?Q?jNkioZAP0OAAbD8pOisrtTTo7Ml/IUHLs0WrQJMPPKg90L+DRdoOzl8Jfnfc?=
 =?us-ascii?Q?YNHy4GPtZF6lNjDdEsvPRlk2zEtXy+VsEzJsygw5Z6YDGGaalZTBd0Oacik1?=
 =?us-ascii?Q?EXSFzCtS/ZzmmtGuSJVXMF8LoPKqBwJGO9BXOfpHcj31EcPHga4bE2dD5BmX?=
 =?us-ascii?Q?2zY5qfYn9kNdgVqBsjWFQ14fOMkDdZbMFcPK9ckPaJqHf1Fcfevmc0TaTJC5?=
 =?us-ascii?Q?V4vTT43laenm5Kvpk4XxEzcibV3Sn0OvVVC9EFAKp0eEgr4WKVgZmQtFhEvz?=
 =?us-ascii?Q?3ki6ibsS7bivc9EiGd2dR4gWTQ1hLBRsQIhS2zlcYFm4S/j5/wdIw0wMhTu5?=
 =?us-ascii?Q?eyQmKLff6PDG+9h70r/9js4ZKkEOErEYVRtpm/IKFKvIvEV7fL63Cez11tgH?=
 =?us-ascii?Q?DZ+jToMvp6uSybcuucg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4191f3fc-9bd0-4fd2-f47c-08dc6583e71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 00:00:37.1885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbk6Tv7wQZNBMmlu3o3smS1r/lpvjGvq4mWqu3RSuJT4h2Re2jpzCg3Qpnxfd7NMX9M9GXDdjNclXAoDVUisrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8597

Hi Rob, Sudeep, Cristian, Linus

Although this is dt-binding stuff, I hope you could also help suggest how t=
o
support NXP SCMI OEM extensions. There is less chance NXP will change
SCMI firmware to make linux happy using generic conf stuff, because
the SCMI firmware will also need to work for FreeRTOS/GHS/QNX and etc.

> Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properti=
es
> for i.MX95 Pinctrl OEM extensions
>=20
> On Thu, Apr 25, 2024 at 09:06:00AM +0000, Peng Fan wrote:
> > Hi Rob,
> >
> > > Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add
> > > properties for i.MX95 Pinctrl OEM extensions
> > >
> > > On Thu, Apr 18, 2024 at 10:53:17AM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions.
> > > > This patch is to add i.MX95 Pinctrl OEM extensions properties.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
> > > >  .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66
> > > > ++++++++++++++++++++++
> > > >  2 files changed, 72 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> >
> > ....
> >
> > > > +
> > > > +title: i.MX System Control and Management Interface (SCMI)
> > > > +Pinctrl Protocol
> > > > +
> > > > +maintainers:
> > > > +  - Peng Fan <peng.fan@arm.com>
> > > > +
> > > > +patternProperties:
> > > > +  '[a-f0-9]+$':
> > > > +    type: object
> > > > +    unevaluatedProperties: false
> > > > +
> > > > +    properties:
> > > > +      pins:
> > > > +        $ref: /schemas/types.yaml#/definitions/string
> > > > +        description: name of the pin
> > > > +        items:
> > > > +          enum: [ daptdi, daptmsswdio, daptclkswclk, daptdotracesw=
o,
> > > > +                  gpioio00, gpioio01, gpioio02, gpioio03,
> > > > + gpioio04,
> > >
> > > ioio?
> >
> > Yes. The name is exported from SCMI firmware.
> >
> > >
> > > > +                  gpioio05, gpioio06, gpioio07, gpioio08, gpioio09=
,
> > > > +                  gpioio10, gpioio11, gpioio12, gpioio13, gpioio14=
,
> > > > +                  gpioio15, gpioio16, gpioio17, gpioio18, gpioio19=
,
> > > > +                  gpioio20, gpioio21, gpioio22, gpioio23, gpioio24=
,
> > > > +                  gpioio25, gpioio26, gpioio27, gpioio28, gpioio29=
,
> > > > +                  gpioio30, gpioio31, gpioio32, gpioio33, gpioio34=
,
> > > > +                  gpioio35, gpioio36, gpioio37, ccmclko1, ccmclko2=
,
> > > > +                  ccmclko3, ccmclko4, enet1mdc, enet1mdio, enet1td=
3,
> > > > +                  enet1td2, enet1td1, enet1td0, enet1txctl, enet1t=
xc,
> > > > +                  enet1rxctl, enet1rxc, enet1rd0, enet1rd1, enet1r=
d2,
> > > > +                  enet1rd3, enet2mdc, enet2mdio, enet2td3, enet2td=
2,
> > > > +                  enet2td1, enet2td0, enet2txctl, enet2txc, enet2r=
xctl,
> > > > +                  enet2rxc, enet2rd0, enet2rd1, enet2rd2, enet2rd3=
,
> > > > +                  sd1clk, sd1cmd, sd1data0, sd1data1, sd1data2, sd=
1data3,
> > > > +                  sd1data4, sd1data5, sd1data6, sd1data7, sd1strob=
e,
> > > > +                  sd2vselect, sd3clk, sd3cmd, sd3data0, sd3data1,
> > > > +                  sd3data2, sd3data3, xspi1data0, xspi1data1, xspi=
1data2,
> > > > +                  xspi1data3, xspi1data4, xspi1data5, xspi1data6,
> > > > +                  xspi1data7, xspi1dqs, xspi1sclk, xspi1ss0b, xspi=
1ss1b,
> > > > +                  sd2cdb, sd2clk, sd2cmd, sd2data0, sd2data1, sd2d=
ata2,
> > > > +                  sd2data3, sd2resetb, i2c1scl, i2c1sda, i2c2scl, =
i2c2sda,
> > > > +                  uart1rxd, uart1txd, uart2rxd, uart2txd, pdmclk,
> > > > +                  pdmbitstream0, pdmbitstream1, sai1txfs, sai1txc,
> > > > +                  sai1txd0, sai1rxd0, wdogany, fccuerr0 ]
> > > > +
> > > > +      nxp,func-id:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description: Indicates the PAD connections which function
> > > > + module
> > >
> > > The description makes no sense...
> >
> > I will use below description in v3:
> > For each pin, there are up to 8 muxing options (called ALT modes). For
> example:
> > Select 1 of 5 iomux modes to be used for pad: DAP_TCLK_SWCLK.
> > 000b - Select mux mode: ALT0 mux port: JTAG_MUX_TCK of instance:
> > jtag_mux 010b - Select mux mode: ALT2 mux port: CAN4_RX of instance:
> > imx95_wakeupmix_top 100b - Select mux mode: ALT4 mux port:
> > FLEXIO1_FLEXIO30 of instance: imx95_wakeupmix_top 101b - Select mux
> > mode: ALT5 mux port: GPIO3_IO30 of instance: imx95_wakeupmix_top
> 110b
> > - Select mux mode: ALT6 mux port: LPUART5_CTS_B of instance:
> imx95_wakeupmix_top The nxp,func-id property is selecting one ALT mode.
>=20
> Looks like constraints on the values. Please add schema for them. I don't
> think you need to list an example.

Will add maxItems: 8, minItems: 1
>=20
> Perhaps you should be using 'pinmux' property. That is the standard way t=
o
> specify a numeric mux mode.

Ok let me try.=20

>=20
>=20
> > >
> > > > +
> > > > +      nxp,pin-conf:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description: The PAD configuration
> > >
> > > PAD stands for? Or is it pin configuration as the property name says?
> >
> > It is pin configuration which includes pull up/down, drive strength and=
 etc.
> >
> > >
> > > This is just a raw register values?
> >
> > Yes.
> >
> > Why can't standard pinctrl properties be
> > > used here. What's the point of using SCMI pinctrl if you are just shu=
ttling
> > > register values to SCMI?
> >
> > Standard pinctrl properties will need more memory in our SCMI
> > firmware design. We have limited on-chip memory for SCMI firmware usage=
.
>=20
> Then maybe you shouldn't be using SCMI and just write a pinctrl driver.

I think I have to. pinctrl-scmi-imx.c was not preferred by ARM SCMI maintai=
ner.

If Linus, Cristian, Sudeep are ok, I could add back pinctrl-scmi-imx.c for
some OEM mapping/unmapping stuff.

> Or, Linux has to parse the DT anyways, so use standard properties and
> transform them into your register values and send that to SCMI.

Cristian, Sudeep, Linus,

Is this ok for you? Before sending to SCMI, linux driver transform
the bits into register value, and send to SCMI firmware.

>=20
> > > > +
> > > > +      nxp,daisy-id:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description: The select input register ID
> > > > +
> > > > +      nxp,daisy-conf:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description: The select input register value
> > >
> > > I remember some daisy chaining stuff in iomuxc, but otherwise
> > >
> > > What's the relationship between these 2 properties? Is it valid if on=
ly
> > > 1 is present? I doubt it.
> >
> > The scmi firmware will convert the daisy-id into register address, and
> > write the daisy-conf value into the register.
> >
> >  Looks like an address and value pair. Either the
> > > schema needs to define allowed combinations
> >
> > The firmware will check whether id and conf is valid, is there a need t=
o
> define
> > allowed combinations? There will be lots of check to define allowed
> > combinations.
>=20
> The firmware can't check that the DT contains nxp,daisy-id but not
> nxp,daisy-conf or vice-versa. Of course the kernel could check that, but
> validating the DT is not the kernel's job.
>=20
>=20
> >  or design the properties in a
> > > way you don't have too. IOW, make a single property that's a tuple of
> register
> > > ID and value.
> >
> > Define tuple will make the property not able to use linux generic pinco=
nf
> > driver. The current parse_dt_cfg for custom_dt_params only support a
> > single u32 value and not easy to support tuple.
>=20
> Sounds like a Linux problem. We're talking about bindings. Fix Linux if
> it doesn't meet your needs.
>=20
>=20
> How many bits of id and conf do you need? This too could just be part of
> 'pinmux' property. It's value is entirely h/w specific and up to you.
> You just need to fit it into 32-bits (though we could perhaps enlarge
> it).

For conf, 4 bits is find. For id, 12 bits is fine I think.=20

Using pinmux property with some vendor handing code. Not sure
ARM SCMI maintainer is happy or not.

Thanks,
Peng.

>=20
> Rob

