Return-Path: <linux-kernel+bounces-52503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FA1849911
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A9FB27CB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D49199BC;
	Mon,  5 Feb 2024 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XeIR/JGK"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0518EAD;
	Mon,  5 Feb 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133347; cv=fail; b=H2jdOSaSa4x9KFDFC/nSs+6yMCJmqgOOkviMPUc2YYvo1geat9ZzdrWUaD/hbW548yhrKgoRB96tGvcFP6zyG9VjagAXJz9MmvXPz2PB5dyc9hBR0G8j/53BpGFzOrduxyL7AT+HtxjkCI0p5LqZ76AQMBfkIAjqHHuyFO4fA7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133347; c=relaxed/simple;
	bh=FCaCHWBzd1/Eo2gs9bLrPzOLRTdSVTtDPKgZjGV2QTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lFFRdBji0pE0BomFTDGb1QDORH21AvssFi9FwsFcLhui9qEiVlmhN+Ugy0olBwl4ylKCb3tA8zdsVpDUQhn4ukQsR1sukUMlpOFTx2FnsEHoYK+gFxOL2PRALggDOtbhFtzKMc2aext9i4T5p57QEudgd9V4kxCQWaQGUMvOYGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XeIR/JGK; arc=fail smtp.client-ip=40.107.8.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnYotPLB+VbUXHsCZq72l8sWiOiKdzm4r3t4WB48ufNviMN80iqlv9/Bqp7ZJAlPL/iAmby1nMf448dv2X+e/qUVkrpVcmvwdW6ZxaUeRf3cug3sipzHDdmOyUN9L2h0qg1YTG9ELwpGlrqWykFHwGQ8JtmYJCfLToER8KNbjCygTq+O6ksngroqZkpk5XPUqZCeWViYtMR2QmRPUAL2u6FBiKpyjfovhVkblqPYewUa85380vMI3s2d0Sq2sTUAWAi79/plAaEbHuP2mR5p1hQuCpV4zcby0SJjfqbX6KPuu/Ze+QRJKNjtw7Hvq+UKrFJIo8lxtjsAkmpgfkardQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlDRYAB7a97sQgm0cZzC/1d9DHcC5zY1AVEL+TemQU8=;
 b=Wd4rnBX1ug7qpXGMzMoomcQiJRTd5oDXDQRLncxcBsNRrSO4TaVfmoFR5UhopRG7Pc/iM+/k5LwXWXHC8JgJKiAzAa6JyQekj7mczpXqIWhrpAF6sZQTwTwIcOP0vcIYGBn5J3CHYL/X+EptTJf41/+CYp3H5554rjeb7gQs0VScMnlQcThv/mTEEYOnhjO7UY/XV7dGXeZoMzL0OG10+rveuEUi1Q8RTh1nPeHXt5A3ZmHQmrdrljklzSPktyC/so5AaxLZEn9NhBWSePOXTqrEBEwZBkCww5xCkWRwwNJgwdzZ7uXEZhZEgdFtPJxlUeEaNvdccjU+yTrRSJYAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlDRYAB7a97sQgm0cZzC/1d9DHcC5zY1AVEL+TemQU8=;
 b=XeIR/JGKZVwaMhu8v25jQmM+qGaR1Ly0gfuKW+jL9NJt5OHYyvjAgMaU7LpK0oKKpBJQJOv6OIk6T6zGercVsk2wNORr0vDYNWxTtA6fo0gTn01d/sfbH5uftLiucUd1/Owi6/ZnRUI9BC0j6BOpX8TQMv4Hp4zHp2AMmyNJwxQ=
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com (2603:10a6:6:5::31) by
 PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 11:42:21 +0000
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::530c:5815:14e4:2c7c]) by DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::530c:5815:14e4:2c7c%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 11:42:20 +0000
From: Kshitiz Varshney <kshitiz.varshney@nxp.com>
To: Shawn Guo <shawn.gsc@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Varun Sethi <V.Sethi@nxp.com>, Gaurav Jain
	<gaurav.jain@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Sahil Malhotra
	<sahil.malhotra@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Meenakshi
 Aggarwal <meenakshi.aggarwal@nxp.com>, Rahul Kumar Yadav
	<rahulkumar.yadav@nxp.com>, Nikhil Singla <nikhil.singla@nxp.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4,
 polyval, xctr cipher test support
Thread-Topic: [EXT] Re: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4,
 polyval, xctr cipher test support
Thread-Index: AQHaMzkv0uKPr9fQ6U+/vbkIUpb10rD48jOAgAL3fjA=
Date: Mon, 5 Feb 2024 11:42:19 +0000
Message-ID:
 <DB6PR04MB3190048410A18A231D5B7FC08F472@DB6PR04MB3190.eurprd04.prod.outlook.com>
References: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>
 <20240203142149.GI463595@dragon>
