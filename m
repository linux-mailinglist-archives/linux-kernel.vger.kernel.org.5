Return-Path: <linux-kernel+bounces-103946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889E87C6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9FC281DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416F1C02;
	Fri, 15 Mar 2024 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m276eB8d"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C741361;
	Fri, 15 Mar 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464467; cv=fail; b=jK3JX2753py2HJoPhLyGf5WfCIsAPjQ9LZnWVQvraFyScz3ZdCon1F7u7hYa6D1YKW6DkAwlbAVp6g5sO/rG/zl6Zr74Utsp0pO+u0gznUiMHCj1fN3+aD96RKxnMOPjTY25o6LM4r8LIUtDn2XyoIWAud5UYALpnoxHAjlr+Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464467; c=relaxed/simple;
	bh=+4HD/i8bssSYmS4gHBpV7TpanO/JjzVk25SXbOo6Zno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3ZrtFZxQKWQtTm0joQeS0BeWbUF4ztFiHrJowtnbSsW0Y1p3vOI8Xali7o+J3uLX8i2vlFWQnpXspkayiRQcuMpx/lWSKS2KCTwG+6v7azlEcRnf9NOfCGHIV3p4CGCvy5Ep5h0ffcyn54J5awxGbiw3lktruBtytL1TeZQ38M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m276eB8d; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAzdDdt/YnL8QfHo9aWMq4J2RlqlHuSw6c2xaKCTfnFXflMogegjvbQ/ihrngJ9NtsUnaGUhoaHPpJHVGHcTDkefc2tPCiub5rH4J/2LYHS/Q6v3qzeXsL/l57N3abTXjkNChMj5iNdqJKmF4aRu+phy9P1feXwKNOQy7gni6hTIqOeKAQFYgKR83SWjXypEvLO3mAJSxQktj3zFxiq7W9a1/XGZ2kr7aNkO/wi5dPS0qOvH/x2gat6nd2saelf9R8yWCIOJfWHZnkEoozpSFaNUgrhZKXhy2mdl7v36fXQgMaTowb3QiUsTQ9y9wvZKiqWPISFOoy3gFTPRfkY+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZFZqFKUo0ZssTnjR3ckTsUtHGbBYCqa/8hcpHiHjXo=;
 b=UtQ+WrDH54Z8TckSxnjt8BzA/M07zv0TjBMpyq/01jHfxOzrYU05X2463R6cwhQlffYJq1r0i/Sow/my460foOtelwTZPUrHFlGI1TwsrO8JlCpQFh/m6tAYOUfMHxdgy8Hew69aF0gDDxkavfSxe6TsKzRPhog39zFPeKm3vpyd0dFBOkz0/aze1bjuigsYT/4RgsGBOd9uDqLi3uZIFjHaOkMfBQk1li1mADadx+UGcAXqfdMr3bA7SJG0C7a7NK2NM9rzCRV+e06ZXgX0d4+mNVfliwgK6xYw2kqqbwAeLSVLFparlGF9OldGHiqe8DtR6Z/LHgwV8pGhzJ1m0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZFZqFKUo0ZssTnjR3ckTsUtHGbBYCqa/8hcpHiHjXo=;
 b=m276eB8dxiW9k2dkxbvai1dPzjt1H+mp3bVgHZxgosBQRlv54O/hx/B59jMuhNPNTsgbIAeRbTwtVggRihATat8yNk3AFwUoGJSzqvjeJfkS7T0HuPafbtrT7MGIAbMAqXtxqiCgLKPt6Kcs3e575ANMpFdbKrYhiRTHCqgyBrg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 01:01:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 01:01:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
CC: "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arm64: dts: imx93: drop the 4th interrupt for ADC
Thread-Topic: [PATCH 2/2] arm64: dts: imx93: drop the 4th interrupt for ADC
Thread-Index: AQHaaLPCjH2/a6vnk0q9QpbqOHDEk7E4Fr3Q
Date: Fri, 15 Mar 2024 01:01:00 +0000
Message-ID:
 <DU0PR04MB941754A55F21B32418DDC2EC88282@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
 <20240226130826.3824251-2-peng.fan@oss.nxp.com>
