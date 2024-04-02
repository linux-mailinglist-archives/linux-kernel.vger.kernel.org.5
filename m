Return-Path: <linux-kernel+bounces-127798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E007D895120
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94916286A72
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE07F7E3;
	Tue,  2 Apr 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Trq6JsZ8"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2111.outbound.protection.outlook.com [40.107.14.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC967E0F4;
	Tue,  2 Apr 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055473; cv=fail; b=UypvGoc3rZlgpHaUrOQaBojttql3vzjyWpViKmJXYIad5v9VdO94XxvdG64Vh/2fMDOR7jay8/rnu4zW1fmaP5yC6BcXFauhxFYWm/AaRTIq62IkMLIuSK1a5ICB0OJl+isxeuVKpsIL4z4vzVRP1vvotwhoZJ5RSTZlas3Lh6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055473; c=relaxed/simple;
	bh=fZkX2XEb8DTPL0ZpRZoHq/C2Rf4hON5OJcowwF4LKRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KY+KbQe2L9poIIjB/IHO+bDC84LA0wnoiOz8NicdXArHXXgEajjcG/XlsbbibVA4biAW4YVrgW68A61e+DqC/9VYLSO9HFokOW5WWZWqBZupnlPhJA568gEm6zI3Z5nyoO0juSFzZWKivtEbAbct5lkFxEsSttNEe/8s01fiQ4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Trq6JsZ8; arc=fail smtp.client-ip=40.107.14.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFUB1lXmUB9gnXgBcpRwBOwpTvU9Oz2gCF+gpNRAkQPLCpXx3OnRH8WjlRatyyiVMc+hdtS7AtUUyoLzF1i5KmC0LOyhkCpMprLJL5gMhnNBah0R6EkeKlj/CMPa1EIZ3fRBccsnphG5rNlprHsqEw5xPSg2P4zh7m9hinIsrjkxS85uwgrklvVrJ1m4etnLjTyE6kSS1hjUjWBSqIcznPa5EEN1eAkwang5vIx+rod13DRNCnZjcZiKXrKTGXBLm3Kp4cFZ2Hj/3vlPvSxw6frrq3AZxewGQKOoD/NZ66XlI6TU/bON2pgRAt4AzVJLY9pz8HfocZM1QioYkOlEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aykXMAnVJm1znKxK1fpgoUG8C6P1KgATvjvhvZBcuw=;
 b=MGjwz2AyrcYjLoQSGN4VRBslOHy83Y+A4h5LQKsh/5Mu8U0E/ixdrV2TbIF/sogt3eAU+HBiSRTQ8iN925kvv62SQNepXC2wAA6OEIgLopPGp6W1wkZIJnIn59Gb/fPdQg9oh222WX3dVsOsilK+nwIP3Rm3E9U1D47G7EvEEPZ7l283z98uNKxmsrVapZ03IfsCGfMUZWrt9b/+i9ZkOWBoKMnG6Qs5xH8p5fbmBpOKFbsqdl8MJeUWbd/mDMhEs2q9hnInHduehXjJBTIkvixyn1Hp/QSPdqk4u0usHYPVB6KrE9yuPjUrw87npjwUx3gRpQZrHyy41hXCg/D2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aykXMAnVJm1znKxK1fpgoUG8C6P1KgATvjvhvZBcuw=;
 b=Trq6JsZ8u1Y0ajR8XAr2jXM1aXFoXpqGDVHnCrwE6AnfZSAchr8vEKTvecu8iTcmERjurSH0wOlWCPufBJyjhMYmxhd4JNr2dKVihKrR9iCks2oeyoowqoorPLn/3sSN9/9GghY1OGj4RfqjqpLZr1x0aDSC1Q9XMmfpAhCSELE=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8115.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:57:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:57:46 +0000
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
Subject: RE: [EXT] Re: [PATCH v10 08/11] arm64: dts: imx93: add usb nodes
Thread-Topic: [EXT] Re: [PATCH v10 08/11] arm64: dts: imx93: add usb nodes
Thread-Index: AQHae2ffBy+Xup/fwE6K9MWKmQtH4LFUu9+AgAAgiJA=
Date: Tue, 2 Apr 2024 10:57:46 +0000
Message-ID:
 <DU2PR04MB8822270270971F34455558ED8C3E2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-8-xu.yang_2@nxp.com> <ZgvEXZTOHUv+GGeH@dragon>
