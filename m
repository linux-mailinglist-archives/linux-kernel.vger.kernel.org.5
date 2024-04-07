Return-Path: <linux-kernel+bounces-134115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFA89ADC9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E204B21D20
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4298F54;
	Sun,  7 Apr 2024 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JSTAOAk5"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282726FC3;
	Sun,  7 Apr 2024 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451098; cv=fail; b=Dk8vKWc2TdsuPCxQywpyuvHhGKmnrM4oRz20V/HduYno3dmMN3fBaI+1NHFpYU+zqTIkysdsp1YFNc3tLsQ/SXvtbjb7cVG50XbKcTMJZrwxnJHAmt92x7YYiSJVtuawbMBbT7qlfaed4CQSHTRVDTLbr/Sr6xxeT+GdDKQTFIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451098; c=relaxed/simple;
	bh=duSd0raHGUUn1DDT1VCr+AA2SnFLUHBEuBh3l90Dnj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gThdpDmKzMJiyP+jk6X0tW9zyNrpfiG+RU7etJWfdRBpMuVqsFeKXfzcKVm32bwTyvcAGkzYGyOIqVrxAPsXjyNL0Tg7Zjq57SCtK4uDq4JvB5vjhYTQ8lb8Qojk40AMJGBdWfZFQiFWkS1apUEYzW4ykJP/f1W99tcdFJkPKfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JSTAOAk5; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMas4EPvHd4GJtoNMY3mNpeRhc0eEBSRUiRwncZvy/XsUllZRK3r/t0GY0rMAtDvaOIVezfg74RJjntJ4gfRAZyt1j2C6mRqbitA4QX4HC7yE0vDF/82bM1fm2+6KfoU6Sv7jKCV64PX3c7v4UoNTrT9klZYX+duD7RB2Toyuljr3wLk2Gqoeqs/kH18yG22/XFrD+jLLPIBB8scLMmEpU+hUxe7XrcAhvNmZ2XC/70UvcI2iNCuPnodQDH+vFhnnBsR2Ta+/bue8rYJbn2tKvCScxMILjvSmuo7+mapxDdC4alAsY0NFTBNyGvlKe0lvHfeZtvQbpKvMp2BjHCXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2Zr/XNemT7jvYFXlxX/KoxpwJSUX9T/1d12vkMSxBY=;
 b=KGQWWgVV3CXVeTnL2acsyWjFgWS/qGMWB6bkXbGvpZ0lQeA9Zky8R7e0RC8CzO84t6ZmcLvUiVqqKZpGK1lD4SlUB4OTs35UZB/XnhBb0/5mCYorDRHJ76dq9yOpJOOSncL1VCbsgPFY4pZE6NQkiCqkea9ulldDw9+OIb5QsBtVzVSlUPWn+siOm/xhQQmb/6qEIHJdieUQQz7mvdN8J/mzflnt6og4sL20kWLArjLVbLLuM8xs4qV2osFKhcxQEO75AEQLNCsBRt+H+ctSNb4Zp561o1NWccCJ4D56ZipXjMAqZe4jCcYj1S8UyvCm9hE2xhQ3CIu0gaA48uustg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2Zr/XNemT7jvYFXlxX/KoxpwJSUX9T/1d12vkMSxBY=;
 b=JSTAOAk5zK7LjSV9D9d3XcGo4HKCRcB7CPtY+1acbwUBKcRpqfPr3WW0RwIVN0wTJ0X0Jfbu0GbVa1Kf4OHWIFTdDnwVUnKitLUoVv5gbxMVRZ7yeEmGVZBZraiugIgAw0D9Yf0XQvqpOESHUImznsSX0jGAm4zOPopFjfkXOI0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8486.eurprd04.prod.outlook.com (2603:10a6:20b:419::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Sun, 7 Apr
 2024 00:51:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 00:51:32 +0000
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
Thread-Index: AQHah1U59RmV1LBnZEq28+9F7LvjPrFbFSOAgADj6VA=
Date: Sun, 7 Apr 2024 00:51:32 +0000
Message-ID:
 <DU0PR04MB941719A18C3F749E7D180FD888012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
 <9aab8dab-27c4-40b6-b1d5-0a2babe0700d@kernel.org>
In-Reply-To: <9aab8dab-27c4-40b6-b1d5-0a2babe0700d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8486:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TXlAxwzaOVoB3w4+8V4/uVQqedfDRDe/sFu9EOyQrCR+AfS1fUpT95j/MpJh4f+1JVTmeZMHzcDnGlHal9ntpiqtwQnlhGvKSRW7JAjIWH7LOq/Fo+WNqUnj4g/fPlkdeC3gxFT88EypciZpMK+SoOWIeMaQ73kMpEf2zhpgSoN+MajjJbU7kvAi8aotgpwnlwq7iv0S9KIkexSUBUVWAk7rQ2pvA7JrERauzpg3RiwL6DEUlVvFRLmPsSzLzFUJStRkZveZhuHJ8PbhCla0urcNAH4uu13IEwmn0XL6aJauqnMhW/sOTXasvSVP1Q58Z2RDcIhhfnBj/ZzGpktY4UoiC/EAjrkyI1bQmGnClKVXgyEccBwpplo1EWIonGXXcklae3XQ4K1cN8KJ8d8Q/ucyQRgu44LUkg1MiDCVg0ksGoEQ/gf1QGW2NGWB/XLyo4lhletd+Ail0sL9Ma3BhGWCFe7YqWYVBkmfloTop76UD4+Xg78TvmIHFpeMCIQItWpfzJ80hG91ByM0cRPA4dKyl0sdIGYCI4YQbUVIvnBqsGLQ3bEKlfy14RDv2Fpbc7/Ndysd+IFcdI7Litx3Y8IUbFbeAQXHq9F9dkoxGBki1Y8FnP/PYzcEtwkTQXDPhqBA/Hp1iDsS5dhxnPvldTHBr9QoHtZXC7qFwuaqwBNT45w/qYm9+oc6Fdo9BFSzerhc3XKHqW+SFfRE2OK/4w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VlMODbN5Ph+KR5xSvkNGJtARkHFVINXtyaO3YAqRjXuFPvEQILIFYgvAoXVk?=
 =?us-ascii?Q?hKIEwdUh+ZSNV5mYeuAIMUGhDn5Q1wQBDBG5JeSdA1UoOEfS+Vps8PWrNvHf?=
 =?us-ascii?Q?3XO+NdyrIzPz4v4wOQzyTgDZULo2zn6nUnWFguwOhpbOJ96GbEHsfjQzdAge?=
 =?us-ascii?Q?NHFT6slO5UTfJkpEC3+8mW6X8wAWZkyLbaGWArFDVifH8oHm79aukzQWdTj+?=
 =?us-ascii?Q?BYg2pqcFO6IXajH99dCWGw0tqp0cZSMxMczLVpKQYBttOyR8ClbsdhivNDln?=
 =?us-ascii?Q?FVjUy8PyPmcR3/v2OJN6+CXSJjSQyE2tChZlSTlfbY4DLNJtXGbY+ci4eJG4?=
 =?us-ascii?Q?f5+CnIsbssk93Ac5Jpr5Nas8QBg9sSy0gxzZXqJip6W3OQtfWoeWdHIYu1T6?=
 =?us-ascii?Q?eC3TctuXIwcxD+sj6E5dOJpizN6o9Duffa+fcrvtH1aY2ggXLr3flrYOXX47?=
 =?us-ascii?Q?q7eWlAzaFbRHf4PR0elZm0vXdywviYNoq/cOVut7beUU34LVU5fdto8gLEN2?=
 =?us-ascii?Q?wAhqrbQvH3waX+U8hh5mPhZF6/tITD1y4vKwI0FXt7j9csDEGa1Kif3y+Lss?=
 =?us-ascii?Q?dYQhGIPItcgm72lrZ+XzWuCu3GxbjNiCt6l5GLRIvDfxtfx0WicHyYfOVf0f?=
 =?us-ascii?Q?d89rwF/QaJjQUrZo434fUI3pvCSLFNSnpLE0Nu2twzxaWo/oypyR9tu3bChJ?=
 =?us-ascii?Q?BlDB2Lvr/rH4XragCr3Ld8I/9VSoVsYm66m0o+RvcUvosnhxLKWjOzaKn1tF?=
 =?us-ascii?Q?DlcIrGXyDcUrdnSdW99Eu3BRNW2Pa7v5WJTWYysKS2P1vWNJNUNF0SVMAxHX?=
 =?us-ascii?Q?IKr2Ia9nSg4z1JSy+FFC4NFcOvhdzZgPOFsFl/Y5YF5WKESIR+3069lBWvYw?=
 =?us-ascii?Q?NaUvlglKfEk6YbH8Ws5zXJn+PJC1JXdh52DCbfhpXKulyYMrgEdN5QPJVO/G?=
 =?us-ascii?Q?ejTVG69uSd+JmXMbASgo2MwWZlk31LU7QD0aF6gCbwwJ1AGH5+g7QEV7wCgZ?=
 =?us-ascii?Q?V682EeB0wDRw7FJRT30Mezxros9OAh4ZXxGrhU5uIadARA4LLimGb24j+HKV?=
 =?us-ascii?Q?9+IfODC3Ed/2mBi646dmiFc0aDkiQWW502DoGCmJP9IVcf4c5BrvLQmzt+tN?=
 =?us-ascii?Q?DtJi8UP4ohnoEtoRXc2ld6dN0oI4QC6lP5fObS3DbFHEB5nyxBQ5PUCvIA9X?=
 =?us-ascii?Q?01fbQ6AtoWSDY+JUmnZamlbHiS8lEPXDdxB8ERGXrHbEuhYTHxjxaUPVihpe?=
 =?us-ascii?Q?KJdKwciQIsk975yvDa1wgTPbHkNtjDnZ3S5accn/CVrSEOrXSons/J0rhgyO?=
 =?us-ascii?Q?ZPTFd2FhNoemtURQYbo5a19iDDXgkMg0WXb3oV66ElrsFK7zC+yE0b/W2Uai?=
 =?us-ascii?Q?56EZklk34ertxBPvPjDc1EGhgPlTJMDgLBijbNgkLa6QTQQVH7aKp7IRjAfE?=
 =?us-ascii?Q?ZYo3eBogmtSHJsxu2kvyFln9FdoouPpdPg0NwgQuk7hhym6xKkMZF/p5HkpL?=
 =?us-ascii?Q?zlbUj20/7amU9/VHAL9/creKcZ4NGeeCyduFJvx9zMo2guzuBxaKSc5JRl2R?=
 =?us-ascii?Q?wctNYMvz54KEbLL2SOk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f822b5-ccbe-4ca4-4a26-08dc569cde86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 00:51:32.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aK6KN3eZifcbTiyNWMSmrjVrQ6kNR6Nu9Dhff0e1aq7Z4DiArr3r6vJtBNfUsZsaVq+R6N1gmXP9NtUTDGi6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8486

> Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extensio=
n
> protocol
>=20
> On 05/04/2024 14:39, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX SCMI Extension protocols bindings for:
> >  - Battery Backed Secure Module(BBSM)
>=20
> Which is what?

I should say BBM(BBSM + BBNSM), BBM has RTC and ON/OFF
key features, but BBM is managed by SCMI firmware and exported
to agent by BBM protocol. So add bindings for i.MX BBM protocol.

Is this ok?

>=20
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
> +eng.fan%40nxp.com%7C5d16781d3eca425a342508dc562910b7%7C686ea
> 1d3bc2b4c
> >
> +6fa92cd99c5c301635%7C0%7C0%7C638479981570959816%7CUnknown%
> 7CTWFpbGZsb
> >
> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D
> >
> +%7C0%7C%7C%7C&sdata=3DmWNwPvu2eyF18MroVOBHb%2Fjeo%2BIHfV5V
> h%2F9ebdx65MM
> > +%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpeng.fan%40nx
> >
> +p.com%7C5d16781d3eca425a342508dc562910b7%7C686ea1d3bc2b4c6fa
> 92cd99c5c
> >
> +301635%7C0%7C0%7C638479981570971949%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiM
> >
> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
> C%7C%7
> >
> +C&sdata=3Dv4XnGG00D4I8j5MJvDUVYMRTm7yRrvz0V3fUyc5KAAA%3D&reser
> ved=3D0
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
> Sorry, but arm,scmi is a final schema. Is your plan to define some common
> part?

No. I just wanna add vendor extension per SCMI spec.=20

0x80-0xFF:
Reserved for vendor or platform-specific extensions to this interface

Each vendor may have different usage saying id 0x81, so I add
i.MX dt-schema file.

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
>=20
> Genera register is not a setting... this is a pleonasm. Please be more sp=
ecific
> what is the GPR, MISC protocol etc.

The MISC Protocol is for managing SoC Misc settings, such as SAI MCLK/MQS i=
n
Always On domain BLK CTRL,  SAI_CLK_SEL in WAKEUP BLK CTRL, gpio
expanders which is under control of SCMI firmware.

> > +
> > +    properties:
> > +      reg:
> > +        const: 0x84
> > +
> > +      wakeup-sources:
> > +        description:
> > +          Each entry consists of 2 integers, represents the source
> > + and electric signal edge
>=20
> Can you answer questions from reviewers?

Sorry. Is this ok?
minItems: 1
maxItems: 32

>=20
> > +        items:
> > +          items:
> > +            - description: the wakeup source
> > +            - description: the wakeup electric signal edge
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
> > +        scmi {
> > +            compatible =3D "arm,scmi";
>=20
> > +            mboxes =3D <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> > +            shmem =3D <&scmi_buf0>, <&scmi_buf1>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            protocol@81 {
> > +                reg =3D <0x81>;
> > +            };
> > +
> > +            protocol@84 {
> > +                reg =3D <0x84>;
> > +                wakeup-sources =3D <0x8000 1
> > +                                  0x8001 1
> > +                                  0x8002 1
> > +                                  0x8003 1
> > +                                  0x8004 1>;
>=20
> Nothing improved... If you are going to ignore reviews, then you will onl=
y get
> NAKed.

Sorry, you mean the examples, or the whole dt-schema?

Thanks,
Peng.
>=20
> Best regards,
> Krzysztof


