Return-Path: <linux-kernel+bounces-163233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632208B677E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787A31C221E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9A20EB;
	Tue, 30 Apr 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q0irHgAh"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D2BE5D;
	Tue, 30 Apr 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440978; cv=fail; b=mT5GRMWQc+7AZn7w/Y5SSXy1LScFoo9WdJJXOLs3/cJUOGEDYErSO106D4F8nCSgFXyg/Tfvdzk9NU64PBQDHPGtgt677yByfoUR5SAoZcZln8kCFQZ6avzS1ySyLMep+VgFAcgnLE2JOgHBHrNLKBMo9TA9O7nj1r3fyW36g6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440978; c=relaxed/simple;
	bh=XR9pqI1bG65Q12nLkxDJXVJgybkIZ6bnJHGEBlnN5Eo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n/U2K9pXhKbfnvYJxoYw5v0rWdMPhMvwlxIHwvwhgf0xNunGYXs/p1E233DqZXFkfeTa97hMs3yavSNA2RTJK8tVSt9GoO9MeoOADIHoRWWypWo4IkfG1oS/QArmNU4AVVIASXcKkP/9SDqsqdbOLpvC4HUyCj2R9nxsD4IK35U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q0irHgAh; arc=fail smtp.client-ip=40.107.14.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IibH8TAGvSAQPoBV5vfTgJ2nf7QntLm+UNxhpCGaJg+SPezEd5EpLa8DURRivOiGQL/AEvh05hmG+06XUBcdmVGC9x5ZwbL28/wJON3pNnWOOfO2Md18472DTwMYLjbXT4Lla8EKn900gJwWATZscaCdJGDwPXNGL7MBdcASOQoZwHZBfLhPk263hNeYfkICheJFSMbVuIabom0Dcu81k1fxjfHmaHRQMW7y346aLwMWsI2p4TrFNEsqh0esQ3Jxihg8JptEwVSf94uhc8xVjM9rYkngZGUZpq/jH/8/yW1iL43r5HltonPc4Ae0HXKtOEtNQIi5MuVgVeb/VHSmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs79PdesDVlnyzG+fPWzu4lya0lFKQvqb4THrCVAzgw=;
 b=mL1hM6/ENmjJDEnYeWTcOwPJmhrFMi6W/PE4rv/OWQ9VkLc/6+qzAW+2qS/ZQ6P9unZgr2rBzv2PTmwmY1e73H2i8MGK97p8YbgvcljSbi1c8ATuSy2w4Ggn7qlnP3hXWsOdEriJ3TxQ0R0WCVz8CfD6nHTdBza7Laiua59RQYVVvNLXtPKbB7bmaqF9S9SW6AINebp1KVXkEZAqD52ctRTPEFJWCtmgx/Mzg1s4YKpoZgn1qx/qvKNkwqi0Sfmy8+W3xAgJ1KplwAl4Bs4gSA8fC8ThUMVEwQ/ZCiSwNZSuTZHAswNHWClp5XuZ4PJZ2MMoiSmbGHFrNQjpz85kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs79PdesDVlnyzG+fPWzu4lya0lFKQvqb4THrCVAzgw=;
 b=Q0irHgAh0B8Kwohbxxhik2FEsvf8DBW7tNSq/ZNoDDh0HpkPveXrbMSHkGNJ9xmuyQEgizSatEIvwXHAdnyTqTBQfT6DPHQrTPWDgMYc2kkznhObtib/iie3xOCk1KvnrSHigjdLHkeeJQ1VhZgFgNue3iDCmkQTix2ltFQg1bc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 01:36:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 01:36:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/8] iio: adc: fsl-imx25-gcq: use 'time_left' variable
 with wait_for_completion_interruptible_timeout()
Thread-Topic: [PATCH 3/8] iio: adc: fsl-imx25-gcq: use 'time_left' variable
 with wait_for_completion_interruptible_timeout()
Thread-Index: AQHamiklrLoHwKkt802KEzt7tf8nCrGACTPw
Date: Tue, 30 Apr 2024 01:36:14 +0000
Message-ID:
 <DU0PR04MB9417CE73856B1E1B1CC3D62C881A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
 <20240429113313.68359-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240429113313.68359-4-wsa+renesas@sang-engineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9233:EE_
