Return-Path: <linux-kernel+bounces-59891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC584FCFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E59E1C2610F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE8284A44;
	Fri,  9 Feb 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ymq76vmT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2104.outbound.protection.outlook.com [40.92.21.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090AC8287F;
	Fri,  9 Feb 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507449; cv=fail; b=jv1R4T8/5CydUV5cp5U5AONvFufEkJaiTASn+wGbzZQAGfH7PDoeYQMlqBM99RFtKnxw0D7pYunGXpxQtUdVSy2V+0tZQPsX4aLdIqq1sXeFJI2PLuM2pt32ZdzgtLI3ekKTF9tTCK3TxwGlLT4Ol52yc0G/TOqn4hkO3mLnUdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507449; c=relaxed/simple;
	bh=ILXwQyG2LEL9vuCpZwpy/ZQXduGu7XWnwrIwy42Igig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cDpZUjOoCPuLGmu6lh91KQkQyVl9VNw4dhdwakJZeIBqivZmcGso4BgPb0kAljGWtofRCkC33gwGuuugK5cg7+DtASXjeVeKTkb+89KSzvWMGTUTHheYgcnvgVYL3zVfp5mFQCizLROMA8bKQScz60SYcR8ol5VUafpXHvzAdH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ymq76vmT; arc=fail smtp.client-ip=40.92.21.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiMIdpVqwfRBaRVfOsq7v8EEERVp3VRu4EUdjmcjYLSr2zD7zDfqQ+pUTS3YiSSfrrNbBQfGgHIKDvF5YAK9DiNyln3EBwfiXUjbZ+OR5o+2j6FLjkvRkE6CZidkeHQ8JDzfE1yQWEDUZzqU07FwOIC4vTrvkgo5uVWhOPqKvQWmsUPVmuHykVTONk79PiqbWC1fF3vKp8xXMKbroVAXXIEOFzIOjYuZlQyyq+iTUmRSUcgOH84fjtUclPF/6YLR1muN6QeV+75CDlDys5Io+1MUd/b3QK/hG2TlmDbJBtFJYromQQ6+XHZNawNlSVCfv+AxNcuMSZgZoRF7xg8x6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nSXYHI9uB8RyxtoRjJOdWU6I4BSCXsmsEAt5aYWvOg=;
 b=OMinebCIVSjJa44nAQomiH6Hv2jpOuk6FyD7nb80VI/BzlOd4lQ+4uwbha8gKCfU7pcvUxXszMnIAmO/17YhV6d5rc6yHOKKhPGpvOUHhFqLmyUNWiRLPQRcZILhEoQpIhx4ruajnoJ0z507T1vsnhD48PEHTXgTuwJlCbUeylPZfeZvpX5M3Wo6Ysvy3bBfFHwpt8M0SFH/v9R6OriDLpUyYaVCxM5HWq2ZVMXgMtbs/uEvG4Tz0r+v+faJhqZqOr0No6cYJg8Y6l1WpV/mRi6qiCQNTvHEKmzux3xdRXsJ0c1jWSbyM6U6FtOMu3qobGOaeR2KbC9HWP5l91U4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nSXYHI9uB8RyxtoRjJOdWU6I4BSCXsmsEAt5aYWvOg=;
 b=Ymq76vmTmy6oG+DUF+YO0wb+NqLd6THcpgazb9FHiIJfY2ajo+SZbJp0WBDn6T9QcrRMryYRwBQT6GJKk0pDYJnEIC+pAv8zBvL2J4XHUN7mdHD+Qy7k8dn1da8CQsMnbxGjY+Td5lj8BcZo/LEa60O4tsvYMMFo7Do0XgQiB8WYRvVIY+KIZoKlBrSxl2YTCENqc9Z81n3Zzj+XPeLlUbKapi/vc2T3YuFDDKlgiyQQZfpnBOyv63cyMcM8ghw6KCunC/pdMNegpr61jZOt86z0JSoXbMPyNNOffEjhcKthqS/ZRnokDukhHL3BvNwB3lg76Q6JP4twChFkCuMw0A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9317.namprd02.prod.outlook.com (2603:10b6:510:27b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 19:37:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.027; Fri, 9 Feb 2024
 19:37:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun
 Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
	<frowand.list@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: RE: [PATCH v3 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Thread-Topic: [PATCH v3 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Thread-Index: AQHaW3j+UG9ZZrqvj0qLa4F9lupB4LECZ1uQ
Date: Fri, 9 Feb 2024 19:37:19 +0000
Message-ID:
 <SN6PR02MB4157B73801B450853E04369BD44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <f0ea76846c89a65dfe42933d78d770004bb3de01.1707493264.git.robin.murphy@arm.com>
In-Reply-To:
 <f0ea76846c89a65dfe42933d78d770004bb3de01.1707493264.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [B9A1mUvZtHVPxvEJ2o4GSk9CmJ2HmRuI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9317:EE_
x-ms-office365-filtering-correlation-id: 337a2f12-2bd4-49cd-8873-08dc29a687ce
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3US/y0l0Y6LjjIkvOY1GX59DGad2BufVh89UZvnpLW1miZPBJUGYVPJvZH7Mn7dhLWXtK7A8R4aRb+J5oZI4Uv24cUdAef2fVN8ZgQeSUNt/oQ4Z2Tk4eR82PRyiMD07yyQzKsjF47QSDEilLGTNApdBGUpaPTlL5pDEp2FV/9nqTZ6FSy1j03x69SeP9556ceOmbcxOvHiEFx54D0bZAP4ODhoajKmaoYIKkiMR1Y+5lTgreWDWROnb8Rt339z6HRSjKnhPjn1bLJNk1FaqeAI6VS1EsXu0gwCc+j9nSlT2Y4Nfxa1/jmxkaesYRAD6ZqAwtbZSpXL+016MrqJgFyQGWndkE7xs2QYMOtsqjKTcFXO3w/P2TWMVR0GaVr1NpsqCmHFlqNrrKnsBmAszeBvWQrOPRvrZeVnftCt7jfE7jafImfSJZ6GRN2wY8XaKxolNoRaASvnbvUr8jKXEnsywmZ0kfc2+F28Ti1GiO6Z1DNMWsWNwiI343x1L0XnWFoVUWqgI+WHmCCZzMg1BrgUmwc7VEBvE+YvAEigl9Yv7G2r2+/l5P+iekFhbVM44
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ggLJBwvvy7Eh208xoKdtolYsvRVJR8ikHxkmk7bqq9nbVoDIukjyvCiDKoJM?=
 =?us-ascii?Q?RLsZZnTCjPztyM3iNrD2zIqgZ9u5oauWddtJo6an3NB/QKIk0RQXFPu5KJv4?=
 =?us-ascii?Q?3iueYj4Eov1YpZnZ6cNvvsU8gQuUwI9kFho43PiGT/qxdaRD5OPWulbVm3p/?=
 =?us-ascii?Q?xGZ99W34HmkWg3JTZhOaIOUbLCaUoAyZyxrKG39GHF9ZWDQ7oT9CGAHiAXki?=
 =?us-ascii?Q?sWevt/w8e6zk/JfCf68tRhIGnNRRgzPLDhxS72tDGXq2PjLkFctQGdDjgOTp?=
 =?us-ascii?Q?0aEvS4qXzWoVACVV68UgzEKyetS9AuxYRquOzn7C6mHu+mQ5Vn9G20/SWfH6?=
 =?us-ascii?Q?ElAtdjutEgrclXvfT8SbgqGUba6ul6oqqUGMD6khozO3kR0nAFbP1ycmOg3z?=
 =?us-ascii?Q?6Y/l7mj7MBZSTVY92ZLlmH7rsCVbx2Wg42c3GNDd35N8RvBa1HVuISx31wjW?=
 =?us-ascii?Q?XNFbGZ5xtekseBRNjPoFQFxrHLEVVUadvWL87K750WwjcPwL4FC7JVU6c/Jg?=
 =?us-ascii?Q?5BzXxaYWcEWOoOL9LSnPtommXS/6GI3CoOHMlqSstYZWx6iaOYiOSb8oLo+I?=
 =?us-ascii?Q?wFG7jTe5XszHgHI4c1OV96GjQG+aARafwjVnog68WsKFzj7Xz0sLQj0pauiD?=
 =?us-ascii?Q?O1iu7DmaIaqYUZ5GdaqG7n2sGE9QkOE+SgYzqvkYq4EkRxg9F38+Du4ScAPb?=
 =?us-ascii?Q?21t5O5zjjfN2EDBtLkwxtTG53JXLtgjMtMUgczhyxe//Rcs+9uhHmKaVxNnq?=
 =?us-ascii?Q?FenwovcmmhQrY0RStpsCDmReGejznjkCOBia15qEjIeYVRZoEK2XEhTMGrFa?=
 =?us-ascii?Q?wYYTQ1bOubZZQ2v0lgfgEE0Vb+/KaPnH5IQZbEd46SrN01shCWVB3k3rWJv9?=
 =?us-ascii?Q?pyQAHP/4PVUY2Ivxpa7SXRWlxPEE7l+idrUOOUdvFov54gaV5WJX1HJ3m9E4?=
 =?us-ascii?Q?KGtSqp7C0ydWxWeOAftC12aGliSIZ5LbyBppH/c1M4tNabMIQg/wuClAzjIM?=
 =?us-ascii?Q?BUec4B7Ljl4SC15RndrQhqnn1Q0VDC1BuQFDOkTTD7iUaMroiS6E9Mt/stbc?=
 =?us-ascii?Q?kllYhT0P8GuEp9fiHhrGHedOYL6YI9NaQ+4MAEFFHKu1fTQ7xBKlDNOTne9i?=
 =?us-ascii?Q?JtBJ2PSsh2JStTSYPLZMfItHryZPqRU9t9e3nJ+AWF8cdxjQEqd7JgL5o84S?=
 =?us-ascii?Q?/yvgPoUfZHPI3FjpsFteY4MAM1hzv+z7i91cJtsUKZrC/7k8pVcmng+LPyM?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 337a2f12-2bd4-49cd-8873-08dc29a687ce
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 19:37:19.9209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9317

From: Robin Murphy <robin.murphy@arm.com> Sent: Friday, February 9, 2024 8:=
50 AM
>=20
> The dma_base, size and iommu arguments are only used by ARM, and can
> now easily be deduced from the device itself, so there's no need to pass
> them through the callchain as well.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Make sure the ARM changes actually build (oops...)
> ---
>  arch/arc/mm/dma.c               |  3 +--
>  arch/arm/mm/dma-mapping-nommu.c |  3 +--
>  arch/arm/mm/dma-mapping.c       | 16 +++++++++-------
>  arch/arm64/mm/dma-mapping.c     |  3 +--
>  arch/mips/mm/dma-noncoherent.c  |  3 +--
>  arch/riscv/mm/dma-noncoherent.c |  3 +--
>  drivers/acpi/scan.c             |  7 +------
>  drivers/hv/hv_common.c          |  6 +-----
>  drivers/of/device.c             |  4 +---
>  include/linux/dma-map-ops.h     |  6 ++----
>  10 files changed, 19 insertions(+), 35 deletions(-)
>=20

For the Hyper-V related change in drivers/hv/hv_common.c,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 197707bc7658..6b85e94f3275 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -90,8 +90,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t
> size,
>  /*
>   * Plug in direct dma map ops.
>   */
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			bool coherent)
> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  	/*
>  	 * IOC hardware snoops all DMA traffic keeping the caches consistent
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-
> mapping-nommu.c
> index b94850b57995..97db5397c320 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -33,8 +33,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t
> size,
>  	}
>  }
>=20
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			bool coherent)
> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  	if (IS_ENABLED(CONFIG_CPU_V7M)) {
>  		/*
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f68db05eba29..5adf1769eee4 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1709,11 +1709,15 @@ void arm_iommu_detach_device(struct device
> *dev)
>  }
>  EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
>=20
> -static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base,
> u64 size,
> -				    bool coherent)
> +static void arm_setup_iommu_dma_ops(struct device *dev)
>  {
>  	struct dma_iommu_mapping *mapping;
> +	u64 dma_base =3D 0, size =3D 1ULL << 32;
>=20
> +	if (dev->dma_range_map) {
> +		dma_base =3D dma_range_map_min(dev->dma_range_map);
> +		size =3D dma_range_map_max(dev->dma_range_map) -
> dma_base;
> +	}
>  	mapping =3D arm_iommu_create_mapping(dev->bus, dma_base, size);
>  	if (IS_ERR(mapping)) {
>  		pr_warn("Failed to create %llu-byte IOMMU mapping for
> device %s\n",
> @@ -1744,8 +1748,7 @@ static void
> arm_teardown_iommu_dma_ops(struct device *dev)
>=20
>  #else
>=20
> -static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base,
> u64 size,
> -				    bool coherent)
> +static void arm_setup_iommu_dma_ops(struct device *dev)
>  {
>  }
>=20
> @@ -1753,8 +1756,7 @@ static void
> arm_teardown_iommu_dma_ops(struct device *dev) { }
>=20
>  #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
>=20
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			bool coherent)
> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  	/*
>  	 * Due to legacy code that sets the ->dma_coherent flag from a bus
> @@ -1774,7 +1776,7 @@ void arch_setup_dma_ops(struct device *dev, u64
> dma_base, u64 size,
>  		return;
>=20
>  	if (device_iommu_mapped(dev))
> -		arm_setup_iommu_dma_ops(dev, dma_base, size, coherent);
> +		arm_setup_iommu_dma_ops(dev);
>=20
>  	xen_setup_dma_ops(dev);
>  	dev->archdata.dma_ops_setup =3D true;
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-
> mapping.c
> index 313d8938a2f0..0b320a25a471 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -46,8 +46,7 @@ void arch_teardown_dma_ops(struct device *dev)
>  }
>  #endif
>=20
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			bool coherent)
> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  	int cls =3D cache_line_size_of_cpu();
>=20
> diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-
> noncoherent.c
> index 0f3cec663a12..ab4f2a75a7d0 100644
> --- a/arch/mips/mm/dma-noncoherent.c
> +++ b/arch/mips/mm/dma-noncoherent.c
> @@ -137,8 +137,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr,
> size_t size,
>  #endif
>=20
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -		bool coherent)
> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  	dev->dma_coherent =3D coherent;
>  }
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-
> noncoherent.c
> index 843107f834b2..cb89d7e0ba88 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -128,8 +128,7 @@ void arch_dma_prep_coherent(struct page *page,
> size_t size)
>  	ALT_CMO_OP(FLUSH, flush_addr, size, riscv_cbom_block_size);
>  }
>=20
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			bool coherent)
> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  	WARN_TAINT(!coherent && riscv_cbom_block_size >
> ARCH_DMA_MINALIGN,
>  		   TAINT_CPU_OUT_OF_SPEC,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e6ed1ba91e5c..f5df17d11717 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1640,12 +1640,7 @@ int acpi_dma_configure_id(struct device *dev,
> enum dev_dma_attr attr,
>  	if (ret =3D=3D -EPROBE_DEFER)
>  		return -EPROBE_DEFER;
>=20
> -	/*
> -	 * Historically this routine doesn't fail driver probing due to errors
> -	 * in acpi_iommu_configure_id()
> -	 */
> -
> -	arch_setup_dma_ops(dev, 0, U64_MAX, attr =3D=3D
> DEV_DMA_COHERENT);
> +	arch_setup_dma_ops(dev, attr =3D=3D DEV_DMA_COHERENT);
>=20
>  	return 0;
>  }
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 0285a74363b3..0e2decd1167a 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -484,11 +484,7 @@ EXPORT_SYMBOL_GPL(hv_query_ext_cap);
>=20
>  void hv_setup_dma_ops(struct device *dev, bool coherent)
>  {
> -	/*
> -	 * Hyper-V does not offer a vIOMMU in the guest
> -	 * VM, so pass 0/NULL for the IOMMU settings
> -	 */
> -	arch_setup_dma_ops(dev, 0, 0, coherent);
> +	arch_setup_dma_ops(dev, coherent);
>  }
>  EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>=20
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 9e7963972fa7..312c63361211 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -95,7 +95,6 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
>  {
>  	const struct bus_dma_region *map =3D NULL;
>  	struct device_node *bus_np;
> -	u64 dma_start =3D 0;
>  	u64 mask, end =3D 0;
>  	bool coherent;
>  	int iommu_ret;
> @@ -118,7 +117,6 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
>  			return ret =3D=3D -ENODEV ? 0 : ret;
>  	} else {
>  		/* Determine the overall bounds of all DMA regions */
> -		dma_start =3D dma_range_map_min(map);
>  		end =3D dma_range_map_max(map);
>  	}
>=20
> @@ -175,7 +173,7 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
>  	} else
>  		dev_dbg(dev, "device is behind an iommu\n");
>=20
> -	arch_setup_dma_ops(dev, dma_start, end - dma_start + 1, coherent);
> +	arch_setup_dma_ops(dev, coherent);
>=20
>  	if (iommu_ret)
>  		of_dma_set_restricted_buffer(dev, np);
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 4abc60f04209..ed89e1ce0114 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -426,11 +426,9 @@ bool arch_dma_unmap_sg_direct(struct device
> *dev, struct scatterlist *sg,
>  #endif
>=20
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -		bool coherent);
> +void arch_setup_dma_ops(struct device *dev, bool coherent);
>  #else
> -static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
> -		u64 size, bool coherent)
> +static inline void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  }
>  #endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
> --
> 2.39.2.101.g768bb238c484.dirty
>=20


