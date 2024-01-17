Return-Path: <linux-kernel+bounces-29164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058638309E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECCA28730C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74D21A12;
	Wed, 17 Jan 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b8DIdKAC"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113121A05;
	Wed, 17 Jan 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506088; cv=fail; b=QuopCHED8JygPlJSVh18nIEwCpB5O+Uj+rtRr3LKuUNmO2+GEYRKAbPDI6t6OmOAaK/9mEbUH2Bvh5krmBaihi5ZtVAnFFeH58K0mMKVUiMk+z2zK3oBFwZwJ4JSV9uub5bi0BrYAx/07qE3OKyDGZClVwJPhrv9qG6stp5qn5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506088; c=relaxed/simple;
	bh=EqTfzluaQKQuB1XzZYPw9WEDLaRx15/5qe8mhOyXjaw=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=laCS81/D9LnUyPAbz+Jt2iHuJgRFaGioaLGs+N7j2J8y5yY/XBmIjNg9UqrMbTPp7mrE/CJlGYfzMGe24dVBXCemy7oDG0LF5ICqDidF08elhzUrX/wtU5sdY1lDDuOMdwRfurELAmMfFCuuzNJnj1aBBeGdECr9NXl43Bu14VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b8DIdKAC; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/ijMbhRmvtQ4UEZFvQyQ1Doedt/rTkSRHh5DiVPV1rsnjGIihvdGgbOu2jm0iUip4PDTQyDO2SmtFFpRY2y+23/sF73ZN7XiulqB9qdXejbrVz/JHotxfl6d4wfD1VOGoQyC/1onnFEQ5XvkXT/WXqUr2QO4Pd+tSiGKGc6Jh7ilUOfLWqgZMg8Ni6InpnVqby2HwEZz8Kr23d+lHWFyKAeo/bBMsOmRREPLXVGL9/17lrUc0wg/sja0kd6nh9RbIhZKhBfj+26brbHc2nAmSVKYXOw1AipM4WSHY1uL/eCvPcJIKQg6SCjnfYkLrGkmOXbexBWcSgsnOC9N/5YbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDilDovi1qMKzU1teE9uZi1GaRRgqYBuDedx+0V10+A=;
 b=PzLV1ftRp3OeG54ColU18udxz/++eIj4nLfU/Zh/O6CMyuRKKGVg/9+uTx4rNFXIb8PjneHTbEAo8s3sVUrp+coDQkc+0nYUoMN9RMuIiW+H73WzgzJ5Yj6cZGHA8r50dQeS4TiG6/OULK+flfjCah+GRhTu7enP+y3TccF3qXTWTMTrMNEJgnSNfVNRr5DGzEE4YL/sB1Neh+6sh1nAK9dzgrvNM3hsJLiINtlb50vfVQgtVmXWP9uISMbUw/ztBODJ2k5pIOO9GiN8TK0FG2QpyitjDHUjxhKrXVD7dEYzc5j0fm42bzbZaNTiF4OC4AgTxeXvm2C9fO7xnV5mBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDilDovi1qMKzU1teE9uZi1GaRRgqYBuDedx+0V10+A=;
 b=b8DIdKACfKWcgGVDiunP0hrtVYT+tIY/CKa+atQhRyw5t1/co1OPEEvPUsEHXIoEVuf+JesTPohCeZW2H4NY1eRBJTBo4el8iPrH/YSWaoGJ8MSgqu/F4/5C3H5w+DmVa3zSodL8tJJ24V+aPVLitSLQiUFvo6foayAVt+Bh0KGjC/JS1ZMAdqvZTN4z7HVicIl64R/fNovWvBdb7VUB7JUhB2vbSBJFcU9aJ67EAIQ73eU95iStUXtrhEZBxU2farqZ2oXJ1ZHDYzq53sLQIoYDCt83ulm1s1y3Z75f9GV0z4oejNT2c51PRML7Pw1vv0zTwm7CjO0udmTAr6isCQ==
