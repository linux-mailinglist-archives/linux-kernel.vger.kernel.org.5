Return-Path: <linux-kernel+bounces-75662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174C85ED12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641371C22AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796A1292FC;
	Wed, 21 Feb 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h/l6UZTo"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2010.outbound.protection.outlook.com [40.92.47.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632D126F37
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558551; cv=fail; b=JlPoyBUhtNv96e/oqPP5LE79actYJXp3Mtm3juNJpM6CJ80jEQrTIafpsg6IJyoXLDfvQDpytWYTqYJvWJXHbLwWsD9Qy7+vZbuenYrgzzzYEBRP1vIiid2zC1ipScId19dgNBQN+YRpIFLz7RnzBU5ObEKVgd9YJSofPm2Kaz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558551; c=relaxed/simple;
	bh=MzpiNtuc3L5G+ckPpVsb5PHt8G47COKEaMjkHxSbu2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mz8QLvjAk2X/WLv+86aG2WznMiGd4eHP5oOQgDd4QtJZuWKK34JfVhGKo9K52QZlAmK8U9o9sW4RDJhwIWVzxZPFw+mmqqmFLu40UrkMGptb6WcMil+yGlXEL9t+ttQaLWoFoSc3mkc9PmWAQHBGN/ajM2tvg9FItzmJLlwKonI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h/l6UZTo; arc=fail smtp.client-ip=40.92.47.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/Hg79WFXE6q4LaQNsUZknv+U7VMUuoe6Nk2VcER1CBGCQXatePmnCnhNaJnm6xBBcoSRy0j+Qx+1LNKarYXoX0fJiIrrm8wvbR92D/vMgfhLS3uVhnshIVVawHqch35HZUhfOiP7qwscmgy0p0/ogSZUdjfUd7KM2BECc7mJ8Ns8IeTtGa+6/T8hQMZDJittmzAkO7xAbESlZT9rzulQlokUi47sSwqIll1sCM6/vUoSBqUVpNIjeasxXjwMezRmbT8ziFUz30xCrCPa3Q+jFGCgkKYoCS2zGrArQ7Ta7AsosjfYApmkyZS0ja1Du46TmzhYDWQ3xYVlRwEQYOIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f13IfVdSIN1gwdDAbFfLMUnvjDNzPSUXW/jRP8U9poE=;
 b=Ny7cdQw0zNLDe5sdqG+p0T6un/gA2aHT7ns5jrcG+ZYIRC7D0e6GRWh/V8KqUF6e85XCjb72ItyrH6WcwSY1Wyd9yTHVCisNlhwZOx3/j0xOStX2oSdgG/Jp8Ja0GqP1QcKM9vga402Jv3PlGt2etCOhlbxosry+rqq7TbSMSBZyBH4tB3l1rKUTY/u86yF16xM8U/G8mUWD+rnRi9RlJZbadDUm1e+qxgGgdKD7PndlrM8XB5p7/nIhbvFDTt7DbobAXL8eK5GQTZW1dvWo8zQQmcPxOQrnXtqZusvon0brYXy4NyJ74CjkZvhtDFQ152GQ7y8KJaWpIpEFlfaigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f13IfVdSIN1gwdDAbFfLMUnvjDNzPSUXW/jRP8U9poE=;
 b=h/l6UZToPXgA3+SY+tV43jug3S2wWw0T5HPxe7H1rqe+x7EBXDvVJvwuRQWeHPg2JZOm81uE7JHGgsvhNg4OaF1Sw3NI5ECsxwwBJfN3E4hNLNJMEy5QjtB/QLrX1vVQePQl6on2zkTzz2d3aDf1+0LOehz1eDHRwQfLSU0OH83meJrlk8kMMgHsUeZ+vwo9hCWaWn+UCorbEroDpiUUJeUqSEFDx71RInWmFkeuXTOdP08Yxw6ZZIt0aOqY5iDG93OtN7u9TQ8kU0uGacQxB06ShpJ5kRZvxmAee382JKh9o1oAU7U5PI/Hf0YsCQr2saFqX6TwEtP1goAch3m0SA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9754.namprd02.prod.outlook.com (2603:10b6:a03:539::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 23:35:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 23:35:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 1/5] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Topic: [PATCH v4 1/5] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Index: AQHaZLoKzpSVcbbIx0uxPuvnjPXM9rEU/tHg
