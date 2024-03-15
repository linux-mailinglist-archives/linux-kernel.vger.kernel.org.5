Return-Path: <linux-kernel+bounces-104001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4D87C7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACD5282B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089C6FD7;
	Fri, 15 Mar 2024 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gUAEjt5h"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2056.outbound.protection.outlook.com [40.92.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6627749A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471196; cv=fail; b=LtIATYe0SHHvsCN/VXPOoSK3lYeUDSqw5Pyaqb//ZPMQfzaSLgieBDSw1k0Hn3ajdsSrUa4o2fb6gW3en4sMFE5fpOTwsY/HeDCk86AD/xAjP/Fs8hpE/Mpdv/jk69/xILlLNRkx7xh5ExgBAqKY9Z/EtWftXoFrWKzFzqUXmto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471196; c=relaxed/simple;
	bh=X7Fx61L7S5Ti5XfJDlz4/G4qU0jhDKUSoOGzlCVpiMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWraBoABCjTIEiNDyuiqC00S3+Ri9xxWkI2AFkxi4syqYQLVw2MZsovKmge2Ajo3lVbhpLbH+LA7FWRMxRkW0G0Vvoj0UvSi1qb1bKRqiGSlfIZ3Uyl6NmwMNTUfxS/sg/2gFpF7+170H3bsX1OK8wGTtoLyaMGSscSLYSRad78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gUAEjt5h; arc=fail smtp.client-ip=40.92.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeBiAbJrBRIqChHPc5cWCl1NXHROZVQaKD9ZtnNmivjC/I7qJwjLnzswvtQdyFw4qxrlFfrCHJpxH8hsOWKKiIjl47Nh0HAHwQ8EyutiUBg2kKZdfBDDugGKP01DBtvk7o6+SreINcXvqzkifb2wxtGgYpaYGUGQNa6Nr6FSwuNiWRMRXYZ9nUBfkBffCKrZDoOKVLMzh7kTy6njEDgS/0cFGBgAkC/uKUg7CsTFzk1x5tsP96QKDODy/r22zta6JQQNXOFgvZLig9T/PGK3crUHI1RRITP+HOnSERF67U++5Wt6m6ic1XTm9ytrb7uXMo6gcRrkpEEeJFRIINnxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlEDeFKGrh8AMjjX/WvyYh+94LT8JatlQxEh5vBXdho=;
 b=mF8UGxN3q4ExWdP2SdpSXbQY8mzo3MwBA3r7W+1d5r1Rq/Zqw9EnQLQiC5EmDMkvnHMbPnC9WFM/ab3ZtCitwrH5bst2ziKGMc9vqCOrEUPrxxCUd990bTPVmz9sYqcPizlL8KtExehGLFLgTOVm2svKhrBNprk9L4DR4Dpxl4DdH16sXWOr5tIfebuCk7QmQEbIa+idV9vT3htfB4qGNWFCuJCCOwDFgFnzG0ItvnJ3NqfIM0/3YZo5aRMwLY4KT/stIy4LwDV0M0S0FysAVSHtt8mSF11HNOKyQJleAN4uJy5kehTQyjfePSg/e+/1kX8fSeaOpDjQH+BioCTb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlEDeFKGrh8AMjjX/WvyYh+94LT8JatlQxEh5vBXdho=;
 b=gUAEjt5hzJmidb9oTMj+kgzDpgWy6JPyl5l1VVmNt6U4m33NzxIwQNUQuH2j+PdWVrKvxGk+IztACUvzn+BuhpLpnwKYRNccasvNOqfGZa51grkelQ7YP6JPv3WalbXA771Q2fM3idi1q6ydVK85PmnhuPtylAL3Ca1BezHmz5cXG6TrRuTqActH2yL4Iyq+fiFzSZW9fKDFtgRnARC0/8xG/89oPiFHAIkQmgwz8MvbpxK3BQcUghcNQNfbuxTwuh7K2QU1nj+HVxEFUfbr7xYbarUE1pfkiqzDYsdHuv+Y6pnXAlgC3Ysd4FET2M/H+viSkHZQT0LHDGta6cCQ5A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7261.namprd02.prod.outlook.com (2603:10b6:a03:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 02:53:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 02:53:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Nicolin Chen
	<nicolinc@nvidia.com>, "open list:DMA MAPPING HELPERS"
	<iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>
Subject: RE: [PATCH 1/1] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Topic: [PATCH 1/1] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Index: AQHadIMeoQfESfdw8E694i37J5NSp7E4FUDg
Date: Fri, 15 Mar 2024 02:53:10 +0000
Message-ID:
 <SN6PR02MB4157FB27CD890E9F29408926D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240312134149.497-1-petrtesarik@huaweicloud.com>
In-Reply-To: <20240312134149.497-1-petrtesarik@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [nkehJtU7H53AkmsjmzctliNM2opSIgFi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7261:EE_
x-ms-office365-filtering-correlation-id: 7d002a56-5c6f-4ea7-6be2-08dc449b0ced
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uLFWuBXPwkZiP9Vzdrdi2a4ITys3+kSBzizzx3r/EpjqTaaLZvSGODPqIyvbAzNsJBPyMXPn85fEzC69WJDIcI3LN3rj9zqF9XIQv+kefVXQ5aSrqMLyTUQaI2D0njwm4UNIkEWaqYnYy2Z1aCvMQvkmbuhVMY2eyOQDdsvKI208HW1Wm+7xHEWQmRfr9bERD+90CRomlC7owixH+cZoC/6NhekeS8lHsCOmEfMei/tbr6dOfMr0lWf4PtIGBVW2enhT2j9+AQ0BVkQ6SC5tZ54CTZLf28ODKWlSXIkKsCf922VLLqq+3QElRI+NUpDv1P5n2t5WcoO8ZMFKBXei0+Tg/Ef1tm8QBuO6i431X9BB2ofefdGSKGCQDZ0kCu1FBO6IRVgThu20/wTlHKLLOSSrJQBDQ40G0iZoAUfdiFcgTpah+qHI16+uw68TEj9EbV/hY3cDytQNp2a1yZFj/Bz2A/fRNB9bV9DMJD2pVvUz36IJW42TLzjEB5ybBFaY/kHR5rPe4zndRaxfxf/Rv3iL3DHnawcJ7c3qYnsDiOp/3FTdHqbOEq0DtJYlrWWSgCYVt1PWFemA/xTBwnh96YxUhpdyQPlhY3MXCYjJ/Q5y3Z+Gr9Hg06p9ie/350kt5co1WtR1qzOMvNte6LvAELFKxjIKqsjUsFOhwtGsfqE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pp/xdqNO1435/gImf6jUKJdsjf4aZTSme9RC22k2qM3hGfI2xbfUKIDYTNdX?=
 =?us-ascii?Q?uReqBBoFuP0I+ev4SKIyfgcWZXkbx6bL2x/cW1uD3WiXaZgHbA6+Z5ixkjP6?=
 =?us-ascii?Q?Pe3DwXNwS7LEmVrh0R4thV7abJf04PfxLeaYQW0XPkOmaofZuOQKah5O849r?=
 =?us-ascii?Q?ClIN+ruDeZjGsgyYbplR0ZhRnoajcliPzLkEqLm284EFlMNjWOJUJAXTDQaA?=
 =?us-ascii?Q?+NtOXkKg1kfhG9QxEMOQl/0L9F7cszvxuRA4vVhL2nVrI5ypohikOX7My3Ou?=
 =?us-ascii?Q?JS+/IOvck7Xy81akmeAoeZYGg9TaUYMAx1IJay/5qM7t2iQRmHy350ma0kQP?=
 =?us-ascii?Q?irCH8n3rTLYvZ45zhjhyZN3bi5pl+sAw1ZDGNmcmsufOmqu9OudMOwAzpVtS?=
 =?us-ascii?Q?jGvgHbA9Zm1i7SG6yj47KAeTWae2GWiISEmPQvFCxUeSezBGwM7PXCWTqBu9?=
 =?us-ascii?Q?IcqOP1CCxliJggY+hTbQ6MrWQRuE1YOpsTAnu3rWWTIayMo7UREBkBJAP+oo?=
 =?us-ascii?Q?LT80iSm4kqd9ObCF1ehsy9UsIOo18f+gSTvFln9BN1FsBIfN9GXcm2v0IVi+?=
 =?us-ascii?Q?vwk2eTeWYIFeT5V07YXHvhvnAJYA2kvZflvK0C0yWRDF1HADJs5rtsPrXrlO?=
 =?us-ascii?Q?/9fJ/QsIDF7gFqQV6qz3O//NWoMIEqq1vrz5pQlRLuO0iv9XY+cZEN/Py173?=
 =?us-ascii?Q?AZ/0Bwr1/J0BMVD2Z7AJYNEXCHAttQC3j8E3TE+P/yau/Bkd8thJroM3oRyx?=
 =?us-ascii?Q?trnD6680iJ1nC85MuJQD9pyIzR4D+9yCHEglpFQLzJqvw8DlUv6X9Bg29CGa?=
 =?us-ascii?Q?sNH1c80uv8b7oS6D2dxwZ4tzMHU4RloxZK95ao+Y7R7UpWQE4zUzyXCLFR2T?=
 =?us-ascii?Q?n1jfCFsOg8Oa1GhFMj0cts6jnwny+Mwb7wO6LgN7+5R2A7YZTyuV2U8Tz5ZJ?=
 =?us-ascii?Q?CVwwNELLQt9u+b4Fc90AsUpL4b0LkhlRm//JXIRJC6pfknlMnbokkQysoNji?=
 =?us-ascii?Q?y3pGelm5hklcsBbkITIleddHQsLkZTpKVW7KqCPtEZGNKQ7ow+evPylXIwgf?=
 =?us-ascii?Q?EU6WZDdEZ9GeWibHj3L2GT5i+4peTDh5LDhTTWvFPcXS61Ych5FFA3/nmpuZ?=
 =?us-ascii?Q?N3Wi2OEQ277I4m02nfWmhQp3GWPQuIArS57BUOdWbJvMrsvWYGs2glwAPNqo?=
 =?us-ascii?Q?nkeMZ03aXnyhuPWR/Al9KkF+ffW27lomoz+OUA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d002a56-5c6f-4ea7-6be2-08dc449b0ced
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 02:53:10.6856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7261

From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, March 12, 2=
024 6:42 AM
>=20
> Allow a buffer pre-padding of up to alloc_align_mask. If the allocation
> alignment is bigger than IO_TLB_SIZE and min_align_mask covers any non-ze=
ro
> bits in the original address between IO_TLB_SIZE and alloc_align_mask,
> these bits are not preserved in the swiotlb buffer address.
>=20
> To fix this case, increase the allocation size and use a larger offset
> within the allocated buffer. As a result, extra padding slots may be
> allocated before the mapping start address.
>=20
> Set the orig_addr in these padding slots to INVALID_PHYS_ADDR, because th=
ey
> do not correspond to any CPU buffer and the data must never be synced.
>=20
> The padding slots should be automatically released when the buffer is
> unmapped. However, swiotlb_tbl_unmap_single() takes only the address of t=
he
> DMA buffer slot, not the first padding slot. Save the number of padding
> slots in struct io_tlb_slot and use it to adjust the slot index in
> swiotlb_release_slots(), so all allocated slots are properly freed.
>=20

I've been staring at this the past two days, and have run tests with
various min_align_masks and alloc_masks against orig_addr's with
various alignments and mapping sizes.  I'm planning to run additional
tests over the weekend, but I think it's solid.  See a few comments
below.

> Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation =
and DMA masks are present")
> Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshula=
m.tesarici.cz/
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  kernel/dma/swiotlb.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 86fe172b5958..8ce11abc691f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -69,11 +69,13 @@
>   * @alloc_size:	Size of the allocated buffer.
>   * @list:	The free list describing the number of free entries available
>   *		from each index.
> + * @padding:    Number of preceding padding slots.
>   */
>  struct io_tlb_slot {
>  	phys_addr_t orig_addr;
>  	size_t alloc_size;
>  	unsigned int list;
> +	unsigned int padding;

Even without the padding field, I presume that in
64-bit builds this struct is already 24 bytes in size so as
to maintain 64-bit alignment for the orig_addr and
alloc_size fields. If that's the case, then adding the
padding field doesn't change the amount of memory
required for the slot array.  Is that correct? Both the
"list" and "padding" fields contain only small integers,
but presumably reducing their size from "int" to "short"
wouldn't help except in 32-bit builds.

>  };
>=20
>  static bool swiotlb_force_bounce;
> @@ -287,6 +289,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_po=
ol *mem, phys_addr_t start,
>  					 mem->nslabs - i);
>  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size =3D 0;
> +		mem->slots[i].padding =3D 0;
>  	}
>=20
>  	memset(vaddr, 0, bytes);
> @@ -1328,11 +1331,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
*dev, phys_addr_t orig_addr,
>  		unsigned long attrs)
>  {
>  	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
> -	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> +	unsigned int offset;
>  	struct io_tlb_pool *pool;
>  	unsigned int i;
>  	int index;
>  	phys_addr_t tlb_addr;
> +	unsigned int padding;
>=20
>  	if (!mem || !mem->nslabs) {
>  		dev_warn_ratelimited(dev,
> @@ -1349,6 +1353,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>  		return (phys_addr_t)DMA_MAPPING_ERROR;
>  	}
>=20
> +	/*
> +	 * Calculate buffer pre-padding within the allocated space. Use it to
> +	 * preserve the low bits of the original address according to device's
> +	 * min_align_mask. Limit the padding to alloc_align_mask or slot size
> +	 * (whichever is bigger); higher bits of the original address are
> +	 * preserved by selecting a suitable IO TLB slot.
> +	 */
> +	offset =3D orig_addr & dma_get_min_align_mask(dev) &
> +		(alloc_align_mask | (IO_TLB_SIZE - 1));
>  	index =3D swiotlb_find_slots(dev, orig_addr,
>  				   alloc_size + offset, alloc_align_mask, &pool);
>  	if (index =3D=3D -1) {
> @@ -1364,6 +1377,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>  	 * This is needed when we sync the memory.  Then we sync the buffer if
>  	 * needed.
>  	 */
> +	padding =3D 0;
> +	while (offset >=3D IO_TLB_SIZE) {
> +		pool->slots[index++].orig_addr =3D INVALID_PHYS_ADDR;
> +		pool->slots[index].padding =3D ++padding;
> +		offset -=3D IO_TLB_SIZE;
> +	}

Looping to fill in the padding slots seems unnecessary.
The orig_addr field should already be initialized to
INVALID_PHYS_ADDR, and the padding field should already
be initialized to zero.  The value of "padding" should be just
(offset / IO_TLB_SIZE), and it only needs to be stored in the
first non-padding slot where swiotlb_release_slots() will
find it.

FWIW, your while loop above feels a bit weird in that it
updates two different slots each time through the loop,
and the padding field of the first padding slot isn't
updated. It took me a little while to figure that out. :-)

>  	for (i =3D 0; i < nr_slots(alloc_size + offset); i++)
>  		pool->slots[index + i].orig_addr =3D slot_addr(orig_addr, i);
>  	tlb_addr =3D slot_addr(pool->start, index) + offset;
> @@ -1385,12 +1404,16 @@ static void swiotlb_release_slots(struct device *=
dev, phys_addr_t tlb_addr)
>  	struct io_tlb_pool *mem =3D swiotlb_find_pool(dev, tlb_addr);
>  	unsigned long flags;
>  	unsigned int offset =3D swiotlb_align_offset(dev, tlb_addr);
> -	int index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> -	int nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> -	int aindex =3D index / mem->area_nslabs;
> -	struct io_tlb_area *area =3D &mem->areas[aindex];
> +	int index, nslots, aindex;
> +	struct io_tlb_area *area;
>  	int count, i;
>=20
> +	index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> +	index -=3D mem->slots[index].padding;
> +	nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> +	aindex =3D index / mem->area_nslabs;
> +	area =3D &mem->areas[aindex];
> +
>  	/*
>  	 * Return the buffer to the free list by setting the corresponding
>  	 * entries to indicate the number of contiguous entries available.
> @@ -1413,6 +1436,7 @@ static void swiotlb_release_slots(struct device *de=
v, phys_addr_t tlb_addr)
>  		mem->slots[i].list =3D ++count;
>  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size =3D 0;
> +		mem->slots[i].padding =3D 0;
>  	}
>=20
>  	/*
> --
> 2.34.1


