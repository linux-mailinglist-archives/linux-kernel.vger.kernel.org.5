Return-Path: <linux-kernel+bounces-149486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355FF8A91B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EF61C20D62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689A54673;
	Thu, 18 Apr 2024 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PoS/p/6K"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9C53AC;
	Thu, 18 Apr 2024 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713412985; cv=fail; b=kN//bvLosepwvIkADlW0zZjjfCHwJfd42mHhsHdyIu2E5vSD/gd0jRLPhftDUAWrgxwjL37/NiYl9aSW961ZiiGG7ESJKcWlLZe//qwKQcUzuPBX4CjKrpd5Te/vFfD+SrxjL3u3Qu10glTNcda8UyhOn6M9ygtABpwE4TMS4Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713412985; c=relaxed/simple;
	bh=kkmDxGycLRun+HZdMU8wq6w1xzT1G/d5ZvAglzwAqdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9sN7bpcZB0CQNRGYhBF1lINCcMZCKcU9dZNrFouHZGPlhlqkyCwtW1Fe6ZxPH3gqaKc4yZ8Clflobz1Mv3Rwmcf+FVnx19E1AcOvvrrvv5mXh+BEuo3A4J1/L0S6spvq4tIGx4vwSy3q+do4E739iLa83fLr8k4glxkzBngd2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PoS/p/6K; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2julL1jJjg7YBeMe4fVEZhJQ5E5ygmI6RhY8RsvEN7MUnIE1yd5kOWS6sQSZSZiatwJEDBQEYk6KeN9MY59oRqRXYZXLW+muucFnlmZJcHkSEphitCJDJtp9MdhtiX+pNOI/rSVhI7i+3hDl9JmlTAEL87qfZGTWZlmQJ0mMvYUHfcJYfCFtnYQ68cD088rHj+4i+53bhKkNh7BF0D83zh+OJHH+BbAhd23f6UbBmi0BLqb1z7WjxdOgGe9v+YAEeFHLhzyJTascuj9WtxceKyZAP26qSgpc8JPkhTH6RzsfsJYDwHQmwwbCb8yFdxDSFcmH3/n70v75mqvbmMSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEByaC53qZDP1hH6a2G5ydBeVEcovqxDgccxX/Z6qZI=;
 b=Gav2S7qiVKZXXc2NFRkDrhqEpi25Gq5kbTLn/M95AETxaMYt5n6VQHhswRxHB4vpS22npbloia6LfSz3thZha8wiaVra13D2hVZybnFQZnpzUSBop9LJXJQpUzT80oSWWAmxfmN10PF8PRKD5q/lO28YUe4CTIbNLnVc52t7LGWV2BOt/6WjSvV2bYPQxIRjnjpXgEH6WhoNC4GGmj4aaJWmZ30baQFG1M8nbTnUhMwZAdQz9mfo024qZ/yoJb8ZGnLAdBcTi5HyA1DbWlFnkMbI7Jqx7ETAzqamwn+LWyLm0X48VXoUmgxnOzG//vSn8/aKJ48JtU0dV1Toh6stjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEByaC53qZDP1hH6a2G5ydBeVEcovqxDgccxX/Z6qZI=;
 b=PoS/p/6KtpfW9aAq/LXy6fL6JOaaMT+8aoY4l5eVNEnU4/XEppKBbj/GFPZOl44lpEk5g89iIdoa/AgDTW82lDDAGEujqYd8bVqDb9st51Z2zMp/P4xpSeWQIGRo0omD3Rf5fEkdmpnQNQwV/gq4qrDg0mQV34W1s2ihL8t3eLs3XhMXPsgl+IJuVs5dLrQYnD0ICDOwgCTljn++drRyPfdghzpOBH4MvgCDN0vk+NhINtRj5Crrc/+5Iw48MMpDJPpfkCe8rZK4C0T/wu5EyzJvITvbFsynEwm4B4ETiLU3G3PDtQPOsV/WKI8gyveXxIybm75V9l9McTzA99MKVQ==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 04:03:00 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::e696:287d:3f92:3721]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::e696:287d:3f92:3721%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 04:02:59 +0000
From: Akhil R <akhilrajeev@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/2] crypto: tegra - Fix some error codes
Thread-Topic: [PATCH 1/2] crypto: tegra - Fix some error codes
Thread-Index: AQHakPLXFgrOV8qeM0eYRC1RnpmShLFtaBwg
Date: Thu, 18 Apr 2024 04:02:59 +0000
Message-ID:
 <SJ1PR12MB63391314C4D644EBA8A5E77FC00E2@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <ec425896-49eb-4099-9898-ac9509f6ab8f@moroto.mountain>
