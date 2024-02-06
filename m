Return-Path: <linux-kernel+bounces-54358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD984AE29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FC3285AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8947F47F;
	Tue,  6 Feb 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HITDulDh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551F77F12;
	Tue,  6 Feb 2024 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198639; cv=fail; b=oVMnXsKP1XXwOhG2qYeVOtdCBdFqfe3k67tbWPt6rm68MeiW46HCDTkEpaWXQbMtrBrfRkVgFjKXUtF8M9BrVip+q7QvfOUSKrRKBcRzzvusgpyZz5623hFXxP65ZuUolmTL98mF1ycJA9L+S427isVj8mKDUpSKojblAdj4wEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198639; c=relaxed/simple;
	bh=hMPGh2TmVGvYcpcGrKGa0gKbQKzHa16Lmqq+HEPcZ9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tn8DgUNMvz/p62W1G+mfv1KCJy3DM0lZiJAuKqyLcySgBkJUkUZk3vlt1JRefp0R1fPLMXqQFsG66tGvD6rXnqW6rBSA0ExTZj7Y58R+wn1luVx+epJufKTGS0qq3thi/qnnWx5ROt14k1bvqtKZKQabjlybKR5bEDBUuAO8MR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HITDulDh; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZd4j4iLsgGdKNmOGO1JPQ/KM3TTO2J/oZYPoXitqT25E4XdwyGklxZKVVcRNq78POSwhFe4PhMRVh6zUbCG0pzKsz9DOgou+jr15C2W1OXTLMAqD8WnFOZG8vKcKG8DcVG6X9qtrEM8OFD3kyFGStOvYUXBiGrPjzPPi1xtEsCGB3ouk1C+pK5KB1kBvLKYqO4/Sno/ltuLPlcvJXcXBhHcUdozK8HJZmrylO99jrAocJYa+TxDdOx80MzzdZV0jm60GdH6gBol5Y3G2rsdF0WsRw5rLa3SFPDNfqzhDMYCRWNpB8DCSi0/TtaqEmVkFEA/UfaC/iowQ7qxRQOUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HmSOA9QXnrOZ31kw3UPynyhq7Y5ryOR5jvMSo+wP60=;
 b=PiQ2/SLua5d/R2KtdcfExpU1fla59DM3a7/DYjDsQ24aJqQ5LZg+fLCRKiQzMV3yS+UwBnI8EXts970sWNPR7d2Z4aEzbvzprsKeo3xJVeff+DYLkXcywf5sWtHta/lhd/aPFp3OBQMkcAOXujcZIn7dR8Q71S0zM9sqshKq2cTjWAa3OLARI96iM3Wc7WDGXx9q+T7Iad/4x3Z1IrzwXVXauVcql3xX/JK+XyUs2e7B59rhqI/vdb9GvzQKyFNQYBPCQtIvUWPwe1SJ1a+gpPRkFFj/CosFP1seXlAahPjFt9WIzhf3mLYUCqykvP4T8YZmYFKEfpAHSyRO4PFsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HmSOA9QXnrOZ31kw3UPynyhq7Y5ryOR5jvMSo+wP60=;
 b=HITDulDh5MaziPZNUevgnZh/HMxxMJTHibSFdASeQJyI834AOtabZ0gXeNzBDJ+NSWa+vMbZgA0/vu94oEwpBJIt4s5fviGDp+Xr6h1DU3cHhM3lmE2Re6qvydwCinIDt5CctQLeSBYt5Ws+ZMU0twxPl3A4JLFamHke5lV9+USG6na+AKCTE6RxdqdZbqlJSXGBiPbe/JlroeW6/6l1FyYKm9fzHSCvWLjsWjueQe56LS42lHcekBGt4111iSt3y+4UENAJnoFqpIF9T4kBYzAoPk2mazyySmAIyxUcl0rvzCEH1eQ2/RtVb9qG97o2TPUU03N+eL0M6FGdGNfE8Q==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 05:50:35 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::f013:4a74:215f:1127]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::f013:4a74:215f:1127%5]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 05:50:33 +0000
From: Akhil R <akhilrajeev@nvidia.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "davem@davemloft.net" <davem@davemloft.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [PATCH v4 3/5] crypto: tegra: Add Tegra Security Engine driver
Thread-Topic: [PATCH v4 3/5] crypto: tegra: Add Tegra Security Engine driver
Thread-Index: AQHaTqDynERkn6GX3k+4bkJs49N3a7D2234AgARfRgA=
Date: Tue, 6 Feb 2024 05:50:33 +0000
Message-ID:
 <SJ1PR12MB6339E195387767AC3BE74F0EC0462@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
 <20240124083846.46487-4-akhilrajeev@nvidia.com>
 <Zby5bLEgz/UktarE@gondor.apana.org.au>
