Return-Path: <linux-kernel+bounces-75664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C185ED14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59D1282F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBC129A89;
	Wed, 21 Feb 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ld8rIVpt"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2097.outbound.protection.outlook.com [40.92.45.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A928663D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558604; cv=fail; b=Yj5EDPYqULgtj3JNiO3LfAmiejpIoJpea9xE8LW6GhpcMRfTeE7q6DQD5wa5Dx1Vqdu2IL8FTUsZq57ErEIXfKDMBRWRkXLwtL+2AI8TlWZz0yIZQBilhin4MHpJR5C2XVumQSyxLYh6ouIE6euExPrltgTG1ZzE3/ptNKFQvW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558604; c=relaxed/simple;
	bh=lC69TCmj/TFMYrO4jcujvKXTbGVN+ie0tCQftHh7FlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUXPTD4U9YdOZ2QWWl7jpNVn4M+qFjCR8E3B1UYV0bYkC87yLBEuwbbiWWXxr+ZDnI4F9acSFtllNNxJcLDLGZT5nLQUBF5RfxshT1woWAQLQ/thKfBFVAg+DYCZUzMTcnAzG3Oh1+zPfBT/l1puAWqrPs5eLTo7ll+p7U04Dgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ld8rIVpt; arc=fail smtp.client-ip=40.92.45.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zhv9wr0051MOCT6y3X/E7Po+W+KLe9jfLj126e9FKI9fRwpQpohYjXe/+P19ah0R63D5T2Jbvk/35yoIrAcKkBjSC8P/DS0CmbRSVTUCW9FGO7u6NnbFd9GOGbDPRlsvf4P2yptcGSQDHwi9mr00qJfMzbZ3U+fxD+MRb5FqY63ctinmBjXx595dMY9NzaFl5qenuFREa+/wa75lLkyDtJpqULIj1R2K5JSMILLoLPcfyVmAEIOGKb77NF3jbaV87hNP2TRKt/GXWV0g80jA41ZQMqSHNmFmV5Rx5dHbLyLuE+/Ry5Qk49uj4mL10P0SgrNlH9Wa9tRGn3U2/XKnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwjtUXP0S/jhtN49a+XP/c43Dkoe8rBnDRroly9I2AM=;
 b=gABwhnYB7YZoC11Qw8KZN2I7u5AofCB4b2F7LqGYWapBPrEW1HI7HV2VyENS11e8u2GJXbXjNt/MBPDI+gFb3vGq7zDaij/yYXifCRkl+Li/MDKmxli9UG1uyxEbXVtUNQitDaLJaIPhdh+/kAPPfc/6ZJEWk9vkelp6ZjA77ibsD6Bdkp/OLszY/6jb+83lhe/0kkPbMg0DqTjOj50S1mxctag2L2bouvWjJ6EMBR2uYncOg0rJpS+pziV+hzDNsdCYV3ieG3evbtqfT/LyBeKyJUG1RKKNckL1JkdtT1D+m2aSuFf/8EVrQ3mLlukRJn1mMSNPATEwCWAc2G1oNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwjtUXP0S/jhtN49a+XP/c43Dkoe8rBnDRroly9I2AM=;
 b=ld8rIVptoShRS3iCt7Xwe3f4XOp3VC51rH1YQB/ZpOi+F3mWF+kaPhESq5Ftt447WV+JCiaE9HodsXuO4D66echzgiRIcYCWiwU/x79hjV/DAuMAGRteFJBmPsLX57GePuTWiWgy58mbfDM+aLv7XHWde3FxBX0dB3qcis6edMQepbLj+vEJJkNXCbqswDSEOOEYn9gycaQSqANTVhtZ3AZLPAJVzyvtqvZUi6bfzvZq9hMBQM8hXJ9i3+r1GcSSgw5NREjKuGpb2jtV7OrdIu80bU49rZqqWPGbQA0wObXtu2NHatUyq9rdGB2o1qCCimErNt6amgOCMRemi37cbw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9754.namprd02.prod.outlook.com (2603:10b6:a03:539::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 23:36:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 23:36:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 3/5] swiotlb: Honour dma_alloc_coherent() alignment in
 swiotlb_alloc()
