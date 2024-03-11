Return-Path: <linux-kernel+bounces-99573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D741878A20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDB11F218A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1956B85;
	Mon, 11 Mar 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j4wvOvZ5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2068.outbound.protection.outlook.com [40.92.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ABE54F83
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192975; cv=fail; b=scOFKv4J00OuaRVFmZgnkDXsJJy0Bt9HgXIrQpuNCfwhTG6DDkSzzokgEDrKe/D1cfnhRC/G+eIRQNiR9gv3Cbht7uqKqUQ9Aoa55G1ZVHOO9CEW4wox8O9DaBQuFSBWMwHafn4Aq317D6WwHIZ3XBpXMbzXOpyH38w0JVO5bPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192975; c=relaxed/simple;
	bh=Fgdxt3u+vwWm81bgg7gVLbaU0Ifyfzst4uyfAnB0K9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mliJwGnTE/KzOLv56fycfqsGSCPYYpVqIijWMCJF7DtjRlHkZdPjW29PFSsbFNEqz/feo7Q7LmKugGL3fSng4GjxS3nZjcl3GKQIV4DsWd6dPXKUVrk1Wuu8aVPShhnSuFj851EpT6I7NXQPhT6RCLzdMbnARHn8kG/LBk/epto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j4wvOvZ5; arc=fail smtp.client-ip=40.92.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+orG8GzhNakFcFnIHy9o4I8rFOIZy6CDAQ/94SqNMIwPuxfb6ctJdi+JFZeAdh3iYVywWEIcF6jenvKlPYi7Lssh8E2zsKpZt0dnEFy8eneGxhncErd0Trz+9ot5khgRXnWY1bSJaP2UMXBwtTdBxacvityeh3VaWOovxkyc7qv9tm/EdPSpTEjzp1Xp/NRFFpGwGTZIvMOGCgN9Z1JwOo78T2Ft1cjzH4HkMB6t5it/JYhCRDR8WGFzK0StLOuXZwZasHAnzk9OCwciNZhYXswKGWQkwiRoqeNvp0sMeyxuIXjf6NjFEMYcozoJZMPPIzKC5pUW8pv/nEd1c7eGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTr6cO7J+7NIm3ib1jmTCMej/l0UM99sMrgDr48Y4Cs=;
 b=GX7fizTRO9DaNvi2LWf3ZeAu32EZQY0ofk7DzcCmqzb6+Wel1GSlG9IbCkrTx1fM+zSfWuX+yE6Yr2RlIycySsJb++lkI77ZUyJsBRC+ukJ1hKtq/SBAuAPmx/l8MZqhFujPJ/ZGmmxt4EP8TDJqjEoG5LOMPHnf3/EocZINaHtus3CjfICyVj+VAbZK2E+E3hk6MEuqf6cHFOLBL0fY5ZpKOeaaMb415dFJeFPkwvdVQi6JQik7a5KhMMHedG1YS0Bt/wfUk+26Szfygf7/s3SXzrsHrppGachYO1/BwTpMhTciMFEX8K7WxQIBhNLKc/4zC07OrZ+LlY58BnuNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTr6cO7J+7NIm3ib1jmTCMej/l0UM99sMrgDr48Y4Cs=;
 b=j4wvOvZ5z0YoErBNWddtLhA0IrcpIk3w535sa9kWjCw4d3EEzwsebU1jzbaXFJbyRVtKHDOocu1jMO+6b5UZI7ulrPoayGMqX5lt92IodKQXqxDXulBrSyZtd4eMomliAAJnB2CFrl15N+l0IxdlKgVq6sbWijX4gpb/pxffopwiMGZPMILOoQ+fhl+BROe8JDq1bcbftrXAm16bWgUCTJybUrWTtJ/XqoO3QJ9ac7Sq9MeGfwiJcMczB7uQLp2c91scIFRdmEfvHmnGIBaf/OYn4MjHhxUAsDGFE4wsI7bQa2bHYtP3+Rv6V+VoOe8c3F53AVxmbwzLiO+2z2iT0g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9607.namprd02.prod.outlook.com (2603:10b6:208:40c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 11 Mar
 2024 21:36:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 21:36:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>, Will Deacon
	<will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v6 4/6] swiotlb: Fix alignment checks when both allocation
 and DMA masks are present
Thread-Topic: [PATCH v6 4/6] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Thread-Index: AQHacW1UX2JG3DS7FkeH1aW1bgiyobEy+/iAgAAVCNA=
Date: Mon, 11 Mar 2024 21:36:10 +0000
Message-ID:
 <SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-5-will@kernel.org>
 <20240311210507.217daf8b@meshulam.tesarici.cz>
In-Reply-To: <20240311210507.217daf8b@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [FsZCDT32mYTFaOV/n9aLLTxbJ7jutXUe]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9607:EE_
x-ms-office365-filtering-correlation-id: ca5d7429-2a15-4e82-ad2a-08dc421344e6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bhMIjCUf3PWPuK97BFChPFMDy2WClwPGOolOJluilBbPRdu3b+dCBYfMb9vCHX7aoYIaAz+0V1MpEAvodKZNHEJgzy4RzG5dNCgNHrtoHyczwnp0qRw6eYz+Wmi5kFhfY0UHa+Ofdv7kK6kFAscvGomL4ZmtFRv+pIobAKQWQV8kPHtX56znWfP8X1x4C7pCcbEALpqwh0GA7QMbjY6hq9cN/gLcUUyfYxL1qqL19G9V391KHGDGDXpwj4LWuPQNBpBYCDxxvdvTrseu1qzX4pDoKhkPlflRU0edvsOj/FYQ/l/wwssGRaPTgBC9HNIzoCLcMPcngWFTUZptHF94g5R+jAVSuZ85oj9pnt77p72KdvjaVUOsDwfVI6Uj25+qIllpI2G8eqfPmOsYjvFX7BSiEa21MGd3ZbscyVAt29NE0rVosi7KsA0mtyq8Xk4Y7FfgTqshxsTr0KOkViF9mBOQ9ojwF130PfvRCGYk5vYBpHE5qBMPH4OttQ1zHm1Wu2AJjyxXSXsll9sd8GbYFoBU5pU4ZAluDkY7xBRt8GkqIDH7qmgWOvXyr1f9xcQW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?wpurfSUiUjfWDkFAMhx0LsxEA6fIxJEcQEk35Vwn1WzPcbXXPVdHYq73M2?=
 =?iso-8859-2?Q?4WYZtR7OjkClgqP1eknQ7ejNWASkLyf+SHHBkWQrmujc3ONcXQ9UajoVlz?=
 =?iso-8859-2?Q?+Wtu3K5w+Wlb+ccbU5GJqaILr4+xEv6lsN0atPMwKWTpC2ZwtieTEO4Qp4?=
 =?iso-8859-2?Q?8P9b3+9Sq40OTKyNzsIu0Ko7ytE94jsypgkKg6yhsJwjPKFWDPqcz41zo0?=
 =?iso-8859-2?Q?CJg7beCGm2GJOh7QNYuTDF4tZLmiUsxS4RI4E0eRZ1VAhbFJEaGd8OZIsD?=
 =?iso-8859-2?Q?+GESGdrzq6dhn0XOJlDVdLM8BKalUrDq0ADIvwtMWfu6j2pXU9x1bjmnlb?=
 =?iso-8859-2?Q?a9m9fTS9ylpmX7UaJcxMI5UHS0J7vio40sW2zYnYjwcOcduXP14rb4h8me?=
 =?iso-8859-2?Q?8UoI68v8OEA1mP/FJlZw5V/FBFsOEc17XebSHTT3hpx53WAO0IJW9tlR4Y?=
 =?iso-8859-2?Q?xvNpO6v8gVM4HRKpANxej9yR57XMBwVvR5TurEtXZL6LIhvuPQDVybtiNb?=
 =?iso-8859-2?Q?J35MysA6r32EMRM/xD6Kzc/o1YUEip0JfUVfBmVEPCEF5qfskuxuh0mdX0?=
 =?iso-8859-2?Q?J1TRaO4EilLyrzbfLNQkYhEZvnX5D+BWuEZYzzZwL2o1iCXZ1yuDJVXjHa?=
 =?iso-8859-2?Q?klsrgq6BcHER25q/ltJ5fPKiELfmw1qGjQDWgOEnFekQIksVobDtReIano?=
 =?iso-8859-2?Q?Mu7unONIJFrqooJr/pmZDDqd25taHV75r7AR5pQAnVl00i60u6XVDAdijS?=
 =?iso-8859-2?Q?78ooNkWeIa8vBjAClaNoYQgTRBeRG1IInbBgxLJIGx8X9J2GukxBK0Ve9Z?=
 =?iso-8859-2?Q?u7CC50pC/eQLgZM7iv8diHkyF+1R+irFvPvtANFbQk/4Fazu26bZRoKceQ?=
 =?iso-8859-2?Q?e58g+S1fWdGRDcLGq3H437uWOOE2bpY/WYGPmXvx4n/uKTMYPoOplAerKx?=
 =?iso-8859-2?Q?hiYLIOAFhCiarge3B0RUnixcTSi+HxIbfcB70ZLCyCgWeG9hi4o+ueqmO6?=
 =?iso-8859-2?Q?QfasbyKn6Nh8y35WgC6GkQwX2Y04YpN57dvU/LpHd2bTuuHQPGQDEr+Yhi?=
 =?iso-8859-2?Q?E78arrMhMmf75ISWo+KDfl17nWGYKHJtvhMCBYDR5pi+7AqsT7cSw2dO1V?=
 =?iso-8859-2?Q?Pz/efyTRROGgU4Z1hr0o/hJaRkiIFU6lTsCMFqO9Kye4c3JdpECcy4kwem?=
 =?iso-8859-2?Q?lMsg8UnwSa/6iGZ7iHieAhPhc7f9ToG5pNFFlNMTaOzT5gVTm0maL3WvMc?=
 =?iso-8859-2?Q?pnQt8RhnM67gJ5iEi5YQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d7429-2a15-4e82-ad2a-08dc421344e6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:36:10.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9607

From: Petr Tesa=F8=EDk <petr@tesarici.cz>
> On Fri,  8 Mar 2024 15:28:27 +0000
> Will Deacon <will@kernel.org> wrote:

[snip]

> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index c20324fba814..c381a7ed718f 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *=
dev, struct io_tlb_pool *pool
> >  	dma_addr_t tbl_dma_addr =3D
> >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> >  	unsigned long max_slots =3D get_max_slots(boundary_mask);
> > -	unsigned int iotlb_align_mask =3D
> > -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> > +	unsigned int iotlb_align_mask =3D dma_get_min_align_mask(dev);
> >  	unsigned int nslots =3D nr_slots(alloc_size), stride;
> >  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> >  	unsigned int index, slots_checked, count =3D 0, i;
> > @@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct device =
*dev, struct io_tlb_pool *pool
> >  	BUG_ON(!nslots);
> >  	BUG_ON(area_index >=3D pool->nareas);
> >
> > +	/*
> > +	 * Ensure that the allocation is at least slot-aligned and update
> > +	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> > +	 * offsetting into the allocation.
> > +	 */
> > +	alloc_align_mask |=3D (IO_TLB_SIZE - 1);
> > +	iotlb_align_mask &=3D ~alloc_align_mask;
> > +
>=20
> I have started writing the KUnit test suite, and the results look
> incorrect to me for this case.
>=20
> I'm calling swiotlb_tbl_map_single() with:
>=20
> * alloc_align_mask =3D 0xfff
> * a device with min_align_mask =3D 0xfff
> * the 12 lowest bits of orig_addr are 0xfa0
>=20
> The min_align_mask becomes zero after the masking added by this patch,
> and the 12 lowest bits of the returned address are 0x7a0, i.e. not
> equal to 0xfa0.

The address returned by swiotlb_tbl_map_single() is the slot index
converted to an address, plus the offset modulo the min_align_mask for
the device.  The local variable "offset" in swiotlb_tbl_map_single()
should be 0xfa0.  The slot index should be an even number to meet
the alloc_align_mask requirement.  And the pool->start address should
be at least page aligned, producing a page-aligned address *before* the
offset is added. Can you debug which of these isn't true for the case
you are seeing?

>=20
> In other words, the min_align_mask constraint is not honored. Of course,
> given the above values, it is not possible to honor both min_align_mask
> and alloc_align_mask.=20

When orig_addr is specified and min_align_mask is set, alloc_align_mask
governs the address of the _allocated_ space, which is not necessarily the
returned physical address.  The min_align_mask may dictate some
pre-padding of size "offset" within the allocated space, and the returned
address is *after* that pre-padding.  In this way, both can be honored.

> I find it somewhat surprising that NVMe does not
> in fact require that the NVME_CTRL_PAGE_SHIFT low bits are preserved,
> as suggested by Nicolin's successful testing.
>=20
> Why is that?

I saw only one stack trace from Nicolin, and it was file system buffer
flushing code that initiated the I/O.  In such cases, it's very likely that=
 the
original address is at least 4K aligned.  Hence the offset is zero and
the low bits will typically be correct.

>=20
> Does IOMMU do some additional post-processing of the bounce buffer
> address to restore the value of bit 11?

Not that I can see.

>=20
> Or is this bit always zero in all real-world scenarios?

For file system initiated I/Os, probably yes.  But for raw disk I/Os
initiated from user space, not necessarily.

Michael

