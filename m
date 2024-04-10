Return-Path: <linux-kernel+bounces-138408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A763C89F0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F83E1F221F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F315ADAE;
	Wed, 10 Apr 2024 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CqsUJchD"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2130.outbound.protection.outlook.com [40.107.7.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EA15ADAA;
	Wed, 10 Apr 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748347; cv=fail; b=PaHyCViNcGXePkum8VatPHHjEG5yNZe9/6nHILyJoAIgCpflrIG9Yy97ScEjxoeMjxYa+816hBNiy2lzhTFlIZs+jmSXUxQfj44fqzJtBvKGsT7FdNDvEo+uFCsfCSmQkpjueF7g+rp5XmSN9zSyg9EYqG/XDmrBAE0bYbdam3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748347; c=relaxed/simple;
	bh=r/cVI1RNFKGwWjbrpkrJuN5bsV5Q5Dshk4GViG0AbQo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DFJYdEzv/hVDJ72DLNZDsO68zd36PZvhhWoOTIXoGeOvyY+/6RF6e3raIBx5a0GwwZwDmsmiImCHehgLf7TvseplfXB3vbohwIoC3llxib1THrG5JAf3CyH6hdaNEeXvmTu8FDcBSGbhYvRT4lBrp66pK2nybWrOMzha8DfKSK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CqsUJchD; arc=fail smtp.client-ip=40.107.7.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQpUNWDPCISQ+tYsQNdvG/0rSELhUBDz7JuF2gOyzczYEPOL0f3ITUGOK5ArhvOxbC5owDxJvLGzz0XgsLIYmqbcQjyzeNGTBsUT9Jyl5yVjMZJ58yEc9sptqFCw85WWupymMIUK5aZAdbTmLd2DFHm/6HWit4CTtjbzy1gWc/hP6Xo53Gc+/WefYw7rg67nyci4Sd2bydYyXKZB/yIXF+1XSfi6NdppskK0sZWkV8GeyyExnyM9nnzG7YhXNx15n5o7n2L+jOEghkpoqFYAmQ1LIr4DLnFS66bkEoaYbnZJ5IaIab1Ss2PQVkrLYQnr2cCnSDnoKcmG3CeCG+Ap7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6fPQr/d0T408iWJ4TG8lAAXFgBL5UGKwyfoj3RqeYw=;
 b=R1lUSdv2X3GDz9vSZ/jA7Ee2cfsmAEc4N942R8OW9ImQmqdtIdjGFUZH42KJ4GxJYN05f5Sa+e8N8hiP2LQnXM/qQ45tou5DYRwGdWQ8B8gRS7pkWe88M81kBj5z6EJI/XHl5VI/uLXz+6Fo0pPXwJYm0FOhzTlE8IuWy6oGD1NzMVmpV56cUj8jItmOmD/67PkCBE89n79DUxDQ5BzO84Zx/LHU0xDh1zIJUeAJFGS0NbqDvspG8YDfd6DJE+ZDVfPCF2NaJmFrRlR1Q+z9rAHCmhjZy2/sclltoyhftANetsYH7YyeKEnKKGM2F72gEGgPKRQ0LxtjXbtZ+JgOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6fPQr/d0T408iWJ4TG8lAAXFgBL5UGKwyfoj3RqeYw=;
 b=CqsUJchDc20m1vXheQImNQZ+6RUgKakLp0iH3mBGQHJ1WqJE6eQtIzGXYiVnnZS9SQC/jUBefMhmGZGb4TukSAVXZFmNAcKwfrYGmBtsBHYu/xeGZgTRathT2+UJ8x0fX3elQY5kwUjTi7FmLgdYJETjsGzWtjsG5pO/IKRTq/M=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB8444.eurprd04.prod.outlook.com (2603:10a6:102:1db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 11:25:41 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:25:41 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Horia Geanta <horia.geanta@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH v2] caam: init-clk based on caam-page0-access
