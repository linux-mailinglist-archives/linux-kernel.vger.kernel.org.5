Return-Path: <linux-kernel+bounces-75665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BA85ED15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC65B1C22B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093BD12AAC9;
	Wed, 21 Feb 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="O/RKGfV8"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2100.outbound.protection.outlook.com [40.92.47.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43568128824
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558630; cv=fail; b=RveoNeD3mlbUhm82aQ3Q1HkV1q/XG8NGQbmk5r2feQ+Ar5eWeIfQoIXBRXIa7OB4hvH8pwjGKY0UjQkk4DOfzlWKz7QmfENUo+eSYseVwHBaW+mHSRLrR1lgN87WczyaTp4k1KAcrTNCYm8UMd1ZYLDxj7hhK3tvwiGS9iWAJmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558630; c=relaxed/simple;
	bh=gZBsbQOVdq7bqKJxjPxB+rPmJjma6n/PvooNxPHHZtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PA4y6o2B/+GjJSyXlWeOCWR/ww49JedY++2Nxrz2tZf95pFthErNt24VE8kLB8AjZWJxvqp5IBCxAYlKMrsCfZpV9RATHayNBHf5w5bbOIoX2xDSyigYYfKyp2X2K7c30NYSTc8FWgGiYx+5sw6TQON2uKFfUNhF/65/qHCnlcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=O/RKGfV8; arc=fail smtp.client-ip=40.92.47.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7hE/Im2b9+g9cV/t6r/VQfXZ2bHvHFm5pSPWKcP07QGKx5u+1PxXMB9VrpwGNhAjJCDE2MAD61vvlNHaGPCZdbA81uMrtN+aihR93F7NL8fGkD0FLoVkwkAqj3RThdQRQL08ELsaxAOhCvHkA9RyouoOBM7OvqEpe4Zmk59LcQXgDRK84f/zpXFbeECu2LE5NO0tixncm/ap6KF9FDCdeM7hVKeyfG49PDr9ldVdXUTQPxj9wXz5LzU3nNt9Lw9FlZX7js91sLtBWlDI2EyviQ9pR9YPO7AaCnn2A77aKBMzaCbMjlk8pBjL2bXqcIzI2vCp29OUU1qMiAOAstIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHLMXB54XRu0WHNNJsXR0By4NA5nnUM+6Q2NKCxNKe0=;
 b=Sv3XdH+D+mOIKRj2YWyjp5ofIL2LYSjWv3KFFAh8NgK19AOTOLBAcmxg2rYtqUEpn7rMO1+OJxV6ZQbfyoWQy1zzK5KH3NXqc3as3S3elp1nVZsiGf4yEwG/IQabW7KjAb7Ap4mM+r0Po9Vp9smOkC9LVT9c8QuKD+ExFhfm7scd2d65Zm4M2i1Iri2/aXsRN0vHHv73UOC4eMPUja6iaqQkPetmmQ3J0tmRq5GHjCnpM3EVeVwiDy+ZikEZyqCQBrZss/IroamUFqwZdA0lstZJAkqNPDvOjW7K9EODfNR0ib0zwYPI5YW8oRTKJQQGpxgOX5uXHDBrdMn8RS/w2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHLMXB54XRu0WHNNJsXR0By4NA5nnUM+6Q2NKCxNKe0=;
 b=O/RKGfV8zvgRPf5O7JnojH7/DZd33wApamj2VvKm27gy8cZ9DR50RUNmxCSnEbEUi6uwR2Dbqc8zzkhc9buwXPsbNV0Kjgxyv60/jooNukQJfGfmNraXnW6exjCaeWPEU+9kehLzcpYbzMM15MPzicjUaQUQDgvmmQmomkamkyNRb6Zw5x7BlMQP7u2s/qZFmDjPtQZA7ey9pY+Cn2s9rL7EoeyZfqzk30kdn2EGAjj5bi++TMkbD0UKSxJCGlZpstI8PrKsAdcse+wETpqqCSxI0GCb31MudrOjNvb2uEskFVFVQHeSCs6Gw6sldydlYW1kRlgoMNpKe1L3OlxfxA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9754.namprd02.prod.outlook.com (2603:10b6:a03:539::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 23:37:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 23:37:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 4/5] swiotlb: Fix alignment checks when both allocation
 and DMA masks are present
Thread-Topic: [PATCH v4 4/5] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Thread-Index: AQHaZLoRU/rkXwVNGUuuP+NQzmiF5LEVb8Yg
Date: Wed, 21 Feb 2024 23:37:05 +0000
Message-ID:
 <SN6PR02MB4157EBFF4863305A91772D9ED4572@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-5-will@kernel.org>
In-Reply-To: <20240221113504.7161-5-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [PLskltgRP74jzmZ1ahYJGreu8kNjCYic]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9754:EE_
x-ms-office365-filtering-correlation-id: 3cc23007-3ba2-4316-4070-08dc3336031b
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eyOrDXnpW7SJuO6IID9nawsl7MvSAF4kFMsFBFU9TicE9I6wh0rSeMNI1ceVS+DPOE1eYicNkp06SNYIqEAr83SSK1djCEXdHEEgs6WzuDcpM4U2AbB21Yg+Ax64yHQhd0gGlf5fejWOJIv1PsmpZXv41HkuQ1Sc166rG5GnwlZu6R5NE+Ihr33uKvzjMwOaKQ+0XDN+l1aoj64b7ks1TmZg8QLoiH2SK4KUSE4BiMvxPCpqy33Du/lLFJ3R5xcLHUlLVwTRkycBp2X0kI6GS0YMcesEt63J+eFKO0p7y5Z1SsYFgLN+f8pr9kycpa5mvVd4d/cJAffknaeRzovZymCnqqfSdh4FOAdM/uSOdU7r+i6Bvq9iKbHUCZWXt86r2O42dMNJztyXZBraoiM/PWQ6OsDUnGeOf3mwH4z2r+OPiN73fGDE4HjeazpcgfTcInjL9h5JnWzMHO3sJ3qxoR+RAy5VOy3lonZmerDZVl/yZZwCDXU1pCPTXceU5OzFDdjYKM79bOqv06yVExqSIOChk71N2gtUS9lNwnm+xXWRzCNzJCkQx3CBkkoHtmBSsz3DR8Ku2gtdkxQ92JiLsGUk02hQRCNbNKaeCxs/F64=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mAHDtplKJJSKDvuvkk3con4kQWOd4hNkWopm0TsWQ0JaZ+ynzanZSz8UEnU6?=
 =?us-ascii?Q?vJuWbihFkWt+qmSozmRJeAiA47QuK7UzMZbrVMvb5+l5tcOEesql1ohZvo/t?=
 =?us-ascii?Q?cq5xXCb7LwgqJtE0AUzDiwGPPuJVYMQJ7iCQe+269lkzZPaO8E2y3STkp4NV?=
 =?us-ascii?Q?WaZaO+HAFHzVHJu8+avV1HSo8QnmgiKkm7YQVCvslvb6UAA8YUNqGaLLBFsC?=
 =?us-ascii?Q?4KQWjQ7nNezrOqjXulD947oqyTsyXDsM+eLvln5ApEqz+BlEPCYsdisB9Gy5?=
 =?us-ascii?Q?ZKx5vxFQ4YdS+BQ3WGSB7EP1sT6sP93MZuPnWqU2DX5d2/FZTa4uRU7ObSGW?=
 =?us-ascii?Q?ljSEoyOvueZnMi5gU0iDcuQG2XOZqm9Y/4K7lXqjEiMxlRaoJU7/sTXEYOc1?=
 =?us-ascii?Q?zAubRwitk7hVIpkRBSZOjZve9bsWkj6i58pPUv/1oYtEP6Zq9GH+wRm6tJCs?=
 =?us-ascii?Q?1pQbMUkp9AJ6trRW/qcFSSRRUFC83t8XMnigJFPE7OWLa7aEXhpzCYbe+eSe?=
 =?us-ascii?Q?OgVW51ORSr3qGZQZSOgyorFbNQRUa+vQTmwNftnDFS4hiIIjncFF4UbmAlFc?=
 =?us-ascii?Q?AU9rYC/krYdo7JcRxzq7ajshnprYYelHIUKLnCJE67Y0PBcqPuKxGbKaK8Z8?=
 =?us-ascii?Q?gOsf7s9c8WfaXA9FYIV5Bsb5HETg1Wcah6wt/0fKf4gG2Dswb5bE+PjU3knI?=
 =?us-ascii?Q?M/MIIFUPgE7bvDERSxCHHGbiaTur9Lu6A1GNs57K5VApQn/en0oWCdetVCZo?=
 =?us-ascii?Q?djDCKbNrU5WICju6NaGx1V+xtRSGKXusTcReND7a6Dq5GSdn3uYhBUu3gopX?=
 =?us-ascii?Q?a5KJHE1pQgzHOMSjdmi1vbJjU08Wd22Xp9Su7XXd86J5zrEtt2hGUEAEaJxt?=
 =?us-ascii?Q?a728qL1we/MCoO33RBEKV9bPzQtzkMN/CUUsLhT/W7S1BgFVX8shRm8OMsIL?=
 =?us-ascii?Q?VYjvqZ/QkV7arEjdMSQXVKkY9ufAopBcBgMfgRTPDOXCY4ATdU3IW3wUgulv?=
 =?us-ascii?Q?schPcK0pp25/aQt39ITG4ZKJ3cLT1hAtW1jvgndtAANofvvxOs88nQIS6yu/?=
 =?us-ascii?Q?Q5pa/5hzh/fMyQUYzNW+cFfqb2ZTzRFzrnfo5/w0t2hR5mVClbMObm8iyak6?=
 =?us-ascii?Q?k9Zi8meS6+d7w3LFKAsRE7U5P0sMYIQJCFT+aKEV2kmVkjCnpEMdsBwG3v7R?=
 =?us-ascii?Q?x0GPG6FkEofjssH/NpZPGY2Tdty5X6KKhQngOA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc23007-3ba2-4316-4070-08dc3336031b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 23:37:05.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9754

From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 3:35=
 AM
>=20
> Nicolin reports that swiotlb buffer allocations fail for an NVME device
> behind an IOMMU using 64KiB pages. This is because we end up with a
> minimum allocation alignment of 64KiB (for the IOMMU to map the buffer
> safely) but a minimum DMA alignment mask corresponding to a 4KiB NVME
> page (i.e. preserving the 4KiB page offset from the original allocation).
> If the original address is not 4KiB-aligned, the allocation will fail
> because swiotlb_search_pool_area() erroneously compares these unmasked
> bits with the 64KiB-aligned candidate allocation.
>=20
> Tweak swiotlb_search_pool_area() so that the DMA alignment mask is
> reduced based on the required alignment of the allocation.
>=20
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffer=
s")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Link: https://lore.kernel.org/all/cover.1707851466.git.nicolinc@nvidia.co=
m/
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c20324fba814..c381a7ed718f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device
> *dev, struct io_tlb_pool *pool
>  	dma_addr_t tbl_dma_addr =3D
>  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>  	unsigned long max_slots =3D get_max_slots(boundary_mask);
> -	unsigned int iotlb_align_mask =3D
> -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> +	unsigned int iotlb_align_mask =3D dma_get_min_align_mask(dev);
>  	unsigned int nslots =3D nr_slots(alloc_size), stride;
>  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
>  	unsigned int index, slots_checked, count =3D 0, i;
> @@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct device *d=
ev, struct io_tlb_pool *pool
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >=3D pool->nareas);
>=20
> +	/*
> +	 * Ensure that the allocation is at least slot-aligned and update
> +	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> +	 * offsetting into the allocation.
> +	 */
> +	alloc_align_mask |=3D (IO_TLB_SIZE - 1);
> +	iotlb_align_mask &=3D ~alloc_align_mask;
> +
>  	/*
>  	 * For mappings with an alignment requirement don't bother looping to
>  	 * unaligned slots once we found an aligned one.
> --
> 2.44.0.rc0.258.g7320e95886-goog

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

But see my comments in Patch 1 of the series about whether this
should be folded into Patch 1.