x-ms-office365-filtering-correlation-id: 367b39d2-2fca-4488-e9c9-08dc68b5ec48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bpho4sexQ2pL189nTSdEkXDCa5p3Xc+dZGvVrL2n15VDKRVVTK05xAeTuXEm?=
 =?us-ascii?Q?tsEgc9frIraNSE/w7appeHugW0yA27oQF8eux1QFeS7yyljtgq2lp13tD5mp?=
 =?us-ascii?Q?/hkvd25WnDMl77dlanyYwkokvp7LmhFuOONdaMvek1fMEJ4V7RkC/BjZoGOt?=
 =?us-ascii?Q?SCX1pFtN1rjQ/q/hKKpV5i+GELN945Vgoh3Rafn8x7nO9+hnhM3sJvnl5omm?=
 =?us-ascii?Q?GvgHVybHVUXkK9E9NJRAKdgj/HJJUSRi0tt1EKj5Bqj8kXHb1Wk8FWHTjVVm?=
 =?us-ascii?Q?Q6xflbb7G9TlXYBEJRofzPLaHAyYcrl+Ol0uOWtPmMEY4pFEnpVVn8xSwafn?=
 =?us-ascii?Q?QRqnalEXA8sxdch2iiVo8HjzgxECLk0Z/lTnaxJcyGvcx09pRFHYvq5cXxV1?=
 =?us-ascii?Q?tTyZ4CR4VMLlH8fLVJ7yl6v8wksyNxzGk4504XVQE5EWB+0yX4A/fNFbhqIe?=
 =?us-ascii?Q?0d8+ue4fJk/x3b+9xN/Csrnp9MQ2cx0IXgk1RAL37opoWBBRgrO42dL73hJU?=
 =?us-ascii?Q?NUQnVbkVozjoyKz6VOsfaPybEygGkLz6QUqRfgkClNY+3iz6GYxnkyIm0B8Y?=
 =?us-ascii?Q?X5Nhks57riVT+ejrTGVCKydeo7JiVxMh21Etuq5S0x5SGuvYaxTMYkbh6oSA?=
 =?us-ascii?Q?w0x+mUsfe8oM5p1MAX7cApv/EqO5xaZ+MFwPB7bgI/A+IHaAJWyMQJCH3+AK?=
 =?us-ascii?Q?Z4RQFvHjzTGecqusyT2+WQyew/nnhNL8zPBzyizwWyZGgVfPQGSOkzRNLOqd?=
 =?us-ascii?Q?pjr+PDEkzuAraiiGorOefNyRcJhv+kos3VH9XOIA5aK+ehZRCz9idjytPbJ5?=
 =?us-ascii?Q?97P/2xoCOAF9wHKPHUdyQk1t9Lrp2VAPRyGh7u2LQrdDF9G3AqhymY+7GG+B?=
 =?us-ascii?Q?uMgO0I5y1/W6QhyZcdR2++6S9K8RnZ7KX3ZQkadoe17Td0X26Cohj4ihjzBd?=
 =?us-ascii?Q?6wnMF4CiG5JKznnzxeNSv+kMkR8lMRZkjCl/aVRBNgvdg69UIxeUsbxcONIs?=
 =?us-ascii?Q?9kUtquNMp8BjcVJMh1RBJCDO+RufVdWgzBK9oiFYF1RIBePRaEf8nvjB44Un?=
 =?us-ascii?Q?zn+QK/eK2hbayY9r8R+GKRvojnQQXwtYHKZW4uRn+VTK+ulkFeS63wSZJasZ?=
 =?us-ascii?Q?3LCfyUeY+clVwdgvzBlesbAn+TChpBAIZGDbaYvmsBG+ZPikfBveX/QkWNYL?=
 =?us-ascii?Q?WssXFXG68Md3HUdUDcyeNAMily06J7bLd5uq694svosWkUrcF1j/VapIOtuL?=
 =?us-ascii?Q?Lp4hOBNe8af52mmanLWDx6kOFOJONhrrAK6kcHbea8S6nud34PrjGB33zV5M?=
 =?us-ascii?Q?BLzTHANu6K25JXWbUznOB/4esGHVgY6XTLRvbf6HrijiwA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/T5nGPRMwqBpc6TwtogKEVA3Z4nPwJu34327JD43VQpHjNhQ0gyvfE6Byxtt?=
 =?us-ascii?Q?vj55cKRzLOiUL5w6c+P7KMPJoampOCdEGBx7fL9IJLGl4Zg39gVAbFFmm/9T?=
 =?us-ascii?Q?vx1Rl8spamatxoAcI3mlru1fFD09Pw5XEZ+fxPOhk2SVOe2nZlT/EhvCh+kq?=
 =?us-ascii?Q?KbFTsbyDJ6M/SHhuWRzqYpeYOlywFlnd/rPV00oE2GYew9W5nARxO+6r1kz0?=
 =?us-ascii?Q?POyclJbe6xg6vi6PRHp6mxWdmHM5r52LvBg0x3rB2RmyRBuWCGNe+CZxApKQ?=
 =?us-ascii?Q?i1pxC5HcDjtu3UyfH0ftXVYnLTmXOeaQK7FD/v/vBDUtpPd/sp51BYEEdIzA?=
 =?us-ascii?Q?UoO+m69KwTGt853PVzbMDN+NLK1UfdhY5QDzS2Xdhfgh5/a/HrKBXXVgAaMA?=
 =?us-ascii?Q?90w0JjDiazcoHuBOCkQfSrHnQNntZUlnkP0twt1aiEJ8Ix2gjKXSV+ySRqTq?=
 =?us-ascii?Q?a56gi+ip2QzEx9spkz1B0ABjlcpQJt9zGp9xoeSczRC2VhpaaMW7O7lnr0rq?=
 =?us-ascii?Q?9cTPA2vjgwQHMe4Hqfgx8xwtHTXNqKAFzVSH9K9A1+hdUfOOGSlslOlzMJ7w?=
 =?us-ascii?Q?c5InWaKCplCJ58ZqXA2fvC1FBS/BQBTjbJtTQxdEUFeee2SP6vmR1zGpi0js?=
 =?us-ascii?Q?nVy07SMM+VMQW/zNIqXV9mXokK4BKFADCn2CIZNuuyRpn/pRCa7Mlqmz+ptF?=
 =?us-ascii?Q?fWeKP5KMwpPTGcq7m2xZ9kQRl/jTO7AzR3w3oGPsN9CcyKW+LOjJeLRQt+ba?=
 =?us-ascii?Q?PezyYxt2NuwxlZNYxaPH945pC68BzqQMmtYAb/POT/6S3gmkx9OfbpNPP3W7?=
 =?us-ascii?Q?5m6ZQ1Q//aMoSi1pEpAFRJugirIGDzUNc6vLv2PUWgPHW8A9Xf/Mncr2bdun?=
 =?us-ascii?Q?4ig0f8z8dki62xcazuIOI2yHXsSU7gQq9qmgbDoF+VCv7cgq1y+qqePQrF2T?=
 =?us-ascii?Q?qLmqA2/Ent+o5WsgG/Zh2OnOhXH8lt7F+DCG1OBMk6E6t9sG5Ipmz3VkltPM?=
 =?us-ascii?Q?UfMzdTVwFMIKC/KcYyNwde6vCqsfSajoegRiBzf0WPZZ4Xp+mrwv6sYVQ+ST?=
 =?us-ascii?Q?GJk8nvXJXp+uc95Qqi4VIytanJuDVkMlXc9y7P0BG2mKFkU2mnTDTTJcimRL?=
 =?us-ascii?Q?27GtLAUeGl+kyxgBlBkXaYoFs6BwmX/0dP9rkqfiTCNaJEe4MZ6jfvfzh20o?=
 =?us-ascii?Q?vfqrGj9Cjkx4pHgkP5gZLUd9LBzcgcT7ie1ccP0PpKzCBK0Zhe6Qkxx8fQ0D?=
 =?us-ascii?Q?DZEHUpkoHpuVEYsqhELcoI1q2a5+hA7GxGc42tZjrneLg+VjI+tyvjL6lPm1?=
 =?us-ascii?Q?Br1bF8+cNkeGvh/OQk3XiTXqM4yty/AV7Vz5QevdkNdCeBsjOKtF7m9+qDS6?=
 =?us-ascii?Q?rxC+6Dkm1aRWifhTnBOO22dfQPAiB9oUZp5YS3/X09xyhGP72salKof1P609?=
 =?us-ascii?Q?qFIhYWQBUQfMYmrWXcU5JkMAsBpT93DpmDdnS2J1DWFmcHoWNDMKDau+5pQB?=
 =?us-ascii?Q?+oNQyr6kpnYHWuzJNcuLmqZWPk0ya5fHwnG/Qs8M6wf+TVONypEO/bmCl+Zk?=
 =?us-ascii?Q?dh/tzkc/iWSGom58As4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b39d2-2fca-4488-e9c9-08dc68b5ec48
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 01:36:14.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0atN7URh+gY0P0KNITzAkv0yOpTVkglvgbndnj20RGB3GIBdGakkjPDInyggwFLAt+VNC8pomknsPtAE0MndPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

