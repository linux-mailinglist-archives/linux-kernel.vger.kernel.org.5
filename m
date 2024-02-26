Return-Path: <linux-kernel+bounces-81462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD467867641
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F14B285D17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C218A127B6E;
	Mon, 26 Feb 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YK2qmOxs"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B1126F3B;
	Mon, 26 Feb 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953418; cv=fail; b=q6d9D8vCZVe8TwYV4LMbeLY0lwqIxbwhuyQf7Zd2cvHckpaROQ8hW/j1poHBrW3xM4Mwz5RlSzh+0IsORYjKhNyVd8wkyw+CDUvdfd9eonVGD1fekzjiRtfMm7Ljyq7tVky2y7c6vXVzPVDGduyaX3i9/NsyZRrzQMujkgWly48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953418; c=relaxed/simple;
	bh=0eueMde/W1cyk8U1v+I8peWLwZtQwmCJXcGq5XGMysE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BqYfvwbzX2aK95cMMS2jLrvNgTPiBU4H7luGG/ZAeQ9SAIGG6Z2WfHpQGGxM8HAoizHHDTF6sn+Dt8hfIYlSmWX5v7bE0Ot+7ov6sbfeM3yGOHEKcRLFDpXJDAqDz8k6hWd3Aazj4+4iieDY+68UtwIp7Yr/cjVXpziDJ9PYuuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YK2qmOxs; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYo5Z72KEaCrMHVjYDjy69JsHoSCL/37EM70o3YGfBP43kR1MSRFDMv7wClBU8KIAvS+1kVFneV78s4EbuzwehUVIIInq5dB7cvJY0sh4UIynaHDKED4LoC/AhRoEntLnYYnoUxNR/HPFII3UKfUzYqmoJ8X93HtRc0SSchJu/97eoNf4nZMbRtGr3x1tH6+Dv7BzT6RNbx765QX542YlwvKBnTGkYI0k1xBoGGwgVz3P1Z1QDOu/aiqi2j85dtbNkFD6W0sHA4HllwU6FKJn22P8GEhfjBQDpZsoIf0dN07GB2AKB9ROkZLDaZxDyvgTAGoa1sYR9RuloPZ6xbX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWstsyFH8W/9+XrowUa+UBkmBBry6TMUIchylS8LE9E=;
 b=mYm6f7OCK6QHZESNDBR7nXY4ASpmO0a0i+pz55403d9FY/nLVzK3qlBSpSlhk7Q3ALTKYlIt/Iz8kplde7/Xk4oV9aVrSvWyY0B14134SjwIwR81qlVWcvzRHSoMNAvcWTOdPWMGhD7SiUL5es830TFP1n/qI3Oymg87hI+SUuHaRCpmOVbDL8HEUe4FpAQqNXYE89HHwoV8wCggB6igQTCqhEmu5QXnUU+C3ICED/j+ooiZQcuZPjaANR1+pjSXicruHmxWRsb4T7eQJpj9xXcTCvtp+wXyzBVYovBfQmFp//jlp9GPl4bwuoeBXx1lpFtPql5bmP9IrUuVMysX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWstsyFH8W/9+XrowUa+UBkmBBry6TMUIchylS8LE9E=;
 b=YK2qmOxs4Vo+zVXUsaqhZLlhY9V9rPX+heHaLiyNp4svPXpm7UHwGZ3lQZNM/x2I6khkG+EsH9Lxai7LF6VPLvp4Z5lP30NJE8Zo9WXfLxObcrs1565SKm9uHmlQSt0Nm34VGsMZGvuG3322ChK4nptqmzn+qncSJKC8aLXOj14=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 13:16:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:16:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Nitin Garg
	<nitin.garg_3@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
Thread-Topic: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
Thread-Index: AQHaZicCkH+tvBnis0Gt2w9aePsLUbEcn84w
Date: Mon, 26 Feb 2024 13:16:51 +0000
Message-ID:
 <DU0PR04MB94172086AB4EF0389B78CA6A885A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240223071557.2681316-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240223071557.2681316-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8405:EE_
