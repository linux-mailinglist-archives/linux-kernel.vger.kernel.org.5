Return-Path: <linux-kernel+bounces-117793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057D788AF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298DB1C61CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D7182A0;
	Mon, 25 Mar 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NTICg4XO"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010000.outbound.protection.outlook.com [52.103.20.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325E1B95B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394181; cv=fail; b=rQkDkjKepTSPrqQ22VQGxXToTKhm8ECQ9WpmT0QkyhpUY6HHFwt0bvn39qowGPCr7Rr3ANCs9l+zvMLBI7M5/+p2vwDlMZBi/VLtN9WcXzo0O4rv8kChQiBp3DFal/8UT0NazW0KaIc19gtBLmyuwrI6JGi8j3CKHSngMIEHzv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394181; c=relaxed/simple;
	bh=vbaZaKnVdjY962KzFZdVHAKMF4cmMjofE2euT5l/jO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZZF/U1p+OORKarGomMd2cmE6EKNTcPRW0TEk46Gav+YdFV7WkMWwSMbEwzhwZwNHAKhTF9LssmU9rCgq2s5vjOtwatLBpbHLBdQpRgTjXEpp3hs1UwEDeEbe6XgNIrFr7Wwq9aQcGgdjWJAxGKWP6qPdp7BkNngUmTPRz7TNyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NTICg4XO; arc=fail smtp.client-ip=52.103.20.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP2DOnMgKW+gry8P3znBGJPq1sSPPAZnAch5rpknLIOMmX57NBgYh82G/r3MQXphjHSkx/X5yWMvPTvzwvTPYF3BfIx8NlolWBiquDs7zX6sHFy79zlXALIf8PNy0YVDppzzK9AjyVZq0/LXQvq1v61hK8l4KdneJuMW29bChKP6I9BfRmiXeLXT1OvP3VZZzibDPe4nsr3UgOujAz0e8cvvDwbWB3SecUbvoNr+j4Dp88nqcW5vI3RQEQRzDT4fwP2hkB/O34Lnb3Ws6UcFDhvFJPoDNeLmcnkYpAET60+RNHF+hil6H1kRSvhwzRTRYugLJ2TG09LJUYTxs1POEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH/qsd13Ad+4mivXeDkvSau/eQr/Bg5kXxRapf7SXMg=;
 b=fTeTZDVXucHOLzsD07cp7AJEdKdZGUjoqwV1DNXTc0UPVa5EXMhGop+ZGhE5zVo0wTLbxPG5Qsk8o4zex0zCZCZn4SKC97dnW2Rdn/2zZDBFXB7AojZWFk1VKk7Gzj5u40gJcTDG2Nf79PbxVv2rd3JGUMKpNn/6cjLz7xaeUmY8/jGAzkUpuV17S9uLnYVgDEs+Wm2msw6qD3vsvTysEcjErfCij9m0jtLKdfhENuyYZUogdL88NWVMjMpVxu4jeD9B4vfK7rO/3V9TWIbK8J+bsNCsEaYqOMJZ0y/LT5SFxcRBoapQ2pFmZIR/rdCqyT3B5rwXQo3x8BckAP933g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH/qsd13Ad+4mivXeDkvSau/eQr/Bg5kXxRapf7SXMg=;
 b=NTICg4XOlDjn3wZR2owLi1JXOrpytq4CRk/YGR/1kRwV0yIiQflXdnkgreniBw9OG8aVqWxWtg6ltAj1+MiNsuTKdu4V8thY+I6FckJHTChpjoKeBTyYyVF0/kwF85+Czcov4onMShtJ61ybGyBtn8vKNX47VSpJbCjK/1NCfoF2PV5OrbhMAqqQ/E0vYbSpRNzEyTwhDVIM4BBwFpqWgJbvkfHOOJJGyIBeT1UFPxT7KqeZSaYo2IcD9Rt9Q8Q4ca5RSPoOJ7uQjPMxvg0KOcU70kmnWmyT7O7iXmiUBlzlqZxe1gADruw2RzguxSSzGbjQdKAVbe/5vVokzsfJHQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7413.namprd02.prod.outlook.com (2603:10b6:510:16::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 19:16:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 19:16:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
	<petr@tesarici.cz>
Subject: RE: [PATCH v4 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Topic: [PATCH v4 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Index: AQHafo7a63CBGA2bfUSKyJFu6hRn5bFI03ug
Date: Mon, 25 Mar 2024 19:16:13 +0000
Message-ID:
 <SN6PR02MB4157827F3199A90757DB7CB2D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240325083105.658-1-petrtesarik@huaweicloud.com>
 <20240325083105.658-2-petrtesarik@huaweicloud.com>
In-Reply-To: <20240325083105.658-2-petrtesarik@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [FR4HgM8xOjeDOfPFbn/p3Ua78dk3TsGv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7413:EE_
x-ms-office365-filtering-correlation-id: 7c64837d-de7e-4e39-bae1-08dc4d0009b6
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZkbUfAVRL/9GaRAp4oMdTYFquhyBAceYV8AN5SHFye6Hqu1D0ZuK2yRzPHHaF3ECTIrVx/yJc3Ae3KYl9kbpT1tzPtu4c6p7qoWp27Mwb03YDvUpsYBunLT97FQT7i7/mJu6G1UrFynSYZIKozjhLEb+V6zar5NbDThV8x9it7tM3q3roCDKUoFu38wreazQRchjMGSuEDhnEPDSmkZVq0bNhmURt8KGHQumnAHi8GG0DVJICgHNibNpYMmugAn3XXkyz0g0ZSfKHBYuamCUqy97UiY/80Ft7OIDzE/P2lQlc7/C1Th5B9QXMBwOMa7ssYQvlpsIeh4+G+QFMoik/VSAQvJD67OqvCnZkB/k4HA40wL2tNMHENq72X2J8EKM9HMFWf3Q5lt8Ix9edB/nN/rQqy4UMDKfh/j1wEelIdTLPipajUmKKeN54BBHnvPqOVD4Ie3GlJU4zJatt2E5+u/oEf0ZDmiMpavWu51Ghfs3Py1Y8aVZLprj+Tmsf742UXbH3UI/nUQAhfJZR3Ph9LC6XqZgnonNODd5X4MbYWMkKobB7tQxmcrcILtYt5VmwHhzB/UB8R1XwUi2NE4YGc4Rcig2N6614JHThd0n350w0gbAxza6FEb7Dtxj6UihLzpjE1FPftanP379hRWDWbw1kMhU5fRqZeXQZUCbF/vt4evBx/phWYhLXjSlGEFXU7hMFxWNJazyOkDTqtOlL9IlOQDy0RIwg15IsLbMmL6tgzSRD4JocLUCkcj2CEIbXGo4SEU8IbjWKyJMrgyLhH+V6grXpEr65ZgJG+m2kzBy+udfa1H5Nnt
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Pajpg0qsx73iyTnvOaRcabhNjRTOiM3dWseBMLIYSqAp/qZ8/Jw+DLvGcvgXyN+TpJttH5h2fBAK0hJ9MXjOm4y4iZOgDvnV38nGy591kiZBrcOMvsdtlXJA/Nlcdg/s9J9o1VY1/ZItymVGTfJBFRc9MhZNY1SAkNkqJj7SwG3wwu2ITt7k65C7Hzy5D3X7uzeovvk214fiS+n+yRLuqWjGxRVQj2eXQ8pOY1OhwZ2WBDJn7XFjZhHuJjR8BSPeaVwQ8A0xWWwTSGCkP3jm03cO8i4F4/pjp7Y9Ioy8zqy5mCVObEE4BUPqE+XA0XwgrZLwPPhaMKpw5ji2foMYRLCU2ZyIv5Ly6A4t49oSWqyutfxawKyBEJTQl6Fb5q0F8x4gQqCppWDt02scVXjKx+yopmORUDaDdxlAjTqA6CEULj+UGima2dqOAEAX+dK+s6PBX2/U5P7PIa4Bzhn75odX6X3A3eieQ0fFTU7OarLkYzBPOD4bZTqI+XSoRPk9vLYc2TsG9/UUJZndyp0cP/KmmvlLHtaBR8h+D6F48Ads250ucRu/DnSyjK1oPKnAmbMerXULym76RfX6gzjkRoKLHBsW0qltadVfjmyNoT9zeEuWnPhWha7u3CkBqF5XRU3UuM5qh43EyfEdyaiW2b3WChAARjy6u7gdxaVTPws=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P0CBoWZZBSOHHcm+AjLi97G854wSXe0fTgknzhYutKcXvITJ4LgzfNvCxtcg?=
 =?us-ascii?Q?keKFjy3ncIVoG+ThNCPkApOJ7Z4HKWJPEXvEPBVSfMdKndi8ZO1HuL02eh/Y?=
 =?us-ascii?Q?wkCoW4oTWa7uwsWDM8nbBAxY9kEME/O4amnHjLkKnoukYJyNpXgJDxfaL1Qc?=
 =?us-ascii?Q?MtQb5MVnrrmBiVmymLdG5JrGjnk2/UJTP2BlBOQP2EKE017RiUM9ZotgCsdd?=
 =?us-ascii?Q?ZiuB6EdQgXB9mITPHwCacjqWq/uLCBLAjt4KarWkt+I2EBeo1TF5DCLgSNHI?=
 =?us-ascii?Q?Vh+KkUnE6UjLh1EW6b/DJmO9DBNIy27ArMkL7c2kujuJAmyR0Z18nfWb6Qou?=
 =?us-ascii?Q?eyBZ8plu7z9sDQOf+bM+H7VS5rtYhUfQ5O7dbaomHdmUWvXZz/Y810LxFXr2?=
 =?us-ascii?Q?SB6unysyaSnnUIduCROBPGFKHF0RkK+14UzjmIH3hy1Vl1IAxuMzUMcBHlWf?=
 =?us-ascii?Q?j3tV1qzdycTfhlI7wzH7mrFrx5xRxcyrUApWArJ0X/0tTTwBsAaxJ/7VEzrZ?=
 =?us-ascii?Q?NkSM0ugtA9Xw3aPIUqz9eH6+15Y9sopnj/WKVEYDcp3HHaaQTTrmkSQbaRrY?=
 =?us-ascii?Q?CVAL/IigIciurvUO+LclMG19cWXhOu1GE9Iqxk4u0X4wxTxHfwRRypUEAvFw?=
 =?us-ascii?Q?PUK5Ds3V3o+1+AgSC5NJhGaUkr6Yt4R+GpEm4U0FfcitfKyElYsBLp8rR5wP?=
 =?us-ascii?Q?N16bGaZH+cNE5NgIhz0jgjC8x6fI5GU+ff/ny8attAQ+icm+izeqfIYOTcYW?=
 =?us-ascii?Q?Mo0w42KauY6GqIVhdwKiXvETOWzmDog8DTtUSVTFVUGaUIc9bj7YOjmkCJSX?=
 =?us-ascii?Q?YhaDTAjQsawKVwRmzR6sB8Hcq4phiY3181qL2TT++I61wnY/VwTvFXU3wGGq?=
 =?us-ascii?Q?WSticHlHj5s2RBug+QnxwaeZjxdzH9Z9K+kVdppTLl37lBll42XEuq94pEVT?=
 =?us-ascii?Q?RLrQqwypnN+vCZURVPR5RcLmlZY88UvX9V34xP6BPExIExi3FylUVWuoodpH?=
 =?us-ascii?Q?tfWZzj5rOMc11m2z+AK2qlHCataYg/cRmr4BpWkSwvCxd1317W5p9A8TB7z/?=
 =?us-ascii?Q?6gWcb/a4zn60pQaeqQr3lEpCybTIcrP5z3FPtFYNueNIMAKqicQY9K6kmvDY?=
 =?us-ascii?Q?mfK118eHsOihU6cw7dqz093huL576u628agll7xT3OAPX3qOaJ1Zc9NgZ1cV?=
 =?us-ascii?Q?/JLtJI9fFZM0mcou81hKURCbkv5tpdMZKyfRaw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c64837d-de7e-4e39-bae1-08dc4d0009b6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 19:16:13.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7413

From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Monday, March 25, 20=
24 1:31 AM
>=20
> Allow a buffer pre-padding of up to alloc_align_mask, even if it requires
> allocating additional IO TLB slots.
>=20
> If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
> covers any non-zero bits in the original address between IO_TLB_SIZE and
> alloc_align_mask, these bits are not preserved in the swiotlb buffer
> address.
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
and
> DMA masks are present")
> Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshula=
m.tesarici.cz/
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  kernel/dma/swiotlb.c | 59 ++++++++++++++++++++++++++++++++++-------
> ---
>  1 file changed, 46 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 86fe172b5958..d7a8cb93ef2d 100644
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
> @@ -821,12 +825,30 @@ void swiotlb_dev_init(struct device *dev)
>  #endif
>  }
>=20
> -/*
> - * Return the offset into a iotlb slot required to keep the device happy=
.
> +/**
> + * swiotlb_align_offset() - Get required offset into an IO TLB allocatio=
n.
> + * @dev:         Owning device.
> + * @align_mask:  Allocation alignment mask.
> + * @addr:        DMA address.
> + *
> + * Return the minimum offset from the start of an IO TLB allocation whic=
h is
> + * required for a given buffer address and allocation alignment to keep =
the
> + * device happy.
> + *
> + * First, the address bits covered by min_align_mask must be identical i=
n the
> + * original address and the bounce buffer address. High bits are preserv=
ed by
> + * choosing a suitable IO TLB slot, but bits below IO_TLB_SHIFT require =
extra
> + * padding bytes before the bounce buffer.
> + *
> + * Second, @align_mask specifies which bits of the first allocated slot =
must
> + * be zero. This may require allocating additional padding slots, and th=
en the
> + * offset (in bytes) from the first such padding slot is returned.
>   */
> -static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
> +static unsigned int swiotlb_align_offset(struct device *dev,
> +					 unsigned int align_mask, u64 addr)
>  {
> -	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
> +	return addr & dma_get_min_align_mask(dev) &
> +		(align_mask | (IO_TLB_SIZE - 1));
>  }
>=20
>  /*
> @@ -847,7 +869,7 @@ static void swiotlb_bounce(struct device *dev, phys_a=
ddr_t tlb_addr, size_t size
>  		return;
>=20
>  	tlb_offset =3D tlb_addr & (IO_TLB_SIZE - 1);
> -	orig_addr_offset =3D swiotlb_align_offset(dev, orig_addr);
> +	orig_addr_offset =3D swiotlb_align_offset(dev, 0, orig_addr);
>  	if (tlb_offset < orig_addr_offset) {
>  		dev_WARN_ONCE(dev, 1,
>  			"Access before mapping start detected. orig offset %u, requested offs=
et %u.\n",
> @@ -1005,7 +1027,7 @@ static int swiotlb_search_pool_area(struct device *=
dev, struct io_tlb_pool *pool
>  	unsigned long max_slots =3D get_max_slots(boundary_mask);
>  	unsigned int iotlb_align_mask =3D dma_get_min_align_mask(dev);
>  	unsigned int nslots =3D nr_slots(alloc_size), stride;
> -	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> +	unsigned int offset =3D swiotlb_align_offset(dev, 0, orig_addr);
>  	unsigned int index, slots_checked, count =3D 0, i;
>  	unsigned long flags;
>  	unsigned int slot_base;
> @@ -1328,11 +1350,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device =
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
> @@ -1349,6 +1372,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *d=
ev, phys_addr_t orig_addr,
>  		return (phys_addr_t)DMA_MAPPING_ERROR;
>  	}
>=20
> +	offset =3D swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
>  	index =3D swiotlb_find_slots(dev, orig_addr,
>  				   alloc_size + offset, alloc_align_mask, &pool);
>  	if (index =3D=3D -1) {
> @@ -1364,6 +1388,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>  	 * This is needed when we sync the memory.  Then we sync the buffer if
>  	 * needed.
>  	 */
> +	pad_slots =3D offset >> IO_TLB_SHIFT;
> +	offset &=3D (IO_TLB_SIZE - 1);
> +	index +=3D pad_slots;
> +	pool->slots[index].pad_slots =3D pad_slots;
>  	for (i =3D 0; i < nr_slots(alloc_size + offset); i++)
>  		pool->slots[index + i].orig_addr =3D slot_addr(orig_addr, i);
>  	tlb_addr =3D slot_addr(pool->start, index) + offset;
> @@ -1384,13 +1412,17 @@ static void swiotlb_release_slots(struct device *=
dev, phys_addr_t tlb_addr)
>  {
>  	struct io_tlb_pool *mem =3D swiotlb_find_pool(dev, tlb_addr);
>  	unsigned long flags;
> -	unsigned int offset =3D swiotlb_align_offset(dev, tlb_addr);
> -	int index =3D (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> -	int nslots =3D nr_slots(mem->slots[index].alloc_size + offset);
> -	int aindex =3D index / mem->area_nslabs;
> -	struct io_tlb_area *area =3D &mem->areas[aindex];
> +	unsigned int offset =3D swiotlb_align_offset(dev, 0, tlb_addr);
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
> @@ -1413,6 +1445,7 @@ static void swiotlb_release_slots(struct device *de=
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

Did the same testing as on v3, covering both x86/x64 and arm64.
All looks good.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

