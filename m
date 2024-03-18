Return-Path: <linux-kernel+bounces-105688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2132187E2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7D3282C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DCC1EF0D;
	Mon, 18 Mar 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LsPnG/pM"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2011.outbound.protection.outlook.com [40.92.45.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74851E866
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710733152; cv=fail; b=KwvFbPNPPRs7PmgPmtGkXwHuRDP615taSCWJ2inMzIEOxFvzTMoDGfMrb417zfCx3SiJ8BQm34mLg/Bj71bXJgu3x48X5WN/iC6SacSPzWpAhpGC/9EC915muW+KXdhjonoPfMWwI5yqUKrbFVZsUhhkB3IqAwei+G/llGSzQTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710733152; c=relaxed/simple;
	bh=Aza8L198sheu317m3/5i+nyDIyI3ddx3GSvznx4GGQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UlcJ7d3G0yNcnPPeakAWQYo1G0golb2BdWs/6/q6lGElbQrFEEO21gOaPjsfmuz1n+fMZ+BetmovYBaMTaBjWHLXKBgbB3t53agvjHVDvCEiBWt/bh0JFCHh6ashyGujOJ67ueHpiBciBqA+p/TlbFS4yhAO/oXyogtRnqkiZCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LsPnG/pM; arc=fail smtp.client-ip=40.92.45.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eb878WI45BrET2uc0cgM17T1ny7OnTepwn2Wlb1Y/Vsqg7NVtqKaTleB1Ybd78jKc3SQmcpSuThBUSvFVWTdfQIWdJfzqTMK11L8KI4QagHQLn70VDZ8EpIM9p9FCzs+opPq1xvD2icLpz6oZJ3nP5zJ2HHH0yGmZ48J42/QBf1XNTExdUoPzBzQnWwaXb6OJzR0ejgXQ6iARmLf4/lo+Rvaa2wRTPB+BOSP82Mf3/20LcZc/Qio5/CB6k82Z+tM+4CYfS9LRmKaF9GoilPLINsNy43zJ2+fu+lu/ATfVKPe9sBXgDCy5RWmJ1KM/DBQxGjs2sJHNdhTOM2r5sABgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqo6hcthJNIpcExBOv9+JL6Nu5fiR4qjz5ZfbvUYcls=;
 b=fCJWfHiDh9BEg6GxoKP1iCqabiFbmFRtQUGo4FdUopTNwVV+aJB3+neMRhtd1ZjTq2YyCzSxgbVtxzMxu1geGfMYis1dEEmCcxA5+WwvOnNygCwFiXWdTokXXnykVLnp7zveUr+wXph7hIo9Ctk0QSld+fJXEuFGPjga/WCbqydTLu2n0+0TN9uM3ArUzreFJ/0gxNCUH+yYD+begDj4tD3dgNgXYt2+Sdh/sriaggDQX4h+fAjs84nrm7SMd6HyYaq8HcD9nHMXLy0KiJNVP/xmjbxZTL5zcDjcysRyKa6V9dy2Drwg19HYHqhuI/7dql8WOMj3dLU9qJSs01chyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqo6hcthJNIpcExBOv9+JL6Nu5fiR4qjz5ZfbvUYcls=;
 b=LsPnG/pMAGt8nihfaf5W0YKXCVEqockCa2TMJU2vSeBm7cSsuEpX1lg+xWrcVBL8r4ljCDwYyIf8it5JdYzlP8A+Upultqb1agAWc4EkVcl1Ulb/JR12Ad1dp66My0nwtCD9OWQ/mhUQD5zgHxc/374NzypaIc2tEzAn5AUW/+bFALGjT9B9AgTC9BjHP571AcJSh60ISYGQCXWe2oOi9d7Kn8E9+YyFbmdxyo+64JQVi3HDtrmpqmYRIko+aGM6wnTpAgGZvfPNqMfu6CDjOKGTVLaPcXjCFq+OhjmIt62gcPRdPAt3ySM4QdG5Mkm+q6nTaOW7FNOoZbh3naub3Q==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by PH0PR02MB7271.namprd02.prod.outlook.com (2603:10b6:510:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 03:39:07 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6af6:2e8d:b2b:440c]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6af6:2e8d:b2b:440c%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 03:39:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v6 1/6] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Topic: [PATCH v6 1/6] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Index: AQHacW1Qy/FhZnYt8U2kGWb3uSufILE7Rwdg