Thread-Topic: [PATCH v4 3/5] swiotlb: Honour dma_alloc_coherent() alignment in
 swiotlb_alloc()
Thread-Index: AQHaZLoQP5pvu7LIN0ifIewA9hPQArEVb2LA
Date: Wed, 21 Feb 2024 23:36:40 +0000
Message-ID:
 <SN6PR02MB4157AE0780AB094784F0DF56D4572@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-4-will@kernel.org>
In-Reply-To: <20240221113504.7161-4-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [t/XUl0bzjpeVCb2gLn03yhrBP4avxAf4]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9754:EE_
x-ms-office365-filtering-correlation-id: 5a7292ba-b484-424c-6a30-08dc3335f48a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ruNRW8EGEyGxoNE/u74Y72/MrO8P8QikWrbaLlH/fyr6KwHLyfFP/g9FLO3o5s6A5csZ3H2gm00z4T0SurZIfz39NKlehO11TTEoCiY0LOhNwRGseESgYV9xMPUc+jXVgn8B8b+7569mp96cps3HXaMctRXgBu+ZfVXVsQg4hja0/4KM+GInihYI+ZC/VXcGXCYm/m/7fJRotY1U6llj+KE8+gmtZ2X6cyXK0eoWXFuWOwFbk5gPiJTuqGLKBl/tiTC5ThS9siYVPHZVIlVjB2SxOiQX+X+14iZeVy/FHb1enyzJyfROSjzPgO0/hF7c5JOLJB12UqaEKImvyqT5CnVQG9k4R7JHveBJB2Ei3LjVA+FBHBuV9/T0PIQRqbYiWFSFDJ7GWNRmDbxowiJgb49NEKaSuUTQ0Og6ELSJEu5vGVYHJptTaHXn331+CejEKRkGHgXy6cbTQq2G9UuHofV6gC+rKY17yZly21U42JHBGOtP0RixUhO3m46YUW47ul23UCHV4vy1Rq0Z/m7XUYolvLK1sF0M+uDNN/As9gbs3QhZ+l0YO122eAvFaXDO
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eMFjZtngE6VKjxZpoVwzoth/uYWFmH+hgmCQL5N1v1k3eSS7VHbcd/s2ArA1?=
 =?us-ascii?Q?9KGtZ8tYXQPCeXyRRlJC1ZD6wmos4odMjzGXK0KgFAmI/vwBWoxIWrKUc9rD?=
 =?us-ascii?Q?plswgUr8DgUYN3Zjs18l2+YNgLPCkXPDvCSviH2p65esuEm7Xv47QOOKVwDu?=
 =?us-ascii?Q?dVDFY6PZXZujEE6PnGLzjGxn2X1SJcDRXNsRqSkHEq9mcte6Nw6HlLL4D6PZ?=
 =?us-ascii?Q?/LwojULvssSYwIvU98NcdblBGNXsx/QhG0uOHBTiCoehOq7MlFBbaSPPougV?=
 =?us-ascii?Q?az+EOT22v23mtFDja/FUEfBmwEaBUQMu/aRBCK0zh9ScD5IKQEmjijCqfVFj?=
 =?us-ascii?Q?PEr6zfu4nKfjU2l+rmxkXLlR1zP7kyiDrQ4fBUd6rbN05gDciIY+S3cgWlOW?=
 =?us-ascii?Q?uIS8/oXy6SRTCzL6UhfqpdH46eaUcH9yRrk00ZDwVguPe6bNjvBRrUCwe30j?=
 =?us-ascii?Q?ZFB9mdM4YTDE3vlZ3IuNvoyWHzJwFfApZOTwOY+WGL+LHbliG7lavO6H5N/n?=
 =?us-ascii?Q?mcH0d8oD9sJZJHtjQ7RK+jCryr72dF4zBIj4SwCYAm8cj3LV1WdnGla/vACL?=
 =?us-ascii?Q?fKzyWWQBOx5zxqCeA4ZAg7FyWcRBay4F6GmHKdBFWfoyTZnBZXSbKYaHi6ji?=
 =?us-ascii?Q?sw9DUhzal+LasFezPr+Y7nvdGdcSiqjiO0aOO+EW8P/zhJQJf1wDn9QjE0v6?=
 =?us-ascii?Q?mWxIxnzB6bPfW1EJmm94RVVdFfpcapwZApSp8UIK9VQyBoQ2EVPq/ey6PAnD?=
 =?us-ascii?Q?uWzdP8igpi8wFqCKu+Q0fo7tk4V3ZYFGBhkeTcNXqLldpkA2lxUwgnMzbQk4?=
 =?us-ascii?Q?9XHB6nqRZKVpJzoLRGcB4tlW6tt/OPBMN3ohUyqOMlVZD7GG1PEIwmwt3BBz?=
 =?us-ascii?Q?nPQ0Rj6jse2Ig9noKHa7kKpQU7bNN4JIGMyBMH8ycxqND1CokcUWxJ+ey2o4?=
 =?us-ascii?Q?7Me/vwpdivvmzNJPRHJj5kNeb2b8+vWvJ5rftvK32ZvEFtrryrKVeFZsRcCq?=
 =?us-ascii?Q?CV7xf8hfkrejjE52Ekyh/R94RrYuMGsHTktBTME5ZJ7+W+EW7L7LBOY9tMuB?=
 =?us-ascii?Q?uBmAayOE8+KWoVVDX6x944PpQ26CH/8oX49bUK0OdUZwLBySKyYU59jZliO0?=
 =?us-ascii?Q?hXanSwx1Oo6ApvzvV76fedntYOLVrRcTKng+GzQYQ1OhF/s4245hWPZ1e74+?=
 =?us-ascii?Q?8UwOdqp+fJnSQ5nU8cd0/7l0j305hw/P4m708Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7292ba-b484-424c-6a30-08dc3335f48a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 23:36:40.8666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9754