In-Reply-To: <20240203142149.GI463595@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR04MB3190:EE_|PAXPR04MB8909:EE_
x-ms-office365-filtering-correlation-id: 845643ff-d733-4026-8136-08dc263f82da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YA5z1aN3eVLnMKeeP9x475eLYg+/GVJ+Xg4xuzp0fTtyZTJgejZyOx4R+mP9USH8sKFG9Ebz8YcbJA9IFbJvp+9IBZ5JG19801cm0O8wldRVFD4qo47kNdSqnTmeNX62oCzYJ8ivRz4UPztmlrMmZK3lEOLukutfJvbXGpE9qJfjf+JxembwaoxizOZDbeqWpXZfpKAngU1PocODQs/So/MlkjhlDk9hrP9tkcK0LJiCQF7wgcRbwQSfvL8cbkXpBY3Skb1+s+Nx9AlYTlJTZzHmsf5Zxa4gP/9LzXAEw2cEoJCvYDr4HnpanoIlUSJ7dN54fo051l+0dpvUmtKR3AunaP9auABL12kpkKx0LXBmaHS1kGbsCafpc5N4uE2dn42HB0SC72G9vH2m/7p7rkhq0ekFQLKY1p4WOBjiBKARrI4n2U2Y0M/5kQuVscbiDbqKKsvGDaqZun2yGQiFKVB765X4eUrVqjgSuvhPuwy3CjEHToZA+VgNcRp3YIHTxtvpEQVJ4IkPP0PjplJAAq/9UxmUJAckmEH1Gudg0UlkkqAeWKejQ5mfb8MLYWdLh283mORTzZoRHYk8PUX5upqikTW+4N7yCEiTF6HdBpEtrMCtZhPHBavQ0bHi4/mS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3190.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(55016003)(33656002)(86362001)(71200400001)(26005)(2906002)(7696005)(6506007)(9686003)(55236004)(53546011)(44832011)(41300700001)(38070700009)(83380400001)(5660300002)(66476007)(66946007)(316002)(64756008)(54906003)(478600001)(66556008)(66446008)(52536014)(76116006)(6916009)(122000001)(8936002)(38100700002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h3jHklNUv+Evk5YzOeKif6LhPwYVIY+1fppeZU8F5l+M1lrzyN2DcN3g5I8m?=
 =?us-ascii?Q?FU29OIlrGcELybQkxRW+arh6/fwVQ1uKvGknUTVT9m0g7GHrCslDFHgX2nv/?=
 =?us-ascii?Q?rixcrhGoE95Cjp22HPP1GF8e9scwTspUNDDN+x36G3lOvx4dTEfvwB+38XvY?=
 =?us-ascii?Q?6zVbsn3HKg6vkKjiph4viez+6VPMPqQLgDqqAMJ5qreLESJCizcdGCHyS1tm?=
 =?us-ascii?Q?m4LpTVMqKnWp1X9wTSLH8l5WAU1R0s10r8kRYj6IcZ2YDqqz8wjwbDD7iGY7?=
 =?us-ascii?Q?KdTh0gHcTyhfT0co/GDOQDs2rIerzFZRSh87Bsp+Ub3t/5j2QQMG/7CkeELK?=
 =?us-ascii?Q?AAnyIASYdZbfdzN5Qp3FBWGb5o8cKPMbQy3HXWojukL8NEuqVhFJK9EP3E07?=
 =?us-ascii?Q?rePLu0AXAzE+O4gJnH2jlC5JO/UmRw1udbKXNRdZgf7ZtR1xGxY60I0Eapwt?=
 =?us-ascii?Q?No0Rt9nlX4LXUZdV6/5uwjeUnWS47WysSAM3qx885fR0Off1nl5mzZPvlUGV?=
 =?us-ascii?Q?89rEWc6oojTpJAH0T4wUtynr+HcWv/r9bMaYz8TSOk1R+aQkde3K4wRFD7kC?=
 =?us-ascii?Q?6nh5da+rrnje583GhQ3xUjG1JOX0kZXqclqGyLI62tIAyeLoCp3Kh0t4PzbC?=
 =?us-ascii?Q?CU7GbESSlelPRM4zWGQozR9rosQ5K0hhGhi+rDw0vhPF6CR8sutefGcEZ6O+?=
 =?us-ascii?Q?yoFB7mMrdI9JoSr4oTT6klO/e5qJ4PSj2VvmuS+C/UJHFwMSb2hNXFLBalBO?=
 =?us-ascii?Q?cVCP1ISOR/P0bSstBRAFWivd4RUsoNWyew73/1xOA1m9PUIVFHf+N2mMwtfK?=
 =?us-ascii?Q?3RJPtV0CfWxhq+XzIuaAB8SlWxuvZsT7tL9SJAIEteUazVHEJ/TphWMAQAxk?=
 =?us-ascii?Q?EEn7MM09g05eERPv5UnqmTrVnHj1rFjDF/kIiu4fraQx/N46MOT73RVHT8/m?=
 =?us-ascii?Q?QddddEzSx4OdBfZVIdwIZKUCnpl6Raj1mu3eLdZOsrHekJCYLI751OvkMAFN?=
 =?us-ascii?Q?nKURN9OIE0AfFx9L37A6vQFf6u398GA3XrTWQiQAt+fahbmHQlDHrf0zHaWI?=
 =?us-ascii?Q?OmF5Uql1N3tSiE63hw43gZjbSL9g8mF8TtT8KQPssAzQwbzh+hdCfR+MhI4F?=
 =?us-ascii?Q?Tvl86ws3zfiaBJsJWa186yWpxoYkGaHW19qpmRBbnGlA2qbtQsb7zyWHdApm?=
 =?us-ascii?Q?jI3PdATT+Gq8mCU7q+4FFOPgXDa50vSOeRkbc6knfUroXQQXq7Extt1lwxoR?=
 =?us-ascii?Q?NzzWMZXv5ed1CEHtDTVxXbZQeE4++fmOav0HDEShns7VxDxcnnh81NSpfGib?=
 =?us-ascii?Q?hmhipYiZD4IyTpRRjgKaA+DZSbb5XjufWtszP+RRhgwnQGP+GGsOvmmHWfuh?=
 =?us-ascii?Q?4f/DgULqL8Q7Ur2CPlh9QgEbOdxpH6aUAoazUdrk1HVsZ2uj5A097Fmq9B5O?=
 =?us-ascii?Q?2M1nyemJc3z9LbmW+7sVKQCGVpSn9wgmYC3FugyDY0wWwNdjk+boqhff2vGF?=
 =?us-ascii?Q?1dMVpRM1c4ITUDME8qEwbSQREFbVcLdGxaH/cWAcyO+2bjVm+Fvu0CgeiKKU?=
 =?us-ascii?Q?Jslt8eT+vy1Dv9E8iEXlbGSxr9iO//Ncndyv9GlM?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3190.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845643ff-d733-4026-8136-08dc263f82da
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 11:42:19.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez5UGDmCOMFYcuvKIE+RvnZDfVmsKZiwblLxWJIMakEwLK//qm7MhNFlLT9e940xys/BXtQBnKfT+jYO47J8rYQBjBFjK3OieeO7Z8zBQhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8909



> -----Original Message-----
> From: Shawn Guo <shawn.gsc@gmail.com>
> Sent: Saturday, February 3, 2024 7:52 PM
> To: Kshitiz Varshney <kshitiz.varshney@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Fabio
> Estevam <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Varun Sethi
> <V.Sethi@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Sahil Malhotra <sahil.malhotra@nxp.com>;
> Vabhav Sharma <vabhav.sharma@nxp.com>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>; Rahul Kumar Yadav
> <rahulkumar.yadav@nxp.com>; Nikhil Singla <nikhil.singla@nxp.com>;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4,
> polyval, xctr cipher test support
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, Dec 20, 2023 at 12:38:57PM +0100, Kshitiz Varshney wrote:
> >     Enable config for sm3, sm4, polyval, xctr cipher test as built in m=
odule.
> >
> >     Issue:-
> >     Multiple crypto tests like sm3, sm4 xctr and polyval failing.
> >
> >     skcipher: failed to allocate transform for xctr(aes): -2
> >     alg: self-tests for xctr(aes) using xctr(aes) failed (rc=3D-2)
> >     alg: self-tests for sm3 using sm3 failed (rc=3D-2)
> >     tcrypt: failed to load transform for sm3: -2
> >     alg: hash: failed to allocate transform for polyval: -2
> >     alg: self-tests for polyval using polyval failed (rc=3D-2)
> >
> >     Resolution:-
> >     Enabling CONFIG_CRYPTO_SM3_GENERIC,
> CONFIG_CRYPTO_SM4_GENERIC,
> >     CONFIG_CRYPTO_HCTR2, CONFIG_CRYPTO_ARIA as module enables
> support of
> >     sm3, sm4, aria, polyval & xctr.
> >
> >     Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
>=20
> The commit log and Signed-off-by lines shouldn't have leading
> spaces/indent.=20
Checkpatch has not reported any such issues.
>=20
> > ---
> >  arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> > b/arch/arm/configs/imx_v6_v7_defconfig
> > index 0a90583f9f01..627f57da9d5b 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -484,3 +484,7 @@ CONFIG_DEBUG_FS=3Dy
> >  # CONFIG_SLUB_DEBUG is not set
> >  # CONFIG_SCHED_DEBUG is not set
> >  # CONFIG_FTRACE is not set
> > +CONFIG_CRYPTO_HCTR2=3Dm
> > +CONFIG_CRYPTO_SM3_GENERIC=3Dm
> > +CONFIG_CRYPTO_SM4_GENERIC=3Dm
> > +CONFIG_CRYPTO_ARIA=3Dm
>=20
> Instead of adding lines at the end of file, please use help from 'make
> savedefconfig' to get them appear at the correct places.
Changes done in v2.
>=20
> Shawn


