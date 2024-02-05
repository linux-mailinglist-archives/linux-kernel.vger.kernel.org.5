Return-Path: <linux-kernel+bounces-51988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAA849259
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F93E282B13
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EAE8F40;
	Mon,  5 Feb 2024 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ji+MTM5W"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604679CD;
	Mon,  5 Feb 2024 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099694; cv=fail; b=Fzctq3lS5Qn68Gs8QUJgBKAX1M+egRq84Q3VHHL15/jBaevMO2zaH1qrs+5+XJ+nmr+IfKFXTBGoRP+blRQ0QXatYIK0izi9YQF4bHilvy1vUoSczzubqdLqRHmeIZYD3PEzc4RiONvKxWYc6a8ibnqbWJnLw8XcBvy/gCjIkq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099694; c=relaxed/simple;
	bh=hPNi9K0ttRv3ryuvHtUmkLjoUzaB5dBZSMuGH6/iazs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNnVobfNgmyt3uCcACvqgY0+8Z9c+2erlhbpgYj8ZevhdGZIvMkrlVhmkETAchnnNa2NP+j8XiQMJIyi+n8mT4Hgb6TvbCwupikFClRY0oDhoEPjgYCkkecCe7byIdOAVXmA/+aPT34xFc9gFeDpypjXo2iPZhtQDLtmI9IztHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ji+MTM5W; arc=fail smtp.client-ip=40.107.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur2urN3LgEgXMM16/oclUoLkJ05lD5pWvaeK/u96Hs0821F3zbGUqjw3E1nfJlyIZHU3ECoizHoqz0z2Vl4Ubp1Bn7xq7O65SBoZhxO7niIDwJMnbDapmVBr31Mnb8HP5qa9ZI+HjyOiI0XGx7PLisfY/9+WzCrueWGry5b6Y7362eWbKXlg9WGEejwiXBPI90VbkorFPC/uk+U82q+hPRDYYU+e3FZZHUtAbL8bSfYCdOn7AXOqStLzmK7jVLr467Nfh3oq0qFsknV+IuTA1z7O4Rl6oyYZIxYlV9c/oPt/26Kw2SCC/tLXMKnlHrjnJsCE5kXQeTJ6HibgwVjvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+amDo9t4k719UxxVr0PBPXNflrhAeTwOk3wgpBrO8bs=;
 b=eE8SI6tJeN+9TQCw8KEwyVYX/X+1WhybY9MTgeSb4hZV2z6KVlaOBACKInnZoc68cCUmeOoNt9T126JgbwdNXBhddJ7NB9DjuxF2ea/92zwZuYDRK2ZyL5pxBN4D891bxuHsquFrUguGhKGUtelAM602dbOpS8YKrLWrG/PTVFWNVR8DStxdlWH+E5/Ev5LXCMmDp6xR+u8xecthPu8zzGNSCSQvdrXDWTfoWCwzxUdFIj91NLt3Q8pnNJZhE1+BQwhFoa9OeODTsAkfAS28WNoih34bIoOQFE4DB0ULgFdYV+OpKjvxGtPADdf5RdKxcI2XpIdvvqKHgvbzBMiGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+amDo9t4k719UxxVr0PBPXNflrhAeTwOk3wgpBrO8bs=;
 b=Ji+MTM5WaiBa70c4dH6R+qwjDpuZeXBvdMmZv3DV86O0gvp8pRE3HrSeBf0sLQrbbUkrhpxnvDog5YeX/+Xmdvf6x2wxXxkvXhf3+MYyGsVhBD7GB+3glWblkx5KFneP19aaty3tD3yfRJ+vBsTDhziIwhmwE6ujz7Po37t3wrI=
