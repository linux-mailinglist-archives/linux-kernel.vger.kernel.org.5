Return-Path: <linux-kernel+bounces-134126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD089ADEF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55541F22579
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EF317FF;
	Sun,  7 Apr 2024 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hfIdM83a"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2130.outbound.protection.outlook.com [40.107.21.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE8EA4;
	Sun,  7 Apr 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454609; cv=fail; b=T1NAkBQ6Ke1XIQhirrxttVZEn3JFxbhmeOE9Tk7EaB1beYwiGzccNnpdbkjvU3uhlX5B6MzUuI58wwDGObybpYEBk54ZkffRjOKUaBFyb6540NC7E1wh0OlUXRMYeNBYHQ5/8RjcsOKbZCDD18Y3vRuCo6Kdlp2CxQd1qYuhufk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454609; c=relaxed/simple;
	bh=LsiGuiKreRiOYuh0GJY/Envm921BA5WXros4lM9TSF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R0WuuL7HFn2cjjq+JjUbfOg+C6oYR97+T0MynJJ/XvK4qXqmxOPoSrKleNPY6ZwOzuu927tqGhzH/zbnFoAgoTVCjeVGuTyyXEl0j6zNJIUSGIf/NYjTSiThgHN8bt2X4ci9irTkS9/6kU5maFaJL/Ij3PqwB0NBVb3nyOxVNK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hfIdM83a; arc=fail smtp.client-ip=40.107.21.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XO9VUx+Qr+ZftjLzsHoN8LXHmXHvavL6PvmeQi+PVeT+O9G5DOB5+sKAnna22iI3CSCL//hBCe3ncJDH6knS1fHVOW/Cviu0ccsAhMT4dNq5Hl/rXkUpvq7u0hx60vivEnefcVK9tjgZB87EOMzFLx6IuTp111MlpCTBOQq8lvTNCliZ5PUcAlaYEYk6ZksIJCM4LiwS6IPn6+Fplg1ZfkS6gRyp04TcQUQnqZtOQL1Prn7jOsNqChpoXXzNGmYZYwdtjTsSQo9WddLFM1QwOHCYZMubmAssSe1gfzXhcri9dr4CeW6HZqNOEsJElsZhuEJAYtIWEeiYjDRqTEONoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmJvNP5e80idrIZUf41xv6kjHcyRbQXGowTFnOoWpAY=;
 b=coDTufzMHd/L2ALbWJW0f2Ini28aCYnSGu63chmmebp65lZSOMulV2XSMWjH8Z+AYOUoM4+7JGoloJeTot42d22Il+bpA7nUVFmd8mhl66vs33J724CnXC0ZFTqzXQfDLp8X59rP5XJ4COPl5KNZsTlOQtADfIoDtVj6AVd4EZSWhfob5k+4EiqSZzNWY2qR//0WsaQCHxkBmArE5+bHcAYzTWYtRkT0vN3OW4WESugO40bRWLhxLqr3J/1k6cAetn9cDMvGLPCv9VoZt71GzL7GXYgDMOyQQh7RL8ZxPKrOp6IPsZTpm1yA/u2gC8++88HWZVbr3OBKKo9rPEtuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmJvNP5e80idrIZUf41xv6kjHcyRbQXGowTFnOoWpAY=;
 b=hfIdM83apfHiNshpZsafiirpcKJLVkKv7gfEvCKooKhPWnfm1yMREjNi8S+qBhsHnsPyWmsZrGVcBbXQPZ8DTK40z4loTSa02XZrHtFwUCz3VR5QLTRMbPjVVqnyB83TkCUBxmpxidYla5bduZ01hSaTtqQSs702zjzv7toNpoo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 01:50:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 01:50:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Topic: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Thread-Index: AQHah1U59RmV1LBnZEq28+9F7LvjPrFbFSOAgADj6VCAABPlMA==