> Subject: [PATCH 3/8] iio: adc: fsl-imx25-gcq: use 'time_left' variable wi=
th
> wait_for_completion_interruptible_timeout()
>=20
> There is a confusing pattern in the kernel to use a variable named 'timeo=
ut' to
> store the result of wait_for_completion_interruptible_timeout() causing
> patterns like:
>=20
> 	timeout =3D wait_for_completion_interruptible_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
>=20
> with all kinds of permutations. Use 'time_left' as a variable to make the=
 code
> self explaining.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-=
gcq.c
> index 68c813de0605..dabc5303d644 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -107,7 +107,7 @@ static int mx25_gcq_get_raw_value(struct device
> *dev,
>  				  struct mx25_gcq_priv *priv,
>  				  int *val)
>  {
> -	long timeout;
> +	long time_left;
>  	u32 data;
>=20
>  	/* Setup the configuration we want to use */ @@ -120,12 +120,12
> @@ static int mx25_gcq_get_raw_value(struct device *dev,
>  	regmap_update_bits(priv->regs, MX25_ADCQ_CR,
> MX25_ADCQ_CR_FQS,
>  			   MX25_ADCQ_CR_FQS);
>=20
> -	timeout =3D wait_for_completion_interruptible_timeout(
> +	time_left =3D wait_for_completion_interruptible_timeout(
>  		&priv->completed, MX25_GCQ_TIMEOUT);
> -	if (timeout < 0) {
> +	if (time_left < 0) {
>  		dev_err(dev, "ADC wait for measurement failed\n");
> -		return timeout;
> -	} else if (timeout =3D=3D 0) {
> +		return time_left;
> +	} else if (time_left =3D=3D 0) {
>  		dev_err(dev, "ADC timed out\n");
>  		return -ETIMEDOUT;
>  	}
> --
> 2.43.0
>=20


