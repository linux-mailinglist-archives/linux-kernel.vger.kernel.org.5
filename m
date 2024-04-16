Return-Path: <linux-kernel+bounces-146863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33778A6C05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42E81C20AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707A12C481;
	Tue, 16 Apr 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RjbKUFye"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265E3BB30;
	Tue, 16 Apr 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273567; cv=fail; b=SSpjiue7gLgEhaZgzIdKbtyFT6YCDZcn5by8U+mP3eprfgC4n+SwxrM7Y9oqTkDr1+kX2Rj4FNMdF3kUS3cqZt8rCYBa9DW3t9pZRyMcUo7JlHGfbvBLb4wB7Ipaspw8cqiL3WkvBkOPfISY/tTNx16diaY1EAb9VxBxqeFaml4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273567; c=relaxed/simple;
	bh=KR/VrV+G5DdKvF2qawzBVBKExvS7/HQgWNxrT2AzNAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TdOrXuZLZmOIC4SfqvGO3r9j3R6loOTeKqzHOAfBJV3yWKVIwpErwRGST0kyjQUGleyzfp2ukxPi3AL08AGkPmeiRVliDHgPwt0rHC0wzRf/gB0VBLwuynBUurs56QIu2P+8m6gYvTFXtMwbHYjhESf7A1gMX2+S/cD1xewxzO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RjbKUFye; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljQwafFy/kjBCtXLDhZbmgIT9oNlK0GHk9kCFF2Xe1g86klxGaz8UgpCZELxtHYKxZUgR+hI0RPBBtjVumWrbZCMnDqI5HF1bh2jCUdKwtRcHyiEc6gmZiX7sv6OThuU2d9xpxifUHAhXWm0CSr0CxRtsdriCBKFfDXubfiKC9TyZ03W72SUmzrMMgN6Im/fEPuAzCaQUQaWIjdEZQgNEDkeBrJGEm6VrlF2GErKT964fteFo+Uer6tQUFxkjLuwbI3sSyP4ztNM3xj045p9eFnGuv25DBkzU3dt4AiOM3RYRI7F4B36fSxJPnrsowXMlDJ8lhDVBxim3In8LMwLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqevLgnm0Wdwaly5aA+vuWQBjA/iUQZ0g4gkgcuypt0=;
 b=aZQpP3yi86S6Vhqd3575WzskQOoLpFSgOSDsW7YyZ4mgcd0womdPPHYtHiBnqA4GRY73fy086SJ+aHsyfqOnfhBsKd2Be4xgoYikmL03QqMb4Chcep5cQDBPPowaz0z8J2gzLPG+UNKySvLaYyS2KQ7lsPB0oJ6mCVbJDdRgCS1iP/+1aKGxdSX17SdCsROb4uuF/kyREjL14GuliIzsseaqCla6JT1lUWAIUozklA52uj9GTzMTnT94NtZNy0lkPkEQLFiYPK25F0d4dW/p+iZ6iCYrSfcnj24nYKQ/8v/47KMUDLLneryXLADjABdVxg1s95OWcfkNPw4gIH2Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqevLgnm0Wdwaly5aA+vuWQBjA/iUQZ0g4gkgcuypt0=;
 b=RjbKUFyebefIdEqVExh8W08hwfVTktqu1qj73PlWTHWb3SyT5sQxp8sCduNYW1F5X6xA2bXkb9E862ZKKz2hkRlb1qg7jGxuEMPZYBcA+q+Dl2ZezXgjsRVavgrfr2yz56otsQKLN1eLCYSZPCUjX2pfA8ZXcxdfgPJtiUiDsc0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 13:19:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 13:19:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Jonathan Corbet <corbet@lwn.net>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Thread-Topic: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Thread-Index: AQHajMWwPzKaKnlwaUWTuAs/m6AnGLFkopsAgAADorCABj4qgIAAAx8Q
Date: Tue, 16 Apr 2024 13:19:21 +0000
Message-ID:
 <DU0PR04MB9417D5A577A5E91AC98B69C588082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
 <20240412-imx95-bbm-misc-v2-v3-2-4380a4070980@nxp.com>
 <20240412133400.GA2282201-robh@kernel.org>
 <PA4PR04MB941680A7FCBCDF926417F6A388042@PA4PR04MB9416.eurprd04.prod.outlook.com>
 <20240416130703.GA1992329-robh@kernel.org>
