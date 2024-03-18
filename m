Return-Path: <linux-kernel+bounces-105760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291187E3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF4B1F2161A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A31225AE;
	Mon, 18 Mar 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hgw+0b+g"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945422EE5;
	Mon, 18 Mar 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746140; cv=fail; b=rsnNHfptuTVVrJ/qhJLs579DtioYwGbHZrY6p2q0Oh8pCjldAFpEnocGIH7gTLBFgofYFmJu8aa1VHiWZX1737N4vf2NxxSUQJlDWCQU1Le/fb2Q4aDeETu49IEo7GRdqRBqMz0o0y93C+uPTZUZ8SxssU9DT4tIe5OoZ5jgENg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746140; c=relaxed/simple;
	bh=QZzUE8Ni0EL5kQMH93CTY03XQefB+z62J6+2s5MqRSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mA73LlKlQr607ZGGNhY9KrZ/4JlBYIePCJmWSqOuiY1CVi8MxVikvcfNPZP/57cqUiu5Lcu5qN5IxKymmDi3o6qAyIpUWyi7BMGoUTKqbbpfOQwjZ8/wEbhEMf2uVTnmPRMDTms2MPLS+XuBUoOZe3HBAeZi6yCWLzx+XsZbqlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hgw+0b+g; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeaWxIISRLzx5pzxxdoSv+E7aKq7GpXX65xtzPv9CrX1zPvvwrxid18c9fG0+TTRGji0c4XqQP0qBFw80XR5mLR/7WwTbwfH/98izR0iRY5iICndMzU+DipEedcHLOzbCorW7D4CeVNq8psnci9r3JWZwjLYS0jPj7hgES93/eYqy0CF61udhe6XFIFCka5AU2gmAQzMqDuMN6+bsA6pouWuNK1ObfzEZ4o1/N4+VjdHEE+LfEFsZR4jjfRag3WUM4/6hymC7eOg8p4pYxTWpJJA1NdQ1l+Q7CXDhc6FytGfyTOulgy6Ao3o1mRonTy8ny3cp2A4HGtvgG3Zc9wCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPkHsDEUCwfA0ZE3vx2En+FIAsicT8aeR3ImO4Tig7Q=;
 b=XqnEDJfDoFwqoaLjMkwvKX1Vj7eG8SPOch98BBm6kZ37iGVr0paW80RZektUjFTW9LKQ9IsaEUy3R8KWr2foP+Nzec8OpDnRukcuF6zGPwoy21eMEjo5S68Ji2c1ghbnaJZ0vU5L/6SOV7ieBRl7WtLd0DuAWLy2f9UF/0XncExlg/45EvyBeoo26eoWCEQZcdqlD2U7ZyOcZNyYeg/nj1DMzlMkJzzmn1CzWYimAxQkXdJPCNpxOw3/UJvoi6+r8UAwms9E41rbrfzV9BAP1t4oXaGUDAGrcO6qDWiW6NtcF0TzBCGasj0ySWhdaD396FLK/iqgDhY+QiBvqKpW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPkHsDEUCwfA0ZE3vx2En+FIAsicT8aeR3ImO4Tig7Q=;
 b=hgw+0b+g+JYUmRaHMKdwiYAoTwj3zSVXKdnAGKbni80RrwUolwc+DFoefNhANgg35jTVf4BVC2RY3q6f7XBR2ey2d0Ym0rZmA1YisbdGmq3DDbznLmVtmbc0Q7sIgveEsYbiE6KtQgXpBukfU51c6QOT6asXPqZt7Pyw/sXe08M=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:15:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 07:15:35 +0000
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
Subject: RE: [PATCH v4 1/6] dt-bindindgs: clock: nxp: support i.MX95 VPU CSR
 module
Thread-Topic: [PATCH v4 1/6] dt-bindindgs: clock: nxp: support i.MX95 VPU CSR
 module
Thread-Index: AQHadhH4UE3MbiZEYkaA9C+JsAj7gbE5R/qAgAPTvsA=
Date: Mon, 18 Mar 2024 07:15:35 +0000
Message-ID:
 <DU0PR04MB9417BA412243B8E3FEC0A46D882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240314-imx95-blk-ctl-v4-1-d23de23b6ff2@nxp.com>
 <99b72931-0007-4ab5-87fb-9b4c3021c1c2@linaro.org>
