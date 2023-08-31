Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1778E595
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbjHaFOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHaFOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:14:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3841D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693458869; x=1724994869;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x63OFnkgYBO4J0C1Iau8KdwgfiuUJOj5wLWGv3sCQFU=;
  b=KGc/iBZ73qJswurDp+K1CNSxU9iblMJjGHb8sV10sheqTeeu4sEI8d1D
   9wSdzzM2BcMeXmz/TwasoKk4Zyph9Ks8Nkp4xCFmOLwMzkc3V4SRye3Pr
   d25aEO3W5B/O8TPkjy9cpR87h/TovnCM1OTjsTPwIT7d6Wh7bO2zA/sre
   FAk9cjQpYOYN3kj9kqMK/sKEcqUehM5jR/FIJnQVyGcTTXibxEitAsCsq
   pZJoAYkfwHgXjoTaQxUu55UEN4zxMMID2SaYphqM81fX1Bs1EZVL4jn8f
   oAD3H+3gPqL4v75wOpp7JSYrN/A/f75o7JgPHA3iIy3FjfKrYjRuOV8dn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439766782"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="439766782"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 22:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689176464"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="689176464"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 22:14:25 -0700
Message-ID: <7000c8d5-6989-0329-05ad-b96ed68631c0@linux.intel.com>
Date:   Thu, 31 Aug 2023 13:14:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iommu: Introduce mm_get_pasid() helper function
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-3-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-3-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/27 16:43, Tina Zhang wrote:
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index e95b339e9cdc0..e6377cff6a935 100644
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

There is no need to use mm_get_pasid(mm) in the set_dev_pasid path. The
pasid has already passed as a parameter. Perhaps, pass domain and pasid
to intel_svm_bind_mm(), or simply merge intel_svm_bind_mm() to
intel_svm_set_dev_pasid()?

Something like below?

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8f6d68006ab6..de490b3409cc 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -298,21 +298,22 @@ static int pasid_to_svm_sdev(struct device *dev, 
unsigned int pasid,
  }

  static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device 
*dev,
-			     struct mm_struct *mm)
+			     struct iommu_domain *domain, ioasid_t pasid)
  {
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct mm_struct *mm = domain->mm;
  	struct intel_svm_dev *sdev;
  	struct intel_svm *svm;
  	unsigned long sflags;
  	int ret = 0;

-	svm = pasid_private_find(mm->pasid);
+	svm = pasid_private_find(pasid);
  	if (!svm) {
  		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
  		if (!svm)
  			return -ENOMEM;

-		svm->pasid = mm->pasid;
+		svm->pasid = pasid;
  		svm->mm = mm;
  		INIT_LIST_HEAD_RCU(&svm->devs);

@@ -350,7 +351,7 @@ static int intel_svm_bind_mm(struct intel_iommu 
*iommu, struct device *dev,

  	/* Setup the pasid table: */
  	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
+	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
  					    FLPT_DEFAULT_DID, sflags);
  	if (ret)
  		goto free_sdev;
@@ -364,7 +365,7 @@ static int intel_svm_bind_mm(struct intel_iommu 
*iommu, struct device *dev,
  free_svm:
  	if (list_empty(&svm->devs)) {
  		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(mm->pasid);
+		pasid_private_remove(pasid);
  		kfree(svm);
  	}

@@ -839,11 +840,10 @@ static int intel_svm_set_dev_pasid(struct 
iommu_domain *domain,
  {
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
  	struct intel_iommu *iommu = info->iommu;
-	struct mm_struct *mm = domain->mm;
  	int ret;

  	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(iommu, dev, mm);
+	ret = intel_svm_bind_mm(iommu, dev, domain, pasid);
  	mutex_unlock(&pasid_mutex);

  	return ret;

Best regards,
baolu