Date: Wed, 21 Feb 2024 23:35:44 +0000
Message-ID:
 <SN6PR02MB4157089980E6FC58D5557BCED4572@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-2-will@kernel.org>
In-Reply-To: <20240221113504.7161-2-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [8X5zJNzsrZF8sdfHIra+oJAd0gP+WoeY]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9754:EE_
x-ms-office365-filtering-correlation-id: 04679e23-b9de-4ca7-e78c-08dc3335d300
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 egp9Q5Y0xN3bU78wacczSahTxBXoaVf+/FSmBs8YgPv+8mSo+6mG0xTunTbVYAssG+LQxrSn3rFNdxAtIw6kaUdhp7kFJvfBnFtlriaKxeJTNS/qeZQ2v1Ug5Yjc1UzotfMo/WDmuv1mcG1rpfLvpy5Cp1y1cL7Y5sJjULhZwcgMNOvWvVMAIE9jiNgCChyF4w5+k3aECXWcnBjGJvRrdiqnHIFF2LSK7uscQnlxEojjPDfLq2JFVuE5iAotSO5CKu77E4svkPNonRcEvtfDX/UNQW1Kdje608OUuCQ/CmpiVt+wpnZyylFNR/lHEjXSOpZoJELdOj2RiQQqwDaP6tNGQhO2tMcJB5IiVbCtFzllCNXCpFNYdZ5uzVSKIGLF4i1cTpMQAtCOVwhRvZHFHC3hKppdBT1hxjNLzPv/PFJ1ECc1kzqN1iUdIIU4HckugK54GYNrytFt11dT97UP9gZA1PHD/qahXkhI7RkYwh07fBEbLx4aQ23QTO01X7rlJDWSgr/gsq02p1PyPiAX9NMdtoHIQbdKoik5luND54PgUW6TU/a5CSNyffmKdNuBdFjt/rEhNr4GuUUgeiHsE0feaAwU93vgciwTJfWPDUM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zXUF0IZ0jc/X5UB10tbg0D81NbIVku0XEq4onm80ZaFe83L1V/K9yQPcwC+H?=
 =?us-ascii?Q?c3tBs9e8fw64FA7gL6u3FR+C+1V+9p0ZWM5WKukNNslLD4d1XyxykQ2xl8Ti?=
 =?us-ascii?Q?YArEdOibf2itV8foF4d+BIcVAzMke3MicXw5wb00XTI6TL9ydPD+YIbsdDaN?=
 =?us-ascii?Q?aGn8owvxKWYTJQRY3xz2rCKoXpuFL+2jzyHaAKkHw0ZGgoJPETcivDPb4INK?=
 =?us-ascii?Q?ETaBl1ypeIhDp0oDAaSOYzslPg8wFgvXHXTFYsEVf4EL6N2AqgzXCnHcC1fr?=
 =?us-ascii?Q?GLcxV6Dz+pQBQrqSM/NRMQuYWYEqyJUffSo+ENFOm13JovOy7yPGxSyOPkiY?=
 =?us-ascii?Q?aMTHBt3Yhhj4hWdhLabpqClu6pINJFTmhe++gkZgu2eTwGurEmzFLpOVdtRv?=
 =?us-ascii?Q?an9W6OolEe9p5BPRICRCsbgTPTUt0Y6n7XwyHS83p3n/9dtrklV8RC55Pfmk?=
 =?us-ascii?Q?NPjZB/KxQvGLQDXuPoOYCPd3RovFFaHLM1aDcOq0JkgbbFiAJrj086Q3Ni7L?=
 =?us-ascii?Q?nBUgQHKRx9+67X5xIs6mi8EXA6aK+atVSOUs7HByviMJSmBJEDSbMwzmve4r?=
 =?us-ascii?Q?OdR/yBi5uKlOavVSKojOcc5tw1u41mwUSP9LY4tRJCDC/PRmAI6AiSiGXi1S?=
 =?us-ascii?Q?PZl91RL6xGAjjDOg7pip1wFNmmgzEtio2BEAoZj2fbsImVNlYVyovrnS4+xw?=
 =?us-ascii?Q?0sY5Wuso9gWZp7L+c6LDYXDvrcj+NPDlqqz/I/7rctE2EarOijYfvPXoM8q6?=
 =?us-ascii?Q?g+LVkSAoPG9ozWo05uTOEnMFuVuceZ3ePXAGMo9Dc0AcOH1PdKZqp8FlK1q1?=
 =?us-ascii?Q?SjhLx2X9SJcKtuPT0wysEiceqR9ZWG9iyifrLrqgATuG0nOuIjKYo2aPor1a?=
 =?us-ascii?Q?l5LxiEZRseJJ7w+/MaUYfcs3rocIrkBu5rI1EmpCk/2VvJGqbamHxn0zMhJI?=
 =?us-ascii?Q?r48DW3W/VPv42Yh8bfx5ToQrYoIvn33dCiWeFVpA+lsNisWji+lARraPHw1v?=
 =?us-ascii?Q?mTtObaqSl9anX/+g42J+byg8/uoeF5T8fOe6k8PHRVFC8hHkScpDx/6pyK5A?=
 =?us-ascii?Q?fMaB9nq2/V4TeeGWiyz3en01VxjBUf9YKay3SVLXYJ4NZv7bI3WIYqqSRiff?=
 =?us-ascii?Q?q4vsmkOBwG7UrqFVjH1cQkJgndPMkthX946qvneZMyObpBLdeSCqTEFuTcrS?=
 =?us-ascii?Q?AxEUtjCUMGEJomhLpQPJgQkDQin9jUnQQgSBeg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04679e23-b9de-4ca7-e78c-08dc3335d300
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 23:35:44.5926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9754

