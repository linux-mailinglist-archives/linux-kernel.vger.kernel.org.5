Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88553774FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjHIAVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHIAVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:21:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B0810C8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691540502; x=1723076502;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pSnxsYD5ez1ZILtbpLadGfYWDNm7OAnwV//2jsi3Zmw=;
  b=izWykr7MiIfXul5opU/kHyfVXL8KVKOAC6xQA26BwOqzFYc33CsoLDTZ
   3bpsyp2mpRSVu+g7+5Dlnd9ixN9BylLYckKMsBaV1yCwYbJYq+/VjWMXB
   yHXlzH0cU6hYmxCmei3KkNAUJk/iWHmE+KiJmaj0Cy4I3MNcY1XRLARuK
   VwvC5JZNZkWROdm5U6j5K/lbGh9RFrw4mF/DzdqFY8HWyce+8HDJ/+HDD
   UHhWLNzfYcKrzZdeGOSleL6R4gsRiuQsWFk3l9JBpLa0jkC3Fk5wRX2W0
   yBD521ASGutoXrdZyFXSKog3zSnUQ4VGknMDBWSRqTOnPyzT/uqtP8Aa8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457366963"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="457366963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708496406"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="708496406"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.46]) ([10.249.169.46])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:21:40 -0700
Message-ID: <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
Date:   Wed, 9 Aug 2023 08:21:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230808074944.7825-3-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 15:49, Tina Zhang wrote:
> Use the helper function mm_get_pasid() to get the mm assigned pasid
> value.

For internal iommu drivers, perhaps we should use another helper.
Something like sva_domain_get_pasid()?

Suppose that the iommu drivers should have no idea about the "mm".

Best regards,
baolu

> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
>   drivers/iommu/intel/svm.c                       |  8 ++++----
>   drivers/iommu/iommu-sva.c                       | 14 +++++++-------
>   3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index a5a63b1c947e..0b455654d365 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -204,7 +204,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>   	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
>   		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
>   					    PAGE_SIZE, false, smmu_domain);
> -	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
> +	arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), start, size);
>   }
>   
>   static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> @@ -222,10 +222,10 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
>   	 * but disable translation.
>   	 */
> -	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
> +	arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), &quiet_cd);
>   
>   	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> -	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
> +	arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), 0, 0);
>   
>   	smmu_mn->cleared = true;
>   	mutex_unlock(&sva_lock);
> @@ -279,7 +279,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>   		goto err_free_cd;
>   	}
>   
> -	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> +	ret = arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), cd);
>   	if (ret)
>   		goto err_put_notifier;
>   
> @@ -304,7 +304,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
>   		return;
>   
>   	list_del(&smmu_mn->list);
> -	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
> +	arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), NULL);
>   
>   	/*
>   	 * If we went through clear(), we've already invalidated, and no
> @@ -312,7 +312,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
>   	 */
>   	if (!smmu_mn->cleared) {
>   		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
> -		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
> +		arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), 0, 0);
>   	}
>   
>   	/* Frees smmu_mn */
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index e95b339e9cdc..e6377cff6a93 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -306,13 +306,13 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
>   	unsigned long sflags;
>   	int ret = 0;
>   
> -	svm = pasid_private_find(mm->pasid);
> +	svm = pasid_private_find(mm_get_pasid(mm));
>   	if (!svm) {
>   		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
>   		if (!svm)
>   			return -ENOMEM;
>   
> -		svm->pasid = mm->pasid;
> +		svm->pasid = mm_get_pasid(mm);
>   		svm->mm = mm;
>   		INIT_LIST_HEAD_RCU(&svm->devs);
>   
> @@ -350,7 +350,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
>   
>   	/* Setup the pasid table: */
>   	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
> -	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
> +	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm_get_pasid(mm),
>   					    FLPT_DEFAULT_DID, sflags);
>   	if (ret)
>   		goto free_sdev;
> @@ -364,7 +364,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
>   free_svm:
>   	if (list_empty(&svm->devs)) {
>   		mmu_notifier_unregister(&svm->notifier, mm);
> -		pasid_private_remove(mm->pasid);
> +		pasid_private_remove(mm_get_pasid(mm));
>   		kfree(svm);
>   	}
>   
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 05c0fb2acbc4..0a4a1ed40814 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -28,7 +28,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>   	mutex_lock(&iommu_sva_lock);
>   	/* Is a PASID already associated with this mm? */
>   	if (mm_valid_pasid(mm)) {
> -		if (mm->pasid < min || mm->pasid > max)
> +		if (mm_get_pasid(mm) < min || mm_get_pasid(mm) > max)
>   			ret = -EOVERFLOW;
>   		goto out;
>   	}
> @@ -71,7 +71,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	if (!max_pasids)
>   		return ERR_PTR(-EOPNOTSUPP);
>   
> -	/* Allocate mm->pasid if necessary. */
> +	/* Allocate pasid if necessary. */
>   	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
>   	if (ret)
>   		return ERR_PTR(ret);
> @@ -82,7 +82,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   
>   	mutex_lock(&iommu_sva_lock);
>   	/* Search for an existing domain. */
> -	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
>   						IOMMU_DOMAIN_SVA);
>   	if (IS_ERR(domain)) {
>   		ret = PTR_ERR(domain);
> @@ -101,7 +101,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   		goto out_unlock;
>   	}
>   
> -	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
>   	if (ret)
>   		goto out_free_domain;
>   	domain->users = 1;
> @@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
>   void iommu_sva_unbind_device(struct iommu_sva *handle)
>   {
>   	struct iommu_domain *domain = handle->domain;
> -	ioasid_t pasid = domain->mm->pasid;
> +	ioasid_t pasid = mm_get_pasid(domain->mm);
>   	struct device *dev = handle->dev;
>   
>   	mutex_lock(&iommu_sva_lock);
> @@ -150,7 +150,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   {
>   	struct iommu_domain *domain = handle->domain;
>   
> -	return domain->mm->pasid;
> +	return mm_get_pasid(domain->mm);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
>   
> @@ -217,5 +217,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>   	if (likely(!mm_valid_pasid(mm)))
>   		return;
>   
> -	ida_free(&iommu_global_pasid_ida, mm->pasid);
> +	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
>   }

