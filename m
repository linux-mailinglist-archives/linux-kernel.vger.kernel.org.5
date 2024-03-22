Return-Path: <linux-kernel+bounces-110924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B558865C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263BA283467
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F679D0;
	Fri, 22 Mar 2024 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mY41arhE"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2048.outbound.protection.outlook.com [40.92.40.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945EB6FAE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711081762; cv=fail; b=A+9RSKuja7T8egsIHWSMAZaTsh8k1BzZrhkrdsl1kR6osSAza0MMM7VZMTwwmf7RW6iDM6YscE9+sm2cr7dWtTEg3dnB9XghRvLQOLiYu0B1ELbv48xN50Ne+rc0r5fFf+vycrPo8afdtNbFDvqlZL0Td6gwxiljUKA82+iAxKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711081762; c=relaxed/simple;
	bh=bPXt9RIpZzHLpbkh8EfFb+GK7PNGvG1iChEs/o1SvhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hra3Ck6io1dZJ6QF4D5DB5+OF3vdwRAmkdnobuwYXZQjDodcWCAHbWdvskIbFvJEQ0ExS/FhyMieFj+TZpr0ouYtnaDJLRqodS5KDQq6E29i1dgWSG5aonMalSOD58raZA2LJLR4Go8gy9JSMdwM1NIh/vm4KP4uBk/QM0kk2eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mY41arhE; arc=fail smtp.client-ip=40.92.40.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuA9h4s9faA1SLiVe7jSJnqCmJC/eMYHlaqfXXvuPbLqLJtTQAGsMHDokDb1HuVv9kId4bRbJn++npqtOWQD7uaHm8TQH+YRXPIWGuE8JJOP4aGWt7Gpc/pc0awOCzfscK49rqyIO2256Z9JXtRdg6xDd7zxp04paLrV3HrtknnYfBRvpBe5q3LFzLiahu+LrlhOLLi0ZH1i1Y7tlyd0WTY9q4mXQGcWWEpDLdDcElpYzBAiUC7S9glKAVcRf/KvqRI/Zu22k+BZTuPPoi25ymAwfvwFVb27tk7JGU46+5UIx85aismr8OspopDvmFtRzXjEgJ76f8YImz+3ZeRCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qR96Y3K9B/bs2tyFawkyxRvBXMqcNofoaZDJRUu3Mc=;
 b=PSahAJQiWNyE5IVME1Os+1ilnGc574XD45rpf0nr0xM98jog/mf/r1GowB6qmjpqDrOrTnt+l9so0NQE+AYxm1sOFcxWprRUBMV/89UEpCeR51dT7Jsra3iuuUDzhpJnZFKLQYjn7TH/zKmpz6TppI1/lzoAL2l3rqKtEx0mYGLqNbfsb79fQ38ThAxriZW50oSN9UVVUKdZfggo6BlPxc9on5lOzWfdWt4hV9qe8MM7AFlKvggJQs9eRdOsgHFcSZRojt317L4aWj1PcKFtxeM8B+5J7tx/Gj6TkP2kR/6HANsP0zRTR4hrzuOC7ysD1+Y/JaXtrLqobB6ITzuVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qR96Y3K9B/bs2tyFawkyxRvBXMqcNofoaZDJRUu3Mc=;
 b=mY41arhE5XPJ66FSRA/V3t9A7fvR7hUNgvn7pP/AURI0h5rsztfL95tA4O8judrFlLPVwEUuBAxHm/sNXRlOujDo60PltXRZEiHXXNe7Lr+illA2QTaxc+MHyeUY2DiTLEmL+DtZvlqKRuwpq1cOMR2wvAYy9OGFlA6160rg+ayO1f91AIbx0hRKwm6OshPn0GQdPOa+5AafEMJwrRlN4bytfkBiRtI1aS37rnL0FqOP8/lBBo/hHEAOUwVugZQCq8g5Vd/kLxriIJ5vzItmMU3Ai3/JkosswjBguOkccgXGbloQ/VtixUW967iUImsv0Y3gARoiN8mfYTJE03Dz9g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10336.namprd02.prod.outlook.com (2603:10b6:408:1f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 04:29:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 04:29:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
	<petr@tesarici.cz>
Subject: RE: [PATCH v3 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Topic: [PATCH v3 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Index: AQHae7P1v9J3nfpwTEKyNy18gy4LeLFDKKig
Date: Fri, 22 Mar 2024 04:29:14 +0000
Message-ID:
 <SN6PR02MB4157AC19CFB8B800EA9748B3D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
 <20240321171902.85-2-petrtesarik@huaweicloud.com>
In-Reply-To: <20240321171902.85-2-petrtesarik@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [saLfv108V/7YksT/pnUHpKrgJlaeiFlF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10336:EE_
x-ms-office365-filtering-correlation-id: ace95a29-a6f0-4b27-9211-08dc4a28a181
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r5jgzUFaQ6d7lb/ZKTn5HOyv+tWxLzQu6wnBRQv9cmiINTLCO20f9ah+nHLuCCznR3ZhQmtdrGV/HPG4X4Q7Kvtk0pGKBoq+PqFVsEIX605m0iOg6aEUm+yDcwj11JuOG5iwWq1DpLGk6uTzRuS7mRXOayF8TjcBvea74GInqJFAfWtXu6dpphbh1/YBdtBqNuJbkk1xfnAqLIDgiDJLAthmFM2s0yx58H8THdckhlE7RvYn2exqifq1kKv62shLlsxV+7+cpf/x5dp/yA4W1MaVtFemcUt6jy3fHL++Yg4EUokrj/oJK+dYCicyurPj6+GvOx3YjMcjPUzL54XvpRphvIVsKW2caljTpx7Ub3f2lx2IKGjQvBeAGZ34sfAeF+WWWXagNtiWm0fDJKp/Q58JjHGnJq7rrIDVlQ96BYsqTq6qqsas4BlT/FbDm7loIjZQx9zdO9WoZi6eYsTrFcbuRTK4euuSzc0aMSpOUNPSaB/UchXjzstQbLxAyFBh0ER+kdVn7OyxX2Q+EmeRpgZW6RBleIvxQpPNTygaPcedW2eRytFqtPRou9e4F9s0jWDrCiUZmvMDDpg/291jKUEOHK4PU4G+F+528KJSwf+iBFzkNzvV4w5VCKfyxG/9zVhjQGNzrWXJefVVcfg3sJz+XGzl/3jkCSPDtiU0Vy0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E2MC81VjILT59ZfTEj7vfvMU9NyLRihGthb6chejX/On0kPegeKrFvsIz2g0?=
 =?us-ascii?Q?hbtr5IAtqXHGQahBp9hDn1n35kiHP8KeXTgo76LCLzbd32XnhpJUBDgEszTW?=
 =?us-ascii?Q?LUkEJ0tVtykwFBbDe4Oclmz4KAt4iR0fZZgB9+QiSvaNPxP6YPIoLp/WIRV4?=
 =?us-ascii?Q?0G8KfDtVidLhdFiNjy2lGQsqM0GnzYpAJw+LWABXYwLXnJ/ZfK8Tde6xYcND?=
 =?us-ascii?Q?IdsvxYM1EHiXHVxnMUWIhdfbE8vOR77rBtqiWPj4e7wkIAv3L0sWkTDEMYcJ?=
 =?us-ascii?Q?MnrKel2NDqZRGPZUqES+UmZ8BeSkfMRWiyEXGP6vHdkdbVJ88hy8QR34x2w5?=
 =?us-ascii?Q?RhHinA3/lQKWW8KnAFkvF4rBwqQwNS7Md9sMvxubP0/J9UXhylTSSvKLWLOB?=
 =?us-ascii?Q?AypR+Odv9GZiITEJHZGA8DRVoJafFZwAFgqLGyXjKXjw8gkHrqZs1+tNrwkg?=
 =?us-ascii?Q?8SZyRXIDF0rQ7om8uRMn/+Ka97o/uCy3ODrQqNaOVNQD7Rk4shB7CLD+6pKz?=
 =?us-ascii?Q?Cz75UsTZXnCG8yaInu8JeG9XdUEX3pS3uDZmnMvlBN/aQMmmtNd7QhzIFsnN?=
 =?us-ascii?Q?o/N1ZWRBXxXZ1wt75o54OBV6uEBVrcf28yiqDDnT22FC8h6LXvY/cjDAMd1i?=
 =?us-ascii?Q?dzmvKHpDf1Uf+/VWDHwgOryv2DNmYJzU1Sy1NbwYxGiIc8cyk/KYAkMyJB+J?=
 =?us-ascii?Q?PxCqblJYjCz+o5khRemwUEe71/EyG6Sbl9HQy1mxVMUhHB4xtBKXE0XGl0xJ?=
 =?us-ascii?Q?8h6prEHNm0jxdE9v6gb+stiINCjZ0g9++HXYzzX31TIk77Zhazjwgiw97EJe?=
 =?us-ascii?Q?lK7tOgALvH6a5lYc0eRQUGSz1ORUxVmDSPpEiAac367IuyHZ4EXlot8WT4oz?=
 =?us-ascii?Q?Q9/5Fv8HnNqvwzcw8iAEU/T2kPP+nTINxSAqDLvhE4Pga3KqpQhXC5KdXPVh?=
 =?us-ascii?Q?g86llAbHziIQMerJYKll7O5bMrCxmdeReVLt5lKHQ/VLjY+Nqp76YWYeCaUO?=
 =?us-ascii?Q?01OHxnUzhyejfG4/rsfWwh6Crn6B41dgi7eGWgoBuF4fcIxkCcmwppIpR7B6?=
 =?us-ascii?Q?R5rrYtiW5UCjRWPtP8mI9ywfxO4SFfmxm+qst9QTxfN2J+XJ0R07GJM/5VXb?=
 =?us-ascii?Q?5ICq70d/8wjDBfM7jJsiKByJTsb+QTTaL3IM1HkKNfStevAffgPg3Pe4RG0R?=
 =?us-ascii?Q?bC1uQJfFYerMvSOKXtNxyOlxup4u1CFKd8OGEQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ace95a29-a6f0-4b27-9211-08dc4a28a181
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 04:29:14.8450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10336

From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Thursday, March 21, =
2024 10:19 AM
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
> Leave orig_addr in these padding slots initialized to INVALID_PHYS_ADDR.
> These slots do not correspond to any CPU buffer, so attempts to sync the
> data should be ignored.
>=20
> The padding slots should be automatically released when the buffer is
> unmapped. However, swiotlb_tbl_unmap_single() takes only the address of t=
he
> DMA buffer slot, not the first padding slot. Save the number of padding
> slots in struct io_tlb_slot and use it to adjust the slot index in
> swiotlb_release_slots(), so all allocated slots are properly freed.
>=20
> Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation =
and DMA masks are present")
> Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshula=
m.tesarici.cz/
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  kernel/dma/swiotlb.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 86fe172b5958..3779a48eec9b 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -69,11 +69,14 @@
>   * @alloc_size:	Size of the allocated buffer.
>   * @list:	The free list describing the number of free entries available
>   *		from each index.
> + * @pad_slots:	Number of preceding padding slots. Valid only in the firs=
t
> + *		allocated non-padding slot.
>   */
>  struct io_tlb_slot {
>  	phys_addr_t orig_addr;
>  	size_t alloc_size;
> -	unsigned int list;
> +	unsigned short list;
> +	unsigned short pad_slots;
>  };
>=20
>  static bool swiotlb_force_bounce;
> @@ -287,6 +290,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_po=
ol *mem, phys_addr_t start,
>  					 mem->nslabs - i);
>  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size =3D 0;
> +		mem->slots[i].pad_slots =3D 0;
>  	}
>=20
>  	memset(vaddr, 0, bytes);
> @@ -1328,11 +1332,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
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
> +	unsigned short pad_slots;
>=20
>  	if (!mem || !mem->nslabs) {
>  		dev_warn_ratelimited(dev,
> @@ -1349,6 +1354,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
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
> @@ -1364,6 +1378,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>  	 * This is needed when we sync the memory.  Then we sync the buffer if
>  	 * needed.
>  	 */
> +	pad_slots =3D offset / IO_TLB_SIZE;
> +	offset %=3D IO_TLB_SIZE;
> +	index +=3D pad_slots;
> +	pool->slots[index].pad_slots =3D pad_slots;
>  	for (i =3D 0; i < nr_slots(alloc_size + offset); i++)
>  		pool->slots[index + i].orig_addr =3D slot_addr(orig_addr, i);
>  	tlb_addr =3D slot_addr(pool->start, index) + offset;
> @@ -1385,12 +1403,16 @@ static void swiotlb_release_slots(struct device *=
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
> +	index -=3D mem->slots[index].pad_slots;
> +	nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> +	aindex =3D index / mem->area_nslabs;
> +	area =3D &mem->areas[aindex];
> +
>  	/*
>  	 * Return the buffer to the free list by setting the corresponding
>  	 * entries to indicate the number of contiguous entries available.
> @@ -1413,6 +1435,7 @@ static void swiotlb_release_slots(struct device *de=
v, phys_addr_t tlb_addr)
>  		mem->slots[i].list =3D ++count;
>  		mem->slots[i].orig_addr =3D INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size =3D 0;
> +		mem->slots[i].pad_slots =3D 0;
>  	}
>=20
>  	/*
> --
> 2.34.1

I've tested this patch in conjunction with Will's series of 6 patches, and
all looks good.  I tested on x86/x64 w/4K page size and on arm64
w/64K page size and a variety of min_align_mask values, alloc_align_mask
values, mapping size values, and orig_addr low order bits.  The tests are
doing disk I/O through the bounce buffers, and they verify that the data
written can be read back correctly.  So the bouncing is working correctly
with the slots that are being set up.

I'm not able to test with min_align_mask less than 4K, because my
synthetic disk driver doesn't work if that alignment isn't maintained.
But min_align_mask values of 8K, 16K, and 64K work correctly.  I've
seen up to 5 padding slots be allocated.

I have not tried any 32-bit builds.

Overall, it looks solid to me.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

