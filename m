Return-Path: <linux-kernel+bounces-39562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A9483D2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA992874D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668EAD27;
	Fri, 26 Jan 2024 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iXfaDXPD"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA178F5F;
	Fri, 26 Jan 2024 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238310; cv=fail; b=Dn898myirOAoZpY4iZZ5UGaPhewSHzS64veNBO4DGtaGe+pennEjjEZxby2Bo0x2KCNp3jLH5nu55+rlZp7xn/RL/Tl4RdGn2Klfed2bOzOg9QKN6pkIDwl2E6Sa3CWp4wyCOq01v9wVCBt9vjbG21Oz4LhAZTktPzUjpPylRhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238310; c=relaxed/simple;
	bh=MqfPTmXQlHJ6ND1A8YpVovD0XQTyoHLm15+rw8omrkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NmxMdTt7VIOKWdJiZtwPPpMqkkFnmK576I90p5rda/F70AnU2b/trJzVzi/8QFO6+a15pC27ezlGxHoo/79mFkBGlV3A/OERX7coTGZOVQHYSh2Tj34BioZLEuflVXeWAlMwi4NPhwTTIM5LU3DeaF2iPU683pQxVss6a80+GSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iXfaDXPD; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+WSwjLhNX+HORtDyEFMG8jnZWf5Wtbkqejn8+0ddGQ16pewqXreF9+9aWNdlX6VQ0EpOscQCwqb9eYQ8DFl1lb/SnsuGkVbSWXerfKt+Hjn3O7T6TTADiKcGDlunn5Z+qfTB9zJJStdwCVpD6f05ha4daHhi+arB0LDqGmDD9DN0q9G3tA7ziDDT2HJ4HS8rnX29xPsIZaEPF6S08Qw14gmrqP5yF9A/eKp83V9fSfd47PBhnpE3MEgUw26PszFO45ZT3d0tbd0SqkYJdojBtJZ5wZoHw2AE1lRQUzbRod5ibAJ3PMxNGEXbtJn9zYtKxxznn6QitPnhmJ4x0E6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv9LEaxSmp/Fn2/XswnKyx2GyIuo2kFVZzQnqD1gyz8=;
 b=DZI8kp6cXifvluniF3GMxnLLSxW+CxdTGzAMCZFbRvbTU3xcNpfObS5mV8X5p+8HX20T8czCW3qZZOzrFSCBNlCdk5FSM2dUk/bXE0/BSiqLkBPd8l6rSy4y9cJdc4BjJIUmAMoVSg2Bd8kzs9KxDTkl2oXFUYH7h95+FEjImnLAoMZKoyA7L0sMFmyMQ8wWBwj75RedYnslC7Xbnhym1L3GsdWXysHgDBI0mZ8nzoF1PMFD7G6pby3/1NWB0DvYXx6Q6E/Le8nbJS6coWoQnCw/+Ahzzx/S+S0NytvCkd9l7CIaQre4sImiDzJ55YvNQTkzhYW/IHSFG1hJz9Rw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv9LEaxSmp/Fn2/XswnKyx2GyIuo2kFVZzQnqD1gyz8=;
 b=iXfaDXPD0/UP4AlMgym4aY91nzq2loLpB/znWf5MsI8pAPAKXUDgiZ2GVlbXnm6w2ycN2xuzMHlPWk9KYXeoVY6sJr5EyO5vuCU2+UtM1nZ2qn4i9V05fOtw1PIzKLU/ORZrGDck6qmPy79+f2gtk74xlZ9tearQcjsK0d6rUOc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 03:05:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 03:05:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Conor Dooley <conor@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Thread-Topic: [PATCH v4 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Thread-Index: AQHaT02R4UQu3dC6dEOtm+7qySAJqbDqxx6AgACjD+A=
Date: Fri, 26 Jan 2024 03:05:04 +0000
Message-ID:
 <DU0PR04MB9417B99B4937A65616F51BA488792@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
 <20240125-imx-mailbox-v4-1-800be5383c20@nxp.com>
 <20240125-prudishly-contort-274a48bbb33e@spud>
In-Reply-To: <20240125-prudishly-contort-274a48bbb33e@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
x-ms-office365-filtering-correlation-id: ece72439-618b-470c-bca1-08dc1e1b9813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IIJdiV7/IdqSkqo9+pjCT+lcMrbEjy4sgaSpltYIw8xL6mSkoaFz1ATA/8fjTCNMjwmCRaehW5IRK/72HbKN2LjHKbiMqnsNDoGcxYqQh6SJBJeb7042ymG42FB5ksx6SJwUoG69v2gfvO4XW+A5JlR5inn+8FZSK/hWktIgnZAOKLcGVxVY3JZLE8twLUS8uemMQjYQOLHYRzg3ADwZlSBNtbOoLrt/HdaCYgc/Chz85Igw68bziM5y6yS5pLnuyQtmXrSPUNxSJx7aIMQ2e4HIm+/HGosFJcu+EtatqXGB1a+DGsNNMruv4DmruHMxShhnTBaOhM/lB7mmfzvtMbZHXmRTGD8+vaAWusstK3Hgcl2x30Voyg6OmhzggWLS/ALEobstoHE+rdd9DPtP8I9n8i5OpIrFMcKGQAazZxT2Ab6Kl4ka5a59e5j+3Lxw31oSmh5ddtvJCWuJb7oH9IHM0ifNJ4GUqOBAqih3+nMlTXv7fe8JMS3i4xPBYq9BEIA9nsUhfe1z+ath5E6FlGiSqh8p664b15YjsepwkfAnoIW6LFVSc1eRN5pdoVVj5+nrJZPJbrLED1DXBRhgU9yo4bjDyAVmvbF55upc+AigtP9TPTB9kTzIiSN3bal7vEGnu6aCWMot1kkUH5HSvA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(9686003)(76116006)(110136005)(7696005)(6506007)(66446008)(15650500001)(316002)(64756008)(54906003)(66946007)(66556008)(55016003)(38100700002)(44832011)(52536014)(8676002)(4326008)(8936002)(478600001)(83380400001)(71200400001)(26005)(2906002)(7416002)(5660300002)(66476007)(122000001)(38070700009)(86362001)(41300700001)(33656002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+SvX8fL8XHo6Yqvb7RnNi1/dBLYxLymfGyIm4bKoPA+9y6TxkMgrDYw2kdzO?=
 =?us-ascii?Q?oPPwKYBtMmwubQySUD8Zcz9ph2WDTvR1SZr7eAggskDCevZbinVqELkEQoaR?=
 =?us-ascii?Q?4kHNZjqnBdFVwS4/L2nfHuP5rRoWBXKDp5oqH+4klSzTm53SSxRCy1rnCHs4?=
 =?us-ascii?Q?wm2twc2TFS13aCl7K3zcrqiwS3cC1x4ybeI9KZTK1AXMkWAI5abV/hA/cNIK?=
 =?us-ascii?Q?Z5YBQVHgKahPmdP4DzBqk0z6hYut6FDlkmdAayrLYNE7Su15+pxDpdHUI+hz?=
 =?us-ascii?Q?sifSd2IxdQDlRlNHTADdZrgzYUixPHWuLpshRUixJRmzuwpHSTTezxV2GlfR?=
 =?us-ascii?Q?yKXW+4eHuaNk1OQhOXS0V9bFry/2J6r0Pa4hFFV6g3oEG1BKOxZl47czTFIw?=
 =?us-ascii?Q?4mYeuzFrQuS3neyHssvOdlCrLACRpN6XgsUSrfaMIp7sqaXvM5r8DT6n0VP5?=
 =?us-ascii?Q?MK0YSdeHLUXuzS0qOoYPJM+01AcwSNKX6jQyYE/UutQ/vDOWMTmgeLG9n7wD?=
 =?us-ascii?Q?pgBTnnPye5Gr2VKNDdHvDaPFZ7+5XwJkI0UEE7XIGkLTTqCKSN7EmBDQc6Os?=
 =?us-ascii?Q?jGFlkL77SMH4y0YAL1F0UiLsyOcZyIPOYCxPngIX+pWJQ5LL89byXnTVPsz8?=
 =?us-ascii?Q?ZpYFIAv/r3W38oIDKGmNtKa1vSXhuyu5Nua+093SSwwrVGgrmWiU3AQ9WY3i?=
 =?us-ascii?Q?XHtNdMYX/OP2N1/tlGzqNtAvT89SeUSpfUm3peFuABuSAjr/Dr4EbCDwsg6U?=
 =?us-ascii?Q?PuCsmzR9c6O5rjr9k8oyzVUVz2a4a/9dz9C3mSQsKky2JtKDtWgOzhAOBuqq?=
 =?us-ascii?Q?DrLwg4LhuA2dXldCoyCeKmUrbqygNsU+w0ZBEEdBCEmzXApJ6Q34FBAdLgwy?=
 =?us-ascii?Q?F3z8Ps0HukVwupv0kMlT/9YKOL494RPOFbjYSpoxEA71InQuUuCG91Ukd+xC?=
 =?us-ascii?Q?Oo07YWhRCFAiawhcD7vC0FbdQv3KPbUqVqPmzigzzAc88o4WtnZ89cdHsGZm?=
 =?us-ascii?Q?aLM1LbJ5F8E2EMSMDVdFSACz/PTQDtObs/IXGRSq7+DDndl4Zxyh5kMmTn/2?=
 =?us-ascii?Q?ODcOtD7thhpPstuh8otFLhOD6NUp+CNsksab2yr1fhA6xcQDzlLSs1TJ8yBd?=
 =?us-ascii?Q?GZFQpyclYPzaJXb15uUU+79WVjUHmiQ+Q2ua2Cuy7xyZhllHdOJAB7IfJTaJ?=
 =?us-ascii?Q?PQ4Bq9ppTEMOWGT51JliQvjIgel6kZ7oJU4p7BDnR431CxWe1fCfqoyGU4qR?=
 =?us-ascii?Q?ixC2APuSYzadq3BBr+hqYSoR51RidfwKuBC6gzH86aRZbiE7+fDoAe8+z02z?=
 =?us-ascii?Q?bYh4d+HXa63iegBqvLpCiUAV+lIi9AEIsaUZNOWzNSfl4PlOeGrRCfFi6WgQ?=
 =?us-ascii?Q?oKWMmcBj6k+KCs4SxdTXCn/HQHeHWyFzKmd5NQ69tEHuzAwXKpM4f9WU843v?=
 =?us-ascii?Q?GK/7KPvSztiuDLDfnlWTCIxEznrC92Vj1AKNa5SHG/2BCmchsw1b8gT/5urd?=
 =?us-ascii?Q?7/dtyqN2aLwtLGR3oxJwfiPERBqsSx7LwoLrtTluUQQBdKdB0C7AZ5G4iGMW?=
 =?us-ascii?Q?OUEmxNbkqA7SJS+w21U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ece72439-618b-470c-bca1-08dc1e1b9813
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 03:05:04.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2ZaM6HMm+o2KB75QBmDaWroQWS+Myxx420tuYcgEwfYvqE1jubz7BSUK5jekxjgIWM8IWTZ7oZcU4WF1ODQag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

> Subject: Re: [PATCH v4 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
> Generic/ELE/V2X MU compatible
>=20
> On Thu, Jan 25, 2024 at 01:20:03PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible
> string.
> > And some MUs has internal RAMs for SCMI shared buffer usage.
>=20
> Please restrict the SRAM child none to whatever the "some MUs" are that
> actually have it.

Ok, will update it in V5.

Thanks,
Peng.

>=20
> Thanks,
> Conor.
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/mailbox/fsl,mu.yaml        | 52
> +++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > index 12e7a7d536a3..86759831b24a 100644
> > --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> > @@ -29,10 +29,14 @@ properties:
> >        - const: fsl,imx8ulp-mu
> >        - const: fsl,imx8-mu-scu
> >        - const: fsl,imx8-mu-seco
> > -      - const: fsl,imx93-mu-s4
> >        - const: fsl,imx8ulp-mu-s4
> > +      - const: fsl,imx93-mu-s4
> > +      - const: fsl,imx95-mu-ele
> > +      - const: fsl,imx95-mu-v2x
> >        - items:
> > -          - const: fsl,imx93-mu
> > +          - enum:
> > +              - fsl,imx93-mu
> > +              - fsl,imx95-mu
> >            - const: fsl,imx8ulp-mu
> >        - items:
> >            - enum:
> > @@ -95,6 +99,19 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >
> > +  ranges: true
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +patternProperties:
> > +  "^sram@[a-f0-9]+":
> > +    $ref: /schemas/sram/sram.yaml#
> > +    unevaluatedProperties: false
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -134,3 +151,34 @@ examples:
> >          interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> >          #mbox-cells =3D <2>;
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    mu2: mailbox@445b0000 {
> > +        compatible =3D "fsl,imx95-mu", "fsl,imx8ulp-mu";
> > +        reg =3D <0x445b0000 0x10000>;
> > +        ranges;
> > +        interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        #mbox-cells =3D <2>;
> > +
> > +        sram@445b1000 {
> > +            compatible =3D "mmio-sram";
> > +            reg =3D <0x445b1000 0x400>;
> > +            ranges =3D <0x0 0x445b1000 0x400>;
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <1>;
> > +
> > +            scmi_buf0: scmi-sram-section@0 {
> > +                compatible =3D "arm,scmi-shmem";
> > +                reg =3D <0x0 0x80>;
> > +            };
> > +
> > +            scmi_buf1: scmi-sram-section@80 {
> > +                compatible =3D "arm,scmi-shmem";
> > +                reg =3D <0x80 0x80>;
> > +            };
> > +        };
> > +    };
> >
> > --
> > 2.37.1
> >

