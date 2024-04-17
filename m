Return-Path: <linux-kernel+bounces-148466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B17D8A82F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F35283A83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68013D260;
	Wed, 17 Apr 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FHDHk7nr"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE813D265;
	Wed, 17 Apr 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356164; cv=fail; b=oRtwMErkGRlxRBMYQ9uQatptcf3b/7IOq8vWYeoDxSef5BzT3c/D2hXZWyw072Hm/I3bKq5NFJ7FCl41f4+fpx9jwCo1YoTrst5YOFxrEUlUDnTwATgzQ8k3wC2RJo/AA7pYvZ/8v+pSDTYamNbML8mXnYwg03GcI0nlezPWFb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356164; c=relaxed/simple;
	bh=Dudj6X1fFg/euOFDnBrDEQLJPYVa/bBFo/YkyLPuQSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WBCjB+sGxKOLuzoLXckxG1+e+bOEW/G3syxd1vQknLvXdYARMRj1zAyfDbOWSYePh5vb9opO/y+Tpz88Oi0sHohGOe87BtyVGfLlYQ0wIKfE2G06wYOIKPgEhdRw6vAobdNoDeD6rEzT3w9z91Wmk48Jxb7jkx+dF8JCG+Gn/VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FHDHk7nr; arc=fail smtp.client-ip=40.107.13.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNSwXHAjZlNN7y1LJQs9WWFnQpcoPnBb5xumLwBlIYrwrkIyfc2baEkCoYw4TW2VJG9LLH9DvK2OE5P9jiGiyX9pBiVa3bX5jrmNJlRhIkhkOLFEjgLUmW/HVfhVsGVRQtJp6lxyyswfT0IP8fTPhcWXYSLdO6Ufa0wfo30TvkRvxY3aNSIAvYoqjC45imvOcq3PkW7DbCZrsNKy4baIUyByjDVtMhkG5qObGolnBAk5lrA3s8r3nxFp/c/6+flikQ5CXbDopt+dbGi7oS4IQBGvgeUVw7Syu3psUmZ0XU4zQmWwsBHLnNxwFGak4gLq5/r4QB7+/enNmWOW9vQFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqnUi3So4h7wNlu6U+OhyqfqIMWKGurdVXS/PzRXS9E=;
 b=k73v5yk7doMK7nZ34ArFK5r3v1nl5wv//6umQQEjX1RXEkVW7o7Y+fV7EtPWG8EOQFDd422Ey6EuvHwoHpj9BoOpXx8sEM+CG+ypLGs44ZhI5iZxm4rY54zE6czMDFw4bhU0f0BuyMh/KKF2ccaB2EbSv5GbnbOs8r/Gih8e5Zc4YyT5QDFvP9kFfnz/ocwbPQ1dDvslJLLWXatNqfaDXE52PbzrEtkxfGT6z/SmS1n8wZePae7eT7p76FEoV3/Szkeg5WiE2gtTd6q2gijxFZBxgfqy+9mFsBwcthK6nLeTtPiSEClxD77b1TR93ISGPt3De8nVabn93DyyEQ+vKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqnUi3So4h7wNlu6U+OhyqfqIMWKGurdVXS/PzRXS9E=;
 b=FHDHk7nrhP9+/B4FqmMZcZqngDzA43U+NBBayF7AnWGwNHo+Y5zAt/MVpoemk9EZZNl0hJ0G57D/Ho3Mqe61orvoXon6CZ5ICZxT3tkQOPaq+wWORj5KAjw+v7UtzFq13B9O3fNawu7k58adw9a7DGenD1v5GuQFYRKpWO2mKG8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9773.eurprd04.prod.outlook.com (2603:10a6:10:4ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 12:15:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 12:15:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Cristian Marussi <cristian.marussi@arm.com>, Linus
 Walleij <linus.walleij@linaro.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v10 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v10 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHajxDlnYbGicEx0kmgH54RWsBtKLFrN06AgAErjYA=
Date: Wed, 17 Apr 2024 12:15:57 +0000
Message-ID:
 <DU0PR04MB941737BD9ACF18526D8A50C7880F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
 <6c652af8-151e-4d8b-9587-8eae1254a4fe@moroto.mountain>
In-Reply-To: <6c652af8-151e-4d8b-9587-8eae1254a4fe@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9773:EE_
x-ms-office365-filtering-correlation-id: 4e6b2793-3aea-47f8-0489-08dc5ed8231a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MCgszVmteO+L2Lg3eXSVy8zO9EAGWS7vm5wu67R/xXaJO2ShR+dKfwh4qUk8yV/RT+fOai5frTXy7rN8t+2/7xS+HEvA7O035G6Nz7mKmZvVfDKbQwiY9jg9nr/YqMfCYaJpL2b4g2I56LfiWiYSmICGjLHUn0wkTh+AlFdVAtp93JXPkNiPG4l8zeUfAr60zmyAJWzlhLyhcXoOO6CCooaOB5AQkfWYMi8spKIVmt5fYZ+cP9bEm6LNc2AIOCP/Ks3VvIkjC2p47BSayBU9oUYvn/+h4EraGYC+CiwIzvY0bpwOs1aw9FDQoBH6Sp5C3CWpk/MIHK6AnEAYKlKIPeqAMldUbL/GN2rCfnJKjgorPcgacJkWWrzX1dS8GfHakEwwJFSELqTGBj7e+JPYrmwnojM0ufN8ZRObO5J+Ox0mSUR3KpfPrIX0xy27P41d1WUlYoif9JyH+R2whVoNaYInesipVqcWg70UXvPYGnSbjDKPdUNvv9kK4qhi/KLIROVUrQBCOoTfic1hJ6QKhwexjfP1Q2x0agn36sgzEbOYFWxOp+IZuB5MLrp2V661qeIsDWj2xAZjZ0jJbvDOpMKSqkF7MmUG2lZ1c7W8stqXb+vufQWqiVDVpv9dMF/vzbnOkhFZgJUUlGkzs/TMOJJaHaSjDkD4YNmQ+FmXTIk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7+6TBeo2jRam/X2nbTp10iXWibRkr9dK12KMuFUJCZYUx2Bp6D3jsZC/lMes?=
 =?us-ascii?Q?EHSCQwmfOEKupnhAXDAPE+h87BXYD/ggw8pgFESJsTfFz/ueYUahN7YNIMlk?=
 =?us-ascii?Q?qunBpRm/9ESVDn71jvoYQSEz5Skw36ZNyKtRHJQWy0MMMpdB/MuQk7E5NvXh?=
 =?us-ascii?Q?b18Fy0UlSszHPcQExMegcsHnOR5PSBCPNqBiruc9j3QjBVD/anTDMBl4BFUv?=
 =?us-ascii?Q?dOFmrPODHBgY9937/Q4r/aTdh97t/lDdxYVvpPoFKqSf+TKJRyRZv7eYSzMV?=
 =?us-ascii?Q?oTJxb4BiRcQ9Vm4qvRA5mg9rq+zJ5bzkplG5nnsRRqSgHLxcyholC32xQuJO?=
 =?us-ascii?Q?pb1aLOFUgC/yMD2Dc9KhFoTby0G88zjaW1nUEoSYH888z4nxprtTEqmG+g+G?=
 =?us-ascii?Q?uHTZkBOiHWuTRX3rKx2ZuWV1/lZvT1E2nNmFbB9zL/U0hSrNNY+Zc1PQ2rU4?=
 =?us-ascii?Q?S3umOF60TZ1od3Lr69S4ag8xbxWlas7gXmhyYTSaxfBnZQZyuMv3QL6UzH9K?=
 =?us-ascii?Q?jYq8AsccxlHiZOZ/EZWlkd3djnDCijaCGh/b2WKpIhPUon8OKK+FAXE2ofwF?=
 =?us-ascii?Q?w2xT6p4M/r5eQUWrrHWeLY0qu/CuVMxAPd55YAnZp6zu0ipabxHE8BhfoHeT?=
 =?us-ascii?Q?6qrrI2oTFZsl8O4dSYhOqJ2zfycIlUgUQxqdM9iKEbDzzZCA4jVbCfVrhAiH?=
 =?us-ascii?Q?7l6Ya2ElJwfX3gd31r5J5XZ784T7fBS+j9XWhydc0H3oioTNNT/fxrj6Xzxm?=
 =?us-ascii?Q?4jdKkS9KXD9ipT412W/nkEe2vhGPwMSQsz9TTJD6EgM1LIhNOv4dIpQUrfIg?=
 =?us-ascii?Q?1dkeEJpemGblUNzOuluFn2BezAH9UeQ3If+yXAahc7zDoF/3caHoGil2oDer?=
 =?us-ascii?Q?oCZWxpSGvwv4bcmXmSatg5NkP256vnm0T0tWNt4AefV58orELBgsoi0dGuvk?=
 =?us-ascii?Q?rgzycuv24lGqmcG6Kht/+HhJnnTCQyg1VvsZ0Sudh83w+Ylyudt0k1yDAG75?=
 =?us-ascii?Q?EtDyDlUXSgAnA9JpNiC3TBqRM1SYXFnmDGRURA1fPd6T5tv7O4/+0arB+YsQ?=
 =?us-ascii?Q?Wtrcb5YyBhsOJxYtrUFAbJzK1RZB0IV+eRguj26OFDp7jkgRN7ZQvgLEAUUk?=
 =?us-ascii?Q?cYWHujGHKcHNjAP73mPr7BkrVjEjC3nbDvCDDNCVdPBm+6edFTNxwkMsYQJ7?=
 =?us-ascii?Q?SoDlkegRTjle3KjvcdHFCu1pw3d2QzJRiVAuVnZTfuNF7n/8zfx0NOfcNOnI?=
 =?us-ascii?Q?Jxs4ya/R9CambUwgvcopKdO84xPBgmuuGfWpuf5oLcHoZ8XNQSPHV7/yUPMx?=
 =?us-ascii?Q?j1xJokKd7EWeJPuWprJ3bbNCCMy0iwIbTGRJ8Ar9RamFDdMTfaaAG+x/f6cn?=
 =?us-ascii?Q?3eoCST2by/kv3VGZZGLBktLghr+c6DiJ9r6uGCyP6YsItB/1/UTInOUS3mJY?=
 =?us-ascii?Q?HFgVtPEBPNMVZI0OUa7E/YiQW5xFiTAMbXkKLL/O8yTRyWsdWwq1bfQc6YpE?=
 =?us-ascii?Q?veS4U5TcFH8xTjmJvo2qxH0WmeoGooOlWrQ3VFxZbecMyLCT0+rvbO8ZUf/u?=
 =?us-ascii?Q?PFgZzs0OAfzCmVBUq44=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6b2793-3aea-47f8-0489-08dc5ed8231a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 12:15:57.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZx7KkcTqSHJ37ZHSwwtTzm6JDnrCrCtVCd/fP1atUhbBcI+lA9nef0Tfuqk5cPD26oQMletCCPVhxalC4pNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9773

Hi Dan,

> Subject: Re: [PATCH v10 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>
> I'm trying to re-base AKASHI Takahiro's gpio driver on top of your scmi p=
inctrl
> driver.
> https://lore.ke/
> rnel.org%2Fall%2F20231005025843.508689-1-
> takahiro.akashi%40linaro.org%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%
> 7C342dd6eb0463456d0d6608dc5e41de1c%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638488884186606528%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C0%7C%7C%7C&sdata=3DDMJZ2uwuJigkEnEcY7JdBw6DMPjHxcUvvh7
> 2fsaep50%3D&reserved=3D0
> I need to do something like this below to save the gpio information.
>
> So now, great, I have the information but I'm not sure how to export it f=
rom
> the scmi pinctrl driver to the gpio driver...  (This is a probably a stup=
id
> question but I am real newbie with regards to gpio).
>
> The other thing is that the SCMI spec says:
>
>     4.11.2.7
>     PINCTRL_SETTINGS_GET
>
>     This command can be used by an agent to get the pin or group
>     configuration, and the function selected to be enabled. It can also
>     be used to read the value of a pin when it is set to GPIO mode.
>
> What does that mean?  Is that right, or is it something left over from a
> previous revision of the spec.
>
> regards,
> dan carpenter
>
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c
> b/drivers/firmware/arm_scmi/pinctrl.c

Just a short question, you will make this a standalone
patch part of your gpio pinctrl patchset, right?

Or you wanna include this change in my v11 patch?

I hope v11 + imx oem patches could land in 6.10,
so I would not expect big changes to v11.

Thanks,
Peng.

> index a2a7f880d6a3..f803be8a223f 100644
> --- a/drivers/firmware/arm_scmi/pinctrl.c
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -26,6 +26,7 @@
>  #define GET_PINS_NR(x)               le32_get_bits((x), GENMASK(15, 0))
>  #define GET_FUNCTIONS_NR(x)  le32_get_bits((x), GENMASK(15, 0))
>
> +#define IS_GPIO_FUNC(x)              le32_get_bits((x), BIT(17))
>  #define EXT_NAME_FLAG(x)     le32_get_bits((x), BIT(31))
>  #define NUM_ELEMS(x)         le32_get_bits((x), GENMASK(15, 0))
>
> @@ -107,6 +108,7 @@ struct scmi_group_info {  struct scmi_function_info {
>       char name[SCMI_MAX_STR_SIZE];
>       bool present;
> +     bool gpio;
>       u32 *groups;
>       u32 nr_groups;
>  };
> @@ -189,7 +191,7 @@ static int scmi_pinctrl_validate_id(const struct
> scmi_protocol_handle *ph,
>
>  static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph=
,
>                                  enum scmi_pinctrl_selector_type type,
> -                                u32 selector, char *name,
> +                                u32 selector, char *name, bool *gpio,
>                                  u32 *n_elems)
>  {
>       int ret;
> @@ -216,17 +218,20 @@ static int scmi_pinctrl_attributes(const struct
> scmi_protocol_handle *ph,
>       tx->flags =3D cpu_to_le32(type);
>
>       ret =3D ph->xops->do_xfer(ph, t);
> -     if (!ret) {
> -             if (n_elems)
> -                     *n_elems =3D NUM_ELEMS(rx->attributes);
> +     if (ret)
> +             goto xfer_put;
>
> -             strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> +     if (n_elems)
> +             *n_elems =3D NUM_ELEMS(rx->attributes);
>
> -             ext_name_flag =3D !!EXT_NAME_FLAG(rx->attributes);
> -     }
> +     if (type =3D=3D FUNCTION_TYPE && gpio)
> +             *gpio =3D !!IS_GPIO_FUNC(rx->attributes);
>
> -     ph->xops->xfer_put(ph, t);
> +     strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> +     ext_name_flag =3D !!EXT_NAME_FLAG(rx->attributes);
>
> +xfer_put:
> +     ph->xops->xfer_put(ph, t);
>       if (ret)
>               return ret;
>       /*
> @@ -602,7 +607,7 @@ static int scmi_pinctrl_get_group_info(const struct
> scmi_protocol_handle *ph,
>       int ret;
>
>       ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector, group-
> >name,
> -                                   &group->nr_pins);
> +                                   NULL, &group->nr_pins);
>       if (ret)
>               return ret;
>
> @@ -687,7 +692,7 @@ static int scmi_pinctrl_get_function_info(const struc=
t
> scmi_protocol_handle *ph,
>       int ret;
>
>       ret =3D scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector, func-
> >name,
> -                                   &func->nr_groups);
> +                                   &func->gpio, &func->nr_groups);
>       if (ret)
>               return ret;
>
> @@ -778,7 +783,8 @@ static int scmi_pinctrl_get_pin_info(const struct
> scmi_protocol_handle *ph,
>       if (!pin)
>               return -EINVAL;
>
> -     ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name,
> NULL);
> +     ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector, pin->name,
> NULL,
> +                                   NULL);
>       if (ret)
>               return ret;
>

