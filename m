Return-Path: <linux-kernel+bounces-86400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293CB86C4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9227B1F21694
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C485A0F2;
	Thu, 29 Feb 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OxyS9+Qe"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484425A0F0;
	Thu, 29 Feb 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198454; cv=fail; b=qR91wSoCEj8Hv7s//b4TIbYRN0Ex/vIAdwof7tFeGeRG0vMXUvmlePJGgC5XxXIzq0booYDlD44jR5e7u5/Gpju+XleOvw0sZON1vQnFhAwNqigkfklj5dIgbb64U9baLuF5vk1RtKUdnEycvAakcE5nv7k1gWu33TeO7HKKaRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198454; c=relaxed/simple;
	bh=kY2UIES310ZvF6Mm0t0Hix69oOyR/bbA2DpCswMY66g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNKC6UcKeNuRBrPVxc7G+RhHJWDLJSFSzR+Fa0iiQcDGh76n6POgSwet2ptLEAto3Q3z4NGJ/GA8H0Bx5E5aAc3JgPQB/3dEq7jJvhy8MbnrvzfiRuMQ8FCTACGTOxM3f5VUk4I8HlFoVYuqFnkzS6MnEz00HiAAhm1uomfiHNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OxyS9+Qe; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNtysqCaAMCCvtYeQ51kblGGxYk9JDfMOyAzQlvjJu1VD6idu1xrw2J12DXDlUMNYdy1tmnO3tbf+QocuM+v85WoYmi1YWp/taUW96WWOFBpIuQn7fkt8JsENTycDlX6KpoJZFn0HA5mCX8J1cRaH2uvZ06PdEl0pJEeVAva3Ta37D6kW00GKKb8FZBsxspZDSa2c384mD1tldqgCj4YR5zxTn3geSyOuiDtfN5S2NTxbUyKKYVqc/EuKLZ1ejXVAud+Qlx6CX/5griL4RshtZJOkwoh/P1tfsBRMcidaAOIUUbd3k4254wqO1IOMT8fTeVUhqZZI6IcycL+314sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIlhhS9ASpx8uEPo6Pqk+UZo7XP94EwBVt/NL1+LjPk=;
 b=N+lwUiKi0fPJ+fqPsPWbSHsS0w86ujq8fI/iso3cD5IU6xnRLpYdg1fr3vcGiOWRFk4DscoEPYX1lCcgNq5cXIEjFbHwfbqJBwhDzMbZ3auqmRzIPu364fWybRpkPYz08+Av+DSbgDrXkkRbgRmmRixXyXYsHBLL9Nab4f5NZJA4hFuqs5txodgJMZRop8ZKK5za4I2d9RCGMTnqFwzpU3BwivyFap6w54s/ss67vBmi1bS54TjCissk5ij8hBlG3bXrFsRfrm2wxHyqoe+hCxR8zEMEPGCdW6DqyVsEh/tvUB6RsfZppk+BNTE59YhrHWsx7W/0bqIOt+WEXrB/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIlhhS9ASpx8uEPo6Pqk+UZo7XP94EwBVt/NL1+LjPk=;
 b=OxyS9+QeQgJIs1+4ELN0Of7W3COlIiJjb3s04TpXwNmpIPMBP9b2QrfKW7dqIT7yJZ+85k2SKWGZfq35hOHe98qlIow2ajDLGTEJ8PqWEfMyw9HIfZ02moAJBy2guE0BvvqSNenYUBNQz76LxxNFNt4fZumiBcy8eiH2+gi0bGrxuGbsJh26HOI7kGGvXzs99mNoTUgh7gfjfPQzZ4e/QcSrbzpM4mdcbI/h0OWej8HrDj8HD33MYiuQzGUwDDYuVRfTBD/n1goh6pxqumlb6gU99QJu8dcAQ+sFbKqQtqxFGDu1/yepnsytTtpD99A6BZdvuUylRXo96Te3DLsoyw==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 09:20:48 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::ae74:c645:b13d:3d8c]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::ae74:c645:b13d:3d8c%7]) with mapi id 15.20.7316.012; Thu, 29 Feb 2024
 09:20:48 +0000
