Return-Path: <linux-kernel+bounces-146143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A148A614C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B1F282A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE7171AB;
	Tue, 16 Apr 2024 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pYWbPcTa"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6158171D2;
	Tue, 16 Apr 2024 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236857; cv=fail; b=sOdNf0Qs1bmqxkmSarH670D/hGHdnjj4NqHkg33g7R7kwPT+IHNsZMRWnFA8XiOyLtJqTrLYe4Ad7iF1zRlVuX5L8UmFMbgQDUH+IfiBk0MIgmikGHjj8DFQif7TIgSN8yXZ5eP4wCw9VgeaVf+vpYZTMIN8IAiunOa993uY3Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236857; c=relaxed/simple;
	bh=1+tD5ilSPiMRpfDpHa1G+adQPK3FaLSCbfrah8QW4I0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1l5H+WyRKQSR8RichzRYE7CJvVXIuAMOFXmdYR1Ii5E/87mIgNe5wZtFAYKstcnS6k14SW/tAQdsUSrl6q/7Avd4L1glhGl4cyIQBanGkSBdk69Fed0CiScHcMqRgCJEMnUGrZhS1pOSAYlZ6ONTtoltvN39Ix+6QntZaTpSgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pYWbPcTa; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haPG8LtE9mNx41JQVJT8PDiWANS3IV9PMKioFYKfguE4raFvqOr7oQZ37biVMXGLibDC6L0B9swiqEvP5EeTZCCOK5Aj/Eq7koJ8e40o+ysY+/f54U3Xn/prR4wJUNBXFvFt71bqEYs/Afbv0HKIn71SE5aZFfeGOhQlcZgTjc6VqbijuOqB1ARNJWDQV8VhDrdHtCNDKp3yfsWQXxHCnevRg7+NCfAO26T9B3FpRNVpuDh/Ya/h0lhzCjvWO28eWoU/Z+RjjpAnrF7yiGHvBSRvSrrTc2jdpjJVKiuNh6+peD4poXyUrgKuZ1VZkFQmCVMm+JONuFEERRewCG+DCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nySIb/Iw+lI/CT3Zpo8ioILLfp8eWdiip/rK2Zz3xrg=;
 b=eunDGIsSSlHl6PO1Dg6OYP+Gm3cwzMbeUy3BZ4RVRI6TrbFFvHzc+vj6d9DZagtxRN+dNCBpM40pJkeTrw5QDZsOXMxpO5KjUC7bgguUWGPEx53/A2fJbLm39/lsxRyl1KLhNQ2vXO69OTas3mNFpEJd/p49oTtEt5363hM3hO+njIV1pkcPdHNSReg4EP9qgt9Qah7VJPrg6Vnn69CuU7KoL4oM9ozm3wq+dSwdKj6Wq9WMGtjoU+mpt/cvEmQV2tc1nT9KMiYzVMMXHQ9E+UzDWRR9sTFntY8nEkEF4yaD1dfShxM3UP5MQ7qJ0IoOXMcA8G/lhDjwhOD83C4/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nySIb/Iw+lI/CT3Zpo8ioILLfp8eWdiip/rK2Zz3xrg=;
 b=pYWbPcTa0Ofc3tj/5cbDLsfixe8JGUQaFnnIP9UCt2N0g9F7rqtAZi67yLpC4Yd98JKTeY7f8oXzTZTT1DjTWWyhMmxAAjE3qgQZjnoUa/I584ihHVYBpyQt66v++NqFWg4UGS7tSeBczOO3OvIxsN3nUEIyBmINKu1QDmN9V1A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:07:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:07:32 +0000
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
Subject: RE: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Thread-Topic: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95 SCMI
 Pinctrl
Thread-Index: AQHajG9fogbrSJSEIkC/zlbnV4Z6dbFp93iAgABErEA=
Date: Tue, 16 Apr 2024 03:07:32 +0000
Message-ID:
 <DU0PR04MB941714AFCDC74997BFF34DFD88082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-2-704f242544c1@nxp.com>
 <20240415225637.GA234203-robh@kernel.org>
