Return-Path: <linux-kernel+bounces-154822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 110EA8AE182
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391A1B21AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B85FBAA;
	Tue, 23 Apr 2024 09:59:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E822F11;
	Tue, 23 Apr 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866355; cv=none; b=jUj/gMX2Tnh4kHXMK+D5K/v+x6mcx0tMZtqWl44XC4Bvf6/FI10gHpt6eNlKrw8PZBxAFbjFjkDcvYf4c3jMTLkhBZVOh51phRugEKZ67e9EaAf6J8uACtkM+oMIOdtRbYzxwmVpnCU8UtJcSws56moYpEu4aY6xUyayZklTbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866355; c=relaxed/simple;
	bh=f3b/q4mHBxDMFeTpsNoxGk3SPntu5+fBCf9BQ4gAb9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqP0kg/LrHZWGmt7m9g0xVGj60BiacgVqVubm7NATpsNAMHRBYEF+SvHTelz71ciPP7My1zPD5NHjyrb/7fmjitxefHSBqCXO3d6uslGdZbmpzXg7r1kMGZS+H1jr2NXgtIO1cUMSiGkpQOyu+d7quNyYEZBM8wC4QIMPFtbBFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2E8C116B1;
	Tue, 23 Apr 2024 09:59:08 +0000 (UTC)
Date: Tue, 23 Apr 2024 10:59:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Message-ID: <ZieGah8tnnuEgRhx@arm.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <5291c2326eab405b1aa7693aa964e8d3cb7193de.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5291c2326eab405b1aa7693aa964e8d3cb7193de.1713523152.git.robin.murphy@arm.com>

On Fri, Apr 19, 2024 at 05:54:46PM +0100, Robin Murphy wrote:
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 313d8938a2f0..0b320a25a471 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -46,8 +46,7 @@ void arch_teardown_dma_ops(struct device *dev)
>  }
>  #endif
>  
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> -			bool coherent)
> +void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
>  	int cls = cache_line_size_of_cpu();

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