In-Reply-To: <ec425896-49eb-4099-9898-ac9509f6ab8f@moroto.mountain>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|DM4PR12MB6613:EE_
x-ms-office365-filtering-correlation-id: a0b71a11-301d-4100-99c9-08dc5f5c6fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2qfhl8WeDT9ANtAC3uxsQnDZeS/5qoMOGeGmMyfqUk7HWzybPd2GiXIrvTVEmTvjw22pQAOgZ3Bkuhwvl7jslIQVKwIMPcj6PrXclzYuwaGpeMPBRxWFydcC7RKL8nfFeCnYX8hv++2kVCtMZjyWj14znnVrsPGG3AnmWZ46xqAa6WJDgYlo9xIeyk5RmuBPaZffL+Op8a8vEhIuiHnzeRaKmxeWcezYIozXCBlX8jBbQmMfd/5RUQUFl3rj4KYBPYeu4qs/uaKvR5YwmiT3wwSPYKDofTf1ZoCZV3TQtK3mABjUhwmHy1+r4aJGWLYJYWH/vlkSmlsF/ihWSoa3ZZsYCHgdW0/OcWnu8KVb8LkXzeTDNYuCpenQ2dcomwZw0MAqFndf9rPcyFsMRzOFQFpDahkzRS5QeCTcqv86facXKNbXFAiC9/9NNUGRdKEi3JezThe603JZ+JHD2/uPqBBawyJDYJI2xBY8Qmaj7/4tr8Nl8vjNlPeCZE+3yFF0ETDuS4LxZpeRD16gFtnBSggBK+i8V/IiADJxGIS54hSGhYT0zDfShFumt8+zAPVvw7XEUqy3yWnvoAh1RSq+2URoKD+I7sqrYGqlYMeEMVH2srvW4ZS46GYW562P4LfIVIgH3Dg07rwwea2IzvPbsWhLwIuDV22B2ihT1UlSeAtkr6cqdc05jQ0xWM4zKEi6MR4f2m/Mo6AFpcFvxfwd4OT5VCS3K48+t/fHrvEoyIs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JXKgDgnq3sqhT8Fx6Sw0FyUWwDFu/Jrp4i+pe/yqYeig5D++HnFZ42zIDWim?=
 =?us-ascii?Q?K/2T5lXeqP4mPrSA0AA0uIXig++IFyA7BO7azNqHOMUrVYNxb1iRqkS5lzd2?=
 =?us-ascii?Q?rp51Smt5umSCTXZ/8Xe8xNwNDDy5RNVsEym/aENb5FQ/myDHHZtZCjocypaR?=
 =?us-ascii?Q?i070tXtanRPdTUTu1BHXKYrn7TzOo8mPpZQrHjWmLV2PweO6hBU80QK4wbzw?=
 =?us-ascii?Q?6erMGx8iW6KqrnUYgV2V7O8A4LPgx8g/g3EBUPXul6TIKjylsWUIGRzpTYEr?=
 =?us-ascii?Q?L0W67pPLrzR1/58CVY94AKABWkWeK2Z6LxZr9hMs5AxlKUSsa9aQN/G/Lz29?=
 =?us-ascii?Q?fhb2fXTJpDqjv1/VqIz8uRL3s9oecnW5gnd9widlqhZSLPVjT0CMZ9aFa/EW?=
 =?us-ascii?Q?tkMGAxJibgx36H0VGm+i20F98szK1GlutfBaSIxKgcoeEck589W96K5nRsZh?=
 =?us-ascii?Q?r0vkNtv5lAHaWMAkhdoiGCZIAcONg1f/TFr4+3k05w1SeCAwIx/mw0Gk4NnB?=
 =?us-ascii?Q?LURyAGol2J8x9e87L9JRjf3DWZt49ybZszr2SrHlyfSptrE9NU+XORTEXJR9?=
 =?us-ascii?Q?dA7MICO2rD2rAP3lpIQcrnhPbmUPimOS2Aq/lBHQScQesNXCLJ08hNp3wVor?=
 =?us-ascii?Q?s5h7v9Hm70119Xpd+BnFBxYj4DmVzsw1dHz+V+PV/CBx/5LQv/Ccvbv05aji?=
 =?us-ascii?Q?WrreZS79du90II/pfe7h56Tlihmm+duNOtpuqrEYpkGwMjcQ4lchGWXNx40o?=
 =?us-ascii?Q?kzuyyYMkVpCRNeGCyH9i//YXXEaQJnEj4HAWS6eMsH3SzrbKa6SWlgCqKa6K?=
 =?us-ascii?Q?uaoPFHT7orNNeV/rkdc/hKxWGGj/02F88N4KpSTKQQaaBpMsIi7XOm4HI9GO?=
 =?us-ascii?Q?b9fZgaQpjGG+1s5tx0DdnctpKtlHN+9KPICuSD0dBnElZcrcMUChI5az1B2x?=
 =?us-ascii?Q?D+8k2y1ulp4hi7aqCfhleIOReA8Xqg2soZaJADxUGK0ZTzj/qpArTQCLZVur?=
 =?us-ascii?Q?477ulk0h/AFIyCSGLGBl9xttFoOmUmFRKxYyHXYTums7gqJ489HPmP/aM1rF?=
 =?us-ascii?Q?d6YYh/P3gf0Z5dvkzkgXKjJWkO7Mvu1P8vlC8SEDe4Ph4LhXO8ECiYy+cLZ4?=
 =?us-ascii?Q?FxI6O7yovuMTOs9m2ewEMju9XoQgdU6J3hu+jxMMUf7MZcGBWuzeR0XmIeWV?=
 =?us-ascii?Q?aaIXlA364+EyxH5FDJpao/XCJtMiecdgl2gvw+WLP6+QhVi9lST7Iv0hGTFM?=
 =?us-ascii?Q?gP+1J06PojljFe7yU51mUvvVdq3bCgHk0ESIapueK/YVOesjp/oAJPQXsbcv?=
 =?us-ascii?Q?pPQv6rLbwtV2peEqyLSiV+2ukLC8C27shOBmA5OgQ+55exQSSoDEQkt+Dpri?=
 =?us-ascii?Q?CUqurIyD14YJj4FACMZHCv57fRcU3nTRKR0NoTdgB//XS1ryIuPhL5aIYacM?=
 =?us-ascii?Q?idBtiQe1QGCLdoxKCg3tIooQFRjJWf++4iPoWKuOUrhXEhZjJ422BdU/lTbu?=
 =?us-ascii?Q?vTLTG+zqG9ZNsTmYP3QUzuJEBhkKy7yIQs+k/JYnP6cQsDOacjWrEXe/fbjy?=
 =?us-ascii?Q?deoFyjY/C4bnwuSu84koz4aXOmjtmMBH3vIneG2b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b71a11-301d-4100-99c9-08dc5f5c6fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 04:02:59.6862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXaEQJ2az1DBNJ/5OTeJunNf8xBfemozOdM/go1JY+g1IXLWHsH1Pj3ipRphLEz6JJdpLsEY6iXxwnGWu8dScw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613