In-Reply-To: <20240415225637.GA234203-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS5PR04MB9731:EE_
x-ms-office365-filtering-correlation-id: 4fa1e5a0-b40e-46f3-85b4-08dc5dc25bbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rGnob1dvScK1ej3IZio28m8wM13Rrl4LmwiONX6v1bZ+jCIU77Fu0/++pQhEfxAfruzuZxIMO1lyWcJUcHaMRND8XEfqtPeBQ17/vL4ebK/nIoTMSkvUC8wOA6Zp8cbwb3cb7muRi4Z1724AzQ7lS58mH+JzgUHoy0ijc7acOavTT8Pwn8szWT+J9wqEcpkN0UNx2rUqeHpoN+E//F2kVR/dTTtMy2MWgGvf5VwSH1Rp/f/NvD7q/JcaovvkrRtXd0Jr3PIRCjCihe2sXj2v8Ivjl3hJInVO/m2bnmSYUq+AlS7cLl+GMIwO2xshp1Edb0+Kte95mNqMcYsQOduToZn2w2Znrp9MHQnsWmfCLlpRIrZtDnPPdx6ZGKOw66msv23GXPMGykXdy1yWuqjemyzpIa0YKuHSaSb6DkhGMcKwjzHOWqY2fmyVfN6dE+BSLz/2hRuxwliO/9+lImN7IwoaQzbE1U+eXhipixognt0/JIDLnObK8l1zbnvp/dKe67yxA2mXjp801LYW8xlZqvfdwzJGG/glLh3TEn5Ypax60FCSUWDy8rzTZydPv8xVDypdX6rnohdKYqXQD4gUqqqLK+ezFhZzk6/U0AJa5EkurWRcEnSyjYD/NzsTITL4r1KOZxDtlRONpPm9JRJ+P0uUaHrQUEirucRAnQisDryEcyQz1d2UEymKd4eDUp8Lmfy6Os3+DRr3+5KzteJSuTFIUHSPodD8WfWkJow0RoY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ixbvclbe5YFb8FOOSQQ8BNoi09iZFwWOwLau2qObJ3TRTDN8QgfCTDuUCtGU?=
 =?us-ascii?Q?oJRybjl191QuE7M8r6u4jS6zkb48DtYk+sDQ3ITK6mmF2CXevIFEtayp/Bfq?=
 =?us-ascii?Q?Ve5ucrH0y0+B+92YPusMCbcDjnz95v+J3sIMDftI73F7QPUqGfVOwACoqz/X?=
 =?us-ascii?Q?bnnl1r4sHEUsA/YxxkGXZervpKhDSalO/NQTpSmHuN7NbmqmPrFuqXzvOFDr?=
 =?us-ascii?Q?qb9yLaRp3FjKDmxu5KD04OpKtrgvkjJlA7bb6PiQS+pW27IVd52sTLcQU2tI?=
 =?us-ascii?Q?L0Na776nKaphcxidNsBM0C8LhdKUcg+RTlTWHnEpCYNPct2yptgHR+ebbxcm?=
 =?us-ascii?Q?Gp7cT+cOXozwI1n1l1nEXF3+2yKLxC30frjieGaBwPAO1YXbe2KSbhNmzdhP?=
 =?us-ascii?Q?LHOIo4zTgdVYHcARY0jMPDSBhw3HbuBJIhvNKmGSQ1kb4pYgrR9do0OHW6CN?=
 =?us-ascii?Q?JD6W+gdZGEdE7AbDOe+rbU1reRGAnBSXYkwIj+TBrfLp0hzeh/4H/+b9WFKs?=
 =?us-ascii?Q?SJ03vJ8j6gh6x5wRjdRBRgCWuUdclwsCSbUrCg3R41mfu8Sbi72Cmj+PSxsS?=
 =?us-ascii?Q?Xe1aRJIEU46xzLt9RxY/Q5Vbw2brSCmaEfknPUYF3FaipqN+xGEWHwKclQ5Z?=
 =?us-ascii?Q?e3wOMOzyvkMWQi9zWh+rl9r/m59XVdj/J6BuhSGZetvxp6hg63GuOJyfk16k?=
 =?us-ascii?Q?jBTFyU9NN3HI0DtLw3TS95OL8kmAZMJ4Xev6aD1bCPjDfnzF/yZeLWa5AAN+?=
 =?us-ascii?Q?wxMEHhlKOyc/pPiVn6FhIc1yADTXCzpjLvVkFQXhviwisJI9aQ/GG/mDBcO5?=
 =?us-ascii?Q?lQDntEAB/u+clfc2BTYaQqCeBZNkzIrc1WWWQvfuyABgmQVpr7v9FJT/CqN0?=
 =?us-ascii?Q?B7LatwPuU9T8UonRndq9zxaUUVohOnLUbIY5cGs1EDM9wiJfU9QhmuYA4f9t?=
 =?us-ascii?Q?Y7F0YdqMITNh51uBuf4OC8yyR61cnsRII+eBwdSQ3QTADphRWeTL4p3MlywK?=
 =?us-ascii?Q?H8C0p+4VG0EbXfNH1FyAXCXk7NBv8P9EiYaN6jYYsAEQ3fa3riJoIx/wDaOh?=
 =?us-ascii?Q?gumVandmFINHu6J/CKX354BlJkfWuS9OWoBgYZvSHimZnVHpgVbAMe/mwa6u?=
 =?us-ascii?Q?4q1L30F54F3NiWbQc48NqpU2mGrYKg+MPPOVCmeqeFr7NcjDwyHXeFLkTfyr?=
 =?us-ascii?Q?7TITDemd+pw8xKbE6kX8st1FYZ4LXv2TjTYGuZ84xipFhYWuG9lMIIgWsVFd?=
 =?us-ascii?Q?cGLdkdhr9h7vct23WK3bCTleaoeZb0hyktuSHfK3jFAirCnCPpZFfo2RzpXv?=
 =?us-ascii?Q?CJ6aIh42XwbFsIOxcb94RWV8TCigw8CvKEFNaxJugPnIZunJXXKarFmwxM5x?=
 =?us-ascii?Q?FrMnv4Elml9lz1YQaKx5B04jsm9YVe3LLOdEvuiDWg6OeTTe+9ZGsaBjyi3p?=
 =?us-ascii?Q?GOq2w1+F47Q4W2f0MqJt5lz/ijmDjvxC1bLStLzf0WDinPaLlzlWQ4RbbEoD?=
 =?us-ascii?Q?oBTzpDK/9tWSE28zIq25cIeuWn5YgvKB7KmsytoSCIMt0eBKzzlgByii0QNj?=
 =?us-ascii?Q?AItO7no+o8q9vuJRyKo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa1e5a0-b40e-46f3-85b4-08dc5dc25bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:07:32.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fU5OnVZWP1Z1TA1i8liGTq46KXWd4wBcN7YZLnNT9eLxV5s24u/gWTLKn1DqZXKlbu36YUBDy8VitBTVtL7jlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731

