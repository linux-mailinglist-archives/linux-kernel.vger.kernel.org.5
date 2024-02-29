Return-Path: <linux-kernel+bounces-86150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE9286C076
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED581F228B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5933BBFA;
	Thu, 29 Feb 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CU/PGrhL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2107.outbound.protection.outlook.com [40.92.23.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFD3BBD8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709186231; cv=fail; b=QKm7/SZu3lql9SIyA7aSrHOArlyF9K79zW4G4EINAmuwGDIoBQHUmAzgLK1z0v5gBFlO7Nlv3XipqoUqUJKKleleV4RF1rqQCp309qFHbDjDLrstA1TQRsmO4Xl4IwbZcwJlwJ7kqauBMkTxwJR7sSWC9VIbEW7SHneegH0iUV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709186231; c=relaxed/simple;
	bh=zqxmjxjb7VnUp0L5tUBZ9Mzk059Y7GHQHEglGh1fzp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryBQftWU4bRXbU6+8q09Gc9SDHilTmw5xbZguvtTk2vSNBFZzXjqp4onxAq2GxgqhWzWfpenJlITMdfPIBxzq0RY4elVXbE0VqEIX1kwm9G1zh4bhRBsp+mPmDduXXnIt7PGPL3O3ZxgryEU5NVLriXyOrAy2Goo/Suaoza0Un4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CU/PGrhL; arc=fail smtp.client-ip=40.92.23.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXNUwPLXMAz1tAfODDtZRvagtjXQM0ZiRSuyPb0FgjzNtlSIIG/HlfzJFG/24XcpzG2svO0JsDIIf6TnyMCjDSuVbQLPfGkiWXTZMSCTRvED2+I/miJBy96qS6rJ09lqunJ01XHczyuMg298u1X+qGBZvwlsI+9y7GTsCVxT8ZvUMVAmBLYSsWW4a4wrcGCn+5VMHF8RLiCjnMHx0My6Oa9Kz/hrT1pGvDI03OuJm6gAjwLRWIHLiW2zlSpcJSd17NDvCpomUHSivL88wyc2TiMi3IlV3PcjxQ/vUpqHWrTp9zauydbtZDcuI7t9+FVSplmLQPVSCCWRs1Y5CkyLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnxxoOwBX872J8WpgfoTR/GIuDBBNOIUfkD2PcNbme8=;
 b=ctoSu5825/rqMk373dw57VBL5vnfpbW360ol3BeXoKZ92bvKNn5wzeKr+cNfbhbdVh3s8/mrVr8Zrg6ZifP+HV5HaIwYmjqvakx43vM6lWin7gTcuCipzrZMAbt6GImkZmzRQiB2KogaMrCSA+4fqy/Yhw/4UN3AaIgnIIBOmq8OHRCyUTghVGWVAKrMyeRPwNu+8NnViaF+AxhJo8GXcSyRdErBdDdaUr5Ya+Dxu8Y462Id2/O52eMulmkKFMj7pP3Hy2eI5HTzpOTRYShjOfqaTGKoK3sprFLLd9I6t/NcqGtkMeYkpJ9hjZOqZfPLG+VAZCDFT7u/QdLyFszZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnxxoOwBX872J8WpgfoTR/GIuDBBNOIUfkD2PcNbme8=;
 b=CU/PGrhLd9/ojouJ+lzTw3YxwDeZIlYaxUBrNOxkKgEhtniM+xZAo1LKWBhfzqxH5PswZQNnZKhJLhjCIyHZ5QHVgynXjq/WlgN2hhKK940fsj75/L2q6CNylvjTfbXYDeQkhSXIcvjpri3eF4gLXNod7tuRDobp0lZQKEI1yPftBcFxmB1II3EmJJ+6RaAMx1253Gq63UkD0HsJ8rI50W0/9j/ogSXVAkpEtgPv3+2IsIJ7UNZ9pH9Tnnrs1w/wDORMD5wg69jFc7XRkVwIpRUo90SeTJ55bkNFp6ocknM8yPpHhLrwAafmYKkr0aYuKLvopxznwfoT4Q1dHLLvBw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8616.namprd02.prod.outlook.com (2603:10b6:510:104::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 05:57:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 05:57:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v5 5/6] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Topic: [PATCH v5 5/6] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Index: AQHaakuc6mj9COe5aEGLVBeKTq8embEg0cMQ
Date: Thu, 29 Feb 2024 05:57:05 +0000
Message-ID:
 <SN6PR02MB4157D170D20F479A33B71C29D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-6-will@kernel.org>
In-Reply-To: <20240228133930.15400-6-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [J5SYBcQCOSkhXQomTbqDfwOzbWMGX6mG]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8616:EE_
x-ms-office365-filtering-correlation-id: 2238ced2-cfaa-43a1-add3-08dc38eb41dc
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zlC2J6BEF2wCXfMVrR9T2kJ6BT8rZPqp0kdJFxn8lF0RVopZLtViCmIeQmHoikvbJnktsVQS1CNId2Nb0m8ssMqzgLRKI7f7pcP2KhgKvXQxNCQ1LQosA4kP6R9e/3ZDQRXxFPvBrgOFNUTut4KxuWkP7JHmdZ4StTf1O7u/6N4PxUgqjyYW5SSOpZ2viwMoNUbbA+5auvZm926HCuKcVwUZWC/oTpIwTBOmLTfWaYJTfj2UUaQinpB7Dd/sNAa2Tw8xQlgcrK1Wu4IgC4It1MjdwMF9SDqXasJpDiYq3Fdsae1FkPvcEfBv0iynzFv0WXVrWHhn2lNxEq4fC0u6UP9ZIKnygzF/AqZzcoQWHoEJXurEdad4eVAY5bYpp6mFkyAfnN/cyltdGsVVK7TC9154p8U8YdOzcWpeqwr4Yq672nlDOvgI2tItn0BjJ06o1GSHH2XcwcrWHL3A1mlYcLbbVBRa6Wx4QsJs5PmvAeFeE8Rp/PpzZTFhJtZa1ge/28q1cuoWQH0qlqyxHUccuivUbLVjb/l2WvdqlI3qoT7q2Ib7MEtN0U7oAmJxJiRWyrfpQ+ehbyurnZhqflTm0yl9q0uDrg7uFXXkbmxXnaKm8NEw7FIWxKWmvWWfeXd7bk6alwM3MtNTnCqr4Ei5O097yR51mjQN43LvwHj7woQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HWJmUTsrzmkwZNh7tfMvSvXr5h1VryEgH/czN3Z6e93x++5aKbdYS6+ju5Xb?=
 =?us-ascii?Q?QahrKAxPZzgfikJtsE8KCOVo2bnBT5yy4YOTvt26dMojhncSWv2q7VHBfpF9?=
 =?us-ascii?Q?r7lIW273i8yaM7vBIAGsdf6n0jPj9sM7dIlYdPRQAKrIPMsrvWPDqGm4d/Cs?=
 =?us-ascii?Q?W/gWsWD7aObfK9ire8INOhcHizOFL5TcTL0jVmr0p7ntVbJXCs9qt1OcyP/T?=
 =?us-ascii?Q?GhDa+Q0MtHxruGBKTQkesUswEg1o+/AWjASbNZLIJuVYF0hK2Ep2KbPEpVBi?=
 =?us-ascii?Q?zNKCdxtKtdyvtJVP1gQMW//xyF00maH04af5NFWCEKqAsWP6kWq+UE1m5V2Y?=
 =?us-ascii?Q?UAKYCJmFBdJ6u3mqdmufPlyflbus6NOJamNR8CrcC6JKPTunTUnVqQTT8htl?=
 =?us-ascii?Q?hSI4OcsTkrwlqd+jtGMIkKGMXoYgSrHqdm5rCdm4R5VTLvFzQF3mO6ZoFGwL?=
 =?us-ascii?Q?uHcK+sSjdQTVhuB8W1Ok/nci21ZkLasrtpXE2pVWfIOJVT/x4HwpEgg+7p9b?=
 =?us-ascii?Q?vVzMk29z7R+XpQficn0M+Ru7GVFWzSreiQfpe0LEblq/tmkGrLratub4U1dZ?=
 =?us-ascii?Q?kNiSonN+yQM2hW/I20yiJjygoas2gaiUfLYKD/ru0RVX/vZraiZt0RV639ju?=
 =?us-ascii?Q?sCoXH6dGkXiCzqFFc09053/Iw0L26Gkj+YG/r3I/uZGLNm3HpKuOhUXCUG9k?=
 =?us-ascii?Q?MoNj+VqOJFi/Sxx1ppAXfRcHEB3nzuJ1XMpZohTNgKyvMbZdl54PN4aWdhe8?=
 =?us-ascii?Q?EW/xEslzd7sROSJ9s/01FZCIwxelT0jYmiFtGcPmZ28EE+fex7UdJ+SuuIvR?=
 =?us-ascii?Q?iIe85Bdm+54aKuIG4cPlcZW34VBg1fVcO3V8SlwibeiD1ghf03jaieWkvHfp?=
 =?us-ascii?Q?nsLEwhnLaC8dPL5FvePp1Vu3msvvkzvgoDbVPyvI4DhrUjgO7Eo6CCN9ABYV?=
 =?us-ascii?Q?cn3zcEqOAwtFPbFD36UN6S5w+OgeHwRkGsA8+E90XWK2cCiR20KDqF8J2KDx?=
 =?us-ascii?Q?z4wWbtdmv7/qHGZO+hshcADdJsZMtWnQuSURRxzHxDaZRZ61zYfBxP1Wi/cz?=
 =?us-ascii?Q?GJT/RAqbt+KInAokF01B8ajPSlEX3wcEs6Jlo4dgcYjT0dlKlgfDEHa2TDUk?=
 =?us-ascii?Q?iIMLQ7ivc5FJXWSKa66ExKyyyNK7xjp2bPRCh4JmZJu0z4gyAF5y/dWRVTZ4?=
 =?us-ascii?Q?9F8cvHTXG9YrmVitRqB2zNYf8EE8k+xaZeQz8Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2238ced2-cfaa-43a1-add3-08dc38eb41dc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 05:57:05.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8616

From: Will Deacon <will@kernel.org> Sent: Wednesday, February 28, 2024 5:39=
 AM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> The swiotlb does not support a mapping size > swiotlb_max_mapping_size().
> On the other hand, with a 64KB PAGE_SIZE configuration, it's observed tha=
t
> an NVME device can map a size between 300KB~512KB, which certainly failed
> the swiotlb mappings, though the default pool of swiotlb has many slots:
>     systemd[1]: Started Journal Service.
>  =3D> nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total=
 32768 (slots), used 32 (slots)
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
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> [will: Drop redundant is_swiotlb_active(dev) check]
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 50ccc4f1ef81..639efa0c4072 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1706,6 +1706,14 @@ static size_t
> iommu_dma_opt_mapping_size(void)
>  	return iova_rcache_range();
>  }
>=20
> +static size_t iommu_dma_max_mapping_size(struct device *dev)
> +{
> +	if (dev_is_untrusted(dev))
> +		return swiotlb_max_mapping_size(dev);
> +
> +	return SIZE_MAX;
> +}
> +
>  static const struct dma_map_ops iommu_dma_ops =3D {
>  	.flags			=3D DMA_F_PCI_P2PDMA_SUPPORTED,
>  	.alloc			=3D iommu_dma_alloc,
> @@ -1728,6 +1736,7 @@ static const struct dma_map_ops iommu_dma_ops =3D {
>  	.unmap_resource		=3D iommu_dma_unmap_resource,
>  	.get_merge_boundary	=3D iommu_dma_get_merge_boundary,
>  	.opt_mapping_size	=3D iommu_dma_opt_mapping_size,
> +	.max_mapping_size       =3D iommu_dma_max_mapping_size,
>  };
>=20
>  /*
> --
> 2.44.0.rc1.240.g4c46232300-goog

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


