Return-Path: <linux-kernel+bounces-118322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C088B803
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C9E1C3521D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270F128814;
	Tue, 26 Mar 2024 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SIr5uZ16"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA328EA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422567; cv=none; b=BnSYYatEYTF+g08NDcbGWtuaYLEkE+BjwQpCq6nyaUIsZcvrM0HY3hAYZYupQJ/m+DMo/JABgICC8xvQN9TwiG6FLhZpFJgYYKKNATLs0zfsexWrRQElDBlOYe2bOEkulb9wInpa3V98mQ8rLOS/xCrD2wxGPXLbcE4EqEqvb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422567; c=relaxed/simple;
	bh=NdC+FWDPDP18jvWCn2+cfisvoLxcARg0puIr7yAJ5Lo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP3gIfsm1EE6C9dIeYUuhgp1DlrArqHnyjNSKFk05FSclVoZdwHs+A1UaLlpg+tMUWEVQMugA+lUkudnDN5wHp4r6vNlsa7Uafff6/UFEXaN5mAsaS70NMnD36bgXYEgOaII8vdFQzW4To/KLJn4/Ka279sv+joMMDWUju2BHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SIr5uZ16; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q2O692018472;
	Mon, 25 Mar 2024 20:08:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=VT2SPnx1HUhMwAnAmLKupb
	c4KDgy06WgoWy6Y66J9Fk=; b=SIr5uZ168nphjEutZJsSlQd0AktWHVGnLmRDiK
	Bmlnl0biJ7N3d17yIDA2sJ1i9ETy7VUSROpMOcSf5ainuQ3aXs8GHRg1Yrn1h0+K
	ZqKX8t6/7khqFATxuk2uWr84QuPu+6C08OiO7EblkAoDAoRCcPIHW7+JjBf6kj/Q
	L44FW9cSVYNDWi1HjY/53D81416Q9JnZ8t7Mq0ts8aYs8aOjh39xvJiOFRQsl/OK
	XDx5l26UStqhDvS2fgjZ/x5JEV+Ye392N6IREJFX0CiqSkuEnwZS0h4SDkqu9s7D
	hn4i7qinI4GCccayFP7ZM+ZJGqPgepJrCa+lvTEBJyJF7tJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x3nht8460-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:08:56 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 42Q2wV69031074;
	Mon, 25 Mar 2024 20:08:56 -0700
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x3nht845v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:08:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 25 Mar 2024 20:08:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 25 Mar 2024 20:08:55 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 268E33F704D;
	Mon, 25 Mar 2024 20:08:51 -0700 (PDT)
Date: Tue, 26 Mar 2024 08:38:51 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
CC: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS"
	<iommu@lists.linux.dev>,
        Will Deacon <will@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr
 Tesarik <petr@tesarici.cz>
Subject: Re: [PATCH 1/1] swiotlb: add a KUnit test suite
Message-ID: <20240326030851.GA64024@hyd1403.caveonetworks.com>
References: <20240313092740.192-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313092740.192-1-petrtesarik@huaweicloud.com>
X-Proofpoint-GUID: 1K8lZCqhMEw0dhK2t8aVjwvSkr3G7LhF
X-Proofpoint-ORIG-GUID: dBp2EdjjRykq1ugCvQk9Dgdkldo2Cd6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_26,2024-03-21_02,2023-05-22_02

On 2024-03-13 at 14:57:40, Petr Tesarik (petrtesarik@huaweicloud.com) wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Hi,

