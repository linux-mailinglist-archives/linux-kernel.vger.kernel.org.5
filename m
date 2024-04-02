Return-Path: <linux-kernel+bounces-127720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D4894FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC8EB21D12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D25D471;
	Tue,  2 Apr 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S5sa6vLT"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2105.outbound.protection.outlook.com [40.107.105.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78ED5A0FD;
	Tue,  2 Apr 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053234; cv=fail; b=YEzIVXXA0FKXw3aXs3+iPamHzrVMf/i32HibPiG63Z84XglR09HsuoZVS+ZheHAAxxMf+7F2AYHewwZwRE6MyetkYRXL+VJkS/cQwKT8NngC47fw5J8Fhc26R7XbZPekEzaxrdlgB65Dx455MuomZLleqgUS+zeoThUqIPwjLt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053234; c=relaxed/simple;
	bh=iA7tui5DWrg5ejUJmBMFkh+fuA33RUlB3aVu+uO5nMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAEdSHtXrXm5vMp8GCrs9QrZi0Ch59c2gw80/j8Cjj2cKvh8418YbRFCK2LHHb9mhW7giFPywW2yLgg8BLiZn4min0Fx8EPg0szWKMBha4F8RNlVO0v16Mgmz17qXqA+xYiaa7muPOfVdah1r72oD43iNC8PRr5KveAfu+889SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S5sa6vLT; arc=fail smtp.client-ip=40.107.105.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuUKtEUuQG11oZrs0mfmSDa00/X4ALT30Ewpf+FkAWmj/IxtAIrd80Gsju+4ZKq43Ad88+7Iolr7LO8e/qr03SaPQOpa7lsisjDavsY1E5ceYTdPahbvfsktFnwYnlDPygZmnOsConDpESKzVqv6j3pcIg3utH40KOVckmK3kUBwT3riRJNwuDR5lwinR7a99iAsnC6+yELfqO8Rqwf5nnL94dBIT3mjecc6oBKtSM9/wEzh58p5NuwvgyaplBaeamJEwf/fVzwSgxfeCxle48praCkqZz9BmzOFSHc6ScN8i8p7l28Jb8i+tfb/zSJDRHzGnMClU/ZZh1bpkR/CMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTCgZJFU+LTJn/LDM88MfYm+xvE5pxnR4nZVX2/4v3Y=;
 b=EwAtYgXA7xsqMfKmh3YfC6ru/hi/BfQhEKmY7/Rgd2s91gTp9YYtTqYNofgauzCTVld2H2hXgHZgI1w+YTJTZr78UrPCUtq9T8DyH5c6EQvACFW6232fpne51Bz6gNGgUkDQla0ytlUmEraYHyJEmw0kkR5yQ7OviQJDNA8Z0SJM3fkcJwrcspSaWDVNCBmH/26E7MoAPWqTPUDsj5qoLS1JNsBDq0pZY+3spQtAwfRvEX8Z/ujx4cjtjxE1n/nb1r3C9bbTTMsxX/+S1Srv6BG2s7TzpT3kSH+POLPWc/51bYk/bnp99D+s8Ej5n7K7hJJVqo4n8vJqP2K4N7x2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTCgZJFU+LTJn/LDM88MfYm+xvE5pxnR4nZVX2/4v3Y=;
 b=S5sa6vLTI67voFIFywozE38x3bDGWikXwGslJPY/o91L4p7gNfpB0bGdHXmLKg3sqrDKk7h+4CJxI+1w7P7NvUWy7CQqX7dPXPTvmTX9nOASRlQmeo4p2Ap23xo5zhUF0VoRzunRmPzzmvzRA8/CS7vqAgNKV87emMvzCCReGhw=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:20:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:20:28 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [EXT] Re: [PATCH v10 02/11] arm64: dts: imx8ulp: add usb nodes
Thread-Topic: [EXT] Re: [PATCH v10 02/11] arm64: dts: imx8ulp: add usb nodes
Thread-Index: AQHae2fM64boqdCCnUiZChs5zmyRKbFUuWoAgAAeVpA=
Date: Tue, 2 Apr 2024 10:20:28 +0000
Message-ID:
 <DU2PR04MB88225A1F8A245C68071138228C3E2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-2-xu.yang_2@nxp.com> <ZgvCTgB4lp0F83Kn@dragon>
