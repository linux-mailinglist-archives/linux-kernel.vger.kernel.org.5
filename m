Return-Path: <linux-kernel+bounces-80302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063E862D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FAD1C213FE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB717C61;
	Sun, 25 Feb 2024 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p0On1WWj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2030.outbound.protection.outlook.com [40.92.23.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715E1B948
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895859; cv=fail; b=XiC4XpeamnSmJ9J4NoISyDMHDp2PdDkqPmaH/oMBXoooq1k3HF7rtBZZTugWt8VIhEeQMPmjncRoaP2I/4UBwUm8Xf6gMXbXJonz5zue5aa+5RHdDyWmI1+B598ZWUTTS8sMaqeviVqfhfK8uRrvitu24kc5iIbqvd4gFBAD6lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895859; c=relaxed/simple;
	bh=6+YoUu417I/sDtZRLSkTy6ZzALA65JloRQHG6FJzdlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EqrwHRzy07FrSbPvj1K3HqlZSnwZXXNgPD2+43NqHCyhvzz0JWWEguqk5Esc6pI6wheyENq/dC6TOh2aY5xlqiZ2RA7YKMiY2uZhHKKdLecWHI1/8CCe/w06BaPOQW3Lhbc+sOyDAfZ3y/sHOZpu0+Or7guubdDAaQyv1aUXpvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p0On1WWj; arc=fail smtp.client-ip=40.92.23.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEvKFy62WCe70XMfI1qyouvXxcZzImbY1JMwf2MvF3fJVWWuJp9UhC78UVdtJVm35Yl6J0lJBXZe2UeK8HzVDYaE19RB5mEsoDv7HdCEDCur5+XJlxVWVYjlacGtmkk27fuRn/Tez0jFRHEUzEifPxkJIWnd3UW0yFLML+L23oPyXCgsuDSjUKwxfO9ocT610oRQ87beDUbbLRoIDCHyGsl1nF3iYpwgmonusNmfg76rMc56EJgnnEv5TmJZ+wLS/BqRHOyY7AersQ2jucZVOB8X/8PDAnxmsdt9sC1esqBp8v9zMTvpv8SRZpr9pEHmG/qLQ9Thd9XgRjfJTZKZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5Mpk3YLeGBUzznIDSQPOyS2HMpb31q/6iU0BDsA/FY=;
 b=gdpJBM7ycRt9Ouj1/OFWG33Q03bV7i8/BytJQp4nxCFr8rRkZ23/gQluKFjosy/WACMWpwF3aJaZSLk4rxQsLQysYzAXk7+LWuWyHLsOZoaniYvwjOzy00Ju3+FIc1rF4KIgAlCKorGHQskqhE1TLs5k81uIH1oI3915C30pVvf9gJfWd7mKkf/LOA2ZDfRhNkBC2zjecVZ7oPC3f1acSrNJhIB3v/eSRu9r5vHO2ETBQ4sGylC0R7Wdri6uzex/Kqag5smMMLWsibf13SWaSIBEE2OesDIgDJ56YswTsLWYvjYCUJvC/kApyCTJic60iVYaaiaYEnEgRgjJiOSFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5Mpk3YLeGBUzznIDSQPOyS2HMpb31q/6iU0BDsA/FY=;
 b=p0On1WWjncX3cGqS/D+Rd1TjUJ4DztqO+QtOTaWyMD34ToaiR5NorJNAcRCAkc7pA0Xmoq1CSrCH2vlb+kPOvYlvPW7KNgt7i4E4Nr6cSaozZlAf8BvIGKFtvRpysRMSu4DSBwQyg2ULIclSEsQdiYqevti+KQjbaOi+W565jnexI3HBL46GzR8dYFffPTWXIgvgYI8/jsp6eoEcbZnT2fFZ7awvkclq5Xu2dXrE43L3qbUIDkBoDRODNmYN2tnJ70WUT+D40LScCmDa+yI82m97u8pmGm8PbpKG6Uxyk4XwnPFs1oTNHvRGCa11/FEWo8uqhuxbHCTqSzq2IwC1Vw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8359.namprd02.prod.outlook.com (2603:10b6:510:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Sun, 25 Feb
 2024 21:17:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.023; Sun, 25 Feb 2024
 21:17:34 +0000
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
Thread-Index: AQHaZLoRyKgMK9jLMUWPn0GpqcfvobEVbBTggALvr4CAAAjwsIAC0mdw
Date: Sun, 25 Feb 2024 21:17:34 +0000
Message-ID:
 <SN6PR02MB4157EF99BD9A018F0808AE7DD45B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
 <SN6PR02MB4157828120FB7D3408CEC991D4572@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zdj4y7nqF2LHq2IH@Asurada-Nvidia>
 <SN6PR02MB41574C0F51BEF3AC474C2EC1D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41574C0F51BEF3AC474C2EC1D4552@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [fcJAOtBaVD2SaZEmtzlnrmrqYWwxUYv3]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8359:EE_
x-ms-office365-filtering-correlation-id: 31144ec6-7118-4550-a252-08dc36472f47
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jKqXV/hbGKnzChzaIm4vajp3O/6XYN4OQt7q41q91Ea8sGRh0TWX9dtK4m0oBczGhbY3NArMWijJfw12exDJt/zl/XqjUM1hsY6nUnSq3UJ68HfjbBORvkby4QBU0uyXhByb2F4wYhdtnTig5S4jbXK4JhSXHl/Vo7qBTyJfiu+neiGnW2LvxdWfBpca9H/1AZ6urPl5K7+C4jSqK+1I+OhZ4ltwji6Q5/ezFt3S9Z1SXUW16+8Qafu9WZwwfqqC2+u1cPE+DyemImUC4NuGNDKcZFfgts9dkqb1ZUEyvYnP//xM537KqQw9nWBCWVJKRfydi5VxSMgyLMXTei+Q9lRCSiEIdMqzqdhLCSqNT1tmvHHk1omdetRX2uAt6PuFwYvLxoR3vRsjQAZgzl485CWxqgcCdZ8/XBGUwquG05JIl1Q4MAzGX/LPVyMZ8s80n0Utg83Zm76zbhGG0DESlbI6zGPbZnCWE8RiS1P4YjTbDJ3KssQlc5OjA/9ZXMXB+gOSd2R7I9oNdZO92r92KHnAdihx49ey4kqIh3gzELDLIS1r8voAUebx201VfgQXq10hfjJwREcfZHChYV7n3dXHf4YNDG7nc/OEOrH8pY8d5rhx4+zql037D2KR72Ozrh+VIAOooZZ6nvdlJ3GeHjEa4dGisEmWuD5Ltj5JVXk=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YqOA9eSoXhGi8bOUUIchk3xNHlZDTtDYRBkJsRq6PP00TBp4rS3VNXtnarDg?=
 =?us-ascii?Q?h6YX0PJYUy/b+E39taNxhhD/+D/V6vuE2HhYKRYyd3NYvsPSQDDc0rdV4wOL?=
 =?us-ascii?Q?M8fXSyVFiEAml+9yII2frDg6U8+QmlVsQDYTWPulQw6XoCll/27KKLSTBCsF?=
 =?us-ascii?Q?+iBBsajtXXoJus8Ki1aoUEMDCK7doB8KFGTkCFe/0D8gA+aMwP3PghWy06p9?=
 =?us-ascii?Q?6SyYrLf7ZMRlyGollDCkpujLwXUmzjVuT/QcncdBVxZR1vEFOyt1pY59EqXz?=
 =?us-ascii?Q?RnCHGRz03RvjRszHFC0N/dyx8w+3hnACwk9Q87RqaeyzXjoE+7zWD3gWbeeK?=
 =?us-ascii?Q?IXFcu3dlg0cVep+gf6OZO+4KTIQyMTlJybDF4AAP6rHu4EffkOa9GgQDKHTG?=
 =?us-ascii?Q?G0cGw8w58U3u8IQtvOv53TSJuqqVuIpitLOOJyE7olXJF8QJeyt8TGIdbKBL?=
 =?us-ascii?Q?idtDgozxF1GoYvZ7iaiF6N0KU9nd4U+k/T/36fox0SeBUCzwJyKkUt5a55Cw?=
 =?us-ascii?Q?mQxb7/alaB7IQtGE8jjZOSTh0UDn3cVULVQZh0o3RtOWbxVevPpffOlYWY5v?=
 =?us-ascii?Q?UUGbxHraYNCXSjmOKeQSgVtrUeiiyoOIsOblP4GXY5v+ZvVyLaNjshqQd2g8?=
 =?us-ascii?Q?Hkt53uB+E65ynpd91IEFaqHG/jFVzYsyR9rGtA8gLjicFcB/aZgygF7AdBT3?=
 =?us-ascii?Q?nxra/kSGe0UVC9Z/+23ivb36xm11/m+QgtMPw6jwjIhb7tyBGUJAdcupxpPo?=
 =?us-ascii?Q?1moz8n5witIHB6HRiSHfjrN6eABqAiWEcPTSfnXLxiSLMuAIaHPo11bR91GS?=
 =?us-ascii?Q?5BFGf998G2TEOsfcYOuJQB54Q0gjmkWDc++SYHXHvIwM6cmCkWfLqTbLxQ4i?=
 =?us-ascii?Q?YXeUEeR58cmPz9hJPIdvvG51IPSui+koBCa7EjSgTGfrzpWvHjVC5Cbgm3Ca?=
 =?us-ascii?Q?vvYVGsfvJ4aOr1hO822HlTm/1hLqIbjo71uUXDmiU1dypkGVPlUTkfPx56UR?=
 =?us-ascii?Q?UNPuoEBXBBqBCjF7SIwU6yIrbSqX4ggNJMDrOALtDLEmp903XhGVSftyMC7+?=
 =?us-ascii?Q?81lkvWvljqdt79xPdWsTJ2K2Tri1P1Yrfd3UBxhINBGlZWCoZXj3G7WVuxP+?=
 =?us-ascii?Q?Xz83E/+fSYqTzfOr+whBNfOitjeJSPafN9yhVX6wWm304wPdetpCkllYUUTr?=
 =?us-ascii?Q?IG6E0/bm18u+sEv78m2xu2R9jOxjg6mrkwEBRg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31144ec6-7118-4550-a252-08dc36472f47
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2024 21:17:34.3064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8359

From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, February 23, 2024=
 1:11 PM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com> Sent: Friday, February 23, 2024 =
11:58 AM
> >
> > On Wed, Feb 21, 2024 at 11:39:29PM +0000, Michael Kelley wrote:
> > > From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 202=
4 3:35 AM
> > > > +static size_t iommu_dma_max_mapping_size(struct device *dev)
> > > > +{
> > > > +     if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
> > > > +             return swiotlb_max_mapping_size(dev);
> > > > +     return SIZE_MAX;
> > > > +}
> > > > +
> > >
> > > In this [1] email, Nicolin had a version of this function that incorp=
orated
> > > the IOMMU granule.  For granules bigger than 4K, I think that's neede=
d
> > > so that when IOMMU code sets the swiotlb alloc_align_mask to the
> > > IOMMU granule - 1, the larger offset plus the size won't exceed the
> > > max number of slots.  swiotlb_max_mapping_size() by itself may
> > > return a value that's too big when alloc_align_mask is used.
> > >
> > > Michael
> > >
> > > [1] https://lore.kernel.org/linux-iommu/SN6PR02MB415727E61B5295C259CC=
B268D4512@SN6PR02MB4157.namprd02.prod.outlook.com/T/#m14dd359c5a4dd13e6cb0c=
35cf94f8d746257ae48
> >
> > Yea, I just confirmed that with 64KB PAGE_SIZE the alloc_size
> > can be over swiotlb_max_mapping_size, i.e. 256KB > 252KB. Yet,
> > the max size corresponding to the max number of slots should
> > be 256KB. So, I feel that this is marginally safe?
>=20
> Yes, in the specific case you tested.  But I don't think the general
> case is safe.  In your specific case, the "size" argument to
> iommu_dma_map_page() is presumably 252 Kbytes because that's
> what your new iommu_dma_max_mapping_size() returns.
> iommu_dma_map_page() calls iova_align() to round up the 252K
> to 256K.  Also in your specific case, the "offset" argument to
> iommu_dma_map_page() is 0, so the "phys" variable (which embeds
> the offset) passed to swiotlb_tbl_map_single() is aligned on a
> 64 Kbyte page boundary.   swiotlb_tbl_map_single() then
> computes an offset in the orig_addr (i.e., "phys") based on the
> DMA min_align_mask (4 Kbytes), and that value is 0 in your specific
> case.  swiotlb_tbl_map_single() then calls swiotlb_find_slots()
> specifying a size that is 256K bytes plus an offset of 0, so everything
> works.
>=20
> But what if the original offset passed to iommu_dma_map_page()
> is 3 Kbytes (for example)?   swiotlb_tbl_map_single() will have an
> orig_addr that is offset from a page boundary by 3 Kbytes.  The
> value passed to swiotlb_find_slots() will be 256 Kbytes plus an
> offset of 3 Kbytes, which is too big.
>=20
> >
> > With that being said, there seems to be a 4KB size waste, due
> > to aligning with the iommu_domain granule, in this particular
> > alloc_size=3D256KB case?
> >
> > On the other hand, if swiotlb_max_mapping_size was subtracted
> > by 64KB (granule=3D64KB), i.e. alloc_size=3D192KB, which seems to
> > generate more swiotlb fragments?
>=20
> dma_max_mapping_size() returns a fixed value for a particular
> device, so the fixed value must be conversative enough to handle
> dma_map_page() calls with a non-zero offset (or the similar
> dma_map_sg() where the scatter/gather list has non-zero
> offsets).  So yes, the higher layers must limit I/O size, which
> can produce more separate I/Os and swiotlb fragments to
> fulfill an original request that is 256 Kbytes or larger.  The
> same thing happens with 4K page size in that a 256K I/O
> gets broken into a 252K I/O and a 4K I/O if the swiotlb is
> being used.
>=20
> I'm trying to think through if there's a way to make things
> work with iommu_max_mapping_size() being less
> conversative than subtracting the full granule size.  I'm
> doubtful that there is.
>=20

With the current interface between iommu_dma_map_page()
and swiotlb_tbl_map_single(), iommu_max_mapping_size()
really has no choice but to be more conservative and subtract
the full granule size.

The underlying problem is how iommu_dma_map_page() and
swiotlb_tbl_map_single() interact.  iommu_dma_map_page()
rounds up the size to a granule boundary, and then
swiotlb_tbl_map_single() adds the offset modulo DMA
min_align_mask.  These steps should be done in the opposite
order -- first add the offset then do the rounding up.  With
that opposite order, iommu_max_mapping_size() could be
less conservative and be based solely on min_align_mask.

I could see using the following approach, where alignment
and rounding up are both done in swiotlb_tbl_map_single(),
based on the alloc_align_mask parameter.  Conceptually it
makes sense to align the start and the end of the allocated
buffer in the same function rather than splitting them.

1.  Remove the alloc_size parameter from
swiotlb_tbl_map_single(). Fixup two other call sites, where
alloc_size is redundant anyway.

2.  swiotlb_tbl_map_single() calculates its own local
alloc_size as map_size + offset, rounded up based on
alloc_align_mask.  If alloc_align_mask is zero, this
rounding up is a no-op, and alloc_size equals map_size
+ offset.  Pass this local alloc_size to swiotlb_find_slots.

3. iommu_dma_map_page() removes the iova_align() call
just prior to invoking swiotlb_tbl_map_single().

Looking at the code, there are also problems in
iommu_dma_map_page() in zero'ing out portions of the
allocated swiotlb buffer.  Evidently the zero'ing is done
to avoid giving an untrusted device DMA access to kernel
memory areas that could contain random information
that's sensitive.  But I see these issues in the code:

1.  The zero'ing doesn't cover any "padding" at the
beginning of the swiotlb buffer due to min_align_mask
offsetting.  The cover letter for the last set of changes in
this area explicitly says that such padding isn't zero'ed [1]
but I can't reconcile why.  The swiotlb *does* allocate
padding slots at the beginning, even in the 5.16 kernel
when those commits first went in.  Maybe I'm missing
something.

2.  With commit 901c7280ca0d, swiotlb_tbl_map_single()
always calls swiotlb_bounce(), which initializes the
mapped portion regardless of the DMA xfer direction.  But
then in the case of DMA_FROM_DEVICE (i.e., read I/Os)
iommu_dma_map_page() will zero what swiotlb_bounce()
already initialized.  The discussion that led to commit
901c7280ca0d concluded that the buffer must be
initialized to the ultimate target buffer contents so that
partial reads don't change data that wasn't read. This
zero'ing violates that and should be removed (unless
there's some unique handling of untrusted devices I'm
not aware of).

3.  If the swiotlb path is taken for reasons other than an
untrusted device, iommu_dma_map_page() still does the
zero'ing.  That doesn't break anything, but it seems wasteful
as there could be a lot of padding area that is unnecessarily
zero'ed in the dma_kmalloc_needs_bounce() case, especially
if the IOMMU granule is 64K.

Net, it seems like some additional work beyond Patch 5
of Will's series is needed to get Nicolin's path working
robustly.  I could help with coding, but I can't test IOMMU
paths as I only have access to VMs (x64 and arm64).

Michael

[1] https://lore.kernel.org/all/20210929023300.335969-1-stevensd@google.com=
/