> 
> Add unit tests to help avoid regressions in the SWIOTLB code.
> 
> These features are covered by the test suite:
> 
> * basic functionality (map, sync)
> * alignment based on mapping size
> * alignment based on min_align_mask
> * explicit alignment with alloc_align_mask
> * combination of alignment constraints
> 
> Select CONFIG_SWIOTLB rather than depend on it, because it allows to run
> the test with UML (default KUnit target).
> 
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  kernel/dma/Kconfig        |  13 ++
>  kernel/dma/Makefile       |   1 +
>  kernel/dma/swiotlb_test.c | 413 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 427 insertions(+)
>  create mode 100644 kernel/dma/swiotlb_test.c
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index d62f5957f36b..44c62faa8d89 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -103,6 +103,19 @@ config SWIOTLB_DYNAMIC
>  
>  	  If unsure, say N.
>  
> +config SWIOTLB_KUNIT_TEST
> +	tristate "Unit tests for software IO TLB" if !KUNIT_ALL_TESTS
> +	select SWIOTLB
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Build unit tests for software IO TLB.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config DMA_BOUNCE_UNALIGNED_KMALLOC
>  	bool
>  	depends on SWIOTLB
> diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> index 21926e46ef4f..bfb130020219 100644
> --- a/kernel/dma/Makefile
> +++ b/kernel/dma/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_DMA_CMA)			+= contiguous.o
>  obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
>  obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
>  obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
> +obj-$(CONFIG_SWIOTLB_KUNIT_TEST)	+= swiotlb_test.o
>  obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
>  obj-$(CONFIG_MMU)			+= remap.o
>  obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
> diff --git a/kernel/dma/swiotlb_test.c b/kernel/dma/swiotlb_test.c
> new file mode 100644
> index 000000000000..46e4d8055ef5
> --- /dev/null
> +++ b/kernel/dma/swiotlb_test.c
> @@ -0,0 +1,413 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
> + */
> +
> +#include <kunit/test.h>
> +#include <kunit/device.h>
> +
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/kdev_t.h>
> +#include <linux/swiotlb.h>
> +
> +/* Alignment check repeat count. */
> +#define NUM_CHECK_ALIGNED	5
> +
> +/* Offset of mapped data inside the allocated buffer. */
> +#define MAP_OFF	128
> +
> +#define PASS	0x600d600d
> +#define FAIL	0xbad00bad
> +
> +static struct {
> +	unsigned char pad1[MAP_OFF];
> +	unsigned long value;
> +	unsigned char pad2[PAGE_SIZE];
> +} test_data __page_aligned_bss;
> +
> +/**************************************************************
> + * Various helper functions.
> + */
> +
> +static int swiotlb_suite_init(struct kunit_suite *suite)
> +{
> +	if (is_swiotlb_allocated())
> +		return 0;
> +
> +	return swiotlb_init_late(swiotlb_size_or_default(), GFP_KERNEL, NULL);
> +}
> +
> +static int swiotlb_drv_probe(struct device *dev)
> +{
> +	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
> +				      GFP_KERNEL);
> +	if (!dev->dma_parms)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static int swiotlb_test_init(struct kunit *test)
> +{
> +	struct device_driver *driver;
> +
> +	driver = kunit_driver_create(test, "swiotlb_driver");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, driver);
> +	driver->probe = swiotlb_drv_probe;
> +
> +	test->priv = driver;
> +	return 0;
> +}
> +
> +/**
> + * test_device() - get a dummy device for testing
> + * @test:  KUnit test instance.
> + *
> + * Allocate a device suitable for SWIOTLB.
> + */
> +static struct device *test_device(struct kunit *test)
> +{
> +	struct device_driver *driver = test->priv;
> +	struct device *dev;
> +	u64 mask;
> +
> +	dev = kunit_device_register_with_driver(test, "swiotlb", driver);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	mask = DMA_BIT_MASK(64);
> +	KUNIT_ASSERT_EQ(test, dma_coerce_mask_and_coherent(dev, mask), 0);
> +
> +	return dev;
> +}
> +
> +/**
> + * check_aligned() - check that bounce buffers are aligned
> + * @test:   KUnit test instance.
> + * @dev:    Device.
> + * @buf:    Pointer to the original buffer.
> + * @size:   Size of the original buffer.
> + * @align:  Allocation alignment (in bytes).
> + * @check_bits:
> + *          Number of low bits checked in the swiotlb address.
> + * @preserve_bits:
> + *          Number of low bits preserved from the original address.
> + *
> + * Mapping is repeated a few times, and a small buffer is allocated after
> + * each attempt. This should cover the case when the first free slot merely
> + * happens to be suitably aligned.
> + */
> +static void check_aligned(struct kunit *test, struct device *dev,
> +			  void *buf, size_t size, unsigned long align,
> +			  int check_bits, int preserve_bits)
> +{
> +	dma_addr_t tlb_addr[NUM_CHECK_ALIGNED];
> +	dma_addr_t pad_addr[NUM_CHECK_ALIGNED];
> +	u64 check_mask, check_val;
> +	phys_addr_t phys_addr;
> +	char *orig, *tlb;
> +	int i;
> +
> +	orig = (char *)buf;
> +	phys_addr = virt_to_phys(buf);
> +	check_mask = DMA_BIT_MASK(check_bits);
> +	check_val = phys_addr & DMA_BIT_MASK(preserve_bits);
> +
> +	for (i = 0; i < NUM_CHECK_ALIGNED; ++i) {
> +		tlb_addr[i] =
> +			swiotlb_tbl_map_single(dev, phys_addr, size, size,
> +					       align - 1, DMA_TO_DEVICE, 0);
> +		KUNIT_ASSERT_NE(test, tlb_addr[i], DMA_MAPPING_ERROR);
> +		KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr[i]));
> +		KUNIT_EXPECT_EQ(test, tlb_addr[i] & check_mask, check_val);
> +
> +		/* Check sync in both directions. */
> +		tlb = phys_to_virt(tlb_addr[i]);
> +		KUNIT_EXPECT_EQ(test, *orig, *tlb);
> +		*orig ^= 0xff;
> +		swiotlb_sync_single_for_device(dev, tlb_addr[i], sizeof(*orig),
> +					       DMA_TO_DEVICE);
> +		KUNIT_EXPECT_EQ(test, *orig, *tlb);
> +		*tlb ^= 0xff;
> +		swiotlb_sync_single_for_cpu(dev, tlb_addr[i], sizeof(*orig),
> +					    DMA_FROM_DEVICE);
> +		KUNIT_EXPECT_EQ(test, *orig, *tlb);
> +
> +		pad_addr[i] = swiotlb_map(dev, phys_addr, sizeof(long),
> +					  DMA_TO_DEVICE, 0);
> +		KUNIT_ASSERT_NE(test, pad_addr[i], DMA_MAPPING_ERROR);
> +	}
> +
> +	for (i = 0; i < NUM_CHECK_ALIGNED; ++i) {
> +		swiotlb_tbl_unmap_single(dev, pad_addr[i], sizeof(long),
> +					 DMA_FROM_DEVICE, 0);
> +		swiotlb_tbl_unmap_single(dev, tlb_addr[i], size,
> +					 DMA_FROM_DEVICE, 0);
> +	}
> +}
> +
> +/**************************************************************
> + * Map a DMA buffer.
> + *
> + * Test that a DMA buffer can be mapped and synced.
> + */
> +
> +static void swiotlb_test_map(struct kunit *test)
> +{
> +	struct device *dev = test_device(test);
> +	phys_addr_t phys_addr;
> +	dma_addr_t tlb_addr;
> +	unsigned long *tlb;
> +
> +	phys_addr = virt_to_phys(&test_data.value);
> +	test_data.value = PASS;
> +	tlb_addr = swiotlb_map(dev, phys_addr, sizeof(unsigned long),
> +			       DMA_TO_DEVICE, 0);
> +	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
> +	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
> +	tlb = phys_to_virt(tlb_addr);
> +
> +	/* Bounce buffer is initialized to original buffer. */
> +	KUNIT_EXPECT_EQ(test, *tlb, PASS);
> +
> +	/* Bounce buffer is updated on sync to device. */
> +	test_data.value = PASS + 1;
> +	swiotlb_sync_single_for_device(dev, tlb_addr, sizeof(unsigned long),
> +				       DMA_TO_DEVICE);
> +	KUNIT_EXPECT_EQ(test, *tlb, PASS + 1);
> +
> +	/* Original buffer is updated on sync from device. */
> +	*tlb = PASS + 2;
> +	swiotlb_sync_single_for_cpu(dev, tlb_addr, sizeof(unsigned long),
> +				    DMA_FROM_DEVICE);
> +	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 2);