In-Reply-To: <ZgvCTgB4lp0F83Kn@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|PA4PR04MB7885:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wR9Gqm7GyDrXQDVNSb1cKO58L87X1XaOcq2KsOjk5XdWWSUTArxLvfOyzBHYTi0TzmJQ369kuFfNB5tE5ZauM6c0NCIv2tcbSw/EOhBP5tBgSeXjTjdlUt1oHMkTDUKxexn4dmvGr9wlVMzXaljt5YghC60N5keIJVhQRSGSL+7rBzrhYGnfN2MAqmfk9ejIoSyHHVDivfCTuN6bKfMVBaXvz8rTnPXiISBJvE7OCRKzKsg8XXd1ey+1Qlfpf0fN8uy4lh4qijWaLsHyOZ+KkqqHqzZAHvC+ZVGk6XkSE5sDqeihLV2oxuZ/rUrzjjqSA2XcNIQhT6/wedOGJjM/UFe7nICwzUcXpXhDERmx+uiUtx7O56mKGXjJHkB39JXojJs/cQYfvI2H0yU/fMKw3NjXk+xRSzE254i9gSVHV0fv70hu9bGJXdixuEMPaegAYoXY08+WXvSBk9OLqlcgq5OWjY8btFy4y+mq7tB9ti9scR0Q63m5NKahTC46eBqMGuwjeZXGZ274REMCIhnol5ghUNciSx/G7cwS3hM8x6wj2YghkRD+4WtlwY1ZNbFE0dUltxH0+qcRW8zpinOJzZ02DY4Q+aThLvvs3TrcbcXlWtbKKNRYQcL2tWyX7l/dW6z/4MoxYGqhsi/SVhWF1WTtmo8wDBFedoTMqG+eVNM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?amfzH5dVjo2hm9UQzLyZnVtt+6tsbqklQY4WJUMgsgyfmJONqkC0mDcCL0eS?=
 =?us-ascii?Q?BD65Pf5yww9E3SNPOVJjci9DwM6doN92hpNal7KhAw+7QATtkJPZG9RQeVKC?=
 =?us-ascii?Q?cjBaSVGlUxj6WQMyekt/0es23ejSjcx7coOz6EP+3Vafir1Ye1qKSfCiJ4JO?=
 =?us-ascii?Q?ZclKe6El7mnnA3hLF/KkfFEms2oGwJyJDPqxzqceLMomHFLhx/Ezn2yLvpgp?=
 =?us-ascii?Q?4v9YPohxxMkNfID81CezlWeUzMa4cQ1ACsbCsN9STS+YVh2zlHr+vmWI5kLJ?=
 =?us-ascii?Q?D3Prk2mW01TUifbA0EsbOGQxakDyVH4/xEAbxe9dSy9GVuMChpYOSUZxn6Iz?=
 =?us-ascii?Q?0m9kBynEyi6gxDIFBmukm6pyds5FfOBskAsTuC8whjvNN9kaJFaW6pSVb2AO?=
 =?us-ascii?Q?t80uE37BHrt89QnuHftKLBXFnHIztg4aCq8Ne4GDSD5VxBsfoGvGDNZsjlWo?=
 =?us-ascii?Q?xux+Pj25EDsplWex62PjLiOfIVUVqSeqGTTdAMT4vTqIg+b0T/HH3U/KwAPv?=
 =?us-ascii?Q?SHOOznVNf5zH3EbM3SYqVqe6/VV2BQ3rfedzeBo5OuOa9NjPjySURXSXeYQm?=
 =?us-ascii?Q?XuHVwksMEH3XuI+7Ak8KLDmzwGgQrgWTC4837NE1SwmdzSFeEB9tX7Vw1kk3?=
 =?us-ascii?Q?pN2dnBndjtIiHwHFp6ICvtJC5d09yGW4pFdliQt/Ev3SlnL27vaoVK80gqSQ?=
 =?us-ascii?Q?0LnLoUNgNjfAykqzheVPbKfKoudsYp9FOsJFdOGpUnYc/LnpdOKRqnd3irQI?=
 =?us-ascii?Q?zUHZlzNXEEh5a+1xxn5eHbtOzyeb1+8uSaKmD+gshfe9e7J8ga/5JJ4+68ce?=
 =?us-ascii?Q?KI4bMcyonm7QzJbLFDd7RaMbEAODPxJF9vnwfPNyAyqxoSi2dUQc+Vemql4m?=
 =?us-ascii?Q?7xufzxOHixeeoqPZL1oE7t9R1YIJmXkjZ9WSABYCtAZIyyiNFey7bIFkEf3p?=
 =?us-ascii?Q?Gf+wPaWln0nJ7NrKjcy84zvY1lumOKnKCiXUc9eYvGyvNVq776BA2dsmx5mb?=
 =?us-ascii?Q?sG0cC9iCfvGUKBhppk/jf0OQtzsaLrH3ts7/7GSGuvYpMJDqrI6wU3NRaFUf?=
 =?us-ascii?Q?mACufP0vSie5SgwJfslMYXb9GGs7Y6IQ2hlckmZoe+gN9pgcu8RMJJz4E0yo?=
 =?us-ascii?Q?dRQseCbp0giL3CHE25eNQ6A1Wd9I9nSjYK5RjA/pi6jpH0XFEAix8BSWw7Fn?=
 =?us-ascii?Q?Mf3Jv7nfOPBjSm/JfCxJ7yT0w3V3tfT30RMdFdsq2/XgY229h1UfM4L9s7wP?=
 =?us-ascii?Q?IVbBRyNhhd4XXQZV+x2ImGxFz3ZfIApViizUcjCDgYNLNFnSDQTejCjKTYJI?=
 =?us-ascii?Q?doo9gIWIPuyJkFBoTo0uzK1sfSdFpAwmD6v80O/LZZcdhC8qre+/oTe3Vxnc?=
 =?us-ascii?Q?nb88vYLljXXcdpAE5ONKNaFJMOfgli6FM8YnSHDPWFDSVRrMlGTsfEgRcsCt?=
 =?us-ascii?Q?20bwI06tAmenUdFe2g3qeh2u72rbPsVy1L1Os2dh3lJYjsBWoOy+UIunxF+V?=
 =?us-ascii?Q?fFp59nJxrpvm926voCuACC6MLprj872xw7Ms4t4oSP5WGxvWzuGZ+h8afms2?=
 =?us-ascii?Q?78mil8MNqEb0zeNgQOY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9055ae9e-f54c-453f-5671-08dc52fe8513
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 10:20:28.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avk+nfOAeuoAR+yE2o0BxOzQgbi0yaNVLcuOirqtg25T/qDZprdxle4IZnXNm7rlJzc0PsnJJ+emyCSfeSjnAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885