From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 3:35=
 AM
>=20
> Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> checks"), causes a functional regression with vsock in a virtual machine
> using bouncing via a restricted DMA SWIOTLB pool.
>=20
> When virtio allocates the virtqueues for the vsock device using
> dma_alloc_coherent(), the SWIOTLB search can return page-unaligned
> allocations if 'area->index' was left unaligned by a previous allocation
> from the buffer:
>=20
>  # Final address in brackets is the SWIOTLB address returned to the calle=
r
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_=
mask
> 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_=
mask
> 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_=
mask
> 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)
>=20
> This ends badly (typically buffer corruption and/or a hang) because
> swiotlb_alloc() is expecting a page-aligned allocation and so blindly
> returns a pointer to the 'struct page' corresponding to the allocation,
> therefore double-allocating the first half (2KiB slot) of the 4KiB page.
>=20
> Fix the problem by treating the allocation alignment separately to any
> additional alignment requirements from the device, using the maximum
> of the two as the stride to search the buffer slots and taking care
> to ensure a minimum of page-alignment for buffers larger than a page.

Could you also add some text that this patch fixes the scenario I
described in the other email thread?  Something like:

The changes to page alignment handling also fix a problem when
the alloc_align_mask is zero.  The page alignment handling added
in the two mentioned commits could force alignment to more bits
in orig_addr than specified by the device's DMA min_align_mask,
resulting in a larger offset.   Since swiotlb_max_mapping_size()
is based only on the DMA min_align_mask, that larger offset
plus the requested size could exceed IO_TLB_SEGSIZE slots, and
the mapping could fail when it shouldn't. =20