Date: Sun, 7 Apr 2024 01:50:03 +0000
Message-ID:
 <DU0PR04MB9417786C4A0B2B54947D70E588012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
 <9aab8dab-27c4-40b6-b1d5-0a2babe0700d@kernel.org>
 <DU0PR04MB941719A18C3F749E7D180FD888012@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB941719A18C3F749E7D180FD888012@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7621:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FByPVvaKyZ0Gpw95kVGqB453/xVBDYodNpoYM9VHfuQ5mBWdXItv5cMIcRcHBWuDQI3CwkyxkGUQxfqg9N0tbdR4K94fwDbxiRnFNeh2RYyOZNnc4mlX9NSlEBB91u/9+SRkhBSMz63yFcbwUue6OiWWfZK0D5/Thf/PE9Tqb9+zv3IIW2wGGAiYAP2fgyoKCuokcf14SLcvjQ8IZGmYJENK8M21W3nWEJttVWrvsAxxkobDkZTfRru+Ah6AJKVnEefCwW4oBxbk0tMdePRVOrZtZi2/227as3fO+N/Fx/whXG4phseXc8TAp6iMslzLaU/Fa0cxEs5EHhVC9MMcgUtSVlLmNrKMDKUx0GjmIds7+jWGakJBpHhRSHhz7g5WQPCvYge8J8fSFhRfF+5h+fTQzgdVNKIdYT5Y5Y8jxGLr69Vlfhi0+PZ6yLuBur1vxqFHbOMJvec7CfmFYLtr9nAzb2LodPTQj9wTIEl7AoP97wQHrIOGVyCdtKI07isbbKdexNByhcbRWDKWJVk5K62NLnG+mg6xGYp/C7Q8MjsxVcpe0QaslGIuSEPbOgC/c3taJAQEapRmkk9rSuAYBtU2OP6GvRn3t24W1L9JTalZnI9U16zp8MHslaP+90NguYZNkuT29duQTWHN2TbPilPwro7aZo88DCvHNMAeDarK09vNvijUWqRk+Yic00Q0qRpax6YCZfdp8NRuC0VSJQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+L7VUj575xfqU6XiMhrJOq5BoQ6SPnA8IUZJEdiIwNo9vYVs3rMLyTWmtutK?=
 =?us-ascii?Q?v+O1Fzyj5zwXn4zoF5A93MzaEdSmcKTUWF9LaV7FiI/+caV4klSRBSoagNV8?=
 =?us-ascii?Q?ZAsI6213pD2jhEf7wJp5HnT6bSRkFhGq1yhdpz0L5rrp+IqJTk++vwa5v4Vh?=
 =?us-ascii?Q?usIpBJIHNL+n0sgd3pyZhe2Ad+5l42uYsXFr2vbC26t2hB7BtD4Y0ORn/rEZ?=
 =?us-ascii?Q?uQdgs/wR4VW6T9AQEE9PiSfxmL6gyaCuiEmpO1mzC0XxW/72INvALm3mXiYI?=
 =?us-ascii?Q?zv4fVevAIXoByuT+cgCfy4tG6I43bUiT3rgt1SZhbUpJkt76DXlN0bpP1dl7?=
 =?us-ascii?Q?M0YoJ1XZp82Gom/yAcNZ3BOsfk7tfx2dzeQPunLm+puIo4Wr/3MpNnhH9cnl?=
 =?us-ascii?Q?yaBwN3+HB+p4mRPIL6948X70+52CNyPFDAKsqrjFUO48R0U8RoUU5vPXfxqB?=
 =?us-ascii?Q?xP5/GqNLSJpQGAj3BsvmHlCsCa7ij3zqkUDNcaUU3+r8SwW+19r9vYDigJHA?=
 =?us-ascii?Q?3GEbp+zDxhYIG9fn6ro6081epPGgjfUSeRl5ccnLJexZuALM2k94vAP0zlJt?=
 =?us-ascii?Q?q8Mo8JusjQ9BXAQgQz7eUACyOFOYGON2JtWV7W+8pb7pLoTRSCrQAtz5ogGb?=
 =?us-ascii?Q?MNGCN12Fo9zHc22o0WFYpO3tDXo/ueRro9IVyTG2qvtGGtx3VIcF0iEeMmNP?=
 =?us-ascii?Q?yO2yKeC0/29opMAG1i/FGAS6WGEyt6tn7+Fc+M990T3kBxYDoFK36/IoMg3e?=
 =?us-ascii?Q?Ij4bztwi6gnEOVHCs/jj6NiWUMCXCQpRRfQF4yOzbDk8uAsII4t9w58DLMN3?=
 =?us-ascii?Q?kthx4OaBvmQqj6o7qdG0pp3OAJ+J49OqZUiwmNeuqn+6d6WQaEt5/K9Vdjvd?=
 =?us-ascii?Q?xB/feR5TDI3luXdbgM5saEowhXZBpXfvbvZXah10Nka2R5OE+r0wbAeTqUxs?=
 =?us-ascii?Q?PWPrL5o3MbO4aqh32H0GXntmhfd+QMapWpEVfr5CheDbiAfIGqJKiF46r9to?=
 =?us-ascii?Q?qgFRUmt4WSf8rsqnAkz0Ty5t+s85/SuDcGjnwsSaaMG7Zksx6rB16z0gsACi?=
 =?us-ascii?Q?JV74M3f6NPh8CVS5wfD3QiGnHgQS1HSFZcSHokJLHyugb5NtZBbQexDKsvjr?=
 =?us-ascii?Q?xvDJxNKK4HkWZ8ftsKhGCzEbkBUlQMLVz2PQaramSTJ6B3PF+wuo/tYzuV86?=
 =?us-ascii?Q?LEqaOh0zv71oGKmAHLFHL6sLbzACF0QETY3oycfpWmFHB0hTT6byuekDclbf?=
 =?us-ascii?Q?zUIH9w2MEpp9A/YIS7MVbP/sTcd3xFTb1FEAAJpGZGYRK/p5ckHn6kq2pNIh?=
 =?us-ascii?Q?mOjzW7d5HlOpYhsBbOySxGcJ3CR9R3dpeSO23r/tG5HGLxsKBpx7NrEPS9tT?=
 =?us-ascii?Q?WTfmgfYJm1THqcrJSDAybVcEJRpWEbYkHzwoHkfec/QjH3V8oLmKNfPJsT22?=
 =?us-ascii?Q?uNn74nVVfvsneIVXY9CepHJpPnJXNpYop9O/yl195DzxmcjjtwdIBr3UDEks?=
 =?us-ascii?Q?iAsRwYKFHmHPnB6QYb0ZIRMPOSiRhU/mTbRUI7D5wvbYxBqWjZf8g7RdAWEr?=
 =?us-ascii?Q?Mkchqm8zyx6eH4B90iE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9f847c-b4f1-4461-a070-08dc56a50b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 01:50:03.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJo3Mvz19OLCbXLy8IaG1HkCHp8/YW9ahmm2IJQVpys96+wuipewh1JHsBef7Q1AIpfqRLqOOoP9YqnRClDGMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621

