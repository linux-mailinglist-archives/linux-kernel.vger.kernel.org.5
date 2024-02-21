Return-Path: <linux-kernel+bounces-75669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9273985ED29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EB9B22381
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741612BE83;
	Wed, 21 Feb 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ruoOGsNr"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2061.outbound.protection.outlook.com [40.92.45.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AB129A8D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558774; cv=fail; b=icTnfY0waC/ayjFGf7DoA1mQJQUhFZ3NkHYRPF7sLxCZa9StUCpXPiVXH3UQgzGBWnkKTgLrYcMsN3r87aNy0GiYMtzi8TKbGbOOUXk9vIXSz2R7Gf6SCaIIB0HJijju3CJy1l59SR0RPKCq/xCRCdddRvgKB9f7/cvjQgynuBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558774; c=relaxed/simple;
	bh=4lswZVKdUqweJvTKeVDv7diZeyp85LldZLKbUku0RiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3qjasiMS4yUdHltPa41U+glJQsF+pDhtURWLoXEBy26lyHcAqR5d4GepELyiLrT7LDUWGMrbdeGHdZ/QpSByJObMchLE9xsPaOEJ/RtNCSR6nGGXvwJ72RVFEJfgCcQxhZbr1srffF9FmXEQGhxdHpiaYaTagW0x0vPX8kDpic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ruoOGsNr; arc=fail smtp.client-ip=40.92.45.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkdE6iCK2QDk2InK665ZMI6t5Bieb5eveu1OjSefET96Cx2nwuTEtez7nLL+HiWO+5ZD8miADS+HSS4U2ik7eZa/lwcYHsUTYrlDolhCLRYV2NFqhHJAzHuoXaEHR5X+lD1tV7ShJFdVQQTpsgkGXCfqUXGfL7wh/YqZ2Yn3ItVfOW8HdGTxMU4PEyrX+Xqj50wlR8IAjOBSvu4EIpTa4p13rBUCZubw8FyeppQAg/QjTK813T7x6oU37KS09gscRymdYh5ZFcdouR11vB3mWZkG+aScZtZpHP8xvcSdYCnimfsGwrF1USxxrmusYEX/+Bel+ljp0xJIgyoKFHpWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhKQCx48RxySEcX/ZvRxa8G1C4073mnmrxpQjPmQheI=;
 b=QKAlF5GNzSeDdrJgM+hAolaZY+FfovuExD8rYEHrsak9krfEwftbNFm2qJhJrBkNWk8fml5rtMHe1hiuyieEQZZM+sAsnhGyD0g/OBk+qiUqRmReIq1T1t6TTz9VCjt4PJji7Xj4uO7LFUNvFRRlGr82pZSjak5IDsAPI+Si3sMU0qW+/SJtxpIekEAJK1i5BnhBDrDLe6D0L4ZU1e8hvSruJmGTi4q1pQLUjbt41TdeOGbrk/Xs+D8CLH1DIfnmMpRZQ5Ip0BZu5LSYKunLfsxw1c5t3Uk00M19nHE0FeeHYbVxHpN7DXy5RRxvlnaT0muoeVrUHnLVnQ2RbfnwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhKQCx48RxySEcX/ZvRxa8G1C4073mnmrxpQjPmQheI=;
 b=ruoOGsNrwmMrGWrWHaUO7u8Y42u9ErGYkoldJ86cGrBrLJ6P9qCnQ1W+cyJA4x9uTZFM48sLUgstvlrffdlrMq6JEW9pnP+aUx03Jm1ZYrJQTAXzvpWkDjlXhkxPoItdjTVTOmkfhvjfreO+L7tdlBLyCXGHjdHxFig7xpxUaIW+mFDp7PmIg+rf+N9pfWMaKvCFTjsn63Kuv6mdWvohkA3bK+W1sBhVmG2sani1E5vPmGDWVs0TIH4qAxb97GQ4XiboxzWyyktMAy64Lz8iwiQ1NIrMVTYW4DPh1bn8gos5wmlkEKwZyx75ZRAecazG9Yuvchj1hy7xsE0WZ+8ZAQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9754.namprd02.prod.outlook.com (2603:10b6:a03:539::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 23:39:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 23:39:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Topic: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Index: AQHaZLoRyKgMK9jLMUWPn0GpqcfvobEVbBTg
Date: Wed, 21 Feb 2024 23:39:29 +0000
Message-ID:
 <SN6PR02MB4157828120FB7D3408CEC991D4572@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
In-Reply-To: <20240221113504.7161-6-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [itU/x0jPRNFTtH/P66nzon3Zz+bWEDq+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9754:EE_
x-ms-office365-filtering-correlation-id: 7dc37c86-4795-4f59-c957-08dc33365913
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QcBxPbmBvEWLigKby7fHsgHPeOr1CzsKrKuAZ9TjgV8kXb0OvWqxG12N8RZj8Y7stdCHSh9cByacsu9ZLw8QL/oHlufrNgRw4UNF5GRjb1kJUZo/gU+sDntpY2zaHE29BOansdtxkQP4lt60+7h30W/9vF83aAfyLFS3DgrO2GvxJV2YuQjA2m52xQ9xYF880Ckdte0tYzvUbxsJ1cmLx1Pa8bSdwti561IgnTPjInOlbq0rVFhwn24rEmc7898TKq0xHgj855ZA5jlde6D052Q3BKawTNwDg0/T5flYjcz2aUllkWohbtPOCGQmERklVJkWPCMp/eeeQ1ba/7FFFoH7Qk75bT5Pvtsmzl6daceaFOIS17K+m0sIkOM07AzGtxRgHPGffHamfYkhkWpzX9Xj0P3WdAzGTb5EdObERFJNxSq/Ks5RnO5dzDNaO3lO62JYNqMotqg5591Y4Svn6/kweF2d4UVfquH1T159HcOYmmzm98/XU4/JOjSp1PvoNYmvTSrdTpLYcrOD8MyyRAYaE6ENfsrmqrHOXEHEFy9lhOAm3W3WA1B+Yhew9355qy3BUSaEAffMfrMj2BKgCr0jcxF33t3hP+eCBCGvIG+Qk5GeSrjyJwKhAWlRO7BCe6qReopyDGGLanXX1hhUWw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BG6xJaHXf78fs/MYqELLopPDnShnyRWDzk0LBv4UYd3dqm9+o6EbTf4etjl3?=
 =?us-ascii?Q?FpvJVdmfDi+Gm6Uk63FkAbqbJSsgj2vmreZ8jJZR3Z9Ry1BpcgLlSRIDeCVi?=
 =?us-ascii?Q?nn6TSpMcpXJgyzf3VhhEERdsPzyCY6KEREv2izcyEW1tBfzm7l+0RLBhJOn9?=
 =?us-ascii?Q?YDMtorliHu5WAop/4w4VC9PUd7RU5HiSpOk/C2vKzWjeboPFPOb98Im6zrI9?=
 =?us-ascii?Q?nnynVTLA0kf+WBBCqGmUU1adijKhlmNDwucal4nvLQCmDAQUVmTQbtcMRYLf?=
 =?us-ascii?Q?e4sXymm7fFduynMRMo1JKR4f7F78EHc0PAiEmMHRbnOXZJHEVay9eTmuIYcG?=
 =?us-ascii?Q?WsZmnSFOZ6uoep3WPsVFzCaK0Ur1/4f5OqcDN0uHnABi9EM9VxUWTHsm6ij6?=
 =?us-ascii?Q?ujvKvGetHUrD+I0J5v5DbWFX/F4o+CJUOV54AyiCGkWD3/4ryDtvTab3dOg7?=
 =?us-ascii?Q?zLey2ZUzL2F/IJ6xkChI6N0AYbbG1b6qv/KC66Pm633v8u6FdeQtdGyOsJNe?=
 =?us-ascii?Q?7d3OFxowlY8NRHuwf7EuVqvaVY8NL5GH4nJI86jfxCP5IXJSrBADByoAXvxj?=
 =?us-ascii?Q?qMFfswjL3uUQG0AFJWSVoYdUwxDkhlEINV9O9ssFwiZJ8v4UQKu+Ntv5O21N?=
 =?us-ascii?Q?ol6Rbu77HeooRPq9N6kc365q1qQGUnyxhszP0Dbk2UNgK7uA5vjBEwTPOa2i?=
 =?us-ascii?Q?Kjk9cHcNKzlaCBQ0gcNIu1JWL3k7jM/Um6nGsbcaCoQVGE1LQwayu455BULl?=
 =?us-ascii?Q?v4Cf6fUkaGFAviD5ZK/hudEAD0dIfCb6nyrU2Kcsg/w5T7yDB4dHMVQyoCVt?=
 =?us-ascii?Q?OfxIfJxFgKfXuzrfuymXRerbQ8ahll9NiVgOSqhyJJy4e46+uf1UA2L+YnJS?=
 =?us-ascii?Q?sRIbM8/LqeCWAFdhCPKH9zxGuVjooK/UELiZNESDEEQo3H3TcrSoUB82DALE?=
 =?us-ascii?Q?u4w/lhr1c7LJeHVPEldeYq2aToPjhF/+siBi+fNanvb3mAj3NL/qoWim0iHV?=
 =?us-ascii?Q?F884AiOk11MdaL9wt96yHQqD4B2B83NGAvaE//FqjMVmUFxBL5SKDNGdELAQ?=
 =?us-ascii?Q?cjkkW+QPWMR6cU8KxIk/HklHoKMDYBwT/9NVLlDPb9uTnthGEc1Qpl+d3WPB?=
 =?us-ascii?Q?VlSlEnfRfcPAJkEJfxMzOmFF2YpREY1mXh+jrssJLu60VobVUpyYZ2jklbLq?=
 =?us-ascii?Q?Rrc3u6TOwtfC6TiVw9qLt9zZOtm1oUe4+vvBBA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc37c86-4795-4f59-c957-08dc33365913
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 23:39:29.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9754

From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 3:35=
 AM
>=20
> The swiotlb does not support a mapping size > swiotlb_max_mapping_size().
> On the other hand, with a 64KB PAGE_SIZE configuration, it's observed tha=
t
> an NVME device can map a size between 300KB~512KB, which certainly failed
> the swiotlb mappings, though the default pool of swiotlb has many slots:
>     systemd[1]: Started Journal Service.
>  =3D> nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total=
 32768
> (slots), used 32 (slots)
>     note: journal-offline[392] exited with irqs disabled
>     note: journal-offline[392] exited with preempt_count 1
>=20
> Call trace:
> [    3.099918]  swiotlb_tbl_map_single+0x214/0x240
> [    3.099921]  iommu_dma_map_page+0x218/0x328
> [    3.099928]  dma_map_page_attrs+0x2e8/0x3a0
> [    3.101985]  nvme_prep_rq.part.0+0x408/0x878 [nvme]
> [    3.102308]  nvme_queue_rqs+0xc0/0x300 [nvme]
> [    3.102313]  blk_mq_flush_plug_list.part.0+0x57c/0x600
> [    3.102321]  blk_add_rq_to_plug+0x180/0x2a0
> [    3.102323]  blk_mq_submit_bio+0x4c8/0x6b8
> [    3.103463]  __submit_bio+0x44/0x220
> [    3.103468]  submit_bio_noacct_nocheck+0x2b8/0x360
> [    3.103470]  submit_bio_noacct+0x180/0x6c8
> [    3.103471]  submit_bio+0x34/0x130
> [    3.103473]  ext4_bio_write_folio+0x5a4/0x8c8
> [    3.104766]  mpage_submit_folio+0xa0/0x100
> [    3.104769]  mpage_map_and_submit_buffers+0x1a4/0x400
> [    3.104771]  ext4_do_writepages+0x6a0/0xd78
> [    3.105615]  ext4_writepages+0x80/0x118
> [    3.105616]  do_writepages+0x90/0x1e8
> [    3.105619]  filemap_fdatawrite_wbc+0x94/0xe0
> [    3.105622]  __filemap_fdatawrite_range+0x68/0xb8
> [    3.106656]  file_write_and_wait_range+0x84/0x120
> [    3.106658]  ext4_sync_file+0x7c/0x4c0
> [    3.106660]  vfs_fsync_range+0x3c/0xa8
> [    3.106663]  do_fsync+0x44/0xc0
>=20
> Since untrusted devices might go down the swiotlb pathway with dma-iommu,
> these devices should not map a size larger than swiotlb_max_mapping_size.
>=20
> To fix this bug, add iommu_dma_max_mapping_size() for untrusted devices t=
o
> take into account swiotlb_max_mapping_size() v.s. iova_rcache_range() fro=
m
> the iommu_dma_opt_mapping_size().
>=20
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffer=
s")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Link: https://lore.kernel.org/all/ee51a3a5c32cf885b18f6416171802669f4a718=
a.1707851466.git.nicolinc@nvidia.com/
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 50ccc4f1ef81..7d1a20da6d94 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1706,6 +1706,13 @@ static size_t
> iommu_dma_opt_mapping_size(void)
>  	return iova_rcache_range();
>  }
>=20
> +static size_t iommu_dma_max_mapping_size(struct device *dev)
> +{
> +	if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
> +		return swiotlb_max_mapping_size(dev);
> +	return SIZE_MAX;
> +}
> +

In this [1] email, Nicolin had a version of this function that incorporated
the IOMMU granule.  For granules bigger than 4K, I think that's needed
so that when IOMMU code sets the swiotlb alloc_align_mask to the
IOMMU granule - 1, the larger offset plus the size won't exceed the
max number of slots.  swiotlb_max_mapping_size() by itself may
return a value that's too big when alloc_align_mask is used.

Michael

[1] https://lore.kernel.org/linux-iommu/SN6PR02MB415727E61B5295C259CCB268D4=
512@SN6PR02MB4157.namprd02.prod.outlook.com/T/#m14dd359c5a4dd13e6cb0c35cf94=
f8d746257ae48


>  static const struct dma_map_ops iommu_dma_ops =3D {
>  	.flags			=3D DMA_F_PCI_P2PDMA_SUPPORTED,
>  	.alloc			=3D iommu_dma_alloc,
> @@ -1728,6 +1735,7 @@ static const struct dma_map_ops iommu_dma_ops =3D {
>  	.unmap_resource		=3D iommu_dma_unmap_resource,
>  	.get_merge_boundary	=3D iommu_dma_get_merge_boundary,
>  	.opt_mapping_size	=3D iommu_dma_opt_mapping_size,
> +	.max_mapping_size       =3D iommu_dma_max_mapping_size,
>  };
>=20
>  /*
> --
> 2.44.0.rc0.258.g7320e95886-goog


