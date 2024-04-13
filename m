Return-Path: <linux-kernel+bounces-143593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E48A3B37
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0C52823B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CE1CD26;
	Sat, 13 Apr 2024 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X9dizk+Q"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877EFC0C;
	Sat, 13 Apr 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712988081; cv=fail; b=LOPjHJcpo5Q1SgBwxoib/VCazjuCpg2UlEP6GZAqg3Cs+oQq6RWVex+bFGbpG0Jy+DG3eafk+X8IyOKt4ZOFfWUskxPglHhDAje3Wyc2eIT/SSgmfSiJ6LlI65zf29cVysQWf3JZMjTeEBQH8ukGNmFXUXLaqAkfd8KoXgJOP58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712988081; c=relaxed/simple;
	bh=v2NfMpWrBg2TTjp0HILX3NC7tXElB505zoSxqOVoefo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZXfJsF6wcXhwYdkhRRK1FIkAthXbUS114s2L2vQ7Wl87LHav0d55tF4dpQMrmo8OZ+cgobDbdc78bc9uXg6mqKH5qVX732aerIX8MhNPD+os2G8TPBBxiqbtETBk0rZXyNOrGji4oedE7fzm5ntmg/TWE3tydeE0jow2vn82I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=X9dizk+Q; arc=fail smtp.client-ip=40.107.15.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAl17t8DD7am3mikI2RzOFjhiWgkJo7CW3nhJl3wP5wBt/dObme1asAvmX4ynJKYNsHoOytlRpYj9UmyTfRPvH6g1voviQ6X6OSgqUWeavJhPudVQXWRGcMgMnDuqixZXMkl4yw0os/2psU4xAtyynkuicnMsp25O4eLXoX7UjFeR7oDWn2J/DNfekmbJDOR85LWr46BDEyqjNx0fnFguC01XTCno0cSgVtCXo1VAEAor6c365YKF0NWaC8NA+JsxjIIoThgS9BZv/YyI9hFApxr8x3rwPCCQbTs2IUdp/6pZVdMHBIV1Li/sBovM7JDcN02CD2b7zNJ+MtRYTPoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vw7Eh+FZ7rOvuA5OX+0eghB2aa5xongtLD3Vm545kY=;
 b=TZ6//Sifey9+WnDnxlbR/OKw652fd6zoAw23hoYXe4FXprLGkwP6LFULJ1R5Ik4pNKl0hkHbAgpOR6svyBG1/FaH6wkyIbqpZU/87cyMRwpEImonY9IWv/ip/yjBqwsixN7rFb1VALbOGK/Qf3YdLRAvgmu+hjwRf/T7KEkaY/8kNn6wytqAdyAKfOBW8UPS6uUzHaubud6dasTaHxNh+a3lXwq58L/LBrZiYovAoXPWp02EtmRSQtr3RXRF/uUfn9z/lyEI5yaOf0D9SJRs0mUgpKL3IWg2HsQiwQGWVRWY5Bkvg25bf0zVqapTUiyV33gB2vB88jAy49+81Yr/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vw7Eh+FZ7rOvuA5OX+0eghB2aa5xongtLD3Vm545kY=;
 b=X9dizk+QGKc4FT1eMVsYbK6uQEP8vEkNjAmTlcLo1EKzVE5klAaMuSuJw/NesWLMdjcMtf7lztb5CmIooqRxuqwyRGPrdfQoNb0IKbs0EnS4hR+gkbB+YbseGTKb6eHZYYctUqyd6LNpY6RFclewyV5qWC6jlcVmX7G+4rr8jbM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9095.eurprd04.prod.outlook.com (2603:10a6:20b:446::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 06:01:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sat, 13 Apr 2024
 06:01:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Peng Fan <peng.fan@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Thread-Topic: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Thread-Index: AQHajG9fogbrSJSEIkC/zlbnV4Z6dbFkvpCAgAD3YxA=
Date: Sat, 13 Apr 2024 06:01:17 +0000
Message-ID:
 <DU0PR04MB9417C3A75792347AB3A12774880B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>
 <ZhlPK4PmnYHj0K2d@lizhi-Precision-Tower-5810>
In-Reply-To: <ZhlPK4PmnYHj0K2d@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB9095:EE_
x-ms-office365-filtering-correlation-id: 888ee029-2cd1-4f33-a3e6-08dc5b7f224a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cDA0JKGFuIrIJ6704OY9z5PhZbC+lKCqAGu0vCEJHBkBGdEs2TuclIjaJbgpkRggSPlDCrsxPYgp/V7wyX+X16053pBmT3LTsxOtEBr7M3OOl75zTyjD4ZlULAHlZHNi2YjAeC5Rth/tKM7jiA1TtEkMGPT1GcRlYDXpWA97Lpz2QIczuhEvDWxNVKPNv5teteRGkD0BrqNc0+srj0doSa2M9N379qAGSiAordrAlTxMHBdaOco/6DHlp8FBRyrySAg5eDR1Y1Yy3Ra/ZsXIIr+9tR4iGgbCHGirg1ZFBS47r55oufgWyrj4sCrYKW2TJz4iZDSVSpsJFA8LgNAcZa8bp/rjOlwMqV4kujtzk7697z/kdB9I4EsAIl8xqM853/xG6RuYFiUsWWs3n1cos2RuVJGn9sDBmeoXiFvly6nORnE9HeQCzvPcUBu4fKpc5cLDiu4TtoguQochWcy89IvbUFNnR6w1v+SMaK9m2bD7Ne1tgkDi/GY/YyFjqZY43v1MmeQhZ/vwk2sK9yBepkwCsbIiZIaPDGNVCf/GivhVq2XsE7mPlWclqA2U4BMEZymxBsJ4Go9sW0ZlEgX/DswlFhsGJhwtQlbvyeoYc7XvuW4LYehLbAEz2O4etIzMkOn/Eacu1Hoj1KpC11Znc0r3wz7SnkuNKOKF0528wuDNsib+7qWBVvy/2Nys64T+woKmQdAGwFgQQlkxnVisyT4b74BOM08codnj2iTaxYY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n1QWokcENZ2ErWubg77GYRpufKmL1yvzvFCmK/gb9xEn/VhcfusAy5dx/7U5?=
 =?us-ascii?Q?/LYfT8N5w3HW9frWNGD1euE9n528T14EUYwdvxj4h9rQR05klUFxj9GbuCzv?=
 =?us-ascii?Q?j2NpFrNRPwQ3g8ZPfHldo0qqvK+UBWBfpg6Pn6TP9JJcJbUtdh9v3uMOfqTj?=
 =?us-ascii?Q?E0DSXA4e5ybpYMVAFYh98w78JsyQaX779YQkvtw3cHlcyCrZKEoY/RMUZ7x6?=
 =?us-ascii?Q?Tn42wl9RZCcxJzH6LtE6wyhjzucXjICAGFxpg/nQMIarMl24QquuJ1DSZsDT?=
 =?us-ascii?Q?7i6/wL5niqxh0cqqYL1gL7fw2wuJysDVECbDibgsMac3KG0QNfZuEtvSUYWq?=
 =?us-ascii?Q?SKaXz48eKy5clmEHcGtGN08Wt3MmJPCGrRxuXVYTWNZb+qBxzZ+XNL1N6/T1?=
 =?us-ascii?Q?2Is7zQX9sJFuU/aha7ku0l+z5sFEockoOCQOKqIwHGgplkYy3Dqzmrei1VVJ?=
 =?us-ascii?Q?QCtMnrnV68Elt8e3OFGHBW4QLTXSzSkb3kWKqAb8Zzx341oxnrItxCzBPV3c?=
 =?us-ascii?Q?zSTmFXwLHZzi9Y5Ed3Js8tOYSFVkBCvkOHyl+M1qYKd4QYiynmiZSu11qLbF?=
 =?us-ascii?Q?lnmAtgZToVDdm5fRTvMZL2yyF41SiSZ252xaYWasMjm4q27Z092xWimc4SUm?=
 =?us-ascii?Q?jwKyw1m0xik87YrqUzJvr4tNqwX/GqrJqj3TVkOLn5eQvrVbKJ8GR78Ge3cC?=
 =?us-ascii?Q?0mucvsOcs3KdSRXRgKywuLpXD/5XwlvCNZU8hmCHW3EiN4t4mlkRWguAljXM?=
 =?us-ascii?Q?h+bQIMN1jOAaJQMEfO4JPwdFggUM+rSLfitxxbdZv7xSzacbkc91ielLdM8Y?=
 =?us-ascii?Q?41LGUcLQoWI6VslpZdd7fwJ8pRKd2WRgK2p+4WqEqmJGlvHHy7xP15Hhq/fk?=
 =?us-ascii?Q?aTuZrLVqIg5ZFB5N4otTkYzbesjbWAvKhjQA7JgmcX8Lxme+4NHUCvHFLXTJ?=
 =?us-ascii?Q?9ovUO385obfrbqn4BxdaskvB383vFeUVby/pVWMB16XDv7Ag2l1HU38JO+2O?=
 =?us-ascii?Q?JwMTsMp/+0GNyOagY/H8PuRwkt4LebaphuRdVRf7k8d8wNWT38nOShD8Ay+4?=
 =?us-ascii?Q?X4gN0jMT9DSvw5CvHPaMSaXvFkjndIMpABa7wvOiz4g9Pz3hZE8bSj2PXXhN?=
 =?us-ascii?Q?i0vZ0p1a3KVb1sACIe+3g5VyD59X/J5MPSeYbEGBKxzW0WhPy59C5CcPKRIY?=
 =?us-ascii?Q?Q/DGrv2o9+IvWwXXnUHiPBUy67O/KIO5vQsmsAFvVE6M0fMcBZcwCOFQK1Rk?=
 =?us-ascii?Q?u0u9aZdm6dsUcWWwGlR91Ft12S7RNEkXY41U/mMN7mQpuPE5cLiN4tRAw9bb?=
 =?us-ascii?Q?o/Ji1huYPuzmMDW20qMEw5xZd9tFLbQRipn6V5Fa7sHdATSL6k4yaOzFQ1w8?=
 =?us-ascii?Q?l1JFCgiEiyaICx44iO09Ww9yPk36EwD0dyx3PqVp08tg0psQPwW8vG+vHrLk?=
 =?us-ascii?Q?WGDntIkFQgPsPyh6UdOeZOg8FCEhq2GPW1yrTjp0EW9a6Bo2RXZI1jxQci1M?=
 =?us-ascii?Q?h2RcEx/iVtzehkTBug6RnTf8PaIoAa/FOHrxaEKlJGdmcES/yZIfsWM/J3sw?=
 =?us-ascii?Q?yQ+Z2DmTCB8op9QFa1U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 888ee029-2cd1-4f33-a3e6-08dc5b7f224a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 06:01:17.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COMyqcuC5ef+cmJQmAIVoUIZG5+0X9qS0u23/JnxwFANR0dURLnOVykxMS+9qKRDLpne87Z5auXpaKGpfdyRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9095

> Subject: Re: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95
> SCMI Pinctrl
>=20
> On Fri, Apr 12, 2024 at 08:29:26AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 SCMI Pinctrl uses OEM specific units, so add '$ref' to
> > '/schemas/pinctrl/nxp,imx95-pinctrl.yaml' and an example.
>=20
> where 'example'?

I was thinking to add the whole example including pinctrl/bbm/misc
using a separate patch after all the vendor stuff got accepted.

Thanks,
Peng.

>=20
> Frank
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index e9d3f043c4ed..ebc6c083b538 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -249,9 +249,11 @@ properties:
> >
> >    protocol@19:
> >      type: object
> > -    allOf:
> > -      - $ref: '#/$defs/protocol-node'
> > -      - $ref: /schemas/pinctrl/pinctrl.yaml
> > +    anyOf:
> > +      - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
> > +      - allOf:
> > +          - $ref: '#/$defs/protocol-node'
> > +          - $ref: /schemas/pinctrl/pinctrl.yaml
> >
> >      unevaluatedProperties: false
> >
> >
> > --
> > 2.37.1
> >