In-Reply-To: <99b72931-0007-4ab5-87fb-9b4c3021c1c2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8022:EE_
x-ms-office365-filtering-correlation-id: 13a51504-fa48-4bc1-5c5a-08dc471b34b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ntKutNczlzqaJdHNzuYic6DbeqKp2a8B7CUPlcE98ErGfP9hdpRs6nmC9kPWNCOjMnXjdelvGc//cTzF6USzusgEYBYeINWJpk9m3eiPp3+mc4cjPtw7B4omcaEOaPAOZ3Z/ILdeOOOD20l7NFm+rqdUbAUoBhdyvkXBPMb4yaMNG1sABmu3jOYNbbfWq5gF8AhD6lUpEkwa/2v3AylgpCE8tBsyzOqikJYNj6zAWv8ntC3asD7Rmjn/MOn1zivC3z8cYwsbkjYuC79F+9myzAKd+ZT4yTXd2lKGFRHN9EBnyO2ZnXYaJt3j0/LOrCeWQQ86rWrnYKhGCvTkk/85yBsT1q61RiE1IIJjk3GPQkcHN7pV5I8o4V1Fyuj2nSvl41FBdXBNdMwTgX5vgKCoXc7JhvRCk3DchIKFn0xjV4Z8h82RblG1qho66hHZdjykenu1EPvYM2XGRWDlE37QEsGVtnpKxD062sjnZgPF5AxzkMaQnn/u9octTHedgly+QQK6RHSqgLn37V2/9Sg4Pb0mxi8zdUqjwrsNXTy8DLAW4qkiDQmqP37jVx5osfbS4Y5erWssNhZVNqnVsQqUcsNupEG45ApyQ3ExONjRxYrtJxYcgmPjZZghGShAaZde5r6xKEDByinEpApLnkxN9rA1KMmFVUf7bmfTAbB9Iu/SW5LjvRH5rbLzW1wFAME+gOdpuRzJtnqfKaio8+zOI1OPHN518lpja9CIQ9FRqq4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MrH8/MBOfS2EOqaQZEZl18bNxqUur6tXKNcK+pU3v0h0fjFLIPszTdtldPXa?=
 =?us-ascii?Q?JA2sxG064cf1sc+gOmgsBy19hzwNTZJAPDi89Ow8OE9YZpCA4lJa2nU9QwYS?=
 =?us-ascii?Q?Wodr+SbHuimrzVGhC4WGy/d270gdoJ5BaszkXv7EftrxfBiW9/hrjlo1rcwF?=
 =?us-ascii?Q?lftPLXxIweZdRPHmVxyThs4MzIrDGJNiR18NrSsdo+17Q8DC+8AupWJTIOxN?=
 =?us-ascii?Q?+fZeolrWC6HJqrCyaqHPpQun0z24pFPDa22NHzupl+1KNy32hIlDG6uP1Don?=
 =?us-ascii?Q?xKgh+o46M6KzN8i9HuZFoR31KByoicTDvy2/HnpHtdAixmQ8hu0ghF+UQ327?=
 =?us-ascii?Q?bcKA5MZ4dGZL4cteHxzhHpbu0ObZo2CUYDuSD4OKDT9nOf6lEV9M5z9Zh1Ey?=
 =?us-ascii?Q?ZJHpUSeoG5GqeEUA9Kex+VlcXD0P7LyZhUnz9A/jNJ8Lb9cfpWn2JoESfIEw?=
 =?us-ascii?Q?vtOexBOz9B/pHWAMb4i0F6qvQIN0DJ/KUwBBPf2RUeFKIeUN9AJqG9sq/qCB?=
 =?us-ascii?Q?meFZU5ZVn+qvxatQgv9Lfg2VD9+Y31vVQmN/npQLtnCuOrLs0yfg5OA6iidw?=
 =?us-ascii?Q?bcjiAsj0BInbsFAZQ2RKu0B9/IUEM06fZ3ruCTGFnUh3lfcM2OCwie+j/21V?=
 =?us-ascii?Q?tC2t36ViZVnm8UXuqQupfe/Sqm5ORsePYgDZyvcDjfqq5mZf45fn4vVVFART?=
 =?us-ascii?Q?Xir4ruzWF4umO7DTXZVPM4dEcjKbhmcyoHHMbd80b0M6dWsqnaKEqYSlk68d?=
 =?us-ascii?Q?pTiCrLfhrqN7bIYR+N9Sn7u70eocRuFxRMa2MN/t+ssA3RS7HyPta4kQ0nqN?=
 =?us-ascii?Q?YAGYjEOE4sgdiPDbzCgnqhXRdmf9lMVi6evcCAd2ZVouAAHN3BuHZShlpdXu?=
 =?us-ascii?Q?kjcTNZCx9QO8B8pWz0hXK8IHd7fqi0TlOGYx6HYSACAWKcxxn/TWzLcfKf6B?=
 =?us-ascii?Q?48wV8onERTrcqVNYhAmcBf2BvnnV8zdxPBbmhCf+4aBBmSaOBqJfZpM8tHxa?=
 =?us-ascii?Q?9szuUbBtG8GOMUGbxU0XDJUH9u7hlk1pEYMwQWZVmQaBXHOyn+YYgtyY40Es?=
 =?us-ascii?Q?hhv9I4Lhfa/yTICUEhLcOfquyW4al9gnOHWydiKxSeEQx268fxT9roZkxNMY?=
 =?us-ascii?Q?kTUKuboOE8WIY7cxasW/9Qx+wfMOKOABpgee5XaO5SBKydeElac+NzMr2KX1?=
 =?us-ascii?Q?qvE9dIlrNdJCMj5eSFtHTYMgvKf/FNzL8D4P3c3zUcia6uVRw7UWlIoFC/OJ?=
 =?us-ascii?Q?qu4urnuw94HsX/tI7l880VYwuEY3b8uA7SWE+qCrEayaP9NxDC3Tm9Rpaxo/?=
 =?us-ascii?Q?ZD1VuaaRsOy/BJNzyM7L0InGnMU/FOUKGz8QjhYOkg25WCfA3Z2no48TM8kO?=
 =?us-ascii?Q?uxtd6LhoK/8is30ex+6dIONQJoLAVondJjmyVayShF31FB/6R5VIT0RDHrVG?=
 =?us-ascii?Q?0ccv99GxqqcT15rEeA15Etzs4nKzWvhJcCQB2iK+XA/8nSl4DwbpI9RlFhBr?=
 =?us-ascii?Q?5DRvuS/UweSqJVf/4knZbKFSyxtf2cbBi3CLDjuLnPA1lgFUpTNhlOgh5H4E?=
 =?us-ascii?Q?juqYi1MYVFC8b4SKWFI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a51504-fa48-4bc1-5c5a-08dc471b34b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 07:15:35.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfjR1g41aUNFkfo79TnSBR6QV+V1hJmND/+57V5/9U7x0HHF+urK5zVlJpwih2lxx3BOStj2gzRNSHfHoJ6QfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

