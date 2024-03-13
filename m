Return-Path: <linux-kernel+bounces-101058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42A87A1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2B91C21D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18169DDBB;
	Wed, 13 Mar 2024 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BenxyVSo"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8038B;
	Wed, 13 Mar 2024 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710298087; cv=fail; b=cNNgYQEAax+1LMFXijZOhWQVchOj9UIjod7mIV/xH22hleMH7dAloQSmPJEwexSpeQODZ9YAp8IEGSwSHEAZSvLkFK7PTmMwbeWp1wHXBW7meSeYigHRttOQCiFiUKO5hUb9EOtSQT7GabYuVsWeGF7F0cwTIeBDYS3a0k0mJiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710298087; c=relaxed/simple;
	bh=6OXC4j0bYZVekeS5AlxY88qypDwivl3zFhUxqVB9OSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFSkkPt0vLyGKpfDLi0cfv12U9lsR2laVxbfghyvF30j6M/2xbYYn7sotQNh9CsDlH5yKw2oztACn3DIZmhdNB5XSzp87cTTB8frx1rhVVEcdDXlsvu8Brqw03UTRpfTFCRNxW89Nd7legPObQ0qyzk0Gm+VjgN2agiOOwupNps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BenxyVSo; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7VmlhQUiQZj4QRJXL30PIwiATSFYPaPrjK4xr3lrKTq5caD69CuxApxfEjteCSZD/vmEhSj0VpMvcbidbs9rf0TIcBEzUouFBSl0iNu/gGRw7cfR2VhZcwW2zG64U8BviHzcF7ugSVxs3PF3YDl7EkSkjHrbxP3/w7QuJHqkj8s2dR8qXagULMrZFgMYQqGTI8ZMi7N5ikNlWk7bDeC1n2R0zNQa58mcGgLWGKrAP1sILdVD+PHNirfNfWej61kUTCMepjjWFLCqZH7FD4ATTiaE70W8uqIQ6lRdxZAzsk5t398H8cRxqysu0ZkolBSj8iJFlut9u9Rqr+KtaRBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4StoFe/ReBiKhyyAM7E5gD22X57lOD3SdDgiCs63qVw=;
 b=QhDzVKc8mRh2TSQ/Pe3vg4KeznckY/jk1XN570w7lINR7DHv0yVtLdhqjZnpLXNF8BkC+3rLQ3wobe0o64bzlUSqQf18LMIrk8nj980/HwEEaDrTiCqb1wetxuilfY9FbKb99pmX1gpj30zVKWMu2rWNFstL6AGiXZtUqEN2pfe678o3UOiQ6a78s+JwAXMtumniIlODG5GjoYbljM+5BZD38X6TSOLBslsRqLe0gxkZRjWZSovb5nxzsAxkOYb1EtDYJPkn1BWDi0O73zwJTo7eghrxzPNy6904RaK/Wv8gLesSyTtnjf1EfVm1oXao/OE/g+4pysDCVBy6U0dggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4StoFe/ReBiKhyyAM7E5gD22X57lOD3SdDgiCs63qVw=;
 b=BenxyVSou0k6gssfxsB/T8mNfWwxIH4j8OEo9nkWLGpbwZLJLBzW2MfHFfut1Wx9Okc9bUEITtds87VfQ+OC0t+etaHAFkelYQVCQP1e3xztYU/76OyD+9Cn39tCQPGY8tQ89chWExRq/CP64SK82OTzXlxbX+F4xZf2xcqgk9w=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9102.eurprd04.prod.outlook.com (2603:10a6:150:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 02:48:00 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 02:48:00 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"peter.chen@kernel.org" <peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Topic: [EXT] Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Index: AQHadF4T9fa4/JJRF0KTO2HRURFsjLE0MIuAgAC6gbA=
Date: Wed, 13 Mar 2024 02:48:00 +0000
Message-ID:
 <DU2PR04MB8822976F9F052E18D7951FA48C2A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
 <20240312091703.1220649-5-xu.yang_2@nxp.com>
 <20240312145035.GA2204647-robh@kernel.org>
In-Reply-To: <20240312145035.GA2204647-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|GV1PR04MB9102:EE_
x-ms-office365-filtering-correlation-id: 559acab8-22d4-482b-44d3-08dc4307ff53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M4dh4gncJ1TVuwg3/YJ0L0Z/WFxxsgptw/O0JpKYpdr98NoJoLKcStfOIAUNnjPi7sl303cTv046aOKRHSUpOcgBLDO54I4Kmt0zrEIbx0/ok32Exqc2f1uM3h0QWc3PzNnM8wseEph/w1PYgfCtZNAOuoHre31KusOO/5iVojD5EFWvOuyuaSwTwMbCx3RI1Hg1H26BkUXNIbIoS4N/iuSjBbsRsRTnxKdjLnOW6TjxQxdfWvEwQbrwYhMuI9V2J6a65eXfiK4isWox0iHF1TOh33qbe7WWQz5FqzU/LrJGjN8/YHSbOA+xEJy0UTTtAYTjFeseZAlgT2+kRK+Wj6A9s93GT4/wR11Tmh2Bq2LRayWG+USHURUxiCxzVwy3CvSUUYCX29m8nQrrjYL/LW9c80aWC/U9+4TpaUfCrbDq5AxuX81zy4XOyUO5VnsbHmtSPafB1Lc7T52Qm3UcplPj66w0QPKYmxBnK3CuLcV7o9N/pBh1YYz6fCqelMwfSZA+B49u0CQdYPV6s5cHedhqgp9Aiqn35+tX1oNJ/D8+hMYGzXXY80MGN9Q9OQYTrwiYSIvOiRW/+qLQgTsbaIrTTtSvnkEDyOV2F4xexEBsPTwaqL2go2j9SDzQ5wk8ruh8eqBmPavR2oLttRvundX+fkMHRYJ6VuB/Gelq0FTyOHP9XepW3gLe5OiQCfsoxa8RTteMm45q4MkN+bxxd/5lTaCafGttaEQWqaeNhQA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B+Se9ZusxlzEysQWaS6tZ+yEhYL1atknGtFGBm3ak7/RsbEzcZbQs4QrU+i8?=
 =?us-ascii?Q?rrlV9/Xw8I2DSgP5ZPblj797kAG5qyGqN57QjGJ0LxrJ6Ur82kJjIttNBsB3?=
 =?us-ascii?Q?s2Q6h43J3hpLJT5/1ZWzkeA8zYbI3DawxYcsAQN8/2GIuqRxPBfOHmxUfdrE?=
 =?us-ascii?Q?t5RQsPpCmJvfBxj3O5QusxSC3WkZSE+BMEfcN3AhqXbpkwxvDAbm4e3eUV4A?=
 =?us-ascii?Q?sb+yt2ilSwQ50XGSZkTtpzemEBdtLHJamIeq1dEzXkfP0z7aVbn3Cqg3rI26?=
 =?us-ascii?Q?ZMGyWGRienT9LbwL/i6ZDy5oyOuHa0YjGiYFsDEitFOU8S1CHVvxg39t49Xj?=
 =?us-ascii?Q?Iy8n4ZSLBD3+ugsHcmwYCvXEcKrmBQ3w4GKg8la7yfd5+lQ5bJJAO2GgtwPL?=
 =?us-ascii?Q?QmkqkrWApyK6uWMoxbKtv0yFNGicc0D6RDgMOUwPxuaPMX9bI55zFUMXyBOd?=
 =?us-ascii?Q?ageIm9eNUWbUp1gtqHut2EMgYZoySohx4/W3n6HJPLbuFmntKINnftLu1IbR?=
 =?us-ascii?Q?Fz/HgsfRw8k8rojaAaABXzXoQcNmbXcvBVEqPBrSvwoZxJChI2Hsxteugko2?=
 =?us-ascii?Q?/jufWAHXX5WMe6yOtWEJuDcbHhkVudEqiVcD83jrFtEtaujyGz4F2H6K9DHT?=
 =?us-ascii?Q?7sx2fD67mrjh8F/529XBzmUARcB81A+eWz/ALMa1Tbogo75qqQRDt+y6FJ+T?=
 =?us-ascii?Q?eSAzUaG8Hm8yYLXCAX2jKgj7mf8aFdP22wCrl6vAIKogNOqz3SVA0UFcxWBq?=
 =?us-ascii?Q?eaWqjlYPAvhaAbp0np7hTQLkPOCnTylRHBl0+qxU5VvlRlZVNsUl8nc2LkFj?=
 =?us-ascii?Q?8/96GUd3u4MiC3z4VRcJahmLFfW9mxNkzMEBM7BmaJqJGklxVANQ6KU45twf?=
 =?us-ascii?Q?ZGiltYc5Pp01DCGNYdA94ELaHf42P2N8LNikYUSHBy5e5vQ9hEgSCKQmCdV3?=
 =?us-ascii?Q?daU1bwgXBgo//ycUk3XAwA9QSKDLlhR+EAQClrncMaIiabRMBpn6oWzqE3zG?=
 =?us-ascii?Q?g70MaffUkcnAKZCAo9ZySRlyKs7OmvdDogPyxFxdRYTF25m2uS2JGQTv84Vy?=
 =?us-ascii?Q?TpZ2n9zuPe6nd9lRBGpzPlr97IlqFHbKMRxCFmYc+I//zodVvuQSHo+cSUhz?=
 =?us-ascii?Q?ki/0YgYqGcAgE6ZNb+9lSKz8ulPN5QdrQPsyN7Qor0U5pul9ukGNpnTwrQ5K?=
 =?us-ascii?Q?uDepRgOWOgSBwk1oSt9+iOHM8q92FEWFzg5hC5fWSxnbebaF/YEdgyz/I74R?=
 =?us-ascii?Q?TQOC4flLeGNgwp8pNwp+HY2VMGqnRf8PqXnbMovybj/q7TgDF49qQCJ6/Osz?=
 =?us-ascii?Q?NatXw0SDoBJE13e/i50Y14ph8RWKfcyGeXIKjIRHth00j+4VzVaDFgKp5kWN?=
 =?us-ascii?Q?CZEM4rkygIxVBF+BMTfLRj6Uvil/MrWziP606xoyJNMaAc0SUCWlHYp5f38x?=
 =?us-ascii?Q?G7cZWpvZlk8Z6XvhNiVLuk4sPhU1Tzs4vZKsHrsT2yLcDu33uy361TIz4kP4?=
 =?us-ascii?Q?ejQLr3r/HwD/tOFaPUUEU9FQFL2LAes0tE+Ss7Jg57NszkZbudo2rbBQ2W6Z?=
 =?us-ascii?Q?AkD8Trhi/ZICpopsjZg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559acab8-22d4-482b-44d3-08dc4307ff53
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 02:48:00.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKpaBP/+0ZcnFJq4m8cgx8rq1o8zdPeztnljAur17Qis0WEyEF5IJVnklPYZL4Da32XxLwIeWPRZu2giArxc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9102


>=20
> On Tue, Mar 12, 2024 at 05:16:58PM +0800, Xu Yang wrote:
> > Add restrictions for reg, interrupts, clock and clock-names properties
> > for imx Socs.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v4:
> >  - new patch since v3's discussion
> >  - split the reg, interrupts, clock and clock-names properties into
> >    common part and device-specific
> > Changes in v5:
> >  - keep common property unchanged
> >  - make if-then more readable
> >  - remove non imx part
> > Changes in v6:
> >  - new patch based on ci-hdrc-usb2-imx.yaml
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - remove if:else:if:else:if:else block
> > ---
> >  .../bindings/usb/chipidea,usb2-imx.yaml       | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.ya=
ml
> b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > index cdbb224e9f68..fb1c378dfe88 100644
> > --- a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > +++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > @@ -49,6 +49,12 @@ properties:
> >            - const: fsl,imx6ul-usb
> >            - const: fsl,imx27-usb
> >
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> >    clocks:
> >      minItems: 1
> >      maxItems: 3
> > @@ -144,6 +150,80 @@ allOf:
> >              - const: idle
> >              - const: active
> >
> > +  # imx27 Soc needs three clocks
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: fsl,imx27-usb
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 3
> > +          maxItems: 3
>=20
> The max is already 3, so drop maxItems.

Okay.

>=20
> > +        clock-names:
> > +          items:
> > +            - const: ipg
> > +            - const: ahb
> > +            - const: per
> > +
> > +  # imx25 and imx35 Soc need three clocks
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx25-usb
> > +              - fsl,imx35-usb
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 3
> > +          maxItems: 3
>=20
> Same here.

Okay.

>=20
> > +        clock-names:
> > +          items:
> > +            - const: ipg
> > +            - const: ahb
> > +            - const: per
> > +
> > +  # imx7d Soc need one clock
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          items:
> > +            - const: fsl,imx7d-usb
> > +            - const: fsl,imx27-usb
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names:
> > +          maxItems: 1
>=20
> What's the name?

Can I not specify the name since the macro definition for USB
controller clock in clock.h is recognizable and the driver doesn't
get this clock by name rather index?

Thanks,
Xu Yang


