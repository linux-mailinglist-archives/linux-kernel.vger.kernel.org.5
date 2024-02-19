Return-Path: <linux-kernel+bounces-70694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D4859B39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F921C21913
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B76FB3;
	Mon, 19 Feb 2024 04:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J7U+Li3r"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C8FC14
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315527; cv=fail; b=Evf6mgjDlzsLPVMphNGbr1UxGOR/joWsECevTuNSXbZ2Z92FzXjSNNIZtb5MVocLbkad5Z5XIl40oDIgFVOQXUxfyLhnatwMLPovJ6qdYVhs+i5WkNhrNb8jvzXjO1WhCvzLoIJsZm7oGjocg3gWTNL/ctYsrnLcpnUExFBWOgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315527; c=relaxed/simple;
	bh=JlQq9Hf3i8LUCt8C66iDpqP6DSxepEzrzSkk717SyH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RnBxvjzHHdXdEVgEKLERsVLk6Q56ZLY0gGz0xekzhh++mR82Lu1bsfzfEyJCbsdhyrvD03E5aVrtzwM52doSVKj0fgJlwL27zftKFSRttcj3NdvfAH4qv/gjBDl2X4huWOQb/+0vpQQTvTK2mQKZ3PU30tvQ7QMx31RXJptL+ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J7U+Li3r; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJWUUCu9V//Hz20RbQEBCZDsdd1cVdAoLaE76HqqfxH1bO7UkrWK3kZ0YLiZqRpyl6Ij4gIH6szzasgdm1ZB/Hl5k4/7YFO0KJVQbYQjsS2ze7mr9e4nO8S9l2SZ0nBoLg4JP/3KgmioTbXgCQHfVGasof5vubyH1b3WKjtsLZ+IaA1Nm6ZtX2pLnSywyxVLPz0QQ5sKdjZS8AVgJSsoowP+lnQ+rklONS5l7G0UAEyi7thYUH2p9kAd/E1ttfaRd3EdWvSJ/ZT9WpcxrCalTBYIut0J0SHO/Y9c3ZsIFs9G6OQDFNwmCRj6TRK+VPdNvzisDNg4n/KC53l4oNPfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J39Dnd2MumH5J/SmDawaxEGDem4hRti0qdi0FdqQSJU=;
 b=ER7WoHvBmEhuq79tb821iOX4iw4BUb23gB/HQaMSxr4e7m81e3oVzDhh1AkTR7dbdAGaU5/ES/+o2YWoAGwDdhSFhN+bP6kwxJP/uxrX6oY5HGdM2hj1hPDOrJBa6piNmx3Qdkb/5iunslF5GuCvsd3Hf31cZnKLrKfT/b+qernBN4AnorWi1yWrUNi/QcWr309zdtROOyclDKGLe906OC1iMM2vfkyUJ4s8QQDlKfDbXpxZcIz00I2OsnGFCCn2jYHEEStbaCkZVdu8hIGD42dvILksv3+zBJbCLEJhBMQDvHJuSVSUIamdV1zvHsr/y2ROsgFzr2Z+F7OG6tUyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J39Dnd2MumH5J/SmDawaxEGDem4hRti0qdi0FdqQSJU=;
 b=J7U+Li3rhvIf1dHmojmKQwxXfLmNWX6qUy4uH/tHlxQEy2nF6V8VffUbrjlFd0SThXPOlYnC5PiOe2nb4Z3zgCA6lEeCJuFmDmQrDGu/LZ5mK8CGD6BKMsnq6Em9bTEKxtsxZzNaunAJRNAYIwYjj/l2Nqf4yN16g9JuepV5BUVJXg7ZrimKr/+cOyxh0uszKF78U/KQbEFEPiL8VYy5wGVy4DsIwgfkHEi/WX7EEc12KmeV2Lbk1bPS1rnpjQmmI4klTtQd0q4XFhW+wpniIbdbUj5CSSmqNE8VJ4dtRL3wMbY+PznSMH6H/UjIm9nHbkFzG2c8wsj/QmVkime4cA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB9306.namprd02.prod.outlook.com (2603:10b6:510:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 04:05:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 04:05:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "murphyt7@tcd.ie"
	<murphyt7@tcd.ie>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Thread-Topic: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Thread-Index: AQHaXsdY2hY8FHuVH0OgB2HEIx34KrEMIFuIgAHkEM6AAv1hkA==
Date: Mon, 19 Feb 2024 04:05:21 +0000
Message-ID:
 <SN6PR02MB415727E61B5295C259CCB268D4512@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck> <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
 <20240215142208.GA753@willie-the-truck>
 <20240215163544.GA821@willie-the-truck> <Zc6rr/LleQ2krkyg@Asurada-Nvidia>
 <20240216161312.GA2203@willie-the-truck> <ZdBB8BYsK6WvwTYC@Asurada-Nvidia>
In-Reply-To: <ZdBB8BYsK6WvwTYC@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [TrVk5r2PbCrpjitjJwjY2FvI0idzTKcH]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB9306:EE_
x-ms-office365-filtering-correlation-id: 31361407-6fdd-4705-1f14-08dc30fffde6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WFa386AK9sjyx8EPlLNLBLH7dwgVcNR929zzvye+0rA1dKir0WIRsOpLl9tkTyAk+2PFOtyU2S3XjASLgK9ezvA15YHCZSJj5VrGE/l40YEpBnbNVynes496EzF2JuJTYztj7VG6idS/HJ17mLtwhbV2xoVUe81E96u06zh1gFuxDk/D6myaJYEDh1POGXbO7cOHD12JPyUEIHgADwTBk+RJLXq557royNxL9erzs3iPDAGCo8PtdLFw4KvqQjo7VzO6cTqvPSsya0r1dNA2JpEAJuDNbdlwfgeM2Cvx6UpPWS/wEZnHEFcoVzL+mcsr+AdyWfYHjC8cN+KX9jmkT+7bLqJxFNe1VvTznqjRufIIV7xzarBgqQxFiG9yzcgEtXtFJ4FLv4nleC67kQ5XOanMSDffo3BYZ11DbTO1yuuAqra8u7Zbg/Zwx/cqSW7C3B5CoyAyuMMzsadU9CJ+SNBSl0GoqrRKW7JL6nWZT9RLduLqVfocH5XFPj+N/G+XkVjTO+FKED/xb7VPnrTYeB+xFJK2x+jfN4mTVEHXdw4igOet85mErwG8izpX2TT0
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?spgFDXiPBJ10uCECrW9KqMSXuU3pbwim5MsjP10nKuaLBall/+0pn/tXr5cR?=
 =?us-ascii?Q?8QhWdXgsn+FmqBENdTqw+Df81qUdkAbZYGxs83EfUtwQj6hVScX3vkTJa/m1?=
 =?us-ascii?Q?jRK0J564d3ckFHcacQdgRLlIxO0QC+72KRkAXy5joGhnssmESfaCmGVq79AG?=
 =?us-ascii?Q?fhqeY2CeneDVzelxYaVQb1LTVT6JIX4NSYZ5NG2eCWbKYNFQCe1P3iU6v3zA?=
 =?us-ascii?Q?rWRmqoUbwYkUGBrGy4sN+wTROCC7HcnbYymQzeaDIjFIWGYDFwZ9sfezneRg?=
 =?us-ascii?Q?DcY3YCTQNslhd5M0VakkD/icVT9FcJ3XkTr2FxjjzI6vHg6XJ3UukSKb1FwS?=
 =?us-ascii?Q?Cr2zs+QjnonlBtyyrOlIKLFg7OVUi7NyYbvSRNsnFVRcwTMX/rRIpyCbJx49?=
 =?us-ascii?Q?844iCBfCWEn6G9f/eEjTA+rHNrGoGOSU+NZLjEcbY0LWPhvF+G1/geQAaj03?=
 =?us-ascii?Q?5beDXh3c1xHIOtEVmVVmD2I+DqEOSNaB1juKSglgPX2MqlBs9LQA3L03mY9R?=
 =?us-ascii?Q?M2gmJJ4IGBsNOM64HJMwQVpNfVYMqv8e6k8ddCN8s34/6dhVOb89gxQPelMS?=
 =?us-ascii?Q?ubvx5jE+UfF6Zlp5DYEJyAjRful26Pkwdh3eIgn3+BtSTeHoJch9sYPkxtlz?=
 =?us-ascii?Q?1xcF54es7Q/Cy0lcRKnGCjSFtGErbefLqmboDSvnn2mQXQcbNwr2D+g9dLJV?=
 =?us-ascii?Q?DyzkvvFifPwWpeYrfjZTXz61YRoxq4hSbxOvUGDGDB59aURD/a6y55E3k6dT?=
 =?us-ascii?Q?Tn12zfvgg6ptiCKhqDg5ESBCXLJNIj15Xnc1GfXMi+PacpEstI5fYuwOCcZG?=
 =?us-ascii?Q?lkWhSKksZshDHbtGvWGBdf+NK0dQr4S9Zl/cw5YpkB8/Jq8YFiBpwIMJQ/kQ?=
 =?us-ascii?Q?i0T6TyGMKjBdQ8vLAkYTUTNVSWEbYtw3DJSP4g9EAGt4AGz72sAsYdyRpTUW?=
 =?us-ascii?Q?s80buZAGRHQ7UmOVvm6/G55MhgQ4ua/bilUwAZdNmKbMZsrsRbbLf4G2VjYJ?=
 =?us-ascii?Q?pvWcblwTKnoNG5bF29a2OvgDYjsCWJHO+YGUoJz0Kx37MYhCLSxP2BcwwxL3?=
 =?us-ascii?Q?n9/CI5ovJoRISYVg8Xjq0SvkXDvIDitcaV5mpIG222xiCm+/boXGrj3X9Mvc?=
 =?us-ascii?Q?SO3SZjgzq3M11YUmyhWArgRR0xS9moxscd7jDeNXpPNxaqD+qGwoIRHe5It8?=
 =?us-ascii?Q?6W35xOezKql+yehozTjY4L3AYvMuPAiVywTCkQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31361407-6fdd-4705-1f14-08dc30fffde6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 04:05:21.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9306

From: Nicolin Chen <nicolinc@nvidia.com> Sent: Friday, February 16, 2024 9:=
20 PM
>=20
> Hi Will,
>=20
> On Fri, Feb 16, 2024 at 04:13:12PM +0000, Will Deacon wrote:
> > On Thu, Feb 15, 2024 at 04:26:23PM -0800, Nicolin Chen wrote:
> > > On Thu, Feb 15, 2024 at 04:35:45PM +0000, Will Deacon wrote:
> > > > On Thu, Feb 15, 2024 at 02:22:09PM +0000, Will Deacon wrote:
> > > > > On Wed, Feb 14, 2024 at 11:57:32AM -0800, Nicolin Chen wrote:
> > > > > > On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> > > > > > > On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > > > > > And it seems to get worse, as even a 64KB mapping is failing:
> > > > > > [    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 6=
5536 bytes), total 32768 (slots), used 0 (slots)
> > > > > >
> > > > > > With a printk, I found the iotlb_align_mask isn't correct:
> > > > > >    swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align=
_mask 0x800
> > > > > >
> > > > > > But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
> > > > > > mapping..
> > > > >
> > > > > Hmm. A mask of 0x7ff doesn't make a lot of sense given that the s=
labs
> > > > > are 2KiB aligned. I'll try plugging in some of the constants you =
have
> > > > > here, as something definitely isn't right...
> > > >
> > > > Sorry, another ask: please can you print 'orig_addr' in the case of=
 the
> > > > failing allocation?
> > >
> > > I added nvme_print_sgl() in the nvme-pci driver before its
> > > dma_map_sgtable() call, so the orig_addr isn't aligned with
> > > PAGE_SIZE=3D64K or NVME_CTRL_PAGE_SIZE=3D4K:
> > >  sg[0] phys_addr:0x0000000105774600 offset:17920 length:512 dma_addre=
ss:0x0000000000000000 dma_length:0
> > >
> > > Also attaching some verbose logs, in case you'd like to check:
> > >    nvme 0000:00:01.0: swiotlb_area_find_slots: dma_get_min_align_mask=
 0xfff, IO_TLB_SIZE 0xfffff7ff
> > >    nvme 0000:00:01.0: swiotlb_area_find_slots: alloc_align_mask 0xfff=
f, iotlb_align_mask 0x7ff
> > >    nvme 0000:00:01.0: swiotlb_area_find_slots: stride 0x20, max 0xfff=
f
> > >    nvme 0000:00:01.0: swiotlb_area_find_slots: tlb_addr=3D0xbd830000,=
 iotlb_align_mask=3D0x7ff, alloc_align_mask=3D0xffff
> > > =3D> nvme 0000:00:01.0: swiotlb_area_find_slots: orig_addr=3D0x105774=
600, iotlb_align_mask=3D0x7ff
> >
> > With my patches, I think 'iotlb_align_mask' will be 0x800 here, so this
>=20
> Oops, my bad. I forgot to revert the part that I mentioned in
> my previous reply.
>=20
> > particular allocation might be alright, however I think I'm starting to
> > see the wider problem. The IOMMU code is asking for a 64k-aligned
> > allocation so that it can map it safely, but at the same time
> > dma_get_min_align_mask() is asking for congruence in the 4k NVME page
> > offset. Now, because we're going to allocate a 64k-aligned mapping and
> > offset it, I think the NVME alignment will just fall out in the wash an=
d
> > checking the 'orig_addr' (which includes the offset) is wrong.
> >
> > So perhaps this diff (which I'm sadly not able to test) will help? You'=
ll
> > want to apply it on top of my other patches. The idea is to ignore the
> > bits of 'orig_addr' which will be aligned automatically by offseting fr=
om
> > the aligned allocation. I fixed the max() thing too, although that's on=
ly
> > an issue for older kernels.
>=20
> Yea, I tested all 4 patches. They still failed at some large
> mapping, until I added on top of them my PATCH-1 implementing
> the max_mapping_size op. IOW, with your patches it looks like
> 252KB max_mapping_size is working :)
>=20
> Though we seem to have a solution now, I hope we can make it
> applicable to older kernels too. The mapping failure on arm64
> with PAGE_SIZE=3D64KB looks like a regression to me, since dma-
> iommu started to use swiotlb bounce buffer.
>=20
> Thanks
> Nicolin
>=20
> > --->8
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 283eea33dd22..4a000d97f568 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *=
dev, struct io_tlb_pool *pool
> >         dma_addr_t tbl_dma_addr =3D
> >                 phys_to_dma_unencrypted(dev, pool->start) & boundary_ma=
sk;
> >         unsigned long max_slots =3D get_max_slots(boundary_mask);
> > -       unsigned int iotlb_align_mask =3D
> > -               dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> > +       unsigned int iotlb_align_mask =3D dma_get_min_align_mask(dev);
> >         unsigned int nslots =3D nr_slots(alloc_size), stride;
> >         unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> >         unsigned int index, slots_checked, count =3D 0, i;
> > @@ -993,6 +992,9 @@ static int swiotlb_search_pool_area(struct device *=
dev, struct io_tlb_pool *pool
> >         BUG_ON(!nslots);
> >         BUG_ON(area_index >=3D pool->nareas);
> >
> > +       alloc_align_mask |=3D (IO_TLB_SIZE - 1);
> > +       iotlb_align_mask &=3D ~alloc_align_mask;
> > +
> >         /*
> >          * For mappings with an alignment requirement don't bother loop=
ing to
> >          * unaligned slots once we found an aligned one.
> > @@ -1004,7 +1006,7 @@ static int swiotlb_search_pool_area(struct device=
 *dev, struct io_tlb_pool *pool
> >          * allocations.
> >          */
> >         if (alloc_size >=3D PAGE_SIZE)
> > -               stride =3D max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> > +               stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> >
> >         spin_lock_irqsave(&area->lock, flags);
> >         if (unlikely(nslots > pool->area_nslabs - area->used))
> >

This thread prompted me to test another scenario similar to Nicolin's, and
on the DMA direct map path I saw failures like Nicolin's.  Will's Patch 1/3
fixes my scenario, though I'm still looking at the details to convince myse=
lf
that it is fully correct, even with the above tweak.

Here's my scenario:
* ARM64 VM with 8 vCPUs running in the Azure public cloud
* Linux 6.8-rc4 kernel built with 64 Kbyte pages
* Using the Azure/Hyper-V synthetic storage driver (drivers/scsi/storvsc_dr=
v.c).
   This driver sets dma_min_align_mask to 4 Kbytes, because the DMA
   descriptors sent to the Hyper-V host are always in 4K units, regardless =
of
   the guest page size.
* Running with the standard 64 Mbytes swiotlb size.  Added swiotlb=3Dforce
   on the kernel boot line, to see if it could handle the scenario.  This
   simulates what CoCo VMs do on the x86 side.  We don't have arm64
   CoCo VMs, so the scenario is artificial for the moment.  But it ought
   to work.
* There's no vIOMMU in the VM, so all DMA requests go through the
   DMA direct map path, not the IOMMU path (which is Nicolin's scenario)

In my scenario, the block layer generates I/O requests up to 252 Kbytes in
size.   But with the unmodified 6.8-rc4 code, these requests fail to be map=
ped
in the swiotlb even though there's plenty of space available.  Here's why:

The 252 Kbyte request size is determined by the block layer, ultimately
based on the value returned by swiotlb_max_mapping_size(), which is
based on the dma_min_align_mask, which is 4K in my scenario.  But the
current upstream code in swiotlb_search_pool_area() adds ~PAGE_MASK
into the iotlb_align_mask, which increases the alignment requirement.
With the increased alignment, the offset in orig_addr is likely larger than
4 Kbytes, and that offset plus 252 Kbytes no longer fits in the 256 Kbyte
swiotlb limit.  swiotlb_search_pool_area() can never find a slot with
enough space.  (We could easily add a WARN_ON in
swiotlb_search_pool_area() to catch such an occurrence.)

Will's Patch 1/3 fixes this problem by using PAGE_SIZE/PAGE_SHIFT
only to compute the stride, and does not add ~PAGE_MASK into
iotlb_align_mask.  In my scenario with Will's patch, iotlb_align_mask
expresses a 4 Kbyte alignment requirement, and
swiotlb_search_pool_area() succeeds for a 252 Kbyte request.

But what about the alloc_align_mask argument to
swiotlb_search_pool_area()?  If it increases the alignment beyond
what swiotlb_max_mapping_size() is based on, the same problem
will occur.  This is what happens in Nicolin's scenario when the
NVMe driver sets dma_min_align_mask to 4K, but the dma-iommu
code passes a larger value in alloc_align_mask.  The later version of
Nicolin's Patch 1/2 that uses iovad.granule in
iommu_dma_max_mapping_size() solves the immediate problem.
But something still seems messed up, because the value from
iommu_dma_max_mapping_size() must be coordinated with the
value passed as the alloc_align_mask argument.

Will's 3-patch series is based on a different scenario -- the
swiotlb_alloc() case.  Patch 3 of his series also uses the
alloc_align_mask argument, and I haven't thought through
all the implications.

Finally, there's this comment in swiotlb_search_pool_area():

        /*
         * For allocations of PAGE_SIZE or larger only look for page aligne=
d
         * allocations.
         */

The comment has been around for a while, and it confused me.
It seems to apply only for the swiotlb_alloc() case when
orig_addr is zero. From what I can tell, allocations for DMA
mapping purposes don't do such alignment.  Or is there some
other meaning to that comment that I'm missing?

Michael

