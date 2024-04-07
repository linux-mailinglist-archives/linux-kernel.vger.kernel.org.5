Return-Path: <linux-kernel+bounces-134371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1AA89B0C3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF051C20D07
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA846249F7;
	Sun,  7 Apr 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XuVZPthd"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2097.outbound.protection.outlook.com [40.107.15.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3122F02;
	Sun,  7 Apr 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493335; cv=fail; b=IFysmalZJUfO/rDNfmWpOPkmhGd3uDYzJhfOtXSDrYjjVHRPBxIZo/GIOEj+5RQ8r0ytpFgAv18TYWKVy3sb5g4SiqxO9izsnJCbnA/GOCYZuELp8sIy2bhQ1wI0pKG9W9xBsucoLRHmfH/xNQk8dc7riJnP9Us5K+CmEMpKuhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493335; c=relaxed/simple;
	bh=hopfhlqY4DfSLltGK/VLhWCDAt0Ez/2jgb8OiXJ5uFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6MuySk7S8zhHby7VXs771UOtCIgW8wfjzZT0r56nt1cKEWQKicMZm/yQGJV4etG+FSGq0rnXAqklzLfxNfpq2Qj4G0f2rLdybILuqjpwpAuytqYqsgW7xIAWmk0EQ9254Nqz+BXkgD9jsARlteHBkA1J1RYZhyYTpfT8aEqGlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XuVZPthd; arc=fail smtp.client-ip=40.107.15.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv9kVBjqSQNthaKPE5K4nYmUdzRWJs6wxavEYHfAMAa+cb0+Svb8Q9bxqld9GWXFSCexKQtDV1n67JJ247WYcV7A0vb1k+h2Iz9pQW7yIti/RtlN+IpCaMERPfP3gj3C2HpWnG0PtE4T8mSpfxAIsl4OlnkuX9zleOMbFqzuxBZv6L2ehVrFiceCmDqp/inWP/EG9yIa0fQxUlyiaZ8sK2YkT8wFmyU3RQLk5sSMWew41elIN4xyqcKH3sPqbeflgRANBdJcYdIDSHIMYbXODOc1g3edEWr29F1XzLnEBozM4penYCK3dyyYTkUFv6gR6/1H+BVGWjNAFYURbQBoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlwQ2128zhseH61X1HFKXWM5fKJl1k4RbJ9OvKO8DVA=;
 b=AOb8JuIhKtRQ4vm5BO9PRkl0MVqxGwATRVkOdWf8Qs+uPaLfzbEMhgLClFQioCRgmqQMWnjcqUhot0Sd5Lx+tP6QOtD3eyz9glW9SF9f09+T17wFhNjJq0VGGbIVHKnYdjtp1NO47GONbMjFYZbceVLkhucKf/XGJDB0NIF3z3gS25Jmin0IcYl0mON/riU96LXZisJiieRLji6wvWiYWoLDeKvZiruFPoKWg4PoXCap+XBVq5SdOqsgvODRKuqcnGlYjQbL23MUMQJ0I0oYNKosdY8cSvxoH2OurQaXSaMOKZ3E0UWUK9fbjmEJCTZPuxQhbb0cPlC21K5XctawZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlwQ2128zhseH61X1HFKXWM5fKJl1k4RbJ9OvKO8DVA=;
 b=XuVZPthdAH6jj3Wohupz9E46FBvQQTETYZcsdrLrJP5fBotjR3H4RmQu0r5cqXyWS9MVj0FEY8Pd1vYAHO6Q2qU/MsqljGWZzoQLCdRyDmDkc5M2Ke5rS240/kjY6z/g98mA8vuicj34xtKhg+SnQPybcoqFGyILpPAnuDfQlg8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sun, 7 Apr
 2024 12:35:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 12:35:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/5] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Topic: [PATCH 1/5] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Index: AQHaVaFQyMElkM8qJ0+1AsXohnLry7EG36SAgFZD6hA=
Date: Sun, 7 Apr 2024 12:35:30 +0000
Message-ID:
 <DU0PR04MB9417EFBFBFD374B8A5E7039D88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-1-3cb743020933@nxp.com>
 <20240212150919.GA322668-robh@kernel.org>