In-Reply-To: <ZgvEXZTOHUv+GGeH@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM9PR04MB8115:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UVx1I/+XQ6nkp3mLYe7oCv6L8R8FJyVT3fDnjrm3pMFOoMPgN2pTTQ6bejupehcW/CkFUJHubDUCJRI6CYAwWCqQi/oPalhMYGZpUVujU5L++olmVPQiiCiCV1IeVaD3hrQySvoq4kG5dgsdt+kaQCFyskf7s4x0N0oFxDXUTFaZuooWIltN9v/XJtsmbvuePQuNMXS7qA2FH3HY5Ex59AHmJnAwDOmLvpTtzxHef+Qict39JLhu/B+UfDQxkA4Vhig0mzAFTnb5zU22d6r9HRtZjvrgjWzq0BOrnyKs8zpyDFVu4CSQ7qCpDNHlZt5yiylwrRAy4LfxUKmK4UFfAWvfDsq+XGbJCuOFKv1JsA7M/JVE/MpZ+N4hbffNXe6yNha3KBSJxsJUqUVbGoDZLrkjX+cMCpVDWvidqy9loIgYjt7Z5Xd3555hR1dYhZjll/gm89EEoY2n1McFouCVd+Kc/HMryRX3D1I7L0HyLFCoqAdJTsBbT6/R+o4WNobU/FBtbW9QjctQ8C/eY+8hJPzi/XXJlR1qF993l6cQza7JHmaQjZf4Gc66o/d5/X6YIA3VrvGBbqkTYW3UTLOqA6mKf7DkYMS3KWsH/pWaEkcz4DQnp39p0LWrt+1Ux9dthUJr5HMq1l86yk7t1H49obXOWvQUGPWD+3LsvCXmrps=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4/ZERUg6fLnxey3ILbFGtt6Dg/R2e8RdUkIv0qFxHt0EOJAoYUI3MnebvFVj?=
 =?us-ascii?Q?nJOERQ0EzXp6rCg4PTV4/YlY7+ULyVeHxlByDhKHMoPfLkFKt+F0B2tX2T0E?=
 =?us-ascii?Q?ENebMKkHzV2d04ze3hDJvhTOrF4qR6jcASnFnGnJR6iQScHP8D4BZeYIap9h?=
 =?us-ascii?Q?QWz0TQ+Y1Q2Gog+loYc0HDzFkoNCKWf7Tn++wRj/fNjzj3mPdkyaKMFg6Ch7?=
 =?us-ascii?Q?Yup+yomwL5U221dUZ0MA2lu7GLscEbklHOvmQE+x5kui2x78c78KW8XBovNI?=
 =?us-ascii?Q?5cMxhnkKuigPDQhzZxrghrTyFQeWbM01WNHLr9K7XSBcVXifilJL0Dm8kKSa?=
 =?us-ascii?Q?AhX5cTtWOEHYJND/Ve8BuAvz/ff058FA8FoZ+20RyDySeMOKfOCsTmEmoGxw?=
 =?us-ascii?Q?GEE17wml8RQSPsiESrc+EvPe6GbNv6ASvfd+XtSTgtTdoVP7TcCh7e8MoWfj?=
 =?us-ascii?Q?rTcWwcNfwqg0vqy2F7I20t9DM7p6ymveZER9CobgIk91+pNAPALWIC5wrZF8?=
 =?us-ascii?Q?2WT75HSKGjxttzUQIICxB3eSxRn8YLomNbir4DcnxwEnPvXQFDGv6O3Ka4Ma?=
 =?us-ascii?Q?HPtVGJdlhMRgfTdjZKfO3Ak20MOS+2hPp2An4cAEnm0DP+3p7VP2hRu3VPQJ?=
 =?us-ascii?Q?22/RGQFWvGw5pNaT04ReS4o/BYkIXtCbATAS5QfQd0l/7F15gItmF4uaxe9O?=
 =?us-ascii?Q?UQ5RZwySlPQl0HKMLYMQ/AOpD5FzqnEB1lzB7LJw/4GxWRYgUyBvqltf5uC1?=
 =?us-ascii?Q?x+fgFh0ISowNpR+ffrH+WD4MVic8JyH1Jx7ahthjkRmD3es15W1WHKUR9cwx?=
 =?us-ascii?Q?f5CCh4Uo4T9JT7n6ljLPScplrA4m6ULbN4rw2mSNitSn+ZSM4zDGtG2zJzNu?=
 =?us-ascii?Q?tYN9WD1AUYyNqwSKdYU6T9JqOIs+MBOZWcX2pntFYRdUm5U0rSxlgUa5M/MO?=
 =?us-ascii?Q?baa2swqKu4tvBqiL01Sp4JIbchpyybbT9++9WO9Aiepc3OK77lA6g3KDA3di?=
 =?us-ascii?Q?LEtSpGvs8/AcfMdDCB+EALJIsCGE5FtjXdk9oW32qwrVyx8ByK7cT1O9INgd?=
 =?us-ascii?Q?STms7OAy/MtKXLj+4WTct8Qy5V6k4Y0Q/J8ClAy0qLeOFWCrgsZVruSD9krZ?=
 =?us-ascii?Q?itQbu60Qrcw5nA22A32m8ha2rmT3+DvUgRJr76gFeig1lmo7SL9wpMtlOHC9?=
 =?us-ascii?Q?HNOsMTr2DlKbNQnLuxz3irpnsjWESKRWDBkx2KQt+SsZzZXtqH7XEDno+/kT?=
 =?us-ascii?Q?sI3Uaw3UZm43pFN/3ogREWEfe+eeq8rcuQG0ygaSiuu2hTrcpMujQH97SYoR?=
 =?us-ascii?Q?TFSA1kLLta/Nq1ML23b4/uWfOi4s7WwikOL01zWHBaNOZEHSUaEpsLzzHV+X?=
 =?us-ascii?Q?WIm4beQh745Bm2Jx5FVkfIYckpuPrCARKmHOCNDsQp0oql+pgmZa8tbC0/jK?=
 =?us-ascii?Q?fWdjEyjRrXTp9+L9benfHMrtQKZUQlYimFnwz6iFBdzrIZ8whbIeXd6FJVVK?=
 =?us-ascii?Q?v1OJMeeZ9U6TfLHdH4ZgljFYxUKpZ143BCarWJQb8IRXYT6oinrP0964an28?=
 =?us-ascii?Q?f1rlrs/EW0H4uPXRiUo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a19dff0c-0de8-410c-8cc9-08dc5303bb17
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 10:57:46.8009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+ecqbd0H6SpuGUGoS8lHZZZzG7nJyqnlKhEdJfxmPKgUQuuu/nWv/hL/OeDsTNUrn0egZ2cY35oItmuxY0uqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8115

