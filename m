Return-Path: <linux-kernel+bounces-78785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3648618CA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5D11C255C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76512AAF5;
	Fri, 23 Feb 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GKfMwR08"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2079.outbound.protection.outlook.com [40.92.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD212A16D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707904; cv=fail; b=rTzZ6GTK6ItX1RPwjcWdOGWr4I324Khw+Fm8hwhnP4dYIM4zXeNY+rjqtt3llpqfEjCbrS5Dyj7fGDZnqNtTkWeccUBRq1gfdJEE2ecCQ9vU7moZMCk4p9KBClKMHEoVZqQCgBrZmhZV0HmP0obB72M22exiOS40zXKNqzml2Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707904; c=relaxed/simple;
	bh=pLrzjkSEdnz9q6s6EgIkGQSL2AdisXxLDjA/GgIfvVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G5nph44/kqpMaA40UCo8zP8fy6lGghow4XJzHxFnFU4WTt1kOWLHjUBC5ebkbAKeKtJwG2DPtDWp5D5rPK/PFRnOu3p6yzWtYGBMQIGqSdc2g6Zg1KbS/wgQbwCJ7UGOvF7hIIyrh0uA82uoLkSuNwHV+dm2iNo+JK4nx/UhUuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GKfMwR08; arc=fail smtp.client-ip=40.92.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PU1UpjQEPMNDAQ+7Gj+rUnSNP40swuo3a8Y5Ik1UvAtaa7t5c80plkauAMMq8VLHrOzK5S+vJyJ1ogK08sZTFKUbmjt0V5tlVOUUkUS2140ZKs1UH+l1ugTToNwI7U97lUieD0wn6pIdn5hDw7ZuZeqE3Quzs6QARzNhLBfDJsEicFZF0ak1RzJRlYLRZMyP7VA402pSL5gtscXdTPQQvLeg7dIaXjwuNgeJvqhdYd+V2wb1aJIbDJflOyAoHwbAktA/duH9iJt+dkw2Iyf/pFN3+yLonlgP7uDDCzq0wfMjfX552l12xTR3LxLTb8a9Vk6DMlQnU70T26W9suBlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZM3ISqCmZekkWv0bdTJW4M/1ec9h8I4VZTCL9cXOZM=;
 b=RaN9xImL1UodQlF6AyJwF+hrgAj5kZ9F2V3TxviG78ARRqOcV1sJoRoIe6amfwz7tpqbuPlhLz1CqJ8tTGmtIF2mcjBi6ycts6eIlKr3KlHZJbcJxUlwmO+S7jqhQpO4N8TuFA3nGAUxU5/v5aHKBv4ML+6fuGwoDiWQDZ3MUsvWyH0GJm2prUCPG9fe3sTOyeNFz6dVVU47213Kim3tfkJfyK5kpcm8/jNszNMo0b4TYWnpL1Vxye4OwECUKHIovW4TKb93+0hIkeQV+0t5/Z3TKDVgqUP9GWa66o3yH3SWSkTHqF3ol4Hs0Jye7/PqbacBMc2jozrndtGw/wqpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZM3ISqCmZekkWv0bdTJW4M/1ec9h8I4VZTCL9cXOZM=;
 b=GKfMwR08e2NRIVriECDUzRQk+d2CE8d2M/ALNccSe/MDpkiI9qoIlC45n5VXAW2VaBXQ9NHyGZi92uFKH6t450PI5sF5GI2r6ik4RUv3+L2rIeFDAOgTpL8vSWkYIU0KbL961lLFukkcAGCmPwNZAyFiEeoOElEwoir2nP4vKYHzGHXyQydDKYZnQhs8ceb5hhr/sNF68Bqu1nybuRl+sibOqayg8UA6T2tp2uVdyd6UJBXCIg6/H7wjSl0D9n8PCobwxQQLHKY4ERsegFqjnHkbXepBuzsr0ello8S/YO5MKm8PbRpn+AjYsIOPAnDMUPI41KvfUkUYiA9Giqs88g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9498.namprd02.prod.outlook.com (2603:10b6:8:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 17:05:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 17:05:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 1/5] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Topic: [PATCH v4 1/5] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Index: AQHaZLoKzpSVcbbIx0uxPuvnjPXM9rEU/tHggALkt4CAAEQsEA==
