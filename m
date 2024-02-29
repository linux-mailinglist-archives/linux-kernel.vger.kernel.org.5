Return-Path: <linux-kernel+bounces-86156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1BA86C08C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F4C289AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F92CCB4;
	Thu, 29 Feb 2024 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OnReNP6l"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6442374EF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709186858; cv=fail; b=Yf2bOS1sxMhyv0KSvc97L6fB+gEa8uwWxUc6+l2NMDWDR4itG+rBc9U7cplOfYZFnSWGIZIBdpFhNqtcWe81bprEQTYkjcxjGiprwGZ2KVR0xGipFLfJ7uNF9H61n4JZfTSdCjAwDRiQKdcW6Qf8MI9kMaFuMK3cp+uPoDUNSSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709186858; c=relaxed/simple;
	bh=yjJv045SSvYN6fx+zaEvgVpndHVVgbgbjSg9pw5yJp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MPF+KP42W65mmYewAA1MJ8H+LVdrl/U9zJ3HBjMQp5ht+9KQh9RT+0GqLelb/UAOxe0oOlz3QAmb3/xfEAZ9IgOFZWeZ5mB3qk0ulBZlfNyfDSxaLUKgO1c/Q4rL1Mm3M/jM4f+bxmb8Qfxu97wpw3dKC7RgQ1ZFJi6u41C9sU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OnReNP6l; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laNKXk+RBRA02QEAUeFF8PTSb/3iu6jHBpIYcMhl3LamEm9z+crY6hO3P15bjLT3ODr7Cq//62hGwZEgocUio10lakT9feBNwpslx9A7UzbVe5XJM2iEoqWvSJ1Dqk/MtrVvjlg15zsLwpt2Bmy63Y3h0hxr+R/yErnlEi78CRM8tlWKTHtYOTnBqyWKprQdst7A/Q/8MEgpUec6Q7CU1zhkKuFAxHrbiRhARVqFm27DEO4DxR+s1j0rkTPsz/nEp2BJ5gFJLCmWMzTSQcCSimiHYwPUxVT9t/NYA2wVczt0OEcEJgyc0ukn6F5z+Ym7TZ+pCDDbvQP7080KGwU/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AouLCKoz6O4yTehzsmT/97FGF070j/aLBiRsZBYjCVo=;
 b=VmfJHx4+PuYyV1p8iwLsv/kWQlORChxdIptDv+kZ/FgXjFWHe4lSmy2SDIs4HEN3InTZqHcedbUATLoyMd2MK4inDv6G1OYvO6wTDMPYjHrdkDZVLF3ZufNg+cfIQ0kbf+eIGmbtDbAk8WZ+XmJZSQTKTZ9ZTK/xYSYxzsJdpPWusBypNdSLlGKXY1ieSQin0ZBGUFbuG/lMkwrZZ253h8h6PG3D7D1QySqIkMCd0+WIoPAwAaKoW98o709XkO6aoZBASfwfkd/j0EBAemZFhotBeTuH8kX8Mh8Gy5jYWwYb2qGum+9hOCF1ie20CoHQIebUWV7Ttg2iMJ4CV/dJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AouLCKoz6O4yTehzsmT/97FGF070j/aLBiRsZBYjCVo=;
 b=OnReNP6lSEZeG3YDsVKu+Xs62Bp2mUGr8sXYUHypBOBilqCW7pMfv082eupu6mA1WUm1nJSDBEh2FrMHDv2ruUw0ebelMll+oC85WK2a2eF/0dJ1CwxVp1eE2qj5AwR5gQkm+gG7WeFQOu7Os2vGDDj61ckf3/bs9TCmY820yYLrzJ/sFOHKBAC3qa3zOojp/+nIyzTQO+H78892akTYP7yQACFge0HkxwdFnFLFkAcAk60CpQ0oLGfMm9bHEHIbVTy3q8Plg4fQp8HHVQBZCp9mxu/F48BwVIl9JXZnvZFlt8wCDruuXVDUg03qb3+9ydrbNHQKmZU+KTsAsvU7gQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9713.namprd02.prod.outlook.com (2603:10b6:610:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 06:07:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 06:07:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Topic: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Index: AQHaakuep9s0mIf3eE+om+sQlmyZtbEg06/Q
Date: Thu, 29 Feb 2024 06:07:32 +0000
Message-ID:
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-7-will@kernel.org>
In-Reply-To: <20240228133930.15400-7-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [sAEJk7cocb3JrhKBCjiyxhFVbd47Lbgl]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9713:EE_
x-ms-office365-filtering-correlation-id: 8429e41b-7f98-4eb1-4717-08dc38ecb7f0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TrwZhJp/qNnfgKJS0h0wIFXzRUQ26C/FeLOzaijh05BzaL9HR8zWnAtda5lYy0TmOhcU3v6zSF6JtgOMaDN6NU2SeFARmqDzPAYjDaV47/2o7m4P8lH9v/0OSHJCP/uWgat20UDc0mHwq+v6PPa/NndXTKec9eHIrLeDYShXkdd1Zlcadq63kXowK+D7ydBvBuvlIGHFk8Ilx0L+LRhRa8wGSQUYGu5xwi6u6rAE7pV676OoNH4SK1ygElIrMFJzqDwMnjo+W1po4yZlCLzFAlUNW/0suFQyI7DpqqSEslLRiHmTNbGSFtgdcXiN5wUIe0Gv0fFoiNteqISByFGGJtahDtqnk9QIPUR4JmZy6hkJR3ymhaBVGDSjpe+qzBjPgxUnRmlc+CP0ZBShIp6Ths09sy/xDynnylAWFLPpgBlf/dwDzPpwRAK65prliLxcYf68SPM83XDvWsuLWawcrRq1J6OECUUXKvhgZvovXs7ZJV8Kz3PFxDC8UZhYdAl9jeg/si0W0Ayela5mXoxZ5JbVvMCjmBiiem43nk38bELvv6K7giGh/VPhLu6WFHv7FJGF5hbJ/BAOF+BWC2HiM6ROM32JK8z8xNzTEa8jBVc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vV61VZUXIQH3hWOhKgZ/ebCvKGlo10Aw9t3LJ7psJCCSgfY8y00pksYPkMqw?=
 =?us-ascii?Q?18npNuEJHWbjFtFJbjXGyuPVAC8MmFVLMB63mJgFZ9IW4Zx1xsfkaNRKkioG?=
 =?us-ascii?Q?y9KNqGqAxvmNF1PkI5JTkO4sa3+vLFAoU58Vjxp8r1QQ0hv9oWy2ryWXHqr9?=
 =?us-ascii?Q?CiaG5MV+Iv4a+UKqjUvoOb6WyQOijHYPKHAsCXskIoH9WZ/OzAJUTrpLY+ga?=
 =?us-ascii?Q?4mVppdI2m/YPxdOsAXtgOavZ8cpbycmvWtDvne3NoZD85JkiZzQqiefdyML9?=
 =?us-ascii?Q?EbUA3FN2GmiG7xgUrJ8smyiCw9yrj1e1t0nqScZeFGcfMHrTuo6CnXtXN6HD?=
 =?us-ascii?Q?7Y6+iHpS0EXRZXECuLzlQQ+vdShGGra7EruaW6TMz3QQB0U117TxzjQ7g7xb?=
 =?us-ascii?Q?BYlgp6FkWY/Ua4ItjVat7gjz/DjLUtDGDRA87sstHGw7I+XgdZtf7MIwZC8h?=
 =?us-ascii?Q?gjdNYxtvdP9yRuSxwwPoQzIOO9YxCJr9++DNXOggLcmXiS7cqrlWNkHg08R/?=
 =?us-ascii?Q?P5mxZLE4qlP6qoOxZz+Us1D4+uZad1ofZVYVTg05DdPUatdxmEuyuo80bAkW?=
 =?us-ascii?Q?PqZv0KaPrskvAHvFVj44/ZZXR3ppU7Z8fs3pVgdkWKQetgTjKRdoTZmyCgYq?=
 =?us-ascii?Q?F7exwU4MXc17MLk1STnOq550zmStWwiZ9CeAmenzLAAAIs3N8ApOcTlOO0yz?=
 =?us-ascii?Q?EOvpoEjcY2GZ3tnENP3P071rQCLy3AmzZkLfc+tKWeSHGrJ6WqcYKSE1+s9k?=
 =?us-ascii?Q?8ChcYSQg1S/UR+eI59Kmr9IMzH7p7P0Xs2QyoF0kqgtfDZNh370FVAyGveWm?=
 =?us-ascii?Q?/OVLKsRcrWNYTExzXMCSAg0bDArBQ1ZUg0bkRNUfHjPuugzYOedNw3FRTLfg?=
 =?us-ascii?Q?NdLW4YlICQosHS2EEtA610LGN5sufT1eEXMVeXKsaZI2RkwuTf08Y/5GadhZ?=
 =?us-ascii?Q?u4sRZUbvOxRYGezy0H9PgdaB3ukMW9FYUwwRhxKzBI5e0eSweTlhaiX0FldD?=
 =?us-ascii?Q?9iDQETXIAxmb5pAxXsVuhbB/9P1EKveIbqwt08Nl6EKFDACnw8wnKrEXzAEE?=
 =?us-ascii?Q?1pWspg6QfkbYGeWhFzDTC9kZi+mFEmYmDLf5d3adiuwCfvTcMF2vtfBJ8Q3F?=
 =?us-ascii?Q?tvzP0GjhJm+kp1LShaXnikhke9yEcbPtShaKrGLU7KWHTjRDXWtLSdKXsNpf?=
 =?us-ascii?Q?ZyICekUzxhwIJnmxfqjDYMSPejgKOGcrw7qYrg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8429e41b-7f98-4eb1-4717-08dc38ecb7f0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 06:07:32.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9713

From: Will Deacon <will@kernel.org> Sent: Wednesday, February 28, 2024 5:40=
 AM
>=20
> For swiotlb allocations >=3D PAGE_SIZE, the slab search historically
> adjusted the stride to avoid checking unaligned slots. However, this is
> no longer needed now that the code around it has evolved and the
> stride is calculated from the required alignment.
>=20
> Either 'alloc_align_mask' is used to specify the allocation alignment or
> the DMA 'min_align_mask' is used to align the allocation with 'orig_addr'=
.
> At least one of these masks is always non-zero.

I think the patch is correct, but this justification is not.  alloc_align_m=
ask
and the DMA min_align_mask are often both zero.  While the NVMe
PCI driver sets min_align_mask, SCSI disk drivers do not (except for the
Hyper-V synthetic SCSI driver).   When both are zero, presumably
there are no alignment requirements, so a stride of 1 is appropriate.

Michael

>=20
> In light of that, remove the redundant (and slightly confusing) check.
>=20
> Link: https://lore.kernel.org/all/SN6PR02MB4157089980E6FC58D5557BCED4572@=
SN6PR02MB4157.namprd02.prod.outlook.com/
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c381a7ed718f..0d8805569f5e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1006,13 +1006,6 @@ static int swiotlb_search_pool_area(struct device
> *dev, struct io_tlb_pool *pool
>  	 */
>  	stride =3D get_max_slots(max(alloc_align_mask, iotlb_align_mask));
>=20
> -	/*
> -	 * For allocations of PAGE_SIZE or larger only look for page aligned
> -	 * allocations.
> -	 */
> -	if (alloc_size >=3D PAGE_SIZE)
> -		stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> -
>  	spin_lock_irqsave(&area->lock, flags);
>  	if (unlikely(nslots > pool->area_nslabs - area->used))
>  		goto not_found;
> --
> 2.44.0.rc1.240.g4c46232300-goog