Hi Shawn,

>=20
> On Thu, Mar 21, 2024 at 04:14:36PM +0800, Xu Yang wrote:
> > There are 2 USB controllers on i.MX93. Add them.
> >
> > Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa9352=
LA/CA
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - fix format as suggested by Alexander
> >  - change compatible from fsl,imx8mm-usb to fsl,imx93-usb
> > Changes in v3:
> >  - replace deprecated fsl,usbphy with phys as suggested by Alexander
> >  - reorder nodes
> > Changes in v4:
> >  - fix the alignment
> > Changes in v5:
> >  - rename usb_wakeup_clk to usb_wakeup
> > Changes in v6:
> >  - rename usb_ctrl_root_clk to usb_ctrl_root
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - no changes
> > Changes in v9:
> >  - no changes
> > Changes in v10:
> >  - no changes
> > ---
> >  arch/arm64/boot/dts/freescale/imx93.dtsi | 58 ++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot=
/dts/freescale/imx93.dtsi
> > index 8f2e7c42ad6e..4a7efccb4f67 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > @@ -183,6 +183,20 @@ mqs2: mqs2 {
> >               status =3D "disabled";
> >       };
> >
> > +     usbphynop1: usbphynop1 {
> > +             compatible =3D "usb-nop-xceiv";
> > +             #phy-cells =3D <0>;
> > +             clocks =3D <&clk IMX93_CLK_USB_PHY_BURUNIN>;
> > +             clock-names =3D "main_clk";
> > +     };
> > +
> > +     usbphynop2: usbphynop2 {
> > +             compatible =3D "usb-nop-xceiv";
> > +             #phy-cells =3D <0>;
> > +             clocks =3D <&clk IMX93_CLK_USB_PHY_BURUNIN>;
> > +             clock-names =3D "main_clk";
> > +     };
> > +
> >       soc@0 {
> >               compatible =3D "simple-bus";
> >               #address-cells =3D <1>;
> > @@ -1167,6 +1181,50 @@ media_blk_ctrl: system-controller@4ac10000 {
> >                       status =3D "disabled";
> >               };
> >
> > +             usbotg1: usb@4c100000 {
> > +                     compatible =3D "fsl,imx93-usb", "fsl,imx7d-usb", =
"fsl,imx27-usb";
> > +                     reg =3D <0x4c100000 0x200>;
> > +                     interrupts =3D <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
> > +                              <&clk IMX93_CLK_HSIO_32K_GATE>;
> > +                     clock-names =3D "usb_ctrl_root", "usb_wakeup";
> > +                     assigned-clocks =3D <&clk IMX93_CLK_HSIO>;
> > +                     assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PL=
L_PFD1_DIV2>;
> > +                     assigned-clock-rates =3D <133000000>;
> > +                     phys =3D <&usbphynop1>;
> > +                     fsl,usbmisc =3D <&usbmisc1 0>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             usbmisc1: usbmisc@4c100200 {
> > +                     compatible =3D "fsl,imx8mm-usbmisc", "fsl,imx7d-u=
sbmisc",
> > +                                  "fsl,imx6q-usbmisc";
> > +                     reg =3D <0x4c100200 0x200>;
> > +                     #index-cells =3D <1>;
>=20
> Do we still need this '#index-cells' property?  I see it's being marked
> as deprecated in bindings doc.

Sorry, the driver still needs fetch the value of this property so far. Othe=
rwise,
the driver will probe failed. We still need some time to totally retire thi=
s property.=20

Thanks,
Xu Yang

>=20
> Shawn
>=20
> > +             };
> > +
> > +             usbotg2: usb@4c200000 {
> > +                     compatible =3D "fsl,imx93-usb", "fsl,imx7d-usb", =
"fsl,imx27-usb";
> > +                     reg =3D <0x4c200000 0x200>;
> > +                     interrupts =3D <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
> > +                              <&clk IMX93_CLK_HSIO_32K_GATE>;
> > +                     clock-names =3D "usb_ctrl_root", "usb_wakeup";
> > +                     assigned-clocks =3D <&clk IMX93_CLK_HSIO>;
> > +                     assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PL=
L_PFD1_DIV2>;
> > +                     assigned-clock-rates =3D <133000000>;
> > +                     phys =3D <&usbphynop2>;
> > +                     fsl,usbmisc =3D <&usbmisc2 0>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             usbmisc2: usbmisc@4c200200 {
> > +                     compatible =3D "fsl,imx8mm-usbmisc", "fsl,imx7d-u=
sbmisc",
> > +                                  "fsl,imx6q-usbmisc";
> > +                     reg =3D <0x4c200200 0x200>;
> > +                     #index-cells =3D <1>;
> > +             };
> > +
> >               ddr-pmu@4e300dc0 {
> >                       compatible =3D "fsl,imx93-ddr-pmu";
> >                       reg =3D <0x4e300dc0 0x200>;
> > --
> > 2.34.1
> >