Date: Fri, 23 Feb 2024 17:04:59 +0000
Message-ID:
 <SN6PR02MB415757F135DBF95C08E1FCDED4552@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-2-will@kernel.org>
 <SN6PR02MB4157089980E6FC58D5557BCED4572@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240223124742.GB10641@willie-the-truck>
In-Reply-To: <20240223124742.GB10641@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [tyHlnI1gdAUtxOUeS25q/pCXJXC422UT]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9498:EE_
x-ms-office365-filtering-correlation-id: 28464749-9e35-41f2-cce0-08dc349191c6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SrIzy18K4NvuhMyxQ/1nmScALlnhK/sDgvB/Oma1uUxNuEm0KDiSJVUS29EABPz3jK2qRrndgEWow5vkm2m/T3pd6Ol8gFLocOTH6fXcp+i8E/EGJn489wtgMZ2qfMYnO+rCWrzFU6klOREPvvWOFil2/8Xb07dlNuaSyMKB3G8/GK122OE/EmHDUvhTDZMCFYir2+jpcy8UowRKk9m8L5EKjiJ0ML1skFQR9QLtcQ5Q3WHfOqI3TD8wSx3IxPZniYpJ7M0M7Be9FiTgazNRyVd/7NQMfRrW2GG0oJRqnQCPmjgnyOzrb9jd//qN72djI39y4bXnybPVr90yr5qejMS0O7p4SehYUre+QhUvzi23V1PQV97ryMfHK1B84EOppM8ZzIFFEKB96CV6R+zh8r7MPBFfRIk1Pe/FMnE52NnRiGGTBOfLbTWd+gHkdSmvE7WHVEHTqXGNNwekfutWhGIGUH10NPlMQvrBqVmf2cGlVfQPmlk378j0s/OEIlwwdimgXyRGYvK7vPGbsQLukRfhUyZjhcZFglO9QGSG5Erqf6OCkgQs2FERvvOXwEEe
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JV23+NUTEYuq/DteRNJGeUidbyc2JdFWxfy582z27rsMkDt/WmgxJRZYybpc?=
 =?us-ascii?Q?JtWIL+uiKXERGTPQ+sPa0+37fSr5CpTFjro7nbaFwAPURhO87D90ssSikQuz?=
 =?us-ascii?Q?qZK8O5eAdwNFvHZ3/QgSUC2wPzilep5oYmjvEJMO+VUgo4tjkXbxADxfwZNu?=
 =?us-ascii?Q?xFtwqBU02kS3BD8GTltOBUDjFjQZXCel98kIc2NKnrdZUwB+okwt48CulYdc?=
 =?us-ascii?Q?t1LIWPJVtJYBZwjJj4WyWhBVxJr72CeTEBL9YNCGJx8KqgsxIa8PP2w2Iece?=
 =?us-ascii?Q?3BK0MmDRvQrcJ3y1XQEQicHmwnAx0X3qNhOOUnp/c52wLiIWfimkOQEcyXuf?=
 =?us-ascii?Q?Wm4oR7vw5t6IxGQT1y/DxOG1Fo/piJJr/QiLM2ekCwRv9aUHLitB+kAGrE3m?=
 =?us-ascii?Q?hnW3ic8/gpTq/Fy2sNG2pWTbKYFZ/CldIGmCQV9HAhaBy6UgkglqtfV8Ob3w?=
 =?us-ascii?Q?HxJyHoq/oqi8aJzc3Cuam4KP30/7zgt4Kggwx2pbEhpnZzGv+MyChGuLodE8?=
 =?us-ascii?Q?mSBHPHab0f4ucdyqGg+Vomw4JiCpFTU2Op6dUQUmgECizlGBnKF02z/jh2TR?=
 =?us-ascii?Q?os/F9t23Mn95McneHO51QJRiVi8ba+2l4I75G+xYJVCq+sK1MhJ4pDRw/as6?=
 =?us-ascii?Q?aCd3Ir5GGfQbmPwygaiYXxo6DUHVAvl9CR8jWou3dTTtXLUXTi8OAiL4Yvz/?=
 =?us-ascii?Q?SiixgyxAEyz3rkMT9AIpBqJrZEP6jeIlWqo2QUq7WHaW9D4B7fls7sqMm914?=
 =?us-ascii?Q?npf3f8rbgydOfkV0nBDxr+KP5DE3WWbvXVnThhwPStx7R7SxH0pcRb+Y/53X?=
 =?us-ascii?Q?uvlPDTGTFtbZjTXbcEMUKgygQ2GBGFAOo6Yi/JWj4Sq6hUYqnRYpUxlGnz6/?=
 =?us-ascii?Q?xcrIwV7aihfTOgCDj41zxZcZDKN4RVbeN5zi1R5eonI3syLPqMX380JiwXdb?=
 =?us-ascii?Q?fN6/XPzmH95hVsjHe4lCrYoFti8TkC1kFNLJBSQ+JyOBFrVQCSYx6EnCrift?=
 =?us-ascii?Q?AemE+7i7Jbfubxzr+FxpVCfXxx8QyZUfB0hkkuDPPS6mE6Si4op/TI4xAwoD?=
 =?us-ascii?Q?B7b2HpROHtQBmHarDRu0NG8H3KXhb5HELYNxyiwgZPvCWWWF9VMpvwaTLmFw?=
 =?us-ascii?Q?BwGNxBA3+hz26sJdnSEFfn4x2g+cR1YIkucIU6fuDQewvv1nGQpoynRw+zUJ?=
 =?us-ascii?Q?hPTMQxcO/6JPIwFWRKJU8VnpYFIzRyBebMPWqw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28464749-9e35-41f2-cce0-08dc349191c6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 17:04:59.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9498

