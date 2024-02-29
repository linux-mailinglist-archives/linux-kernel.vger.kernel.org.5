Return-Path: <linux-kernel+bounces-86240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946786C2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46E51F24F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975C45955;
	Thu, 29 Feb 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aP5UV2zC"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2054.outbound.protection.outlook.com [40.92.41.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142B44391
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192171; cv=fail; b=Sl915QqiZpykxSnTK1Alp3O96D2uTveMhcb31xLzaJFR6VIaanK7B0MlYGzZn07FZRcKsobpLpwN+EYx8d5+0+eMRT+rIX8G/FjOk8fd3lEmLHW/Ttts85kXVLJRVzPYYJ0Kke8eWKeX6RaPgT2SzIst3SRTqVdzDFJQMH6wNoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192171; c=relaxed/simple;
	bh=KS3y+96FU0MWaX4D9C7Fi3Bqsn+8Xpv+YubQvc0tCkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rc5HwYAvNdAS60cBpP/9sE6zN/KBRlWuArCIWKzqp5q77bKtJGV4HLB9F0DLunYBGJm8AVhPKcc7iSjvLbjPHhDDkGBOdFqgr+QqlQdBAmecx6bHgU78841IFCfkPNQBn+ahH6hPsyjkbQBpYNSq43n3Gy0rbSLAVC7LtTgc1OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aP5UV2zC; arc=fail smtp.client-ip=40.92.41.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnPYAOGPa3pWqcdgpBesmwHi8fnIq5jgPBUIEQ10InCTFZZZj60we9GVsgL7wbJMIoRNP9Gl9d2U4AksUb1mgHmXXCD7qsJVIY5xCrC1mD+XFLCGyNLRqXRBdZ3BuR4LnFvRi6mDn8YeLW+waqpwPTNzTeuVWpT7C+Qb0IQTZX4SbwRQh+Ut5KybeGGCtA0Z/HpE+d+vcU/b0FIjbcOnVfucpRgIC1wj70ptNb+yR2Cknqwf7memjgbZbnO48DPmPR4cf5T3FXa2UMsB6bYEexSOJgWnQXl2coIC7aSlL2B9E1YK9t0z+0KuUihZ+hO38ZKMjxUICC9x8OaKW+JgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO4YTlOOjtAWTRt0Dbwct8P58rd4w2p8QseRByuYVZc=;
 b=OeqMZ4ko2Vr4VDrnihXSsgkvn5Io+1M/RvBT5Lah8RTrhzstNBuaIqb5UYI+v5Cq+YammZCVm4ZXL9WTS51Bx+D2emDUEtyiHHgUblI0DDmYLKng5TEho0WmRhO2Bc9Ueffb12ghnwb1hga18UTWOSqhOFW71EZe932AKpbHPKvPiaZQFG22jf+eG/GLHj6SuTj5/cQ9nsRc9xsNrTZIkrQoq2OCG0NO/VcRZcex/e6n2A1UX+Ug+6nIKnHhOVipJ68pbHT5y14b2ZvJXiWds/jRdgr/0of3kUYnTB/tGTbFTsFGpcA0/SyoWyigk5KJUmqvK1OwQeEMz5ne2z4O6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO4YTlOOjtAWTRt0Dbwct8P58rd4w2p8QseRByuYVZc=;
 b=aP5UV2zCEukPmgoYRlJGdWohIs+ir0uxlzSjD7ZGm6U2IAalicaESZOazeuOgO9pwanvH9zY2zo1/wW4E48RA8NQ6YmQGGwEKpNlLyJ+hzArZnAJW67cygei5Do+pty2T6nBo9aDq3cxKeT4HUmyM7RcU60ihq735Zpl8ChbiWNyBJYBc8r4D3GBZwuzvDx6hRumGYgBajQA9TBSXxsHoBM0zAoCAxZhtisn7nLcndXQPD7GM4jDx7Bj0ePV5aIDXzJUdDXjjbZaqAfA6yHkvvQnglBgCBw8CqGVOYQpp8M4PwzuCUIrcoEFxd5povbF4RngU4paRdTAPEO2Z8oWAA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8022.namprd02.prod.outlook.com (2603:10b6:8:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 07:36:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 07:36:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Topic: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Index: AQHaakuep9s0mIf3eE+om+sQlmyZtbEg06/QgAAR1sA=
Date: Thu, 29 Feb 2024 07:36:05 +0000
Message-ID:
 <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-7-will@kernel.org>
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [JjVH26CSkS77Hu1bhHR4k2X5/jjNX+H5]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8022:EE_
x-ms-office365-filtering-correlation-id: c51196c4-7580-4fa7-4db3-08dc38f91670
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5hTREnYf2Fm4YrNv5hzF7TYqXKbsqPjUjqdnU9PdlU33sO7qjpfnRQ0wlkAmrXa7qYuQydYIvSeVw9dIA/FQckPVNfoBPGaWvh7fnSxEtlvZQ0f2/CGVKhxYXLWLqfKiFPWTtGa97iS8pHNmh/pX/IS7xp4RlJMrTL2Zh+96YRrJCQYTo4QsGD8XYDIrP9G9WLXn2iFUQnlUtGf8AaCat5shE/kkmyHAxSzkAsLGORKGwEUowddBptGQ288hftccZWpBXzSuORm3zd31yfV1JO8mNJW16E7asgEhSo7DHSwU7n1AcMu+UecxYQMNYy8ECOEE5AlAlKYRTb4oI3R3TMB4bo/v5Jy2pdRsIEG59rSTkQzlj8pqOGQkSAj6utTiInKA8ukL+Z4J6enX16bye44VtdlQisULDySJnj+6JYnU9FhhHiUCEs49b55ELNWBuqZVXxZkUfYD354zFSNzSzSyrNxTeAe7xjquSSMYpmZvJi6pxpXIMPeUXauEBYluBjvypvV+bPLA5Xp6SsEJOPvrqs4PqZs2UfncYI+eP4mUsL35G5ov96kIiIVbb0J4
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wk5AEgXsaiOIzdsBB6bjKxrKdulyQOFErOCnkwIVy1fO8m+qLW9nm5d/+q49?=
 =?us-ascii?Q?hgsGMigGP3Xh54+kNVbItUQo1yORp7cEZJX7ci40nmEEA4e2kIs71z8NIKPZ?=
 =?us-ascii?Q?9oD7dZVK6dRi8T2T0aJ1UgqOZl2Zxbave6yU6At5DkHePgsDqrBuNJK5sC3F?=
 =?us-ascii?Q?nrnDgFOH8qkDYrt7CDYa1tuTf6l4Np0iyolO2SQT+v2QPxZSujWTOv16KAhK?=
 =?us-ascii?Q?CnB8Y0ryhzAzXNBb/FHx1cNJQ4LWsi60G1aqXks6RPI5Y6Zj3WSYNAcHXrtE?=
 =?us-ascii?Q?rtA8GAMYaDtzLZBiJwdWfD++ZDJHnmB6RP/JRDxjQfH14i5JuUCZH7Q5AwhN?=
 =?us-ascii?Q?28SJ2XuwELMXv8usHKGlNEQotbyycKf3/0I5d2zSu0Er7T9HbL2m3jsywY3R?=
 =?us-ascii?Q?bn5pLgr6e5cLbTyQaiUluWL9zhUNByLXHmIeiNjfWaZ1ANFZU6WAX3/mOEHM?=
 =?us-ascii?Q?lxyKHc2831obYJYRG7YjHo8U8CsG+zA9suAeeGDLSkHKinEiqCPHF35QPiP0?=
 =?us-ascii?Q?j+FRXQvB9kqPe/p3lEB/dZtXu3wLDnTGaeSx4wFWEYQRGc5O8AKhYaVHThEm?=
 =?us-ascii?Q?YT/b6FbYlx8G/oFWL5VDdmrG1DulS2sCMIHcTPj+JDdg4l+WXr1RELEtDVpa?=
 =?us-ascii?Q?NkPDEtaJ+9dnY6QcjS30Hg1FX2iD8/1pgXqgtHsC6i4Ab5oWcy6iOKG0a9TZ?=
 =?us-ascii?Q?99s4XijrIVooq4OAolm85/u4ngqCzZN1oME4AsUDf0neArVXwuEtrGXcDa0H?=
 =?us-ascii?Q?qEcPXvsR7Vmvw9HHFGfqKzvpEBe/L/IBuBhvBeySCsjOPBza1V5oJdG+8xRB?=
 =?us-ascii?Q?kMk/SecBmtohoNFRThEz2WYIxCUGyu+VwUjGXcpKWQpof4gfJXKTYXQSXxvw?=
 =?us-ascii?Q?NPK1r99ux0J+5MfQRKAeZ69nJFPo6sAy1AB/3d/NH/Bq+v5L7lnA+jRBxZf2?=
 =?us-ascii?Q?ljqWTYfKXsEzagbjmZR07/GCFCqqvXN1mxdaS297FTDhrTfPdF7LnxiH4ZyE?=
 =?us-ascii?Q?LZM802id2iujW+3vQ7wUdjxWWjAsBNkBrgEskbzjWjHNDu+0jni8ezu0+BOx?=
 =?us-ascii?Q?RTwSw1c6OLrp8l1o6hkyV43PboMW2vM38Ki+zKIIHFcmErIupOCq6I5ULjoG?=
 =?us-ascii?Q?YMjerIXTcdEzrUWAHMC/ixMjtbK6ghB1LbiMWM+m6i35drhsonznvz7zMV/H?=
 =?us-ascii?Q?dAkzJCOgPqF3odFnIPpBz05sXWf4eMRTrJWMKg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c51196c4-7580-4fa7-4db3-08dc38f91670
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 07:36:05.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8022

> From: Will Deacon <will@kernel.org> Sent: Wednesday, February 28, 2024 5:=
40 AM
> >
> > For swiotlb allocations >=3D PAGE_SIZE, the slab search historically
> > adjusted the stride to avoid checking unaligned slots. However, this is
> > no longer needed now that the code around it has evolved and the
> > stride is calculated from the required alignment.
> >
> > Either 'alloc_align_mask' is used to specify the allocation alignment o=
r
> > the DMA 'min_align_mask' is used to align the allocation with 'orig_add=
r'.
> > At least one of these masks is always non-zero.
>=20
> I think the patch is correct, but this justification is not.  alloc_align=
_mask
> and the DMA min_align_mask are often both zero.  While the NVMe
> PCI driver sets min_align_mask, SCSI disk drivers do not (except for the
> Hyper-V synthetic SCSI driver).   When both are zero, presumably
> there are no alignment requirements, so a stride of 1 is appropriate.
>=20

I did additional checking into the history of page alignment for alloc
sizes of a page or greater. The swiotlb code probably made sense
prior to commit 0eee5ae10256. This commit has this change:

        slot_base =3D area_index * mem->area_nslabs;
-       index =3D wrap_area_index(mem, ALIGN(area->index, stride));
+       index =3D area->index;

        for (slots_checked =3D 0; slots_checked < mem->area_nslabs; ) {
                slot_index =3D slot_base + index;

In the old code, once the PAGE_SIZE was factored into the stride, the
stride was used to align the starting index, so that the first slot checked
would be page aligned. But commit 0eee5ae10256 drops that use
of the stride and puts the page alignment in iotlb_align_mask, for
reasons explained in the commit message. But in Will's Patch 1
when the page alignment is no longer incorporated into
iotlb_align_mask (for good reason), page aligning the stride then
doesn't do anything useful, resulting in this patch.

If there *is* a requirement for page alignment of page-size-or-greater
requests, even when alloc_align_mask and min_align_mask are zero,
we need to think about how to do that correctly, as that requirement
is no longer met after Patch 1 of this series.

Michael