In-Reply-To: <20240212150919.GA322668-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB8026:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SxV0+9ePnNmJ4Zg4B8wSY7ZF1MjtJ8zGtMtJ37HAO0XIjR9g9sx0QMpDaGUh7qAa5dVaSXu6E6zQPs5+IJUpcGOzLa+5SX6oREi/0De4HEKjWtmDfgJTwuj3C1BUnnMLkS0w7dzWSAg+2nUfzvxcde4kH2t2rMpK4yNkA2gInF6e43qL3nLO1STKlf8fOpv39rW+mU2DXmtjHQyJTxvQ4vrlcTZwX1qn5nEcKOhTLxu9RXbUvb2C5xvxVs+j9PA6lAsUZ679gHMrzK0UpT9KQR0zG4ytXCq2pVk1pfD2kMLHACJhOFIeDvmpCpebTDwfWeo2tho34MOtxU4UuQDpmWkkNbuOCG6UPprsaz+miE0LD+lPjjijQe2F6nr66jwWfRnvlxC5tRgRVcXFxZGBCDNPeCKnrGLt4rEz3kxtYic5ekRWw8VWFZoLc68TL+7zzSGFwetz8FzWwkrbey3yxFbelkzmaNYGSIsl32wOD9aFydO43D1ZjOdLfn//8ktv9Ma6Nf9vGPa/2JMrhEA4c1/qK6kp0sZJUW9BfHAMwFp6NuqBJl7Aja/QAv8jl2GPaCpWLxvayG4rxVsc+itU5yyqj5aoz5poTfIqd4Dw9BySM0yxy8Da/gg0TF7Rd++ZB9i3uVvFg8AuQS3GXpMgIj2bWtN+qg95KW0pyEL7FG8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FWsMYI6dtM3XRUU53CcYK2+kE7gzY0TupkRqYReL4TU5MWhFP/ItiJy08AYk?=
 =?us-ascii?Q?4CkjbKsPa9zsgDxA8MltFTZJkjxk906W1DiAi3+Q40zy2gaWMoAISCEwLiI+?=
 =?us-ascii?Q?W1q4LV9MKcyoFeX8Sgv6skmLFY6ETnvpoYzh6on3nZqehgxnxVw7Z7GXtk/I?=
 =?us-ascii?Q?gqINEvvnwGRqQsanpjPo901LR3riN5Ya2v2wcauQZtyPBZMSV6PkHqnHriKz?=
 =?us-ascii?Q?gfh2YTVVikbE/4nv44dOXFVY7Ag2BZN7UPkZ0smL3o3RtgO9++/YfaH3htNv?=
 =?us-ascii?Q?CuH3zESm5fZ1SrHIZh/AwQvDNK+Ln7wDQmw4flS6q6hIvAHd6Sx7vsV2r77G?=
 =?us-ascii?Q?SKPBcEeuAoPZkWQNLOlerRay2uQIlb164abK3H+CwmriaFJBjY7dHpk9Wzs7?=
 =?us-ascii?Q?3ZspwVlpThGpxtmd7VxbVdVBHtm4uODQmGJq9WUEbL40b7nBDwjHDJ82b8oq?=
 =?us-ascii?Q?5YOEJN6NGOQeT8Du91Sp9HpJlhmw2oZZ8xDu5t3w2eEkSInoGKMmUoCA3e46?=
 =?us-ascii?Q?s+3AnvYEnbOh1uPrissGclxu2I3onoSHwzs2Pg8xyp0+9NzVIGLXBJiFIojp?=
 =?us-ascii?Q?Ykdzxjx4I5wgDSCLVVrkbqZu2fE+uDf3jkdVOb0F92xk8VoflIJ3ZMfUGFMH?=
 =?us-ascii?Q?N5sVDKo4Ts3BTuGTQxNUxuqnd9zpjA1SD2NqTJOKnGRRq+nwgU7DjEwb8E7o?=
 =?us-ascii?Q?U1xtLxZxIKc9Z4ameqZ6cDHI70Dtvj9yrr5M00rUhuIQWjrfug4fSn0cSNwi?=
 =?us-ascii?Q?Cd6GqRaLIQaElvu2oKFrGQXUkAjGKr2RnwYPRnny60Nyj2pp9Icy/ck7N3Il?=
 =?us-ascii?Q?hvocQX99lYHapzeCvlnlM8uAVLqeUKp2qFIjJfdKqEM1L0k445nMLRe4t4T0?=
 =?us-ascii?Q?nHj7IT5u0nJquf6bI9gAWpmEBczgOEEbWwbfI/9CDAlYup779fU8Rnip20fH?=
 =?us-ascii?Q?LU62rlTZVfIGcWjpvzBfyQx30TLmtq29Lg++tnKeAg9/lvuuwcaNSaxAk2bG?=
 =?us-ascii?Q?S1u5gVcKiCwgwn61m3MbnIhULbw+ykRKX2TXmnbEaLTyzlFRaAON0NEXwRR+?=
 =?us-ascii?Q?+kEL+pw32quIPOqgS5m2zs3/UiiPA04EKSpTi+4mU0+eGnC37jLW70o/WSLi?=
 =?us-ascii?Q?riteY92X0cvE/rqS1GhXKuyMDfBUn0Vg9B/waEMKPkLwz4ZkBDLAqhJ70uJF?=
 =?us-ascii?Q?7aRIsWhK8FgcNbKNtnrrc2Os4rRQD+aGxrXB/Tbkh1fb2hmNWE39SgF2Fa2T?=
 =?us-ascii?Q?PVoiRm49wc5yIoAfFNBu/oYWMTli5ttjNo9QNlVEEj9Cr8q4hhO+gmbszKJL?=
 =?us-ascii?Q?8VOGoOn5lrV1bM8iewMMmUZYqSkuusWUs3npXJgN7xmeQkAa1fXR2VNkJS88?=
 =?us-ascii?Q?67RLbP7DpJQmYmZZvSuUjNyZMNjnSFwdGEAg5b6dvI3MBrXyRoBolU98Fj04?=
 =?us-ascii?Q?q4R4Vs9h0prm67HKouHm3G2G4X/Wzf5QRXpAKxpcly5yd3ndH/KhifhE5G4x?=
 =?us-ascii?Q?wBiOX64dX4QeA5z17PhIvNzQd60i2aYIa6DYtUO151ylr/pz4UoupXGhjsk/?=
 =?us-ascii?Q?oKTo6zZ40CW8D08dfVM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ee763-ec38-4744-866a-08dc56ff362a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 12:35:30.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kyqCZSW+W8TQBVruhic9OKhmgrgCqRmvOtUEgcuIC+tQ/8Ee19q5bhHQHGjYFcYmwV08kLJKR9pWN3IAyOphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