In-Reply-To: <20240416130703.GA1992329-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9438:EE_
x-ms-office365-filtering-correlation-id: cb67333e-655c-406d-3160-08dc5e17d439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wLRSyMchFwbmW/rRWhOE2V6l4WqN0M5cc28HjA34MjvmBY99BKe4O0rt8chUvTlHE/LJRPC/ibLR+OQ2dJmwj4hsFdJqa5paMKhBhm1gI5OFtG2gfBMQaFwIHLFKquY1ztoJW+brB23QRNYPyfrJ2E3AdJMUZOORHNUP92lE5IjCySfY67tMHfPArHPSAI8ZfubAHTefB+vvi/z2NmXbl/rnsSr7ClaRsuClQwDZ01u35S5IlHjeFRG2DcrtYJQG5N8Ebzn8/y4GOg/ebjwrplPTOmkgUzb8UMlFcEBh1FOqbTRl0DlIw9kh+G4oo23P+nmpyyjBMMaymyWK0sfgMyhuZMUsJPX3oJ5wgdknaQbwyskdxakNvOedKqa1lt2xJA+4htHnlgsv+E3rB5l+Vhsbj3EzICK6qgBeYtFsxTRfNHoIFSvaThtZTjnJ3iL/sg7k+VuD385WqaI5YcQQpUaq3dewF+1JYWZIQQ5IqcVECDX3qUiD93NImZISYwGW760vGNYbDW+4TahxMABCLT3JskGRONdXR1XRdZ0pdtMM68H5uF6pLnBpqVqlIcXh5BF0xkKNMcBkb074/zXvxh7eFYXI1zBq0M8O3ETTc4+ouI1PRbtJDVhkJEm/3lAqm0XN9+Cp2Jt49cSZNY5rwb0wwlF1uKJuAN9Cmm1DUDR/IQJEEkZGC3wZrh0Gfd/zMnBXd/V/+qoU2yOXH3Ajaw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XIyl3yizMrlQt6H1YAk+Zvp/QjSqO7QyFSjFtO26JaDBbIuB6/5TIWIMsUVH?=
 =?us-ascii?Q?as94ZwjGYPZEoRlvyt+5iZ3RAMCgbpWBlS0/zfSIFSm5u4L9TtaDKMVu0pUz?=
 =?us-ascii?Q?iFnqSeOaaJyM+PbGddf7k94Z+EO/QDMp2y79TfnG9rCuaIyhuHNhYsdUXu6V?=
 =?us-ascii?Q?k8ovCKePdfG3sWKBCNzQXiIIUPwOCcWu0JuWtGxDr9cuKOZtpowRuL/WVFSH?=
 =?us-ascii?Q?05KzvL+deU1ZBnQlw1nlAycexg78stLnnVBEcGEOlLZTkCTbKSgdUhWGKTte?=
 =?us-ascii?Q?GLXA/OhTwtgZyOCKzKhqO9TIPAw7M5Q6nrwCAqiOY1DdrXjtmVzvkrlyN+9A?=
 =?us-ascii?Q?79IddHpyqJP6tWghudBvewXYtuL8D7vEEqdZebr24cE/MEdCtUuPbQ8PEqi6?=
 =?us-ascii?Q?yX99hfiQVjA/EiAJF1GqXVriacAGt0vqMZHaRPg+aYQOTL/EKBovWflJ2h6J?=
 =?us-ascii?Q?/+gEg9NuoBBkHC2FHEZh2e+KzGJNk6f1T9RJ8UrHuc3mMO7cReuYGhSq/GDS?=
 =?us-ascii?Q?4g0R4G/bbT4d4UBjZpzeUyh+cawcmWBlJuAWyjAKuGf7ssKYx0sMyZP/8ITs?=
 =?us-ascii?Q?PJxDW/ZJiabmh5Xt4SLEl0i/RYXWwETcsP2VNEloMJ1qYBBSaMR9t12j7M+4?=
 =?us-ascii?Q?xJBIeBEumVD+Xd3yBYcKIP3MarbtYk4qPYdAlDHI61dwbbCVM6dHuV9Gti8M?=
 =?us-ascii?Q?IkQrc5xCXQvPaqgjYpZzhy+jvHnMz60+rbTPzwprvsLp/QSt1NrQPzEFfT2K?=
 =?us-ascii?Q?VCGqScqfzmQJGlPccqSh5qHPdTc4qqpzE1d/KLETLAT1n+hpWqt7NkL/dydU?=
 =?us-ascii?Q?qvUoX0Es4WpJKa1cO4pDdyOtgQD/pQOU1JzamE5fvbKenQh+ED11adxj/5ih?=
 =?us-ascii?Q?m1U3FNUKtNggFejaXQyJY0vw7+SXj/1SN2Tm9gSYda77nuNJuKuqcdCq216P?=
 =?us-ascii?Q?1uKXq9BjHce1dr3HQLmc2AMPTcPHI8s/dr4r5wy8hqPevqVE40/7IrKCy+3e?=
 =?us-ascii?Q?/Gp4wESZOd9ILz/K9aAPL+8HcJrCNwNa22dMKmisjtmO9gHJ2nb89nd8EjoI?=
 =?us-ascii?Q?iVEIHfA2R0LOPrsBCKXHlUAprvXqQ+Y8KmsBW51S2IOPr1Sl45hpq5AyLbyy?=
 =?us-ascii?Q?dv6xPG3UGckTNxw3H+7BdUFahbulve41zMGEzfUB8XQk3oAHqpHrXK7jSncV?=
 =?us-ascii?Q?a8gQelsams4zRLH+P3whnFMj1e5Jj4XB/0kL7Z+x+lxFeZ83dkpNJRPQMFWj?=
 =?us-ascii?Q?umUSTRq9e1piGJh/xRT0KedF4cWTACeYS/PB/l0/xLfLmoKHvf3jj54Uzfc8?=
 =?us-ascii?Q?9Uzke/KnEa1qTSFuq9oqalf6v6FuSz4hrlxUApb3VXagPsVET5+Q9QO3mtWh?=
 =?us-ascii?Q?ntv5hQ5HLs0+d7jYaXMJr1aYwMDaZcmoty5eNd03ENB7ppeudsKmVYNH2qW3?=
 =?us-ascii?Q?b6iPFsJ2N+VWPWcJOdl5PKvQiE/4v8+cXvOz50E2hGwo28a7xEuERV3Y++8R?=
 =?us-ascii?Q?+J/Oq/nx/zaH4A12WujmKui9k+ki4S+ntgvmEC/Z+uTzQTV/0LJlFD59xKVF?=
 =?us-ascii?Q?LFlGhcCs2AlPN1VQI2g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb67333e-655c-406d-3160-08dc5e17d439
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 13:19:21.7453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgHprwJcEoyjBmelzh/PPE+dBTmSmIQ2g1LMFy3mlVtdF+ipPoM3CwIdPBfWeHzKYwP4MzDkUI6Szpz0oqHavA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

