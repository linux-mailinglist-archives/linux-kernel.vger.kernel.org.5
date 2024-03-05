Return-Path: <linux-kernel+bounces-91643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A779C871495
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9B11C21D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5F3D0B5;
	Tue,  5 Mar 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWsZmlXY"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E79611A;
	Tue,  5 Mar 2024 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612021; cv=fail; b=PgI42hVPOlEXCBZdcicBgIHycUDuwaWg23c1oODeu5gH+IwEUuG+mGFbX1PAI1rDTPDLFL/fdTmyQ8wVwDZKsw6Ou2cZqyPLe/710mVWm3qi82AdxIjprdljHZZ0ZRQnGBEDySga3F0DfmLYdv7h8NgGfhrD6/PDJD2arG9Njys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612021; c=relaxed/simple;
	bh=+RFF8zLVsmJuI8qRr02gtkZ3FGtFsuv/v5Jhwnj2Dxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFZ4q/DzZWrttiJfyw2zIGz9lBsE323LXP70CWiHNeXcoBm5USirVz7ILk1k0yTXc2Kkj/aoXf7++VHIGUNaGESgSX5IgnS7acxj4wmrrOosMHUhhOEyGBo92mOee8gTrN3YV0/An0hQkeCysDRC5E4wKke7k6X5OtqllK//pY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWsZmlXY; arc=fail smtp.client-ip=40.107.104.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+75Y/BjC+3mMkFqdd3843z7EbGTR0n47+uyNoPS83HM0r8c3ACjNxxht859EcJfY4gkUVTatR8o9sn0BF+VKvuyQTqOdq4Psv20yTDg4zzATxvEcCfNmpRjLMZMKhNU6OB8QraJPXXki/Gi0t14Y0xjbROiqlECI2i5N8ycRwTjq8CDeHeLV0d5vwfbITSLfEzsmnJrSCuBVcULwu7kzt23qtB6DEl/sTz6u+jmA3ErMh0cOfPkzq2CO0jtuArzd3UrtZuzjrexI6Ow/uVt3JcjWd4giiUX3J7W1fy9nYa8pwNQOlibPFVzzyUMblHRlAz4gIfphi+vo9F/lgMJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaG4+gr8E0iFLEWC7rhq17pE0dKIZb7sT65KlJfTZwY=;
 b=lzGllAFt5jfJGashEtrl7hykqhch87OEobAxJmP+iYJ9+/ZyhRa1qN7S53Ryi6i+Foe3DSXachwXjkqRYFQGNPpTVSKoJhdjRFfYTDAjVa8Sd3yoy/lyBMp0e2+P24Du8IXokm82u/ABap+LWxQhyltiPoS6drTDlsGZE7vvk0TRHEy1I3lKsbreZ5+MtE/7le3l1wzqqTvXdfxjcw0jsrscVipvK7YgFESL0eaI8wLq4e424+OOdcLmnBJ9UqKoSij37/lmYFhFzQ+zupeGzheC4cMAWCdKc0NM0yeuAjym9m9o3Aky6mCe36K0s6TbcerEJ6Dr/Qgn1FR14VG0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaG4+gr8E0iFLEWC7rhq17pE0dKIZb7sT65KlJfTZwY=;
 b=LWsZmlXYDOpLcEf4aJfaKAP1RoMrdE3oVZT2ocRIuHC/W3QwxYu5H7TD330GTF2Hy9024c1Bq/uqBF3i0yJYenwZTLVxrXaBgzJKB5nDwBGenzK3VckxV9Fw750c0MP52PseMS69njcfD061MPOUmqaWjbvd8X91T2RTiJNHJJA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 04:13:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 04:13:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Topic: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Index: AQHaahlgOv6evYTjhE2qVPUINi25/rEnr0QAgADi1dA=
Date: Tue, 5 Mar 2024 04:13:34 +0000
Message-ID:
 <DU0PR04MB941740A36E953A0E1AD690EC88222@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
 <20240228-imx95-blk-ctl-v3-1-40ceba01a211@nxp.com>
 <20240304143916.GA181628-robh@kernel.org>