Hi Rob,

> Subject: Re: [PATCH 2/3] dt-bindings: firmware: arm,scmi: support i.MX95
> SCMI Pinctrl
>=20
> On Fri, Apr 12, 2024 at 08:29:26AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 SCMI Pinctrl uses OEM specific units, so add '$ref' to
> > '/schemas/pinctrl/nxp,imx95-pinctrl.yaml' and an example.
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
>=20
> I don't think anything from here was actually used...

You mean this not used?
allOf:
  - $ref: '#/$defs/protocol-node'
  - $ref: /schemas/pinctrl/pinctrl.yaml

Or below?
>=20
>=20
> > +    anyOf:
> > +      - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml
> > +      - allOf:
> > +          - $ref: '#/$defs/protocol-node'
>=20
> This must always apply and should not be under the anyOf.

I just try in arm,scmi.yaml:
  protocol@19:                                                             =
                        =20
    type: object                                                           =
                        =20
    allOf:                                                                 =
                        =20
      - $ref: '#/$defs/protocol-node'                                      =
                        =20
      - anyOf:                                                             =
                        =20
          - $ref: /schemas/pinctrl/nxp,imx95-pinctrl.yaml                  =
                        =20
          - $ref: /schemas/pinctrl/pinctrl.yaml                            =
                        =20
                                                                           =
                        =20
    unevaluatedProperties: false =20

And in nxp,imx95-pinctrl.yaml:
patternProperties:                                                         =
                        =20
  'grp$':                                                                  =
                        =20
    type: object                                                           =
                        =20
    additionalProperties: false                                            =
                        =20
                                                                           =
                        =20
    patternProperties:                                                     =
                        =20
      '[a-f0-9]+$':                                                        =
                        =20
        type: object                                                       =
                        =20
        unevaluatedProperties: false    =20

But the following example always reports:=20
                pinctrl_usdhc1: usdhc1grp {                                =
                      =20
                    sd1-pin0 {                                             =
                        =20
                        pins =3D "sd1cmd";                                 =
                          =20
                        nxp,func-id =3D <0>;                               =
                          =20
                        nxp,pin-conf =3D <0x138e>;                         =
                          =20
                    };                                                     =
                        =20
                };

arm,scmi.example.dtb: scmi: protocol@19: Unevaluated properties are not all=
owed ('usdhc1grp' was unexpected)

Do you have any suggestions on how to write the yaml correct?

Thanks,
Peng.

>=20
> > +          - $ref: /schemas/pinctrl/pinctrl.yaml
> >
> >      unevaluatedProperties: false
> >
> >
> > --
> > 2.37.1
> >