From: Will Deacon <will@kernel.org> Sent: Friday, February 23, 2024 4:48 AM
> On Wed, Feb 21, 2024 at 11:35:44PM +0000, Michael Kelley wrote:
> > From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 =
3:35 AM

[snip]

> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index b079a9a8e087..2ec2cc81f1a2 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device=
 *dev, struct io_tlb_pool *pool
> > >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> > >  	unsigned long max_slots =3D get_max_slots(boundary_mask);
> > >  	unsigned int iotlb_align_mask =3D
> > > -		dma_get_min_align_mask(dev) | alloc_align_mask;
> > > +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> > >  	unsigned int nslots =3D nr_slots(alloc_size), stride;
> > >  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> > >  	unsigned int index, slots_checked, count =3D 0, i;
> > > @@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct devi=
ce *dev, struct io_tlb_pool *pool
> > >  	BUG_ON(!nslots);
> > >  	BUG_ON(area_index >=3D pool->nareas);
> > >
> > > +	/*
> > > +	 * For mappings with an alignment requirement don't bother looping =
to
> > > +	 * unaligned slots once we found an aligned one.
> > > +	 */
> > > +	stride =3D get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> > > +
> > >  	/*
> > >  	 * For allocations of PAGE_SIZE or larger only look for page aligne=
d
> > >  	 * allocations.
> > >  	 */
> > >  	if (alloc_size >=3D PAGE_SIZE)
> > > -		iotlb_align_mask |=3D ~PAGE_MASK;
> > > -	iotlb_align_mask &=3D ~(IO_TLB_SIZE - 1);
> > > -
> > > -	/*
> > > -	 * For mappings with an alignment requirement don't bother looping =
to
> > > -	 * unaligned slots once we found an aligned one.
> > > -	 */
> > > -	stride =3D (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> > > +		stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> >
> > Is this special handling of alloc_size >=3D PAGE_SIZE really needed?
>=20
> I've been wondering that as well, but please note that this code (and the
> comment) are in the upstream code, so I was erring in favour of keeping
> that while fixing the bugs. We could have an extra patch dropping it if
> we can convince ourselves that it's not adding anything, though.
>=20
> > I think the comment is somewhat inaccurate. If orig_addr is non-zero, a=
nd
> > alloc_align_mask is zero, the requirement is for the alignment to match
> > the DMA min_align_mask bits in orig_addr, even if the allocation is
> > larger than a page.   And with Patch 3 of this series, the swiotlb_allo=
c()
> > case passes in alloc_align_mask to handle page size and larger requests=
.
> > So it seems like this doesn't do anything useful unless orig_addr and
> > alloc_align_mask are both zero, and there aren't any cases of that
> > after this patch series.  If the caller wants alignment, specify
> > it with alloc_align_mask.
>=20
> It's an interesting observation. Presumably the intention here is to
> reduce the cost of the linear search, but the code originates from a
> time when we didn't have iotlb_align_mask or alloc_align_mask and so I
> tend to agree that it should probably just be dropped. I'm also not even
> convinced that it works properly if the initial search index ends up
> being 2KiB (i.e. slot) aligned -- we'll end up jumping over the
> page-aligned addresses!
>=20
> I'll add another patch to v5 which removes this check (and you've basical=
ly
> written the commit message for me, so thanks).

