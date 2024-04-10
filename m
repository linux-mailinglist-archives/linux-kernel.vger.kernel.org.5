Return-Path: <linux-kernel+bounces-139546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25078A0431
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536362875EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7BB3F9E8;
	Wed, 10 Apr 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XHQcghXz"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2105.outbound.protection.outlook.com [40.107.249.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C59381B1;
	Wed, 10 Apr 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792842; cv=fail; b=GZJYgBVVdWy69QMIayZ4PLihFtjQwWfkyzMYXNAeYPwcvvi1rlZ32ZFy4pY4MbCm8Wfw/KY36fri0ObPcRbhBaEQPFpQQ4qYHJ96+C7fbUUju7D1I3e9X11NudGyPbjHJ7Z4LiZPibhJ+lnc1eTJ1L+vU/o2wXeoxfqKPfHTwGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792842; c=relaxed/simple;
	bh=iyWG5hsoEW5QbBwvdeTXimCdc66j8m8sKYT/zo2PZTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUq8XGPWQhWpPtBPsE3JuPEdL8MOCr9J8Io5cPnx/mrJhYXinrnhUUAQ8jHVcL/UwGitMnjm6O08yHFmgrUae2gNQ8E4e1gma1k21OgksuaBii2tF28Nh48rSkcaZ1W3XIqIZOLIZnFd93b13OA640NOx09Owo8oBLrrcX4nBV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XHQcghXz; arc=fail smtp.client-ip=40.107.249.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkKppmNqRGQTwkI0XZBfRYu8JrWbRhx6lHeWNSlXy/+5pwLrhvyQ94qfmm4jKT9Nx+1eDGTpbRF2QjTtkfBB/S3gt1FsVk5n83jqhpgUCH/JiP1SGxxt//0/0g24EFDOeSVgGEMiX31KDeNtcfNhlQOEJX4E5g8NIxN3AO6kh53UgtM8tOFpgSbqscMHwUEa5543tbWdvLPil9o+iyPjSC8c8ZlYvuEGs9kVgsT3NaIcvHLQDhWWGaR4W0crVqre66o8GXaLJHDDCmjJ/WAiZ4gLJ2DhRqHwIPI61D2lX+0z4cIzoNHAhZ6/u7KmyVGBG7xVViU2iNoiYU+zHwfcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxaCKKT9iv0Sizj0KYABiIJyjeKFTqcoo6pCCoPrklU=;
 b=L+zAs6K9JWavRva40O3zw11G8sSt0RO+3dcKpeBCIA9JbAGcXdXEj+LmeLi7ErP9PVpTWy6JpWVXhd18yrTXiekNDO4iexpkiKwKevMyLT6dV5m/QIjbvlzefw0/FSxhBVhYMBgUsBPubncahoIONydQyjW9D/j8eJ0fHwsDWtsqc9GYd6GNeYXfHCwXLt6uF3Ln4PPBGg4aqf5L0/ckYwuXav+OgmaWKdCeNrtWcfRrB5D3Ao+SVQIILnW3OojJgnPD08+RAzWvZZN/QeZr1A7TC8hxyPYU2HX5X66b+txrOQxE3+C8LH7A8LHEvxjwnI38wxov7lBkvm1wlbz40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxaCKKT9iv0Sizj0KYABiIJyjeKFTqcoo6pCCoPrklU=;
 b=XHQcghXzaldKz8wR/7oAoG26TXTeyodZIYF6Pt3bLrhDURqvsUMUNMmVLKPDHC3I8fWEmRiM18T1LD6CKL45tXQkNork9fcqPzR5iSCZ3ij9LJJ2sWD7OdMv9S2oi97jHBjRq7IeJggHHyxymq1qaS/kwS5tgilCtmCen569Tvs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9182.eurprd04.prod.outlook.com (2603:10a6:150:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 23:47:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 10 Apr 2024
 23:47:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Topic: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Index: AQHah1U59RmV1LBnZEq28+9F7LvjPrFhx86AgABr+tA=
Date: Wed, 10 Apr 2024 23:47:14 +0000
Message-ID:
 <DU0PR04MB9417B8B6F35D3F0934D205DA88062@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
 <20240410171925.GA564262-robh@kernel.org>
In-Reply-To: <20240410171925.GA564262-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GV1PR04MB9182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uMoqG0AzSe5BCiuiIAENVxFZaSd96lBfGhUNQas1yYCUnD5oVYKHSaiuHETtVWMNCD1899k4vejWoalUleSCF70MRy9PQI/bLXIa9DvZt0obvuZBj4DtWPmKhB0XF0nOcrXIDlZcty8peV8wOgag/Ai1VF13rA2zITV2mJbs7U+eO3MYfzya0g0Lrq+ZDv+cK5+HMfpZ/s+ODa8Lzem9ZmnGRnO9YYFqAT5AOapTSostu+6hn2XMIkZOe/3Py0kHiczS23no1kbppAz3xCWZCmpmV9xJFQ5ckOuf7HxfKAB17NmqDL6Xs0pZz29oAkc3dZzR2VG/XRiAHIag3CfgW8cUeXUrYxELfCvXdzgXoEK9BIMXC7tXd22IXNQzo+dcoyZ7uB6oK55uQF+emLxTVRDuV5TgEz6QvUm26y+9KdSmOM6EzAVBwJXi0JN45hTBqrG7XhUwN61y5rFCiustcL0sUpEAPn0fIHdjIYcUmaQuJf3M95eVUX1pMaovxjiURt6QlG+d1u7ndCyWfQR4jKmYL16gp0ggBZ7Sl0UK57YRTY9UmDBuDrKh3HrVVJiugZl/V1xu2xV7e7hztehW8bOfHaUAQkuRN8VrZ70TqRNfcoROmID7B4A+9Xlm2mlhXKiC+lZ89iT/lO7FVhaiFqOxwjDgh0XoBkS1VC1Pd4I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AIqdLLANQBLXdh+rS09AciJOFuWKULDDYD2S1iocgv0jC9NpYe0LF3VJ6EsF?=
 =?us-ascii?Q?08LtIcPOlUBQGJRfXE+F6Mk0Qto/Sk+H+Fv/WSaoElZ7DAzKYPWtTPjepp4/?=
 =?us-ascii?Q?c7jE0iRWTH54LqIIvFIsRUegDAQMEYz38O4tB/6CdPsHU1VOsNKwE9DKqMiS?=
 =?us-ascii?Q?MA75cp4ujvpboVFUKfC+Ti3VnyqO9yaiyrRun7BGZmzYqohmN6aQifpr3kp2?=
 =?us-ascii?Q?9wVwASj1vYN1AojGf+acQ9rLbjwwFPGPPuvmvVYxvyKn4R3SxyJipgb0Hjku?=
 =?us-ascii?Q?HJiXCnGr6Polm3+EevBmLqU1wBUiRm4BC1aR7zv9nS4RGgQ0q+qd32C7sZ3w?=
 =?us-ascii?Q?udPkOmIgibVEA8HLQVxc2+Nj0P33b8doRXW8sa8L3KT6vrpj4xmY2mLqAAJ9?=
 =?us-ascii?Q?SKBWcbGVayzC03O3xmD62WSAVmpQzYKtLMYm3vEvivtX4QrrMzER+ABmqxxv?=
 =?us-ascii?Q?D5SVaTtSYM4SzIMg9tot1kH4iTmvAZ28WE9sSJiJXqYnObyDR150SF6N6C5o?=
 =?us-ascii?Q?JKdVe+fdwP9cyXkEPmU0b0FJFb/rbDnjPFSiGjncPXr1FRndp01JsxUdBtP9?=
 =?us-ascii?Q?OCaVBAFdRHIkoiYQMsCRxY3mZvWNapKn9QSE7ABxpVohXcPwL/VL108bt9g5?=
 =?us-ascii?Q?O0tCyfhaxKO1/kV0d6/ISZXtBDdi+gG2H5caF9ETFHbPXYhGbSwvjby3mw20?=
 =?us-ascii?Q?vsLV1vHtTM2dsV7cjQid/HZDrPkTV8ysIgcY50Cjxuc8ikz17nB/DvQQ2hPE?=
 =?us-ascii?Q?PgiF20J9DzBF+O+6M0UU4ef7CbtapDskPumdjzUYKv4zLwTujP33/S6/rQsb?=
 =?us-ascii?Q?26S1s6vGr1K1jSv82sBllmuQSMs7aat4AzxkMxo417rCk1yQ4ZznewYlCbMO?=
 =?us-ascii?Q?NzjEJiu2LYn9sltlSV2hxl6PCc+eqoppFOPZZs2I2VlDGul7KTX4e0IwOXM+?=
 =?us-ascii?Q?kuN+bkfH2RMWgYTWDPEJI1oCFnhQuFBAD7tJ4X+Md2f/7880aoyUfXw6Msob?=
 =?us-ascii?Q?1pmCMT5bB2IjLof1YrcnNwVJdNXTLl3eByon09y3kcMf/aQFWPLGSZTlOtyd?=
 =?us-ascii?Q?0LpLV/7q2N7QEU8/hVoRFRJdj5XrTGa7WZ/4D6/yyY20hilE1rMx4QaSbsLr?=
 =?us-ascii?Q?7cmtBEMBXjwLredS48j2+BLYZ+afBeKdoWNgassAAs/z+C/ZquMgHd9WrpCw?=
 =?us-ascii?Q?raDtVgaAVz9pGxR6rvesPicK1GKqG7uSrBLEuJ4t6I7Q5jK/ks0oPet9IhyK?=
 =?us-ascii?Q?5V1W8DIjclOSujW4/tjZunGT4iQiIB9NkKTEaiS13xiyQ0z8ByFBgqobvSwH?=
 =?us-ascii?Q?B42nQ+63++r50tyAUB5mRfVtutS2OEDETN482xkhEnlGiPt0D3Tt2pDC8P7A?=
 =?us-ascii?Q?Z2mGvYrhM/fTXeH7LH72CdJ2qnHR3gbiRP7BUDM8Fwi72KTBSH9YcfBJrnwj?=
 =?us-ascii?Q?FzXpnNPZj69nel0/v8tpa3gFl7CMpLyFf+0XkpyhLv74s5lJ0j/uV76mT3+J?=
 =?us-ascii?Q?479A+uAo2ZrONqyzQoOwNuHyU0u7aawKq+eBxYFahzdHEfNbelf7WOKPe8gB?=
 =?us-ascii?Q?xG9W63gHcFaXrf62VzU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b8d669-8b7e-4d3e-d616-08dc59b88c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 23:47:14.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfAAVYu43rART49F79RIZBwZKXShNxDo4Nku/vafPvDHoNVApipMV8tUDzDZSuyXEI8Iq5Wuqh0KlwKA0UPF/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9182

> Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extensio=
n
> protocol
>=20
> On Fri, Apr 05, 2024 at 08:39:24PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX SCMI Extension protocols bindings for:
> >  - Battery Backed Secure Module(BBSM)
> >  - MISC settings such as General Purpose Registers settings.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/imx,scmi.yaml     | 80
> ++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> > new file mode 100644
> > index 000000000000..7ee19a661d83
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2024
> > +NXP %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Ffirmware%2Fimx%2Cscmi.yaml%23&data=3D05%7
> C02%7Cp
> >
> +eng.fan%40nxp.com%7C25c72418c9864a73924808dc59826288%7C686ea
> 1d3bc2b4c
> >
> +6fa92cd99c5c301635%7C0%7C0%7C638483663734828123%7CUnknown%
> 7CTWFpbGZsb
> >
> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D
> >
> +%7C0%7C%7C%7C&sdata=3DY2uSGDorqR9HK8PO4AQDQ%2FaTv%2BETnulvU
> C8u9ktDoio%3
> > +D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7C25c72418c9864a73924808dc59826288%7C686ea1d3bc2b4c6fa
> 92cd99c5c
> >
> +301635%7C0%7C0%7C638483663734841350%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3Dh6lSgnPvR88CEBxmU%2B%2FCfCx9GHUrogWVxck38sIdhB4%3D&r
> eserved=3D0
> > +
> > +title: i.MX System Control and Management Interface(SCMI) Vendor
> > +Protocols Extension
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +allOf:
> > +  - $ref: arm,scmi.yaml#
>=20
> This needs to be the other way around. Add a ref to this file in arm,scmi=
yaml
> under an 'anyOf' entry.

ok, I will give a try.

>=20
> > +
> > +properties:
> > +  protocol@81:
> > +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> > +    unevaluatedProperties: false
> > +    description:
> > +      The BBM Protocol is for managing Battery Backed Secure Module
> (BBSM) RTC
> > +      and the ON/OFF Key
> > +
> > +    properties:
> > +      reg:
> > +        const: 0x81
> > +
> > +    required:
> > +      - reg
> > +
> > +  protocol@84:
> > +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> > +    unevaluatedProperties: false
> > +    description:
> > +      The MISC Protocol is for managing SoC Misc settings, such as
> > + GPR settings
> > +
> > +    properties:
> > +      reg:
> > +        const: 0x84
> > +
> > +      wakeup-sources:
> > +        description:
> > +          Each entry consists of 2 integers, represents the source and=
 electric
> signal edge
> > +        items:
> > +          items:
> > +            - description: the wakeup source
> > +            - description: the wakeup electric signal edge
>=20
> No constraints on the entry values?

I will change the property name to imx,wakup-sources with constraints
minItems: 1
maxItems: 32.

>=20
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: false
>=20
> And then this can be true.

Fix in v3.

Thanks
Peng.

>=20
> Rob

