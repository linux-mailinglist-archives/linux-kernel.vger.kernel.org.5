Return-Path: <linux-kernel+bounces-38484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA183C086
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1107B1F22C65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997B50A83;
	Thu, 25 Jan 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h7CvLe4u"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA12C695;
	Thu, 25 Jan 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180840; cv=fail; b=o6Hs0MQI1hAEbb1GfmQOy4ZkSM8LbyCAS7MMOk+y5dmNF02ABYkjryktnABmItQZGypdY4jg9nUsYLu/rpfKEaYJ8Wdg2mnHsvem0q/dU6lWq+1jQ/RmQvKb+MCFtK+wb6o8mEWqsDLD+IxquLAKuELrA+PcHJb2O56iwNBq000=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180840; c=relaxed/simple;
	bh=/a7tl11lGLzsfkepXMU4QKz3kbtbkNpTStV2chIXSkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+ZKnGQEFUpmx3ajNVR9UzFgXe8VVcXrrbiM8f90Q+O3NjNTTB4GkdmgYqq6PzD9oVdkACWwSSRw5MAMqgcIhWeiu6m4rVuBWXEiU2WXuoxulUCabY56QeFowQ/zCeGHr0Op6P0DlXkN4u9A61nkG0kqXi3PTEPPVZ/a24hEL10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h7CvLe4u; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neiCOcmdw/rl1nImqMtTtgOMNf5TBpXLiy1vab/7pBaUvpOfb8gPXVQM9LhTnTbLeBDvcmND3fCA9wTr55s8qEuBZJITcmp6+K6GfUntINBXDLMETPlO4g1f6krbF95mvemJAZKm4yvudJeqtBMPmTvIpFKJ+zvac/UdM4EznoqyG6QsLIKt9gsxlEYkEORyYDL+DmxbYutajI15/6HRg2+EQmNVJz7+r5ISiEeq0ps7p5ZA6ZZQFZ7sNS2yulxJ8/9hXNQpqhbh+eNWs7vrW5MRTqJMDpM4OKNtCbIfWALqQAgmje7031spOl6x6cZ0Zv7tASMXO5kxZskJfRb2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG5ejSGDUDStd77NpvYw8xOcyCAeXb9Of0pKEmV/kJ4=;
 b=MFRdPwerAdDanmV39ECxp9U7BRWzjfOYMFSpGb2+dLGDP+0ajeTy38ZuktGxv7CmSkc1rO2qLCKvIsbRb6qYAPgpHp6P5e7CJOrlOLF1qFnilRq3Lc8JWdqilOdVzX8zT9LKkPCWjpwTgyQq7r0m/+eNloK4HVhg/B0O2dQxfz0j1kCR9w46WORgIb6EX61x0Dsh9KuqmABaeYl5V3sd31t+m9z93ZNXjGkU2+6H/dgyt+w79k12DA6i83ETbqHJyv2aj5aoWOjg4GlnAsx6jq2hgmRqoB05f9dAEbMj5rGTQWFjJUSLaaSLtLNnoJm+PhPDshGpatBizwWZpVYArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG5ejSGDUDStd77NpvYw8xOcyCAeXb9Of0pKEmV/kJ4=;
 b=h7CvLe4uOj33qaWORBhxSTQ8rN69zNCaBdGjQmpyauHFFfqJxnq1+F+8YNwA3K+ySYdzqu7c+eOXcRO4Ym8+/lt36L2l9W34bGWf72kpmtsQKVxekB5c9NtAcTgU1OWH9BZ8pT2ByDzoYbqkGT5lO8y7+jAkBd+8CmuJkm3mjhg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7710.eurprd04.prod.outlook.com (2603:10a6:102:e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 11:07:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:07:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Subject: RE: [PATCH] thermal/drivers/qoriq: fix getting tmu range
Thread-Topic: [PATCH] thermal/drivers/qoriq: fix getting tmu range
Thread-Index: AQHaAyyxm4iPh0Sv7U243t/NmfenWrDq9qpQ
Date: Thu, 25 Jan 2024 11:07:15 +0000
Message-ID:
 <DU0PR04MB9417004E7A877D306DD561A1887A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231020081337.3141488-1-peng.fan@oss.nxp.com>
In-Reply-To: <20231020081337.3141488-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7710:EE_
x-ms-office365-filtering-correlation-id: d2e1195d-a357-4464-22d2-08dc1d95ca2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ULz0BbY2JBynV5RozroQ5I4CjxymFOTTQCqhFf2XyMa4fQOSbfQCcdTxVcXi/cWcmjAmaJve45dpO2Nw891hzJ7rMML3Vt4DKzJFASOFltjcdDA0X1FdUcSCz2/iuxoisTY0moEiD5SB9z1jF2eRpOnv+D5W8idf36EmmtyssNzHgJjxy9tVByL6KdsHzTt6wN2bRsfLlDzaNSU9ZgVmcMF0HkhRVyhY3fcD/NJWodcoWkWxadj4L6Yua4eiDEu5Fi1qkvpudYkyq/auYpJRILS96VdroZyhV6EWETwW+zKZi932fxShi2wvjN1gAG2FEYyle6TAVEP53VOEf/9nclHR8IQxb0huJpcq4NCDzMf9T7y+PNgn4sTd2M0OapVkwilB43rXEcTNWY9gBsSBbKnhOkChy8U/2RtruwahQfCtlN3kBP4c2Z0AxCC+uzYNNAmd2zGCvY7ysyDtxSJpAGF5dT+rqsc7oRnYbFt2qWOS5WZTHasyKKonxAddy90ZWgmh5LU5wiAwPXHKHXFdcxkLY1rSWvMVVLXhtWvA/l1PWs5snrT6vYgJ9TRv7pF43iHrYjp+fPgFaWMDPCjgSAsezQMVNFnyDl762fmJlKdjlZ3e0Bqe05SMY8uAQkPY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38070700009)(33656002)(2906002)(41300700001)(76116006)(66556008)(66946007)(83380400001)(86362001)(110136005)(64756008)(66446008)(66476007)(54906003)(316002)(71200400001)(6506007)(7696005)(478600001)(9686003)(26005)(55016003)(122000001)(44832011)(52536014)(5660300002)(38100700002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4rNRvGbJCrf5aylXsEPCtbEltxm5O89APQ8KcsGSKjH/o6coyPBVv+XZc6NB?=
 =?us-ascii?Q?Yka6tNzAex/b/Du4rAZGegWU3wdur/oz2nZ7b/Haw3MFw84wL+cxtQhdwOSl?=
 =?us-ascii?Q?wTvUsYUZsnp2pXTPp4rtdV7XBzr2ymRpS9rPvqTXhF96rIKoykmNRNu9taor?=
 =?us-ascii?Q?OTIX+V8N+DFZQz2RS5CiP3++019vDStJ05DN/5IlxJsZLALkhKzUZqpA3gQK?=
 =?us-ascii?Q?Gc4ErGozdWlsqLFpvFw8g9s7JSMluC5UYwwtm9GHixKPyNlDcpq+D/VG9EYL?=
 =?us-ascii?Q?/AWzqxnoj31TDIm2xOy9OyZhzof+jYOm4cg6YqNkRAEp2a+whhupvt6xap2a?=
 =?us-ascii?Q?nvSaWtHXHa8ZEnS/c+zlCBkNzXqvOzhG0KLwWqTNhKpfKRBefQNzKC8R9Pes?=
 =?us-ascii?Q?89mPQP4Nx21TkOb5WNeP0ggBbYLnYmbLyuncMzSvvEycW6uW9rfuaHKSmec8?=
 =?us-ascii?Q?fRefHb4u9D1YW/fyQfadqahn5UUPGx8idY05/z5auBHn2KszkKNo+JOaTkb9?=
 =?us-ascii?Q?tyNSfXGG+FYpKckOOfm7gO9PkQSOAWPm7S/vMU/mdcth5KZsINxM/V9IN4i7?=
 =?us-ascii?Q?J9TPP5szIPcpYu7VaQhM2vwVBzN0e+Xk7NTchaNiN/1DaUUFcdWYLipCQxZJ?=
 =?us-ascii?Q?4JFv48HZlhlreMY3dWW0LKdJeHSR/sADT8YDhgDKFhMptEU2jW/J2lyVLay+?=
 =?us-ascii?Q?DL1/0fyIr9sNs6so47WOQh9kP+zcGMvoBKVZXuUv5BuqFthVS/BUmsarblgm?=
 =?us-ascii?Q?aLWt3krX7bR/9zQ8adiBK/1xtYMtz1ai22Csc9ozXTTKApJvMhBWfWhdAunn?=
 =?us-ascii?Q?BSWuVNaj0/gC9XUfeiBdVELh8btV14Wf/MiXLH6xFYPvkjmPtem9Mcdg02j7?=
 =?us-ascii?Q?M5R8GrNZMGazBK5tT9/KmGRZ4hq26tfp9eRhNkITO1SKqV85oHyds8soni+l?=
 =?us-ascii?Q?PyxEq1EIp79/mdIvUsLmS13EIoEbsbUUiCRHWNUEF6NA2zm44uUGlzabNCWD?=
 =?us-ascii?Q?i88EVlIhZvLTg5rs3WgWHtPFdBB+vVX95mYU0EkMOFUW2j3Ye5c44DkbGJG1?=
 =?us-ascii?Q?gbuhg287rbMrSO1lGG5mdwDQZs+XibZxAxmwtupY7qj7KnSXRlv118T+PuD6?=
 =?us-ascii?Q?M9YpCnR3dM4ykLKZYZoK0AJTP3FyTNLzKa4VQTEtBw5RP5uFl4oeI6veNmLv?=
 =?us-ascii?Q?aEJGnT5zRxWAd3ffSaVGLSjx2rz5U2QwbeFdBkQcPZ+rFM6gR5jV4iJoyXPC?=
 =?us-ascii?Q?DH5tAvXEagOVHgwzbGmlZCEhF1J/T+WdhOL7fmlibD11KTR7ArFdhs61mgLQ?=
 =?us-ascii?Q?ZpgcGRHOtTlar0+Lvnv5Oho7O/2bbkyW/W9xjDrA3NhDthw2grUmS7KCvjgD?=
 =?us-ascii?Q?yhbXbKl5SKWfn7PL61zoZPJuEsqZZspuI5GLFCpSvG/o1vA2aFrDZdpzm6c8?=
 =?us-ascii?Q?/912B8BqENTS6tit9J+Ng0D43FO5816vUOV2FmWdoTTUMB5QqAEtcIYdRiIg?=
 =?us-ascii?Q?NJerSTB9j7tRdwnQGq6eSdtuVddJWySgHF6gsXdBAOvyMWrY6PMWKHoiXe3B?=
 =?us-ascii?Q?mtHVpAOft7zOLt8JWfs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e1195d-a357-4464-22d2-08dc1d95ca2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 11:07:15.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHHjiNlYbUz0mUMR8lWt41WugN7r+mFhGokgj10QZ1mFb0OWjpKephWBmdVkq5aukn+1AxXQquMt+8sJd8s5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7710

Hi Daniel,

> Subject: [PATCH] thermal/drivers/qoriq: fix getting tmu range
>=20

Would you pick up this patch?

Thanks,
Peng.

> From: Peng Fan <peng.fan@nxp.com>
>=20
> TMU Version 1 has 4 TTRCRs, while TMU Version >=3D2 has 16 TTRCRs.
> So limit the len to 4 will report "invalid range data" for i.MX93.
>=20
> This patch drop the local array with allocated ttrcr array and able to su=
pport
> larger tmu ranges.
>=20
> Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/qoriq_thermal.c
> b/drivers/thermal/qoriq_thermal.c index ccc2eea7f9f5..404f01cca4da
> 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -57,6 +57,9 @@
>  #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
>  					   * Control Register
>  					   */
> +#define NUM_TTRCR_V1	4
> +#define NUM_TTRCR_MAX	16
> +
>  #define REGS_IPBRR(n)		(0xbf8 + 4 * (n)) /* IP Block Revision
>  						   * Register n
>  						   */
> @@ -71,6 +74,7 @@ struct qoriq_sensor {
>=20
>  struct qoriq_tmu_data {
>  	int ver;
> +	u32 ttrcr[NUM_TTRCR_MAX];
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	struct qoriq_sensor	sensor[SITES_MAX];
> @@ -182,17 +186,17 @@ static int qoriq_tmu_calibration(struct device *dev=
,
>  				 struct qoriq_tmu_data *data)
>  {
>  	int i, val, len;
> -	u32 range[4];
>  	const u32 *calibration;
>  	struct device_node *np =3D dev->of_node;
>=20
>  	len =3D of_property_count_u32_elems(np, "fsl,tmu-range");
> -	if (len < 0 || len > 4) {
> +	if (len < 0 || (data->ver =3D=3D TMU_VER1 && len > NUM_TTRCR_V1) ||
> +	    (data->ver > TMU_VER1 && len > NUM_TTRCR_MAX)) {
>  		dev_err(dev, "invalid range data.\n");
>  		return len;
>  	}
>=20
> -	val =3D of_property_read_u32_array(np, "fsl,tmu-range", range, len);
> +	val =3D of_property_read_u32_array(np, "fsl,tmu-range", data->ttrcr,
> +len);
>  	if (val !=3D 0) {
>  		dev_err(dev, "failed to read range data.\n");
>  		return val;
> @@ -200,7 +204,7 @@ static int qoriq_tmu_calibration(struct device *dev,
>=20
>  	/* Init temperature range registers */
>  	for (i =3D 0; i < len; i++)
> -		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
> +		regmap_write(data->regmap, REGS_TTRnCR(i), data->ttrcr[i]);
>=20
>  	calibration =3D of_get_property(np, "fsl,tmu-calibration", &len);
>  	if (calibration =3D=3D NULL || len % 8) {
> --
> 2.37.1


