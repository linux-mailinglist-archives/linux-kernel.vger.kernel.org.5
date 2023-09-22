Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B157AB36F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjIVOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjIVOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:21:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D24AAB;
        Fri, 22 Sep 2023 07:21:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D47BCDA7;
        Fri, 22 Sep 2023 07:22:00 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EE4D3F67D;
        Fri, 22 Sep 2023 07:21:22 -0700 (PDT)
Message-ID: <2ea199a1-d20d-2fde-d1bd-76ecad14a68d@arm.com>
Date:   Fri, 22 Sep 2023 15:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH REGRESSION] iommu: Only allocate FQ domains for IOMMUs
 that support them
Content-Language: en-GB
To:     Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, stable@vger.kernel.org,
        regressions@lists.linux.dev
References: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 2:40 pm, Hector Martin wrote:
> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
> introduced in iommu_dma_init_domain() to fall back if not supported, but
> this check runs too late: by that point, devices have been attached to
> the IOMMU, and the IOMMU driver might not expect FQ domains at
> ops->attach_dev() time.
> 
> Ensure that we immediately clamp FQ domains to plain DMA if not
> supported by the driver at device attach time, not later.
> 
> This regressed apple-dart in v6.5.

Apologies, I missed that apple-dart was doing something unusual here. 
However, could we just fix that directly instead?

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 2082081402d3..0b8927508427 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain 
*domain,
  		return ret;

  	switch (domain->type) {
-	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_UNMANAGED:
+	default:
  		ret = apple_dart_domain_add_streams(dart_domain, cfg);
  		if (ret)
  			return ret;


That's pretty much where we're headed with the domain_alloc_paging 
redesign anyway - at the driver level, operations on a paging domain 
should not need to know about the higher-level usage intent of that 
domain. Ideally, blocking and identity domains should have their own 
distinct ops now as well, but that might be a bit too big a change for 
an immediate fix here.

Thanks,
Robin.

> 
> Cc: regressions@lists.linux.dev
> Cc: stable@vger.kernel.org
> Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/iommu/iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3bfc56df4f78..12464eaa8d91 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2039,6 +2039,15 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   	if (unlikely(domain->ops->attach_dev == NULL))
>   		return -ENODEV;
>   
> +	/*
> +	 * Ensure we do not try to attach devices to FQ domains if the
> +	 * IOMMU does not support them. We can safely fall back to
> +	 * non-FQ.
> +	 */
> +	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
> +	    !device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH))
> +		domain->type = IOMMU_DOMAIN_DMA;
> +
>   	ret = domain->ops->attach_dev(domain, dev);
>   	if (ret)
>   		return ret;
> 
> ---
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> change-id: 20230922-iommu-type-regression-25b4f43df770
> 
> Best regards,