Received: from IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 15:41:23 +0000
Received: from IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9]) by IA0PR12MB8906.namprd12.prod.outlook.com
 ([fe80::c1b:dfd5:17ba:bde9%7]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 15:41:23 +0000
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: Rob Herring <robh@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "cai.huoqing@linux.dev"
	<cai.huoqing@linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Sandipan Patra <spatra@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Kartik Rajput
	<kkartik@nvidia.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>, Jonathan
 Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Thread-Topic: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Thread-Index: AQHaQHVXi8lSHewdikO4T3WqC1nA87DMiwUAgBGpZsA=
Date: Wed, 17 Jan 2024 15:41:23 +0000
Message-ID:
 <IA0PR12MB89066B43B0646AFA4AD8200DB5722@IA0PR12MB8906.namprd12.prod.outlook.com>
References: <20240106075134.3933491-1-petlozup@nvidia.com>
 <20240106075134.3933491-2-petlozup@nvidia.com>
 <170453471019.703179.18182038720980471680.robh@kernel.org>
In-Reply-To: <170453471019.703179.18182038720980471680.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8906:EE_|PH0PR12MB5403:EE_
x-ms-office365-filtering-correlation-id: 51e096b2-4cf1-4d2b-88e0-08dc1772c246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q+VLfXnzJqD5AktU/SbNyT9pbNbg/kVdjTJ23siwAb70rOgfEcHuvjciOE/6rjb+FahKwqPF7aw/Ug3ArmezNOGnzTOoIExhs8Q+55FlXfGex+xlDjSjFtRee/aMEp2mbD2OGYEXRJ1TzDiaDPJyRT8ynCtTT0TvxuGy4F7HLsCznSB+XGqBdIM54TymOmDMS70a64ruwMOHaCAHO5Tiz2DoGylaLOH+R1Z9DEH3XWPAitN/NxhO0AfkOvIsbzg7s32FfT/3AImFresQhizhgoYm0PLnp3SjwV2lO5LJdh8lOgdkzfhL90NRnCdrSpYk7q0dWEXHB9ZxyjTE7PF+8+ELJ8LgELL6+jSM3AfRaFewme+R86E303ZLL8gIQ2VtgkNrFb3vQc8uRwZL2U/ZHMjCmIbYBxIsmvhwv/t2l2KHiaO5aN4G9u0/HahNhK3td5qWXDkH7uWAl4UFwvO6t7QfyWJ6v/BiyEfZ1eD1yAiVB8L9nP/dwpJ0HV6TnlpwMqabfv+FXQo5/wYhnE3O1vkrXjid8I0LfUgTXuIdsBSY928mi+DDc9lKTWXS9iXpqn7Ohu9HHWQ6tso29EyAmGjN6vrujAWk5cvBaqKWzr3y4SXwWFHNy2+Gv5e6+irywFVzUWnutJkev4v6uuI2caTnRi65QhVe3k9d7r62qBnL2IQ6u9cOWlnxVsA++mQCt98pxA3FNOKvcT+tPldcWw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(41300700001)(2906002)(33656002)(86362001)(38100700002)(478600001)(7696005)(8676002)(54906003)(66946007)(6916009)(316002)(8936002)(64756008)(9686003)(7416002)(66476007)(71200400001)(966005)(83380400001)(6506007)(66556008)(5660300002)(4326008)(52536014)(107886003)(26005)(76116006)(66446008)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I0jOyTnkg+OttuN+L75ub1RToNniwBb4Kk0qcW24GoxglX+pVdNKPrqzDAfK?=
 =?us-ascii?Q?Hd3ipSmV0lpdUFn0XVOBQ2NfT5DMLOl0I2O5wNEgAJoihp7Hum4SwJEaP49G?=
 =?us-ascii?Q?4DXWIUKYdfgL4hyH/yP+pe/+CDoC46DSeCTUsJwNLWrhwKFvDYWnMYpiRoLs?=
 =?us-ascii?Q?y1fwoK5Eor8SxMIf9N1C1Mcupq0zBBaTS/lkG+4W98GahZBKokOZr94Pm6Xt?=
 =?us-ascii?Q?sXtcQ++XBqPJcFBM/KDAtoHYjG0nQ05Zfn6461Cpddu/nrm6gBxi16QKGuYs?=
 =?us-ascii?Q?dTaBNLsuWM1QZfr6KEa6micDTtNPMw4z8o6sY628Ztm5uVa6B6qLrw7gIaDE?=
 =?us-ascii?Q?XXcBn6kt24MilgOSU764OgNTbRGIjtElNgkYVhhebBbZrd3MuUi9OHGp9myb?=
 =?us-ascii?Q?w5kP1yyooFxNx3l/I9aPGkE1wIU49C4vhe3ny1/x2JEL4t7gWZH3007rc2oP?=
 =?us-ascii?Q?MXUFuGdliiM+KTjkOU2RXUdpAHvd4FMOv8yf3IMLCCx1ceET5UO0a07eh3hU?=
 =?us-ascii?Q?Ba46Um01CuuG2qgRNIjlWKgwIAsKiLo8aMOPyNcKK9vTHszMd+mXcqAfg2zB?=
 =?us-ascii?Q?fz8yJdRb9E2p8W55+LiS5CS2w1W9VL2FMho4LGkCG4VdDEs7TSldaE5mLUqf?=
 =?us-ascii?Q?+iWjNNhZCqfXqpWXxBUtoDmO0mlfiYNCTDwGFqgVWd62FxHgz1RfrS+zDW3m?=
 =?us-ascii?Q?8kUbkFRQgnu9SONyTmhuopVZFS0MJs003kHl228/o0rXEVMnW7QNr3z1WbPK?=
 =?us-ascii?Q?FZT1Kxa58sJrlF8RG0PGBNaj7mwVRD/SOZQMDRZR7SRknKdd2XdvbDX18Sm6?=
 =?us-ascii?Q?ApPXKDtq3GYX92c9jl5TYuOHcaOIJD5Pl/D86LM3kVozX6R3NsqgTLZqlmeg?=
 =?us-ascii?Q?SHuuDPzUi1VoTL/C/tY4CEzr4WaffRPgYQRHVRcHAlRn/smJOQdCSTk1UNeH?=
 =?us-ascii?Q?eSQxcXapv+5qs0mB57QUgtIGnkro2YTt0XR2gr/jW4kpgMewaaL+KxuJpfWx?=
 =?us-ascii?Q?Wi1MQNf/PN4Z7suh9heauBXSCz+/+sV7nwyo5YxM8R/s7f90LweTbc05IHLB?=
 =?us-ascii?Q?8r7imujv35vR/6Yq/DT7cypSVT1NlfVsl6eA4Qhs4LXJiiJKpeOQ8EsvAlpJ?=
 =?us-ascii?Q?Wx5UWWq6sntvu/2p+nJK069XZOlrLARLUBqpDpKoKR3fuW5ZNQmG4RANu3w/?=
 =?us-ascii?Q?NSMLKsvEmfAH2jStiO0dN0ghst1lk2nyaxcgmElvG7eruHeUg6/RDA6PjxKi?=
 =?us-ascii?Q?fyLu+5TBrr2I7dhYVrfbb3OkqCph+b9Lfr6aKob0LkqyXOBO7/DGdqIUJMkz?=
 =?us-ascii?Q?R3gPmyMVZWMNjUHmbm93piI1b0Fe+Vp/MSVBzjqi2JCLGXo0XetKPe/j8idP?=
 =?us-ascii?Q?HElJqF0B8zA/+TYfuK39xTD0Q/QLWaP97J6rJZnlbaihLaeveko/g0IAwjGB?=
 =?us-ascii?Q?24ubyHcEqJ7MO6eXXNToeDscfOTOyPRq9uTbtF8yUmrLjnkmL9hLfq0d8R93?=
 =?us-ascii?Q?ekrEngbOEQQFP/VgV3A1/uP9nqfWJEwgPJQoXoxh+7qf/pBbYxrYPzxVZcKb?=
 =?us-ascii?Q?VBWZ53M+IDjblTOSAva8Py8SZYe+174Qt4G8puqz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e096b2-4cf1-4d2b-88e0-08dc1772c246
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 15:41:23.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTgZELy8aQk9MrNX0tYKzpTTi0f6aZG9hQvty/b5WtvRpbVRjF3BjwX7SGzdBKAKBU1tgnHa0I/M36p2Ql7HKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403

 > On Sat, 06 Jan 2024 07:51:33 +0000, Petlozu Pravareshwar wrote:
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
> >  .../arm/tegra/nvidia,tegra186-pmc.yaml        | 83 +++++++++++++------
> >  1 file changed, 58 insertions(+), 25 deletions(-)
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-
> pmc.yaml:85:12: [warning] wrong indentation: expected 12 but found 11
> (indentation)
>=20
> dtschema/dtc warnings/errors:
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-
> bindings/patch/20240106075134.3933491-2-petlozup@nvidia.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your
> schema.
I could reproduce the above warning after installing 'yamllint'. I will fix=
 this warning in the next patch.
Thanks.