From: Akhil R <akhilrajeev@nvidia.com>
To: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [PATCH v5 3/5] crypto: tegra: Add Tegra Security Engine driver
Thread-Topic: [PATCH v5 3/5] crypto: tegra: Add Tegra Security Engine driver
Thread-Index: AQHaY1jZwFltH5yLb0OQSiEEFOMbgrEhGKTA
Date: Thu, 29 Feb 2024 09:20:48 +0000
Message-ID:
 <SJ1PR12MB63392983F30CA57CBCB69B93C05F2@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20240219172530.20517-1-akhilrajeev@nvidia.com>
 <20240219172530.20517-4-akhilrajeev@nvidia.com>
In-Reply-To: <20240219172530.20517-4-akhilrajeev@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|DM4PR12MB7501:EE_
x-ms-office365-filtering-correlation-id: a6119b04-104c-42f1-49f2-08dc3907b738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z2QwbO4o/yTf8XuEXaBfSH4xEvQi+4fO5SKb7YtxatJaKeprZHRZTdlcNTUbcFNMevoZ11hNqw1vlPcOlkiWvXwzt4WRqtzK8vBIDJJGDqM/4pr0XjnGA48UwUOTnJSBT7dPJBZeG8eC1Rp7rvOkTtg4q12rN9jlDmk+DSnQw7ozkIawndF1wiSv/wJO3CyLHhWnzYhA1yXIobIwMprET301RV0zdeckwlm8oVukLwhZHebrUWjV5JhPAOvaCpw92Uixl+WWHipQDLwe2mv47Q4ThesFpTY1jaevI5xPinT/bmbiX5ZQRcS21cHny7Zh2HyqQDWz7WsUSd2KynpBK3Il94I+e1vP2Q5HRcrrvXnlxZiTel8No8ORmOLP5JXuOVSYg6z1jZ3qG8kKRUXUF1ylV/sVSQAuZicqiCIJRrkhzOuSJGIm5XBV6GrdOAqG7OdLHvWwh8KrsCGUuHVxBeU1GODuG9ocbr+mki7EaO/71T/fnt4ZDD/nkb9my87y5xkXoHa/3MPxK+vGVbuy/QCOW7HctiM/kmfCAcTZ2WVwzDgkLotCt3up0Si4nLwVXmsmmufM5ItKlZQZ2syNaloTrN9Mc6ck1aEGK9jeC1/OWMjT/HaE778TyHueW3hOJduCkbRu/zUfLtjAi9W9Jd/QytSHDL1lnDoqgYLkdvXs6FeP3S6xy3dAGQPA30bPHw6OhCGeiLwqAYrn0omAhrSkenNNV/bbF6gVqJ6vzN4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NuJ4MohulrynnFKdJF/RTh9WxnoARwZ8UwSsBAQGOSuQBg+002hnIkIO97ni?=
 =?us-ascii?Q?ASICspQUiTcNJE106UtloZjR9rQiMYSag814pFGYswEZyac402777B5wVmbZ?=
 =?us-ascii?Q?zgVR1td7EpNTZkhS9Rf9LmPoScEu6OeFt1xMrS59AZfpSpoQ0Xt0J35doiq7?=
 =?us-ascii?Q?vd4kGR49g+QzNwdE9mv1xOvRqafCBYRfo1HdDrYBtMprnG2VHGGi22/iILWI?=
 =?us-ascii?Q?+O4c+FU39483wrw/ORsqkwKapC/hN7vA62PZlcJqctlO1ejY42sybkKyQM44?=
 =?us-ascii?Q?LQPUO6PzhERN+h7IHiJQqgYO+8ZRegWjSI5Y4SYkgZaWlSKqs+1gH8Mr5fCq?=
 =?us-ascii?Q?MapRXhXUQL8eLIOEE/9kQewWp8Fsf382T2eEX3dCCFzb4sGZ8tDlrabfjwu7?=
 =?us-ascii?Q?D8XCvq8tb3tXVMIOnuncsqZhM5OSFo0bH6IupP+AozY19E4Ugmvdux3EQ4iw?=
 =?us-ascii?Q?6Aukct+FAex+yulxKDWL6eHnKqMOMn24f/GgSs/DTSiokvXRFbbKvzgLodyu?=
 =?us-ascii?Q?+iwq7Nhywu76HxRh1f6xSSsf8WhN0m/ftqipzs6fJELVVIcmbvymrWoIt8HW?=
 =?us-ascii?Q?mVS3zqSRdJ97w3ONMUg+B1rFNviNbaAS5hdB3zwgzio2rSjR4gYrrQX67q8K?=
 =?us-ascii?Q?EXp3GRrpQqVHQ0wA6oLvZUajuqzYepUM8YQ71MYSkJhWxWrKWjalfbaV2YHw?=
 =?us-ascii?Q?ztcmHZQSsPqiFCKyg388Ghv+pstJmvb4k+ys2SUQmcgwd7homwsFHMmXolyy?=
 =?us-ascii?Q?5ba8+tjyYuHnYZQvhOy9GH6We+UaLbK+9UxqQfBcfEJn0Rwt6T8gkYpvlWt9?=
 =?us-ascii?Q?wwTq+325pJZl2NsQf+DdOFMpgcz/whHi3sGE23f7axlIyAoUE7nAhQ73v+Jd?=
 =?us-ascii?Q?nfHPnOH+x1qCl6CKmLi48d8kS2+MEmjt6DAX5G4OXB0LlBMqq8pVE2yAnVY7?=
 =?us-ascii?Q?tAEGkfituKeRq8ViRlxybVElGVswXurQ9Trp1+z4GDuENznH8NjiabWfUYFs?=
 =?us-ascii?Q?0cWVM6u9HgW5gGSfVBPfdScx3cnoJnAF3QYxAjH6sTX86wuHn0uTHXxM1JPS?=
 =?us-ascii?Q?XKRptsnjnkc63ASa7vgmF9ZOlEmMbJDr4UoZRzAg4aWB/tpG/CcDiVj8JWCb?=
 =?us-ascii?Q?AOw+miKz8YmwKIsdgrxmYhZTTT1DPjXj3XU9aPyIWPLThF804OGkObNJznLP?=
 =?us-ascii?Q?+EfhHwHZoW4r4PV7ARbAl4lLOlbpSCbvMeB9K+83EixjyeqODZZlODD/7MJM?=
 =?us-ascii?Q?HH1kWNh28DSuPCMe5RXbh2jUK1toa+TfHscQ9j/+Io+KRoSJ4RZ86xSe0du4?=
 =?us-ascii?Q?eM6LzPNJDGYLtctmFwjo/cH8HntaiIFfRE3oaAg1vXT+MgO3vzVDuiRBqSOR?=
 =?us-ascii?Q?UFIbJ+sMhgGNkZ/5ebVB/+0MmMxDR3osXgUZjZ3/ZnOV7cOmabTggx24wNuX?=
 =?us-ascii?Q?hJCbyVzHBw4vHvSEqr7AlS88Zl7cd2Hsk0+XBJ3h7fLvc8SAe7WjY0MOB5i/?=
 =?us-ascii?Q?38NKLSfPuya6id6RvF3cJEhc6MsTTKDlUxTYFGn1xq4CQjskdwD6xA40Q6u2?=
 =?us-ascii?Q?H/ytxyNhXl2zRcj56iw6Yc6uV1lt68IKLporUqHM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6119b04-104c-42f1-49f2-08dc3907b738
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 09:20:48.0992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcLDWomfSjIIU4oUFkGi0qPq7qoDxUydD/caa7r/M5oTIA/HElsaWThcsSn4I7S2XMXdKKSfw23bfW3oUJxCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

> +
> +static int tegra_sha_export(struct ahash_request *req, void *out)
> +{
> +	struct tegra_sha_reqctx *rctx =3D ahash_request_ctx(req);
> +	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
> +	struct tegra_sha_ctx *ctx =3D crypto_ahash_ctx(tfm);
> +	int i;
> +
> +	if (ctx->fallback)
> +		return tegra_sha_fallback_export(req, out);
> +
> +	memcpy(out, rctx, sizeof(*rctx));
> +
> +	return 0;
> +}
> +
> +static int tegra_sha_import(struct ahash_request *req, const void *in)
> +{
> +	struct tegra_sha_reqctx *rctx =3D ahash_request_ctx(req);
> +	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
> +	struct tegra_sha_ctx *ctx =3D crypto_ahash_ctx(tfm);
> +	int i;
Got a warning from testbot for an unused variable here as well as in the ex=
port()
function. I will fix that in the next revision.

Do we have any other concerns with the driver currently, which I can addres=
s
in the next revision?

Regards,
Akhil


