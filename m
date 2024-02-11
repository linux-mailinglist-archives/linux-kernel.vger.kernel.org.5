Return-Path: <linux-kernel+bounces-60875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AFA850A75
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183A91C21E28
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475215C61D;
	Sun, 11 Feb 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EoZHU3WK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416836113;
	Sun, 11 Feb 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671270; cv=fail; b=ByHlNDK7RSEFKusd803m2zgBDXCcBRsZmOR4t5zNkjD2gyfG7rFYzjkZ3qFGSIeV3BtCe7kqwWfrCm0xOR3DBbKc4Na+rHEO6Zx7kEtzCAnTPXIdwdWanhYjGy7aPpyqaS6P7QYAHUSUIFBC5lboZ+phZxoYVP8vo2if1kojDkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671270; c=relaxed/simple;
	bh=MAoKqqs4zXZxk2v1hJGL+ASF9Bzti389p+jzrb595sQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dy7/KL79qfWHkIutwryq2DKSOkWZALjuXLDIWiuFpPblTrQtCZx/GnHsH/W/XdxHFm9UPdwYoCvCGMiCkXnOuohUJvj7Gk16u90mVN/bULCGLFUfebZogfcdzexD3rMdOjdfaYXQ0yw8kMYRyHgicFGdLHWz+v8X3giW7gyKRzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EoZHU3WK; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YklQE14g0yRQ5pztqWdalSmrExNwnY9aH2fRVjrUSnb2z62NDqMkJsFo9eDpm8mzccNGjaGYfgBkK+kBzJVranA18p4K7T/bvke2HYjtlMBrQjmwi+/Iv2DI60Z0KnjeeEoW9Mi6k+hTpAaaHVqyDe1ZO2zv5tOEokws9XWZr+ma+sbwdZz2f7Yi0Ma351BGbQXeYTuUrzk9+lRRQi+N8iTyIjgfuchJMVOl8DWdgp9sCkMXtzYCAiKqweyrZd3HqkLy8DZxN/0Ga9dgerCWOi+6WUNeAL14yf3kwORcxSDuiq/SG/+/QnQF+YaCvmyC3deTO4zV4ZmYN9ADAkeIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTuDxcquma5fPWfJuoOQmhEhoec7WG3DzuIYpDxTdvA=;
 b=IUexOV3RyjBDg0lZICFTLyp5h2BP/WInkTAxMHSRDea9NkigMJyOgxafGSouEXrMBVS/guJsn8LczBoOQ6H9Ri1Lz1m+USqc0HEhmXnh7Gar49Hi6SVa2GD4JRkI33E00TAbeOznItP6n/1dD4M3rAD6NeLzBxOW/uVYNjLF62OgbxXX2+yiOiH5zJU7uf96IgeYigp9mad3qMCkqBzPYWt4K33EmJrOmfCRpR1dAQwblaIeV8cEYMJKraic+HzVVppxzoIMQGQN5SQszHmzaL9qWozuVCN5YxEFrXN5YkZnFiFz9qUAgxS4KBo7ldqdXB+cMjjju/Kq+mK8GXVSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTuDxcquma5fPWfJuoOQmhEhoec7WG3DzuIYpDxTdvA=;
 b=EoZHU3WK5DQkFNRnBHVs1b9Haht4y2RRctgp3egge5GAMUy8AIa/BNExAVVJWANqLKmBmF8WQdkZb60LLDjAfTNZHMsZME1L2ZXUo1uacFSjpUubRreUxy/HWo9ZO4KioQGGP62u73sDIUUCjp7/05qfiA/zRMdOGlFyHNBdI7GIEGLIrd996EWy9PJJ/KNbvQ/tYkGr2ZcBEVb6glanCtmYhgBZb3d71dVHgdq/S7XsZM3hor8CNQ8bGzCSk/wv9RyWmY+WmEI6yI5DE3BKJqEG8mxcSkheX8piQgoHHr7fxyWlWvjH1JupJkpKgrXP6e4yn3v57+kvCMeuNNpKaA==
