Return-Path: <linux-kernel+bounces-93864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F2873601
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959D62869D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7CF7FBD4;
	Wed,  6 Mar 2024 12:02:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0122A78B43;
	Wed,  6 Mar 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726573; cv=none; b=ABDxJ24d7A1zNz2d8RVHP//ydVcsNc2F0BcLeoaAcLoxFHCEha4FTE69Nm+1KvpL8yA+9ibNZAKJd6v6+IUlUcs6qOSC/+t787pgw/JDwFOcENR+74aO3K+Of5k28I2hcUsNlXTo2Rh+53BOtpPfIxrvucydNA9sv82YWVV7GjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726573; c=relaxed/simple;
	bh=yF6gwCEWbGF3pPVi8P+IIvtLpYFThZkXLvepHc0U0MA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XC9ZLbHXV/y+n/oYYkxPNAVYr2VPuPTCYMhwJZbr8a1rsm2Bp83uiuT0dxcLMOxWIxlmqwte8XffIU8Dbhv6in6GtJdHm/BXLy4m0p/GasqYsnhhIvSduPXlfWelQcf/688/Ts+eEwObc93A7HK476pyuJcjNyM7OmsOMTv+XPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552571FB;
	Wed,  6 Mar 2024 04:03:27 -0800 (PST)
Received: from [10.57.67.126] (unknown [10.57.67.126])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AF433F738;
	Wed,  6 Mar 2024 04:02:41 -0800 (PST)
Message-ID: <6af5e7da-08ba-4fc7-8e57-863377182142@arm.com>
Date: Wed, 6 Mar 2024 12:02:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] dma-mapping: Simplify arch_setup_dma_ops()
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <cover.1707493264.git.robin.murphy@arm.com>
In-Reply-To: <cover.1707493264.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joerg, Christoph,

On 2024-02-09 4:49 pm, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1702486837.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Here's v3, rebased and fixing the thinko from v2, so unless anything
> else has changed behind my back I hope it's good to go (via the IOMMU
> tree, as mentioned before).

Are either of you happy to pick this series up now that we have Hanjun's 
acks for the IORT parts? As it stands it still applies cleanly to both 
iommu/next and dma/for-next. I do have some followup IOMMU patches 
prepared already (continuing to delete more code, yay!), but I don't 
want to get too far ahead of myself.

Cheers,
Robin.

> 
> Thanks,
> Robin.
> 
> 
> Robin Murphy (7):
>    OF: Retire dma-ranges mask workaround
>    OF: Simplify DMA range ca1lculations
>    ACPI/IORT: Handle memory address size limits as limits
>    dma-mapping: Add helpers for dma_range_map bounds
>    iommu/dma: Make limit checks self-contained
>    iommu/dma: Centralise iommu_setup_dma_ops()
>    dma-mapping: Simplify arch_setup_dma_ops()
> 
>   arch/arc/mm/dma.c               |  3 +--
>   arch/arm/mm/dma-mapping-nommu.c |  3 +--
>   arch/arm/mm/dma-mapping.c       | 16 +++++++------
>   arch/arm64/mm/dma-mapping.c     |  5 +---
>   arch/loongarch/kernel/dma.c     |  9 ++-----
>   arch/mips/mm/dma-noncoherent.c  |  3 +--
>   arch/riscv/mm/dma-noncoherent.c |  3 +--
>   drivers/acpi/arm64/dma.c        | 17 ++++---------
>   drivers/acpi/arm64/iort.c       | 20 ++++++++--------
>   drivers/acpi/scan.c             |  7 +-----
>   drivers/hv/hv_common.c          |  6 +----
>   drivers/iommu/amd/iommu.c       |  8 -------
>   drivers/iommu/dma-iommu.c       | 39 ++++++++++++------------------
>   drivers/iommu/dma-iommu.h       | 14 +++++------
>   drivers/iommu/intel/iommu.c     |  7 ------
>   drivers/iommu/iommu.c           | 20 ++++++----------
>   drivers/iommu/s390-iommu.c      |  6 -----
>   drivers/iommu/virtio-iommu.c    | 10 --------
>   drivers/of/device.c             | 42 ++++++---------------------------
>   include/linux/acpi_iort.h       |  4 ++--
>   include/linux/dma-direct.h      | 18 ++++++++++++++
>   include/linux/dma-map-ops.h     |  6 ++---
>   include/linux/iommu.h           |  7 ------
>   23 files changed, 89 insertions(+), 184 deletions(-)
> 

