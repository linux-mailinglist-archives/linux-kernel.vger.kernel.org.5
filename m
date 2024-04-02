Return-Path: <linux-kernel+bounces-127829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF462895187
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633F9286441
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAB77F11;
	Tue,  2 Apr 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="akXaCJdK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2119.outbound.protection.outlook.com [40.107.20.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FA60BB6;
	Tue,  2 Apr 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056232; cv=fail; b=tnsl252jfBpDUw76FXCKYYd1NLQLJ13NWRPD5IAtgGZeid8FhiN2TxI8Ui6yNocL78pc/1TrqyG/Ohacdmv+sOUyV9XudxnC1UzUM7tbKPhFJ8jCzVVgTkIL7xhLPTpgVnbPRLpYbTnNT8c3P2ct5VWqzQ+bTkM21xHlgGazkEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056232; c=relaxed/simple;
	bh=eG0+ZDsdF44prmJymrk7Ytz139FpLdp0X+n/16aQXpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKTFmMtoBCB9EUaB31azln1U339JipqfA3h9pjcOaFVj3krgOEC2F+kv4IlU2l0ZoOtZjGNlV0j3nfcQPH7dNW+mYXNDk5CI/siJNQK8riSbEiyj33gQddoW2JNszio6Ea7+nwEExz/MfJ75A9NANXhFlzrz6wac2jWlWxByy3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=akXaCJdK; arc=fail smtp.client-ip=40.107.20.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUzGqErU/ASr/8/ebSRxF5l8aeEKgE5Xcre7AjOkFLOiofxWkDy08Adz3SfHuqqLm+CRXkUnwLFfYelJxsmQFsVX6sjVqL6jtZ1XrqTJ/UGFCWsiEH0EkG4jShhSGK7lDBSAlfDLYqoRtp40knxqO5KxqEOVwAx55DzKCD7tEZUNYbiANAqyvCKfK3eI1gNXAeYEAVJDHvmF3BAOM6gNnVkNZpTGl1N59S6LJO8m1iiQpCZeNFRM48gX7PRNibC2GYCctsUPadTA7kWtHWV5ZRZ3N5bcprcR4f2ZFNpavjznnoKXtDMLlcot4ShhQNdCk9jYyo4gvzqprLgvHxZ6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OZFaxPmH8elz+7ubqgYAXnK0IF7bs88bgYb43RiJF8=;
 b=UT2W4eqZsuHAyS46bBVUTHtSaVBoPGwgHjnc10hFTVROBFGy00UijTsmAeXsjcV1ULRegDZcYCVevf5NVT8gmRwLdUrCz3wDW+07u18qtEj6nhwNCYdFeSTSogj5jknWgN8m0TFhVPPiVRzRTulaC+uB7wQcNhRwogOUvKMYKA9WppWVRZ80H9zcAVHAf63BoV715JLRdy1OsAh470ysimPCoEHPUz0PCNrW5B3VoudVXP75gDzJC/mDwWCWfP3YE5J+ylKp9xScmwZxvcXOcn9GgUjt/vlBQTNCD4q8cBqjFMR6OmTXUdHCmFyyQ9EeXGsN7U+JEdRZqnCZp2bX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OZFaxPmH8elz+7ubqgYAXnK0IF7bs88bgYb43RiJF8=;
 b=akXaCJdKXKm7ZCj/MBywaBOkQnKlmVZoQupvj0bBBclMWfn1zPzQeJmMyxEddeYnMGx26GkYHXUfCAJKLo/ayH8ee7qJjCsES/edbwTqErZEC/J4hYaLhTXavMfg5OX9VigTzxIv1oL/HKnfJUknBmNY5yi7Al+3AVCgU1wB1T8=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8665.eurprd04.prod.outlook.com (2603:10a6:20b:43c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:10:27 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:10:27 +0000
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
Subject: RE: [EXT] Re: [PATCH v10 09/11] arm64: dts: imx93-11x11-evk: enable
 usb and typec nodes
Thread-Topic: [EXT] Re: [PATCH v10 09/11] arm64: dts: imx93-11x11-evk: enable
 usb and typec nodes
Thread-Index: AQHae2fiM4t7LhbL4UG9hlOii2nK87FUw26AgAAh85A=
Date: Tue, 2 Apr 2024 11:10:27 +0000
Message-ID:
 <DU2PR04MB8822F09664394E466CB9F3868C3E2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-9-xu.yang_2@nxp.com> <ZgvKteCEZJxShA/j@dragon>
In-Reply-To: <ZgvKteCEZJxShA/j@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM9PR04MB8665:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UgboTkJKAk3i6gCqMJ1titIj2t4JiRMF63RLQQoCT6xBoxHujUvwuv62y/xJkECGXc++kkLIAG0KrxCYZAgzMngeGJE0Y1i9JvgAEpEI7bLh2cNDlNOSa0lymIRmnKDWQo9HEQzPBmRqmGcLvm+C7iqZeUM3NRK2uJpw1Qjl8CJkHTZQLaV9cjydRkZtQBvRt34B5qfFJxusrGRObKYiEXMB5bvuOwPTL0I/En81H2WAdJDIR9QifSrEO1djkV+4OuTVOXzZpUI3LnxTN7PzRJ94ISqNCfKzSPeL/0KHA8Hao7IVVxe+CXB8zTr0LMKPXQvMpZvpwyCZ6M5fNNQcJyCUzx6/GfYzevPELnzoDFXrV2Ql/lnAYfGtVEj0XzKOVCceQssavC2YJcEKtQ2TUMNqBzBJwuIOTrtDoAbTc4IB9a24t1Ct4KWZijdA74YktCoGYs5jGPT2BS6tW0aw2VJ0Vbg0R0vg/VtQqpnyiepiL1dEnlx26EPH+8jvPlZMBXoNelLNojnsmWDUE0apC7f0jsuke1TqjcFciieDvexJgmbrLLKpupC2k5vFaDCwbG+kgpkBqt5ApIpJtADjpcr0FYxOG3fHqA6lNc/Djpp9WDB/sAl03Zwlbrc2umXt1CyolcevGEs29zkABLaBSw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bAzFwFQFcNHXyrF4yFgWj0k5DJo1Q7XGWLsG2C8eGixQeGfP9NfRltR8T8QF?=
 =?us-ascii?Q?KuEhp7o0CZsNIz0MIevWW94Vd740Z03gYi4aeGz9IKsOTelnTJkXqXN7wmUi?=
 =?us-ascii?Q?CSKB4mpLp2krIfKktEGtqlWlSuhk7N3Bcav3MhXKNUZTMZV3Sri26k9/25Az?=
 =?us-ascii?Q?MGl7MzLzeJwIDBfD0NSF1bFN+XaCHanZ8ql2ixqH7+Jh0eK9jr34bvURmnrf?=
 =?us-ascii?Q?E2hURIJt5Sc3BRH2MO6ZWH4JWfh1yIYMxYi7SAHTc/LwcfAq0iGpXeVcfss6?=
 =?us-ascii?Q?jl+9uRCi4Ni9JjgdWlugkMQtiIiYvwbqER+XL25gkBR6ptfpj+W7V3YMpCQh?=
 =?us-ascii?Q?HUzvKy9b316JPLIlhpf4Ib29obEUt2Pj0tWl6s+WGVUeOUj8h/y9minaYme0?=
 =?us-ascii?Q?mXtCYnkjux2IaI8RrLRp7K92fzPt5gaQkv41eICDOab+H8IwaeBVrgZ/Kanu?=
 =?us-ascii?Q?oHNL6pzfQf4KDr+GNg7I97vzsbXNLZ+wUbYs4KWn3aYvP/WgR966Han1nfKb?=
 =?us-ascii?Q?KgpoB7rsdSgZCJPdernViKp0KKhe3WKCcKvJHjSelo1gEDQqq8B8qYeOohX6?=
 =?us-ascii?Q?S2tZPyFccbpURanhlOwhFEYgEUT9yhNsDgyVODg6qWrCCbPwD6fuTya6a7ab?=
 =?us-ascii?Q?IISyUFsA699aqnvE+icUgM/X7K52yB22XHgEdHoL7GelP1lMw+7p9RhlNDLR?=
 =?us-ascii?Q?7yiZblSwsQHtYR6leAMcUL5ZAtkGpoTTWthPPuNTJWd82S3y1enFKvxhvv4M?=
 =?us-ascii?Q?tConVjventaD6W/8S4RzeUEtipgRoh688OtJE8JGHMNic6ob30LOrz06H2ev?=
 =?us-ascii?Q?IxxGxaAdNwNWGeyltYzp9iUZ6aFb+eoPQUbS31drSl9jqXjQMtCVHWCFlFWy?=
 =?us-ascii?Q?H2PqUPm7wRwWK4r9anI9HStAtIs6YP2+8HSS/ZlIeTjNzbsxGzDiBEARMulq?=
 =?us-ascii?Q?aDivs9ojazKvsL18IqsWrOJV+SSlS8Ra0aiArFE5FfXDr/h3hZ4hKvcx2gm/?=
 =?us-ascii?Q?Lh6zs7KMVBN/U6dXSET7DiPyzytpywYszT0nElOfX2A/rkw3XJSOVAdPeQ32?=
 =?us-ascii?Q?EucDW6gE8eyZu+FjfrHHxw0YMuLCnr1DCN6e04DGFKKuIux+2EXKtVEgNScR?=
 =?us-ascii?Q?UwbxxM+yl3RDg1jFk7zhth2wDpvQ16JGbkb84/2fk8xadQn+Kav4LELevlBZ?=
 =?us-ascii?Q?8uJPMit4hiP2gyIrCc+1jopUF8UXHuneAszUQx5Xsy0rC5NVSfu3zIewZdJ+?=
 =?us-ascii?Q?zkRYjEYh12VFeXkU4FK8lBzrmzZovHaq3j1E+GlSUPpqjJ2Ad9MZTDxq9RnM?=
 =?us-ascii?Q?jdxqwdPoA6zqWlh1RJP9ZTV6jD94Kb30NC+pQltD0LKYxBdKZWW9gEKtoamU?=
 =?us-ascii?Q?W/r4LA+P+RE0X/WGfYzyx2fFucbvWKYyHvmCubik3VGrHDkCESTXRig7IP4l?=
 =?us-ascii?Q?f+L02FqkE1R2gc/1TbKAenDk35NuZJf6z7quBRW368xPABxx9fCWZ2Cw+D0n?=
 =?us-ascii?Q?Iwb6B7NEFVxZ4nCNxoahJ+k7BjgtsRRYrPeRAUej/38nbc4bTivPieu7jGZA?=
 =?us-ascii?Q?rd9Pm04eww341HSlLyo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e3d218-cdbb-4c9e-7570-08dc5305804b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 11:10:27.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ng4pzZqr4XwS69DcWxh6pcTM1NLIt+RUPz3ZwI737auGQ2QtzgEl3+kUDlDpfn/A1eOrpOu0AX/51MBRI6FXrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8665


>=20
> On Thu, Mar 21, 2024 at 04:14:37PM +0800, Xu Yang wrote:
> > There are 2 Type-C ports and 2 USB controllers on i.MX93. Enable them.
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - remove status property in ptn5110 nodes
> >  - fix dt-schema warnings
> > Changes in v3:
> >  - no changes
> > Changes in v4:
> >  - no changes
> > Changes in v5:
> >  - no changes
> > Changes in v6:
> >  - no changes
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - no changes
> > Changes in v9:
> >  - use compatible "nxp,ptn5110", "tcpci"
> > Changes in v10:
> >  - no changes
> > ---
> >  .../boot/dts/freescale/imx93-11x11-evk.dts    | 118 ++++++++++++++++++
> >  1 file changed, 118 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/a=
rm64/boot/dts/freescale/imx93-11x11-evk.dts
> > index 9921ea13ab48..ecc01d872e95 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > @@ -5,6 +5,7 @@
> >
> >  /dts-v1/;
> >
> > +#include <dt-bindings/usb/pd.h>
> >  #include "imx93.dtsi"
> >
> >  / {
> > @@ -104,6 +105,80 @@ &mu2 {
> >       status =3D "okay";
> >  };
> >
> > +&lpi2c3 {
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <0>;
> > +     clock-frequency =3D <400000>;
> > +     pinctrl-names =3D "default", "sleep";
> > +     pinctrl-0 =3D <&pinctrl_lpi2c3>;
> > +     pinctrl-1 =3D <&pinctrl_lpi2c3>;
>=20
> Do you really need "sleep" pinctrl state?

"sleep" pinctrl state can be removed.

>=20
> > +     status =3D "okay";
> > +
> > +     ptn5110: tcpc@50 {
> > +             compatible =3D "nxp,ptn5110", "tcpci";
> > +             reg =3D <0x50>;
> > +             interrupt-parent =3D <&gpio3>;
> > +             interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             typec1_con: connector {
> > +                     compatible =3D "usb-c-connector";
> > +                     label =3D "USB-C";
> > +                     power-role =3D "dual";
> > +                     data-role =3D "dual";
> > +                     try-power-role =3D "sink";
> > +                     source-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_=
USB_COMM)>;
> > +                     sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_US=
B_COMM)
> > +                                  PDO_VAR(5000, 20000, 3000)>;
> > +                     op-sink-microwatt =3D <15000000>;
> > +                     self-powered;
> > +
> > +                     ports {
> > +                             #address-cells =3D <1>;
> > +                             #size-cells =3D <0>;
> > +
> > +                             port@0 {
> > +                                     reg =3D <0>;
>=20
> Have a newline between properties and child node.

Okay.

Thanks,
Xu Yang

>=20
> Shawn
>=20
> > +                                     typec1_dr_sw: endpoint {
> > +                                             remote-endpoint =3D <&usb=
1_drd_sw>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> > +     ptn5110_2: tcpc@51 {
> > +             compatible =3D "nxp,ptn5110", "tcpci";
> > +             reg =3D <0x51>;
> > +             interrupt-parent =3D <&gpio3>;
> > +             interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             typec2_con: connector {
> > +                     compatible =3D "usb-c-connector";
> > +                     label =3D "USB-C";
> > +                     power-role =3D "dual";
> > +                     data-role =3D "dual";
> > +                     try-power-role =3D "sink";
> > +                     source-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_=
USB_COMM)>;
> > +                     sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_US=
B_COMM)
> > +                                  PDO_VAR(5000, 20000, 3000)>;
> > +                     op-sink-microwatt =3D <15000000>;
> > +                     self-powered;
> > +
> > +                     ports {
> > +                             #address-cells =3D <1>;
> > +                             #size-cells =3D <0>;
> > +
> > +                             port@0 {
> > +                                     reg =3D <0>;
> > +                                     typec2_dr_sw: endpoint {
> > +                                             remote-endpoint =3D <&usb=
2_drd_sw>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> >  &eqos {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_eqos>;
> > @@ -156,6 +231,42 @@ &lpuart5 {
> >       status =3D "okay";
> >  };
> >
> > +&usbotg1 {
> > +     dr_mode =3D "otg";
> > +     hnp-disable;
> > +     srp-disable;
> > +     adp-disable;
> > +     usb-role-switch;
> > +     disable-over-current;
> > +     samsung,picophy-pre-emp-curr-control =3D <3>;
> > +     samsung,picophy-dc-vol-level-adjust =3D <7>;
> > +     status =3D "okay";
> > +
> > +     port {
> > +             usb1_drd_sw: endpoint {
> > +                     remote-endpoint =3D <&typec1_dr_sw>;
> > +             };
> > +     };
> > +};
> > +
> > +&usbotg2 {
> > +     dr_mode =3D "otg";
> > +     hnp-disable;
> > +     srp-disable;
> > +     adp-disable;
> > +     usb-role-switch;
> > +     disable-over-current;
> > +     samsung,picophy-pre-emp-curr-control =3D <3>;
> > +     samsung,picophy-dc-vol-level-adjust =3D <7>;
> > +     status =3D "okay";
> > +
> > +     port {
> > +             usb2_drd_sw: endpoint {
> > +                     remote-endpoint =3D <&typec2_dr_sw>;
> > +             };
> > +     };
> > +};
> > +
> >  &usdhc1 {
> >       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> >       pinctrl-0 =3D <&pinctrl_usdhc1>;
> > @@ -222,6 +333,13 @@ MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL        0=
x57e
> >               >;
> >       };
> >
> > +     pinctrl_lpi2c3: lpi2c3grp {
> > +             fsl,pins =3D <
> > +                     MX93_PAD_GPIO_IO28__LPI2C3_SDA                  0=
x40000b9e
> > +                     MX93_PAD_GPIO_IO29__LPI2C3_SCL                  0=
x40000b9e
> > +             >;
> > +     };
> > +
> >       pinctrl_uart1: uart1grp {
> >               fsl,pins =3D <
> >                       MX93_PAD_UART1_RXD__LPUART1_RX                  0=
x31e
> > --
> > 2.34.1
> >