Received: from IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Sun, 11 Feb
 2024 17:07:45 +0000
Received: from IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9]) by IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9%7]) with mapi id 15.20.7270.016; Sun, 11 Feb 2024
 17:07:44 +0000
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: Rob Herring <robh@kernel.org>
CC: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Kartik Rajput
	<kkartik@nvidia.com>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	Sandipan Patra <spatra@nvidia.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Thread-Topic: [PATCH V2 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Thread-Index: AQHaSYNiQc3Ffh8ZXUOeuNNLMtgYTrDyrdYAgBLXPvA=
Date: Sun, 11 Feb 2024 17:07:44 +0000
Message-ID:
 <IA0PR12MB8906A78CE7A5652181720561B5492@IA0PR12MB8906.namprd12.prod.outlook.com>
References: <20240117202504.943476-1-petlozup@nvidia.com>
 <20240117202504.943476-2-petlozup@nvidia.com>
 <20240130171908.GA1964535-robh@kernel.org>
In-Reply-To: <20240130171908.GA1964535-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8906:EE_|SA0PR12MB4512:EE_
x-ms-office365-filtering-correlation-id: 02d204f5-d89f-4411-656e-08dc2b23f6a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WE0sZt+lVZ+G2ktPe5kq1cZ6UUOu1ufaEVCSnYYr7HUxdeMpZJTYPgs8KuNUp+y29DmZsZ0iq4aO6Gxd8NRNpPbvS3PfkB1EmNVM1rk+SI5XLalo92sEa0yagiZ/6u1MGaNehwciW1Qq8LjW1aLNeQVsJCGCqTxHMfqTc5wVmKVCzM19V/57NBNZlL3+GV0KSJ5k3z96LBW+WSbccvhR/MVRk6h7m5CO3X0yZBAt5bUACfNI+OJWTFNaz53Pw01tiIQIYUlIa9ATDOlXfXmKz0LolVYi7yZfZQLsP8w0H23uJWB9bWGaPxb2Af0l8fJ45BwFplmAPLr0n+rf3Ktn+rGX/0IR+Q5iwKtAgAMJ8pckoP8BuGhlGqD9Tsm0l7azYC0CUXehlM+LIdP3V0lJIrsDAHcMl9XZYPKc3aI6r5FxJXcXudjKleiwf/e0JeWtT0QeWOM2Z/YcJh6vnmmY0li3honkl2iFlWPGBNVZCbF50Cy7p3UsoF2YNEkMR+uvZxRIxTgDnPVcW39xs66o2d2iB24YkrMtr7D9cdSiWTBD5XfKkFuOH0KYT/NO7JsKxW1+NgxSZzkFMz5Z1qRgbTBD2axaLYgkvn6+w/rDf+mx8U+anSTBenXGMeNgfOex
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(4326008)(8936002)(52536014)(8676002)(5660300002)(7416002)(2906002)(15650500001)(83380400001)(38100700002)(33656002)(86362001)(26005)(122000001)(38070700009)(71200400001)(66946007)(316002)(66556008)(66476007)(6916009)(76116006)(66446008)(64756008)(54906003)(6506007)(7696005)(9686003)(478600001)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iITa0vXEwKuB8gRM64LY06deP1KRWD7qosL1kNZx3jeVI4CWq9rOCMosyER8?=
 =?us-ascii?Q?BFfdw9gCOIkpg7Fi9ynjbU3Qa0A8I+FRrQpCvPaT8LJRtB3T4pBcR0BTSCcz?=
 =?us-ascii?Q?MrcqSPOv4mTk63jSRmfoj6sJILIvAoBoummbFRxs+gLAHtxbWEpEECgnnH3t?=
 =?us-ascii?Q?+IwhC43Na4wm/CrRtY0ytZDHTLhwjgnGMsaUsYGMstAZ8qwq2ec9hoRzKBLz?=
 =?us-ascii?Q?4c2YKVKsHe8cNvopOGnFJo3Q2LeVe5D2+54zEnXFFZ+dQhQJh5lkzdFA/PZB?=
 =?us-ascii?Q?pvS0R1VNryPl0Be1KEx1r1LhKIBb4fg7KqBkSS7UyjE/57/dp6OHuaGdWt91?=
 =?us-ascii?Q?nx6tAWhpC7YGoZFKFXissnyc4PBasTMeZEkwHG7oaqIaNL/xZsHreiydP5Fs?=
 =?us-ascii?Q?FbJaglMWggNfzZuNh7cnpap0XQbjfZ+nvBSL+iCfsrBBDpogU5FRAFmyJ/Yf?=
 =?us-ascii?Q?+Crf7zlNs9RICL4ghg3JCrOriW6B0E17wti35HNhWuVs+VGmJZvtPMMK/Oni?=
 =?us-ascii?Q?1kfdCZGEX8i3fG0xWtQuK168HZ6FvW/bBSr3ke5W2H0b4O0PYyFwhkR8PAOH?=
 =?us-ascii?Q?jn8nXAg4HXkCfWRp8S7yiFijzxwJadwiw7GGEVWvQ5ccl1FS5oe90i1TjTgQ?=
 =?us-ascii?Q?vdCj6U0g6GSwXecjAss/lcEM1+NDAFsgDgkItLt6USx+UIys2w/NASeVlvai?=
 =?us-ascii?Q?VUKM+sAwk6Jwws+kSYodlNT7qLclOhu0W06rTT8pF6w4epyST5iy78eZpZN/?=
 =?us-ascii?Q?tLXNJYhruT1X2nRVpZdzqPu9SLbNRN95yEsIViY0CemRVFtAFMt8y3mIelUb?=
 =?us-ascii?Q?gpu22nxIxQeXTIZuYl1aAzUSQjp6lShmt/xzAc6CChsrilOWYzS5WGkx8/Dt?=
 =?us-ascii?Q?lDEZ05DMib9tcp2pCrT2T57IaiKjqf2KXmy5KPYR3rfrjA9mwHZA1D2K59D6?=
 =?us-ascii?Q?gY9RdMeOp97HrVo5Bf0g4VukXnjczDQq3sEKtyefqhdQLRbeGxuTcQ+W8M3D?=
 =?us-ascii?Q?0bSFrUe0DRkAGE4224Iticmm5wlU0RJ6PaTbYkeV5yLP5ISqD1nENMS5Kuqv?=
 =?us-ascii?Q?gTLdn+95zD02llkidy6qaJPmHNL4Wj0DVhMl+NGOfewHRe1hKqoBEpZeQrB/?=
 =?us-ascii?Q?z/ftPEfya+I86n2p3hHF/I/lD9QnBbjzUnD9/DUmexqK1F1AVr81eoFGgE4s?=
 =?us-ascii?Q?syZLL4wjf9qbMcE6+kej6rCylg66mfkJY0WYfcXpIGavkW1sSM3vS443cRrI?=
 =?us-ascii?Q?P3bC9htnhPbn66En13kI6BOLLRpOIWv70OHF0VXBdppqPrlI9NfaFs343X8a?=
 =?us-ascii?Q?yUF17+I3xzteTIH3o5Qhm2pgv94/p05CeJfAAHT3z0qaHBP1Dft+1w+nLx/2?=
 =?us-ascii?Q?9jwfsD622ZuY7FyutoZm3HZOi8K4cliMNU9odyWlHLNOmaiYvgRfyi+BouDK?=
 =?us-ascii?Q?GF0s5s3jcy9v33HpNOpPtWpOVkvKLUsPJSOYN02EtiP5d6qvHnvjo5cUybQa?=
 =?us-ascii?Q?JHp4bEoBMWqkmkHaU7z9EBw6GbcFPHK4KmMzhyAg1WKTqKBoMzrkGfaRx49i?=
 =?us-ascii?Q?NfsPLiEorn/M+McqK8ZT8sYVYt2HA+ZDvl06s90V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d204f5-d89f-4411-656e-08dc2b23f6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2024 17:07:44.1061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuMZj8O4aXh87DQ+J/zVWs02V2O4KYYdNi+16gc2O1aM5bYwXGTeHn+sfS2FEttzNEm7roeNQLUu7Rjzorm10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512

> On Wed, Jan 17, 2024 at 08:25:03PM +0000, Petlozu Pravareshwar wrote:
> > Scratch address space register is used to store reboot reason. For
> > some Tegra234 systems, the scratch space is not available to store the
> > reboot reason. This is because scratch region on these systems is not
> > accessible by the kernel as restricted by the Hypervisor.
> > Such systems would delist scratch aperture from PMC DT node.
> >
> > Accordingly, this change makes "scratch" as an optional aperture for
> > Tegra234 in PMC dt-binding document.
> >
> > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > ---
> > Changes in v2:
> > - Fix dt_binding_check indentation warning.
> > - Update 'reg-names' property items list.
> >
> >  .../arm/tegra/nvidia,tegra186-pmc.yaml        | 78 ++++++++++++++-----
> >  1 file changed, 58 insertions(+), 20 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.yaml
> > b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.yaml
> > index 0faa403f68c8..79928824005d 100644
> > ---
> > a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.yaml
> > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.
> > +++ yaml
> > @@ -27,7 +27,7 @@ properties:
> >        - const: pmc
> >        - const: wake
> >        - const: aotag
> > -      - const: scratch
> > +      - enum: [ scratch, misc ]
> >        - const: misc
> >
> >    interrupt-controller: true
> > @@ -41,25 +41,63 @@ properties:
> >      description: If present, inverts the PMU interrupt signal.
> >      $ref: /schemas/types.yaml#/definitions/flag
> >
> > -if:
> > -  properties:
> > -    compatible:
> > -      contains:
> > -        const: nvidia,tegra186-pmc
> > -then:
> > -  properties:
> > -    reg:
> > -      maxItems: 4
> > -
> > -    reg-names:
> > -      maxItems: 4
> > -else:
> > -  properties:
> > -    reg:
> > -      minItems: 5
> > -
> > -    reg-names:
> > -      minItems: 5
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nvidia,tegra186-pmc
> > +    then:
> > +      properties:
> > +        reg:
> > +          maxItems: 4
> > +        reg-names:
> > +          items:
> > +            - const: pmc
> > +            - const: wake
> > +            - const: aotag
> > +            - const: scratch
>=20
> There is no need to define the names and order again. Just this is
> sufficient:
>=20
> maxItems: 4
> contains:
>   const: scratch
>=20
Agree. Will address this in the next patch.

> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nvidia,tegra194-pmc
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 5
> > +        reg-names:
> > +          items:
> > +            - const: pmc
> > +            - const: wake
> > +            - const: aotag
> > +            - const: scratch
> > +            - const: misc
>=20
> Just 'minItems: 5' is sufficient here.
>=20
Will address this in the next patch.

> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: nvidia,tegra234-pmc
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 4
> > +          maxItems: 5
>=20
> That should already be the top-level constraint.
>
Will address this in the next patch.
=20
> > +        reg-names:
> > +          anyOf:
> > +            - items:
> > +                - const: pmc
> > +                - const: wake
> > +                - const: aotag
> > +                - const: misc
> > +            - items:
> > +                - const: pmc
> > +                - const: wake
> > +                - const: aotag
> > +                - const: scratch
> > +                - const: misc
>=20
> Only need:
>=20
> contains:
>   const: misc
Will address this in the next patch.

Thanks.