>=20
> On Thu, Mar 21, 2024 at 04:14:30PM +0800, Xu Yang wrote:
> > Add USB nodes on i.MX8ULP platform which has 2 USB controllers.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - no changes
> > Changes in v3:
> >  - no changes
> > Changes in v4:
> >  - no changes
> > Changes in v5:
> >  - no changes
> > Changes in v6:
> >  - drop usbphy aliases
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - no changes
> > Changes in v9:
> >  - no changes
> > Changes in v10:
> >  - no changes
> > ---
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 62 ++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/bo=
ot/dts/freescale/imx8ulp.dtsi
> > index c4a0082f30d3..7da9461a5745 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > @@ -472,6 +472,68 @@ usdhc2: mmc@298f0000 {
> >                               status =3D "disabled";
> >                       };
> >
> > +                     usbotg1: usb@29900000 {
> > +                             compatible =3D "fsl,imx8ulp-usb", "fsl,im=
x7ulp-usb", "fsl,imx6ul-usb";
> > +                             reg =3D <0x29900000 0x200>;
> > +                             interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc4 IMX8ULP_CLK_USB0>;
> > +                             power-domains =3D <&scmi_devpd IMX8ULP_PD=
_USB0>;
> > +                             phys =3D <&usbphy1>;
> > +                             fsl,usbmisc =3D <&usbmisc1 0>;
> > +                             ahb-burst-config =3D <0x0>;
> > +                             tx-burst-size-dword =3D <0x8>;
> > +                             rx-burst-size-dword =3D <0x8>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     usbmisc1: usbmisc@29900200 {
> > +                             compatible =3D "fsl,imx8ulp-usbmisc", "fs=
l,imx7d-usbmisc",
> > +                                             "fsl,imx6q-usbmisc";
> > +                             #index-cells =3D <1>;
> > +                             reg =3D <0x29900200 0x200>;
>=20
> Could you move 'reg' above so that it's after compatible?

Okay.

>=20
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     usbphy1: usb-phy@29910000 {
> > +                             compatible =3D "fsl,imx8ulp-usbphy", "fsl=
,imx7ulp-usbphy";
> > +                             reg =3D <0x29910000 0x10000>;
> > +                             interrupts =3D <GIC_SPI 104 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc4 IMX8ULP_CLK_USB0_PHY>;
> > +                             #phy-cells =3D <0>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     usbotg2: usb@29920000 {
> > +                             compatible =3D "fsl,imx8ulp-usb", "fsl,im=
x7ulp-usb", "fsl,imx6ul-usb";
> > +                             reg =3D <0x29920000 0x200>;
> > +                             interrupts =3D <GIC_SPI 105 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc4 IMX8ULP_CLK_USB1>;
> > +                             power-domains =3D <&scmi_devpd IMX8ULP_PD=
_USDHC2_USB1>;
> > +                             phys =3D <&usbphy2>;
> > +                             fsl,usbmisc =3D <&usbmisc2 0>;
> > +                             ahb-burst-config =3D <0x0>;
> > +                             tx-burst-size-dword =3D <0x8>;
> > +                             rx-burst-size-dword =3D <0x8>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     usbmisc2: usbmisc@29920200 {
> > +                             compatible =3D "fsl,imx8ulp-usbmisc", "fs=
l,imx7d-usbmisc",
> > +                                             "fsl,imx6q-usbmisc";
> > +                             #index-cells =3D <1>;
> > +                             reg =3D <0x29920200 0x200>;
>=20
> Ditto

Okay.

Thanks,
Xu Yang

>=20
> Shawn
>=20
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     usbphy2: usb-phy@29930000 {
> > +                             compatible =3D "fsl,imx8ulp-usbphy", "fsl=
,imx7ulp-usbphy";
> > +                             reg =3D <0x29930000 0x10000>;
> > +                             interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVE=
L_HIGH>;
> > +                             clocks =3D <&pcc4 IMX8ULP_CLK_USB1_PHY>;
> > +                             #phy-cells =3D <0>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> >                       fec: ethernet@29950000 {
> >                               compatible =3D "fsl,imx8ulp-fec", "fsl,im=
x6ul-fec", "fsl,imx6q-fec";
> >                               reg =3D <0x29950000 0x10000>;
> > --
> > 2.34.1
> >