In-Reply-To: <20240304143916.GA181628-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9257:EE_
x-ms-office365-filtering-correlation-id: fc8c93f8-8407-4d1b-abe6-08dc3ccaa041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qhIvNUyQcT8RNdzZrlFhG5aig4g6D4JsTYGEtHjSmW65J/XcJgqOa5tYQkaRhY90uJK0U1v8gNtI0ms/rGLAHuB1vRw1J/KbRNWl6kGvfTF2lLBeAfUfXRgTcuBmD00ZAVOVr7q9DWTQhztnhapxRnZA0/cajwRgj97/yD9ON2L0VtI+zqSW/bcaywMrjpcmvJ83DNzY+tqOb/Kgl21bNRedsx2HQuVSeAP9Phks92tMLBOQPo3iTMfgxrJlkVk50XHkYkkro1UEREqe/RxXqp8o/ds/YwZrXdsJB1gn4oA6zGllYfZr7qjk0qaLHDWim6SD/S+hd/Fdql0AQz/u3Ex3aayfAFcHiN3RHMGLimhoiWXPsGJazrXuh5XY6dcZDsdvQWOOLYMwAGUnzQXkFIW8ciKvOVbVOfiYsDGMa6KHxPTEElNJHCuAkoErlmliuqqtgvktI9o169EseXCMNwDkAx/t3sUwt7m0ywakaUa40gVVzzp4blBWV2wZbok2BN5I7JpVr2J48o+TkQ35ZgnrecmvNgSTpSaDTMamh2I6158YxlZTBFGMKDlfhMz0E/dphFvix0Ni3N/WGrqxGvgua4VHQLdfimdv97mbhFlHpWZPDneUFdUEunjvOU/KPS6kp4bm8nWUNVd6QijzzYtuRiBS6SUcwSEu+xt3Z5ywm8LAL3v5jMVGm/qostlJHYoYQEhWGpeDi0+S2d5IDg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LKKcViamiXc+COBKlAn3bwTiAaTiRq9WXL2fgZK6EC9yzVk4pJbsLEbvl/mG?=
 =?us-ascii?Q?TYMSQUoMUvyBfcB82wghkSi5OD9iIB+rqgvymetPs2aQIbeTiwsxRfPdTlFJ?=
 =?us-ascii?Q?GXyxP2N3kFc8QNcEq4nL8UO1MqE0PCAk22/Yl189KCXg/O5Snu+r3JYJicSt?=
 =?us-ascii?Q?tyJTQA5KSYSi+I9/J87J2ldfuXLqWZuDIg9/XQyN4oXa1TjLwfsed+WdQwEl?=
 =?us-ascii?Q?Pw/h/7l9Gt2JcieXtfE2rZoucegFuEtelD0RpL4kgm8g9ETIi1g6ooML1U0o?=
 =?us-ascii?Q?g3L5ZJRGxLOkvA+YByqXRdoaeFZgawqHolxD+BDPwW3fyGwyLBAtm4DJkUrk?=
 =?us-ascii?Q?gL3SKfEkcqNjFy3NMFcvT2B0mAJ6yoYKKdPnmLdasBIbM2/epYWXit/tPvNe?=
 =?us-ascii?Q?8XV7m1qfpPNe0G8GJTBfrm3gelLqAdJ6P+IRORV1gNYB8jFRNoinGzgZxnac?=
 =?us-ascii?Q?6zzI3kpTaqD8CeIyoToFCuTBZ5qiIrS7Hlnnp5qFrQXapuqyZhaCScY+2rVB?=
 =?us-ascii?Q?0m56wGBiY0sw9qES2mg4AqAj69oroh6zpG38TxIclMrEo7pG0WFC0vKuoCMp?=
 =?us-ascii?Q?7zzTLW/N4O5L8cs8A7Zu6JPDMdj9Fl+4e7vyMAxPCuvH66Ver67iqdJwgcde?=
 =?us-ascii?Q?iyDjZqXHyM/32q+2/qiBAYcqXLXBqI+LUBw68c5rXuVwahTvmBRvAV9ALoNk?=
 =?us-ascii?Q?ue3YnkeOiAKkqEpuClmZnwG+YZXdMbQ+92NcHCxaZcgQ8dJ7LixLxXfVxqtk?=
 =?us-ascii?Q?m1X9I2nlh9o0keapTlvG+qp1z8PnxHlYEnu6NVD/i2uOigykKiKc6gtnpTQF?=
 =?us-ascii?Q?sPCJ7ed8Q8kZr3Y0+cNUMdkDCWkhEaSoORrRNGFDZrN7VNAQlhACdJIA08Io?=
 =?us-ascii?Q?VedM8dW7zFbkQt9shrlzYraDSxPI+JdFv017ep+PZSWtMMWFwXoKlz94kKuC?=
 =?us-ascii?Q?ueXoxVWv3eOVereFc4IMHjScIQpZ8rzNqfU9gFBo8Ydz3EzDmwfJEHWe1Nyr?=
 =?us-ascii?Q?bV6dT9bJQgjkCBnd5NOL3H5pu/6Fp7xinM2wHbomF6r5Y2kDkR018h0cQuLG?=
 =?us-ascii?Q?DIl+ZwINSGVkWmbUac6GxCYV+cSXKrsH+Ke5k/kA4JjK0QwvR/6QnMt4E9kq?=
 =?us-ascii?Q?Kxmpw+xkGgWMxl6xM7vbVgIDtXBJDeiFNDUf+zN6sit9MIF3I9OMDZA8yOOC?=
 =?us-ascii?Q?C+QMx19wSRlm2VaCt5ER71MzQW27Zc3DSsbVRHw2KYUd1+TV+km2QKpKSHf0?=
 =?us-ascii?Q?lSpjmBJpYqlom8OKQV9EeGl6SbsrXgqLIjlZegIHlVW859GAkzYl+NslZnBv?=
 =?us-ascii?Q?sypjEA98g4xs9XfDCzFNDs0EPq5bJmudhh7aeqFFjirKW6ceFv5G7k3lxzpO?=
 =?us-ascii?Q?lxLeX5tDc+7oVRZNNv9W4zdRVLxOffBIpqCh7bZ0gcg+upJCQsr51tYBaOj+?=
 =?us-ascii?Q?C03f2H6XAW3rqz2qFErJaG5Gv74zVS2Q+ZczkbRlYDO53+bZA+FSXW+vr9d4?=
 =?us-ascii?Q?ePkoZ36RpJLxmG3tUWbeh+3sZnxErQty4zN6zR63GzTt7kYL9uGJ2ttPYBj6?=
 =?us-ascii?Q?mqtMnug5Ye2mL0+R2aU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8c93f8-8407-4d1b-abe6-08dc3ccaa041
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 04:13:34.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6ItpOfawJhum55eKZBVdlW9146fgSmACIqTMUaDb6WDy4HBo8Tom53EJYF9oF8zNVXPgt4iPhECiw8Iv03r+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257