In-Reply-To: <20240226130826.3824251-2-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7864:EE_
x-ms-office365-filtering-correlation-id: 6dd47cf8-7402-45a6-dc05-08dc448b6133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0UPV0HUge7na+b4jWEXX2qcy9Ho1xEAN6kdjOUGfvwjmGlmRFsAgmmzCXpWvIg/xTrtPDl2Dr2ScyPLgnW+Aa5wv1Vt84wOqExAvUZhURyylD6l+EG30/CLUuXkhjL1Cw/yEbfZ6LlTV4uSHl/UvjkgMUjaxyWSSiKHXLz7r6z1GszBH4UOqyu6P8T3FXVDO9L7vAOpwNXIV88zS0FBMDnTATumR8TPKvSdTFgMWQM7zvxRK7rXUAe5VkaS6vut4oTplTfpMfQEglGZDhiRt3qjlopFekA6d2ZIGV/YAxnQEsUewem/tP0HEFcbgTICaXehzVD5+F8xYPptS4yRojjknJv50XhUIAZp0A6THWce6ZX8MMNPgjnfq/D8X4tLZtv3/JD3i3pMBP8QQhvt1ZW+UK4LjcBB68LxLerTnKykvsfCZYC5RVHwH5FBpjiD2pmiSo5j4NSO2dFhAjohG2koFrjq0FMWpudW/Fz+J9ksXKCfCSO78gC/tcOf8NYEcjDcZq1pfKm1aSVpxRYNj2bt3oZ4PpgEZ3yHvOc/FS1QGvfsU+bpyglmWGXzHYuaW2FjUlUn9Wb4ESwS1rjBE0Jk+EDvP1Ap64k+XipyLkq21WMakgZqG+DMthqcNIlxP/KEvRZIfJS7wgYk0ysY/00obiEhWxhQ28Gxw55QexjR1xRAqS5LKNPtH0mSeJy/HmPd+YSVxJ+82MgiNCoK6/A1FS/c2K4VyE/SiA1H33ow=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U6rsHcNEpVKoSPklZ3l51QWBZSV5Nqpkzuy5Vx8XJLtaqu8Riv3zpiUpeUt2?=
 =?us-ascii?Q?qSG7+2CZQqlA8hVdF2xUv6QJEdCcCL9zs/oeuVRZR4OkHuoO6bkagKAodql4?=
 =?us-ascii?Q?iX9O0XQuZSKuiv7VegkgDdc81vOXGNLEOHPV2F2XCghUAFz4DNJKUJ9HHEIv?=
 =?us-ascii?Q?zvPJ9Z/90/5KxXvFRlidZq/oIrbrGWGtlIkKQuz6fmPVUb5Xq3xlj6u1aOXn?=
 =?us-ascii?Q?8PXs36NJ3O18J1lIlzsL8hms8ZLPpgdq7kVgTAMVWSNDc3T34AzFjwpH27q6?=
 =?us-ascii?Q?CKCelFn57dT9nKOqNE1fyhScJk54FyK4EcI2dPLt/kaEuGUoC/t+CgkCSlh3?=
 =?us-ascii?Q?gUz1MOxO97IvFXWxknj+nCWuzNeGoKTM6POLe8g5S+cvNck1PJP9BFAombHh?=
 =?us-ascii?Q?pFan3xS8UcEF0tQKzFMUtjIMfydPqCe5LadoiLzr7Z/ZF0cs+s8vE9bkrtKz?=
 =?us-ascii?Q?79gH101GnC/7zTgfAsD0aL9F0sZg6SLsH+5CRYYsVYldwtPGvk6rwiEQXFyD?=
 =?us-ascii?Q?RjxcM6LvCNNJEA+XVAH31jWSDr6areDllzq8Yds6u1tAy+9cz6qs9IQn6Ln4?=
 =?us-ascii?Q?mObGRnX86lvuDyAANDh3pn4IibrK5MmziUWLdbayXmb+ROvR+CeZ+zs81ksg?=
 =?us-ascii?Q?4R4HqGGiDWvf5FIfIJmnW2ShBqKfYDTRHFkBbVkK+/UMJ6BvXY/grrXESRa7?=
 =?us-ascii?Q?Zxcl5z57iAiNnWv12TEKxIyEI9oTPwVuHyOACvx4Rk6wzkbOgBZP1useeCQv?=
 =?us-ascii?Q?zQoWF3VssJVikH5R86o+rHJlrQvY71QJlmeyc+c8H1GwsxQ9R5TJeY2nia01?=
 =?us-ascii?Q?sL8+QHtTRID4ZU3IdJufPSHB3eeZMP8RHAhByjGxvauWj711yQiUEStddLI4?=
 =?us-ascii?Q?e7ONiTDimavggfAanveQDmx4U72FAhUBfxCcnutZCHi5HkEoBxZqHBKjRQO3?=
 =?us-ascii?Q?gprAHggGhcvP+MYogObiINjLphUvtpiHOUSFeD3nw1oZzsf8VdC22XnBZh5s?=
 =?us-ascii?Q?QRytz115uF0VuxGcI3g68ua2XwM/rHY2fIP+QMYsdAao6EjBu2N4Im6Ioe8w?=
 =?us-ascii?Q?IbbuApUtm/uxgnjquZXeubkVDoY6pjl9lYQq3LATtnnyf+aetUtrE0mNg6Lw?=
 =?us-ascii?Q?iHPXMOufdvdEUj486EWNDslIl+GaxjkV6/vegIjPIg8HznrIEFB9n95+Ap0Y?=
 =?us-ascii?Q?vHtxiRwWrSgbmCLYCj6fzRezyR53csz0p7MO9iM0rdnLf2ste4N1F5Wj+uLo?=
 =?us-ascii?Q?SsepSjbXwn6CjKXFrKebz0YUgo/lzka77XSOQvFHOMm0N1t50lJzHgRIDuEW?=
 =?us-ascii?Q?wkdYlhV0OZxUj/6q4Am3LDXbA77+R7NtjezTgonWxxgJc3vEIN9NR0uQ6Z8i?=
 =?us-ascii?Q?suufeh0/m8ImkqRj/byGJHokQsTgUSAnhpZVIoFdGB8kXW4RQp3Gqbsf8mta?=
 =?us-ascii?Q?do9zoS6Kn0F2/Pv00NHOuyh5ASEETfOV5d1nc7UM21qNzJ8jZC92ucrRTEMc?=
 =?us-ascii?Q?GX3LSA1nmS2nDycqKPzyO2dqxOFnHhiTdx+ONu7HWIPEaeYxtObdpHSnTm/9?=
 =?us-ascii?Q?181zZtvx7l5WGVo+yeU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd47cf8-7402-45a6-dc05-08dc448b6133
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 01:01:00.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+IZJPhuJzvPOjCJtphRhwUkbwjhHXEAqaFNhIjS4Zf9Cl2M5kT9OX7PGoevDeqrJFovydBCVkXAPF7XIazxmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

Hi Shawn,

> Subject: [PATCH 2/2] arm64: dts: imx93: drop the 4th interrupt for ADC

The Patch 1/2 has been accepted. Would you please check this dts part?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Per i.MX93 Reference Mannual Rev.4, 12/2023, there is no interrupt 268,
> drop it.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 601c94e1fac8..b8ef9b938856 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -509,8 +509,7 @@ adc1: adc@44530000 {
>  				reg =3D <0x44530000 0x10000>;
>  				interrupts =3D <GIC_SPI 217
> IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 218
> IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 219
> IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 268
> IRQ_TYPE_LEVEL_HIGH>;
> +					     <GIC_SPI 219
> IRQ_TYPE_LEVEL_HIGH>;
>  				clocks =3D <&clk IMX93_CLK_ADC1_GATE>;
>  				clock-names =3D "ipg";
>  				#io-channel-cells =3D <1>;
> --
> 2.37.1


