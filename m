Return-Path: <linux-kernel+bounces-104549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5DA87CFA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F5EB21504
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E93C470;
	Fri, 15 Mar 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cnvBNO/9"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2017.outbound.protection.outlook.com [40.92.47.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1A288DB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514754; cv=fail; b=LfpddwaGHsg+Guy/2Bl1O+6Zp4abGg3fT0GwfjwPB2Cq/zUyOKKZeMwQfA6cCA9AR9ZTqYLb4DyQo6Mxx8BppkRgFb4FsMjmI1C2Xr7RsP9TSHwfQ/ZbnLeGZhVkN9C4dgyMJ4y7BTbiOOeL55QYYAgrtgiilfKn7AVTNrst/2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514754; c=relaxed/simple;
	bh=ZwpAm3Z6QXW4RHXdus5UgkDR+n6HhlHrFlHcHOFCFtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jhi17WdiLSw4avwNMt4rDRhmjluTcGH5AyWAa+7IWaVlv3Aonf3la3VzmSRmB0p0+Rj8MqW5Zjdfts+Vit5yytqDic3epnYBUXkNm6W/wTaR386nbRcfswYvlyn5si09w7+L4resWpMzlwod5k0ml7sgQbDv9aEJmBNMGJ8SnKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cnvBNO/9; arc=fail smtp.client-ip=40.92.47.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RINHmQ2iSTB7jSHNqkBaGgRCT+Jd+tOOvjQEUs++4uqpZhNQUNpdhm7kBOSOGHAOEtH3HxbfyGwmcC++LOodI3fQT+6upZ+922L0pxd16xUSQ/y5JLzEw/c8DDM4xKZgestT2Yen28okyQPOTcuIbHCGbz6QChSPCQGQxaYuvfcdAdNW7VIeclTvDIwuCfU/12sN7+zBCWS1WZf7IJr4cIM2uQHb9EuzTJhOjOjvCHD8ifessZqgKSuFAiegexudI/HuYXrjc/qaP4U3fjws1H5Kn8g4rZ4uAehIFgGH8xolJBLYmS+twIkJUzZ7osu9V9LDUl675Xs2Iqn/UqMcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE5I/MQbK+9Qb9Zx9DR90m++hmCCPyKNw83tZJA8NKs=;
 b=Rzy9/gQZhc+o25yWCodvQ9jvfutWwKGTAh2Dp0+jj5sNEfCirBQArTEXC9dgWzLK4xV4gz0gBR/EE/hXYstM9seYYK8hqRulXZHknkotlxzo3LlFD6/Zrq36EB49pSGlnc0s7/GGUCiiaUcDDVPnFiAiaRX+u+0Xcwxxw441mAxcPC7wYUhV3/k2WX7mcndJiewKht3XwRi9az+E5XTjUTfCeAdjalCOnayTHG6jB0483HQzkiLpG+VxBPKA+2pMEVUArUrez3aJ533nObkV8Hn0Hngrb/iWaB2tqGJhLSkbzBdiX1vvMWRINH/INGd8jcKNdYM3nQMDu/cwYxi6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE5I/MQbK+9Qb9Zx9DR90m++hmCCPyKNw83tZJA8NKs=;
 b=cnvBNO/9tMuwLAS0qqX1uAZHkDJDLkjjno6+Mnq4LPV+SnrmPEkemHqtECqpERdxgeABH3XpzpE7YvHxZ6rl6Yus6urvAOkXa4I2FFHfKhePzBZkTlHblVg6UZu6IwISS6D9RaKRRAQt01aelmvPlLZlfOx+Dx1a/N+j0l1zkbyDnTW869FN7jPnVyifhYfs+eHAq958SN8+StTAc5dgJzfoW9ht4ff+CeBLOk38/ET9VLD82syI2XCVD8Tb7unwZMMBUIDf06xYtlV1X4S0sD3pR+4PCMFevC898XNeiw2/4UWZr7aZnQlPGTwi4dTHTdY3ZSIErus00n6GtcEmiQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7671.namprd02.prod.outlook.com (2603:10b6:510:5a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 14:59:09 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 14:59:09 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>
CC: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Nicolin Chen
	<nicolinc@nvidia.com>, "open list:DMA MAPPING HELPERS"
	<iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, Roberto
 Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>
Subject: RE: [PATCH 1/1] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Topic: [PATCH 1/1] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Thread-Index: AQHadIMeoQfESfdw8E694i37J5NSp7E4FUDggACpqYCAACd/wA==
Date: Fri, 15 Mar 2024 14:59:08 +0000
Message-ID:
 <SN6PR02MB41574FB8FF2FA08C26682EC1D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240312134149.497-1-petrtesarik@huaweicloud.com>
	<SN6PR02MB4157FB27CD890E9F29408926D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240315132613.5a340a69@meshulam.tesarici.cz>
In-Reply-To: <20240315132613.5a340a69@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [4flMFyVbFYAxnhvdm981hmelx82ocXxV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7671:EE_
x-ms-office365-filtering-correlation-id: 5d78e5df-9721-4db1-9699-08dc45007788
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ar2mHgoHRUf1I9I4W20sZm1gs+K7VkmGyKaj2HByZcPvKf/e/ul7cWnzaVzmeXlsYENFLKGa2XIaQyo/w/xcfjFXQCX9lMgsjy802gzgDqMhmKsA+wllAB+gJqPzGab0BVzdjQRfOCYZvRCQMIE/fZxPRWp3RmCxFiG/6/pMTuvOfw3v3lCvYzZH7eZIGC5+uc+mPT0CRIonhsYaFz7pk+1a1eCEs/6WfLmC7pw6wD5ovFSIVKI7XAGIn4J7HKjROBQZX9k8p658UNZr+CPcxEiixxe/n+TNVLq6LtQ7YlJN2z/JBESuZMZYjc0+qH9tzHIPa5HPIuU8MZ10frus19GSFO6nKxdSroOA/v5jSUPtAaxjBurOmxvr1hqy7e4Eq1PHcZutf7ayhxpR/6JNJ7E2rIH0iMoGtzSbRcCEWuQBE2E33uCW/K21HBKNnAWXNWYKR+bhIlv/YNLtaRU2JilTD1A7LD/yA2a0cVXcsZ/OHJdcI3+WVyEadncS1p5PEVg+JScjxT7w5y6SV6XuGcOV+wOHFXzUxPGKcwlj4bJrQVzLRQsSOl3c+Wc9gRZD
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?HRfHFfmRDX8rSahOMFYHaN8cieFFa9OXfiCiu5lcpcTnhim+dout8G2ufI?=
 =?iso-8859-2?Q?uIGqAxaLDXnkIb4OHsYW/ui2K6gSlmaOS8vPnQBsnlMe7X2j9Ro6jJT6ld?=
 =?iso-8859-2?Q?9TkcH5zKKzirUkUR8A7ZKip8EYFiMQdrGxaQ/zlmowrhRD1yUdpM0ovFYC?=
 =?iso-8859-2?Q?YKVIWVwTA2y6D1CQUKHmf7e/z9tbSDvBK4xbIDVW0YDpMm7o8RoKGbMqO7?=
 =?iso-8859-2?Q?4AsmpY13kPud2VeFOTLOVQaX8fRFuPTCRzjVu8kaxSHC5oTEjHs/9pwOfK?=
 =?iso-8859-2?Q?p9AE1SxoN9xHaLLuW9UIZCegr8rSIZflOKG+tPoJblD1fzpQ3DNx99cwQg?=
 =?iso-8859-2?Q?S6OT0XomwJwCSgEQAm0baZuzIUr/H9Ra34XkH62PZPJaohlTABA8n7okfV?=
 =?iso-8859-2?Q?3UpDw9nukdaM8EPGoNAEB/eQaXTNk5uVfKkhEGiS3ndLGkb7U7kEIFcZ9a?=
 =?iso-8859-2?Q?QaOQ1BKdfOzfXHN3yuX6eaMCvnm37UhuAsFybukhY6Sp2X0NHtcXFl6XGG?=
 =?iso-8859-2?Q?Xt0YYfQemAKvtptkUbNJK9XpycWPXImJtD6Po1/DtrwRludaqFLqnmD9FJ?=
 =?iso-8859-2?Q?rn/eFIJjaqtnArtT4glBYgYF2PVNqJdqbP/uVmKQdQZvjL0EhqTITyo/v+?=
 =?iso-8859-2?Q?7IzjV9VLViYTtb/eLuoOEDgzc8gngEq2mxoLGVanERb3jocAZNk72NX1VY?=
 =?iso-8859-2?Q?Lqp+vvr6Aus7cEH7PbTiUrN15KV9uOgvcKr8Y7rO0nSKDE56jJ/cTgRJcv?=
 =?iso-8859-2?Q?0EU+OiUl7SO5Pm32dZbM1cjeMyUA6S6PesAt2l2GoBAcXRbd6oJsZJeWFA?=
 =?iso-8859-2?Q?SemQFPqnhyWcQC4etTMBrQX7PZXmTT73xFmaujN+rh7uHOsjZuOwoQfQQB?=
 =?iso-8859-2?Q?IlYZXAvBT8KMrNFlDJgrJCjOW3e7MaM7JLqR8whKZjIY+d8/cE8UmE2XRv?=
 =?iso-8859-2?Q?jV9spVi7y9171Xzlw2Z8n1objOPuUsDiEdAOlygpXejn/c0o7D1tDtnO2s?=
 =?iso-8859-2?Q?phbZe/vscXstkt97XmtdBDULSkJxvBOKy41JEONQFQ260hzmUzPccc6vhO?=
 =?iso-8859-2?Q?guBENBpXvdz+3JB2nYtWXxJ15MgdDbM00HHvAgV4qpu7OhT5BID0YezKgf?=
 =?iso-8859-2?Q?NULj/LZaEj1PPVv8MXLQrrYLhzhOvM6NX1mnKPodM33+V3V/omeyD3RXVd?=
 =?iso-8859-2?Q?3LvPoRgmXWDYqYZTd6GBNM+FUIMlhoLnL7LUXe0DMfoN9S5eMV9CXscTZP?=
 =?iso-8859-2?Q?5exjV8YT/qUqoBU9qHKw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d78e5df-9721-4db1-9699-08dc45007788
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 14:59:08.7459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7671

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Friday, March 15, 2024 5:26=
 AM
>=20
> On Fri, 15 Mar 2024 02:53:10 +0000
> Michael Kelley <mhklinux@outlook.com> wrote:
>=20
> > From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, March 1=
2, 2024 6:42 AM
> > >

[snip]

> > > @@ -1349,6 +1353,15 @@ phys_addr_t swiotlb_tbl_map_single(struct devi=
ce *dev, phys_addr_t orig_addr,
> > >  		return (phys_addr_t)DMA_MAPPING_ERROR;
> > >  	}
> > >
> > > +	/*
> > > +	 * Calculate buffer pre-padding within the allocated space. Use it =
to
> > > +	 * preserve the low bits of the original address according to devic=
e's
> > > +	 * min_align_mask. Limit the padding to alloc_align_mask or slot si=
ze
> > > +	 * (whichever is bigger); higher bits of the original address are
> > > +	 * preserved by selecting a suitable IO TLB slot.
> > > +	 */
> > > +	offset =3D orig_addr & dma_get_min_align_mask(dev) &
> > > +		(alloc_align_mask | (IO_TLB_SIZE - 1));
> > >  	index =3D swiotlb_find_slots(dev, orig_addr,
> > >  				   alloc_size + offset, alloc_align_mask, &pool);
> > >  	if (index =3D=3D -1) {
> > > @@ -1364,6 +1377,12 @@ phys_addr_t swiotlb_tbl_map_single(struct devi=
ce *dev, phys_addr_t orig_addr,
> > >  	 * This is needed when we sync the memory.  Then we sync the buffer=
 if
> > >  	 * needed.
> > >  	 */
> > > +	padding =3D 0;
> > > +	while (offset >=3D IO_TLB_SIZE) {
> > > +		pool->slots[index++].orig_addr =3D INVALID_PHYS_ADDR;
> > > +		pool->slots[index].padding =3D ++padding;
> > > +		offset -=3D IO_TLB_SIZE;
> > > +	}
> >
> > Looping to fill in the padding slots seems unnecessary.
> > The orig_addr field should already be initialized to
> > INVALID_PHYS_ADDR, and the padding field should already
> > be initialized to zero.
>=20
> Ack.
>=20
> > The value of "padding" should be just
> > (offset / IO_TLB_SIZE), and it only needs to be stored in the
> > first non-padding slot where swiotlb_release_slots() will
> > find it.
>=20
> This is also right. I asked myself the question what should happen if
> somebody passes a padding slot's address to swiotlb_tbl_unmap_single().
> Of course, it's an invalid address, but as a proponent of defensive
> programming, I still asked what would be the best response? If I store
> padding in each slot, the whole block is released. If I store it only
> in the first non-padding slot, some slots may leak.
>=20
> On a second thought, the resulting SWIOTLB state is consistent either
> way, and we don't to care about leaking some slots if a driver is
> buggy. Maybe it's even better, because the leak will be noticed.
>=20
> In short, I agree, let's keep the code simple.
>=20

One other thought:  Fundamentally, fixing the core problem
requires swiotlb_tbl_unmap_single() to have some information
it doesn't have in the current code.  It needs to know the
number of padding slots, so that it can free them correctly.
Your solution is to store the # of padding slots in the
io_tlb_slot array.

Another approach would be to have callers pass the
alloc_align_mask as an argument to swiotlb_tbl_unmap_single().
It can then calculate the offset and the number of padding
slots just like swiotlb_tbl_map_single() does.  Nothing
additional would need to be stored in the io_tlb_slot array.
The IOMMU code is the only caller than uses a non-zero
alloc_align_mask.  From a quick look at that code, the
unmap path has the iova_mask() available, so that would
work.  Other callers would pass zero, just like they do for
swiotlb_tbl_map_single().

I don't immediately have a strong opinion either way, but
it's something to think about a bit more.

Michael