From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 3:35=
 AM
>=20
> core-api/dma-api-howto.rst states the following properties of
> dma_alloc_coherent():
>=20
>   | The CPU virtual address and the DMA address are both guaranteed to
>   | be aligned to the smallest PAGE_SIZE order which is greater than or
>   | equal to the requested size.
>=20
> However, swiotlb_alloc() passes zero for the 'alloc_align_mask'
> parameter of swiotlb_find_slots() and so this property is not upheld.
> Instead, allocations larger than a page are aligned to PAGE_SIZE,
>=20
> Calculate the mask corresponding to the page order suitable for holding
> the allocation and pass that to swiotlb_find_slots().
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Fixes: e81e99bacc9f ("swiotlb: Support aligned swiotlb buffers")
> Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ab7fbb40bc55..c20324fba814 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1633,12 +1633,14 @@ struct page *swiotlb_alloc(struct device *dev,
> size_t size)
>  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
>  	struct io_tlb_pool *pool;
>  	phys_addr_t tlb_addr;
> +	unsigned int align;
>  	int index;
>=20
>  	if (!mem)
>  		return NULL;
>=20
> -	index =3D swiotlb_find_slots(dev, 0, size, 0, &pool);
> +	align =3D (1 << (get_order(size) + PAGE_SHIFT)) - 1;
> +	index =3D swiotlb_find_slots(dev, 0, size, align, &pool);
>  	if (index =3D=3D -1)
>  		return NULL;
>=20
> --
> 2.44.0.rc0.258.g7320e95886-goog

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


