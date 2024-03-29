Return-Path: <linux-kernel+bounces-125489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F61892714
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E688E1C210BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726413E414;
	Fri, 29 Mar 2024 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jLCwKO0b"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2016.outbound.protection.outlook.com [40.92.40.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7213E401;
	Fri, 29 Mar 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753192; cv=fail; b=Tc/AvNuVi9yGggJ3FxqMXyoI/x0J4lyBmOPhmY069tMEX+rI7sgLw6DBZTHZzdCEI5Q1lQL5W6FH0/ipW1ZivDSmzTPqpl5Qu5O2y12L63Fb439UHLzjV6gkijim1/b/qTVqNJysS55T2wH+c2vENtGqyi6rOcqmNculuf6jO8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753192; c=relaxed/simple;
	bh=M4G/CWBx2Oa8+fRgMukMy7+6TsKN1RSiWCrndu3BkzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhxTE8SANHyczUTKPtiwklNbccJlXz4vouoocrfLfwuXYES6E2W+TZhCEUon7lxerGweaKvUck1oB1WM/xg7orORSjNTwmXXSHiE3aF5G49Jldyin1XpEka5UlMJlKpcNkNX0dhkzgaHbkXe8tvS+dheS6v2wRbGrW9pY6Nwd74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jLCwKO0b; arc=fail smtp.client-ip=40.92.40.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKKne8PNcq2fjY5igm0MaXcDWKiT7x7yRfRjUxv5lAKCmQ9AXWgcVPTPY0aIYlzLE3FNi/Ir2ccmElLyh1v+SzUEtvDKUAptRLMo0tNbVHFQ47JnpNLb8bmUaVYxq0t58pqqx2pp4kzssBjeoKYuc4Cb8grUCncMD4AOJQ6D6v8yc4urqyvwv3AEzOrKxDFEjvoxaxO1KyeIlOs5DIKLRm9NzEp6bPnqBImbqGJ2l8qwbs0RE9O69JZ4sL7SVvvLdf5BlLfz29vjKt64fUmyAjePrnWVVtCs/QMIjMmDeTqjwO4mez9kgmuYzimQj0SmHOWtpE0DiQww64x6yOiDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaxmU7YLrhJYdoWV2NktOvWHZ/acTZwL0PV5wnksq9A=;
 b=dYgUhwZDK2lCEMhbd5MDOhXApEJmiPSSlsOByiMMLkoxCVyaHo3UPK8i4NvCgG1S5E1+4wafVc96Kcg+tnVensRnYAs5ccXehAYh1LU4EsAuRsUtzEpU8OqSyfXgd3X7SsL62/Sewnx7yrej8m2fsZi4JnC1krgkNqId+PRmh/xRXt6+8unsz3TIGR4Skq8XTksTNMaUNkVaKjjo48m28LlLXyUIU/WuW1Xusf0t7hHk0dlJ7n70QLZKUPQoTMAyDCx+XNP+jNPSxVRqZA9LwPq9LBocQlMP0xvoF8dvXthmApiz9RXYduh1YsXcuMF3dsIEVigXxjWGOg0AwJuiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaxmU7YLrhJYdoWV2NktOvWHZ/acTZwL0PV5wnksq9A=;
 b=jLCwKO0bAhVXx7YMnSmVDZPud0iOqhZ5O3NYCIaFaoJjIzG6pDZaam4yzUTwmK51pUFZTtgoNE0wPinjhtC3mTqMbzidvnNxhLm2Blm3GNpnl6aLgM8Kr3iLGPgz2Clz9mhlj5iHEopkr0YEbldpZdvzXEFWTPSsnG/5X60q0Jkuvi3Ym9xu2L5e6QQ0MwSBb6WVswdtmqM1rErUyyD1E6kzRymJplYiETqWXcVNM6B+46CZLugFbMaeyi/A2fJ8zt2cpG2haszZ5tUUtXf7ECqlfSVcBMFFhG7dVdJeAQqH7VIhGmntkTC4yQ77kzS4izwHxOMJIRTFplW6x7A0rw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8478.namprd02.prod.outlook.com (2603:10b6:806:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 22:59:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 22:59:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "zhangpeng362@huawei.com" <zhangpeng362@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Topic: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Index: AQHagg9QlWq1924eoUuMlxAYgr9iE7FPVPfw
Date: Fri, 29 Mar 2024 22:59:46 +0000
Message-ID:
 <SN6PR02MB4157D73B5BF7161B3A5596EED43A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240329192809.17318-1-decui@microsoft.com>
In-Reply-To: <20240329192809.17318-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [sM8PSIUmV3Ftfvtd6WphV0zEkwbBQy8p]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8478:EE_
x-ms-office365-filtering-correlation-id: 8bcf783c-101e-4725-7693-08dc5043ee46
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ocalrKaLRSVt53m0tY5i/5898HbhBWr8iKOUKclpn5UaGiGk7SGeolOdBBnj+4x5Tb0uraKqpeZ2Ld25tD2uISczggqp2cGXMiBa8160DEI1Jqec/nzd+tedLIF0RJ8GXGuiNs1HtXLb/gOxCLlqKiIHjxoMJi+lkKchgB8cclovSwPK5hccVywO0wB/R546fPYW5BbWGKcrFx3sRceEYVqwr2dXDix8quk8S5ic0/d60s1TT4X5RRGYtHP5tNnTpCfZqkBbMRy7zSQSMT35qPn4Bxdaw50XNgTndupVKdV0zTJfBFj7sBZEvdxAexzowU3yYwCVZW2AxzSRqOGjlzhj33te7LSDNWhjzkU+VMZr9ftVZigXAhSV9fKi8ZMCAHiQw+vWJXqiimUdNMdjd254RNjLM0pTEba92BYYUyHXcUXAGKlajl3tO17S8Yu2zNw4a8i9gEPbkNPpLICOHPFPI5W6RIwY/nc4Cy3xacMT1XeC+GFGBvROAba8xeWObwAjf4z9EwPGGrGvEA+bQ3ujbG9eBH2mukDJw7W24Hyon03+A/TGqHWlMv6SbAyi
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?soFo4xEkaj08zqSj2hsC6ivZNirTPoISk3LtBbNJ14SMTXxCSkRNR8HHhiHV?=
 =?us-ascii?Q?aOlAza5EJd7niEXQwO53TcFDt9Rm0J3cGRoEaSJ3XucqhSYX7lFA+XNAn5gc?=
 =?us-ascii?Q?Cb4/tVFC+H//ydp4TTVF7Ib0g3vMLghCAf23amDZk3lZl4aadd+Axz0+hXcH?=
 =?us-ascii?Q?7mQ20hgZ9Go5sY6X89QrgwUF/QnlDAIW22kqHNPUgLwgCd8fcHV3W8PrJHyx?=
 =?us-ascii?Q?zwvPfhkjK+mwEDJgtt9KtKkWOUusFekvvyjmWGc592f4sv73JqYHez78XfOb?=
 =?us-ascii?Q?vCEQYxcqcReGVWNZQYR+JCurRT6hCxkeJj/kP8eZ2inYtnWWhO3tpH1/JJuy?=
 =?us-ascii?Q?dwNoQf7E0XNE4ZHPqiUGBs75iaX7Li0jvd6cSSfT2zTWUw/UEsXI22kd88XM?=
 =?us-ascii?Q?H0q545jhmwRolsHRzdwydI8j5ZzaxT5uEU7hB5yz+0oDnnOdl9UsYkJpwZdC?=
 =?us-ascii?Q?aZKJShtphm54SUYqJuE36S8w4PhoE8TOwtsEhkmToh8/hb5WVkAJ4AWpxRX8?=
 =?us-ascii?Q?f7CdiUn8LVRgrTxhdJnstTCrWs5B1omGNF/K5ayFc5jzkzivhxXitfP7n3FZ?=
 =?us-ascii?Q?ysevv+uLtlGtbFjuP0Se03xTZS1B6wJIV03xYO4+8kei1s05lA+T5duNH058?=
 =?us-ascii?Q?emIsMFvFNLYfTaF2NL0eVo4Eaz6OKOhLZn/y9MXtCI/0OY6P5wf2iE88hxp0?=
 =?us-ascii?Q?x6Vk2q+nheF/OjFu3WCUmPeRUF2Gjcj3HpkuM04JF89RSPL5tTfeafDOduOj?=
 =?us-ascii?Q?vGjLz2oiGFJ+gstmfyv8SoNYcw8PWX8/hW2CgXRoNV4aAusr9aQSP9UwYC+g?=
 =?us-ascii?Q?ia5n1Iru1vWzAFssXyS6+PQ3lZ8mBrYf+SMydvyAelxG0w7oUl0lYDz2C6JY?=
 =?us-ascii?Q?hw6WDElvZw4PWHib8M9xYT8Fqz1pIKOQeXzUmiCK2anJgtvXNqGMNXf2wE1c?=
 =?us-ascii?Q?M5SO9vj0m6voJnNsSXLEukdxWBWS89+vOBy2R5uS3pJgs+ltXjDZwP6Kfoh+?=
 =?us-ascii?Q?/a63byZ/gL1ogI1AAFQw7E3bddIRAFhAk61HVh1ehTtCylsbcJUkNB1WhR+j?=
 =?us-ascii?Q?pJPqOYU2pMavqBkgVYnc670mnjxafnj8B9R23Vu9zzU+PBftCnHC4S5x1vzc?=
 =?us-ascii?Q?ThQx6+AffuOUVhkIF1341H4QZdNig5ncd6CQOAP0yZx9ImPm3rm7B8+p5Wtv?=
 =?us-ascii?Q?Ks2Xz0+Qu7Bb2Lr0fGbS5ysurl5/D/6u6zi8+w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcf783c-101e-4725-7693-08dc5043ee46
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 22:59:46.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8478

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, March 29, 2024 12:28 P=
M
>=20
> Sometimes the readout of /sys/kernel/debug/swiotlb/io_tlb_used and
> io_tlb_used_hiwater can be a huge number (e.g. 18446744073709551615),
> which is actually a negative number if we use "%ld" to print the number.
>=20
> When swiotlb_create_default_debugfs() is running from late_initcall,
> mem->total_used may already be non-zero, because the storage driver
> may have already started to perform I/O operations: if the storage
> driver is built-in, its probe() callback is called before late_initcall.
>=20
> swiotlb_create_debugfs_files() should not blindly set mem->total_used
> and mem->used_hiwater to 0; actually it doesn't have to initialize the
> fields at all, because the fields, as part of the global struct
> io_tlb_default_mem, have been implicitly initialized to zero.
>=20
> Also don't explicitly set mem->transient_nslabs to 0.
>=20
> Fixes: 8b0977ecc8b3 ("swiotlb: track and report io_tlb_used high water ma=
rks in debugfs")
> Fixes: 02e765697038 ("swiotlb: add debugfs to track swiotlb transient poo=
l usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  kernel/dma/swiotlb.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 86fe172b5958..4a9f02c13da6 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1647,9 +1647,6 @@
> DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_hiwater, io_tlb_hiwater_get,
>  static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
>  					 const char *dirname)
>  {
> -	atomic_long_set(&mem->total_used, 0);
> -	atomic_long_set(&mem->used_hiwater, 0);
> -
>  	mem->debugfs =3D debugfs_create_dir(dirname, io_tlb_default_mem.debugfs=
);
>  	if (!mem->nslabs)
>  		return;
> @@ -1660,7 +1657,6 @@ static void swiotlb_create_debugfs_files(struct io_=
tlb_mem *mem,
>  	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, mem,
>  			&fops_io_tlb_hiwater);
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
> -	atomic_long_set(&mem->transient_nslabs, 0);
>  	debugfs_create_file("io_tlb_transient_nslabs", 0400, mem->debugfs,
>  			    mem, &fops_io_tlb_transient_used);
>  #endif
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