> Subject: Re: [PATCH v4 1/6] dt-bindindgs: clock: nxp: support i.MX95 VPU
> CSR module
>=20
> On 14/03/2024 14:25, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX95 VPU_CSR contains control and status registers for VPU
> > status, pending transaction status, and clock gating controls.
> >
> > This patch is to add clock features for VPU CSR.
>=20
> Fix the subject prefix. You mess with people's filters.

Sorry, a typo error. Will fix it.
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/clock/nxp,imx95-vpu-csr.yaml          | 50
> ++++++++++++++++++++++
> >  include/dt-bindings/clock/nxp,imx95-clock.h        | 14 ++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml
> > b/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml
> > new file mode 100644
> > index 000000000000..4a1c6dcfe3f8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-vpu-csr.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fclock%2Fnxp%2Cimx95-vpu-
> csr.yaml%23&data=3D05%7C
> >
> +02%7Cpeng.fan%40nxp.com%7Cbd64d1b5d1784bdb6df508dc453133ca%7
> C686ea1d3
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638461324818682648%7CUnk
> nown%7CTWF
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DPtStE2Y%2BnS4HpesF9wE66t8bh0Qmg
> 3s3y4aERwhSr
> > +Mo%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7Cbd64d1b5d1784bdb6df508dc453133ca%7C686ea1d3bc2b4c6fa
> 92cd99c5c
> >
> +301635%7C0%7C0%7C638461324818692719%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3DzWKRFnTPTwLZvtOvOrFUo%2FNlqPKRqRIEYCrztlfhzAU%3D&reserv
> ed=3D0
> > +
> > +title: NXP i.MX95 VPUMIX Block Control
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: nxp,imx95-vpu-csr
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
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    syscon@4c410000 {
> > +      compatible =3D "nxp,imx95-vpu-csr", "syscon";
> > +      reg =3D <0x4c410000 0x10000>;
> > +      #clock-cells =3D <1>;
> > +      clocks =3D <&scmi_clk 114>;
> > +      power-domains =3D <&scmi_devpd 21>;
> > +    };
> > +...
> > diff --git a/include/dt-bindings/clock/nxp,imx95-clock.h
> > b/include/dt-bindings/clock/nxp,imx95-clock.h
> > new file mode 100644
> > index 000000000000..9d8f0a6d12d0
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/nxp,imx95-clock.h
>=20
> If the header is only for clock IDs for this binding, then keep the same
> filename as binding filename.

No, this file will also include other IDs in following patches.

Thanks,
Peng.

>=20
> Best regards,
> Krzysztof