> Subject: RE: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extensio=
n
> protocol
>=20
> > Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI
> > Extension protocol
> >
> > On 05/04/2024 14:39, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add i.MX SCMI Extension protocols bindings for:
> > >  - Battery Backed Secure Module(BBSM)
> >
> > Which is what?
>=20
> I should say BBM(BBSM + BBNSM), BBM has RTC and ON/OFF key features,
> but BBM is managed by SCMI firmware and exported to agent by BBM
> protocol. So add bindings for i.MX BBM protocol.
>=20
> Is this ok?
>=20
> >
> > >  - MISC settings such as General Purpose Registers settings.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/firmware/imx,scmi.yaml     | 80
> > ++++++++++++++++++++++
> > >  1 file changed, 80 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> > > b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> > > new file mode 100644
> > > index 000000000000..7ee19a661d83
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> > > @@ -0,0 +1,80 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright
> > > +2024 NXP %YAML 1.2
> > > +---
> > > +$id:
> > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> > > +vi
> > >
> >
> +cetree.org%2Fschemas%2Ffirmware%2Fimx%2Cscmi.yaml%23&data=3D05%7
> > C02%7Cp
> > >
> >
> +eng.fan%40nxp.com%7C5d16781d3eca425a342508dc562910b7%7C686ea
> > 1d3bc2b4c
> > >
> > +6fa92cd99c5c301635%7C0%7C0%7C638479981570959816%7CUnknown%
> > 7CTWFpbGZsb
> > >
> >
> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> > 0%3D
> > >
> >
> +%7C0%7C%7C%7C&sdata=3DmWNwPvu2eyF18MroVOBHb%2Fjeo%2BIHfV5V
> > h%2F9ebdx65MM
> > > +%3D&reserved=3D0
> > > +$schema:
> > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> > > +vi
> > > +cetree.org%2Fmeta-
> > schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> > >
> >
> +p.com%7C5d16781d3eca425a342508dc562910b7%7C686ea1d3bc2b4c6fa
> > 92cd99c5c
> > >
> >
> +301635%7C0%7C0%7C638479981570971949%7CUnknown%7CTWFpbGZs
> > b3d8eyJWIjoiM
> > >
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> > C%7C%7
> > >
> >
> +C&sdata=3Dv4XnGG00D4I8j5MJvDUVYMRTm7yRrvz0V3fUyc5KAAA%3D&reser
> > ved=3D0
> > > +
> > > +title: i.MX System Control and Management Interface(SCMI) Vendor
> > > +Protocols Extension
> > > +
> > > +maintainers:
> > > +  - Peng Fan <peng.fan@nxp.com>
> > > +
> > > +allOf:
> > > +  - $ref: arm,scmi.yaml#
> >
> > Sorry, but arm,scmi is a final schema. Is your plan to define some
> > common part?
>=20
> No. I just wanna add vendor extension per SCMI spec.
>=20
> 0x80-0xFF:
> Reserved for vendor or platform-specific extensions to this interface
>=20
> Each vendor may have different usage saying id 0x81, so I add i.MX dt-
> schema file.
>=20
> >
> > > +
> > > +properties:
> > > +  protocol@81:
> > > +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> > > +    unevaluatedProperties: false
> > > +    description:
> > > +      The BBM Protocol is for managing Battery Backed Secure Module
> > (BBSM) RTC
> > > +      and the ON/OFF Key
> > > +
> > > +    properties:
> > > +      reg:
> > > +        const: 0x81
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +  protocol@84:
> > > +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> > > +    unevaluatedProperties: false
> > > +    description:
> > > +      The MISC Protocol is for managing SoC Misc settings, such as
> > > + GPR settings
> >
> > Genera register is not a setting... this is a pleonasm. Please be more
> > specific what is the GPR, MISC protocol etc.
>=20
> The MISC Protocol is for managing SoC Misc settings, such as SAI MCLK/MQS
> in Always On domain BLK CTRL,  SAI_CLK_SEL in WAKEUP BLK CTRL, gpio
> expanders which is under control of SCMI firmware.
>=20
> > > +
> > > +    properties:
> > > +      reg:
> > > +        const: 0x84
> > > +
> > > +      wakeup-sources:
> > > +        description:
> > > +          Each entry consists of 2 integers, represents the source
> > > + and electric signal edge
> >
> > Can you answer questions from reviewers?
>=20
> Sorry. Is this ok?
> minItems: 1
> maxItems: 32
>=20
> >
> > > +        items:
> > > +          items:
> > > +            - description: the wakeup source
> > > +            - description: the wakeup electric signal edge
> > > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    firmware {
> > > +        scmi {
> > > +            compatible =3D "arm,scmi";
> >
> > > +            mboxes =3D <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> > > +            shmem =3D <&scmi_buf0>, <&scmi_buf1>;
> > > +
> > > +            #address-cells =3D <1>;
> > > +            #size-cells =3D <0>;
> > > +
> > > +            protocol@81 {
> > > +                reg =3D <0x81>;
> > > +            };
> > > +
> > > +            protocol@84 {
> > > +                reg =3D <0x84>;
> > > +                wakeup-sources =3D <0x8000 1
> > > +                                  0x8001 1
> > > +                                  0x8002 1
> > > +                                  0x8003 1
> > > +                                  0x8004 1>;
> >
> > Nothing improved... If you are going to ignore reviews, then you will
> > only get NAKed.
>=20
> Sorry, you mean the examples, or the whole dt-schema?

Missed Rob's comment, will use
< > for each entry.

Thanks,
Peng.

>=20
> Thanks,
> Peng.
> >
> > Best regards,
> > Krzysztof