Works for me.

>=20
> > >  	spin_lock_irqsave(&area->lock, flags);
> > >  	if (unlikely(nslots > pool->area_nslabs - area->used))
> > > @@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct de=
vice *dev, struct io_tlb_pool *pool
> > >  	index =3D area->index;
> > >
> > >  	for (slots_checked =3D 0; slots_checked < pool->area_nslabs; ) {
> > > -		slot_index =3D slot_base + index;
> > > +		phys_addr_t tlb_addr;
> > >
> > > -		if (orig_addr &&
> > > -		    (slot_addr(tbl_dma_addr, slot_index) &
> > > -		     iotlb_align_mask) !=3D (orig_addr & iotlb_align_mask)) {
> > > +		slot_index =3D slot_base + index;
> > > +		tlb_addr =3D slot_addr(tbl_dma_addr, slot_index);
> > > +
> > > +		if ((tlb_addr & alloc_align_mask) ||
> > > +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=3D
> > > +				  (orig_addr & iotlb_align_mask))) {
> >
> > It looks like these changes will cause a mapping failure in some
> > iommu_dma_map_page() cases that previously didn't fail.
>=20
> Hmm, it's really hard to tell. This code has been quite badly broken for
> some time, so I'm not sure how far back you have to go to find a kernel
> that would work properly (e.g. for Nicolin's case with 64KiB pages).
>=20
> > Everything is made right by Patch 4 of your series, but from a
> > bisect standpoint, there will be a gap where things are worse.
> > In [1], I think Nicolin reported a crash with just this patch applied.
>=20
> In Nicolin's case, I think it didn't work without the patch either, this
> just triggered the failure earlier.
>=20
> > While the iommu_dma_map_page() case can already fail due to
> > "too large" requests because of not setting a max mapping size,
> > this patch can cause smaller requests to fail as well until Patch 4
> > gets applied.  That might be problem to avoid, perhaps by
> > merging the Patch 4 changes into this patch.
>=20
> I'll leave this up to Christoph. Personally, I'm keen to avoid having
> a giant patch trying to fix all the SWIOTLB allocation issues in one go,
> as it will inevitably get reverted due to a corner case that we weren't
> able to test properly, breaking the common cases at the same time.
>=20

Yes, I agree there's a tradeoff against cramming all the changes into
one big patch, so I'm OK with whichever approach is taken.

FWIW, here is the case I'm concerned about being broken after this
patch, but before Patch 4 of the series:

* alloc_align_mask is 0xFFFF (e.g., due to 64K IOMMU granule)
* iotlb_align_mask is 0x800 (DMA min_align_mask is 4K - 1, as for NVMe)
* orig_addr is non-NULL and has bit 0x800 set
=20
In the new "if" statement, any tlb_addr that produces "false" for
the left half of the "||" operator produces "true" for the right half.
So the entire "if" statement always evaluates to true and the
"for" loop never finds any slots that can be used.  In other words,
for this case there's no way for the returned swiotlb memory to be
aligned to alloc_align_mask and to orig_addr (modulo DMA
min_align_mask) at the same time, and the mapping fails.

Michael

