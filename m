Return-Path: <linux-kernel+bounces-97492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB5E876B02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A48B218B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAEC58230;
	Fri,  8 Mar 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cYp1JAvw"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2043.outbound.protection.outlook.com [40.92.19.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAC225D4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924546; cv=fail; b=mPSBjjEn3fdaXbsZxagO7V/twnY+ZgXzyCYy4m2pV2TinUvRZPDqbWUY2knb8BygXS7tnncukTpbv4vF2rcxTx5NPLe8J6gQz4TYeC0nzpBVN3A+wToLfmfoma9X/a2NdA0oi/E0Pxls0A0YAUjgg3a92+fxoHAQqW6jCZPKlxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924546; c=relaxed/simple;
	bh=EGW0D9qqdINcQpeWyWhl9kJk+cU8rwnKIgqwzgZdqts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oQwex6iqBWFrenbDqvMfDSNUZI0PXVtjAxbGagBI/19tOE6viQxvqFn7oqHm8SRYtVdhUye8nEZhbM4bPML++Y+kuUSa7ukUMVbk0UmAcd9nbK/UuNq9avezOGo5K48FpWyfz3LMhQtqMJnAc/xqttiXELfn7LHKYmM4mBV8Tn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cYp1JAvw; arc=fail smtp.client-ip=40.92.19.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs7qVVrT9Nk7WSxZiTluTvdO4Rmq+eeQ41DGItq9mlxZ6Ul9E+2BuUvPi0phhk1lhFj17+vJJEgs2EBMJVGV/IML8Ph1lYThqH/Q0FCpjQ7L0kO4VQhsgEA/mJQjBL+Hq+UWf+Bugn4Nhjg6qkY8PcsZiZBaoknKaiEoHls9U8dCCFiGbeaF+PZfZcgjiJHDfMx5a2FOwX4WhyPtTvf9vFyy+5fZK3QEJzuHc/yFwNKMQ+rizKvzDPgyMpsmf/ZAGvkI70COsK4Bwd3mDKX7owbXc58wqOnSiJa1Qo22C1VquqnM9o5vP4nmJomrXvWIpAoP9PMZOWHWKSmh2sF+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VG8Ld8k0CeIikLDC8K4VkB8lTJyb6pElm/nq39FUk8=;
 b=IgVBoiYCT/K/AVTHlZytLlEmxHpbJaYKHEphR+doWObie40ce8hwYdWhCgpnZi0l+R5xCm+nObzuVh2ZDGuAiJ57M6njDF1/n1HlyuMZuT16ydYQrpwJ4/lmIFz/yKhycfXwRAl2C4HodkEDdbmRHmHhcoHIrzNRBMV5Dw8EmSeNY4hYEb6AzUXp01IIadgo99MSnkzvA2sfUGqI+6FaO26QGNLey6TgYId9t7mLPDWbqpqLzps8fosb7K8KJ6my5fzV7jWHlzxNQvbwo/sQsUe3Weos4oxlcTQjIhk2UQ5AhQKvxQrU7mXd/I+R8/8dFHXImt9z7fR135KPL0V94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VG8Ld8k0CeIikLDC8K4VkB8lTJyb6pElm/nq39FUk8=;
 b=cYp1JAvwxQcEg+SCSYK1Csr56s0Qpyu9draJC22q8FVxppkYCxmTQSRHJxs5SfxjhEsbGzrp6/DxQEYavgy34XBaJxyrjcLduSLBYXZF7n96KBshrA25MpwJIBt0EkDdSPOv6fgYOy2kjohCzF79/QACqAK0zfyk8ju5NJTLH5VxQUtB91nM6HsyvrvhiS+1a21g10+MGvbosJJwnTfipKNuVkgbIy1yycL8pIntSJQgImEiBlvluQGjA8o/vzA7LgXyA3JM7yrUzb43HyilpjwWzS373aU1kXXInxHPFRVDkjvh8Dd9SFoLsqf5dyGI5ICShU91JcZQkBAp7c6uEA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10152.namprd02.prod.outlook.com (2603:10b6:408:194::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 19:02:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:02:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings >=
 PAGE_SIZE
Thread-Topic: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings >=
 PAGE_SIZE
Thread-Index: AQHacW1Xe8drQ9jqnUu26if2JOMrnrEuMy1A
Date: Fri, 8 Mar 2024 19:02:21 +0000
Message-ID:
 <SN6PR02MB4157DBE41292B3E1B380D9F0D4272@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240308152829.25754-1-will@kernel.org>
 <20240308152829.25754-7-will@kernel.org>
In-Reply-To: <20240308152829.25754-7-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [mHyMT9635YLi3cJz0GV0fdAWLrrLyvVI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10152:EE_
x-ms-office365-filtering-correlation-id: 8015f6a1-0f9e-48aa-3599-08dc3fa248dc
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gCB4HEdo7kBkSKHYGrTjKlL4EmotdwG0hxibCk1HFqdt48iJZbtz7vkOCOe+T4GNMZFg6x0ulcSEwhuK2rP0WuQunyMM0vKLdx+vvtuPbEfqfQFKiemKvgsFqUR18ibmcRAp0Ermw1keVTNV38UtziaNyDlhXCe9qushc1/SnaOMEVQ+URTYb2ZaHOu9aiwoCFWslVFpbxC8QktZ/le9xMSUo7LY46Ja1T76DDtFhdXE/whb9axeW4lemKYxc8U/8fPEsutAnx08O49ewmOXH8IOYubghewwq9+t05Gb0lpA9PiTnyA+40pOvRKQgzt4fii1L+YFB+zny3ucal8Yv8ZLJBh19MV3op3snhpMAXzvCGHzH1x5RbGfmIMpSL3Fxg6VcRM56PrgJOLFD1JlE08x4wjCMbuLfpYn/Ky+nHEzwu6DBfXDVjZ/SJ0/tZkc2pm+Zg0O2Beuahq+0Gqs8HBdrb3Uy2kXDLK4mQ3nKVArwBuWwgbjGD8h1VvP4karESCh7Frhzo1zeYZl8Y/TsyqLotirMA/TtJQBQ3yC4Jnh0Q6x0ypVWqWPgDBJRYLl
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hfGUoj+sT6P+PpTqlMrGRChamlRiXep1zeEdnRVP84CQgXY5ePKSV/kkTrrn?=
 =?us-ascii?Q?HjuZdvKP8UwEY3XUSqb0X0mMh0KlnoGl5eB4Kof5mED+lovWGsRra4eeFz9E?=
 =?us-ascii?Q?Mdbpp4YMUsBPD2B8OlVWs28+oag2m99p8rDEVpWmUiYvRqZrB06d2lX5yJjP?=
 =?us-ascii?Q?QhPi5p/Zr2Uvt/jU6ddV0KDD2NhT+l/xmDAuUf1dpDhA5ETRdxm+FayqQRID?=
 =?us-ascii?Q?Nzk+Mfl+IooUJltSC7r0pYhzKNn2MKhrt7o/atqC0QigZmk3MOy9CDan47uB?=
 =?us-ascii?Q?nrwsqL/WFqPOWYOZnxXjsS4ctrNsb6wPawkgwVpEGdhRKUA8qhs+P8tLfj5Z?=
 =?us-ascii?Q?NxLsgvi5tdmdTUXjngA1a37Yg/w3QFr+ndvvfiiE+lVS8e0Vsq+uR55cKkSb?=
 =?us-ascii?Q?Du5ViwgSoBMt6eDraG5WTRDQncQ5lfk3uGRMaJwgjlLusSmGmtZvz4vnDzsD?=
 =?us-ascii?Q?XkDZCdOPv9B43spA5QGrGSbTnriL+2bEDY3oUzbN1Y47e7pMcWFcnmFn6iPH?=
 =?us-ascii?Q?n2aQkWnpkZOTtKHgw5M1Ayk/MScEoO4wxp65DsU0drYsoDvyAwH6UAUPsWh1?=
 =?us-ascii?Q?PPu/RlEFFvoVhXIUTrIMmoBxxCHJ1TH/BNwsjjIMQr8g5VboWV8dpiAP2hUd?=
 =?us-ascii?Q?u8WVD0xaH9tfGDjvTGmS+ZtQLl0Qic5AG/PIcgJyeDU3S7foDhMesb3o7G/k?=
 =?us-ascii?Q?LKhwl/yzkXfOPRkRzm86Ow5WTdSKEHnh5+0yKFU2fDp9Pn8QnWfLU98AzVm2?=
 =?us-ascii?Q?y6SMA9cVlvwDnpcGjUYG68mej4n3+RaQtiCr8+1ffdzr8oXaL23r2fsSQhSK?=
 =?us-ascii?Q?OUAmxWYKZSrBknnKwzZnJFtLpauiNzLRZ9sADmXkdmp/ophrDc8AykWiiVAu?=
 =?us-ascii?Q?OTr0IToZ5HBEfNW54W/jo3GdIOInZz5MIobM0aRO6BVWu5gAZI+rw8YZ4JM+?=
 =?us-ascii?Q?RBz+TE2YQDhXCXA1XSlPKSMiK7dy7m7SSWmkAXdHOu77G2JhNQhFlcOqW/Xs?=
 =?us-ascii?Q?8O4XF8PvMfv83nCUdgZN6I7aSJHphWwyqaais9qrnJISTATeDini8qEr/xRW?=
 =?us-ascii?Q?rtXINHQQgi0g1ZB7y+PsTcblOc90o0CeUWAxNGKQcnqSwEo6nS/oVROlDtgS?=
 =?us-ascii?Q?extaJcNp/X0tmPbM9Mkve4K1pyJKeEnTrO/+8/JkrsB11oRoodAVCARWxdtw?=
 =?us-ascii?Q?7YTeXyfIzfwatnO2SdwKqa2NBZ2+e78ejUDxtA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8015f6a1-0f9e-48aa-3599-08dc3fa248dc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 19:02:21.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10152

From: Will Deacon <will@kernel.org> Sent: Friday, March 8, 2024 7:28 AM
>=20
> For swiotlb allocations >=3D PAGE_SIZE, the slab search historically
> adjusted the stride to avoid checking unaligned slots. This had the
> side-effect of aligning large mapping requests to PAGE_SIZE, but that
> was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").
>=20
> Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
> alignment for swiotlb mappings >=3D PAGE_SIZE.
>=20
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  kernel/dma/swiotlb.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c381a7ed718f..c5851034523f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -992,6 +992,17 @@ static int swiotlb_search_pool_area(struct device *d=
ev, struct io_tlb_pool *pool
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >=3D pool->nareas);
>=20
> +	/*
> +	 * Historically, swiotlb allocations >=3D PAGE_SIZE were guaranteed to =
be
> +	 * page-aligned in the absence of any other alignment requirements.
> +	 * 'alloc_align_mask' was later introduced to specify the alignment
> +	 * explicitly, however this is passed as zero for streaming mappings
> +	 * and so we preserve the old behaviour there in case any drivers are
> +	 * relying on it.
> +	 */
> +	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >=3D PAGE_SIZE=
)
> +		alloc_align_mask =3D PAGE_SIZE - 1;
> +
>  	/*
>  	 * Ensure that the allocation is at least slot-aligned and update
>  	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> @@ -1006,13 +1017,6 @@ static int swiotlb_search_pool_area(struct device =
*dev, struct io_tlb_pool *pool
>  	 */
>  	stride =3D get_max_slots(max(alloc_align_mask, iotlb_align_mask));
>=20
> -	/*
> -	 * For allocations of PAGE_SIZE or larger only look for page aligned
> -	 * allocations.
> -	 */
> -	if (alloc_size >=3D PAGE_SIZE)
> -		stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> -
>  	spin_lock_irqsave(&area->lock, flags);
>  	if (unlikely(nslots > pool->area_nslabs - area->used))
>  		goto not_found;
> --
> 2.44.0.278.ge034bb2e1d-goog


