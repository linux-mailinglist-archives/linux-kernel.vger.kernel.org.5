Return-Path: <linux-kernel+bounces-103940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE0E87C6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D27C282AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7717E9;
	Fri, 15 Mar 2024 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d5jpwe2C"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FF10E4;
	Fri, 15 Mar 2024 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710463479; cv=fail; b=WEgppcfw7L9SLbiOX7iBPC2gh4notNB5KY+DoFY5APayu2MtiPxl9YGglIAES3/eOxTO6uHUb8RGh6m0EPGKzCtwz6O1dppQxgSrn60nFrhWEp/UN7eG74PI0QqBoa69wxYlKH1p5Cnm8UajqM2NcFd8jERX8KZe0pmpjVglEBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710463479; c=relaxed/simple;
	bh=oqBTUCn/ppl5btcufmot9AcQI6ymnzm1vlD0TD07ofs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2Gjx0m/MDVkhQlr7OTEeXabqpIxdLGQ7UyJlEEDBUDIfBv5gyA75W0wYMIFiccKKx9YXPbrlwNIaaUt2O/sAtn7hFRWM45niOCTNdLr1p2OzOk2PGGxKZq/lSCAcx6tpc3wbnlFJNzlb+V4kZbPvbY59ffsH3qPBH9EDo8V23g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d5jpwe2C; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUupdtn4UpUOHbIuRDH9wdlCz7O0UmR0QYgR46X78Da5uqIzpFxZmUO9WFrp3hyjSWWNAFX0g62RiFRDJduY/kNGoE/3JtSKazTecBRc9ymocg2dsLmDJfaKkqxxi7nAnL6o+7SBMvl/y/jKxgxv43X8hhwWYWCAttoNLBj9Dc6AnP6W6BUCh9jVJW5cvwTf0iQ+GBP4GkTmudSEcR24iSWr1FqmamBJTo7CaF1ppQm162NU8vIkS46hjh10KZ60n3kfG+NcXqGUKoajsW3QsRPoYkq+UZ4icL5n2h/eTUleKzVlbG4P4kkxF8DV3AxFxRx0g1kQFgwp1L1N97BuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5Eg1cXg/Q85KwGpf5T4x3Xb88TTe14vDwOEhWrAhNM=;
 b=mIk49s5MES/CF36ArjZvuX/lXR+NzefaMhJDwKOpFmhqL4vsif6bCe22UnwGJc7V+TpCYHl6EoQ6t9BiR5Ok69GsXhuVr6rUHnBgWSh2uWGQegZQoIhOlR6qDlBCAlyBUynDilHGJys8vXuWWF2f4A5dNGLfPJe/YUsETFr5BNOb5/MIVf4olYuLO7oQneqAWIL6ReSlwRAGSByV9qwxkQR1ZwOIGU0hf6uYDs3Cns2bNxXNOPEgq8dKlSp9w+7pc7bKCeNgOmfAmEgSjlAH89FS1FBqVh/wAVDDFu1nZAOgfsoKmQe9/cx4yBbvkrvVgHU+inCW92RRHpkoor38BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5Eg1cXg/Q85KwGpf5T4x3Xb88TTe14vDwOEhWrAhNM=;
 b=d5jpwe2CAxF6ODJNVZoesGISigKljmaa7UMROd2h/esIdVjbWt7T6kW450OPrVNxJDwesHvBnWzS2kGwqvcIMfuVx2TwuXrLGtm4yUZQ0Tl5MyAuGJGwhehGxEYBwQ292v4cecJcv0MuSGW9kblQcbewPAi9F2pti1Ij11hg6Wk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB10065.eurprd04.prod.outlook.com (2603:10a6:10:4c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 00:44:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 00:44:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus
 Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v5 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Topic: [PATCH v5 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHadhNdlT3LNwW+z0GotvRK+LURY7E3XT6AgACaO0A=
Date: Fri, 15 Mar 2024 00:44:34 +0000
Message-ID:
 <DU0PR04MB9417F0C53A0B112E7A8A334288282@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <20240314-pinctrl-scmi-v5-4-b19576e557f2@nxp.com>
 <55ec2392-c196-4669-a339-12ef336707fa@moroto.mountain>
In-Reply-To: <55ec2392-c196-4669-a339-12ef336707fa@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB10065:EE_
x-ms-office365-filtering-correlation-id: 2e7b1b11-fdbd-4ca4-8b0b-08dc44891585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pKpKh7xlLVAneJ3QT0wKYLCjH+w4JtdkJOisJZxuQzx+ksif/1YGmDqd3IldkO5h1Mkyirw7rhcRsHc5n4VhE6IPZAA8nzi10bxdyICcf3jtGrnb18MLRye+LZ/GbRS5HMQnVgGyqwviyw8bd1ciE8eEj1jeEzCp0LQxz+nByxAAj8hs7aZGLY+WCTRt4nHGB4+0keqoFvbuF7nU3gJqXhp20x9SQs+8rhccyRBJxdf4QW76JCbfEndbcut6PZFOyNiupF4EKVMnBBfKEjcVRQiR+eirnhJGTgh426GtMNr/FrIGWxpPMx+Yd9uuokmGaXbwpEkW3/tIqD5YdyfPhKJ8VB2tmxvO4E93KTITQprXBrpT3tsWXX6SfKRAUG0gziw8FDuveQzWMrdEcsHx5FtYqXP6uFxX5tV5Jsnh5wipM5kUu1TIhhujsAS+u0d+qkQk3eMIc+dsrp++tyF2T2M1tw/tIdlRQo2ghpZjLiHwLKPK2by2+Umf/wau5NTN30X85fjFJUOoR6PAui/ND+Rln5pFedJEQvkCe0PWQxZwX5Mr15GrMdjaxMZboXiXRuJwkuQDRoRPxQxEjMwnssQLddHkANKUDzX7K69bo3vVozPzO9bbSp/sAm08UlCw5KDSrK327ReIdTyTvmUqCHeEQeUH/Zd5ecEqZO4nbl0Vr2kK7p52T6hZAvyiZtfmR/ssUMCakNOQghCj25UK7BY7w6ZFd2S+bLS2oMyz278=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?esvZqgotgQXHrYdT3GhKqFkxVpHOeYbEqAmJL+Ztuux/6TIGsYxlPNxG/6Gu?=
 =?us-ascii?Q?6sAGUnrMM5zQd3wVWr3Nhld87ycNR2Ch2A1MqPlMKe8p4MQWcFXANPpaDLZI?=
 =?us-ascii?Q?+Ab78hOd3yM2nl6Lnh+VumMjkV00FGvUslHQuoWKhphm9PBqucutaM939e4w?=
 =?us-ascii?Q?kUdlwUmBUO6OyBD3XoWNZd14tSej7h0ArBKg1StrTpMPwItmZ2yTiOlX28zc?=
 =?us-ascii?Q?T6yxtiKvc+OnmQuWqKRPZoADFNnn+Hb9+I7T0j5bG4kqTLKghIAZbJ3JaZ5b?=
 =?us-ascii?Q?bDsxAa7oK17AgAgCW5LQHyN//YE7X6Gnhb0rYK+MVElNTe5CIwyIoSvkDY4X?=
 =?us-ascii?Q?T2Lr+rn6kXQAd6yaS3qGBG2P+oeXXgY039rWkdmMWCZ0G7fjefOEZ04BbojA?=
 =?us-ascii?Q?p6WogpblYR+gYV6+e5GNSG1BY/UDVHmDoFE2YynwLNbnmIpLQ/moWKD8Y/eN?=
 =?us-ascii?Q?fvY+te0Dh2SBsHbWqu1XLFa2d4QwL0AauGlDtmdrg9YeW7OjGpoHcPj/Cw96?=
 =?us-ascii?Q?lGFW3QYqB0IJtiouy/rkIuKbZAKmWSBMThtCzfMa2dkpCuHzqvl5h6ZW0jzL?=
 =?us-ascii?Q?sbWCp26pEWRat+p9tKzpTSpZsb10rVMsaccXW3jZ56nc5/LeJL3ArbWASRSE?=
 =?us-ascii?Q?FzLHPNyFqqrATomur6P9uhMQjYKnAcfMqrVB5Odxz7LJV/sgKFoZ8pwIKRf2?=
 =?us-ascii?Q?Y5JSUUzwlon9B1oGe9mR2quOZcRNTsqSmCmws+DHiYefdoIvE4TYbxqj7qzp?=
 =?us-ascii?Q?sezPLFXpT44mkDydChvKx02EgHJrZYUlqNe1ZQP/7p2yf/Gykq+aF1YVqHIT?=
 =?us-ascii?Q?DFJHdcpHcXh1/WcQ3kdKzzR5G5Y+r9QxBTEymjhxC6tRJm/BXwBreAq31EqY?=
 =?us-ascii?Q?n3gmFWkT4XSnaCaqpB7LBFPDBRCqBLPPgyY2sGrQKmF396VzQTBIy7gQ25sS?=
 =?us-ascii?Q?TKSca67Nw8m8Al5W3o/lwVdnGTkhuEZK4T3EXPzv93ByuBkbnWc6nQu58RHf?=
 =?us-ascii?Q?DVNEkAtUbd0a0DVx7BJboIFuTSaU9ATdT5YGFBBCb84YAFhALGX+g99j9OA3?=
 =?us-ascii?Q?/u8u84Y1O2b1hQhFp8cDZFtmxvCxJmE2MddBwdkMsV+L6lWNqafd++ofNVsQ?=
 =?us-ascii?Q?nDpJ+O35CdWmbf+roFu4wn8YMon5hFYPNVYFbx/B/0O3gL34LJosiZUB17j8?=
 =?us-ascii?Q?ceSkfZfQr0eadF1j+T+TdFteMh/YVQy2d3xzRFTQzYJqk2MzyAAIWyJH9QkW?=
 =?us-ascii?Q?X8zLo51sTTjj/M7NjxfixAQb6ECnMogUDlLCkiIAbjo/q1nDQUHWAJjU3pgw?=
 =?us-ascii?Q?W4hBr2TQrYB20APgpoA+U/Xo/v9T829mdlLd4aFoIe4M191LnUxQMuvnKh7b?=
 =?us-ascii?Q?WTm0CKTY26zh4487eARew6cd6UFIuhloxPDjhWNc8P9jinOv+/K6YSX9ZOJx?=
 =?us-ascii?Q?gm5tR8p3ez8nWINYGC24JIqgitppcYdDwF/Eedv4L95gI12ra/DhT7Zz5XUD?=
 =?us-ascii?Q?xhM/1PsSXrGhWw42EZJU6iJWmtAlfaWG7Ge2P/kqzl42rgoN9BTcv+vh1tA8?=
 =?us-ascii?Q?Y/DFwczJo9AFfc8zBRM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7b1b11-fdbd-4ca4-8b0b-08dc44891585
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 00:44:34.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGpiqq2VK3AGXLjmcY/p6c6PCL0tM46t+U046vmPIbYuyHjuKhY+US5xNZdnwgvVHgEYlr1GthYzOy/PKx0tFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10065

> Subject: Re: [PATCH v5 4/4] pinctrl: Implementation of the generic scmi-
> pinctrl driver
>=20
> On Thu, Mar 14, 2024 at 09:35:21PM +0800, Peng Fan (OSS) wrote:
> > +static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctlde=
v,
> > +					    unsigned int selector,
> > +					    const char * const **groups,
> > +					    unsigned int * const num_groups)
> {
> > +	const unsigned int *group_ids;
> > +	int ret, i;
> > +	struct scmi_pinctrl *pmx =3D pinctrl_dev_get_drvdata(pctldev);
> > +
> > +	if (!groups || !num_groups)
> > +		return -EINVAL;
> > +
> > +	if (selector < pmx->nr_functions &&
> > +	    pmx->functions[selector].num_groups) {
>=20
> If pmx->functions[selector].num_groups is set then we assume that
> functions[selector].groups has been allocated.
>=20
> > +		*groups =3D (const char * const *)pmx-
> >functions[selector].groups;
> > +		*num_groups =3D pmx->functions[selector].num_groups;
> > +		return 0;
> > +	}
> > +
> > +	ret =3D pinctrl_ops->function_groups_get(pmx->ph, selector,
> > +					       &pmx-
> >functions[selector].num_groups,
> > +					       &group_ids);
>=20
> However, pmx->functions[selector].num_groups is set here and not cleared
> on the error paths.  Or instead of clearing the .num_groups it would be n=
ice
> to pass a local variable and only do the
> pmx->functions[selector].num_groups =3D local assignment right before the
> success return.

So you concern is I should clear the pmx->functions[selector].num_groups in
err path, right?

Thanks,
Peng.

>=20
> regards,
> dan carpenter
>=20
> > +	if (ret) {
> > +		dev_err(pmx->dev, "Unable to get function groups, err %d",
> ret);
> > +		return ret;
> > +	}
> > +
> > +	*num_groups =3D pmx->functions[selector].num_groups;
> > +	if (!*num_groups)
> > +		return -EINVAL;
> > +
> > +	pmx->functions[selector].groups =3D
> > +		devm_kcalloc(pmx->dev, *num_groups,
> > +			     sizeof(*pmx->functions[selector].groups),
> > +			     GFP_KERNEL);
> > +	if (!pmx->functions[selector].groups)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < *num_groups; i++) {
> > +		pmx->functions[selector].groups[i] =3D
> > +			pinctrl_scmi_get_group_name(pmx->pctldev,
> > +						    group_ids[i]);
> > +		if (!pmx->functions[selector].groups[i]) {
> > +			ret =3D -ENOMEM;
> > +			goto err_free;
> > +		}
> > +	}
> > +
> > +	*groups =3D (const char * const *)pmx->functions[selector].groups;
> > +
> > +	return 0;
> > +
> > +err_free:
> > +	devm_kfree(pmx->dev, pmx->functions[selector].groups);
> > +
> > +	return ret;
> > +}


