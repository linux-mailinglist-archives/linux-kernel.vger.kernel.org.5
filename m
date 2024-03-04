Return-Path: <linux-kernel+bounces-90875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE74870623
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40AC285568
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080A4AEE1;
	Mon,  4 Mar 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TlNliqBf"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2073.outbound.protection.outlook.com [40.92.40.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DB481CD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567250; cv=fail; b=KTew0hi4iHvEnlIq+G359lj2FAv04cfjah8mvUH/Cv3mnuQxYbdkLXRVt+xqDCl/WbbmLZW8YaGWitgpBAZZHBOQ4lNs+/yw5YoOctfztoSSZUf5guvGEC03pMaXD8PMobIO2HCwKtQt0Uv0uwQCmKM30zzE2XQXUjDGQA4s46E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567250; c=relaxed/simple;
	bh=a7+fk5tuZ1hLrl+JnYlxhoByXStl2ER35YLEt68f0eY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oq+2cc+s1VbF9uYTgjY0vuLP7FFXyIKvR94FLUc9XPvD0pAqQdmfmUq/Yac8o31UjY4OxnSN1KcYqcC2GQhez8gPtXTNl0ppXGvnmGvnoOautDQD5YjIZ16BuNR20FPguC0GxsoqpoWBJBBLMCyMeP/eZdXeoDWreRpAUqE1nbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TlNliqBf; arc=fail smtp.client-ip=40.92.40.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFEuBYV96a6/hYISMULy3t+QZt4g90uH7iOmNZculkYAQe/lXzu125qD0suy4j9jczgt6aic/lDgC1MxJ+VecRoXmdgdwY6rQTCWbTxEoHt1hCzOZO6Aat4az38xtj5bZZfIpRs/IqTmtHNR1vnfyIGC4xK6uUZFgQhnu30j20aycRhjQuBUQsR5EipPWM1y8YtY+f9+aMlEUPDkM7KcSdGTG6o2xKR/leFMlDCQbCRNSZL0SK4/McFeBg3xQ50wR6hIHCD4ezjZJWfl4l4bz0zCs+yImmETHGLS49GEJ/7JH2GPNxlSowDiLU4BLLb2PCavvDuSAprT7pd+N846UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SaPqiTexd8dcItWMt0h6VQaUqqnT3Y5TsmsadJLiYc=;
 b=U4//jnAw9dsWdxTbPC9/rFHieXEBWNa2ILiy6GINfqBWry33Sy85ZLxseWybCnBxWDSkrReLsZWeMvM9zNWO4mvMXfsRAVjyPjJ1tIy8ZYfSx/ggGWh70AjoV4/fHKmQxEr+yH+c4qar9WK17l/HLvDQnX10+fjcb63VuFlXB5xr9mg2uoQlVI1LfYlEPfQNqS8oy1dgFMRx+3+GJSxJ1P27a0b5KgXomWdOaI1Rc50eW9Vuf94KniK5m23Esngi/QNVFRRXhIA+yZ51Vc0WwR3pVrjmp91WL2eb4Hd/hRjgz+3gb1Mgf/LFrtphztrFfURFDGpb2yO9mVOIFfoFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SaPqiTexd8dcItWMt0h6VQaUqqnT3Y5TsmsadJLiYc=;
 b=TlNliqBfYxibs0W+E/XS2QVshlqebDK7ri/AVYXXBZwN6AvlyPMW3ds5x34x3OEO4E0wWBhU/BOKV+FN95eAloGU+saI99evtgs0P6MICX6BecjUfGbSJ3tkKVpg0jvvg0gMhSxXuKmYgjukZ7ZgGQlLoI5uAx9OjZsiAKnC8vdDDCKFVSXZyf8PWoJmGLbdl8YiNchoTG1AyTKr352VRKs0Vj4VcyTofQaSIhR3OMJZH9IvbszMk+Nw8gUQ3UiMpoOE1zcKBUHHVAhKlbLuzbQMZIJlpj2WCtgib7Q1QqSM05l/VmP3geFUh4nPP82FHA+eJ63zLk/BkaLPgNvJVA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8493.namprd02.prod.outlook.com (2603:10b6:806:1f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 15:47:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 15:47:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>, "petr@tesarici.cz" <petr@tesarici.cz>,
	"hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] iommu/dma: Document min_align_mask assumption
Thread-Topic: [PATCH] iommu/dma: Document min_align_mask assumption
Thread-Index: AQHabixNyEI53EwZYE21bqklpqvnybEnuUvg
Date: Mon, 4 Mar 2024 15:47:24 +0000
Message-ID:
 <SN6PR02MB41574B4345AC47DCF1BD176AD4232@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
In-Reply-To:
 <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [l5ZNEZ+QRSSHfCrxu11FuSYOLs4IdB9j]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8493:EE_
x-ms-office365-filtering-correlation-id: e753a10e-4b46-4848-c181-08dc3c6262ee
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKzRAqk0BkaiLjT4b4Ie7ArXbKtDz5vXV5n3VCtHgDf0ImS5HSdTA87P/5vEt4OgAXmCgik5SPpLkf51VPaThcXkEOXo3fu6NS0Jl//sEjIAv5qc4TplbH/C6nVsE/5SLQWd6KcOPYGdn7vB1qb6rWhGrqMP2Xwg2SWvVq1gZTWqCDd5YiV+gLElIceGEmGv853SxDk/8UbPR6Je72seGv9B4anYmCPgmXADIC7hIM1m3sBB8dN/r6uXGc0pxNRxScRy8xPP0E7eZULCzlmvSzHjMFOWI4lKkqauPB2SY3EK17dnW/RbgNzQIUDqeOBnH0jLfFB8zXr1u3olBu3UyR80Jw+bRGKs8ItTXkN5aa3vK+doMAi8aEYJKahBVoLyFqnCkV1Ej4H5aGjngE7g+OVaC7ysPNcRnQ5fWGzmsj+WKWZZHb1g6EV1oFQZIWN6OSfkvasaS3UAYI+N+zFRtlPwSXx7DPlb62KpWOg02kyS+hTZF9Al4iu63p2VpXt8Twokcl/uKjwAPuVutjyNiNXUt9pLLaWRLwFHptkwQJVUX9RYyA6FGFlDeJrAH3sfSXPy+mVQB5or9DYzO09Cghji7xR1da2NJCVwFZr8hT+Rj+5245EThEChtxvkSRe8maM3aMlpa6WFp11Ah2NffTWm8VxJiDcEi2nva0/y8rgnfi9sdr51eCIFNjwyRSEt2gGdW7UeO+phdadBH1QwLIYdYXfdTdpgMLU=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XHzolSJgOri4z1l/5mpORaHXbztjXtBJyvJsXAXteBD4Glwt8JmgbS62rcPNPztRfUWoJ5XAT3Zsu3pQogJ1Jxl+Qo61fTsON4xCJFcY01JaWlQ1Q9RM+STzyQExGv2xHVkmMCSzehtRQwDJs871nb0TN4qHcE+QdV08bV3Mo5qLFi5ezR/GO51u4+Aax52+TK/6OUWzsgmSKYEvhGRqdw8wI6HK6NuV31ogGU1ke4+JkSm4EHuIBMJbUAy+LlD3UPiN8eEahkR3qkFFueaDtq1KmYUor7xvITsLKiFqQAUlZoxTTwU36IrGdpcg+dac16s/bYISn7abLxWwhUQPfxxItDY1HRtwb3hcz+MVyYTmEFUezshrWq730pgNl91jochandmbK839+AstsoKQCHpVG2XSYAj3LjwRGzp80up9W61mk3CL+4WIVCwJLEdC+7aYaQ2xXKSvV24hRFgYF+vHy6Qc3YGnOPyzPLW4AjHRUI/nI9sevm8eW1XmJegJ2nwIApwTam6/hvYTDpWDbEnV5pmFMVQl2EzxP69YZm9HtRglmdL3evhdZdSF5Jle
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zWx5bbirQ7sUWnc382hGyD6V+HK9qxcSDP1Q6OW7nD+8e46mnzs5uTirPuPy?=
 =?us-ascii?Q?lMmR19lBlc7mW+cz8+6nAUCvmV4PnkS+trRrZ01xftoSMxYQBt3a73na2Tq5?=
 =?us-ascii?Q?quH8EdRGD3zDk8ASOuYPQeJhEuSNzgrgJPvEdqiY8trFkSizr3ywnAUovqHZ?=
 =?us-ascii?Q?Dyr+Yp9FjJ3us+Bdz1MVqwAcNH3gTR8DI+q/Mg5uxxy5cN/kB74ZNnCNrI18?=
 =?us-ascii?Q?f4zvKCwARrZVV8wWYYHk5gXQVGbmuzjBFzZgStm09d/+v0DfKF43rjBiFWvg?=
 =?us-ascii?Q?XDIH/jz3NWJ5nCyqUapoXGyCoMQ8hJsRGnjZVbeg0ADlpDWE6l2OzZVP4tNH?=
 =?us-ascii?Q?ApW75aT90EgXaXDYKgEEN3D/3vBelSG2UH9PSakyWTO7S3pMnxpzSS1PfY43?=
 =?us-ascii?Q?waR79iQtIMo6gkxfGm9M5bAD29WYxkT97/+2yPS+9tEJ+XeZk4jj7j2zEQBb?=
 =?us-ascii?Q?0WHEwKCtEPjAdlZx33o5O4whgrBFIyF2hMVjg4t3aRrj2fnz+f8B4VUmWat6?=
 =?us-ascii?Q?+Z1AEZQW056O6GLttMeqZ0Zhx0t+SPGMvw2FgFkUvjGoIE+5nWXI+sjTOyAP?=
 =?us-ascii?Q?+JYDzA/tH5HGJMhceWKp9O0oGFuEa56wqKysuHY5ElhBomXs9EuliILl9bUg?=
 =?us-ascii?Q?QKG2B3bo+y9abvcNRk2maxfe78+V7eNGSkO2Uwiq5tQ7hQVH4lX8K2YI79ub?=
 =?us-ascii?Q?fs7LHvhzN/f4KcwiLDLKlQBsswnIjFyqHaC1n5b7RsfaMQL6mA92GLIA01tY?=
 =?us-ascii?Q?LRSo3TfiSKjf/MND7LKYbHLG5QQ0YzHZFFtMqAL1hD9848sqxYOIYSvgnL/n?=
 =?us-ascii?Q?vrLpatwO5EDBz4EEfpafxvwQwEbYpZpBd3AKrEmoxafmOTfx2OgZMaACX1A8?=
 =?us-ascii?Q?TwkGD+m6TK1Y2f5S3YzJ9j+hbkeOiy11MyVLhrXrd0tGw+vcbvGTAK1BU7aW?=
 =?us-ascii?Q?QhRWtd5969e5JvzexstIG3wYLMV80O+wH9h0V4bVrOW06VE9xH4rzQrsuOaM?=
 =?us-ascii?Q?b5LsGqO1WSsV9y5gz/NmqkrGQdcRNV0p4hgQ2JeoJCkRsRZw1i/FcGTNw1fV?=
 =?us-ascii?Q?asYobRHgO7ur6SxypboYIo2PQRR8B/FG/jvaP19vD8JdTYhcLPW72A/7LCvv?=
 =?us-ascii?Q?OxVi9eOzPZZvznYMuNMXyTRmx6X6kXodD2rQ3ovCLG75U0kKo4+lewjKt0QZ?=
 =?us-ascii?Q?41sCaQvI9XgDBKshJAUCMwJjWQb9XWCnl820nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e753a10e-4b46-4848-c181-08dc3c6262ee
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 15:47:24.3524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8493

From: Robin Murphy <robin.murphy@arm.com> Sent: Monday, March 4, 2024 4:06 =
AM
>=20
> iommu-dma does not explicitly reference min_align_mask since we already
> assume that that will be less than or equal to any typical IOVA granule.
> We wouldn't realistically expect to see the case where it is larger, and
> that would be non-trivial to support, however for the sake of reasoning
> (particularly around the interaction with SWIOTLB), let's clearly
> enforce the assumption.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 50ccc4f1ef81..b58f5a3311c3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -859,6 +859,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev=
, phys_addr_t phys,
>  	    iommu_deferred_attach(dev, domain))
>  		return DMA_MAPPING_ERROR;
>=20
> +	/* If anyone ever wants this we'd need support in the IOVA allocator */
> +	if (dev_WARN_ONCE(dev, dma_get_min_align_mask(dev) > iova_mask(iovad),
> +	    "Unsupported alignment constraint\n"))
> +		return DMA_MAPPING_ERROR;
> +
>  	size =3D iova_align(iovad, size + iova_off);
>=20
>  	iova =3D iommu_dma_alloc_iova(domain, size, dma_mask, dev);
> --
> 2.39.2.101.g768bb238c484.dirty

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


