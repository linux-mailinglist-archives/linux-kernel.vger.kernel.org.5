Return-Path: <linux-kernel+bounces-101074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A6B87A1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760431C21501
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75210A31;
	Wed, 13 Mar 2024 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ShWEY/7j"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D3101E3;
	Wed, 13 Mar 2024 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300394; cv=fail; b=cyU2VHoe9h/90b3JxnXRBGR7eKRMN0BiiqiT7iGoqoYPkORxT97JjAd7KbEROcgXueu5yqFeAYuvYvXYO7z+6yNAWH7P0/BNeUFY4aDMVEFp3SXEPRKb3OVVEvgsZdBNhqMPY1f8hTnplrrvbngn8OMT5CtJDnsRhY68F5Lue2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300394; c=relaxed/simple;
	bh=7ckFtzEb1t2xJeSt7PAv7TGA3wOnJjp8FNKtNVc9bPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbuwjTUVB8BrSKINxjjfuLvsy31mm3/qOnxd4m2CzXNsumgMjyqc5uYr5/qHKWA9wLyW8+/6diJgrSv4Anq9+XNu8O0EmR/LSEPZmCizF3ALMzDrqY5cpJjcd7f0FVO3+1G97GldTXciiXAIh0csxioSIokGkyGUe1p4U0WN+MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ShWEY/7j; arc=fail smtp.client-ip=40.107.15.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW8P57nZJ7X2H0u4QbrBR1MNKbdqDDzoljyrRx+4rUOOuGkikGo/S8AIHGAQ4RHcQuJmyS/6u4tmw8D+kLCxylb4JyWIRGDEp1bksO6EMGDMQkctLhc/sTAipE548Ju+tkwGwnIT3pQ5zvigLYguVca7tj1zu5lhwxNcNBaDE+SV+vALiqzzFYRHJJVRiBNudRkLrrELC484PUG0cq5Oe5zLBXFu6QzazUThojO1/BY+YihktL7JAIYWMdsg2E27MpIa+tH8o7nXOIIKM4KqIbI3Ve0uaAm8WB0gVcZHE/W02ImdW5f4XyHo/gOE+8sfLqppzhb7pcuDRoZdSSnKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uds5PQn9pCfy4h/i5beiDpDtKcnh5VhPLHtD6Ck1kA8=;
 b=DL/eb/67N13HVTVoVHhZqQyoCq7IK/eO2xpGNxCZsVGT9zIJNdCxmV2nCsDRU/Kj/nlCZ8Kl8jWV7xlJGKehDJsA0LtoBI/kNIp06JGuV/hZUjcW5mKKpnAzE5Pe+LCJYNUn2170IXfH9GBcn8z0g2IB/lNJTg+Oqe1FySiL04sZ3C1gfVuirmbsXI5wT9eByQTZTKUXRpi/efZNIES3+ZNhgtMW2CVAH7vY8JMWybb9j3okhNtpvQPw5dAe0Y6L9URnspBuf6hL7AUmk5hTOlXQ9pJ1rPcTj9rnBZCTsKWObUgqUP1lrqC/YXmUtGugmX8q10OZbcjj6reOxuIH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uds5PQn9pCfy4h/i5beiDpDtKcnh5VhPLHtD6Ck1kA8=;
 b=ShWEY/7jGKgFIcJ6rkFOwIyVqrPkFPb5K6MsFO/1zoVB9k3ry3V1z0t6tge6SUJ5A8Dt3LqqfiNEHJnjVZm3HE8o4EFEc1PR2dblPROtZfkie2TKUS2rY9hDgd5QDnx27tNDg7xVvlyYxeQAYk2XHJjvUMAVeei6JD6QIpFgOf0=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 03:26:29 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 03:26:29 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "peter.chen@kernel.org"
	<peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Topic: [EXT] Re: [PATCH v8 05/10] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Index: AQHadF4T9fa4/JJRF0KTO2HRURFsjLE0MIuAgAC6gbCAABN3gIAAAmKw
Date: Wed, 13 Mar 2024 03:26:29 +0000
Message-ID:
 <DU2PR04MB8822EBCB6C77F2055D2CF0FD8C2A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
 <20240312091703.1220649-5-xu.yang_2@nxp.com>
 <20240312145035.GA2204647-robh@kernel.org>
 <DU2PR04MB8822976F9F052E18D7951FA48C2A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
 <ZfEYg1BVTVMGAUJX@lizhi-Precision-Tower-5810>