Should we not try this on a buffer that is mapped with DMA_FROM_DEVICE ?

> +
> +	/* Original buffer is also updated on unmap. */
> +	*tlb = PASS + 3;
> +	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned long),
> +				 DMA_FROM_DEVICE, 0);
> +	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 3);
> +}
> +
> +/**************************************************************
> + * Map DMA buffer as bi-directional.
> + *
> + * Test that buffer is synced with DMA_BIDIRECTIONAL.
> + */
> +
> +static void swiotlb_test_bidirectional(struct kunit *test)
> +{
> +	struct device *dev = test_device(test);
> +	phys_addr_t phys_addr;
> +	dma_addr_t tlb_addr;
> +	unsigned long *tlb;
> +
> +	test_data.value = PASS;
> +	phys_addr = virt_to_phys(&test_data.value);
> +	tlb_addr = swiotlb_map(dev, phys_addr, sizeof(unsigned long),
> +			       DMA_BIDIRECTIONAL, 0);
> +	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
> +	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
> +	tlb = phys_to_virt(tlb_addr);
> +
> +	/* Bounce buffer is initialized to original buffer. */
> +	KUNIT_EXPECT_EQ(test, *tlb, PASS);
> +
> +	/* Original buffer is updated on unmap. */
> +	*tlb = PASS + 1;
> +	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned long),
> +				 DMA_BIDIRECTIONAL, 0);
> +	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 1);
> +}
> +
> +/**************************************************************
> + * Skip sync on unmap.
> + *
> + * Test that sync does not happen with DMA_ATTR_SKIP_CPU_SYNC.
> + * On swiotlb_map(), this flag skips only sync for non-coherent
> + * DMA; the bounce buffer itself is always synced to the
> + * original buffer.
> + */
> +
> +static void swiotlb_test_skip_sync(struct kunit *test)
> +{
> +	struct device *dev = test_device(test);
> +	phys_addr_t phys_addr;
> +	dma_addr_t tlb_addr;
> +	unsigned long *tlb;
> +
> +	test_data.value = PASS;
> +	phys_addr = virt_to_phys(&test_data.value);
> +	tlb_addr = swiotlb_map(dev, phys_addr, sizeof(unsigned long),
> +			       DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
> +	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
> +	tlb = phys_to_virt(tlb_addr);
> +
> +	/* Bounce buffer is initialized to original buffer anyway. */
> +	KUNIT_EXPECT_EQ(test, *tlb, PASS);
> +
> +	/* Original buffer is not updated on unmap. */
> +	*tlb = FAIL;
> +	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned long),
> +				 DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +	KUNIT_EXPECT_EQ(test, test_data.value, PASS);
> +}
> +
> +/**************************************************************
> + * Historical page alignment.
> + *
> + * Test that mappings of at least PAGE_SIZE get a page-aligned
> + * DMA address.
> + */
> +
> +static void swiotlb_test_page_align(struct kunit *test)
> +{
> +	struct device *dev = test_device(test);
> +
> +	/* Bounce buffer is page-aligned. */
> +	check_aligned(test, dev, &test_data, sizeof(test_data), 1,
> +		      PAGE_SHIFT, 0);
> +
> +	/* Even if the original buffer is not page-aligned. */
> +	check_aligned(test, dev, &test_data.value, PAGE_SIZE, 1,
> +		      PAGE_SHIFT, 0);
> +}
> +
> +/**************************************************************
> + * Device physical address alignment.
> + *
> + * Test that physical address low bits are preserved.
> + */
> +
> +static void check_min_align(struct kunit *test, int bits)
> +{
> +	u64 min_align_mask = DMA_BIT_MASK(bits);
> +	struct device *dev = test_device(test);
> +	unsigned long vaddr;
> +	void *ptr;
> +
> +	KUNIT_ASSERT_EQ(test, dma_set_min_align_mask(dev, min_align_mask), 0);
> +
> +	vaddr = devm_get_free_pages(dev, GFP_KERNEL,
> +				    bits > PAGE_SHIFT ? bits - PAGE_SHIFT : 0);
> +	KUNIT_ASSERT_NE(test, vaddr, 0);
> +
> +	/* Check low bits */
> +	ptr = (void *)vaddr + MAP_OFF;
> +	check_aligned(test, dev, ptr, sizeof(long), 1, bits, bits);
> +
> +	/* Check high bits */
> +	ptr = (void *)vaddr + (1UL << bits) - MAP_OFF - sizeof(long);
> +	check_aligned(test, dev, ptr, sizeof(long), 1, bits, bits);
> +
> +	kunit_device_unregister(test, dev);
> +}
> +
> +static void swiotlb_test_min_align(struct kunit *test)
> +{
> +	check_min_align(test, 12);
> +	check_min_align(test, PAGE_SHIFT);
> +	check_min_align(test, 16);
> +}
> +
> +/**************************************************************
> + * Explicit allocation alignment.
> + *
> + * Test that the bounce buffer is aligned to an explicit value
> + * regardless of allocation size.
> + */
> +
> +static void check_alloc_align(struct kunit *test, int bits)
> +{
> +	struct device *dev = test_device(test);
> +	void *base, *ptr;
> +	size_t size;
> +
> +	size = 1UL << bits;
> +	base = devm_kmalloc(dev, size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base);
> +
> +	/* Check low bits */
> +	ptr = base + MAP_OFF;
> +	check_aligned(test, dev, ptr, sizeof(long), size, bits, 0);
> +
> +	/* Check high bits */
> +	ptr = base + size - MAP_OFF - sizeof(long);
> +	check_aligned(test, dev, ptr, sizeof(long), size, bits, 0);
> +
> +	kunit_device_unregister(test, dev);
> +}
> +
> +static void swiotlb_test_alloc_align(struct kunit *test)
> +{
> +	check_alloc_align(test, 12);
> +	check_alloc_align(test, 14);
> +}
> +
> +/**************************************************************
> + * Both allocation and device physical address alignment.
> + *
> + * Test that the bounce buffer is aligned to an explicit value
> + * regardless of allocation size and it also preserves physical
> + * address low bits.
> + */
> +
> +static void check_both_align(struct kunit *test, int min_align_bits,
> +			     int alloc_align_bits)
> +{
> +	u64 min_align_mask = DMA_BIT_MASK(min_align_bits);
> +	struct device *dev = test_device(test);
> +	void *base, *ptr;
> +	size_t size;
> +
> +	KUNIT_ASSERT_EQ(test, dma_set_min_align_mask(dev, min_align_mask), 0);
> +
> +	size = 1UL << max(min_align_bits, alloc_align_bits);
> +	base = devm_kmalloc(dev, size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base);
> +
> +	/* Check low bits */
> +	ptr = base + MAP_OFF;
> +	check_aligned(test, dev, ptr, sizeof(long), size,
> +		      min_align_bits, min_align_bits);
> +
> +	/* Check high bits */
> +	ptr = base + size - MAP_OFF - sizeof(long);
> +	check_aligned(test, dev, ptr, sizeof(long), size,
> +		      min_align_bits, min_align_bits);
> +
> +	kunit_device_unregister(test, dev);
> +}
> +
> +static void swiotlb_test_both_align(struct kunit *test)
> +{
> +	check_both_align(test, 12, 12);
> +	check_both_align(test, 12, 16);
> +	check_both_align(test, 14, 16);
> +}
> +
> +/**************************************************************
> + * Test suite metadata.
> + */
> +
> +static struct kunit_case swiotlb_test_cases[] = {
> +	KUNIT_CASE(swiotlb_test_map),
> +	KUNIT_CASE(swiotlb_test_bidirectional),

For better coverage, can we keep seperate tests for each direction ?
May be we could have a common function that takes direction as an
argument.

> +	KUNIT_CASE(swiotlb_test_skip_sync),
> +	KUNIT_CASE(swiotlb_test_page_align),
> +	KUNIT_CASE(swiotlb_test_min_align),
> +	KUNIT_CASE(swiotlb_test_alloc_align),
> +	KUNIT_CASE(swiotlb_test_both_align),
> +	{}
> +};
> +
> +static struct kunit_suite swiotlb_test_suite = {
> +	.name = "swiotlb",
> +	.suite_init = swiotlb_suite_init,
> +	.init = swiotlb_test_init,
> +	.test_cases = swiotlb_test_cases,
> +};
> +
> +kunit_test_suites(&swiotlb_test_suite);
> -- 
> 2.34.1
> 

