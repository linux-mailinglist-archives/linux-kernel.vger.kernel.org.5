Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EAE8085ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjLGKMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjLGJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:56:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 228A4132
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:56:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E31B512FC;
        Thu,  7 Dec 2023 01:56:59 -0800 (PST)
Received: from [10.57.74.174] (unknown [10.57.74.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B579F3F762;
        Thu,  7 Dec 2023 01:56:12 -0800 (PST)
Message-ID: <f1c473f7-ba40-454e-bd3e-a47f6d58513e@arm.com>
Date:   Thu, 7 Dec 2023 09:56:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Set owner token to sva and nested domains
Content-Language: en-GB
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231207021938.306738-1-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231207021938.306738-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-07 2:19 am, Lu Baolu wrote:
> Commit a9c362db3920 ("iommu: Validate that devices match domains") added
> an owner token to an iommu_domain. This token is checked during domain
> attachment to RID or PASID through the generic iommu interfaces.
> 
> The sva and nested domains are attached to device or PASID through the
> generic iommu interfaces. Therefore, they require the owner token to be
> set during allocation. Otherwise, they fail to attach.

Oops, I missed that iommu_sva_domain_alloc() is a thing - when did we 
get such a confusing proliferation of domain allocation paths? Sigh...

I think we should set the owner generically there, since presumably it's 
being missed for SMMUv3/AMD/etc. SVA domains as well. Nested domains are 
supposed to be OK since both ->domain_alloc_user callsites are covered, 
or is there some other sneaky path I've also missed?

Thanks,
Robin.

> Set the owner token for sva and nested domains.
> 
> Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/nested.c | 1 +
>   drivers/iommu/iommu.c        | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index b5a5563ab32c..014d4a4e7586 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -108,6 +108,7 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>   	domain->s1_cfg = vtd;
>   	domain->domain.ops = &intel_nested_domain_ops;
>   	domain->domain.type = IOMMU_DOMAIN_NESTED;
> +	domain->domain.owner = &intel_iommu_ops;
>   	INIT_LIST_HEAD(&domain->devices);
>   	INIT_LIST_HEAD(&domain->dev_pasids);
>   	spin_lock_init(&domain->lock);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0d25468d53a6..d0a28667479a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3617,6 +3617,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   	domain->type = IOMMU_DOMAIN_SVA;
>   	mmgrab(mm);
>   	domain->mm = mm;
> +	domain->owner = ops;
>   	domain->iopf_handler = iommu_sva_handle_iopf;
>   	domain->fault_data = mm;
>   