>=20
> Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
> Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b079a9a8e087..2ec2cc81f1a2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *de=
v, struct io_tlb_pool *pool
>  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>  	unsigned long max_slots =3D get_max_slots(boundary_mask);
>  	unsigned int iotlb_align_mask =3D
> -		dma_get_min_align_mask(dev) | alloc_align_mask;
> +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>  	unsigned int nslots =3D nr_slots(alloc_size), stride;
>  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
>  	unsigned int index, slots_checked, count =3D 0, i;
> @@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct device *=
dev, struct io_tlb_pool *pool
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >=3D pool->nareas);
>=20
> +	/*
> +	 * For mappings with an alignment requirement don't bother looping to
> +	 * unaligned slots once we found an aligned one.
> +	 */
> +	stride =3D get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> +
>  	/*
>  	 * For allocations of PAGE_SIZE or larger only look for page aligned
>  	 * allocations.
>  	 */
>  	if (alloc_size >=3D PAGE_SIZE)
> -		iotlb_align_mask |=3D ~PAGE_MASK;
> -	iotlb_align_mask &=3D ~(IO_TLB_SIZE - 1);
> -
> -	/*
> -	 * For mappings with an alignment requirement don't bother looping to
> -	 * unaligned slots once we found an aligned one.
> -	 */
> -	stride =3D (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> +		stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);

Is this special handling of alloc_size >=3D PAGE_SIZE really needed?
I think the comment is somewhat inaccurate. If orig_addr is non-zero, and
alloc_align_mask is zero, the requirement is for the alignment to match
the DMA min_align_mask bits in orig_addr, even if the allocation is
larger than a page.   And with Patch 3 of this series, the swiotlb_alloc()
case passes in alloc_align_mask to handle page size and larger requests.
So it seems like this doesn't do anything useful unless orig_addr and
alloc_align_mask are both zero, and there aren't any cases of that
after this patch series.  If the caller wants alignment, specify
it with alloc_align_mask.

>=20
>  	spin_lock_irqsave(&area->lock, flags);
>  	if (unlikely(nslots > pool->area_nslabs - area->used))
> @@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct device=
 *dev, struct io_tlb_pool *pool
>  	index =3D area->index;
>=20
>  	for (slots_checked =3D 0; slots_checked < pool->area_nslabs; ) {
> -		slot_index =3D slot_base + index;
> +		phys_addr_t tlb_addr;
>=20
> -		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, slot_index) &
> -		     iotlb_align_mask) !=3D (orig_addr & iotlb_align_mask)) {
> +		slot_index =3D slot_base + index;
> +		tlb_addr =3D slot_addr(tbl_dma_addr, slot_index);
> +
> +		if ((tlb_addr & alloc_align_mask) ||
> +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=3D
> +				  (orig_addr & iotlb_align_mask))) {

It looks like these changes will cause a mapping failure in some
iommu_dma_map_page() cases that previously didn't fail.
Everything is made right by Patch 4 of your series, but from a
bisect standpoint, there will be a gap where things are worse.
In [1], I think Nicolin reported a crash with just this patch applied.

While the iommu_dma_map_page() case can already fail due to
"too large" requests because of not setting a max mapping size,
this patch can cause smaller requests to fail as well until Patch 4
gets applied.  That might be problem to avoid, perhaps by
merging the Patch 4 changes into this patch.

Michael

[1] https://lore.kernel.org/linux-iommu/SN6PR02MB415727E61B5295C259CCB268D4=
512@SN6PR02MB4157.namprd02.prod.outlook.com/T/#m0ec36324b17947adefc18b3ac71=
5e1952150f89d

>  			index =3D wrap_area_index(pool, index + 1);
>  			slots_checked++;
>  			continue;
> --
> 2.44.0.rc0.258.g7320e95886-goog


