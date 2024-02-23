Return-Path: <linux-kernel+bounces-78553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388048614E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADD11C203BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A16AFBF;
	Fri, 23 Feb 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EDP6/8KS"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B237C;
	Fri, 23 Feb 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700170; cv=fail; b=eG5uQXCsL3by2y/W9d+LhfXOhLW3pv2i/hcq7Nzy6tN0SbpH1M5qiRm7xNjTEmjqSJyGR25+hmsXAgMenMPmphmjqdH0pZx07cJF/hBz4gm8zhsw9jNNuXNzSQcxR9tBGF8FB2JXr9WXqYrAR8z32v8VsjDgzJXASWvRwkyQ4fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700170; c=relaxed/simple;
	bh=GpxcjqRC+QTZsIzbSVCb0Nnsi54fFrOtXPZ/YYr1myU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nPeC5mSFSOxnzO0b/UbD55bDtVjJJFeOYsNbNSVNYLfXUBdV8QiHRxuRZqOHionXEKGiGMLk0BnTDXzK0gJ3jBabiiIIz22/NdcLsW28q1v1ZFf9j8KIIL7+piWZ6c38pL6ScVBnrwpT7zJhIEJufmWKnI0iwJQo32k0nwK9pO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EDP6/8KS; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgDxN35uxFmOPGmLijG+grvwdtXoPROX3MXnk0noZvxF6bMLn+IWSEo80QYBeubL5c25QvUXhuHEUO2lhMWLhAc4DuREjr4okb4o0PL1S+NwEE5IuITyXrHH2qZDtmYGSOsXIeVfXFGiyLWQPXVFd6iSSHT2olU6V3vEJ3FgruD3cBHEHIhTFc18YKiV6Hr9n1+8p5BHcgY3ghS/xzrX3mP3CswEshPtvdIH0sW0muZmdeJM5gpO6Pcil0sXMJ4c0bi99OcDVrHIudPe1mE8bPUp7wK7Zgty0ra3xFoqeXDciW9B8205x+6B9Nw/qGnZkuN0nG3VEwb2CM2Ra0k6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7b425Qbc18S63D+/dO0s/VA7y65l8YmL5iVwHYNB0U=;
 b=kp1G8Yjos3Qagv9u3GA4RdzQcfTuvuhkVBAWxpF2Ig83YKBQzXCDLcLd825Fgo23BmoP40y1WdKkVAgpLyrKl2tbFpWGm2PRXSEZ8fIQWvhH6JxiwUw5XbgyTuu8wl52BkYe5Mr2TD0MK3m1YJO65gNF1riL281dRAsSTcPptwJxKjjW42hBLJt2rO9YakOphqWiz4UodY0IMO+H7HYNcsMBOKrZo/6vI7hjB2mGX3mnJp+H1PffHn0N1DkLZ5b5Ob3oJMoPRupxh0CqNzSGr19TUZQ9Pn0HBJ65DBklPTVA8Q/qoaxxwVUr8Z6/G+smJKo98ih9+h3IvyPFGArNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7b425Qbc18S63D+/dO0s/VA7y65l8YmL5iVwHYNB0U=;
 b=EDP6/8KSvBDXNWOJWvQ++9bYoL13KYMc+cwcMZdbQdti/bcXxc4Q9Ka9qfPwzERbU3zH5mR6+3f/djNeUjIiZGaQxbvLbgvTeeSEW2hUYitdgaysUst0EeKdQO+nVy6ZfNWuG9EHZkxxycYL4yMcSQWZQXokgikcrgbdYfApq3A=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Fri, 23 Feb
 2024 14:56:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 14:56:03 +0000
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
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2
 Controller schema
Thread-Topic: [EXT] Re: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2
 Controller schema
Thread-Index: AQHaZJJxwpJRCpYUm0K+YwxPJkmdNbEX+NsAgAAEwLA=
Date: Fri, 23 Feb 2024 14:56:03 +0000
Message-ID:
 <DU2PR04MB882234D1A9D5718D8355928B8C552@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
 <20240221145846.1611627-4-xu.yang_2@nxp.com>
 <20240223140256.GA1768266-robh@kernel.org>