Thread-Index: AQHaix0ngiIpygDrSUiyyhiPAYwZZrFhXRsA
Date: Wed, 10 Apr 2024 11:25:41 +0000
Message-ID:
 <AM0PR04MB6004F1C5AC6CE78447FF555BE7062@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20240410075815.4030570-1-pankaj.gupta@nxp.com>
In-Reply-To: <20240410075815.4030570-1-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAXPR04MB8444:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KrjLSC547Ozh4LS5ZbVb6MqNE9ml7V5sK3d3PJ+LIboAFydCf8YF0WNAXi0WnzdaqzfU8MLaK5IM+b7pRDNHp5B1vMVZ8ckx2Rlh2BPoDGc3VRRApxb+4SO/gX4P7gRgOl5SSI8Z5NmmMDEmi4C/fDaAdi6yZqPo90+ErxN8B2PFWQ7KOGEgU+6egYeswJfxN8/jhBxyxDBGnDEWmZxy8+adO5w84s+BJsIOD76M/dCsKjmLTy3SY0qitGP4T03JS8f3uN7SGRvhM72DpyVtkMMOIhUt0BvL/5B1aa4GwgplaWwUa/ssScOIqsv8GlSJHLeLHEN9PVQ0AGiz5YRXTXRdgd9YrN2yvOMTRh9+YaduxhwSJVbhW/RBf4LdyxQQkVdzcE90uIfQkGYH/2d5TDFwk2jY3w7L8SgXw+yovF172haSYI5bJBb1uKgYY+kyjnTfkll9wzo1zmkw7F9yYaWRZdWeJ/nUToTH6yOy1JqUen5r8swUNeOhfh78KhVppF/3w3sjYwTURtv5e5tfl2GIBLili1ffVED29E4ti3OweCAg7jbh3KdV5dJE2rg3MEY4mBhksOBA/foFrmILfVG2Ehd5mr/1Bll6KPmsxcpVN5ZCWkeB+2wAViK0NxaqXOm6i5QxTVxOmCM+l8DQSWjn6f7q0CaEgXoXUy0gRNI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TcEdoe6MnejzuQklJ3BDvJ3xSYxBdgVNTxN/NIMZuIG2aM+kL8br4St96n0M?=
 =?us-ascii?Q?O8kygaHmvc8xz0ICBCartAu8uXQU2IehHOPr+AjfKRiU8tCQYLDIrImAL05i?=
 =?us-ascii?Q?uBChSl6DkTMKrcjq/cUc+dC+VJquUYWqk+E44Z8yK9A8IRNx7tLumlRb+CfE?=
 =?us-ascii?Q?yED6+UoUsp0KO2MW4LtE4NYNYQuniZRAiMMOQg+Iy2ZW/+shHYnCln31in3+?=
 =?us-ascii?Q?decPmGCJMy5REeWV03ck3f+wzanSm1JgjC27Bah7q8WcCtdoEY7itqLuB6T2?=
 =?us-ascii?Q?XMhYGmYvRaFalnTLXefDEIkedU7qbgfkkD8ixqGFKub+lw/rY/7d76HifmXP?=
 =?us-ascii?Q?2E89SaqSi5D57WN+hZoQu1ogf2yTaGYd2fnlI8SexJ71Q4dRUDsxdb3IXtUw?=
 =?us-ascii?Q?YmmfGyVrD3jq4mMenMkOxijoRELC1JoCZ306BJlemZLhEDwdOxFo588Phn0p?=
 =?us-ascii?Q?q42mMaCcg7pTEBOkBQZ9OUK0Y9IudJcv8WQ+Mxr9mb5cqPcf47hqWRmV2KaG?=
 =?us-ascii?Q?z/gBDd+I/c/hMmmPMyvxT8k+WYjLltgyKFFZiQZVmcnj18WLjjARBFljWFv7?=
 =?us-ascii?Q?VxdMJweirCxnLiS7bZwklDw7dg5g6JLsVlPR+ZKERNrjFQrvPECApekYfel9?=
 =?us-ascii?Q?rLkd/Z0GZ25FL+PPHfiEicXCntgcslJLGJEBkWY+Ak+8VzYITxDKx64r3Wxs?=
 =?us-ascii?Q?JhkwZXrapy1gM3jOtvrm9gowS0RPzP0KVRWNTrbJYD3orHFnTqbbqei7ur+0?=
 =?us-ascii?Q?rmIrZ5Gg/sufKITmVl7UqUrXaeDbU1yY+XAqn6gSZXcDIDCfRZrU7SrLtuhU?=
 =?us-ascii?Q?W/r+/03567u20qTaoBCiPMedz8LIypxp81jJMBtnqGd/uDEt4bSmKwd6r4Gj?=
 =?us-ascii?Q?m+0vI6qk06Q3sJBksEwF9fcQb8Wj94Ivhhu12kTwH+I+ZBkg318zxKNz0G+s?=
 =?us-ascii?Q?SZm7gqKUF/6oX+b6CNkBcj49vFT1Y7wr0ZK4DIAEuDpxkEeVb+gHFH1I29o9?=
 =?us-ascii?Q?YcFFjBwhTNj/hCLF0g6bpGKxIxyV9JjDOzdHT+j7EZdMvtVDqwkGrB4jFcRL?=
 =?us-ascii?Q?zEvMP3pydrWbgkQDssmvhOcRwaZklHwWsfpWGYvE7dKcZO19V5P54m9kziN7?=
 =?us-ascii?Q?4akIY3cJdZNInoudXQMX0C0Vsa8zbGDyuidId2sF6V9QuMr3mkW+UtJrki95?=
 =?us-ascii?Q?iLphD2w3ON5r9ovzsbmEMwGfxza7C5Ssb4tDQBAOg27rgPMhl58hSA2RYMeP?=
 =?us-ascii?Q?rajlzrGwI+VMvPrOA4GzyFHlucp/CdyGuwmAS1bXF4mh9zBKtudnnAv0V7xM?=
 =?us-ascii?Q?NwtmjoR3+T5ropM230wG4m+/EyHCW7viAKA2dQVGbUuGgooY9ZIijVv7W4ns?=
 =?us-ascii?Q?zSeQjJapGQVGiKOYLoXsEz29tbK2Ht63m4J8zAbyRMXmEp5vy5gJR51pER5a?=
 =?us-ascii?Q?qREkRlEM2VJ+jt0aqJkemAOVXeSCeWMysUIgFuiUNYtVWmgUBCarT4BxVrGW?=
 =?us-ascii?Q?qBBnpP4kLQvnkq9weU6aC3fLuaaJWHvTX5PnQLU431cqGomyEt9WWfsBdD70?=
 =?us-ascii?Q?9howI0ri/b8n6RaSUze033fLghklBH7lMUh6xpom?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cb7e23-da0d-4872-98ba-08dc5950f4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 11:25:41.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPHGx+/6APXhvfNkf7FNQWTZRDN5XsfMBLJm3AXdAFTIpKyC3L2VeXBOZ2YQAft4H0AkuSWVnLzvAUjbnOLVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8444

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Pankaj Gupta <pankaj.gupta@nxp.com>
> Sent: Wednesday, April 10, 2024 1:28 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>; Horia Geanta <horia.geanta@nxp.com=
>;
> Varun Sethi <V.Sethi@nxp.com>; herbert@gondor.apana.org.au;
> davem@davemloft.net; Iuliana Prodan <iuliana.prodan@nxp.com>; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx <linux=
-
> imx@nxp.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Subject: [PATCH v2] caam: init-clk based on caam-page0-access
>=20
> CAAM clock initialization to be done based on, soc specific info stored i=
n struct
> caam_imx_data:
> - caam-page0-access flag
> - num_clks
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
> v2:
>  - Considering the OPTEE enablement check too, for setting the
>    variable 'reg_access'.
>=20
>  drivers/crypto/caam/ctrl.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> bdf367f3f679..355ff92f4549 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -512,6 +512,7 @@ static const struct of_device_id caam_match[] =3D
> {  MODULE_DEVICE_TABLE(of, caam_match);
>=20
>  struct caam_imx_data {
> +	bool page0_access;
>  	const struct clk_bulk_data *clks;
>  	int num_clks;
>  };
> @@ -524,6 +525,7 @@ static const struct clk_bulk_data caam_imx6_clks[] =
=3D {  };
>=20
>  static const struct caam_imx_data caam_imx6_data =3D {
> +	.page0_access =3D true,
>  	.clks =3D caam_imx6_clks,
>  	.num_clks =3D ARRAY_SIZE(caam_imx6_clks),  }; @@ -534,6 +536,7 @@
> static const struct clk_bulk_data caam_imx7_clks[] =3D {  };
>=20
>  static const struct caam_imx_data caam_imx7_data =3D {
> +	.page0_access =3D true,
>  	.clks =3D caam_imx7_clks,
>  	.num_clks =3D ARRAY_SIZE(caam_imx7_clks),  }; @@ -545,6 +548,7 @@
> static const struct clk_bulk_data caam_imx6ul_clks[] =3D {  };
>=20
>  static const struct caam_imx_data caam_imx6ul_data =3D {
> +	.page0_access =3D true,
>  	.clks =3D caam_imx6ul_clks,
>  	.num_clks =3D ARRAY_SIZE(caam_imx6ul_clks),  }; @@ -554,15 +558,23
> @@ static const struct clk_bulk_data caam_vf610_clks[] =3D {  };
>=20
>  static const struct caam_imx_data caam_vf610_data =3D {
> +	.page0_access =3D true,
>  	.clks =3D caam_vf610_clks,
>  	.num_clks =3D ARRAY_SIZE(caam_vf610_clks),  };
>=20
> +static const struct caam_imx_data caam_imx8ulp_data =3D {
> +	.page0_access =3D false,
> +	.clks =3D NULL,
> +	.num_clks =3D 0,
> +};
> +
>  static const struct soc_device_attribute caam_imx_soc_table[] =3D {
>  	{ .soc_id =3D "i.MX6UL", .data =3D &caam_imx6ul_data },
>  	{ .soc_id =3D "i.MX6*",  .data =3D &caam_imx6_data },
>  	{ .soc_id =3D "i.MX7*",  .data =3D &caam_imx7_data },
>  	{ .soc_id =3D "i.MX8M*", .data =3D &caam_imx7_data },
> +	{ .soc_id =3D "i.MX8ULP", .data =3D &caam_imx8ulp_data },
>  	{ .soc_id =3D "VF*",     .data =3D &caam_vf610_data },
>  	{ .family =3D "Freescale i.MX" },
>  	{ /* sentinel */ }
> @@ -860,6 +872,7 @@ static int caam_probe(struct platform_device *pdev)
>  	int pg_size;
>  	int BLOCK_OFFSET =3D 0;
>  	bool reg_access =3D true;
> +	const struct caam_imx_data *imx_soc_data;
>=20
>  	ctrlpriv =3D devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
>  	if (!ctrlpriv)
> @@ -889,7 +902,15 @@ static int caam_probe(struct platform_device *pdev)
>=20
>  		reg_access =3D !ctrlpriv->optee_en;
>=20
> -		if (!imx_soc_match->data) {
> +		if (imx_soc_match->data) {
> +			imx_soc_data =3D imx_soc_match->data;
> +			reg_access =3D reg_access && imx_soc_data-
> >page0_access;
> +			/*
> +			 * CAAM clocks cannot be controlled from kernel.
> +			 */
> +			if (!imx_soc_data->num_clks)
> +				goto iomap_ctrl;
> +		} else {
>  			dev_err(dev, "No clock data provided for i.MX SoC");
>  			return -EINVAL;
>  		}
> @@ -899,7 +920,7 @@ static int caam_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>=20
> -
> +iomap_ctrl:
>  	/* Get configuration properties from device tree */
>  	/* First, get register page */
>  	ctrl =3D devm_of_iomap(dev, nprop, 0, NULL);
> --
> 2.34.1