In-Reply-To: <Zby5bLEgz/UktarE@gondor.apana.org.au>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|BY5PR12MB5511:EE_
x-ms-office365-filtering-correlation-id: 6ca41358-5c81-464d-c502-08dc26d78911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u8HBASLAeHAgCxKcetOZaNvWho0XwaRljd0VC3PiYNUytBQVxMGeQBcTgik4zBmJ6qwp6RFfkcTgFPLZHGQ+rdDH/AT4kpSLGnSR9B5O+/Uh9Fyz9jboQY5yLlJu+8F9lNb0y1ML7RzVZS1ahLUWn2Du4Ph6l6SZyn7mhlk6ogy7zYmDYe+Ibv+EqAKaCLxGwN2nEqrrQloJhPhn38qtM3nXTguNzUXvNi8AFk1BTS01GYNt6XZoF9g8UbN0BMfvHlG5T1gEKW1oudxNkjx/JvgApzgQUQIUqve0MvPWpPSYDf6RjLGLGWcNAr4nm3dQBu7hv02rOkZ/UrDbchhv4DsJeHeJ/QASj+g3KAb9W5KexTzPREtLRcKHXvIUgYZqNpwnfTOdmbCwSwlsoyjVq3tnxZne9GMeaWwTbjMEpaxGR3dKkBjRlNZW0PUreSbAbRO71wH2WzxEtiO8V1ZS/2PWn6kXRKbY2es1xn5KxgaeGHGvigHQHIlt7DemF96HBjnAzKMnAOaaQidcoQZzIn3KcLT1/DqhXDKfbkSEYm09WU4dO3TUM0AQFyDLcC77f/7OWyhwuZx4405oaXLjqD+gyMUL3zXSNTUPaZVaBbRFvJ60b7Gd01tUYmbCyJKJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(83380400001)(66556008)(26005)(4326008)(6916009)(7416002)(122000001)(76116006)(38100700002)(8676002)(8936002)(54906003)(66446008)(7696005)(64756008)(15650500001)(66946007)(6506007)(66476007)(316002)(71200400001)(2906002)(5660300002)(52536014)(9686003)(478600001)(38070700009)(33656002)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m+G2dmR5jWeivSdFpWGHV1b/dgv7N1qgs5Th/rb5LQaVA2cDzA8UP2/qy+XX?=
 =?us-ascii?Q?x+7L0ujX102EgZ7TCJwHjOIRpqTRU0Hx3sd9Qyg3S1kVI8c9zVPyohS6H09k?=
 =?us-ascii?Q?KPLcY28NtF1lJn/qG1m6EiV9m6HHEc4ws6glwXxxDQAmlSgAylrONYyC3Wbc?=
 =?us-ascii?Q?YWqLke6SzV6Y/Z5yiRtlhDh37deyO+DksmaFql3GERFHe1Vdo7RMcRq3lHYB?=
 =?us-ascii?Q?sLnT9dvKNgX+p2CXi/VrvouzoXZiyfpitr+0CeyU5ZocF6mdiK/5l/x8Bigf?=
 =?us-ascii?Q?9Bc5JAONMKLMJ7G0I37zMDfVCGLwySrNwa6sJa3PEiogTK7GWarMkVJbRJDr?=
 =?us-ascii?Q?mqqFymvrYS9ACA7JGuzZDz12Dd5+6W7evQGD9OtG29ED4Y/zzduA/qHJvBtt?=
 =?us-ascii?Q?QYwiNMgcL64jcyU2yBo7p/QZK4EHOPmDPDHsr55dAL5TWrHC5WYknn/eaRMz?=
 =?us-ascii?Q?gHSx/vsRqosjzEYwu7FCBhin+lhVgN/zAsOgKT6+GE9G6Q011f3PrJcgfMyG?=
 =?us-ascii?Q?iO1EIQ+UzANsJ2AttXBcC+7KQ20mM5H9GVcYsG/ewjHyZ7lwAPTaOzQw+KZ0?=
 =?us-ascii?Q?Nk0ztCBtyXWkiyJNVW30i0WlSM36wgw+m9wzErp6NiDzSM+b0aQZAC2Fm7Us?=
 =?us-ascii?Q?hx8H4esjGUrCT/nJIa6mnDqbW2b329aESYdfgs94QG1qfUMpPHp7AZf4oEfA?=
 =?us-ascii?Q?IQW3zFwfp9BYfLHMXqPERLK74sWdb12YLLRCRiMzPSWRmDTYZcXl8FUKIBg3?=
 =?us-ascii?Q?LX4R1R5mY10Csw7v2dMMz2fxZNXxh6zUqrMBe7h6rfxsCQn0JbXHXBayE6b2?=
 =?us-ascii?Q?dYGKeongUh8bWJKygW8dPAzbFvpgkQW10r1hR4X9DJmO7trQWhXnXbq4AE9S?=
 =?us-ascii?Q?G8CvC+h6fqy/gUX3YQLn9IKz4IILJFWWqoNlGfdNqxK1EPAG+8EXkeGPj6tC?=
 =?us-ascii?Q?kCbq6YwazbWXqUL0hS/h408gPka2yR3Y7XiNYcNdgWqLtAwJ+MapxWIwpC03?=
 =?us-ascii?Q?l4/D0+YqjlHtGdlvMuAh/7MNwQ/gHCfPYQDh4OFZxN4hVB0HSAlw8bvsRYoc?=
 =?us-ascii?Q?WzeystSio5A/S4G6FuZkslrmXun2CTqNobwPnXNqxvjFyKRiLsI1nWpBVbgY?=
 =?us-ascii?Q?wej6uWjQWUwPnjnrFo4slZmCm/9hDITt7HiiCfAnjcjjfM5rDdmTAn/Ssi8q?=
 =?us-ascii?Q?eraOO7YB2rfIXaaEZ8i9GkpTf/l9+wtV2ggWHQr7NmAF4JSnOkKp0BYTlLz0?=
 =?us-ascii?Q?GvNZJPhomFsRoc+GtW9HTBdjWqCGXyN7lythCdAGU5nqKv+VmcyLqytnp/Hl?=
 =?us-ascii?Q?Cp6tkwVoNlfb/UF3OKhy9gnZKcUPtVL56jwHFzdQelDTic80+DMihQppEkLm?=
 =?us-ascii?Q?E3BLV1E44PDLrq1/apUNDvii+6xhprsQFTpOB8uzh1Ny836AGKO+AA/4zKaQ?=
 =?us-ascii?Q?yQ8fPmPU2x43j6Cf9r+ZOl7mwC+1S8LZn/9PoWpBKGSbUIlPqUOPOSZe7jTV?=
 =?us-ascii?Q?0heTDW8b3WgtBBcSJHDlgK0hMeLudgE51vGA0r151nEB6snTVunwrN2TwAYi?=
 =?us-ascii?Q?ZrOmCbALdjVvqCieD69xpOwKYbEI/D2gZoS0c61W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca41358-5c81-464d-c502-08dc26d78911
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 05:50:33.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74NTKW/unE8cahq98gv/KuE1e4Rd9ZTnbhsBBkcTqzp/OFoWOtwthd+uvFBQjoreDfsAazL9rBDNOG/8HbNfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511