x-ms-office365-filtering-correlation-id: 446cf428-be6b-4836-8465-08dc36cd3224
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wK0FrWpRATn4+vpgziAbx6xnDwTZVHJGAD0hT4Hkg1Atfzch5Jq7jMYiyXwxhFR/c4sRI7IC1cjKTpFsHdpCdXfZTImo01R8ZGkzViBYwsKiTEnpt3y+WlNL2p4HkPuMnO4qibtFzkQZ2IlnMsOpwW3L/DkGVVihhSU21OXcw0nR/vHz7h30LNsehLXK3/cD+heLX4Hdlg+7i9cYNHIGJHYs9nZCRpdNKToPqGDyOHm5sDWxMCJDGzo8vN+eTOtLppLgs+vxBoLKNj6vmRrTsjETn57roMD6FGYoYd4hPmVklHi8H6bqi9kUc/KdI8szBTTT7aZqYYQH7jtywaakC4bSsyM/wJkMJxxA+bO4yMHqxewWSJ3LBIrm8rSprXuH6tpNZ3RWHkVW1nwocwpMlHJdR9xCQvCekaC+yi0MU/Ufi9eQ7+xRKMD/nOR7fjaixr6rPgvu/teT78expHXlKTnYg+FdiWLHf8F/0VV6vJ54rks71akZT9IqW9rFsamexUPAuE63XzL8lZCb+OIZkkNtygxdy4VrfLGnQwvbhXBF9GqQHVzBBDON5xVwdGZIuLHf15w70BQiw2JR7SpAu+EaeGFr5T6nJ81ycNsOylhvVfTkeTjJKA3iQNsRUUMH37V73aKzLp7TfOLRwz+YlPujU01sX7ICchtGodZFLbGg4x06L4K7Wf3yzz1v/KGrZNoZtrO5R/3gGkkM268AZg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yg13sSSeA8tKzX5VRkGNOt+ZoAbrIBzZq19Fw1L6JfzuD46zEcXwEwOP+ciC?=
 =?us-ascii?Q?SuRtbLxwTKYAyEynWnUCcQ/u7TmqzGIqVTtf+zietdbh23Gp5ZQnoYBdurDC?=
 =?us-ascii?Q?53zn1FGu6czGU+fCigQ0hArJ+0yVOx6hI/XN/Ns6TUtpizYovOSgJ4KLl+PR?=
 =?us-ascii?Q?PIVfGe1s9Fr3euP/PJ6t2C2exHGJmsWqPQ4/Iw2RGpOuPCuGIRodgsNetk1C?=
 =?us-ascii?Q?pWyAsj9aW19wzI3TFuqYPnHlUY0tEzvkm+2U6D97pqzgE+lnBOh4mun2jfOx?=
 =?us-ascii?Q?po8piOXWQ7HslfNzMpHDacPAjDOeZ+Bw2YuSI6+SzhUcrugnWGEtJsgiz2gP?=
 =?us-ascii?Q?K6e1uLHmFU52g2g0GZiIfUo7dhK2louZ7YPU7spQGiq9dBhAPOfOx6g6HD57?=
 =?us-ascii?Q?VpKklw4ZeSrIfEV/pUbxR9gTFWM5eT5wK19dWwQxf7ATjSurPo+cfPoc9jfn?=
 =?us-ascii?Q?Jt9s3FAfrO4cq6EpD3Y1xkIkUng6jBhCdVCzjW728kVfKa5FnfoWdqiRI5kY?=
 =?us-ascii?Q?STpfIksAbzPGIOXtUvBmS9PXlgNKmMVely0o+PLoxOPXkl7gLB7O+GO5BLJX?=
 =?us-ascii?Q?sMD4Pr534GqkdfL2ZXDR3f7D6cYFQVSeDuJZq0AimlJaKX/AoOq3msuZpuz9?=
 =?us-ascii?Q?k0sOGCQ+9ZsU6MTCMrsVA9H0k1rfc+UhwtBymvh7x17KiKarp2mRmCPSmo1V?=
 =?us-ascii?Q?RYI9cE3URkC7MrxIx6zBngD0wYbZ1Mnv7409DS97LZXUplhPY54YKpQo/pnF?=
 =?us-ascii?Q?bH7obaUH7PoD9Te1hWcFznZ/tfi9N2BTGjwMoSZz5HbjykktDUMVRBfz/3/h?=
 =?us-ascii?Q?da3lwEaFK/bBWWPZbZBotDBxSuk3psXXBTaqfdS7gQjrmnNY1gWzBiHTu5oX?=
 =?us-ascii?Q?L9lmt0RA4e8I8eDJYsu8+VZLW2+2ZfGKn+ocmZt/XM1JZyqcCqTlNBkuQZyF?=
 =?us-ascii?Q?8YgfVqMigq4hJOIT4Kah1hUh5lQdyeYnMKfWVBwPKvgww8VZ9AytVbLUaMsW?=
 =?us-ascii?Q?5av8p1GL65sRqLl8FGsuEH3LeOI1YRp2mm71wIsoG2wwfm4rEC9/8sKLFsAu?=
 =?us-ascii?Q?VZsYD9s+QzsADnxOZ2WxrjrbmvU8qPbIDVSntReT5910NgwEe0gqBDtURA/F?=
 =?us-ascii?Q?Vp93P4boYudZdCIMRxMoizA/hPB0KrnrshdZJ96w1ywadDeFLcjhtvQ6xlAh?=
 =?us-ascii?Q?v0LgvRQTBP1P9v1MufLEfxu+8KN8U6E42q0llLgreVh/aSedYCDbOU4+m5w6?=
 =?us-ascii?Q?Wcl1Nq8ZCJMqIi53T6BY4dWHYh1JsNCHcmtO609z3yZv6wXyUgy2yrVxp34q?=
 =?us-ascii?Q?LjEUdzG6zFlxIYFDnGQXfHU1JwXq9ivdzMj05cOyip7NtNzSRj1LCCyKL1ho?=
 =?us-ascii?Q?k9pngMaL36E0LB4MGYmLibQV74RBNCKqkWJXwzPbUSftTWUlC09hGPYRTQ9g?=
 =?us-ascii?Q?8lz7Ua5LbUeYv0sUPGIlBraRuvHsNPrrZXsnXyNCkUJaQCx16SFbd18oa8fO?=
 =?us-ascii?Q?Iw07p9yx1go+k5MaQck89jw86lF/OOEaRGHjbX0KZ3GniesaraYGp4WJWqlU?=
 =?us-ascii?Q?ET3jyc/nHkTky9iQAHw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 446cf428-be6b-4836-8465-08dc36cd3224
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 13:16:51.6915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+mDW1FZGHu5EC8ClyuRefjk+Q0vUuMX9q5g5VDklIcgZIIuA46IVaHdB8NApeMYZWLsisdAOsmB1/uygGUj5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405

