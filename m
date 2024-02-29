Return-Path: <linux-kernel+bounces-86942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ACF86CD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE41C2161C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1E14A4CE;
	Thu, 29 Feb 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i4nsUDFb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2084.outbound.protection.outlook.com [40.92.18.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544C14A0AB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221456; cv=fail; b=mMtKU0SX91Z0FfVe65oHxucFTQrhM+nF71WYcdYtRoOJFFHFzBBut+q/C6y9sCXwZmV3oMzIZZQyv5NuVMRhgKc/KNtZcju0fJT+2K59ShCgX2LgvuQtnF0cjop7cETmJCTeX2ZbWPMTkIrGAH28JYs5jvB+JBNezHB4jrsM9OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221456; c=relaxed/simple;
	bh=5AHNemKMeCCSJt1v88kRTOMnWQJ1NyGGEvyopQny8aE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkvYveXIKzXHyWED20W2iv5D4yNXgukOD0qal8A2EFG9oO2N8Y94OkJHV2XkAt/BW5eF+fsMztxQtXprHF80jHt+NQRMu527bvK7Zz8wpAmhdHhuVzG18BLwLX6JvrmuFqLlvSdjv1DGk9YDINFa5QC8IbbYiqA1jG1YfZMypyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i4nsUDFb; arc=fail smtp.client-ip=40.92.18.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLkPhdYqdTahAbSxfxsFFMmMUcwdgz0K0RRAICeWeosvEUYPoKe8TG5Zil6pqKRQF8v82AuF4qLse+bJabHOff/nxuQQuBwXuLmWo4exvvU/2X2KLGs4JS5U73I/Q9O6KSCRWr17FUqr90N1NUw1R5nBg9XSyhQKLFoKQnT/4KM/WRAxx/zHk8JROJoog1O9z+z87IaqY03L3JbdJa1BslmXc0VeMJxS6E83q9zJpVHFDnBOJLP4q2HKnSBEOcfS3J73grxb656tM9fxLDlZdyiGkZ5VjN3eqkLonYKk+h+axSqiu1i3Nrfk+dV2TtTECMUynT4W/JNJxVCp5hMhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83u3nQkfVx7es4l6JumZijIlHFSb1yDRniklylTZZXE=;
 b=SqA9RApuTiLRVy7kdJ+U5dqVLBoKpqPP3GHQ9CYWoGE6fO4IjoEcbizdThaL24jxXiQ6PMXtZBRBHhXOZi/lhlij1jdBfivc67QGmiJBL46xsAZuYvOt+WzKCSqLy2wTFLyrJryE5w6EyJnGlSWqTYg0DBMlnl+ELxGWWkcCZAJEYFrlzyjbgtdk2s0djk+m7X4MI15GvgKjc1grrSBP7HuIEqiR9VnLYiX6ie4ks5IyByN3TSgFY+9CV7aZmdACUUWCrGXffe9ib4Re7hV4Z9oaYsrnlPIhoptpNVScq1HWhVrNbEL1VpymaItohKL399+OxQ5uFDKhN+7I1PwJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83u3nQkfVx7es4l6JumZijIlHFSb1yDRniklylTZZXE=;
 b=i4nsUDFbIvZyq8O2BfsUE1oDcePnjEcamQwViyh4uPwfjsO/h4kH2npBrncqPoudKjGD1Jg3aiYCqra88D+3Yikm/B90U/zC3GvtTFxLRBZ/E+ydef49pXKWe4UGvhYGWFNHNwbGD/xt3Rpx++g//mSTZMRMQl2+AsGhdZdBEcs4KINCCTKyRYRQy28pDf+moQQO8ZFOzAeGQAzF1C5U7vn+5sIe256ZXivzLgawXriRbzRFErJ4em5hqwtW2082Y6u9KVgEjwOJsqXrHCx+/gvTMOKjgqdmr+0c+YtVSnbKyosDYvYFXm/s982m+/agNnK3bBN1lyfCHr1Ec5tEcA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10142.namprd02.prod.outlook.com (2603:10b6:408:192::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 15:44:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 15:44:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Christoph Hellwig <hch@lst.de>
CC: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
	<kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Dexuan Cui <decui@microsoft.com>, Nicolin Chen
	<nicolinc@nvidia.com>
Subject: RE: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Topic: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Index: AQHaakuep9s0mIf3eE+om+sQlmyZtbEg06/QgAAR1sCAAG26AIAAIlEw
Date: Thu, 29 Feb 2024 15:44:11 +0000
Message-ID:
 <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-7-will@kernel.org>
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229133346.GA7177@lst.de>
In-Reply-To: <20240229133346.GA7177@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [/rylYCHwDNAkV4Fy+igzWw3nb9s2B6ja]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10142:EE_
x-ms-office365-filtering-correlation-id: 3f685fc2-588d-44d9-31a8-08dc393d467f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +0kW5jx+RFTNU7d0GI2e20GXagiJDYe9eCmdNTfhv/4lD7ph9AT9+GATBlieycEa8FJ5nKiCzWU2x1FBjEnzWWbOZIgJbPzEMnlTA2dbg59sjYXmDqnV0cRcfGpjTAHtszanOg8mvT/s6VD8ILKSJo+/j1AWDLj7YCZCeAEojWAeLrtQ3bM2N6BU5E7vh+dQIbqeQMWHZT0RnY6Ec4EUFh4uZciweNIK+qUWOJej24ucXqvL0zL45S7Fp+kpk1xutg/A3ZzCJA+277hQ76CS+l3CNqSpJLBAzsj1EOA+FTu4LWk9dQSXLrmm2LC5UI441KyUCaPkBYC1pcDC57+lVCsD9ibgGCUnP2/l4nrciQRlqAoPhYTxvy5Ol3LsQhXvQNy2Mkt/dMZyavE0VeKO1NzjVrUuD7ZObcayH7logwduqn8vQKK8P47J4zHyPM6Z7DtvG0/40t/Qpn78QlHJoFvJFpTIHmc9PiDM46qNJtrdFQevfiaiaIaBlOitgPgYZwvZEd7IJ5Ree2zaE0knzPW7y8D7wOpudznmFPNJLo++pnAPo4x9s75fF+O/NTea
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZT4I8DVdHEFTvkjZhjwkPNGmGMITOhvjgWjUhIDTZzxWndhQDELTx8wYtAEs?=
 =?us-ascii?Q?fQWW+Jh1F/zuLYuyQs83TMHeGAZ5r9Ezwu2Nx4SOgsD1IolWXCrfc5u0ONYh?=
 =?us-ascii?Q?iJeSx2j1dhNBvtQghZq9VJ9h4UZViN3q35jKyYvlJjWuI1F9UgNvCMbxCxME?=
 =?us-ascii?Q?F0r8EqTCF4iFSk6G6XVaWF9Him4ZxoaQxhd3NyabhpxCxLQskuDt6BUaKr+I?=
 =?us-ascii?Q?knUl2bdm7OJgthwxI1wCbXNs7Vc+EyoURc2sLfITdzUSdVenn2EjsWtGkpwh?=
 =?us-ascii?Q?/Gp/hrOBZPifFjQZUVqxQYYivV7P8XmOZn9WX8vWn5mcgMS08BfgjSf5TqOY?=
 =?us-ascii?Q?5KqTNZRw953pBb3aKCKCUaU2FSLPVjhJKofLvVp4VSwOgN08oU+CJfcFZ7oB?=
 =?us-ascii?Q?ZVAqfgaTzIrOuf2yCb7HKzSSjSEA9sSfGfX8Wdk34rtlE9+XB2jVPf17KoQf?=
 =?us-ascii?Q?aJzc/kxxpIZN5U2RHhT8eqNmAW5TYK2O8n40keOJsKCLyJFNKbwRHVd6F5i2?=
 =?us-ascii?Q?jgK3vcLc4ZKutVT++Vc6ooOTCC27YNexoIKI0HcImirxKAxF5wcrPJI24G/f?=
 =?us-ascii?Q?boDWY19ZvdAdhsjYvy0FjsiJg+B4KI5zlsoqjAMUSWONb/s0EOCbL49z4ByC?=
 =?us-ascii?Q?s54AkUziwWSb1w8yolV5yds55HkJTKxT8Em9zx54hv7JQrZV2irhy8qA4LXx?=
 =?us-ascii?Q?QMemd6XYhaPDcRwcRA4A3Egkjeu5MOKmrliZ0hllJsqUdQqWiI7dVSK8BnzC?=
 =?us-ascii?Q?ZAHlR2m9riqogT4ihhQoBpn8fYlbd64LFqCD0cX/C3o6zaf2PrmNilV9MBSN?=
 =?us-ascii?Q?9TdCBoSivYNnzd+90BntUd/0ALk6WD2hr294bVAzeAuM7UUFIcBLPKosyvNq?=
 =?us-ascii?Q?OFh62/HDTKbGi8rYxPzDtzdyjZ7P5gmCjR81JUlnl40Hne7Z1T4gJLoyfdQL?=
 =?us-ascii?Q?gbZ8AfdFRWvHUmX8V/Isas2UusASLY8weyKzAFmVxoJsyIhT0EuhMSaiBfqW?=
 =?us-ascii?Q?GOV0Og46iPmyJQCEVLgiG24yjdXdrAI4SMxVkQO7LIO9vh7OzVHq6yqDRUOc?=
 =?us-ascii?Q?twg+p8tD0mI2UYXC4Ym7gHEafMf1WiCzg9S6RIHe5pZCY1GdGLjjRTBqoERJ?=
 =?us-ascii?Q?mbSSQCyIMifHKIlVlWVPXeB51QnTprj9j26kGakjPCULpHyN7w3hZE5K9/3B?=
 =?us-ascii?Q?3mYhJKGaJJGr6qoIsxz50aLKstJHhKHFqH5W2Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f685fc2-588d-44d9-31a8-08dc393d467f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 15:44:11.7865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10142

From: Christoph Hellwig <hch@lst.de> Sent: Thursday, February 29, 2024 5:34=
 AM
>=20
> On Thu, Feb 29, 2024 at 07:36:05AM +0000, Michael Kelley wrote:
> > If there *is* a requirement for page alignment of page-size-or-greater
> > requests, even when alloc_align_mask and min_align_mask are zero,
> > we need to think about how to do that correctly, as that requirement
> > is no longer met after Patch 1 of this series.
>=20
> It has been historical behavior that all dma allocations are page
> aligned (including in fact smaller than page sized ones that get
> rounded up to a page size).  The documentation actually (incorretly)
> states an even stronger guarantee:
>=20
> "The CPU virtual address and the DMA address are both
> guaranteed to be aligned to the smallest PAGE_SIZE order which
> is greater than or equal to the requested size.  This invariant
> exists (for example) to guarantee that if you allocate a chunk
> which is smaller than or equal to 64 kilobytes, the extent of the
> buffer you receive will not cross a 64K boundary."

Any thoughts on how that historical behavior should apply if
the DMA min_align_mask is non-zero, or the alloc_align_mask
parameter to swiotbl_tbl_map_single() is non-zero? As currently
used, alloc_align_mask is page aligned if the IOMMU granule is
>=3D PAGE_SIZE. But a non-zero min_align_mask could mandate
returning a buffer that is not page aligned. Perhaps do the
historical behavior only if alloc_align_mask and min_align_mask
are both zero?

Michael