Hi Rob,

Sorry for late reply.

> Subject: Re: [PATCH 1/5] dt-bindings: firmware: add i.MX SCMI Extension
> protocol
>=20
> On Fri, Feb 02, 2024 at 02:34:39PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX SCMI Extension protocol BBM and MISC binding.
>=20
> No idea what BBM and MISC are.
The Battery Backup (BB) Domain contains the Battery Backed
Security Module (BBSM) and the Battery Backed Non-Secure Module
(BBNSM).
BBNSM:
The BBNSM is the interface to a non-interruptable power supply
(backup battery) and serves as the non-volatile logic and storage
for the chip. When the chip is powered off, the BBNSM will maintain
PMIC logic while connected to a backup supply.
Main features: RTC, PMIC Control, ONOFF Control BBSM serves as
nonvolatile security logic and storage for ELE Main features:
Monotonic counter, Secure RTC, Zeroizable Master Key, Security
Violation and Tamper Detection


MISC: it is i.MX SCMI extension protocol, including BLK CTRL
settings, board level GPIO expander settings.=20
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/nxp,scmi.yaml     | 64
> ++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml
> > new file mode 100644
> > index 000000000000..00d6361bbbea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/nxp,scmi.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2024
> > +NXP %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Ffirmware%2Fnxp%2Cscmi.yaml%23&data=3D05%7
> C02%7Cp
> >
> +eng.fan%40nxp.com%7C625d14c7c4f14d16289908dc2bdc9967%7C686ea1
> d3bc2b4c
> >
> +6fa92cd99c5c301635%7C0%7C0%7C638433473675932860%7CUnknown%
> 7CTWFpbGZsb
> >
> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D
> >
> +%7C0%7C%7C%7C&sdata=3DdP0%2FgyCwmWtSW9BNYWZQtunpgayjCl2AkSkj
> ZIZjn9o%3D&
> > +reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7C625d14c7c4f14d16289908dc2bdc9967%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> +301635%7C0%7C0%7C638433473675946764%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3DefmqKP8%2FyS4YoDLCb%2Fmxx72D7ZW2KxiEDhgnWdEUT1s%3D
> &reserved=3D0
> > +
> > +title: i.MX System Control and Management Interface (SCMI) Protocol
> > +Extension
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +allOf:
> > +  - $ref: arm,scmi.yaml#
> > +
> > +properties:
> > +  protocol@11:
>=20
> Wrong unit-address?

Yeah. Fixed.

>=20
> > +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> > +    unevaluatedProperties: false
>=20
> Description of what this protocol is needed.

Added.

>=20
> > +
> > +    properties:
> > +      reg:
> > +        const: 0x81
> > +
> > +  protocol@13:
> > +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        const: 0x84
> > +
> > +      wakeup-sources:
>=20
> Is this somehow generic?

I think it yes, but if you disagree, please suggest.

>=20
> > +        description: each entry consists of 2 integers and represents
> > + the source and edge
>=20
> What does 'edge' mean in this context?

Electric signal edge.

>=20
> > +        items:
> > +          items:
> > +            - description: the wakeup source
> > +            - description: the wakeup edge
>=20
> Constraints?

Will add in V3.
minItems: 1
maxItems: 32
>=20
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
> > +        scmi {
>=20
>=20
> Need a compatible here so this actually gets tested.

Fixed.

>=20
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            protocol@81 {
> > +              reg =3D <0x81>;
> > +            };
> > +
> > +            protocol@84 {
> > +              reg =3D <0x84>;
> > +              wakeup-sources =3D <6 1
> > +                                7 1
> > +                                8 1
> > +                                9 1
> > +                                10 1>;
>=20
> <> around each entry. e.g. "<6 1>"

Fix in V3.

Thanks,
Peng.
>=20
> > +            };
> > +         };
> > +    };
> > +...
> >
> > --
> > 2.37.1
> >