> Subject: Re: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI
> Extension protocol
>=20
> On Fri, Apr 12, 2024 at 01:50:37PM +0000, Peng Fan wrote:
> > Hi Rob,
> >
> > > Subject: Re: [PATCH v3 2/6] dt-bindings: firmware: add i.MX95 SCMI
> > > Extension protocol
> > >
> > > On Fri, Apr 12, 2024 at 06:47:08PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Add i.MX SCMI Extension protocols bindings for:
> > > >  - Battery Backed Module(BBM) Protocol
> > > >    This contains persistent storage (GPR), an RTC, and the ON/OFF b=
utton.
> > > >    The protocol can also provide access to similar functions implem=
ented
> via
> > > >    external board components.
> > > >  - MISC Protocol.
> > > >    This includes controls that are misc settings/actions that must =
be
> exposed
> > > >    from the SM to agents. They are device specific and are usually =
define
> to
> > > >    access bit fields in various mix block control modules,
> > > > IOMUX_GPR, and
> > > other
> > > >    GPR/CSR owned by the SM.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 21 ++++++++++=
+++
> > > >  .../bindings/firmware/nxp,imx95-scmi.yaml          | 36
> > > ++++++++++++++++++++++
> > > >  2 files changed, 57 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > index 93fb7d05f849..fa2cc910c485 100644
> > > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > @@ -247,6 +247,27 @@ properties:
> > > >        reg:
> > > >          const: 0x18
> > > >
> > > > +  protocol@81:
> > > > +    $ref: '#/$defs/protocol-node'
> > > > +    unevaluatedProperties: false
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        const: 0x81
> > > > +
> > > > +  protocol@84:
> > > > +    type: object
> > > > +    anyOf:
> > > > +      - allOf:
> > > > +          - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
> > > > +          - $ref: '#/$defs/protocol-node'
> > >
> > > If you put the ref under the protocol node, then it's 1 schema file
> > > per protocol per vendor. Also, we then have to list every possible
> > > protocol node here, and every one listed here will be valid for every
> vendor.
> > > What we discussed is putting the list of vendor protocol schemas at
> > > the top- level here and then the vendor schemas can list out all the
> protocol nodes.
> > >
> > > Also, move "$ref: '#/$defs/protocol-node'" to nxp,imx95-scmi.yaml.
> >
> > In arm,scmi.yaml top level, add below:
> > +anyOf:
> > +  - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
> >
> > And also add a protocol node:
> >   protocol@84:
> >     $ref: '#/$defs/protocol-node'
> >
> >     properties:
> >       reg:
> >         const: 0x84
> > But here I not add unevaludatedProperties =3D false; otherwise the
> > vendor yaml new properties will not work.
>=20
> Just drop 'protocol@84' entirely here and change the top-level
> additionalProperties to unevaluatedProperties.

Thanks, will fix in v4.
>=20
> >
> > In nxp,imx95-scmi.yaml:
> > properties:
> >   protocol@84:
> >     $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
> >     unevaluatedProperties: false
> >
> >     properties:
> >       reg:
> >         const: 0x84
> >
> >       nxp,wakeup-sources:
> >         description:
> >           Each entry consists of 2 integers, represents the source and =
electric
> signal edge
> >         items:
> >           items:
> >             - description: the wakeup source
> >             - description: the wakeup electric signal edge
>=20
> Constraints on the items values?

will add in v4.

>=20
> >         minItems: 1
> >         maxItems: 32
> >         $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >
> > additionalProperties: true
> >
> > Are the upper looks good to you?
>=20
> Yes, other than the one comment.

Thanks for help reviewing the patch.

Thanks,
Peng.
>=20
> Rob


