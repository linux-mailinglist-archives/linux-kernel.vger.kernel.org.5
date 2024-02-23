Return-Path: <linux-kernel+bounces-79181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A104A861E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4498D2851CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C8148FF7;
	Fri, 23 Feb 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t+oVJXFt"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2067.outbound.protection.outlook.com [40.92.41.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816885C7C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722639; cv=fail; b=YMndZuAE/L/a3MxCIrMkmxxsIkpJuc28PjhvWKBFNVJ1tiD9O3uapguMLkyPRkPKl0sc0AQU6WnaDBn41IKcQSh9i/9jwEZLVFJD7mRDPXR9sw2cutdZGO16+U8JQl3lVB8H9tDZkdbpLLuqEKLf/5hqVtPaQpdFJelxgUYlhHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722639; c=relaxed/simple;
	bh=JrVB95/TWCv8ZLM64mCAJklAx2qKyMBLXlf2m8jNuTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rzcmG+TYhP4lVojvc4LfkIZ95fWX2l8iAiz5+NJk1/Xa0yY3+FdouM4zzEaCSxOlIDLvPDPGPud3yKCrDxIE1IGAnnZOH+MCxu+dE/4az/00a2+7I7eA52tgfuBYskD5WxQDZtzB8w5az52RKnVK8SdBSUWBX7cGfvJjqZHOTzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t+oVJXFt; arc=fail smtp.client-ip=40.92.41.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMgOd6Rs7OOXUxhdsoRTLNKdfWeY/rgMVKof0gzROzZJRSvKwV+BpdV1BI69NZy+9W9BnUOVWoLBYAqJDFhvKwV9+OOnvifxk8Cw+L6Q/o7O1BmNwQ/r5bnFa0Okp6C2ygDWDluvsekYUZHIL0NW9IMujRilVWJQKJnckvZW2WRecWL+FSWJ8RSQ3L8UXFqxFQTpibf2OVRoQyhJCl1hAy3NMaPzWhdNeQ/i+aq9NvP8WPcuXyClAn1+EwN94OX8K2v/gedZ8LAABDgxwPISIxJ/dtrWc4JXMxaTbrFYsgEYBcy++vkT4/o9z4vGSlZHou3bdGUlbvveL+N4D65I9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uggaKpUcAWd905T4GzigR2HNUvzixs4MV3ck+UHXZaU=;
 b=V5h8Ax8ls6MSOkgsB9akyPG8pjedevX9XTvqFakK81sMkisE6Ey7SR+BYb+s58wsBjLsRnjVEVmZcQPjfQgrJv2aVg0bhRr8ITgCKZRY7WFpttgKtv5+ZjY2DQLugJm4plgYdRq3tzG/yZBqN7vLbJO9KGaNbxMwwJG1CFAoVHtd4VunNKHYZig3/DO0W4ZpslMUCgXRLQD8Zf02yRwkXWu8Bl0vKELGAWa2tOXvXrGxSc24lNXnfPOrJDdN3S29dKaz6P9W62Y6LCDh1cQQiPSphRNMItDTu2bnkggNQh7gTlC2GQ1BjiU9vcuNDPD9RqnqZYNLDuSN+xz9wPoL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uggaKpUcAWd905T4GzigR2HNUvzixs4MV3ck+UHXZaU=;
 b=t+oVJXFtlxyXU6igdic/fSIagz02gpakQYDt+WUluul7A70wMLo/vPxqa3uuzZSLLx+cA07UXRLARBdXjb7ZWWtQlnuqCHVtjtFFH33r4wq3x1SqejJqsyc9CCI2WZe4V2YAgObuSdXoYHwfpIX4QS/Ih91/RkFQaOvex6y5PQuqlEdoXaprfeQQyF8goFKYkFVVZlvczhnjrymXrvIWM+x0wdoceTGjhdttuFWxbDuR66UoSefCS6DzDXUOmp67jF8xDTBV3puTF+1i3gaD3PytFVn8FLkr5YI2VdW3pp2OFjGwVv1Ovj9bZ/uI0NARJS0NwP1u+6rleSSa701vCA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8394.namprd02.prod.outlook.com (2603:10b6:303:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 21:10:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 21:10:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Topic: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Index: AQHaZLoRyKgMK9jLMUWPn0GpqcfvobEVbBTggALvr4CAAAjwsA==
Date: Fri, 23 Feb 2024 21:10:32 +0000
Message-ID:
 <SN6PR02MB41574C0F51BEF3AC474C2EC1D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
 <SN6PR02MB4157828120FB7D3408CEC991D4572@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zdj4y7nqF2LHq2IH@Asurada-Nvidia>
In-Reply-To: <Zdj4y7nqF2LHq2IH@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [TssF13v3uYvU8cM/C6DKKgGnwC0n4eR9]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8394:EE_
x-ms-office365-filtering-correlation-id: 4924402e-63b7-43a5-a1c0-08dc34b3df5a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LabQ+imBQARDVexfgUuNmsh8qUTbGX91hGMZ/sVjcAr4xdiyqsCOEfCV5FT017h8I82fCfVpYuzs/XhqnO6TYyAfOvdADVWeY8NoGiqCs7MTdtv04kf1KHkMB/qViPBvxVHvENtbhC7az5B/ebz/UzZ44ecHnUIruJ0Jstrklr2hjjTtgzqmptA5gG8zMX6Z1CeINE8nZw6BKwbUc35c5R3tX7BwuElL41YLCZlUi1zo1oNQU3Fhud0K/OXnQ8FAs1hMJaZSDthr0DXWzlLK+ss2XFniYkKe6BTApIPYrK/UQgRMWrlgAuAouZD/P3flLRoZVRyAjbUAJ+ROLaNgVN75bPmvIu8dwVPrUoJ1iLUBaXuj5yRKhEwwd5zGdjkMcxQss/oHg6/sj8B5C6Yr89LAYmPrXRQAnloLxeOjPtSIwIa6L6b95CXLpfB/If9zsLfcovk0lCBJlCbio9gNO5YyoeOmdpV02cwBlYySimw5ZDsKvMzqp+XRW6CNcaHOd/fXgzwQpz/G5JBHoHb5c5DOVe/OEvB2mlu4+a0t6tj512vzAVBQA781YRv9FQ+g
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CaWyl/XV6cBTbWB4es0rYT3xWPNv3tINhp4+W9RCGc9PWNSZwIsRqsgdTpaS?=
 =?us-ascii?Q?9AGObyqfC4bSVacC3SLPPPMk+PTuO5GV1Tpvbewc0+ajy5iGmlmhKFyHQTE4?=
 =?us-ascii?Q?fUV3vHQNKu74LGUBNaORUzi5iSvk+HGiecMVUO0nS99H18cdnigMn+SW0fko?=
 =?us-ascii?Q?yGclD13/gtXEEdliBgSnCq2NdKR5jMj7rR413WZv2qcK8wBocooK3V9fpNoI?=
 =?us-ascii?Q?2xDR73Sgy48cVqIoq/ZizfO+LjMQjp0D5WdsOkoQyo47xHZaBM9didIxe7qo?=
 =?us-ascii?Q?ENMr2BRV/AYsUJHqK4muTHI2bsenM/yCgmy28jLo+FGh+/ara6hx8eYtUlNu?=
 =?us-ascii?Q?7h3NBwYlryqDJl0qB/mrWUMmgcUxMLIv+8zPtJkk6hMCexnt/xXTudfsRa04?=
 =?us-ascii?Q?s03+3hxuaPuCJPGxYotfXYqhzSpwlfKXiep8vLgccR6VcVZetXcnir0Wwpma?=
 =?us-ascii?Q?yZV4U5A/Erpg/WBXi655xFXBMe/U+6X6yZHAe1OAVaA1Fsa+Nf/KYaSoaeKJ?=
 =?us-ascii?Q?qztfU3Fn7m75+6MYF3jDm9cXWVC1t5PYG1NgCizaTjXPCBDnoPrs98MZYElC?=
 =?us-ascii?Q?gNnsTjgabPqUNz5SQCVw0bbl3RtkThnUFvIjBSUJY0WdDgKNgrElNMVzJx3D?=
 =?us-ascii?Q?+Al7IfINUgpUfjHzX42Jt+G8O0pRnpRDi+yhNy3KfmMswRbQo6XE8/XwOI+1?=
 =?us-ascii?Q?rOH5UOaiClmbrju78Y4ZWy44YpEosPQZTg1g8LESBTnL2T6mqdBpPbLA5O6x?=
 =?us-ascii?Q?Bsbr2ALgMal7xbfu4G2MInrQf1FuyvmdWcxS/7DVjhDoG7ZPHOJ4GrgxoSg0?=
 =?us-ascii?Q?duWNML5hLXgjqVZQt48nVsf7elN1Tk9Jd09fo7EJMYQ3XUWk1eGXkxouF6m+?=
 =?us-ascii?Q?YAStq3xrLcStkT8YTQMFzh3LOMQz9J116VXPzuLL2qutGs3D9SeIzLiVE7zH?=
 =?us-ascii?Q?agVKVASaWqTV5SpiqwWCbXbK2CH5XLTjPLPHTmui1mkl5wFDZgbaDyjDXGNO?=
 =?us-ascii?Q?h9a6Zzxrbm2+spkU5EzCYMHZsn5JBKPwBMoDMhzi2CYuoZaFrimfRJnwKQeS?=
 =?us-ascii?Q?T8uWyPfYI4oESTxg/aMxM2MzfHUgr8XRYYjF1QExAQ3vLexAE2IMbgeC09vf?=
 =?us-ascii?Q?WA2OAHRuWeX4mJ66DM0FECxQQb8TZ0ML5E1eg0uPitlj5VXDrztZAIBC0dtQ?=
 =?us-ascii?Q?c4oIZf3jV3xutQpuzy2NQThlA2xv2NclZLgQ1w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4924402e-63b7-43a5-a1c0-08dc34b3df5a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 21:10:33.0319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8394

From: Nicolin Chen <nicolinc@nvidia.com> Sent: Friday, February 23, 2024 11=
:58 AM
>=20
> On Wed, Feb 21, 2024 at 11:39:29PM +0000, Michael Kelley wrote:
> > From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024
> 3:35 AM
> > > +static size_t iommu_dma_max_mapping_size(struct device *dev)
> > > +{
> > > +     if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
> > > +             return swiotlb_max_mapping_size(dev);
> > > +     return SIZE_MAX;
> > > +}
> > > +
> >
> > In this [1] email, Nicolin had a version of this function that incorpor=
ated
> > the IOMMU granule.  For granules bigger than 4K, I think that's needed
> > so that when IOMMU code sets the swiotlb alloc_align_mask to the
> > IOMMU granule - 1, the larger offset plus the size won't exceed the
> > max number of slots.  swiotlb_max_mapping_size() by itself may
> > return a value that's too big when alloc_align_mask is used.
> >
> > Michael
> >
> > [1] https://lore.kernel.org/linux-iommu/SN6PR02MB415727E61B5295C259CCB2=
68D4512@SN6PR02MB4157.namprd02.prod.outlook.com/T/#m14dd359c5a4dd13e6cb0c35=
cf94f8d746257ae48
>=20
> Yea, I just confirmed that with 64KB PAGE_SIZE the alloc_size
> can be over swiotlb_max_mapping_size, i.e. 256KB > 252KB. Yet,
> the max size corresponding to the max number of slots should
> be 256KB. So, I feel that this is marginally safe?

Yes, in the specific case you tested.  But I don't think the general
case is safe.  In your specific case, the "size" argument to
iommu_dma_map_page() is presumably 252 Kbytes because that's
what your new iommu_dma_max_mapping_size() returns.=20
iommu_dma_map_page() calls iova_align() to round up the 252K
to 256K.  Also in your specific case, the "offset" argument to=20
iommu_dma_map_page() is 0, so the "phys" variable (which embeds
the offset) passed to swiotlb_tbl_map_single() is aligned on a
64 Kbyte page boundary.   swiotlb_tbl_map_single() then
computes an offset in the orig_addr (i.e., "phys") based on the
DMA min_align_mask (4 Kbytes), and that value is 0 in your specific
case.  swiotlb_tbl_map_single() then calls swiotlb_find_slots()
specifying a size that is 256K bytes plus an offset of 0, so everything
works.

But what if the original offset passed to iommu_dma_map_page()
is 3 Kbytes (for example)?   swiotlb_tbl_map_single() will have an
orig_addr that is offset from a page boundary by 3 Kbytes.  The
value passed to swiotlb_find_slots() will be 256 Kbytes plus an
offset of 3 Kbytes, which is too big.

>=20
> With that being said, there seems to be a 4KB size waste, due
> to aligning with the iommu_domain granule, in this particular
> alloc_size=3D256KB case?
>=20
> On the other hand, if swiotlb_max_mapping_size was subtracted
> by 64KB (granule=3D64KB), i.e. alloc_size=3D192KB, which seems to
> generate more swiotlb fragments?

dma_max_mapping_size() returns a fixed value for a particular
device, so the fixed value must be conversative enough to handle
dma_map_page() calls with a non-zero offset (or the similar
dma_map_sg() where the scatter/gather list has non-zero
offsets).  So yes, the higher layers must limit I/O size, which
can produce more separate I/Os and swiotlb fragments to
fulfill an original request that is 256 Kbytes or larger.  The
same thing happens with 4K page size in that a 256K I/O
gets broken into a 252K I/O and a 4K I/O if the swiotlb is
being used.

I'm trying to think through if there's a way to make things
work with iommu_max_mapping_size() being less
conversative than subtracting the full granule size.  I'm
doubtful that there is.

Michael

