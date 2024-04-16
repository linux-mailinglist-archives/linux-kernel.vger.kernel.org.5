Return-Path: <linux-kernel+bounces-146914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594018A6CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101C22855A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188012CD8B;
	Tue, 16 Apr 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dc9YPY0a"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80D12C534;
	Tue, 16 Apr 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275543; cv=fail; b=h+90jUo8rdDJ1UCnaC5hVIqd6V0YOVZY/AFeGOiwG3T3J6Ciq868B4hKG+UbUhswsVRSeip1XX+l4wz9/5IE1zxBDRy+dG0WjuSBprMotta2Mpmv2J/G67odSPSVf5aoaOuHoBZJjcULzYYGPj3829PG/Cg5f1sP0SNne5efDcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275543; c=relaxed/simple;
	bh=qjkDPeaaPYfDDMFnH5O2X0v1mclZEHVyaPAMonTTAO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOPPMWfey+479hs5oYLBdVHlGunv+TmvmCfrdW9b5MGBM0LMmkOUX3GMbpY50yrM79iQeBmkNcReexdyEdU9nSiAH7vZf6M0Quf9c63ILb6nNzsYPPvKBLd7+CGMZhoece7vRs5VDPfUiuVriTy0z22g36drJqCdGL5HIMOleBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dc9YPY0a; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4cm/7VUvAtkQw2Nsf7tXTXYcb8u6LYu0cxi+UlPGqHfRqIz4wDlvrwNBrQMFBBmrZc6XAx4BW7vRS40JRt7hvqVTgjwdH0a9UplbEyxv7kLD3nyZeg0sxhbft1x9aFnMdSjp5aGw1PZiZDeZadQOKijNwI6kZwGLzTPxIlTj53P+1UKoqHu2ob8qLsf5IhPeQv4HkWGbEEfMFWGrSPcqS59oa00NiVd8qhsVZMiDJ3N+tHJq4zaalzaAW1Q/2fhcNGg+r0vrH5vMyOXBD1BvfR4CSbHTK6BlDdVo6jkhr9wvJDnKv/F1/s7TpKXJnEeyketpXZ6QOgWuTunijTB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhLIgztNbwtF1+NerSfW11EUh3nH2rXcl5kHZ6gKj6s=;
 b=UFYDgw/JVh5wqoetqtTO4EXr9PwBjqtF56B4EsACCrfxQU00saL+o+k5eMmIkkyPh0XQ2c5l4uPvocce/ypKfPxARAdsI1Rw3sh+KpndaIkT69JvGFKKIZKkt/aXh34zSNHweUcerI9kFjYpzrdd0zeVZAzXk1iXYePKryZZnVAlqx7W7EV1AD99n/f3KyO7rVmBeOKVCHpRpBV3WMYbznkAQtfU3PuUTPICprinp/lwdwfUqiLZkYNqMKRti/ueinoRll6XeJZkrkh7+RsmINHQFLdDLX0tp3jSjk4CqM3nyQew6tMRQsHuo3D35ZOcTbEp51eMncwPRLZnv4vk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhLIgztNbwtF1+NerSfW11EUh3nH2rXcl5kHZ6gKj6s=;
 b=dc9YPY0abTHZuTKOrCYCZ9tZP+xG9dMls3mLO/pnK/sonm7EKELRef3/IflQA9UUc+6i7n0EVxv5orLgUL4Z0+5ZAH3NeGv0tEe9t4DaEaQMpJP49t6GpZ4k0+imIVXFEwn1rD2gmjn14V7+I6DUDEl5af2i9V2B6A5XBoO4aMg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6942.eurprd04.prod.outlook.com (2603:10a6:803:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 13:52:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 13:52:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Conor Dooley <conor@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Clark
 Wang <xiaoning.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells
 property
Thread-Topic: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells
 property
Thread-Index: AQHajx+kgtAO4dwFyE2ikpRkMhstB7FpehEAgAFyDMA=
Date: Tue, 16 Apr 2024 13:52:18 +0000
Message-ID:
 <DU0PR04MB94173B23CBB11E8DC736E90788082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
 <20240415-limes-chasing-dbc111fa9cf2@spud>
In-Reply-To: <20240415-limes-chasing-dbc111fa9cf2@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6942:EE_
x-ms-office365-filtering-correlation-id: 086f99a8-1c97-4783-ead0-08dc5e1c6e75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZHELb//xHdipugEH0ZeWr9HA7e3yaLkva+yQDnse6HCeQbdP83zNQbT7MVAKD9/iIIITg04q42oi4x09gWTBQN1HcozXbTc7VldgqDGG4ilH9u6CPK7v8oTdvJUMCiz0fixxvRqA77dvG8wAY2QpW+MQlNohtqTo94nkUJnpJGH6+AWenztoJ5Ker3tE+DDqIU+XocmEuBRC1Uj1QMW4Q5flpzTpEroTdDVuk8sqFPpjluKh/yWtIMlsKPobHQlk5yHmI8y01Viv0MsUq16fshZ4yfxT1Kwgn0GHDjL7VwZScedwFnmMFdN9GN+bzFwlOnDgOOZX7YJKqJ1qqV5DX8xQED2MrdD+J7uCTJK0Ptn6PD5z/Fe64P5aAMkFcxzJhmvmwbmJ2DKsS8uQMDsjXh6a5iLL6KWG/0W+NPwgUFC7yWwqEYpYAqNu5LBvjnzY6fXhS6RgZZDywJUlZlRW0t1CyZ9jHhQG5UQWqSyyoTilvVueIdcNxiS9z/U5ZRAEFTp4t479Q7Vli34o83OAuL6MqK13iwNxbzFtcx0IdtuqAus35eSIP6eGLD4rut5t15IcvwIzmIjq4O+jKlmXGHViABKhK4MlsGAYaz5IB9cUZuX7P9gdn/KFXklaTVs7lvTma9HNH+zBLcxCGM+7mdlRuzTwIUWGXrka6OJPMu7o+N/d5uFOAWhELQj3TaIk8INuH8zt5jmeFtj6Gnq/jpFEVYjoqPiz4iX75JvZ6Ok=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Um0zY9Fa8/RsOJ6X3W2I+MjtbwHqmad1DtH4DRRDw66IETQmjiHLOraueAlN?=
 =?us-ascii?Q?fDa+u85FeqoappQkpIXSoldOGyq0rbhhue+i4n8jy7ChsebP3BDHpeLzfhRz?=
 =?us-ascii?Q?85JH+5BF8BFTQw6vVHZg8RfK/aZ1OUo9LMMnnX25aWZimAmkTmp9B8PSOKR4?=
 =?us-ascii?Q?ZmAR2g7GMIjUEQS3g8ga4fg6LXSMEvCGxn7GH99ndSACujO5FCxr0gWJDKIK?=
 =?us-ascii?Q?BL8u6zK5a8TBEyeWj3h03LZa06+gASYUTrrnP4on3JeqtVo3YF8d1pNKUKON?=
 =?us-ascii?Q?DUbYP7sa4GOmJiZVzS50otAhnT1BCh2QjurYeyBksFcVlI6JwtPoRb8OK6IQ?=
 =?us-ascii?Q?v6SGi6mUslQXMwpd9bfi+Pp4tqN6FUEOL6092jjkh6Z5I7zVuUgBstyoMwWL?=
 =?us-ascii?Q?rx+cuyzms+oFsIPb3aX2Stq71DUOYkbr3oylpaGTHI0ALdn+wGkEr2qNlt0N?=
 =?us-ascii?Q?j7aNmXBkTIbjw6nuf1M1PSuCBX6HivM0esrxI5StU8Xcs1/P5bfVWMfRmcY5?=
 =?us-ascii?Q?p1UMOFWvz9Do+Mr5SXQXeSM/jagGxV/Wrczbms2lgMdnUOWlw6sY2sorbguq?=
 =?us-ascii?Q?c7AUQvtJFd4Jnc1xr8odliv/xPl4sl5lgOXopLKl7UA8MKZNZrpOuM/ruQG8?=
 =?us-ascii?Q?98fW33ONMh0e8Nijc9Qq2zOX7pJskaGHku7tPqpnnuX/CC5UQDrFwo5bAOvO?=
 =?us-ascii?Q?OukRV9kzkN040PA8AOCg/CPFzMsKlzKLVdwOKVia37rq/pCXdYrQn24j6EAU?=
 =?us-ascii?Q?+zZEu/W6vppPjhy8M1kDKR9KBY2FoXNEGSPbJ+93hXMPU2S9c0ZQWhxthddJ?=
 =?us-ascii?Q?KTgp8aLQO5Unl8acdW5c/ZJIbJdeRk1tu1SmX0Rg1zPSsYHgwmMElYh5sxy4?=
 =?us-ascii?Q?JUAA+WPamMQwO35WZU7n17LDhmtXHNKL61N1wOGIpl+FyO5VG7Hbr0MuSOMf?=
 =?us-ascii?Q?kv5uH3LKkwdC77wL7/0lZ+iyasx9jLwWYuV/x0Qk9arhJW5oOcShR5N4pa8R?=
 =?us-ascii?Q?SD6gVoNivUsbYoCozunjc5v3qIwMiThZhFcp6o+wguTLON6LwWdysTQ/jRTq?=
 =?us-ascii?Q?3LgLCoiLeU9sZf9+K2Eug3X/7aWjmQsBKcPnxg6U8EBsdSCugp6Dx/EWE8rX?=
 =?us-ascii?Q?IzfzFdq24OLDYWEMSAQkPWUaK4PIghjiRx70gpUq5ABukZLsc2VRbh5Agx/W?=
 =?us-ascii?Q?qucM25vgzvtuATCdfpdeCZOVj7f+aNV3rvoRRggFyu6vPK19euTpRZWEXXAt?=
 =?us-ascii?Q?u2XJrvX+6xpcxcevWSSZrHboJyDvCQgctCGH21RIbmBbnS+5TGB3b/OK4qqz?=
 =?us-ascii?Q?7ArJlk9JFvThezI5AAxyyS6FGNbWOFtGdXmDwDzJ05TtFcLI7vwV0YPKD1A5?=
 =?us-ascii?Q?FuhsFOHFbkSMHYEW7YGnik7G7INHdTL2vV+U1Ya3DRHy3Nz8ToLX3tTOkK3G?=
 =?us-ascii?Q?LG3Q9oQmtveMIYjiJaOUISJvkfF8BJqQVUVt6w8LTK3Ob2m8lGzrymuaeKxH?=
 =?us-ascii?Q?58HrItnKj0u5gnk6E4UhGr5vOFGKBdCGvTBLJTQ0k9RJEcU/+0RGXe6N6Ygv?=
 =?us-ascii?Q?fhp+rDyJfuB7Sa3DZWg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 086f99a8-1c97-4783-ead0-08dc5e1c6e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 13:52:18.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mo6X8GgDDTPk8NHiBBrwzuiLJ4qDgqQvda9MKwocvHUDLpIGwXtiBEb1GCAE0NaaTW3FpLm6iePotfcXQPAdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6942

> Subject: Re: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells
> property
>=20
> On Mon, Apr 15, 2024 at 06:36:21PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Allow nvmem-cells and nvmem-cell-names to get mac_address from onchip
> > fuse.
>=20
> Is this valid for all 3 devices in this binding?

Yes. It is valid for all the three devices.

Thanks,
Peng.
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> > b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> > index 4c01cae7c93a..87bc4416eadf 100644
> > --- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> > +++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
> > @@ -66,6 +66,10 @@ properties:
> >        Should be phandle/offset pair. The phandle to the syscon node wh=
ich
> >        encompases the GPR register, and the offset of the GPR register.
> >
> > +  nvmem-cells: true
> > +
> > +  nvmem-cell-names: true
> > +
> >    snps,rmii_refclk_ext:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:
> > --
> > 2.37.1
> >

