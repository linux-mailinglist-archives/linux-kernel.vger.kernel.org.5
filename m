Return-Path: <linux-kernel+bounces-86146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B986C061
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2201C215DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221853BBD9;
	Thu, 29 Feb 2024 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NTDegXRh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2102.outbound.protection.outlook.com [40.92.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63C37149
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185486; cv=fail; b=U+gGgqv0DfDRJqbBANpsCJR5PkCTvdyySfd0N9RS4H7fi9iJ+IGHEGl2gpthBdwKkxcRo8kE5bIwjwLF//ZsZewCBFy2aVCkFg18vccr3IxdQLL7Qp3zKApFbYTREwASnXI2Q2hosmFg+qzS48JUmmua2toRj9++d1A6cTJicA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185486; c=relaxed/simple;
	bh=Weg3J/3hfeAwotMk8p5/WzQ5W8Dli3B+KkZAeUIbxdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npiPN9wYhdYy/DYODGVGydCQ/qmgyinGtQQNrclOCjJP1BDsXXRb9gvFwzcC8Evyr8AmWWhCnHYLHoWVdjXyuqnC5jb1oyKDc0wUqSXcasKSOLhvxVS5vDshMvo3Uicr/rfRH34NjlKUh8PL5KNOfI3PMf27K5x+wUuHpHfduAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NTDegXRh; arc=fail smtp.client-ip=40.92.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgOgTkLQ645ZFUgkSFsYu6NrQN8enRiKFwAfU7P38z4vjSyF8wCjnV5Ph8d+pxoypWdzw3xuqEfFZVdGkjpZvoO+PTrkUbl3vjaXweUp9dE/H7hzFcaMnkqCtyVbnv/DQWL+MH1LI8VzgTC60UDXcrgmzrzZdhJCTKYkpDh5BDa4Kik8e3Swgb1i/LUwUHSu5ukKl+xvDafAlqB8liAB/r1hRyYVHNFCob6CGE0nEl0xUsyK960ZPMO3FfoNpauN2xfjPoHO3jn1zK3XYgU5g2FyjFMYTNDdXDz5xK0aQRRHHcr+XHWRhO2saEAXRDYC3E2BMg2xxee6f9ov35IQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4afXCXhC0jAeHsv64CByaZu56qtzdnrV1mETI5d8tdM=;
 b=OnLb1V7pH+TiEz2uIt5S3zotpLPdCyssJI+N+0hmRmkKnHQlR1a4EWhpvXxdwWUOGBMNuxCyyS9GjLtvTlcU3yAOagRtvBWQJRJR5598aFm0s8Vf9+Dv6xheuIjrjBwG7lGRxHMgoTbrVeq40hv4PjhR3+RQk0RcYk/SuY89oMcDIekJpSNj03PUXtgE1fRlZUG/FMhupv+tJxB+xv5V1h4y5UldBjhQkxzTTdVQtBJKzoOicHgrU2NSGRLqUYl6tIHJzF0w2qAmluHQwkePMbvnKE+Xb7NK2ZfhAn83e5dInopL3wm0zSuLEnJoLkiRqnNJBgxzT/2c8edSeMCHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4afXCXhC0jAeHsv64CByaZu56qtzdnrV1mETI5d8tdM=;
 b=NTDegXRhlT0tTibvfrzvFHGSVfYUXYiG0V+MxVvSCpzZ72Xy3bR6i2GbWsfohxapjv/0X648fnZEAsjwaLGg98jrX1TgttOluTikf4wYu0CZTKxj4GZa2hiIA3CuBkrGXzbT6dRe5qkjjsr9lJXE+NvIkkEHMeXSv8svSngkDiDOA/0rZB0PSS3b/YzgjoqYVcwvdRiRH8nvcN8yTiQd4K03h4uI5M/0w4nCsj5l1Ep+V1DQGNebGHS0/hEgVZLCRh2ipFVZ7PFhnjhILAlBGQ7duoyoz5AVFnk6GV/6u9OD0WEyWF/o6SR5kXbYYssa4QPAKNkL/k/sSuQKgdHoeA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7843.namprd02.prod.outlook.com (2603:10b6:303:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 05:44:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 05:44:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v5 1/6] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Topic: [PATCH v5 1/6] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Thread-Index: AQHaakuXItTjgViVp0ie0rpUKtCFmLEgz+ug
Date: Thu, 29 Feb 2024 05:44:41 +0000
Message-ID:
 <SN6PR02MB4157412391D227828548F0F5D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-2-will@kernel.org>
In-Reply-To: <20240228133930.15400-2-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [F+K3BUg7upsEjz0DGmUevwwTGWe/4aIJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7843:EE_
x-ms-office365-filtering-correlation-id: 14dd9a19-9fae-47a6-7e30-08dc38e986a2
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPeYjFYvO1W6af/5iy9uul6q3BaORcCFUq/6NSKrshRneqExTPlR2Vzt6oAJoAEHNF5GR9LgDxMAYo+66tpTltyNRCR8DA+rHUri+I6ywaZI3JYvSMa6h0aQsVQ6pXUBQUn/b6St/AX8xrS/PqTBPpMzZcMbeyFdXXO5t50qDnFIWy6FnYRKWY1ZDsYXLPJOlqs896g8v2nVnZsR5fGthAWXxeb+RkDV0y+Abc1r2hka52jxs9SkrfMWuFTTkjLe8KI/96IBhU08GVLo1Q41ySzHLusiYh53gVojnr+lfZZ8tybCa3R9rPrc+cM3+DRvo7KjDU1YvsOPkvR88OBsJBirutCdNRWqXB64vZ+Zl7CSlxrn61vMZJ7e7nbFUDYMM8iaXcSqZcdOX4nHaITHAjgT6fXhkd3qSMmDjTnhVDGz6HSvMurk+4UiR7qRmNsCeEzfPkVU8MN9JTDSeQV9XMyMC+PoXCE1jP2qToJKyiA7jJtGMX/WYaLfHPzdZKcflRRWjHVdiijcwM3wArDy7zwQaPTDNzohagJrCy48xkUkWiz5PWSYUkTUA9hmYXmWBIXonc5yJBhrX/vi45ee8rmtfNDW2pSljZaNEDvJQoRMAAaOy+E3MV16R3O+nB8fFD1DQIaBKhptb1e4SGHZoX8u5oysqE5oEmEodGXOkWnEDZJA2sVq1YzS9t1TAMAreaWAPuPY7HZE7HBqtZ/BQ5zP4YoGRwfTA4xjSlKupQnf8MgZEFs3m2pB47b4EWGLvM=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1chwqbsYPsYmNlMyeUxtufGICi6xmtY/rDQK1KUw5v6RKrr+4s++gw2+0cS9tllN58V3EZk82wsBRfMLuxakoHxzPpSrzjUaV4bHX/+9BFYknpdFC9RtuUwnpfqPP6Uu4LvGbq4OWsrBBryb9nem8zKiyMwmkhihF5UjcDyBuyjo0sJCIs5KqdpoPDjr4Sy6GuI8iBqv2QlFunQdyRK25jBCjpFmkFdYWVv/fmWEuNTb3M5lyYRwgm4CpjBP+JVyPcO/i16IuA1XJ1GYHcHWknE+QcsQE+fX0oZqOV13r+OZsd8lcJ3t3d/uk0xeTbV7zSIybg1IEJ+MY7PqepHdENxCdf1awnZ9WlOm+rsiEeqwiI9R3gXkZ8g06/Z7oFN4MbwtoGs9oz0ja2XV2JfMZ5RsqkBHh3czzC8zKrb+/feqbJofFptc8Dbx4l9lHEdSr87V4BCkL6aNv9jEVJyNJswEFAIZ6xjWUOgeQkTA8wcJKKi97s/odlTZ2gnTw9pv672I+PAecBsIpYXTuGpYDjdxvDI+NMDDhHH86uMs+DEX/N8baLu4kx4KXPHM3ApB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0PcZZ6inofirbQEAH5AmHDqOvi73DZ9ffq0wftYNB4rdZ3/nAOGEWH+4QXyI?=
 =?us-ascii?Q?BHyci8rAXnVcJ9pE9l/+6+ZE2NOIF2N3cyTCexNMEMyGY90fiPrXT5mqzh6T?=
 =?us-ascii?Q?BRmbpEhL4HpBsuVcsw+/t5KxZGXrYR2UF880bKlN+iZm0jBCbqJfvf4RfJBf?=
 =?us-ascii?Q?LQz94LEw/cr6cHY1nJPYjV0w2DEvUWekRkWfixtLvdN5w3dXpAgM+LczIWq9?=
 =?us-ascii?Q?OjnEgOzvDBH7bcKC8xRCmVk6Yqsu8upMp8BUhbHDCvn+h9CIsHYR6C8cLAcJ?=
 =?us-ascii?Q?Hv9tPFma4pO/w0eMOvOzTtYn+0BvjPw2JP33ozll5KqwXBm+NQ92AnGfcWst?=
 =?us-ascii?Q?mtF2avmtCkVRayR1IVx3CJ7P5/kwyMNAzUZEcoub+fdUwUdqSn8Bu6WwD/iw?=
 =?us-ascii?Q?TgYrnyMq818SuZePtVYVH0Pc6rkkI+b9OOp++c7sxnI2OWybtl9UkC8ydgJJ?=
 =?us-ascii?Q?8U98nIn3+K9f4L3SV8lT9axX/q211QyBxGwyffrChNBstpXlJOcKuzNrPclq?=
 =?us-ascii?Q?Jb3WruPNskb0RCNjCQeUVMphEa6kfLQFWCcSeNvbJ7F2fnKK7tjmk0aU84Ka?=
 =?us-ascii?Q?MC85zXR2zhECGk0dYPtDMVJMZCslXrYSaq0YEvUv2F7DgiB6yA6HdxnGjiuI?=
 =?us-ascii?Q?lR1uhLuptooa3DuxtRyUY3ZJKPuP9zLgXOy7jQeAil4neZg7E+qZ2P5bYQgB?=
 =?us-ascii?Q?0lsSITd39AWtpYsbWBtqPOcCe0DXZSCQrPXE796Y/CEFhjTDjeSxF+l350+g?=
 =?us-ascii?Q?V79VbTGPmkChnx9CtmnWWnlKW0PPiPzYwhyupMjjFn8ga6a9r1hbz7NQlKBA?=
 =?us-ascii?Q?eciweHUKIaDAoBaPWZYOrtznefuvMRyQA38kuXbExrqZWCkOE438GCJ+KmLT?=
 =?us-ascii?Q?eDhkMtRz7cIve4+ilfAst0Rdgt6USrfsImO1LUyvfUN05ocRwSjN0ZUOmGv0?=
 =?us-ascii?Q?/ZMwjq8fNBzu326H7mM16OoCQojldoO8NsAT9LLOl+QgcmVIV0gYk0G9odpJ?=
 =?us-ascii?Q?JHbcfpUgNy3Ex7jJAfq3MdwwDfr2EGN4K+rO5KVWVx8LJdWB6J9gjz/i7E1w?=
 =?us-ascii?Q?b4UrFhwSlbNb8sbXtH8uv9QKlc5+aD3qbE3wYNrdDjbanddLQ5xwgp1HGuvA?=
 =?us-ascii?Q?PqssuN0Jq/JGjygPhTMQ3eLsuSczIQIM/KY9vRRCQoPbwQuyR/x5bcD9yC3N?=
 =?us-ascii?Q?z2mamHkBJoydC8iH+JErTakT/Cx+l2eVdRz58w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dd9a19-9fae-47a6-7e30-08dc38e986a2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 05:44:41.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7843



From: Will Deacon <will@kernel.org> Sent: Wednesday, February 28, 2024 5:39=
 AM
>=20
> Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> checks"), causes a functional regression with vsock in a virtual machine
> using bouncing via a restricted DMA SWIOTLB pool.
>=20
> When virtio allocates the virtqueues for the vsock device using
> dma_alloc_coherent(), the SWIOTLB search can return page-unaligned
> allocations if 'area->index' was left unaligned by a previous allocation
> from the buffer:
>=20
>  # Final address in brackets is the SWIOTLB address returned to the calle=
r
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_=
mask
> 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_=
mask
> 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_=
mask
> 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)
>=20
> This ends badly (typically buffer corruption and/or a hang) because
> swiotlb_alloc() is expecting a page-aligned allocation and so blindly
> returns a pointer to the 'struct page' corresponding to the allocation,
> therefore double-allocating the first half (2KiB slot) of the 4KiB page.
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
> Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

