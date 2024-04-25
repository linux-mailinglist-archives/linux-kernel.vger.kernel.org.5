Return-Path: <linux-kernel+bounces-158243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A08B1D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177AC28667F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBC86243;
	Thu, 25 Apr 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ji7AtjCl"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F58289C;
	Thu, 25 Apr 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035965; cv=fail; b=fVl4LMMwCdtw5oCKUlrRXRpKFrIWT0JuvzxBru0AGkChVQfZkr2sIxfkXwxYRaTHt+rzeJni6LzyMoJHREXTSaSAcuVwlvmSBJvDciNw6C4uzL9fLFnF4zAVSJuRUnemGoE7zs2F/gueO0Jbubupc21oZ4KqXSBUPvCiWPLWq4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035965; c=relaxed/simple;
	bh=rRq9O22K9eU8qtFwG/9uz+wN6WeMu2Yq1Me3zglNfPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbaIZxGVnNjtFQh/0MMTfDe+gCxq3UBlEDhGPYO5RFX61qO/SmRDKHwy/+OaKoeWGRD48ffrS4BufiAPgs4ZdZuqk6rhlwom28L8UZByZvjpmzVjBPaETSF+L/7vm186lL5If/1/6xqJcsM6/TnEKHA7ADCHGTEZ9fTi6l2v7yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ji7AtjCl; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ/2jM/uIVUTZColoe9Eqq3PLlQoJfeu4a6Xv8xTWNRZgKkUSvZypc+2X8LTxT+wGF0zcx+gWGKUCZDtCmS9dkOag8JN8SMmlqUxE2GDqiUdgIPn+xCZbPCOXdDwkd6J5AEFXNhR3cb0ORwOnFDmWJPBIBR+C57U6dogIvkR79Bp0F7JqB9i0LQpZyMZOk1ufgrEc3C9SmXOOZNB2M3A0ji5PCE17RcnkVoWJChrWyj81wqIK/8/ra7OmMWKMWVV6yHXkdaMudq64CzCiriRdFEUxNy1P5K/+9rvhTbXatJYJj4xabPm3bwTnB3dWQIKuX/pq+9rux7LK2Ss+PDrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAuw+E2EPrp1ffpnEbTWcuHc5HKDozRTQ7V4EKVdARQ=;
 b=eGGmlbhpmoedEd6xkiVYS3LdWxSG68ac+QxqxB7PybIXJLWm6RLNbgtdPtFH5BAyvNxBUcoTqEBAsR0uaZTYdWy4E2vvPiGqXJFO4xdfk+Syp+GmX9IVzG0stiyTaDGs/MJGltf3RghAGcL2GN0Zob9yCPkjUU4qpj/47ka0wiirxnqCCp7Ed6ue3E6v7L3+PUPxP96nynlIu2RfBvBA/AA0m/axIw9MLOGB1Sn6G/sZZzUDJ0SkH/g9ChEXI5Zkr0n7ARyQ6il+sMAZ4eZUWI8dYcZOfuMmvVz5WSHnMiSCswpYwJLp7lB9sY7j0ePsyJUPSXaNGsyyYOPnnZgK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAuw+E2EPrp1ffpnEbTWcuHc5HKDozRTQ7V4EKVdARQ=;
 b=Ji7AtjClWlzEHxURUw5tpm7s99CXv1BOR1ofEfv0en2Mue6P+q7HAn1vPALPe9A84aXRFb5uz0xSOHtorntogk+TLTVAOqOuHOIp33/m9ddKWi7AB8AvQ0siZoZk3XooerhFGnkIg/aXBuj+fzh50kW4qfbdyT8UMTrg6IFHe5o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA2PR04MB10334.eurprd04.prod.outlook.com (2603:10a6:102:417::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 09:06:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:06:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng
 Fan <peng.fan@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Topic: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properties
 for i.MX95 Pinctrl OEM extensions
Thread-Index: AQHakTp0F0gZzKwEJ0KLehvuXBXWtLF32SuAgADPKOA=
Date: Thu, 25 Apr 2024 09:06:00 +0000
Message-ID:
 <DU0PR04MB9417C67342B1DD6CC299B4CE88172@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240418-pinctrl-scmi-oem-v1-v2-0-3a555a3c58c3@nxp.com>
 <20240418-pinctrl-scmi-oem-v1-v2-1-3a555a3c58c3@nxp.com>
 <20240424193007.GA329896-robh@kernel.org>
In-Reply-To: <20240424193007.GA329896-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA2PR04MB10334:EE_
x-ms-office365-filtering-correlation-id: ecd6c50c-f6ff-48dc-d640-08dc6506ed1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gmGPOv+qgJRhjaAaCTLL0biUeKELtUMIiwAAaoSvDxHaDsIoZOVyOs4ypaHP?=
 =?us-ascii?Q?YXiXg69tJOCnv5DCFUmOhjk4tfU443DwT48LjcJT0T1uT3ywSGeyi9XhLDCW?=
 =?us-ascii?Q?da4kuZFBVQBh8jA1RhFTUH4n06waGa/M91yFVV6YxqLPd6iT0mgjqCukh1yT?=
 =?us-ascii?Q?V1IvPnhGYnrmJLLj5SjMvFHOCJz/z2Xv2/wkKe0bSqhsr3oVCsZOfyDcaRqD?=
 =?us-ascii?Q?sTApMpk4chChGEZGemz8kBAirA5R/fWY5+39591zV0L/H5cOwiX8xBU2quh0?=
 =?us-ascii?Q?NO3eTK1Mvx+T2xPpHiWw5iiWDoD23TYLKs5viw/Ngvjkwe8PnBUc4OMAqfKi?=
 =?us-ascii?Q?lkSJdAWG9E4AVvLGfdKqpIona4reCaM4SkfANjChWL8UhzZnmW+rmvDD/3DB?=
 =?us-ascii?Q?Pqo4SSEWrfdl0VO1pnnMFPoO0zFkw75wwM3984mDu9exogPwPY8mtizxbrsP?=
 =?us-ascii?Q?3oN1U+/SWb2JEDqb1+y/WC0ayOw2UO7/fO15Hzy6GfFvEsErN9mR58ej7yGv?=
 =?us-ascii?Q?GcvKRFacsVCCHNm6pwQi5y0cCSe3Ik29ASMt58OqfcpaMb301boBEickIBIq?=
 =?us-ascii?Q?vNVjVKBcWpRXSE/OHMsR54Kj5H0BmXHCLgO8pHHu0TmVJU7eK9wSnW6PhBVM?=
 =?us-ascii?Q?5/9lSxFtFkzYHT5a/U4zQ6l9onCaqDxFeawfVrYDgyPlSOgtRX1rwcxAw0rv?=
 =?us-ascii?Q?tysHFvcpyIG722Yl7uk007QJsSj1GD74hOhaEijfFqs4ttsf7FZWs72hB8/N?=
 =?us-ascii?Q?Umu+/ujmtsCa3O49/JqKXUHetlkz/d6Qz7V1TfUETppmUuSXABmVqBeQp87K?=
 =?us-ascii?Q?COcbKeZLPm6udNr2N0s3vX4M0aOyLDLi90BGvYAZ76GpSDs9stGfiyvozfrG?=
 =?us-ascii?Q?obqD7+kDUsrFEI9WU+9t13KUCh8M1Tq1uxhNDP8QNrpIVplgjbf9YaEHFHHe?=
 =?us-ascii?Q?b8u01MFkknamGKUWIxV/Bvfik94f/8YtaXFj+eRoSG7ECCApJdq0ejDAVYmf?=
 =?us-ascii?Q?93SWgqwS/0jyk8/HAa03U4JHc4eBd7k3PnHpnXBFyV70kjmwx6IRhL0IVY26?=
 =?us-ascii?Q?jIzsL1z0I9GhQVXBU3+JoU38svasFOBfiJ1spWJK9jcA10P+W6JWKYAXrvbi?=
 =?us-ascii?Q?WESC0QGOKNvsQnGXlfMAzva0vnNBJd+fsI3JfA07j2voGH0o85/G5izrbGon?=
 =?us-ascii?Q?4gx2hpc9BYJapuPXNbp/pun2cXRBFHcFPEp3kZI2sAFe3zfPSr69+SwlSyi2?=
 =?us-ascii?Q?TwVo6+wtmEipgc5dJb4G4JN5KFO3ifvt1HF0Ksjnmw3Ty2SlzW0q59evJLDn?=
 =?us-ascii?Q?kyiVoIVcrTSbDQbftnpCBs9wDV/bKJuuemJ+E7+cKPJL3g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nrPWP8Y16FWF/euAGZcGwu3iTtH9XPaKRO2AQZZJPG6p/l/B9nRu/VXKWZH1?=
 =?us-ascii?Q?cYPSIdlD5XMWcpEJOLP1sAc1YR/iJoJaEdP22XccN+Yvc/UDTDhUs6AFP+co?=
 =?us-ascii?Q?WABxxjFKo4jErUzGnfN7SAVz+U2/6qG/3QVsUssjRMrf6I+JwkhG7DYPffu3?=
 =?us-ascii?Q?ZYccLPFrMFI4Qsp3HGf3DkmjXSWIhGlnKQngYPJrPIuk2IjkpMIWjSZ4R2pT?=
 =?us-ascii?Q?KEDb+VdRSnqZI81u4Mc+eLHrFNvt2NQ9ZTHaX6ITXHaQqN25dC13cc1/siDO?=
 =?us-ascii?Q?qhoFDESU8GonP0FNVN4gpCF70/rr/7AdTr+7lB4ptFptkGPziraedVBq4Cr/?=
 =?us-ascii?Q?/Nh4DARW8bX5jeSlY9maV68HtvhlkO40rbzyzijJoajs6C+Wz0FUXRdswWq1?=
 =?us-ascii?Q?0MtrJFYjHmcsqPfull7SW1BmD9dsu1j6mUixiQS2PM2yGtjYDduyqLDuapbu?=
 =?us-ascii?Q?z2AAbfKrkFlHHSx2rf335W5BpJJzVMLBH8G8LLb3dQCBak0HaCwkkxVReTDp?=
 =?us-ascii?Q?+iTt4ky1AsJIxpbhTvDjI809EWeMENyr2TLFgewqawE99Abat94yubPMqAYH?=
 =?us-ascii?Q?p0ak0Ph90+3xGKb2PUZt34iiCbLcJ4c4L3uo5PynbeobrGxJs8tJapU/xZHn?=
 =?us-ascii?Q?pqVM43jnbQ4XiHYrIj7eIMmh28qv2pdJLIt3qata11XtFErpoLL/ZmquWQcz?=
 =?us-ascii?Q?URFTenLJQkP7Na2oIrWiLFFGXGuBvSoqspdKxPAEKR9ISqoZXNCT5Tt7A7zn?=
 =?us-ascii?Q?OSPcf/6O0QJxyoB2/ef9i7lAsJ+t62hshNkLsbhuymkdP1S6ME+I5pFYouRq?=
 =?us-ascii?Q?TX6GoXm7wuvpYSZ/snIEXUlfvXgCoMJPK6841gWt2yDOmqqd2XLBCyYfiInM?=
 =?us-ascii?Q?0ppcI058VaYFpeW/0+j9oKxp7P3deHLVNF9GtUIK2etsVWbi1A3PpAeuRtTe?=
 =?us-ascii?Q?5sfRquDsiz3rzlZ2YwN/JHoduWcqD3MM8dkb6SXD9P+XPg5HNNwHp3nmMJ8q?=
 =?us-ascii?Q?xXXy4NEM3zDewiiIa3zXMrdN9yV2+SxGlB8KY+nIZl4bIycy6lRI8x3oS9o8?=
 =?us-ascii?Q?wMlrK4NX01T1smcVBMuTmlfGMbgMxCFkY2418CY5KYHS1LY33i7HONS3DjlM?=
 =?us-ascii?Q?SRitMjpq2XK5Bo9527XlUxSLSqJLF62OX7SLBslfINV5uOfaCmqdTWy2/qmv?=
 =?us-ascii?Q?kWS5xb/TT+Bub45d5+/iB66OwLGvK5Jexvu/r4drQwFoNf60SBNABqEHQ/+p?=
 =?us-ascii?Q?W6hqKZHBJrMoWlxYPpBdrhJfa/LV4iI4uevjJMawaklfiptW3y+sBmsZgwSS?=
 =?us-ascii?Q?gK5DwtSQwBvcZfjDapu7QnxUcgXl5i/lFKrkIE4F5vvSFs0n0/mfTlXxuTxt?=
 =?us-ascii?Q?/KoZ5Qoqv/cQ/dwjtjVKEZrST9WJfdb1UMN6ARwKDE5Cq8ehrIweAeXPWqHD?=
 =?us-ascii?Q?LE0pUrYmesbLMQOxEoWLf3NhNg6jWaXJ/oRwv9H2blqhppOb6t5lwwLMXyVP?=
 =?us-ascii?Q?N4WFtXWgpeK756R1iI3Daz8XrQERkLQ3N8c3BTuCSopV7JZW0oylAho7s+gm?=
 =?us-ascii?Q?3IRjQdJfOqyZ5Y4gxw8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd6c50c-f6ff-48dc-d640-08dc6506ed1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 09:06:00.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AguWZBalBz90yNTsIDAVpHIrIaKceZIkxVmqTUIQwVDY+fzFkmfI9g1Wks7BqBDTewEEI224UF2/6AXPDn6hHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10334

Hi Rob,

> Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Add properti=
es
> for i.MX95 Pinctrl OEM extensions
>=20
> On Thu, Apr 18, 2024 at 10:53:17AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
> > patch is to add i.MX95 Pinctrl OEM extensions properties.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++-
> >  .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 66
> > ++++++++++++++++++++++
> >  2 files changed, 72 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml

...

> > +
> > +title: i.MX System Control and Management Interface (SCMI) Pinctrl
> > +Protocol
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@arm.com>
> > +
> > +patternProperties:
> > +  '[a-f0-9]+$':
> > +    type: object
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      pins:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description: name of the pin
> > +        items:
> > +          enum: [ daptdi, daptmsswdio, daptclkswclk, daptdotraceswo,
> > +                  gpioio00, gpioio01, gpioio02, gpioio03, gpioio04,
>=20
> ioio?

Yes. The name is exported from SCMI firmware.

>=20
> > +                  gpioio05, gpioio06, gpioio07, gpioio08, gpioio09,
> > +                  gpioio10, gpioio11, gpioio12, gpioio13, gpioio14,
> > +                  gpioio15, gpioio16, gpioio17, gpioio18, gpioio19,
> > +                  gpioio20, gpioio21, gpioio22, gpioio23, gpioio24,
> > +                  gpioio25, gpioio26, gpioio27, gpioio28, gpioio29,
> > +                  gpioio30, gpioio31, gpioio32, gpioio33, gpioio34,
> > +                  gpioio35, gpioio36, gpioio37, ccmclko1, ccmclko2,
> > +                  ccmclko3, ccmclko4, enet1mdc, enet1mdio, enet1td3,
> > +                  enet1td2, enet1td1, enet1td0, enet1txctl, enet1txc,
> > +                  enet1rxctl, enet1rxc, enet1rd0, enet1rd1, enet1rd2,
> > +                  enet1rd3, enet2mdc, enet2mdio, enet2td3, enet2td2,
> > +                  enet2td1, enet2td0, enet2txctl, enet2txc, enet2rxctl=
,
> > +                  enet2rxc, enet2rd0, enet2rd1, enet2rd2, enet2rd3,
> > +                  sd1clk, sd1cmd, sd1data0, sd1data1, sd1data2, sd1dat=
a3,
> > +                  sd1data4, sd1data5, sd1data6, sd1data7, sd1strobe,
> > +                  sd2vselect, sd3clk, sd3cmd, sd3data0, sd3data1,
> > +                  sd3data2, sd3data3, xspi1data0, xspi1data1, xspi1dat=
a2,
> > +                  xspi1data3, xspi1data4, xspi1data5, xspi1data6,
> > +                  xspi1data7, xspi1dqs, xspi1sclk, xspi1ss0b, xspi1ss1=
b,
> > +                  sd2cdb, sd2clk, sd2cmd, sd2data0, sd2data1, sd2data2=
,
> > +                  sd2data3, sd2resetb, i2c1scl, i2c1sda, i2c2scl, i2c2=
sda,
> > +                  uart1rxd, uart1txd, uart2rxd, uart2txd, pdmclk,
> > +                  pdmbitstream0, pdmbitstream1, sai1txfs, sai1txc,
> > +                  sai1txd0, sai1rxd0, wdogany, fccuerr0 ]
> > +
> > +      nxp,func-id:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: Indicates the PAD connections which function
> > + module
>=20
> The description makes no sense...

I will use below description in v3:
For each pin, there are up to 8 muxing options (called ALT modes). For exam=
ple:
Select 1 of 5 iomux modes to be used for pad: DAP_TCLK_SWCLK.
000b - Select mux mode: ALT0 mux port: JTAG_MUX_TCK of instance: jtag_mux
010b - Select mux mode: ALT2 mux port: CAN4_RX of instance: imx95_wakeupmix=
_top
100b - Select mux mode: ALT4 mux port: FLEXIO1_FLEXIO30 of instance: imx95_=
wakeupmix_top
101b - Select mux mode: ALT5 mux port: GPIO3_IO30 of instance: imx95_wakeup=
mix_top
110b - Select mux mode: ALT6 mux port: LPUART5_CTS_B of instance: imx95_wak=
eupmix_top
The nxp,func-id property is selecting one ALT mode.

>=20
> > +
> > +      nxp,pin-conf:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: The PAD configuration
>=20
> PAD stands for? Or is it pin configuration as the property name says?

It is pin configuration which includes pull up/down, drive strength and etc=
.

>=20
> This is just a raw register values?=20

Yes.

Why can't standard pinctrl properties be
> used here. What's the point of using SCMI pinctrl if you are just shuttli=
ng
> register values to SCMI?

Standard pinctrl properties will need more memory in our SCMI
firmware design. We have limited on-chip memory for SCMI firmware usage.


>=20
> > +
> > +      nxp,daisy-id:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: The select input register ID
> > +
> > +      nxp,daisy-conf:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: The select input register value
>=20
> I remember some daisy chaining stuff in iomuxc, but otherwise
>=20
> What's the relationship between these 2 properties? Is it valid if only
> 1 is present? I doubt it.

The scmi firmware will convert the daisy-id into register address, and
write the daisy-conf value into the register.

 Looks like an address and value pair. Either the
> schema needs to define allowed combinations

The firmware will check whether id and conf is valid, is there a need to de=
fine
allowed combinations? There will be lots of check to define allowed
combinations.

 or design the properties in a
> way you don't have too. IOW, make a single property that's a tuple of reg=
ister
> ID and value.

Define tuple will make the property not able to use linux generic pinconf
driver. The current parse_dt_cfg for custom_dt_params only support a
single u32 value and not easy to support tuple.


So could we just ignore the allowed combinations and use not tuple?

Thanks,
Peng.

>=20
> Rob