Date: Mon, 18 Mar 2024 03:39:07 +0000
Message-ID:
 <BN7PR02MB41483F5D16B655F5764D14EBD42D2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20240308152829.25754-1-will@kernel.org>
 <20240308152829.25754-2-will@kernel.org>
In-Reply-To: <20240308152829.25754-2-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [rRMcsPvTLcS4Z8DRIqD02OHrRjjGgbeW]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|PH0PR02MB7271:EE_
x-ms-office365-filtering-correlation-id: 6cc2bb58-8c57-435e-685f-08dc46fcf76a
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMI9+CGgM3Myb3mH5Cc90PAZjbRJZ/F/QQ9aRBALC+S73byoMSoN1aCI8M1+5uygmyQK5kZwTupqaiHk/alCMPWzqgOwQygyHM5d6KZuYKO9uwybMga0w3opZSzXgIOYkihPtKd0DPj/k4lRvslit84Hl02ZOXAF5PzmikzvfZGuyezx76uV0UVPPjRyZs5/9GdGmBvLzNclzhGLMjF+fp/sGAFPbYxE/Kno7H3mZBlLpT+W5vaPY43i1AwBIbVR/GLm6nW7ROCluGaJ8jjMyBKKs/dNIBM6UPhFuYGrQEYuL1L61Zs5Ck9V4pfqu1scNCdD1bNuAmaOKN6ScNFT3Ks64dp+9CWI78D2QdAN7RXlor71ADNUqS/2L8zdH2BFdhCwmtWpv8wUNs5/yOreS8QaC4MB+tzsUv50v5eH9Dud/ER4Bev6M+LKG808sPERFQaSa06teATwfMSS7RQSYiJuCQEElFA4rui4bATIVSo41UH7rM2BNPxrFDSjXLtw9+JtDbuEUkTG6RRVXiADdbqLnNZAGKt5tOifv75dfbtQa0o4diw/ESscK9fsY52gkvYm/lDMEQqLW+P7JwgwxLE0ziwV5PDI7mnd/A5OWt7YSejM8vFsqreYnfawkhdM2iG5krm5TRA7HrGKLypAPVp4fQzx7rkX93EiTbQyZGW+2KjaCekGyrBmm13SmCRr/vU+q3i09LeQg2a9pD5kQmVwCOXWL0iaPU8VyuHpye6ixOlNrHTmCI4oiN5KxgISDY=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ajwuylx0LlExoroDkm8zEcMMOvYA6fAqBYAppj2+Ycja4H2azhp5F4gKp0mwscoUEMWIhKgVZaPGTNuuW4USN/yEDkCohhnbEHZDBkWKe6HnBE+KYTJQsu0aBCDkDzTExdcISkJr7U/S2ins/Lh8Zh4+xRWAPQsW51ZspSaB38hM0qfOks80/K9ztoQHHF4RLZ1+pwMjlAXwH/MWjBppOEZjstJ+Ghlpk/KF97zno5ke7W3yflBMQlVqTGAkHaOQWqwXNqSnrugRibZIMauWLlJ6wHWx2eZA0Hn6ixpOWE0XBclNWTFp8up9OdgZaFkR5IWqMIZ0oaG4C1SqyElWvyDN/PnYOSwxLYwCF2jsIpapMOk113TZy+1IIBjjtq7+RFrx+Oa4rcgHd/hv2cKp/XUSMROi2s3irmdfDU6VudAmrGJCFPN/n72Yj1/NQMoY4pF3Vw5iWa9gbm1PYrj+nwnhWmU48jLQ5eqchbe+YUG6oFySg4MhQsabHmaNrcdhLAY37usV5aEZx+VNKHPIZU4Efkz5WbP5zXsFZ89HUKB3IT+I8c/+8UZtvt65WsC1
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8WM+4AcOesv6/SlEtkpsnt9CU2mocDMTpphmyFa2RHpoNKOJ6+TrarEk9NEJ?=
 =?us-ascii?Q?3DHyVBapgFAXubyaJznaSJC8ZLUM/HGoM5Hws3h98lD3pmxs3wwvYlVUsNiG?=
 =?us-ascii?Q?gQwPnp1QE4ChT+HU+6KSV6Ikd/uquPeUjZaNnwmWz5zvmgwaoVSK8vcFpVBy?=
 =?us-ascii?Q?xnBrH36/G4MnkTATnuzSvS9+77ktuULL/UzkwxJrfUNMqKFnU2wuu+IABcoB?=
 =?us-ascii?Q?e0cuqSSRakwA78B8xeL10bNPz7Ax0t68SQp20FOF2cO5h7BO9MSnT7R2TvYE?=
 =?us-ascii?Q?HvYjTLUr4uyOQeMmc21175ijlnvpSZHCrCGGTQzRq5Z1UCgGSrS6dkKGgLOv?=
 =?us-ascii?Q?82RKkB6jWk8dAYRXcoaq26pZSn6yz4euiSHzpRUj+u6xijaNQCT8LymFk3eh?=
 =?us-ascii?Q?wnYoD1BKS64O+Wnaswrh9j4G5uAOUzlRSHI7dcbmx6NYV3kZvFqK57swthHr?=
 =?us-ascii?Q?qxMlHSM+6qE4hwhGxiQh0oFNt+3q8atljdBd8oH9bzpcYnJ8qJoFJL+P0UQP?=
 =?us-ascii?Q?hJeJCrlDs32FOxwQ/4OKFcRJpP/alYgDKnf3TLDFhrT2Q5pGTkSBYJ+RjUDy?=
 =?us-ascii?Q?w09lSh/zyY5VaeOs8asqTPhmP1lfszjIylki9sMEuKBl+2TuvjZrNFdeYlJt?=
 =?us-ascii?Q?nAYQ//kfAdDwbNshyCSdTA7GiZZ4niOi+GK1+f4NxOr7SZepD3I2ARc0MuA5?=
 =?us-ascii?Q?3EVtRhkHDPS3984432UY1euwwtMu4yp8Oby4WdVUBOwDlt9sdd72e3OCO4wx?=
 =?us-ascii?Q?cwlJ21/WujqVgoU8nNiHzpglGADUTgGMTjT7HkA8dRImaq4LvMkC0ojfML62?=
 =?us-ascii?Q?Ax5p0D2rO+iyRFuC8wS1hcFAHRDiq8trbwc2o6oiq5xQ5B/si9LsEvZsROiX?=
 =?us-ascii?Q?JPlbCTegUpA8HDhQjaLRcbpiflVMSgh7jcIqeaYyJmiB6J7VRjR9VJuL1ExI?=
 =?us-ascii?Q?IHNW88Gxd/8jkN3Z/piwLxA4nqUKVrh3ci4dMcJ9BxwBZapCudcAe6dgEsEm?=
 =?us-ascii?Q?mS/+c4oYnTEX+GyLqN67uhOX67oIGKhjvrY3x3CKNfM1nB813aalCPjrlRak?=
 =?us-ascii?Q?BgBzSP/bo6+9zbcaGn+I6wpp3FsRPzpH4Vtz6ITyFXAY29lYpfJt3bioXvVG?=
 =?us-ascii?Q?jcsn6wfgWsYqCHersatB8ryy3mfMMdIIhV4FwsTPudLzZ8NwrMGM41b+Euev?=
 =?us-ascii?Q?11hMIqELJH/HzPf9YYUjPRepwz7FWoWHt/hpEQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc2bb58-8c57-435e-685f-08dc46fcf76a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:39:07.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7271