Hi Linus, Sudeep, Cristian,

> Subject: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type

Sorry to ping early, but this impacts the design and i.MX95 SoC upstream(
although I removed pinctrl to let uboot init pinmux as of now), so I would
like see whether are you ok with the approach or not. This is the best as
of now I could think out to not adding more size to firmware and make the
dts format similar as previous i.MX.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses OEM
> Pin Configuration type, so extend the driver to support custom params.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V1:
>  Based on https://lore.kernel.org/all/20240223-pinctrl-scmi-v4-0-
> 10eb5a379274@nxp.com/
>  This is an reimplementation for supporting i.MX95 OEM settings.
>  With this patch, the dts will be like:
>=20
> +#define IMX95_PAD_SD1_CLK__USDHC1_CLK(val)	\
> +	sd1clk {				\
> +		pins =3D "sd1clk";		\
> +		imx,func-id =3D <0>;		\
> +		imx,pin-conf =3D <val>;		\
> +	}
>   ....
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		IMX95_PAD_SD1_CLK__USDHC1_CLK(0x158e);
> +		IMX95_PAD_SD1_CMD__USDHC1_CMD(0x138e);
>  ....
> +	};
>=20
>  drivers/pinctrl/pinctrl-scmi.c | 10 ++++++++++  drivers/pinctrl/pinctrl-=
scmi.h
> | 15 +++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-scmi.h
>=20
> diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scm=
i.c index
> f2fef3fb85ae..e58f1aaf9963 100644
> --- a/drivers/pinctrl/pinctrl-scmi.c
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -19,6 +19,7 @@
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
>=20
> +#include "pinctrl-scmi.h"
>  #include "pinctrl-utils.h"
>  #include "core.h"
>  #include "pinconf.h"
> @@ -472,6 +473,13 @@ static const struct pinconf_ops
> pinctrl_scmi_pinconf_ops =3D {
>  	.pin_config_config_dbg_show =3D pinconf_generic_dump_config,  };
>=20
> +static const struct pinconf_generic_params pinctrl_scmi_oem_dt_params[] =
=3D
> {
> +	{"imx,func-id", IMX_SCMI_PIN_MUX, -1},
> +	{"imx,daisy-id", IMX_SCMI_PIN_DAISY_ID, -1},
> +	{"imx,daisy-conf", IMX_SCMI_PIN_DAISY_CFG, -1},
> +	{"imx,pin-conf", IMX_SCMI_PIN_CONF, -1}, };
> +
>  static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
>  				 unsigned int *nr_pins,
>  				 const struct pinctrl_pin_desc **pins) @@ -
> 548,6 +556,8 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
>  	pmx->pctl_desc.pctlops =3D &pinctrl_scmi_pinctrl_ops;
>  	pmx->pctl_desc.pmxops =3D &pinctrl_scmi_pinmux_ops;
>  	pmx->pctl_desc.confops =3D &pinctrl_scmi_pinconf_ops;
> +	pmx->pctl_desc.custom_params =3D pinctrl_scmi_oem_dt_params;
> +	pmx->pctl_desc.num_custom_params =3D
> +ARRAY_SIZE(pinctrl_scmi_oem_dt_params);
>=20
>  	ret =3D pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
>  				    &pmx->pctl_desc.pins);
> diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scm=
i.h new
> file mode 100644 index 000000000000..fcc61bc19c98
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-scmi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef __DRIVERS_PINCTRL_SCMI_H
> +#define __DRIVERS_PINCTRL_SCMI_H
> +
> +/* OEM VENDOR Pin Configuration Type */
> +#define IMX_SCMI_PIN_MUX	192
> +#define IMX_SCMI_PIN_CONF	193
> +#define IMX_SCMI_PIN_DAISY_ID	194
> +#define IMX_SCMI_PIN_DAISY_CFG	195
> +
> +#endif /* __DRIVERS_PINCTRL_SCMI_H */
> --
> 2.37.1


