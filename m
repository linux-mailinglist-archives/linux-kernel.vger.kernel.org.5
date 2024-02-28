Return-Path: <linux-kernel+bounces-84636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC75186A953
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818EA28A1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815442561B;
	Wed, 28 Feb 2024 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="asVjiphB"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56325601;
	Wed, 28 Feb 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106862; cv=fail; b=Z5MM9a4J9rt9X8HRyDhI2iejClC/dApThxlf+Ea1/iI6h851j/A7e8gzRF0Gn1FfVxnfvnUbD3uPIWhWxdtuacg2eS/nWhyyeRrFAtzU7M4qKVNqemzoeJ95NKmEmCkPaJSw0gmejECNko8CuUhMAFLEjRJkDxNajRhUbVyWNF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106862; c=relaxed/simple;
	bh=7T4oqUF6i9Q/x9MdnygCOLI1NTHWA2oSpbU3WGltD8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjMfs1SiNkwgPG+lqAstibjbzcqm/N/e9KG4WbUIlyur9lV9H+NO0SPn3TT9rVv80+ytgMaqhtu1IUYsguki7ug+tldWdyJ9zkKepRV5vfkMyhe+Nb2gw3IJUSGDNmTg2wa1ZfvJJiHHozWXOA/XkAhur8y9rs8/mZyWxGDYHQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=asVjiphB; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOkjrpRXMkijFFa9j6SIA0C1m7c2Tuf+pGaNNIRgLVXxKbsVsFOd5TNqvuT4W1t4zHXzWJuLHzIs1zFRb7FXU/X+hu9Yob63cgmhAfx+kzQAqKjDvrmAa7rlzuoRTeXIZc6gXBXIcZlSiiMol5UpAdzZLyJcp+wh91O9wkccztwtmR4AoW+2z1li7/8/maiQat/Mqsv6k53+kWW22Edun+m7vXJWI0EwZG5swsyDHb62iyQsdFqQYtSgnsE8NBPXlgPMIk0phuDs+XOBZmP/58x04EpGR2X+ZjSTivJcfEbnkfieMn7b2Pqno46wmY1cqy4BnDOnGUw6wCO8B/pNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5mGuGUOJgJVRcrl/TpyMvYc/kkL4gVcx1B8zsnbbkQ=;
 b=lOQS2exuLPHvmPo3WG1iHRN2UrDmoTSedcbJm93o1a9FllNbAAHFqg4puHIRypfxFowDQJw5LiEPYOArgXH49JwHirHnljfHsEXt/fKyxio5cAbKAb+I/UzJQJ659pNdqfD1+3H++4nzOpZ++59kpiA3j7bkZKhGLOdevJzqStO368P4Lvm6zQ+hU0YJcxGys+2r9HqmIXsNHiyXleootNCsqTrVQPerleqlLCHou11s3Yx3jJQGU4l4K1lKq7Gn8MERlU5drY8LQc0xAYEbAPlzuv10zgTdy8giMJkXnDOLiLdtxTk/Mtvntof6KgrrabfZjX630S1yTxeA3PElMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5mGuGUOJgJVRcrl/TpyMvYc/kkL4gVcx1B8zsnbbkQ=;
 b=asVjiphBpbIrJcdBEzE7sl02Q/rdt2qbvUV8p5AJ++JAu6P5u2rXY+NWxW4ISLHJsxdWxwOzVkSYPGwjRFTGdN16I/HmxOtd831hl0Y9rBoGxg5+9Js+mbs34iniToP6Z9ycSgc9FQzajBzikhfWXRL95LtJsrCp0BOTR7T2Y/Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9885.eurprd04.prod.outlook.com (2603:10a6:102:391::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 07:54:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 07:54:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Topic: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Index: AQHaagfdonzElS9QB0ar9CNUieP0DLEfYCWAgAABgsA=
Date: Wed, 28 Feb 2024 07:54:17 +0000
Message-ID:
 <DU0PR04MB9417459448EDB8A674827DD588582@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
 <20240228-imx95-blk-ctl-v2-1-ffb7eefb6dcd@nxp.com>
 <1ad77c33-71de-4bc8-a53e-1e74a5096079@linaro.org>
In-Reply-To: <1ad77c33-71de-4bc8-a53e-1e74a5096079@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAWPR04MB9885:EE_
x-ms-office365-filtering-correlation-id: 378e3b2f-ec97-44d0-cdc6-08dc383276ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iwkJA62Tc63SuwSmcyXt67IYLqJbSD1pF6s/+hezeQDLghlRl/G0hzrdMJvbxAlS0tfYyjEFUTaT8x/mn9s5yZhklcWneuHzVmL2ws4u3xUc/p9qHrUJEpEaqvCNH6K8ArWfml2jbndW6/nYskre0RBqsv246xUyb8rdTzdA4g9tgqva2XkJ8gTLmIj1xOp6gwZrfa5BJsmZS2TgQYMx9VJ51qUqunoMlbsnpVlFlpoyOpGI4WVryhFOYNsYixDjc4vsTGf2xl9a7WAV5MYTkCJ0j0UWw7/NBfOwS0UM98igH5b8yUBR9n07zixzzAAgKcv1TPByn8u++MVWiCY6xhyV4aauWt+gSl686I+/Zilf78hOyRlzsVhLVYd179c2+BO1kCj18m3X47/aUHj4G4XzUQ5+VGE5ZfWZsuDcMXWppSJOOUUuqGYfLtNnI8r2FN4DeizVoQsppKEFzlSKHqtLA4z2PrNPZaZLSbd7SKExT+tCXEvLOUba/WTjMskM5DT1O5tJeO7yw9xx97dzT02yEgHnW5prA/USXaYRe+Lao9kGHhNFhz/PjFt4EXBryiqAnq6pWOsst0QmvjXrlwtWuRpvF4iiv1+V/68gzi8hexxX6mjF+YtD11HNMlPgR40IfFe+uNa2e9I/p8Vy4YQ4MnTIXd96QzvnlLx1YgIj6grImLzj9i4ViwOeAnSQu5pvnVeX5TrWUeUg9Y5zq+slA7Q8L1n04CBIIUBMaig=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UmFNsrDZzDxtHBRB5XVF6mMI6XRtIFMgtGg99NHkiIYJuFvj50+QkH3Dhflc?=
 =?us-ascii?Q?CtBl3we25BZD4fd6S4+D/gsWoF03WGSeij30ofZ14RwZtvd8gi5EUAhddMTO?=
 =?us-ascii?Q?8SdRRApi04bj+jYXNAvOY1+Ro4EvGhUjLiBbQzUWo/mdiaP9O2fV2GPSPcBu?=
 =?us-ascii?Q?0MWvxK8EVbZAWJI+BEMnRvWf1TGMw2Mvb55xtQ+wmHo0uq/FrxbMkJlzULlS?=
 =?us-ascii?Q?mOhTXuMpy75ivwfRUp6vqgvdiyLnCV1MVgvAq+dN7YxLmYvvG9BsFeVVNKe5?=
 =?us-ascii?Q?Jgu0KprEWnavp671oGtDHn36D7umwdjzuwlbZu5iVxMygzFVbvCPRSSjZX8o?=
 =?us-ascii?Q?CXU2pZXBMiluk2lJk7WRdmr5Y6tG0iB7xh090QozfS6CyYenQDRvVa0HqNEV?=
 =?us-ascii?Q?MG7gyWBptwOwusdT/Nz1Q6WdafOo7D1yrw2KDNhYrR8M9f0CCbPRA2bzPiW0?=
 =?us-ascii?Q?sNlQRE3Xzjmh6ONdOcRdNhHFkkFCVj4hZX7yfh3rcAmmuJ7I+qvIdB3X958L?=
 =?us-ascii?Q?G4e8Sfr6RFZApDPJUL0NkNPoP1o8E3RfEovMyFQuthoK9/FmqyOowUx32s8i?=
 =?us-ascii?Q?NPUpgjuinhB6gwZQdD9/99b1KLpN3JnDkCRKamS9wjseNe4eBe3wSZ13Q6rV?=
 =?us-ascii?Q?GVXpbJrylAgHGY/WyFzsfmCVbYjN6sa4GfFuBDiCkh7wGuVmC2gv8BHZGMg6?=
 =?us-ascii?Q?3+ZAxyHUDwhB9fwtHcuM6hM/8UNcTtaLabAXZxUAm/H8KIFYajbK0ptADCWM?=
 =?us-ascii?Q?pBRW0xFpeoN18tLDqV7AUyvAgP/PYrGuXXpTfMyDS7ntx01s2LETDl8dbO+Y?=
 =?us-ascii?Q?MjoRwZ0p+2rHZ2n8iaromdL8eLtBT07JeAgcwnaGooXBsYudGr4JPbBPZfQz?=
 =?us-ascii?Q?d6HqIhvjSxeFp2z1IvGbbd3IqAcaKYY1nbiXSXC05sDB5AD8JbzIXx20rO6c?=
 =?us-ascii?Q?r+HNzSm62KBNgEjEEaos3PN5DJFrPnk7jfnsc4CPLhvTx20FTA+v4RcciVCG?=
 =?us-ascii?Q?BmXQJiJEv0iSyehZVD+i3ccWuRrqKP0p1PNvaNOrjxpdALgmE2Gu4W/VlXZQ?=
 =?us-ascii?Q?uQBFvmwo3HZNPaQZY0JstQyQm/Lyol/jv2FWoHPSBXDME3CJUCvUQmeemJHi?=
 =?us-ascii?Q?Vn/CpG889DFZv26IdEBPKfbgpBEHxGmDGiFATa65VzDEX15Z8eIg9ssKI2Jr?=
 =?us-ascii?Q?n/ioTxFegvXJ1ys9cno3G+nPs+M99xWCRvXPfNjPjWqWIpO07Nyv3Wx+TMP3?=
 =?us-ascii?Q?aWapLTOHioMRZPsyn/cTmZBerQj1tgEveiAwY2QTFRbY0EGuShjTRrEmYLRk?=
 =?us-ascii?Q?F2C65OOfjCv3QLn4z8ejqJD+c6fmKr1wXrAJzLM4/vUZppfhpdufhF7+9Fqx?=
 =?us-ascii?Q?Z4TWxOpvWhklkgcnB5og0XsRn/nW1THcv7NSG0vI7qMpydztxAKqxV5D5vyf?=
 =?us-ascii?Q?5TaW8jMT0dX2WTHYGbslPGQUJNh8sWr521S4bu5wGH1p05xWhWtzYyeuIfhm?=
 =?us-ascii?Q?GX6zt2oJX9UG134qqDNn1cAR0h/y2oWmDmLOnsbeXbPgGCN01CFD/9VylaI0?=
 =?us-ascii?Q?8Bwl8KLamd/P1SdL1sU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 378e3b2f-ec97-44d0-cdc6-08dc383276ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 07:54:17.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIKRtsED47Ib18US8PE3k4unkNy6I7lHFZZ8EcWJgwp3h6MSc3lUdND9QasNhXhQkiJFmm0zjjBr/NK64PqdcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9885

> Subject: Re: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK C=
TL
> module
>=20
> On 28/02/2024 06:43, Peng Fan (OSS) wrote:
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
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory yo=
ur
> patch is touching.
>=20
> There are some typos, so you miss my filters...

Ah.. ok, will check more. Please ignore V3.

>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/clock/imx95-blk-ctl.yaml   | 61
> ++++++++++++++++++++++
> >  include/dt-bindings/clock/nxp,imx95-clock.h        | 32 ++++++++++++
> >  2 files changed, 93 insertions(+)
> >

[....]
>=20
> Filename like compatible. We talked about this.

ok, will use nxp,imx95-blk-ctl.yaml.
>=20
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7Ca6ed8c5ca4a745204f0e08dc38313f37%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638447031362290549%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3DDWrWMkSOrl%2FfCdEf%2BcTFjunNM66q3hHkPFGCzk1%2FsHo%3
> D&reserved
> > +=3D0
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
> > +      compatible =3D "fsl,imx95-vpumix-csr", "syscon";
> > +      reg =3D <0x4c410000 0x10000>;
> > +      #clock-cells =3D <1>;
>=20
> Incomplete example. Add here mux controller and power domains.

ok. But since the power is managed by SCMI FW, and no
header such as nxp,imx95-power.h, so I will use the number,
such as <&scmi_devpd 0x5>.

Thanks,
Peng.
>=20
>=20
> Best regards,
> Krzysztof