> On Wed, Jan 24, 2024 at 02:08:44PM +0530, Akhil R wrote:
> >
> > +static void tegra_sha_init_fallback(struct tegra_sha_ctx *ctx, const c=
har
> *algname)
> > +{
> > +     ctx->fallback_tfm =3D crypto_alloc_ahash(algname, 0, CRYPTO_ALG_A=
SYNC |
> > +                                             CRYPTO_ALG_NEED_FALLBACK)=
;
> > +
> > +     if (IS_ERR(ctx->fallback_tfm)) {
> > +             dev_warn(ctx->se->dev, "failed to allocate fallback for %=
s %ld\n",
> > +                      algname, PTR_ERR(ctx->fallback_tfm));
> > +             ctx->fallback_tfm =3D NULL;
> > +     }
> > +}
>=20
> This should check that the fallback state size is smaller than
> that of tegra.  As otherwise the fallback export/import will break.

Okay. Got it. Will update.
=20
> > +static int tegra_sha_import(struct ahash_request *req, const void *in)
> > +{
> > +     struct tegra_sha_reqctx *rctx =3D ahash_request_ctx(req);
> > +     struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
> > +     struct tegra_sha_ctx *ctx =3D crypto_ahash_ctx(tfm);
> > +     int i;
> > +
> > +     if (ctx->fallback)
> > +             return tegra_sha_fallback_import(req, in);
> > +
> > +     memcpy(rctx, in, sizeof(*rctx));
> > +
> > +     /* Paste all intermediate results */
> > +     for (i =3D 0; i < HASH_RESULT_REG_COUNT; i++)
> > +             writel(rctx->result[i],
> > +                    ctx->se->base + ctx->se->hw->regs->result + (i * 4=
));
>=20
> What happens when multiple requests of the same tfm import at
> the same time?  Normally we don't actually touch the hardware
> in the import function.  Instead, all the hard work happens at
> the end of the update function, which moves hardware state into
> the request object.
>=20
> The import/export function then simply copies the request object
> state to the in/out buffer.

Understood the issue. But I feel it will be a bit overburden for the update=
()
to copy/paste these for every call. Let me explore more on the hardware and
come back with a better approach.

Thanks for the comments.

Regards,
Akhil


