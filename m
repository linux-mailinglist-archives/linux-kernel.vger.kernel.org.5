Return-Path: <linux-kernel+bounces-54365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E884AE42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAAF1F25D40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020EE83CA1;
	Tue,  6 Feb 2024 05:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+bGEitb"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704467F470;
	Tue,  6 Feb 2024 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199126; cv=fail; b=om4v8hV8zV3Vm/TKWIk2ujqZWVlycWL/ySzCMDGHQTC+EbeR/SrZPC4hrLqA6pnci8d8i1/iPbli50YBZU2QCYUdtSDI0ncJck9Wx21va6NA2Xobq2Hqs2mky79rMvf2hnnqh/7s4788CWkEUOdrCPERTeH8PWJYDFVjE6msPr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199126; c=relaxed/simple;
	bh=a4XE/+ohTj6ptBciDHwsbBvYCAOb8zQwuXhyq5DXysA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/wTrA1mr4IL851GKkj4kcms+3mliYp01qz9kjwNUlb47MLs/6sNdR4EVfpYxZLjmqzVJ+IDyfj1DXM+UjKQrLXRRnKQdtZPdXBl6dVWz9tqysKiDPCeEoqYWu9TU+Gc+nY1wSpmS/yVJwAkQorSQsDNR9Xp9cZ9pJlZ1s5hZZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q+bGEitb; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=araANSqI0/BB1iS6UHpXklMFpajfBYGaYkQdkyOlE9gFMbZKf4xPZl+9/jC+R+AoLQDNKcgPpGAMbAdw6RZqXNooxU0nHg12JbFl3qJty3k3qrGu08BzEA+n8/Jr5Am7MD7fgiOovwq0vIfY7x7mro8rw62EC4lwbrRwORIYbS1amrL6Di8OZSPnmoHcN8+8gAbIL2nMBX6iJiSPY4c6ho/qvKlWjK6AhLhmKLo9gJoIz1gXzc4+/HtYYnKRx8eZOTQ0hyQnHxq2HG8jmkqC99g5gFKTnvt8VfCJsmNwsnqAi8KDhtkCMbSTDGTx4fUf14hu0saDVdQbxL56jUjxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4XE/+ohTj6ptBciDHwsbBvYCAOb8zQwuXhyq5DXysA=;
 b=mnZQ0opDDpNUCWcaudRAb6n6tGYoyrqflOIpqT3HMb3LCoHpA2AfK1XkAwn5uGkVlE4hKbn9/n07xeH5G1AKERwLoKHwIx3tXfekdLX6EqSMYDFFsgn99tOqvx1OiPTjmTTN+2d2sLejvWfdATKhliRRqSidjpMHtAkTL0inPoSZ5ShgZrxXrCHcvJP5zek9MAIXu0F6MyKvSxjQUVhn7Ay67Zp+BRzfuLoiZqcPgl5umj1lz9j02rrYdXBFHs4mK1FNRYYdVX2WCjVB4Zi/hJK0wR2Szh0zv7Z3e8jlnOlOzGlslFMR1HQ4mks7b2EGnrk1HFxhDfZF3S9qKceoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4XE/+ohTj6ptBciDHwsbBvYCAOb8zQwuXhyq5DXysA=;
 b=q+bGEitbEzbhs+QwEtPakhxGQsFbzTdRsRQzkReDlS2UREiTd0S7jwPZSBrjNSX+2Gan95o/hjFGUCra0oSr5sPbq5fOV6sUVMIMXfn6P/oeu5xIbcMMRnKzwhEgZ6Y4QDxrogI06od1TFFY1aFP0/FJeKfFZwL6fhNDlZJVIkEDeErBewR9acm585AFY/15lgpEBy628cvtbVqzW40Ze1xreMUQbaoPBVIipf0tVKimkNIq/7lrFLI/u75lyOYsydpwPbUP84wpNy31y+FmuowH9BgYSuiXvwFkU+J/GUJqz2vc3lCH7JpQX+PYfkmL3QHq8Qg6yLyBdi0iPNYBTg==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Tue, 6 Feb
 2024 05:58:40 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::f013:4a74:215f:1127]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::f013:4a74:215f:1127%5]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 05:58:39 +0000
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
Thread-Index: AQHaTqDynERkn6GX3k+4bkJs49N3a7D2234AgARfRgCAAansAIAAAOXQ
Date: Tue, 6 Feb 2024 05:58:39 +0000
Message-ID:
 <SJ1PR12MB6339C06934AE01A937612281C0462@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20240124083846.46487-1-akhilrajeev@nvidia.com>
 <20240124083846.46487-4-akhilrajeev@nvidia.com>
 <Zby5bLEgz/UktarE@gondor.apana.org.au>
 <SJ1PR12MB6339E195387767AC3BE74F0EC0462@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <ZcHJoJxe+2gsfIaT@gondor.apana.org.au>
