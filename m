Return-Path: <linux-kernel+bounces-82324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D486826F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5381C2480D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1C131732;
	Mon, 26 Feb 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sw3NVYyq"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2022.outbound.protection.outlook.com [40.92.42.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BB130E5C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981887; cv=fail; b=twPec3FQpBUyBTs6qZ3hqJz3SOHU4MioV7ywQandLsIIGKUeixAHjUSSG+3gkdztnpjsbFevxWWS0Z4EJ2TpaRErpAq4v+KkQUsq6FmhDagKGg0LFjW+pflmL76mD0u3dlo4UJF9wv9AY4hpk4dnJ31zD9htV7Yqsm3r8uO+sis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981887; c=relaxed/simple;
	bh=NgVhF1ofpDyn8BVKPVajouoVwqTLkZoo/PhU++uo6u8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Idk3NiyZwLyRQnxozBcrHyhepSKV9uvKGrQtdvbyltlPHMtiycN26Wl5lzEk8wcBu0r9Z70JieULRXfp30f7C2rTU1jC2SDljYp8QO3P82hP3X4Eesugc0EIUPv0+MXEWg81rEZtWbo9g7+Q9i2hBX9hkzOHKg2NpJM8yL7frtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sw3NVYyq; arc=fail smtp.client-ip=40.92.42.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNqUkU9aP3C3mAj+8W/qKsHhI9nvpc4Q5MYC1XWPG3eocesmbSzyYoeaM8dDHsediaSyhAR+H/tXrs7hRhF29gtfI+Mx21sD31WG0f/jVmgBb4p+wWbl4x4fFXchJPm+BXlcT8b8P+z4ll5WXPnrQU1cke7CZeEyPsEimctyo1Z70PHOXYwjZ6/N+QXS/S++CoWDfdUwPzWSxQ0qPEyTEO7VXHxcs3xLj5Kx7iTVl1Zi0XeikRCUz6KxCPeHRFIorzJ0Wl3yHQUNFa2Caqq5qQDgvYrptM5TfO/AOJAVWbW1IDWH53VGSYOnt4Q95LyjRYpMLuMf7EDQJjtXcf+1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LigZghKtPkO1bDR+xQDXjitUVpff+BqFhY12NFI+TVQ=;
 b=YFUBTOmylKnKEg7kBkt8mdW7Zsm8XiP5lw+p+k8Z4cOX3iXThNBLJSaZ214amYg1WVo4n9wC6RHyMu+lcI4GtFIU1OQ50Ba8afDIfukWzZfQX9wtxYWptCbADHRy2W2TZ0Zl93djPh5nrRWOhl3Er25La/WXwDjPU3UDkp8CE8zTjhtoZL4KZjMCn3ykkj7zCvHM1zo4ptyRUOWgrnPaHNyc4FeYWTGNwkPuatdsrD4EQCjZRE6cr0CLlduIIltM4sc8Zt8n9iO8TYxD6QFHo8bV3vBx39nFsebCuu3sca/qwY/UOXvpDYa8oXhwrE7tDCruFuJyBFLCPYkpUwW4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LigZghKtPkO1bDR+xQDXjitUVpff+BqFhY12NFI+TVQ=;
 b=sw3NVYyqCfeOHe01Mof/DC1sFTF9M8hmHcyeCaFFby3uTyEEAIHch/wIhL7Lr9oGYYDLarTiL/cQ6oB7SIiIlCj9nSJn+Ywl+oIYHny5xZIO12O1bFE3Qh/UMCe92I70jyigZE0OM5QXw+VFBLTMwx3RTlsnHVD6etjCqXAwlG4aFTOagCidQRaPKgRsJHHYo/sfSgPX9TaS+h/J4ja45BY3AIDAqhc9LOADBa5TE9rFwz5JotSoi9rUowLq5G5N18dAZT4OtxtK3Y/yBqodSoSl1r5mvtwFRH3joIiXiRpBYaO9PHwTqY13iBrt0bZNekbeQEzcoK67Sdz846Aeig==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8150.namprd02.prod.outlook.com (2603:10b6:610:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 21:11:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 21:11:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Topic: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Index: AQHaZLoRyKgMK9jLMUWPn0GpqcfvobEdDJiAgAAUxOA=
Date: Mon, 26 Feb 2024 21:11:22 +0000
Message-ID:
 <SN6PR02MB4157CD26C1D9BAC64208D9D8D45A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
 <6be819d8-f1f9-4833-81c3-32220617f0c5@arm.com>
In-Reply-To: <6be819d8-f1f9-4833-81c3-32220617f0c5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [93LBLVOYOzyIxC3ZZ5x6P/cRW6IwdOwM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8150:EE_
x-ms-office365-filtering-correlation-id: 67e2f709-9929-44a3-02e5-08dc370f7c65
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPlZmxz1a0npQ9IDLvgJEUsC3/tRLXymph4t9SnIvhbn8A8sKI+qmNK36Ennp7fV4JzuMZL/RWwdi1yCQirffIn6i6kXyNu8/+TKnrLLpuvcP5X4KxDDVPRsBFLBt/bykpec+X91JELzGtNz1fTVuvzTaekTM6KiehtYcwrrsQqDe8IeSGvPXXmqifiBkdNXP1EdKfwkjWZuVfpiO8UFRvzso1x1MpscRgGgQCoPl29rMiLDAzngUJyTdXgfZOiH4GqDM2WeIcf0ndhi2IHOlLBy28kRWOLOact4sp62MQcqIhvKJ6YAN8QtNlNEI7YG2B/AE+3btG8BYcS1ZGiwSue/oKHWcM9wlzvC2vLtdctEUdcTL4MNEda6oTOgCEB8vGyqbETZ3eRDqbAqMQ9ayzhvbJr8M5n+q/32Ya+XGUIPK/EacoZOqs5OgwB8kEMcuyFRJTCVKhZqx8tRZj8Cuur1g4cYw0E+bAC4HyLUQFSMiJfNzBiSz/r9RzrX7N91vc8HtfR9D+aMniD834IMzR68liMbVde8A61lngOfQ252rSBliPGdrc7EjeSTNtjyWRAAFjhB1D4QHWwre+3eE5lw4k9uzTh5nB8CO6DqcREWNiHwZz4F+rQ231jLqqv0YTFtWslV/4rUf0Bz8mHldxZwLyeWLEexvFeKQJhOhWbdJZEVUP8fls+WeGzMqJ1y2py/3te7En8I6u2PuPW9u5OA+FkuDnHP7vEMjcasjCVVqq8MXNXniaVGLYysuOOI1s=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SBaz84F9AvW+z1u8+D1U89ivrlxW8KMcVmO6f0lTYQuJjrQ6LGinGyv51VPblWT2v8zkFw4IB0TYc2PNEwbOFqLOttWtc3+OwtArWSs/eGLQfCLMA/CtGvzCyNbzGLUmOu1LWP3H/6yAmF/ImLT5ozozlaVqKdd95xUqOqtE/9IZDuVeJlNvxINbsn9RC2yolY4GXbfjV6mDYSJgzJ/nJR0AaU0pjsHvGK1LLFqPw0szvfecZ2pXB41sflgYGEHuCh2HkC9DqSuEv0KiwA/I9UGNe8xjOAnMFC4K04aK0DxAoFN9sJcTVINbypPdjoqFpe3P2FhbZZ/1iRZlnNWmMglw5F6TXG9WmJedYIiYFL8JsF1NOpl2XDRvcgliajPTqRRosqofat+MZnEKukx4BGQ1Tu1dkh4bkcpmVcyWjI06eJGlyod+Z8mYXTCgtjHSjjA7pEVgHLvS100SDj3pKMw69wpJsSAXDxi+NXt/gL//BGoPrFJQyaP8xbjcwp+KxpKpTV1sL5V5EOU9ODy9mUTs0zGwfDrRl5K5/J2nu5lbu/aNE4LiyOvTuRdP1B76
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4rx1fnkY4QPsenAHewF0kUDnOcECoP9JZ2jbCGoMzm7TNY0LPRasH1pWe/GO?=
 =?us-ascii?Q?kenB8ZJYyd5h7F7GqPARQxYILUgtXjoiDvOVxwwwXmKfwCHi+A1+2KMwUFZR?=
 =?us-ascii?Q?UdeTiRN5fDNrbW3gTfn7Kycp7CzIR2ZTGaSZMMxGnD0F6l/vK6cER5QAR+Uv?=
 =?us-ascii?Q?5w9RzC895WXL7D90w41TxaxAxwo+pdKCy0+npRatAjg84CIKC212d4h+AFS9?=
 =?us-ascii?Q?86KlO2Vcxr42pEJCxrxUPu8lxusx0TS5CFzondOdtaAcmcauOg2MOqu42Cxt?=
 =?us-ascii?Q?ggugTMomawmoEIDH1WOxVf/osQONLv0M2RJHcp0DfCT3YvbdkZW6dB2CIlle?=
 =?us-ascii?Q?d0rdwsrIWQazniuk+YLFkn9OmSUZBe0Phlv+8veDuYN70uwkfakTl/zr+Ouw?=
 =?us-ascii?Q?pFvtzq24KAmGv91aCLs/6r9nlMgGiQad1x7XTQt0tVBQoBCXFavlx/GSXsm4?=
 =?us-ascii?Q?QiRD1vrUyBoC1bPiL6x1jx9rHEIAtMX0+c4X5n9UM8he/nvsz8lJgyrtm5S1?=
 =?us-ascii?Q?mLAIa/IWLYUAJxdDk2xGeLSQNF1XXdLv0ElLXSgWDnBaJxmZ7CgGpi5TnqxR?=
 =?us-ascii?Q?3McTZokDJBeesgQWFfbzqaZ9pZl/VywWJnyVurAKDxdmNMw+BVAwFNKfZ2Wy?=
 =?us-ascii?Q?v+rIzfqjQsEpbo3LkQXkGLKtJRPXa1WMZGir6FjZWpXi1iKBbW9tvZ1Snz6s?=
 =?us-ascii?Q?6r21wHF/wPjgW3uJYoIw9uTvRjKw7Ud73Wh5wCxbZXkFdCrdfDclWmaOVwlo?=
 =?us-ascii?Q?bVaHX49KahxYD5blTEAaoUVmVA0NntlC0PZgKdApOTlFB0UpWeiXrKjHyyh2?=
 =?us-ascii?Q?shLzJN9md3PEWQIRMkd/MGxkTubtA4SlNjXOf5E4XDyLcX6E+s/J0Q49lNH9?=
 =?us-ascii?Q?es5CyxoRDQRE7gQ4eIkxR1e7/12az5My9wn/t6Dm1+rCwL1vL0yojaiRrx30?=
 =?us-ascii?Q?nB3VAKLNlgHsYeqdM6bU5rygQFWWd0JfvT37HoLOBTnxK9JSzqEiSEa4PUeW?=
 =?us-ascii?Q?TZF2L+5PSjs37at0KnZhlxiF7uXZkuZELDCp4dQx+YpkaAy8mk6vwbLVMPXk?=
 =?us-ascii?Q?EB8Vi5zj3aguZwQss2/CMSNONP9ZLsrl0Oscx8646adQK+wZA7PA4bsPE/JC?=
 =?us-ascii?Q?KesuXHugXRF6DNPL7wEcp1M0UKuXKznWmf1rL/bU8y8EHiR/m1YAMdoFtNeP?=
 =?us-ascii?Q?wv/F2JTPb4XFML2KFq8iLg5RIKkbT4WeTLEouw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e2f709-9929-44a3-02e5-08dc370f7c65
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 21:11:23.0505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8150

From: Robin Murphy <robin.murphy@arm.com> Sent: Monday, February 26, 2024 1=
1:36 AM
>=20
> On 21/02/2024 11:35 am, Will Deacon wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > The swiotlb does not support a mapping size > swiotlb_max_mapping_size(=
).
> > On the other hand, with a 64KB PAGE_SIZE configuration, it's observed t=
hat
> > an NVME device can map a size between 300KB~512KB, which certainly fail=
ed
> > the swiotlb mappings, though the default pool of swiotlb has many slots=
:
> >      systemd[1]: Started Journal Service.
> >   =3D> nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), to=
tal 32768 (slots), used 32 (slots)
> >      note: journal-offline[392] exited with irqs disabled
> >      note: journal-offline[392] exited with preempt_count 1
> >
> > Call trace:
> > [    3.099918]  swiotlb_tbl_map_single+0x214/0x240
> > [    3.099921]  iommu_dma_map_page+0x218/0x328
> > [    3.099928]  dma_map_page_attrs+0x2e8/0x3a0
> > [    3.101985]  nvme_prep_rq.part.0+0x408/0x878 [nvme]
> > [    3.102308]  nvme_queue_rqs+0xc0/0x300 [nvme]
> > [    3.102313]  blk_mq_flush_plug_list.part.0+0x57c/0x600
> > [    3.102321]  blk_add_rq_to_plug+0x180/0x2a0
> > [    3.102323]  blk_mq_submit_bio+0x4c8/0x6b8
> > [    3.103463]  __submit_bio+0x44/0x220
> > [    3.103468]  submit_bio_noacct_nocheck+0x2b8/0x360
> > [    3.103470]  submit_bio_noacct+0x180/0x6c8
> > [    3.103471]  submit_bio+0x34/0x130
> > [    3.103473]  ext4_bio_write_folio+0x5a4/0x8c8
> > [    3.104766]  mpage_submit_folio+0xa0/0x100
> > [    3.104769]  mpage_map_and_submit_buffers+0x1a4/0x400
> > [    3.104771]  ext4_do_writepages+0x6a0/0xd78
> > [    3.105615]  ext4_writepages+0x80/0x118
> > [    3.105616]  do_writepages+0x90/0x1e8
> > [    3.105619]  filemap_fdatawrite_wbc+0x94/0xe0
> > [    3.105622]  __filemap_fdatawrite_range+0x68/0xb8
> > [    3.106656]  file_write_and_wait_range+0x84/0x120
> > [    3.106658]  ext4_sync_file+0x7c/0x4c0
> > [    3.106660]  vfs_fsync_range+0x3c/0xa8
> > [    3.106663]  do_fsync+0x44/0xc0
> >
> > Since untrusted devices might go down the swiotlb pathway with dma-iomm=
u,
> > these devices should not map a size larger than swiotlb_max_mapping_siz=
e.
> >
> > To fix this bug, add iommu_dma_max_mapping_size() for untrusted devices=
 to
> > take into account swiotlb_max_mapping_size() v.s. iova_rcache_range() f=
rom
> > the iommu_dma_opt_mapping_size().
>=20
> On the basis that this is at least far closer to correct than doing nothi=
ng,
>=20
> Acked-by: Robin Murphy <robin.murphy@arm.com>
>=20
> TBH I'm scared to think about theoretical correctness for all the
> interactions between the IOVA granule and min_align_mask, since just the
> SWIOTLB stuff is bad enough, even before you realise the ways that the
> IOVA allocation isn't necessarily right either. However I reckon as long
> as we don't ever see a granule smaller than IO_TLB_SIZE, and/or a
> min_align_mask larger than a granule, then this should probably work
> well enough as-is.
>=20

I'm not convinced.  The conditions you describe are reasonable
and reflect upstream code today. But there can still be a failure
due to attempting to allocate a "too large" swiotlb buffer. It
happens with a granule of 64K and min_align_mask of 4K - 1 (the
NVMe case) when the offset passed to iommu_dma_map_page()
is non-zero modulo 4K.  With this patch, the size passed into
iommu_dma_map_page() is limited to 252K, but it gets rounded
up to 256K.  Then swiotlb_tbl_map_single() adds the offset
modulo 4K.  The result exceeds the 256K limit in swiotlb and
the mapping fails.

The case I describe is a reasonable case that happens in the real
world.  As is, this patch will work most of the time because for
large xfers the offset is typically at least 4K aligned. But not always.

Michael

