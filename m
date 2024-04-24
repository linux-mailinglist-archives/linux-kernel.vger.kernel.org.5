Return-Path: <linux-kernel+bounces-156737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4768B077A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79911C22169
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECD15957D;
	Wed, 24 Apr 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bVAFLW8Z"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041CE142E6D;
	Wed, 24 Apr 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955163; cv=fail; b=brrYsm8TnKwGPMXKut5aWX0VVFnVacVXAvLwGqup/9YfhH3WtW3jk7ZD+y2jKY5k5r40uyRN2/Y/o/ry6P42kjELAQFOtQzQKkd/yN7vB/XD5QzlvwInGVTob2QJx8qLnsdltydkF9x322Qthpi7d7Qne0UOLnXcEi2SwYRsPXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955163; c=relaxed/simple;
	bh=KbYYWHLYjlXwnWH/i4L5dNtLt7MdSNoA3AYr99a1zu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffeJ7mRkJ/TpxN8XfwZKvzD5k1W34BeO/CNd7nQAWANR+gy5TSdJxg8TjU6V866KrOic/aKc5Dy4EzSSESNE9FuZOPp+3ARESOsi9IGCn3BIUCZ3vfXDkuSc/VjDzCTdI6JAw4tFfKaNuaUA8Po/1IfwFO2ONGJzvJB8pzbmzuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bVAFLW8Z; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnMGRLQxyL8c/Goc7a5iLnfJ4e3A50VvB5reVdIXWYWxapWYEW/lkUgoGILKn2N/HYmAaezfLvain209NLFt3hzUyo+3GuRcP0Z/QKMD6fJTTBJklYvwHOBeRJHxLSWghlseh4x/HUL8Owa1DlgDC3tqz/FDEe2xB+RktZQBf4yfkc8YocvmivpUiP4CHvtKBUs5JDT0hUXYngLqJ+tFI8N4cRl4ZOv0TngY40+8Gl3/ovWMk2dybrsmj8gBmR6hF3/A9oVsJhoNZuLYLVl7xr6qxCxCjW2K4wAMBZZ3mxEs5NqQ+VUXYufzdhrJAAvXud2jdXvuVN/T21/SiItTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRIgpUayy+9y8+VOMRM0CXMYPOWG6j3dAzCCfD1xMDY=;
 b=mqaJ5Iu8C4idsQGNDjEWqf3SiDURnHH8/6TSEgm7RwyaCNmQxWha3p5xW4eq+f9YaJ3ClLBN88gExREGRfgQE+O2Zy9zaGjkLkOpCzvnX5n/cRL21NGxq/t1DMiRfRwtJbeoWZyQ6Y7Ep8Zw/f4TBDgzTcnADVt70nJZEkjJKY8CWtneTtZ4Z4qXBIQdEABiTa3VaD6UTySfQrLgrxr+hUboUlLjMfF933nAQMtntN6TZaVAZoV2rsmhsLw45/9cyLteurpfL18IrjN4vWEuf2eSUNCMZYPUvuo1je/cVEqnEOkWs1NnDDlARrg1OBaOUqXUgBy9//CKaC814lU6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRIgpUayy+9y8+VOMRM0CXMYPOWG6j3dAzCCfD1xMDY=;
 b=bVAFLW8ZTsm/LYd7AT1hEXDb9ckMMz/paEJVrv9VmqCsBYnU1ZTGt25Waeqrf9NprtKe1oe23NU55/2hmdBa4pLneNa6lnxYz4I/e2/sHZrMJlcmOvAv89Z/EDZwkeU6e56jUo2hGYyeorU9cmY47clLsLx2JmzLpslj9+qRLd0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7405.eurprd04.prod.outlook.com (2603:10a6:800:1a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 10:39:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 10:39:14 +0000
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
Thread-Index: AQHaliMGtjTu4L2HCUOD9XlB0g8kD7F3Oulg
Date: Wed, 24 Apr 2024 10:39:14 +0000
Message-ID:
 <DU0PR04MB9417979E692999E05E13959588102@DU0PR04MB9417.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: d4da32ff-d154-45b2-6f12-08dc644ac960
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tctyBQxhj0YJ5oy755kkTZGTDyf8Dp4km08N4kOLmevk5bUgVLj710M7vzVb?=
 =?us-ascii?Q?2oXBSEJOgG3mYDUyoJQVl/l+yrAmNTGuw/sSpWmNX6tq5/IX45Ku4QzJKXOV?=
 =?us-ascii?Q?44p2nH4pRgDAv9BP2BtrsaU7Pv8MgZjyrYS7hsREZF4y+dNXoG2a+FnU/DmV?=
 =?us-ascii?Q?g1Xn8hn38zWSMpgHcCj4cIjfrVP4x7P564fXY7jgDaNhwEYrIvXnqWK9kx9y?=
 =?us-ascii?Q?MU5OkC3WwT3ufcj8+ku7+HMNBYPteoNd80DNT/+SNo7LYSBkII4xlQoLjJgs?=
 =?us-ascii?Q?LmLTEsGxrGAdu3/62REsruiT8CRwAwYsWhE5lxZ+u5OuWHF3iCEOVkJo+5yP?=
 =?us-ascii?Q?EOo8qPeGdjNmO1CW34s7pXPWgbWb3AAqx6gAWfJyZGMS9NbSOdEMbC7k9A8D?=
 =?us-ascii?Q?rDxD/6ZEdzlquFk+a/gsR4vADCgh6xEUr1K6vzdDf0Rtcl4fXiK9Cf3mrw/M?=
 =?us-ascii?Q?rt5HTCcub6cYCLdIgG1IHkq4vqRntNWVN5lL/+eOaUD9rnJ66LDZZjDHlG5x?=
 =?us-ascii?Q?FMaffR5SP+Mgnf9NX7xeDtSmrPHsTX3f+ogNjojjc22W9uiM63GDe3vOumQs?=
 =?us-ascii?Q?UOgVcQTxYEjI3VvfQygwVmt1lrFCxjyJFoFJUX6Xvgf5ZggvOXFQllOzdTto?=
 =?us-ascii?Q?f/0rJyGuQOY+P/hD8PHy236XrqHPVBvDB5Myz2e7Qe2MTT28p3SXIOo5/odu?=
 =?us-ascii?Q?FHONrAA9P2QNby0R5RZS8MiDAquTeHuLjSWEHhdEDdce1FY0DOBd9F55v/2N?=
 =?us-ascii?Q?gIYVmAKYH3Rfe4N1EcUjmCXdwxKPX8Py3KDYfzKUClU+r+2b2po+kB9yOOsT?=
 =?us-ascii?Q?ns0jF6sfE5s756fHGMrVhiSfEhUlO+PM4yiPTFhzb8Mo68g6t+ypxJvRu0jk?=
 =?us-ascii?Q?Zp476jOkfKQeQbF7jjak9vrdB7GFp00xZEfNdWzpDFUl8s1EWu6z52q89aH8?=
 =?us-ascii?Q?mdn9bA2044s/gXKPZFuUsWtZjt4dmE1MfHclENh+HzgRPl5enEiEsJ9ztqi5?=
 =?us-ascii?Q?MCa5xDnU3tzkruN4GaJvjFw5PiBfao9IudKeje8VN9EpHyrQ5wtwaz7nQpFo?=
 =?us-ascii?Q?SGKL0QWJDuCc1rtI25LpifIdO8NnwPjnrk4QTr+HGczJhVKE4kJIVm2qNlB3?=
 =?us-ascii?Q?/yTQXkYL3ANmzZ3AcdakK8T2djBnTCb61CHpou0Dk+0v2aKRF+hXbQYF4/fs?=
 =?us-ascii?Q?irj6GUQL4J0oLxB5Bod2KLi+94/O3lrHgSOKRG9eV0FjmorKtWRpwH6/6SxG?=
 =?us-ascii?Q?zRiPOSHwKKBDfed7L7fbAXSiAQRkNPMHlLPUInKU15mjorie8xdezJXoZYq2?=
 =?us-ascii?Q?956vr7F3LDop73SHSyucIVpo5QsJYajdYIPVwyexutSvxw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8bLEeZ3G/nAq/KAfZ6dXUKiDezXICB2xEBgDw0SAOE01a1e9hxL6S+2nKrVw?=
 =?us-ascii?Q?P4hMhovLtDON/QTeSPTppNgxRd2IvSgnZ+fZGVVA8fZTWj/9PQJyNmHr5Wux?=
 =?us-ascii?Q?qPb9a0bnqQSvwZYS/Dt9uPMCxqcRU8yg9mWbfKeYljvpknZnWs5FSpI/1Fhm?=
 =?us-ascii?Q?xIvVIr2+jSeNJDp6MKW9sTHPTv2aEkUtaGh0FWEz9DmmVEgBEZ74PauaGrrh?=
 =?us-ascii?Q?TQeQCLF5LKFpmVaYiFcUxjqZGEvmgtlldQ7QyFfnclR+nO05RgPlCo6ZQC/n?=
 =?us-ascii?Q?P5BIBPI9HVGDBIS96zgZ6PrQpUFWsgzJ8yhWVhPrWFGpFV73dX12A8VhRdjR?=
 =?us-ascii?Q?sGyoLxPE+pIxfaGtLmSYT7RiJfTbJtLTo/PFpdxj4tzBy3Y8MyQX7hT0/2IK?=
 =?us-ascii?Q?E0xTJpTl1yPCEOdpLHKdc2KXoA0nMndlcKg/YFcfyKvo9q3UlXEKn5z7oLze?=
 =?us-ascii?Q?t+ZZ3KAb8zAdPqs6JXhfnPLYXsKX3Y9P3+1RFEVVETq0rOar5asG8A5QqGPO?=
 =?us-ascii?Q?Q8rerk7bT9pOJi2sm3IxOzuNFg8be70tM/gN30MKypS56IxqbjU3f61H15Fp?=
 =?us-ascii?Q?5eyPm9XC8p+m8p9e4niuyJLDihZHGUbRZAh8rRVIBt2boh1jf/7V217TK9y8?=
 =?us-ascii?Q?84h/rpiCHuLerXj0aXmGV5F9cVw9n1BWcF9EDXB4g3YwJ1YAO7sxb9KkduA2?=
 =?us-ascii?Q?OoZA7pFmi/ORQFj350+NYwdoMsWxCPosjJSoYix31aOw+hG4KPTAyxkzERFi?=
 =?us-ascii?Q?QAQwLIIFMZ+YvPHAhxOdxaXB9guEl/Q/wx4SHKWEj4KYUJM7bOLwXYrdK5q7?=
 =?us-ascii?Q?6epVzg1AkhjKSG75fv4rfuu364dwopFa0tlbwnwAATvRlQFnyOV3c2fMKb17?=
 =?us-ascii?Q?SXonIj9FVbu5hYKWobCfTNYxIKCT0kSLTQFPyQAp1Jkv095N4pVw8PWUgkQP?=
 =?us-ascii?Q?Z3z9zc99l8JZutqtU5df1VpSNqmeBjIYcgO1bDCN80ak2A5sE0VPWo4TRiez?=
 =?us-ascii?Q?zm+/e0xRqKl7pCT+yA0k5k+NmPwMganHJDZcE2qjzez5d8k0G5RGNUmALIyC?=
 =?us-ascii?Q?fCJR4aUNBMTcNikIfxBDFoJtxTOCgFak8F3MXhp7iURkcWcBOH3+z5+gDlXT?=
 =?us-ascii?Q?UKdhziMRnPB9ELohR01HwjRAgyfHoRZZHFJOe6+9swtj/T75mLs9UXHEDgoh?=
 =?us-ascii?Q?A7WYDnRZZd2T8GPQQwC6y5gs602b1Kwe1W1S5Sr4JXhnbs1A8Xnt8Vd28kA9?=
 =?us-ascii?Q?3nBzKwEsWbeN6Y/NzuZoHkymWFAEONVHVq8NHBRaZf0C9BopuhPNelJounnn?=
 =?us-ascii?Q?j2SCUy0e88L3FVuJfdZYF6ONJ1Qa01Tb5Z8B5tALyaoj2VEeKbIpKvZsuMXm?=
 =?us-ascii?Q?eYWITH1aDQtXMyyCcfORK9Obnl1ewTGgjYovxq87fhMAByBhRWdkMkS0rdeH?=
 =?us-ascii?Q?crYUMrvjo2kNjhz3UKTgOXEnE0q6QtLU7hlMYbQHX8EDmwe7xlAYb6miiozd?=
 =?us-ascii?Q?NtT3oaAZpv0/ueb/iCX/RQ6PQVFkHwtUDPdLRGHes7nsEDjS/vavKo5nZ/4u?=
 =?us-ascii?Q?51kd/ktsPB4rcpuL1iU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4da32ff-d154-45b2-6f12-08dc644ac960
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 10:39:14.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtMduKY/8YfX0pDxHglax0cVp0+0IEstBk+uWBRQIY/wlLWEv73Nm3zbKtEfmLpJ6Ch66cl7USw8wPILWogX7g==
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