In-Reply-To: <20240223140256.GA1768266-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|PA4PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: 1897d849-c198-4fe6-2a86-08dc347f8e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Wh4zo3iDK9M+wC0COTHPfI2EO2YqsgFaeV80e9ILA0PneWUYWheyrNaQczAaTkH+Z1mhF5lpyU+gsIaU8CaYJjaCOD1ivTVDkU1DhE+fJD3JwwKFDdsHFBsK17pVBqibsTWWkyl9Z06dHOiW/4YrbVL29AZIUBXZyBT18ql9P4dETtfsnzTY9MvOjDKlIOk22wma0zeOPBLvIsR6mW4esVj63UNWn3Q/j4mQTEdz+SFuWy99EuBsVgyI7DyC4aglpypTL46E/1jl0NLMMAjX867sROdWFXpmk2x1yXgQORCdBY9x2TQmJDfgrBBXBR1gSQuPFI4M8g0Qn1XDiqXV7Iy+YuX3nU6TaGnUEQupuAJbT/OawE4LCBPkdnKgAyuDc4Qg5YwbMbGhN2RKha0haLGUlXrUN4Oig9dcLJNJwiY43uPO146Zj7mh9wj3r/x3/xgb6NnnM+cMr0CVmAvwNmePJ0VmYlihY4i8iWfgKYdwReFPd3S+Nqn1MGw1orVlDgAQ2z2jy7F/zd34r3vAvNh2MSZmhq0EnqmUaIZxZQ0cPQ0+zU/pEuBQOW851kVn+ICrsrmAWEgiD7a8GY3n1YOQm6UalLplpD1M9s1ITNY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oEfV62Qr+aK/EsVeF1Qx2zbqH9Ni+/nR9Dew12iU+ahexfWi+vXu0IBv5zpW?=
 =?us-ascii?Q?+4ldbKPYE+sViQykPwarfCBmXUKsskgC4rFOGAr7i22IBQglIkbmzWQRkunw?=
 =?us-ascii?Q?7u4rzyekKF3TLMkkDotbX3i6SVZksmpci2iZjgoAo/Ts8RPtPWQpZUgjk0M+?=
 =?us-ascii?Q?moi0F43mPGapTMacvc3f/p9JusWFn82QkxZgPbTNzafZbLzEZsmoPyIeY/5b?=
 =?us-ascii?Q?pti6H6b/6PXMmjli9Ad1jAllasf5KmcIRmKn7Kg/deZTd2TrWjQP2k8taHpJ?=
 =?us-ascii?Q?TfOFBo75mpy0veX4Ml2VkFF68NEhFQvlxHQ7ouaR/KzX8ZTvcwWxXdyRHqGg?=
 =?us-ascii?Q?+SIYUy3SJ8weO8AfFwfLoxR4W9C3wuUlJzVez03IcGEL2o1uOhvg6XD6OE14?=
 =?us-ascii?Q?J2KkPxQPKx/bYSauu12kZ12aex9YO5pD4riXoUj4cZkrsFFCvMr0LaZ3jgrt?=
 =?us-ascii?Q?lk1QjqUx/Xl9wE+Z37V65340ERkr/aNlTBqXr1Tmgn6g8zC0ZUGVNzWjowNR?=
 =?us-ascii?Q?a3BNCu3+QW4ij8ZghPXoxDLnfC8z/MQy2yFmEnRiL3uTNxy/ffCRvH29yGUC?=
 =?us-ascii?Q?LYThmri6FlcdAICKBBYjVt0Qp0rEIae6lLSllkhB9NZZKkXIcNhTNQlIa5SY?=
 =?us-ascii?Q?u3Lgq6XgH2L26YQPrNq7o5lyOO+57BOZkelhOVac4NgwWH4vIbebJSlwjfpr?=
 =?us-ascii?Q?Dns8prNzqOH+o6oi3WXPXiCMZg1AL+vHSDDBjaTMEeaw/Tdm/pOJ1Gli5WzD?=
 =?us-ascii?Q?LfRukilrBeHmgPC9QLgbJ77Irp5b6M3ibxxm14ONdmjll3KLqFcXDlSq6Utj?=
 =?us-ascii?Q?BL9qB3xgdEDfyStjzp7iX+/rVIvaY7s8xdJ4W0P5bMOdJIhyp/qmt9G08Eib?=
 =?us-ascii?Q?yN5LwRzGo+BksqJgg6e+BC/VkK1cdUz+2DKrM5yKxok4knZDIO3GqZ1z7KL/?=
 =?us-ascii?Q?liVIe2U2OTZuie2OUx0Fwp/pfsfeeQAm8laBnyq0HOn/UIBh226PGBhiFXrq?=
 =?us-ascii?Q?Y4jkSkv9KLLZQGrsod+v0Afdu6xHWqoFKe63ElhEoXoZwyPYYYDk4S05vF9F?=
 =?us-ascii?Q?DLBmFrpmNnscERY4MHQgKTUStrGu8dT5B1c+QQbzaJQXKUHzdWIUq4OJSJXL?=
 =?us-ascii?Q?ee1/BYL5+v078vnwIpBqryV/Vb8TuRXO3hgh6nakCq5+7TC+qCNV0S7/Qa1G?=
 =?us-ascii?Q?atKpHVoirryq8MZz4wN7+RzBLr5GBYM/RqFtuzeR3b/qy2Aw6/kV0aQ2zXEH?=
 =?us-ascii?Q?9U8UwR2Q1gVeY0q+kA7NS/G+1Lo4cElBkLr1Hd9k47fG3PZWtRqG/SnLW4UD?=
 =?us-ascii?Q?nDO1eo7u88USIKU8MYa0rRRugYy509qvjWSveDFmnUFZz8b/Ph26L7BFwo0g?=
 =?us-ascii?Q?+K2/+Z0OyQ6GH4UPoIil4zzUKszwTh8bwpIDLDf23rFgujCo/lDLco92lupU?=
 =?us-ascii?Q?I2lWzksU5ioVkK+zecSuTllvfHIPuLwovBnB24w3y1r46u+QV53FoPTSSFxY?=
 =?us-ascii?Q?nGHmVKpIabr/UfSQhrj2q6IYsUstCdiLL1NEdOxpCFZoiyiBaG1542fMNxAM?=
 =?us-ascii?Q?kc6g5LcfsGRI3G3/Bj4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1897d849-c198-4fe6-2a86-08dc347f8e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 14:56:03.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VU3/RpEzLQxtuKB4AFz7Y1hiJNlekXkzKuOb7ZIPbNumOxxhYNboqa3BB7sYsN05PLRMdNNJtQVx+ytmKlgeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823

