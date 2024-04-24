Return-Path: <linux-kernel+bounces-156739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C950B8B077E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8113A286602
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3F159585;
	Wed, 24 Apr 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UhHgHxoO"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0B158210;
	Wed, 24 Apr 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955189; cv=fail; b=kwH+QPfOTQJSK9+iEZxutDYfT1jBAtrvHkdSepXAjoy+gZTbm6ZG9vuuDOettGdvVhrZXksh4Pbv3xmAZMfOyQ5vX4y8xft/DkKa/aVaybnwfiuZrszQPws2y7BlYSJc0UC+c3DVD8ptyDDr8HNnXldYuCM1dyTtQp9QPDDcac8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955189; c=relaxed/simple;
	bh=KbYYWHLYjlXwnWH/i4L5dNtLt7MdSNoA3AYr99a1zu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2KBBbuKuxLdp2ZWONUpFnf2IuHieLj/0VukvgldenjaRTvj8D+pTtOzzvXtBwT53MOYwWVISjZzwtYv7v1BIgrXUaYRcLw/FI7Pt7a9/oeLoCW/xy2fXm9c+dFcJ+KBJzN7JGo9DKAjDFHqbazP7EWisrePV5AskYvFAses0xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UhHgHxoO; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+/Dvz8+dd6XP0K+Xcrc41us0FMI98FAQhmrE++ShtnsyKm1g9Neoq4H6SK0xMs5PLu9JIZRkVw8OebSkYJnEiNDToQw63KTM0pSqJFZqJVnkz8ZlhoypspwnZWyjYNMzTqDsv1ugV9zAhlwFVP4yGclThqNM3nOijYnhAzJ1JOA1n3UCU/RSIiyxKjZeq66UoJSPZMY7TD7zzD4Nv/ddc7z2eJ+w2QWTtHlG4vGxR2BUgTNh8hZhnOfyuk3W/BNFGtUOD/jtsm+/kTU5VlwObeTGafdbUHrK+BnearGCaPg+3UjUODfh5slM6ADmzjvIoEwHfoKwyNpDT8G+lTiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRIgpUayy+9y8+VOMRM0CXMYPOWG6j3dAzCCfD1xMDY=;
 b=awU7vSHKacQw3DgKjY/d/PvxPTO3G379m+K0a0fSN4oRurhVnEJ1G6OCl6+0Y+z8uZVlqXWZi8FjjxHC1fSTLPIRdIQ/dqpp/L2Qpa1vHx2Gj6WK/jsLicGEVXYZDxpokedtUWY+reZuHnAMdyQ0vzRuZfuYC6SJn3YcvydUvZyvY4O2HhHldIMSopwDBAPtrz/c4eBY97vs360fj4JzBqiFbb9wv+R79ON7qoj81SG6h9bts6xGCpHjh7GYbM2nj5GGNmCOnahbLX6UbyADl3T1nPc8cg+pveYlPUtQCNaBAtm+l7m0FJLGt9oGUFIRLDoBVvyYv9sYkEAemUhyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRIgpUayy+9y8+VOMRM0CXMYPOWG6j3dAzCCfD1xMDY=;
 b=UhHgHxoOpCBEN9H6L41jGdj55lOK232hase+nrfx0vrj3vAO7O0fuAXQlpfyPBoyxx1uVQzTKhUNYeDG5jkOVXskiHEkFOgz4+8YHeMU5AEf0NTWCXgp9ct7O50rsFqVdJfVYEX5OdosuSivQRzf/WlJMQiMYre+x4Ablv3PHpI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7405.eurprd04.prod.outlook.com (2603:10a6:800:1a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 10:39:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 10:39:44 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Aiuto <fabio.aiuto@engicam.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, matteo.lisi <matteo.lisi@engicam.com>, Mirko
 Ardinghi <mirko.ardinghi@engicam.com>
Subject: RE: [PATCH v4 2/3] arm64: dts: imx93: add Engicam i.Core MX93 SoM
Thread-Topic: [PATCH v4 2/3] arm64: dts: imx93: add Engicam i.Core MX93 SoM
Thread-Index: AQHaliMGtjTu4L2HCUOD9XlB0g8kD7F3OwjA
Date: Wed, 24 Apr 2024 10:39:43 +0000
Message-ID:
 <DU0PR04MB9417AE3A84178A0350D2D0BB88102@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240424083607.11162-1-fabio.aiuto@engicam.com>
 <20240424083607.11162-3-fabio.aiuto@engicam.com>
In-Reply-To: <20240424083607.11162-3-fabio.aiuto@engicam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VE1PR04MB7405:EE_
x-ms-office365-filtering-correlation-id: 55802a5e-d437-45d2-342e-08dc644adaba
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?slwPWTpV0/nVhUXSNSSg2ZNd3HGbdmJ/kjgso7Kwx1mne3Wzl2VG/oLESdPF?=
 =?us-ascii?Q?ELg6o6AjDeBAEhc8qaVf7ZLV5LLCzlIFAVzeGSb5K1lD9tNmV1OXfJr1S824?=
 =?us-ascii?Q?xV3FyArXzU3gdiDcomVE5TWTf6N+wpW2E4nRdpLcJmys7zrNFjfxJUmtfeDq?=
 =?us-ascii?Q?17QhAXGBFyFnNscAiX84qzp+O++FPgtKgsiyhJWTzVjZ+a/aGijL6L+pz59L?=
 =?us-ascii?Q?VO8ZLrVFg4kWM/Gge3d/aLl0ukdapDjY45zj9MmuYpqiAvXUrRUjmgd8TqA4?=
 =?us-ascii?Q?WoiQ1BFz9/zJV+DiTN/KGSIat7+1jzsbCsFhMVgoPSBYLJRO0tqfdaoJ1i5v?=
 =?us-ascii?Q?I1QmYdVpT+IV5S3BSrAUT4n3K/2ME9kbR+nkMmHki8xfEdjc7BQ0DMLJunmg?=
 =?us-ascii?Q?hbECLvw9nfQ7ZfvJEO7nBtJnmD8X3yIehx13u7ESykdTmMU1UKJ4eVVCy16h?=
 =?us-ascii?Q?hMuRbntdHg7J2RpK/7a9Ir/RaLXt4YAJ2zjTaq1gASiC+/puiFXqFMeCaFM3?=
 =?us-ascii?Q?T31P52nnAQwF7mq0pyOvqSNuYIgmJNJOvza2xzG12gYU5ahWpmA7zJBbIVIj?=
 =?us-ascii?Q?2+qwdML3OKKScqir0lPJNSsj99YTaJ0T/yau3KdTb23GRYAiqFDdoMe7udwa?=
 =?us-ascii?Q?FtDCl/XiDdK9/KYXKyqQKrysGpLyMKXTCRMR/JOVcIWR1p/fGPtP/HwMHek6?=
 =?us-ascii?Q?l65UlHfY5T4pxB3TbASbtl9Nyz9nY6mRWh9VxksLsxfoJSZLt9qbGkWrjL1a?=
 =?us-ascii?Q?ypQrMXenYkx4zxv9aSyHquJRTxjtCCD9tB2JVAX1tKaXYpUFA/sv6PI3IJ97?=
 =?us-ascii?Q?ahlcVYlCNbl+qn6i3VrDq190ojIOoEZry+S0EM1tf+44peMgq0+E2k0oAr1K?=
 =?us-ascii?Q?9rxvzop+/kEaTEuuwG0BafSlZIJxqCUh7KAT3x+dMZnwT69XwlmVUfpWY4h0?=
 =?us-ascii?Q?JmwfvKkDgpTyWk/yTo3mQQNw4zbaP8F2UrsufbgcpolU+5cTax1xlm22HaZM?=
 =?us-ascii?Q?3IzvSPSqlvz+g6xi8ERRhUORx2zupgJx7C7T79Z303ZG9vKJGiwQUPJHk1yh?=
 =?us-ascii?Q?VpLl7Qk2NN0tywZ56n/Cy/83MbpeQHK9uGHZPPmByJNMluuFhMt6l4IBKV1k?=
 =?us-ascii?Q?++rMn4atlQrlMCna+4+L8TdwOJRIVtiDe/AconYqGHOnmzxD8jDGov21ePda?=
 =?us-ascii?Q?W/LqFuGn0cAWbfSlClho9V0l4xTtK1ARR4uP/IsVDnJPh2eFCddIdYsIT0BP?=
 =?us-ascii?Q?7gHTXs2+dAXc6eUyjmTXFQHbUrBrLJDOUxoDmtRxsHXzxPh0mes1MHBhutwz?=
 =?us-ascii?Q?1AMyotoWESn3Jgdxg99pXEKNPYVPWAKgXrc4sXJV9OnBUA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zi+1xGN4PuE11eejcTb2N6ddFy+B9uNSzNR+fEDAeWKTzyfCV5vAIlLIxkOh?=
 =?us-ascii?Q?zXm5CLxLyvTTTuoZpdYxyw9bfqTKMR9xuJ9/I5k1Ln9f44O3Hl46P/DniOVc?=
 =?us-ascii?Q?uM/f6n+dlP6tK9f0P27gdQ+lnOxAeJA9+Jscf5WTI0JFcqj42glsppGnOSkY?=
 =?us-ascii?Q?LuD12KkuUKCzpyEiQmWV5qx79+jU9vjkF2zX2I78sRmlQ5j/890JquzOOQwK?=
 =?us-ascii?Q?2EStKbvw2wDBlZXYxgt2OQVAVH9tV+aPEpCG1tX6Lrm8qveVrLF7Q5OH6lFA?=
 =?us-ascii?Q?cKdS5kDR85Oj0SrKLhyk2HFsrstl0BW11uB/KlYCGLK9dB1QGlPziGLOgcB1?=
 =?us-ascii?Q?u2Hzq6e4u9K1r3OW1FpR3GRAIbNsII1IQ3fsNWcJmmmn9CSNifTbCidWdfM6?=
 =?us-ascii?Q?LPxbTTRo76jzt9+mseUUETfmDRfIufP8oNJ2lIyAp0K7Bsvd7Y4joTUzRwxk?=
 =?us-ascii?Q?8NOAO6FoxY70ggSHaSksUHw5+yNNNedOaneYs9qXlOUSjc20ov7NuO9dfKgo?=
 =?us-ascii?Q?gmlRQYI5rfQPUFh0OAz9mWpV1RJAhCGz2XYDSXpfIfDLm6ETrN46STryNrE6?=
 =?us-ascii?Q?5D42cXoutqXCs8U6DOzLBWGIr7OfzYOmdqeBjsyUNl3eYwd+FfttSyAyTTdl?=
 =?us-ascii?Q?QkvanHGtwWP6whizUj2jPQ3ya7xO+P5kJ8NEAoWfin3VyuTmay+2VG/DAlCR?=
 =?us-ascii?Q?WErCyi8LuPC5d9bCBgfStkXRAjOfA7jCl10WHrvIlDUxJfWQd867jqGkBPUh?=
 =?us-ascii?Q?z/HO8CVb5mZZhPu9SI0NertQoc+d8IE/bHtMB7rnkJ1y6D5Mk2c7Cz+f8aFy?=
 =?us-ascii?Q?k5qQEz4/xi+vpnfBDtnk2XXryDzOr13ZkqWmimxUX7jBtNQL9asDdg9LGhY2?=
 =?us-ascii?Q?Q3C0mfjjnFq3XIArqrqc2TOjgLHhO5Oo3VNP13ff4Iu0gy0sCANpbeEV+Xa+?=
 =?us-ascii?Q?pkEUAxJVXVkEZxcVNbLxJKXV5mGV2Py9J6NgJ8vRyvHxOsoPAffRuCrTYR2p?=
 =?us-ascii?Q?/6t6bDF9vd8DpckLBvuIeOq1UWiJk5KdP8lzs8id1+xqrlYejQu2AJiL2t2o?=
 =?us-ascii?Q?mpdmnUYgRuRkAd4SDt/PufMx94e0dZlFLYCILHkN3kQS9FdUAKLEdwcgRykJ?=
 =?us-ascii?Q?d5Ugxk6oWUa2ZJi7EW/fWNuV6PXC08YU0uk9rWjeeHQRzddaiN6WX6uPcS+6?=
 =?us-ascii?Q?fwDrAEB1xKoSptSjRNGtzvYEAlCxQaV5tGRmIKWjbfxLurYAHwsCOr9VgugD?=
 =?us-ascii?Q?2tCv/d1UTgRhcNiELhf5MzIMAqnsYxAeRK2A6UH98Z29npzMo7RjWtm7kzbn?=
 =?us-ascii?Q?tnxEGV7TyOnB8v1SbySJRMzwARVLcIRXfDKcc9WcD/G+LbeaD3CuJ2BuWXsS?=
 =?us-ascii?Q?Uafp0wgO+iOFCTKHJp9Pe3R4yOEgqbGeHXeE7tqPqy+MYOfqNvtmszhxAB4B?=
 =?us-ascii?Q?vQBMW8gFN+ujUwB7+524lehYrEWWebwBHPqYZtRez8JwWCCJKC32TnhGU1B2?=
 =?us-ascii?Q?Ry/qmyCAu9yyB2/Z1F7+zf5m4Qum/WWlwGM7gXWDZ3pHYCd2nWU8Y0Yq3Try?=
 =?us-ascii?Q?OmMybaOyHmZaxg4bV3Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55802a5e-d437-45d2-342e-08dc644adaba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 10:39:43.9445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etDuWujoCBcb7X2CwZEV3Q3h+yD3xZanSPVYPsT8JRQP2NZxvl395jD8SJjoii1TQIQRnzIrczB3Vv19MedbiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7405

> Subject: [PATCH v4 2/3] arm64: dts: imx93: add Engicam i.Core MX93 SoM
>=20
> i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.
>=20
> Main features:
>=20
> CPU:   NXP i.MX 93
> MEMORY: Up to 2GB LPDDR4
> NETWORKING: 2x Gb Ethernet
> USB: USB OTG 2.0, USB HOST 2.0
> STORAGE: eMMC starting from 4GB
> PERIPHERALS: UART, I2C, SPI, CAN, SDIO, GPIO
>=20
> The i.Core MX93 needs to be mounted on top of Engicam baseboards to work.
>=20
> Add devicetree include file.
>=20
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-icore-mx93.dtsi  | 271 ++++++++++++++++++
>  1 file changed, 271 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> new file mode 100644
> index 000000000000..32a56d51f904
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-icore-mx93.dtsi
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP
> + * Copyright 2024 Engicam s.r.l.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx93.dtsi"
> +
> +/ {
> +	model =3D "Engicam i.Core MX93 SoM";
> +	compatible =3D "engicam,icore-mx93", "fsl,imx93";
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vref_1v8";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply =3D <&reg_vref_1v8>;
> +	status =3D "okay";
> +};
> +
> +&eqos {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_eqos>;
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ethphy1>;
> +	status =3D "okay";
> +
> +	mdio {
> +		compatible =3D "snps,dwmac-mdio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		ethphy1: ethernet-phy@7 {
> +			compatible =3D "ethernet-phy-ieee802.3-c22";
> +			reg =3D <7>;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_fec>;
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ethphy2>;
> +	fsl,magic-packet;
> +	status =3D "okay";
> +
> +	mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		ethphy2: ethernet-phy@7 {
> +			compatible =3D "ethernet-phy-ieee802.3-c22";
> +			reg =3D <7>;
> +		};
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	clock-frequency =3D <400000>;
> +	pinctrl-names =3D "default", "sleep";
> +	pinctrl-0 =3D <&pinctrl_lpi2c2>;
> +	pinctrl-1 =3D <&pinctrl_lpi2c2>;
> +	status =3D "okay";
> +
> +	pmic@25 {
> +		compatible =3D "nxp,pca9451a";
> +		reg =3D <0x25>;
> +		nxp,wdog_b-warm-reset;
> +
> +		interrupt-parent =3D <&gpio2>;
> +		interrupts =3D <15 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name =3D "BUCK1";
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-max-microvolt =3D <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay =3D <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name =3D "BUCK2";
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-max-microvolt =3D <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay =3D <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name =3D "BUCK4";
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-max-microvolt =3D <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name =3D "BUCK5";
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-max-microvolt =3D <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name =3D "BUCK6";
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-max-microvolt =3D <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name =3D "LDO1";
> +				regulator-min-microvolt =3D <1600000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-name =3D "LDO2";
> +				regulator-min-microvolt =3D <800000>;
> +				regulator-max-microvolt =3D <1150000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-name =3D "LDO3";
> +				regulator-min-microvolt =3D <800000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name =3D "LDO4";
> +				regulator-min-microvolt =3D <800000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name =3D "LDO5";
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc1>;
> +	pinctrl-1 =3D <&pinctrl_usdhc1>;
> +	pinctrl-2 =3D <&pinctrl_usdhc1>;
> +	bus-width =3D <8>;
> +	non-removable;
> +	status =3D "okay";
> +};
> +
> +&usdhc2 {/*SD Card*/
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	bus-width =3D <4>;
> +	no-1-8-v;
> +	max-frequency =3D <25000000>;
> +	status =3D "okay";
> +};
> +
> +&iomuxc {
> +
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_ENET1_MDC__ENET_QOS_MDC
> 0x53e
> +			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 0x53e
> +			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0
> 0x53e
> +			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1
> 0x53e
> +			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2
> 0x53e
> +			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3
> 0x53e
> +
> 	MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_C
> LK  0x53e
> +
> 	MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x53e
> +			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0
> 0x53e
> +			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1
> 0x53e
> +			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2
> 0x53e
> +			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3
> 0x53e
> +
> 	MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_C
> LK  0x53e
> +
> 	MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x53e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins =3D <
> +			MX93_PAD_ENET2_MDC__ENET1_MDC
> 0x57e
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 0x57e
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0
> 0x57e
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1
> 0x57e
> +			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2
> 0x57e
> +			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3
> 0x57e
> +			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC
> 0x5fe
> +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL
> 0x57e
> +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0
> 0x57e
> +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1
> 0x57e
> +			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2
> 0x57e
> +			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3
> 0x57e
> +			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC
> 0x5fe
> +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL
> 0x57e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins =3D <
> +			MX93_PAD_I2C2_SCL__LPI2C2_SCL
> 	0x40000b9e
> +			MX93_PAD_I2C2_SDA__LPI2C2_SDA
> 	0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD1_CLK__USDHC1_CLK
> 	0x15fe
> +			MX93_PAD_SD1_CMD__USDHC1_CMD
> 	0x13fe
> +			MX93_PAD_SD1_DATA0__USDHC1_DATA0
> 	0x13fe
> +			MX93_PAD_SD1_DATA1__USDHC1_DATA1
> 	0x13fe
> +			MX93_PAD_SD1_DATA2__USDHC1_DATA2
> 	0x13fe
> +			MX93_PAD_SD1_DATA3__USDHC1_DATA3
> 	0x13fe
> +			MX93_PAD_SD1_DATA4__USDHC1_DATA4
> 	0x13fe
> +			MX93_PAD_SD1_DATA5__USDHC1_DATA5
> 	0x13fe
> +			MX93_PAD_SD1_DATA6__USDHC1_DATA6
> 	0x13fe
> +			MX93_PAD_SD1_DATA7__USDHC1_DATA7
> 	0x13fe
> +			MX93_PAD_SD1_STROBE__USDHC1_STROBE
> 	0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD2_CLK__USDHC2_CLK
> 	0x170e
> +			MX93_PAD_SD2_CMD__USDHC2_CMD
> 	0x130e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 	0x130e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 0x130e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 0x130e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 0x130e
> +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT
> 	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins =3D <
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00
> 	0x31e
> +		>;
> +	};
> +};
> --
> 2.34.1
>=20


