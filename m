Return-Path: <linux-kernel+bounces-145999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9B8A5E21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF701F22A00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2A158873;
	Mon, 15 Apr 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BcHH5c3j"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17811272B8;
	Mon, 15 Apr 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223048; cv=fail; b=dUlOr7W/gCniBJD32dD3SmzhqUoaq8/nCcihFLe1Wf9l++Q0KRnGSYmXjYq5nTh1J8i602y0PCIupKsQeech2P7+VNd8YcOmlbxOccLm7U0vkYh6oq4uhk4Hq4urlerZ/LLV+JfOs13nXKg3yEp6fxClnPt/YV3lDPpltiYZYbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223048; c=relaxed/simple;
	bh=9GGxT+Qd3O44G6ZVjCrGxxwo4Ib9zfB+yxxBBegOszA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FHu+hPkX9swgjobNTXPJo213KrjWbC0LccegdHAZvMoz8JVCyTjWw6cLJ3ny43v+pAWXBT3Jt266stzLdoF2KVv/ltMjEytSxOfzwzMCtwwpqVxB8a3EyhfXzmNQaTDlS+lMaiQQhibdPc8r2BM12mb7sgmIyqOVmY5GRs+Wwww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BcHH5c3j; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpRmzrMccXuy/TRLHhgD6EfzeiQHJ6QT9BCsBrRPEVEEGG/MpnL0CjMQZrblzcDwmVmXP9m9LcRo76rddzK8HdFq15g1SQ68tHCS6WWGGOSfHUBfWi8LG+ZWFGpDY0LsRJbv1BIkim7eQfvZ4jlru1wnfzc1To69iP8M2FciLfQEBt71SScn7dSwnK9kYAptkHYMTd2DhgqDbXS7RGd7D4UbS8TEWCh764HbjP+RwG1cHk85The9096Mv0dRGaKpYKDQHsZFhDkcGtX8UjqWeBtwew8+IkrfA6QUYOdB7IVb0toJVbSATceGZRME+KUJejuVfh99Z85V8WxzC0tE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaY8MMqc8QJGt+Qp/QPNjSAYiPp2Sqnb6wOKy66rJqY=;
 b=dlKPCbK8iy0yYRP3pzoM26hH9Y7OkXon75klvUOl+k473ZISCkwXOnUOdoIyAj/GNehI5/NX4JEtm3Sl+USepE0eMtpoOH+FjJt/3iezHtCwUWGy++jIOPy5xKi/FcBg0bVC5r6tJXJFVDsr7JVRb2maO15ZyeQO3JMQbOt1R6BvJnrgF+TAALftS9V0BvVN0AAC9TZTyqB4on2cgMtiDekj7P60VqRLmol+27ZL/GNqxbgK6ew29HDoRTHdAHAU/xSKQZfpvVhay5RAOBiBJ7zIcxOhOFYwH9lLNVdB7VVckLc85r/NjmzwyWBLNc1+yGAGntnNgDzAuTWyWjlexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaY8MMqc8QJGt+Qp/QPNjSAYiPp2Sqnb6wOKy66rJqY=;
 b=BcHH5c3jDc+ALLPXRY8lOLJUAKDzuyXPy4iPTKlTVxkrj1HKA7scZXN1IO3GpzpRzK1savlu99Wms9DOtH16m2/M0vzVbbPU3NELxY9cWGiFU/5SGCzCfGvI5qSNiQhc7vRvGx8mfnX2ZVt8KJEwmrsoVdEGQrE0EGAwT1+AbrA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8918.eurprd04.prod.outlook.com (2603:10a6:10:2e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:17:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 23:17:23 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
Thread-Topic: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
Thread-Index: AQHajG9cdUkQ2lgZgUStYTjvuii937Fp9agAgAAFLsA=
Date: Mon, 15 Apr 2024 23:17:23 +0000
Message-ID:
 <DU0PR04MB94174F4B34DB446A951CDBFC88092@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-1-704f242544c1@nxp.com>
 <20240415225008.GA215835-robh@kernel.org>
In-Reply-To: <20240415225008.GA215835-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8918:EE_
x-ms-office365-filtering-correlation-id: dac86816-eee1-4936-0408-08dc5da234c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MKTiiYkgEFv/Tsv4M5R7Re/+HX5xoUE/Y8itnU5MRuHG+9K8si4RAerk6zR5NLRK7YQzAgbSLIGhnoCq6LkGYW34cKWyqXol2a/YtNo+VUBYbtNJKY0hse+O/1fkJK00wJ/hx+qu8GXZaEv/0NWHnP7m2+U0wdMIWMLS/1rC4WkM/dtWYfZtLq1VtAyCHqP1tvFS/LkLIyttWC+RYGNtVual9rCDWb0Gz7Xzr9wYWV7izy6tDdWtodudsvqJOjC0ZNFgBbWa/35VdMN4szapiIRFKA7XzbjGfnIasme7zX6JFN7NVsnb3ZobhOvkbjvLmbD5Zua/dsXIjzObzwvafXiFJ2mxXZ4ICqy9HoO6+cnlHqdgPgL2jDxbJYXY29OPFtVQ91KPnTFEY75UTVGmdP2diL9+dfAQCnr5OJIu3dDxO2pj2vvWZPupWaeBDQS0oo7i4vVzf/s3V6hVfWAHT0pQS4ZaHfUz5rqw6cJMl06SvclHogccLBw58JrDj0nMPL5SnfppHYo8gpfsg/Z1uizfMAvap90POybPdV3l4ILnFj+enF3sfvqqX0XbRiamevlmHnQXuxbxhWeairfW2LYuU5JDuDkEmUcWcxteBkGzGVtiTRqast3UlTJloEi4T2nKOsjTpfV3r2dv6MRsQboMo2SbePS5pTSWEaVG06J7z3wgsh50l7nx5kTJEuyydUuvqNoh9ZpfBMLT2mk5MA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+xQvLD0Y1KNIMCftvOZPauQNrFsig/pQdXCt0BJwbioZshULMHRqTA5WeYTG?=
 =?us-ascii?Q?MmH/4L0iO4hfgC0x42mJJoQs4IrFBMphOlc+4oRhFClyv+sz1YBEcYy24FNG?=
 =?us-ascii?Q?mW2GRLK0kLOeZ7ActVNaXUTV6rzdNf6CfXlblCZ1vg67a2hCsh7xuWIb0Be6?=
 =?us-ascii?Q?4wd2bB08AHw8gU1tv4vikk7AXFrzNaNauz4/iovPYHP/FQME1eX6Q42Zeddu?=
 =?us-ascii?Q?tv2E9FyFELtwFULthOMAOfi6RjCP6hA63GeY4cLEVWC82XYE1ALTpCRtCrG1?=
 =?us-ascii?Q?ntXYic7EGvrVzuikzWkg2ovSylCUrwzCtPZTiwNbVylLJsauDChIU9jPh8QX?=
 =?us-ascii?Q?PUYBtNxLyf3Cj0cGOgLOEhILVy1KbSyssst3lFXBv3kbOWR/m22jMzR/ymac?=
 =?us-ascii?Q?MQ7ov5A7W5CSb01QCJ/qRsPKzakxzo5XBH6DtAl1wtWIbp54z8PFM2vDU4YH?=
 =?us-ascii?Q?D3fMUod5Bviz08iXUOy+omIil5iM0kd5o0fjs5Hq/gAw2UOwFDYTpjbDzAjP?=
 =?us-ascii?Q?QnvqAnXEvWV3XtGlkhXXGQMa07hM2CD6H4mJhiAxGLMKP7On3coCJCkkL2yG?=
 =?us-ascii?Q?O0dMW+XB2i6l/PLo24flzW+QeIR/wjtupnagXyebdf2tTrtQPlmvUefnldgE?=
 =?us-ascii?Q?Cw6d7M5WLqjD0drT27AeZeYqGaE+pwvV/pc7eo7M1QetUJ67aYDxyv5HqNvk?=
 =?us-ascii?Q?edfUDOHpf1Dt/Pvcoz4faRXiuDRdT732jmzJOc9LWN1pAgisz7T/dH9XDhz+?=
 =?us-ascii?Q?6PPbxSChdzIn9j6ozZ/m1+nuIacGxpAdWQLNEETCl+Ip3LYkC9F67h0aLNfK?=
 =?us-ascii?Q?2CyF+Ymy29nXRyjkBWHRCIdB0zVX2AqDG8zHbc83G2bswrsNBrGvv45x0g8n?=
 =?us-ascii?Q?gqBa8Lwp2SJj/VMIR1qB3HyloyZi9bamSAn0PeJHVsmjlRiaBCnCdFYAscEU?=
 =?us-ascii?Q?29ID7hLQCR/Eay30BQwb9yNphB3QvQy+5yPYchPH193QCSpg91HUjqDW1OeI?=
 =?us-ascii?Q?62ekpO/m43lW0laJJChsc9mfmOu8ZYmp3UgQJvBVgiXQ1/rqlnwc7tBaIx8h?=
 =?us-ascii?Q?J8wwu165VGtIhNKUHMQIAeHnVZ3C1wX+/ifgwZ3bgvwTN5HTGV/cjNwf8VZC?=
 =?us-ascii?Q?p5VWKDh05duUJuQYPKJnwb3F/7ufTnFsFgdDSgfr7mr1zJbDsJFoEhWjNci8?=
 =?us-ascii?Q?Lq7n7amaUnp+otJ33OfJfor0dry/j88V+pnP6EUiAcruksXSJ6Htbcpo5PiT?=
 =?us-ascii?Q?2f4i4/tJunlWsOODa61TemDzmMjE6vxt9Rt7StGp8KBSpmklezSrC76vRHvJ?=
 =?us-ascii?Q?Mn+6lZkD9kBJaqU9YTh21kYKk5s2wxQU0nnkMr/0xj3AneYgSgg/2CUGLhyG?=
 =?us-ascii?Q?+sWKtVYYQZzK1wgO8gY5PwM4CB8UNUnE3c++8C0O9i9iWtDwgGi5hs7GkwWO?=
 =?us-ascii?Q?IYzILDClgCpsK5taju/jT9QmEchtlsr6CTZI4wf6eobw6bukqYipzyB07ZAN?=
 =?us-ascii?Q?m9XYKRysT+zs2/fducjsJDYc46M/VcFptD5mXtr8WzbIhzHhiw9VJLXbtqZI?=
 =?us-ascii?Q?R3MTgH8+1x24Sb/Of2s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dac86816-eee1-4936-0408-08dc5da234c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 23:17:23.1314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNMxBYV280pydP4oHPiAOa9HVmKqF6eF92CN0OQVW2iDaXz9cQu8H1iWuxRlVU0SbN77UTjQf7aqgH5FFHIWRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8918

Hi Rob,

> Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctr=
l
>=20
> On Fri, Apr 12, 2024 at 08:29:25AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
> > patch is to add i.MX95 Pinctrl OEM extensions properties.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/pinctrl/nxp,imx95-pinctrl.yaml        | 44
> ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
> > b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..4bf7a6192813
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2024
> > +NXP %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fpinctrl%2Fnxp%2Cimx95-
> pinctrl.yaml%23&data=3D05%
> >
> +7C02%7Cpeng.fan%40nxp.com%7C4c448715c4ad4cd1f70808dc5d9e6924%
> 7C686ea1
> >
> +d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638488182142511691%7CU
> nknown%7CT
> >
> +WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVC
> >
> +I6Mn0%3D%7C0%7C%7C%7C&sdata=3DBckWIcVgYU6l8lV6fIpyDIZHt5hCyFdgF
> xaWBUBb9
> > +7s%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7C4c448715c4ad4cd1f70808dc5d9e6924%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638488182142522802%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3D1BJASfju905Rua9G2mkNvPKDppN9%2BP5UaxFCbXDtPqo%3D&res
> erved=3D0
> > +
> > +title: i.MX System Control and Management Interface (SCMI) Pinctrl
> > +Protocol
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@arm.com>
> > +
> > +patternProperties:
> > +  '-pins$': false
>=20
> Why?

The node will be as blow, there is no
"-pins$".

+&scmi_iomuxc {                                                            =
                        =20
+       pinctrl_uart1: uart1grp {                                          =
                        =20
+               txd {                                                      =
                        =20
+                       pins =3D "uart1txd";                               =
                          =20
+                       nxp,func-id =3D <0>;                               =
                          =20
+                       nxp,pin-conf =3D <0x31e>;                          =
                          =20
+               };                                                         =
                        =20
+               rxd {                                                      =
                        =20
+                       pins =3D "uart1rxd";                               =
                          =20
+                       nxp,func-id =3D <0>;                               =
                          =20
+                       nxp,pin-conf =3D <0x31e>;                          =
                          =20
+               };                                                         =
                        =20
+       };
>=20
> > +  'grp$':
> > +    type: object
>=20
> Missing 'additionalProperties: false'

Fix in v2.

>=20
> > +
> > +    properties:
> > +      $nodename:
> > +        pattern: "^[0-9a-f]+$"
>=20
> Drop. That has no effect. You just defined the nodename above.

This is to define a subnode, as just listed above, "txd" and "rxd".

>=20
> > +
> > +      pins:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description: name of the pin
>=20
> Needs to define the possible values.

There will be hundreds of pins, I need to list them all here?

>=20
> > +
> > +      nxp,func-id:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: high impedance mode ("third-state", "floating")
>=20
> We already have a standard property for high impendance. You should know
> that since you obviously copied the description...

My bad. Fix in v2.

>=20
> > +
> > +      nxp,pin-conf:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: latch weakly
>=20
> Same here.

Fix in v2.

>=20
> > +
> > +      nxp,daisy-id:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: pull up the pin. Takes as optional argument on ha=
rdware
> > +          supporting it the pull strength in Ohm.
>=20
> And here...

Fix in v2.

>=20
> > +
> > +      nxp,daisy-conf:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: pull down the pin. Takes as optional argument on
> hardware
> > +          supporting it the pull strength in Ohm.
>=20
> And here...

Fix in v2.

Thanks,
Peng.
>=20
> > +
> > +additionalProperties: true
> >
> > --
> > 2.37.1
> >