org; linux-kernel@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>
> Subject: Re: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK C=
TL
> module
>=20
> On Wed, Feb 28, 2024 at 03:48:22PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
> > VPUMIX, BLK_CTRL_NETCMIX in NETCMIX, CAMERA_CSR in CAMERAMIX
> and etc.
> >
> > The BLK CTL module is used for various settings of a specific MIX,
> > such as clock, QoS and etc.
> >
> > This patch is to add some BLK CTL modules that has clock features.
>=20
> This sentence doesn't add anything you haven't already said.

Will drop it.
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/clock/imx95-blk-ctl.yaml   | 61
> ++++++++++++++++++++++
> >  include/dt-bindings/clock/nxp,imx95-clock.h        | 32 ++++++++++++
> >  2 files changed, 93 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
> > b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
> > new file mode 100644
> > index 000000000000..c8974b927bee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/imx95-blk-ctl.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fclock%2Fimx95-blk-
> ctl.yaml%23&data=3D05%7C02%7Cp
> >
> +eng.fan%40nxp.com%7Cd0a6445fb5604872ec3a08dc3c58e0e9%7C686ea1
> d3bc2b4c
> >
> +6fa92cd99c5c301635%7C0%7C0%7C638451599621992781%7CUnknown%
> 7CTWFpbGZsb
> >
> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D
> >
> +%7C0%7C%7C%7C&sdata=3DDJA1dYKc3f9Q5S%2Fa20O%2BJWgQU%2FsMiskY
> RIykKzCRUok
> > +%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7Cd0a6445fb5604872ec3a08dc3c58e0e9%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638451599622001649%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3DRvMgj7vtwJ3WMYsD3gEO9U8ZI2fRsPy6WVYhCOJ0EfI%3D&reserv
> ed=3D0
> > +
> > +title: NXP i.MX95 Block Control
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - nxp,imx95-cameramix-csr
> > +          - nxp,imx95-display-master-csr
> > +          - nxp,imx95-dispmix-lvds-csr
> > +          - nxp,imx95-dispmix-csr
> > +          - nxp,imx95-netcmix-blk-ctrl
> > +          - nxp,imx95-vpumix-csr
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +    description:
> > +      The clock consumer should specify the desired clock by having th=
e
> clock
> > +      ID in its "clocks" phandle cell. See
> > +      include/dt-bindings/clock/nxp,imx95-clock.h
> > +
> > +  mux-controller:
> > +    type: object
> > +    $ref: /schemas/mux/reg-mux.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # Clock Control Module node:
> > +  - |
> > +    #include <dt-bindings/clock/nxp,imx95-clock.h>
> > +
> > +    syscon@4c410000 {
>=20
> clock-controller@...

But this is a syscon, using clock-controller will trigger dt
check warning.
>=20
> As that is the main feature/function.
>=20
> > +      compatible =3D "nxp,imx95-vpumix-csr", "syscon";
> > +      reg =3D <0x4c410000 0x10000>;
> > +      #clock-cells =3D <1>;
>=20
> Please make the example as full as possible. For example, add mux-control=
ler
> node. Do some of the blocks not have mux ctrl?

Yes. The blk ctrl is not just for clock, some registers has mux ctrl,
such as Pixel_link_sel.

Thanks,
Peng.