In-Reply-To: <ZfEYg1BVTVMGAUJX@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DBBPR04MB8012:EE_
x-ms-office365-filtering-correlation-id: a53d6ea0-6a03-4c7d-e613-08dc430d5f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kdA3F0PyOF548VA3q2IHt7GxHumyJ7o/LD8RRWEBicCRH+EGByRJ/2W/wzgX7kQmfAa2DE4CXiE2RmOCjTfJYYGdYeHfPW/J3bt+BoTsfy9Ji5ji0cNRsVJsDr0vozWa54vnwqCYN1KJALVOorDXeD+qbLWUKtk62QAzbuxG0yBzSv87itaZO2ZJcq/J8903sbjG04p1V84qTuXSr64UTBJoY8dr/O9Bb0R9BcGA09fWtk6IFxZFbN2jLQc1gfDkqkjlp7wTivFbVFqFggOWIRiZ5ijizXQi68iBe3GqB19R+cCh5r8nwa1XRKxQVX+GUXDAN7SiA4WqUiD9qjpJvZR3vHmgIv+fTwmqDa+1RA1WvpR2gb69U+kn4AUxes9vwSKQxM4yHFvSM6H5waGlUmHegIizMLVZZ3LPOLokjuU3dNWxD/wf2qZubxGWuXBjw3zcwq1aFOf0Wv9fs+JGOg5yfmF8PI06BAD2POYXXn0HYXmaQo6EMlyhnWWA5rrL7ONYsqUifUhfv697iXv929Sf9Q8+LUCXVJc5i3g9tQI+MILL8XRTCXJrgJcZhsqzFae5x1XhmjK4EQ8aULAKNTpOAcbX21WLyRB3C22ei3op2sj98u5KLMHQaKbdomwq677U8wG8G7bkhSLy1m4+RFjEStVNpHKiRfsSyoDVxeorzIzYPsQD0pRkJtH735C9O87RrG1eWYdhB2wlejtzYB2NBJfLdqFbx57y0IWSON4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ix4S9gIMdtyGwpx02I7uFNlZoa3qMvtpmrIiJQFLap74m7ZIfv8wjfIn6c8U?=
 =?us-ascii?Q?Xm4oJxaUQ1SW5oEeNuyoJivEqme73lLva9d1vz8SlYLwrs16ckGeq6xAMXhH?=
 =?us-ascii?Q?ntZxVM/2JgBTvcHeIa3aWyiXuGwOonn9PEPbPxrhTiZpqVdA8gqO+RC3V1Ni?=
 =?us-ascii?Q?qrroFxtqZwN8oOZIqqis99ibxP/YKIZ38DelMOZzM5C+VxFJWidHlom06gwq?=
 =?us-ascii?Q?jRLcdiv8TZu+Ve3Bp3cZSJuN7bssCDZfpjRbucg2SmzBAIcMvKyAhQrrzAmN?=
 =?us-ascii?Q?2XTzJuxVj1epW00xGGhv4Sztv+FyG7oSKxqMTJSFF0ArlFT31jzfXJ1ZX6Zm?=
 =?us-ascii?Q?boJkA2pi1Z5xmvJ0xHQTgDBavzip/n9YkvipZYIzYOlwx+sBHkwqdUC/pj/I?=
 =?us-ascii?Q?WEFNbEWXUz0Tae7CqQJuLT0pUr4jSAMVi7v+wD50jBrRCoGDgdShF3zs1899?=
 =?us-ascii?Q?IE5NEMnz+WVuzS7SAMSehp7iT5UQpNlF2vDcpPAiqphi4DaTXXha5n/Ktjwq?=
 =?us-ascii?Q?hSZsaYg5gQzr76OgicNpxImOktXGY/ZaUZJTXL2CF0+LmiMm/tb58hzYmztS?=
 =?us-ascii?Q?puUfKW12Yni+1SKuGEvOaUz69mDPHAF1EDaXZK3K3MbuvGQ7Ojn/AmAdPtj/?=
 =?us-ascii?Q?br6q5xE2JZn06CnwvdmdQb2oWqM8CZXV1VbUFKLkkIYAl10mj0quT0GT5/g4?=
 =?us-ascii?Q?IkvhBI45NWs7RJN3Crf3RTHkhYNDi74xkweLBgmPukqg6/d4zcTzaT4HGbkN?=
 =?us-ascii?Q?Hw3UXqRin+9PeOkM8LDdaaJSk4o+c81JNG+Evvt84etv1LIbF5kxQqEUrhQ2?=
 =?us-ascii?Q?cByKge5ze5+RotSvGm2bCekg60rriz8sn0f6GbsQ0EfCHqV54PYQy981+upD?=
 =?us-ascii?Q?cgP3G93iBOJUVU2qWaTomdn626fa4LPXDql9RV4owbcTjAIkeENPG3mK5VuA?=
 =?us-ascii?Q?9IDkewAfRUGseZ5sdRvtdIlgES9tPO0jl47CZrK81dZGVnXHpV6VaH3bXlC8?=
 =?us-ascii?Q?fWjOI1/N+G/8MvnAbiL9Gy1HaBgxC2Zi7qU7Zea25UzJ9cgeOK0+jJ5SxZF0?=
 =?us-ascii?Q?sVqOAwF9qj6Da8/nq0vfDFqKWChNCsHi6SktJcPOcs2aUcKsJf9cSSKh2TF2?=
 =?us-ascii?Q?Rkk/de/BAolg0ZF2Rn9SCmXn3aq5l9xOnLpv8xHE/i3a99eFWec37Byp+wnD?=
 =?us-ascii?Q?F2SKYIwhDiv0/t8lG07nVWlUGMxfJZ6uUvxCKRyEaxCQwGJhd6WUEm8NTpXf?=
 =?us-ascii?Q?QCm5sMSF0JqXM9yQeW7IRmD5SB5gqoBq4D8zdUrkHnCdKS3xq0V4oOT6YvIZ?=
 =?us-ascii?Q?1EfT0RN++N80OcUA+MKCP8Fu7HgOo/AqZZE65esR8/Xy4VDK0rOeVfQjiGEi?=
 =?us-ascii?Q?XpjW3iI3l2JBOJ4nmA0hJkOgDjQw6AoxOUzhV0PvrYjc7PLteMfz2PzAO8ib?=
 =?us-ascii?Q?5kG+YJybK5nzIR/TzgDeuZteQPk5S/G1lDCTfRdjdR/LIZAiQXuPO5SEd642?=
 =?us-ascii?Q?CXccnTSzoxA7twkKVyb0s+Ql2R3czEy5RhelM1/acYnkigXemHhx1TF8I1DE?=
 =?us-ascii?Q?rjP3shUYMN4nVO1XpoA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a53d6ea0-6a03-4c7d-e613-08dc430d5f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 03:26:29.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKoqiD3wPcJwDVaZQBlVxb7746oxo/2U5YMOfx/BEI0fggZHgz89jwxXHcziJsSRWric5xJPUNg/Ysp3Sm/IyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012