Received: from PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14)
 by DUZPR04MB9947.eurprd04.prod.outlook.com (2603:10a6:10:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 02:21:27 +0000
Received: from PA4PR04MB9248.eurprd04.prod.outlook.com
 ([fe80::4ae2:3101:1c1f:6911]) by PA4PR04MB9248.eurprd04.prod.outlook.com
 ([fe80::4ae2:3101:1c1f:6911%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 02:21:26 +0000
From: "S.J. Wang" <shengjiu.wang@nxp.com>
To: Shawn Guo <shawn.gsc@gmail.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: Add PDM micphone sound card
 support
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm-evk: Add PDM micphone sound card
 support
Thread-Index: AQHaV9oF61EbjuvISEaxhtAF2fceUw==
Date: Mon, 5 Feb 2024 02:21:26 +0000
Message-ID:
 <PA4PR04MB9248F03E085EDB1B1A5F414EE3472@PA4PR04MB9248.eurprd04.prod.outlook.com>
References: <1703136188-7222-1-git-send-email-shengjiu.wang@nxp.com>
 <20240204235134.GA804317@dragon>
In-Reply-To: <20240204235134.GA804317@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9248:EE_|DUZPR04MB9947:EE_
x-ms-office365-filtering-correlation-id: 6080f1db-6b88-4f8a-6b96-08dc25f1280b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jk1GmNHxp7E+ZLr4+9yqMh0foVIGD1AWDV4qsv7J/aHtEtpMv/6uWHyAFRdj2Vf5wOSGJZp/NhYOEZTCCWcBzEXTjsBwsssBerhaFX7Mhh1QHTF6g32CrixvoH3MspCG4EqUury0NR7bGMCoF9YE6zntj8Zhg9iRbVtsDiDgAl1YVJoyuC5xDak28B/N2X+jzqJ2mmbPGzgNedES/XBRDmpvSzcYJq3BNfzVg0h+kGPTSIo9Qn9jsesy3F/cW6CLIFk6AbJF6l07YRMFQbbT0EEYjotwa/j+CKxqfVwRA9lrsEbNRGfE7IIRF64Vssix18DBSNQTz/X755xZxaiAPyqt3fXWxkcnShOvEJp4Y8JZz1wUn1oAaptNWFLMoNPCoV3Uz0dMmrCErhRptVKeYRFyUS97mXMngggdeuFV7SDft2y8Dv84xSWp7uAI1LzaYNt4qz/r9aXuwu40od6aXVSow5lGZHRLYbpw2+DV0kuM43QIP1AeH4SNBECvG9RQAJOUUtUeZX0DlWJ+QHJIE2Q6V27w8mXvimYTnKr/XEmO9LbkYnFQAfebMbTB87q55BzvEPhI/pma4yA8yPKW+h2zNbS5bTa+O+6NeOp175Acyww49FPbXvP8EyGj6HtS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9248.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(8676002)(8936002)(52536014)(4326008)(54906003)(66556008)(66946007)(76116006)(86362001)(2906002)(7416002)(64756008)(316002)(66476007)(122000001)(38070700009)(66446008)(6916009)(5660300002)(9686003)(478600001)(38100700002)(7696005)(6506007)(71200400001)(83380400001)(33656002)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YRWc9W7v3vjrGnWTLvbvFaMfJbDyIo9Sr5El6341kVdZFWPa7lqlx1/kveZI?=
 =?us-ascii?Q?4B8p69Pm+So2RHQScNZuDZ8gFRlglPg2iosJfscsshyixTce8DMkqQmA6+QC?=
 =?us-ascii?Q?0FkXb/HTlkoJnasDnD71YW7VBsf6NYJtEN2aP9AhAsidLOevhV25l6xCKI8q?=
 =?us-ascii?Q?c+cXqRvm7Ea0piFK9RZtPfYTuXnWMaNesVvFfUbxT+qsJJhrdmR23JzDcttY?=
 =?us-ascii?Q?uvOLQbMwBsQsiMCbvGHow+py9dG5GeHjVpRrKpma+UtgasUujDmsLZ/7iNtW?=
 =?us-ascii?Q?5Jba8bxUIPK/7Al4lnocanfUo49rNzDBMOQ8Pu75QBqVMdZyn0yz2dgZ3eqD?=
 =?us-ascii?Q?VEjEh5l6VuLobCn+FPXYHaRi2nDhoHZdpKeMrpjSzdYxDKzvV3pAYDKgdW0N?=
 =?us-ascii?Q?9Yiu6naMyxuVxCGQ29ePc4JYt6FLEzaOcptbGUpTpouYUUiBk8wx+IEtfo0o?=
 =?us-ascii?Q?xwk+JIZLmBvObuiSfdy/6x6OGk0hL8PMT67wyTeGejrLW6u6yjyskr8X4tcj?=
 =?us-ascii?Q?L1RDyydxHNSIhlDRky8tPRmLkYKCItrmbcHDfv2v3c2Aq2z3z1IVluKqHaa0?=
 =?us-ascii?Q?NethrayriDD7z7+Rb2TCwM6hA1ec1bbEQVzXdZSZM9ur7pEz7ZLmGo3YdcdQ?=
 =?us-ascii?Q?vVcHYeaEDUOeS48YCrbetYApRoLoR7Y32zujgTItpD5xVCEB2KF53SV6jiRg?=
 =?us-ascii?Q?hK+YMsXRagWN2BYhp9iVXJ9xVv7nMSfIQdgbltwPDyDxDTl9CGQlLw2ESnYy?=
 =?us-ascii?Q?9YaRu1zGF9CRubIv+lbpYmMxPDt8ek5AhDPBZ3uzqaVN8caMHrY96/O6iSRU?=
 =?us-ascii?Q?YyewuRVAFv4KazZJQSEIEZt74MxsbedLp/8LLlT5K8Skp9OAuuCKLBoqpcp4?=
 =?us-ascii?Q?Bx5Cv5gnsuKxTCUDpmalu7HDmWEqtiLrD++vfhLrmkBhNVoeoAqgO9LInMKK?=
 =?us-ascii?Q?4AxQHMSQzMQCvn6qweKWLslaZsXtIJUYX+5iMB5z5HK1jaDe0DX1Wvj0/LpH?=
 =?us-ascii?Q?W0Fkl9L1pp53UhO8k+hijbi3JJKoechcwWelOK/uXhpaKOe+2wgpqJz3PsGU?=
 =?us-ascii?Q?tqfSynmndmpuSJPMIS1zPX/7rOGKaXP20FP230wmO0SM9p2eOCtuT3koaoOg?=
 =?us-ascii?Q?vt66i4iJzW6oDJxPL973ep/Ne4Xyurqhaxtgqxcm13h7tt39n84RuGDgYriu?=
 =?us-ascii?Q?n7q7sH4mISpapOxakvVG8M8HCYNFKj2JVUiJ+3EGpPIQtUqt3yXtSHMY5V3i?=
 =?us-ascii?Q?bfK4b47XHrKJ0tXvQbnPI9fC/yM6A2DQvsBdpobXHc7KMe9+Hnashiz/jTee?=
 =?us-ascii?Q?KBMGMzn/kpsSrs30LjLQ0DjgUXLhmdNvFtSmliFhh8wZNntMxDGcqDwTTfD2?=
 =?us-ascii?Q?lE+I+wSwccHTQu0Sj7mwNOV4k+wEWQgqaI7V/xsMgg3y7vOJGhRZ5tAM268g?=
 =?us-ascii?Q?tkM291FOJQ3trGubRdfILSOQbceolawArU/Ogmy02/IMFi8y3QmfUDiVqdKv?=
 =?us-ascii?Q?/pnnTCFEPtQNjR9z7CPndUlsnCsVmu3IclZI6V3UgVpBtLFkRlCcOz87Mejx?=
 =?us-ascii?Q?OIF1OqN4uaFcNPt6fLd6g4lWrMyPQvFdHpAs3TxE?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9248.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6080f1db-6b88-4f8a-6b96-08dc25f1280b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 02:21:26.8618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tirmy0/5iIBR9cke+aOVPr04U9cqetwYmLBqpK3ykZ6b3irQ3ZAHmTmjitOFMeQYSSlb3bA6crF6rv9Qrw0GRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9947

> > Add PDM micphone sound card support, configure the pinmux.
> >
> > This sound card supports recording sound from PDM micphone and
> convert
> > the PDM format data to PCM data.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 34
> > +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > index b53104ed8919..9679786dac51 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > @@ -151,6 +151,18 @@ simple-audio-card,codec {
> >                       clocks =3D <&clk IMX8MM_CLK_SAI3_ROOT>;
> >               };
> >       };
> > +
> > +     sound-micfil {
> > +             compatible =3D "fsl,imx-audio-card";
> > +             model =3D "micfil-audio";
>=20
> Have a newline between properties and child node.
>=20
> > +             pri-dai-link {
> > +                     link-name =3D "micfil hifi";
> > +                     format =3D "i2s";
>=20
> Ditto
>=20
Ok,  will update in v2.

Best regards
Wang shengjiu

> Shawn
>=20
> > +                     cpu {
> > +                             sound-dai =3D <&micfil>;
> > +                     };
> > +             };
> > +     };
> >  };
> >
> >  &A53_0 {
> > @@ -434,6 +446,16 @@ &lcdif {
> >       status =3D "okay";
> >  };
> >
> > +&micfil {
> > +     #sound-dai-cells =3D <0>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_pdm>;
> > +     assigned-clocks =3D <&clk IMX8MM_CLK_PDM>;
> > +     assigned-clock-parents =3D <&clk IMX8MM_AUDIO_PLL1_OUT>;
> > +     assigned-clock-rates =3D <196608000>;
> > +     status =3D "okay";
> > +};
> > +
> >  &mipi_csi {
> >       status =3D "okay";
> >
> > @@ -636,6 +658,18 @@ MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5
> 0x41
> >               >;
> >       };
> >
> > +     pinctrl_pdm: pdmgrp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SAI5_MCLK_SAI5_MCLK        0xd6
> > +                     MX8MM_IOMUXC_SAI5_RXC_PDM_CLK           0xd6
> > +                     MX8MM_IOMUXC_SAI5_RXFS_SAI5_RX_SYNC     0xd6
> > +                     MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0        0xd6
> > +                     MX8MM_IOMUXC_SAI5_RXD1_PDM_DATA1        0xd6
> > +                     MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2        0xd6
> > +                     MX8MM_IOMUXC_SAI5_RXD3_PDM_DATA3        0xd6
> > +             >;
> > +     };
> > +
> >       pinctrl_pmic: pmicirqgrp {
> >               fsl,pins =3D <
> >                       MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3               0=
x141
> > --
> > 2.34.1
> >