In-Reply-To: <ZcHJoJxe+2gsfIaT@gondor.apana.org.au>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|IA1PR12MB6236:EE_
x-ms-office365-filtering-correlation-id: ff48dcd6-bfaf-42d1-3b7f-08dc26d8aab4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6X0UH7+5S+S9/xrJwZRqMejxaS71BeFzznOUct9cVkTlcf9dI6Xnkvp89WNqUTlkAgxa5j3Fbh75jOWp4Yb4L1bShnetRjrvwlAvQITvwH9atyAthyihViyhqxQrVBxH1pQ9E3r149ntPF5A56qFEE7RopSfJTQWZsTsars/CUemBs7gZEIHXFxVQG3DL2SbmbrlPabzGCWIKCtC6xtL3rLgkMSVK2AnVTnHbqN/sp19Yu4rEbX8Jtd33AeOJFZ4fYdn96cJpcbJclPajS4jnXkfnZiI7J+9G7/bzRLTbfkNqtsSKQg4DIsDs7+5nHMCjsHJ1V3WAYS3u6CxsCHYDqZVF766WR/2GuVqOL0g5HwAlVkyyzXhxq4Q4s9UF4Z6LTyimeg96U8dz9ayr3dGMhCEmFwv2N159vRc2z/J3/oON2PEMduqsl48v0pokKHPmW4MeaVrdN37hJKXiRxxTJ7AfopUKTtkFwFWLOXm0/jgH/BMqDwsdk7oZkFlPvXuXD3OtfrnF53/lWrSVreTZGkQG9H2Ab9JZk3GhYneT40tFupjjWgc0rqlQwVif9nyb0dMTbOoUhLLweoaJ4xgpxpreTXNwUDvIkRmmFuGNZvUFi2bzawcHRbeynF9BihW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(83380400001)(26005)(86362001)(33656002)(41300700001)(38070700009)(66556008)(4326008)(5660300002)(38100700002)(2906002)(4744005)(66476007)(9686003)(54906003)(8676002)(122000001)(478600001)(7696005)(8936002)(7416002)(66946007)(52536014)(316002)(71200400001)(76116006)(15650500001)(6916009)(64756008)(6506007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D/eaoqWUJxBzdJEqoPsEbjFFFbD1nw2dQ5VSVkKyAm5UPrCGeiboV1298cG0?=
 =?us-ascii?Q?O3tqWso6KErmXeZ9ZijbepUTkUKuu9TeOYHQu4bmq1Va4Rq11STAa2N5LYp7?=
 =?us-ascii?Q?4BwZJzrV6Z5bVqzOWCkO/rv9xfWiBKOZP4NUhb3OcqP61TVeBBqJZhMWDFYD?=
 =?us-ascii?Q?ZljnC4GGO9H0coz+N6vMYTtDZv4h1i7UKWk6z2vskmsLH9v00ZDMT7orfndB?=
 =?us-ascii?Q?14IOihtH3/x5T8XCMRcL2g3Po6xQX1XuIAzDoG6/aJu6MGMD+cFL9lTg9wpK?=
 =?us-ascii?Q?qHCXAxxvgAwqyOLocQ4aVgELSzp9gE+4Y7OuMxCqMqHD9ik7BcUm1zILpt1P?=
 =?us-ascii?Q?OH1ox/JSl6TjYTHuNzY0Km7YweXXyJnv0aTbGtdutE+WGcfw1zxrwtmEnOQI?=
 =?us-ascii?Q?oYqNeXKBkQpdKDu6sEbU5Zak5qqZt9dul6h0qmTNwITDxccPfnHzkbOxig1z?=
 =?us-ascii?Q?vWfNHFjMFbSCpiACNlvAu4gvIexVZP3xL7FkharTzD10CUNhgspr7IuMo4rX?=
 =?us-ascii?Q?EwVzGtzrqReCIhEX7E5IH74FjnXsJgzhU8IgsvqVFQfXWhHQTF7e2nhX8p3F?=
 =?us-ascii?Q?P/6IrZxgTAs3GpfIyEDerHZzPF86DRCJimkUZARoUbpBM48FDx9pzGgBBWag?=
 =?us-ascii?Q?iFkPkcCYN6LwxOH/8+3JPbWGhTvUQA//o90lJLy++31eUOaLzqFYSv2ow76G?=
 =?us-ascii?Q?YYxsQQDsBF7/uxOt47dYeUp3+2bPlRXRqYTJP2Q8hFih1lHqPy0HtB6h8Dl+?=
 =?us-ascii?Q?RVBhJ+K7dnrZuVOcWWduNlRGAge80h8L62XKXSNA6r8Dhp7/ega9zTiIgs1Q?=
 =?us-ascii?Q?C2MD/E23bzJ677cYPHgum/s3UFlcHpb1AORMaAq61X1xU0rJsPkLm0wm6gwA?=
 =?us-ascii?Q?if20WufN1zFFc9eqZtNkRX4EPoE99NwTTG7SMVNzF5GivkXNhqCuOslmOHb3?=
 =?us-ascii?Q?+wJwd5ZplGsAK9IbTArl80r4MnyODB/OKlgjTlbzo5goZFux+iJHBfdX1Nqw?=
 =?us-ascii?Q?cL2UBAwdZgaDd5cdPATJy5ehIn5AhH2icOuExuNpl0NreXeyUrvtCtNcf+iG?=
 =?us-ascii?Q?uU9bMqjHMGUH5z3fhIhSwovGCw0IPSlPiZLV8GwjKfSl6ByFM+sNXFeA9OdF?=
 =?us-ascii?Q?IgNqFHCyquSy2D2NARjiGeHfT2RdpIqC7rUnaa/O7PS7Ejbb1xZcweAAHYJh?=
 =?us-ascii?Q?bdBUdHG2AwH0dadrvfQmRFfDhbNcr+3vfsVLFDt/ErSuq6gZP6shQMd3qN8w?=
 =?us-ascii?Q?LikK/qbp6FGQ70V/GrGq2O5Q5H+wZXrpowak61Jq1GoR1yK/y7PXkOIFc3LT?=
 =?us-ascii?Q?3hmJXwzhjqxKoqsO9cPwEHLz4D6XmpCWV+1S0gcOrPrIm3tB1ErCQgDHrLt9?=
 =?us-ascii?Q?ogZPdWD8j7U3oYHfjb8FsfRRHGLieGICZHRswKvZStSNxubza+8gyonf9ZZF?=
 =?us-ascii?Q?ap8ALCy79VcQfazTm5JmJ4qH28OQ+rKgu6HIy3E2BME0v9ZQBL3l3fzNfqvn?=
 =?us-ascii?Q?Wypz6x3/foehjbCGquAAs5T4dCUYjP0mybAu0/I710ZREyaxV95A1onSLDCH?=
 =?us-ascii?Q?fNzWTXlLBFw2QEMyjPF8+VvpLSjmAsaQUdUsilZz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff48dcd6-bfaf-42d1-3b7f-08dc26d8aab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 05:58:39.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ss9ZD/0CqJrzhfk64FBILbqZOEoLPefRh4fqfoxqECz8ATprVgjTDRbWRaquKVGeXS76sGLrmfxa7pqKNgPpBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

> On Tue, Feb 06, 2024 at 05:50:33AM +0000, Akhil R wrote:
> >
> > Understood the issue. But I feel it will be a bit overburden for the up=
date()
> > to copy/paste these for every call. Let me explore more on the hardware=
 and
> > come back with a better approach.
>=20
> Of course it's a burden to copy it in and out on every update,
> that is why we generally use digest and finup instead of update.
>=20
> As a driver you don't need to worry about this cost.
>=20

Hmm. Makes sense. Thanks. Will update and post a new version.

Regards,
Akhil