> Return negative -ENOMEM, instead of positive ENOMEM.
>=20
> Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/crypto/tegra/tegra-se-aes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/t=
egra-se-
> aes.c
> index adc6cdab389e..ae7a0f8435fc 100644
> --- a/drivers/crypto/tegra/tegra-se-aes.c
> +++ b/drivers/crypto/tegra/tegra-se-aes.c
> @@ -1156,7 +1156,7 @@ static int tegra_ccm_do_one_req(struct crypto_engin=
e
> *engine, void *areq)
>         rctx->outbuf.buf =3D dma_alloc_coherent(ctx->se->dev, SE_AES_BUFL=
EN,
>                                               &rctx->outbuf.addr, GFP_KER=
NEL);
>         if (!rctx->outbuf.buf) {
> -               ret =3D ENOMEM;
> +               ret =3D -ENOMEM;
>                 goto outbuf_err;
>         }
>=20
> @@ -1226,7 +1226,7 @@ static int tegra_gcm_do_one_req(struct crypto_engin=
e
> *engine, void *areq)
>         rctx->outbuf.buf =3D dma_alloc_coherent(ctx->se->dev, SE_AES_BUFL=
EN,
>                                               &rctx->outbuf.addr, GFP_KER=
NEL);
>         if (!rctx->outbuf.buf) {
> -               ret =3D ENOMEM;
> +               ret =3D -ENOMEM;
>                 goto outbuf_err;
>         }
>=20
Thanks for the fix.

Acked-by: Akhil R <akhilrajeev@nvidia.com>



