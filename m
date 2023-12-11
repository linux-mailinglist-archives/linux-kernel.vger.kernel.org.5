Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0080CAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbjLKN2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:28:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEEA9A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:28:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D407C433C9;
        Mon, 11 Dec 2023 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702301287;
        bh=Uh28siBgKPrRx4R97NHRHFSutMUu3voxmGrI4tHwqJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAu0byBI6RS1NorYku2b05EMpa2te/9yWVIdkVVhc3v0B2IUobjYl5G4y/bzWa9pJ
         JjIUc0L5jQy3+vJf3iSPZ9w7NHWJVeveZ8Hwjs82eBFchAAU/z+AI2ET4sBi5zgaos
         Y0BeQpqkgtzEVa5x6sxs4Sp3r9IZJ5Rm+nk8ZGcx906z+EgRGwrnEybDL8FBes+JOD
         A3vFUH1fc1/B2QPP2C8HpmJtX19M50Ti3rcMizOlJoN3msljQPC6btRRBnBhEx7nid
         Mv90l0Dd4s6KBcpO77xaQlgW6DEuntN8+hgoFozymI86YA8qy5G89c76Za3gkok+AX
         LP/+5T3W8DdeA==
Date:   Mon, 11 Dec 2023 13:27:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Message-ID: <20231211132757.GE25681@willie-the-truck>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
> Return the Root Complex/Named Component memory address size limit as an
> inclusive limit value, rather than an exclusive size.  This saves us
> having to special-case 64-bit overflow, and simplifies our caller too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/dma.c  |  9 +++------
>  drivers/acpi/arm64/iort.c | 18 ++++++++----------
>  include/linux/acpi_iort.h |  4 ++--
>  3 files changed, 13 insertions(+), 18 deletions(-)

[...]

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 6496ff5a6ba2..eb64d8e17dd1 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1367,7 +1367,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
>  #endif
>  
> -static int nc_dma_get_range(struct device *dev, u64 *size)
> +static int nc_dma_get_range(struct device *dev, u64 *limit)
>  {
>  	struct acpi_iort_node *node;
>  	struct acpi_iort_named_component *ncomp;
> @@ -1384,13 +1384,12 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
>  		return -EINVAL;
>  	}
>  
> -	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
> -			1ULL<<ncomp->memory_address_limit;
> +	*limit = (1ULL << ncomp->memory_address_limit) - 1;

The old code handled 'ncomp->memory_address_limit >= 64' -- why is it safe
to drop that? You mention it in the cover letter, so clearly I'm missing
something!

>  
>  	return 0;
>  }
>  
> -static int rc_dma_get_range(struct device *dev, u64 *size)
> +static int rc_dma_get_range(struct device *dev, u64 *limit)
>  {
>  	struct acpi_iort_node *node;
>  	struct acpi_iort_root_complex *rc;
> @@ -1408,8 +1407,7 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
>  		return -EINVAL;
>  	}
>  
> -	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> -			1ULL<<rc->memory_address_limit;
> +	*limit = (1ULL << rc->memory_address_limit) - 1;

Same thing here.

Will