Hi Rob,

>
> On Wed, Feb 21, 2024 at 10:58:41PM +0800, Xu Yang wrote:
> > As more and more NXP i.MX chips come out, it becomes harder to maintain
> > ci-hdrc-usb2.yaml if more stuffs like property restrictions are added t=
o
> > this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and a=
dd
> > a new schema for NXP ChipIdea USB2 Controller.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v6:
> >  - new patch
> > ---
> >  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-=
imx.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yam=
l b/Documentation/devicetree/bindings/usb/ci-
> hdrc-usb2-imx.yaml
> > new file mode 100644
> > index 000000000000..2ec62f564bf5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/ci-hdrc-
> usb2-
> imx.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C4ac0c60cd4b4433f0f9f08=
dc34782572%7C686ea1d3bc2b4c6fa92c
> d99c5c301635%7C0%7C0%7C638442937830606824%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D7p1DzvYmBsTgN44jypH7l=
c56z9hVBsFBYXUwsblk9z8%3D&reserv
> ed=3D0
> > +$schema: http://devicetree.org/meta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cxu.yang_2%40nxp.com%7C4ac0c60cd4b=
4433f0f9f08dc34782572%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638442937830615622%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLC
> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DfWWy9en=
bGK5yeKiovday7go3Gss5L%2F%2Fe%2F
> OZcANny0QA%3D&reserved=3D0
> > +
> > +title: NXP USB2 ChipIdea USB controller
> > +
> > +maintainers:
> > +  - Xu Yang <xu.yang_2@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - fsl,imx27-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx23-usb
> > +              - fsl,imx25-usb
> > +              - fsl,imx28-usb
> > +              - fsl,imx35-usb
> > +              - fsl,imx50-usb
> > +              - fsl,imx51-usb
> > +              - fsl,imx53-usb
> > +              - fsl,imx6q-usb
> > +              - fsl,imx6sl-usb
> > +              - fsl,imx6sx-usb
> > +              - fsl,imx6ul-usb
> > +              - fsl,imx7d-usb
> > +              - fsl,vf610-usb
> > +          - const: fsl,imx27-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8dxl-usb
> > +              - fsl,imx8ulp-usb
> > +          - const: fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8mm-usb
> > +              - fsl,imx8mn-usb
> > +          - const: fsl,imx7d-usb
> > +          - const: fsl,imx27-usb
> > +      - items:
> > +          - enum:
> > +              - fsl,imx6sll-usb
> > +              - fsl,imx7ulp-usb
> > +          - const: fsl,imx6ul-usb
> > +          - const: fsl,imx27-usb
>
> Now you just duplicated all the compatibles, and now any new compatibles
> have to be added in 2 places. For this to work, you have to split
> ci-hdrc-usb2.yaml into 2 files. One with all the common properties and
> one with compatibles (minus imx). This is also needed if imx has any
> extra properties the other don't.
>
> Didn't I say this already?
>

Yes, I know.

But according to your words, I need to split ci-hdrc-usb2.yaml into 1 commo=
n
file and more than 1 vendor specific files (imx, nvidia, qcom, nuvoton and
others). In this patchset, I only focus on imx part and KK said he or someo=
ne
will take over other parts, therefore I just duplicated all the imx compati=
bles.
If I only create imx specific yaml file and remove all compatilbles from co=
mmon
file, nvidia, qcom, nuvoton and others compatible info will be lost, is thi=
s
feasible? Or should I create mutiple vendor specific files at the same time=
?

Thanks,
Xu Yang

