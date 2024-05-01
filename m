Return-Path: <linux-kernel+bounces-165214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14418B8998
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8581C209FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24ED85268;
	Wed,  1 May 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ioaviImF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701F7CF3A;
	Wed,  1 May 2024 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565508; cv=fail; b=eezPM1lgDMuGnREhTPaRtBY93gQcOlb5oMmGbdAHICzGlt5HPbtYD1vtE/YFbHJZsNocZENRoUKo33hk+9x6a6XZzVOO3xNPDaQvY5TklQJmwYrAdFP5ckXhX4ES3B1PT2AXtVVr2QC9gts+lN6PNRdN73i7wPvYSTnSKQJ2xpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565508; c=relaxed/simple;
	bh=+FsyOCO7ET7tIlBgM0GU65w2FzhnKqoKWWKjBrnR6J0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=miFpBJBU+0jrdpCcKl54tcHBdcMg0Jp6SUmxHylcBI9HGsL+SIHkbQeKrPoD/1deGclXU1p12UoLXkqtY7l22h2bVlV/Pp8sBe5RGnSBHUxJCGQiGwxWRviMgzlgeWPoixyB3OsAMBkumI9RInDdIN5yQ+l8BDZgrqb+idbIRsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ioaviImF; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgIUH9cdeiq6tOFRkSEBDCK4e9pqyOYehzSh0bBM9JJBzPV7qVGm3QVS9aGvK/qBru8lrRMMiW6v3AJcvIv8h9IaU0zvqThNEZfz45byOtOO6yW15xNWPUY0+9HbPVn8T5O4YnNP5trCo6aWJblVcPx23u2dEFFDoZhrRzpHytrIz4eVcFs1fiZFJeW7d2Mu1HD7wJVx/OH38pIxc5w7xg5Nq1vGVv5ZG5mPI46EO6oUEA5gqOsgyTYopbRsJWnHhy7GYOL0Qh/qU9hwFbhVj2aC5NItV0vq7XoObtVHQcsrtrXrtHGv+PKKPLGQ7sET1ad6f4cqidTkuBmyr9PLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63AFgmoK5ZnxMjlnA/eKLVH5OYzFjCliZ/lL5MTQnWY=;
 b=FXYN2jNN8+kGxTz4z4dQlainIb2Dg/WNav4IxJCCylzZbyFLEvilf2SGIAP8JAWcBtES0OPntBeVAm/vFGSMIItiMt+Nnu1XUvs1MWa+TbiXejyIBR/yHMVflFNVs1dlhkldrvbl8/TNqJWoC30gkjpPRZl+OiqRn66lP4IOMZe/V/uP1mjwhObTzj4PJyeitcmx8q6wj+F6Kxa+i9aVK/NB+B75YlEErEB7i3SXfM/9dgkMJ/ol+s9T8ISAo7baYfpqryz0PCRpkb8pper88WOOiN4u7tYFfFMvcso8+mItiOzIJBodcu2SbjXe1kf1Qlx0cZWCFg6C4IU/s6juaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63AFgmoK5ZnxMjlnA/eKLVH5OYzFjCliZ/lL5MTQnWY=;
 b=ioaviImF14tGtxP51AfnqhQaaW/T1LYWtePVgiuvxtHykVVGSC/w8Ix7qJnEhLI4SDgpnm+eTMck2pk1ZD5mrfvAH1bC7sc2svNC1/gwwqHEMZLooNKLL0CxPFmLqvV61Hua0glGPOz4uDU5pQbUmGhupvTe7DR/28Jf7m7TVSU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8930.eurprd04.prod.outlook.com (2603:10a6:20b:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 12:11:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:11:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng
 Fan <peng.fan@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Topic: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Index: AQHakTp0F0gZzKwEJ0KLehvuXBXWtLF32SuAgADPKOCACauUAIAAClDg
Date: Wed, 1 May 2024 12:11:41 +0000
Message-ID:
 <DU0PR04MB9417B9CD74A1E15F2515ECA588192@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
 <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
 <20240424193007.GA329896-robh@kernel.org>
 <DU0PR04MB9417C67342B1DD6CC299B4CE88172@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZjIoMJOAxtC-nkZO@pluto>
In-Reply-To: <ZjIoMJOAxtC-nkZO@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8930:EE_
x-ms-office365-filtering-correlation-id: 2fd3d8ac-752e-4d4c-be1c-08dc69d7dc9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ULx/rq5QMmP1ytmWrdLP9F1V45ClaJpwta6xJsAGBolOe6xKlirhwz+N6S5d?=
 =?us-ascii?Q?FMGrz1ZXONOrGqb0On4LniojyH/Ef8rvqSOiYNDNhltcwzHtrN9gH4PTNv+v?=
 =?us-ascii?Q?SWodt4lPqT6EuLSaP7D2U9DIpJU2aSkpT47Cjp6gZ95zzUb8BTz1S2pN+42R?=
 =?us-ascii?Q?rnp739VJRCeVc4lO/RZDpzpSH6IO+B/Cb0iO0h4FNoJVIyItwnNEVRRi6ddv?=
 =?us-ascii?Q?7XYCk2qUbK2LjMIpKHy0tSBNAZW5Pv9oXgjBI6Cl2UnhmEChV5oueKKha7iS?=
 =?us-ascii?Q?oNxT/lej0c2CahHV2bRnlWeZejvcmDKB7JpgTlgVaE3S/iPXi4OrQH1A0sVw?=
 =?us-ascii?Q?PiU0ELrumypcCbs77A48NAigK53GbpXyWS1BpoOphrrnpw17Ki3VF7Ri5QRz?=
 =?us-ascii?Q?uzRq1We0dy0ZmCEAxmacVaRaF6ZmS4Fo2/+5jMnXh+vwodAMPp6BiSPBOH3N?=
 =?us-ascii?Q?dkP3hFCRs0rRpRFQaZMES+ZssWmLL2lRCvoY4BTHwIRoELdFodfEbjozakS5?=
 =?us-ascii?Q?FXXSJXUeKsO1U+jnwEIlq5p5mazzSw+liWbbSJnFkKI2kvglRkO+f7If6R7z?=
 =?us-ascii?Q?7Rz5LJPnVBSEVVZlr1jx0w6H+2KbkQy1f4rgPDH+aIM5qL6ws2W1bXFyKUSV?=
 =?us-ascii?Q?jig9u5HrpB5nbWUYT9AS6IXtf8vMNKxnuTx8qyCw45/ZWXfQWETjXsFIbWTa?=
 =?us-ascii?Q?YiWLvJFkhF5dLlY0tS0uDkvPljoEgtmoOHZv4/DNjGoquM9ZHC5CScfQvCiQ?=
 =?us-ascii?Q?CQNVdZcyGHqzyQmVK8Ef79V9SQt1IelvS7P8peRFXefdxTghEviIIY6kqhQO?=
 =?us-ascii?Q?sMW86inJClU8hEarMthvgHBeWfchXjrQhLFMjU+7urDEWCvWFYCCETB249ml?=
 =?us-ascii?Q?7dbnJf2hn7UFnTXW65hMzeeKcok4xCUxX3UWVnNU74T1yrSuWSuS/bTTLxl+?=
 =?us-ascii?Q?9ApsQQ6BvIPrHhUQ/c7UrIGrLn7MgWmF5Q4yMkvt53SmDkGU/gBmAc/Wv+dY?=
 =?us-ascii?Q?3f0SJMKoFcNwDrhEPYbBCesuC+dGdU1wRG9h+8drwpHD4au89y3gceXqFS9V?=
 =?us-ascii?Q?ZBU/IJ246/LD5I000iPAbBUCf0U4Ag6gwkinjoGtvMjgHYbRaUHK3KGYFcgw?=
 =?us-ascii?Q?ELP+ikGw0HnlNiQccCPJ6V6gy4ncKM7pPuvzVRfSNhhhtg7hZ+DNI1TDl+D6?=
 =?us-ascii?Q?l+50dzPPZOVPBr/5euVlO5ATE/NF5n7TNwJali1dn7YBPKcIyEBsOBPiZlan?=
 =?us-ascii?Q?1eouIjntNIZIYyp7jwovIuUmFdN3HqdjViU9DPoNQaKd7W0j19Dmj+/qe0HE?=
 =?us-ascii?Q?5vKLhMOzgYlPwidkgmb3as/eAm472+/5Pq3LtUhlYeaWFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rIp8JMg+5xUk+YNLUP3cY57KUTJTYqxwxnX2ZL3keINrXdYJScpApcUsxLFi?=
 =?us-ascii?Q?UxZeN4KAxlhy93HyQZln/SzcwZfJ36zra4LPOSqtpAbdsvuTmRCCKJWFL2or?=
 =?us-ascii?Q?WlmH9KGWwZM+v1EA8PNnXNBbwbw4NBEtRwCB0rj9H9+lrmPhrJxOvZRFndvR?=
 =?us-ascii?Q?Giij/JhancQkTH3yrXUqQ/twtxR73e+yQ0csw7OhsFMvcPx9+sP67uAYsKA5?=
 =?us-ascii?Q?51siz+fDzgvbAIJveiDHBm7iwgnG00N79M0+Wt2J8DRztB7Ga9yWP5e4GLhO?=
 =?us-ascii?Q?rCsHr2vnpJQ1rPBT41vOxj1m1EVZyaBr1tL/Gb9Z6l/AgkZUydma8A/it7MV?=
 =?us-ascii?Q?N5jujyyMxfNJiWUsRoPZJCdxu1EN/ghXBvN/SF3OjYJKrGSkiOLSD2RhfO+K?=
 =?us-ascii?Q?32D+HKvAYaWKvbEAkGBHENitDzrkAPfHaIuTXR5YSVOrE2rK1pwLkYeSVmXM?=
 =?us-ascii?Q?f94yhgcQJ5iXy5OHL+iVqAcLTiSNsdp3S7zA6fDI/ZRkSAE/d3jm0tOY6SDN?=
 =?us-ascii?Q?T+bSadR1DiNJOu2QO3gVHyJEwq5llSYHIXtk8R7IjIpe/9NwSKa6TeiGuv1W?=
 =?us-ascii?Q?+EMdbNx0XSNtNDGDDrAeFEo0idWSoN6J96W0CYHND4ohZqzU7FM3q4WEj0MA?=
 =?us-ascii?Q?+m0GplkNfeT/pWFhii5yimz6l8qRpygtEFWL9uAR9UFP11wZTY3bYWVKyMs4?=
 =?us-ascii?Q?nmgem03A/gpzlF5wE1Hm0Hwy0Z9sewxpeSIKjx9tTPzOTywjQT+Tyt3naQos?=
 =?us-ascii?Q?juh+Ldkv4hEQfMITt01gI6cXcna1tMVzJftsAj0mhuSvRegvIy12RgNCu0Lx?=
 =?us-ascii?Q?hTnVnKwiZn64CRXNJaa/nJHpgbAxgvBg4YJv6CGZwKmwTGxKTmy3JftE44D7?=
 =?us-ascii?Q?+00J3rh/75/MQx9yElAN1vHryqivAKHjWf67cTjWptjmiOw61ypZ51/B3nAv?=
 =?us-ascii?Q?2vF5OOhd840EFk1i7w/dbNjnKIgyFo07AZ4YttWB9RWJbVufOAFGWo6iyEWN?=
 =?us-ascii?Q?d6EJ61vmP7RWMrofAlTf99j52UuZdP7ooycKxGRcSy1bN9t5PGpVHw/VGyW9?=
 =?us-ascii?Q?0HrrDqndds2NwcbwGrtre1KwFfyEy0XUcK46N5J2QY82VNeG+4QnxJ/iuplh?=
 =?us-ascii?Q?RHJ3pTxWzAZTUhgxXwdYU8gzZC6RlT+Aq6yr/2TAvi0lm6IF10OpngHXxFIY?=
 =?us-ascii?Q?xE6sFmEjy8mrFdVo7PUjGIP4orPnSfIPzu8HiA+ce7EQ5czwdRq2XFf4ie/b?=
 =?us-ascii?Q?eCRsgryiLLpbBCHMtlPF5Y+zMkL4k8t4VVpPH9gQB1oO2UCErcrkgjgzV9dQ?=
 =?us-ascii?Q?CojhD7Po3pHxdCNMK2q2Zc+LHUz/Chi+YZ0jnUrWouAlvCyF4RAqe/E0Togh?=
 =?us-ascii?Q?44LYcr0UZh6WwQjGWbf/J0KAgct37UvsnuSFXp6GHwRvuE9LQNLh7qU9CapS?=
 =?us-ascii?Q?ULAae5lgR60Ueg8Wsx/JsFhob/c3EngDePR0I5Geg283h626C8rbWa+rxpZH?=
 =?us-ascii?Q?1rVwBBjJkPLToGeRVlIKzX5v/iqtHG0fmpc5dVRCJ12JY6q4quXleWiu4PQE?=
 =?us-ascii?Q?wWhAcWwp5VyWpv6TMs0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd3d8ac-752e-4d4c-be1c-08dc69d7dc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 12:11:41.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwvfVEygf4zoFMoKAtj/uhWYsvorI6u+0VXT8K6pl0MdKxWyYJ6AcVb/5N4j4Dmby2wk5ibzChoHFS3OMKREhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8930

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
> >
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
> > > used here. What's the point of using SCMI pinctrl if you are just
> > > shuttling register values to SCMI?
> >
> > Standard pinctrl properties will need more memory in our SCMI firmware
> > design. We have limited on-chip memory for SCMI firmware usage.
> >
>=20
> So you sort of strip-down the server due to hw constraints, but is it the=
 SCMI
> server still compliant with the spec ? (as in supporting all the mandator=
y
> commands and features for the protocols you decided to
> support)

Yes, the SCMI server is compliant with the spec. It is the SCMI firmware
returns num function with value zero, num group with value zero.

And only OEM pin configure type supported in our SCMI firmware.

I have posted out v3 following Rob's suggestion, using property
'pinmux', but now we could not reuse pinctrl-scmi.c

Thanks,
Peng.

>=20
> Thanks,
> Cristian