>=20
> On Wed, Mar 13, 2024 at 02:48:00AM +0000, Xu Yang wrote:
> >
> > >
> > > On Tue, Mar 12, 2024 at 05:16:58PM +0800, Xu Yang wrote:
> > > > Add restrictions for reg, interrupts, clock and clock-names propert=
ies
> > > > for imx Socs.
> > > >
> > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > >
> > > > ---
> > > > Changes in v4:
> > > >  - new patch since v3's discussion
> > > >  - split the reg, interrupts, clock and clock-names properties into
> > > >    common part and device-specific
> > > > Changes in v5:
> > > >  - keep common property unchanged
> > > >  - make if-then more readable
> > > >  - remove non imx part
> > > > Changes in v6:
> > > >  - new patch based on ci-hdrc-usb2-imx.yaml
> > > > Changes in v7:
> > > >  - no changes
> > > > Changes in v8:
> > > >  - remove if:else:if:else:if:else block
> > > > ---
> > > >  .../bindings/usb/chipidea,usb2-imx.yaml       | 80 +++++++++++++++=
++++
> > > >  1 file changed, 80 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/chipidea,usb2-im=
x.yaml
> > > b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > > > index cdbb224e9f68..fb1c378dfe88 100644
> > > > --- a/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> > > > @@ -49,6 +49,12 @@ properties:
> > > >            - const: fsl,imx6ul-usb
> > > >            - const: fsl,imx27-usb
> > > >
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > >    clocks:
> > > >      minItems: 1
> > > >      maxItems: 3
> > > > @@ -144,6 +150,80 @@ allOf:
> > > >              - const: idle
> > > >              - const: active
> > > >
> > > > +  # imx27 Soc needs three clocks
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          const: fsl,imx27-usb
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          minItems: 3
> > > > +          maxItems: 3
> > >
> > > The max is already 3, so drop maxItems.
> >
> > Okay.
> >
> > >
> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: ipg
> > > > +            - const: ahb
> > > > +            - const: per
> > > > +
> > > > +  # imx25 and imx35 Soc need three clocks
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - fsl,imx25-usb
> > > > +              - fsl,imx35-usb
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          minItems: 3
> > > > +          maxItems: 3
> > >
> > > Same here.
> >
> > Okay.
> >
> > >
> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: ipg
> > > > +            - const: ahb
> > > > +            - const: per
> > > > +
> > > > +  # imx7d Soc need one clock
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          items:
> > > > +            - const: fsl,imx7d-usb
> > > > +            - const: fsl,imx27-usb
> > > > +    then:
> > > > +      properties:
> > > > +        clocks:
> > > > +          maxItems: 1
> > > > +        clock-names:
> > > > +          maxItems: 1
> > >
> > > What's the name?
> >
> > Can I not specify the name since the macro definition for USB
> > controller clock in clock.h is recognizable and the driver doesn't
> > get this clock by name rather index?
>=20
> If clock-names is not required for fsl,imx7d-usb,
>=20
> clock-names: false

Set it to false make sense to me.

>=20
> If driver use index to get clock, why need clock-names at other platform?
> I supposed these should be the same for all chips.

Yes, they are same. I add clock-names because some dts already have
clock-names in the usb node.=20
If I set it to false, I should remove clock-names from these platforms in
next version.

Thanks,
Xu Yang