From: Will Deacon <will@kernel.org> Sent: Friday, March 8, 2024 7:28 AM
>=20
>=20
> Fix the problem by treating the allocation alignment separately to any
> additional alignment requirements from the device, using the maximum
> of the two as the stride to search the buffer slots and taking care
> to ensure a minimum of page-alignment for buffers larger than a page.
>=20
> This also resolves swiotlb allocation failures occuring due to the
> inclusion of ~PAGE_MASK in 'iotlb_align_mask' for large allocations and
> resulting in alignment requirements exceeding swiotlb_max_mapping_size().
>=20
> Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
> Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b079a9a8e087..2ec2cc81f1a2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device
> *dev, struct io_tlb_pool *pool
>  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>  	unsigned long max_slots =3D get_max_slots(boundary_mask);
>  	unsigned int iotlb_align_mask =3D
> -		dma_get_min_align_mask(dev) | alloc_align_mask;
> +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>  	unsigned int nslots =3D nr_slots(alloc_size), stride;
>  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
>  	unsigned int index, slots_checked, count =3D 0, i;
> @@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct device *=
dev, struct io_tlb_pool *pool
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >=3D pool->nareas);
>=20
> +	/*
> +	 * For mappings with an alignment requirement don't bother looping to
> +	 * unaligned slots once we found an aligned one.
> +	 */
> +	stride =3D get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> +
>  	/*
>  	 * For allocations of PAGE_SIZE or larger only look for page aligned
>  	 * allocations.
>  	 */
>  	if (alloc_size >=3D PAGE_SIZE)
> -		iotlb_align_mask |=3D ~PAGE_MASK;
> -	iotlb_align_mask &=3D ~(IO_TLB_SIZE - 1);
> -
> -	/*
> -	 * For mappings with an alignment requirement don't bother looping to
> -	 * unaligned slots once we found an aligned one.
> -	 */
> -	stride =3D (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> +		stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
>=20
>  	spin_lock_irqsave(&area->lock, flags);
>  	if (unlikely(nslots > pool->area_nslabs - area->used))
> @@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct device=
 *dev, struct io_tlb_pool *pool
>  	index =3D area->index;
>=20
>  	for (slots_checked =3D 0; slots_checked < pool->area_nslabs; ) {
> -		slot_index =3D slot_base + index;
> +		phys_addr_t tlb_addr;
>=20
> -		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, slot_index) &
> -		     iotlb_align_mask) !=3D (orig_addr & iotlb_align_mask)) {
> +		slot_index =3D slot_base + index;
> +		tlb_addr =3D slot_addr(tbl_dma_addr, slot_index);
> +
> +		if ((tlb_addr & alloc_align_mask) ||
> +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=3D
> +				  (orig_addr & iotlb_align_mask))) {
>  			index =3D wrap_area_index(pool, index + 1);
>  			slots_checked++;
>  			continue;
> --

Question for IOMMU folks:  alloc_align_mask is set only in
iommu_dma_map_page(), using the IOMMU granule size.
Can the granule ever be larger than PAGE_SIZE?  If so,
swiotlb_search_pool_area() can fail to find slots even when
the swiotlb is empty.

The failure happens when alloc_align_mask is larger than
PAGE_SIZE and the alloc_size is the swiotlb max of 256 Kbytes
(or even a bit smaller in some cases). The swiotlb memory
pool is allocated in swiotlb_memblock_alloc() with PAGE_SIZE
alignment.  On x86/x64, if alloc_align_mask is 8191 and the
pool start address is something like XXXX1000, slot 0 won't
satisfy alloc_align_mask.  Slot 1 satisfies alloc_align_mask,
but has a size of 127 slots and can't fulfill a 256 Kbyte request.
The problem repeats through the entire swiotlb and the
allocation fails.

Updating swiotlb_memblock_alloc() to use an alignment of
IO_TLB_SIZE * IO_TLB_SEGSIZE (i.e., 256 Kbytes) solves the
problem for all viable configurations.

Michael

