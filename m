Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE678E71E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjHaHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjHaHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:22:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3F1A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693466523; x=1725002523;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4wer6v6mJCcyvDaQedevv0Y3ICKv0dvwH5/s2/0rEW4=;
  b=TBdxc82J3n4hvrU3vbzLxBUfh+b3m19uZiOIM0d7BLuQVCf1e/9uQUah
   /gymiELhG0eApQ/nh8tRB1bDeyQtJx/cwjffQOfxM0zRxxISnVOjU58WJ
   EpQw3jV33BWOD58VjF70khQqkTwyEX1HDHALMYCE0MQnnub+FdWTSoIzv
   i8WwK0EBrDFaI+yrB2/I2M11e2I+NeED1VCpAfbNkd5hjIFx2yWp8WiAD
   xOLSIm9VIYBDYA95wLOG9CIkvKF4w8kyJyueY7B1qC5tMA+5DvTXcVMBh
   ahMjPSqm7eZH0yxHvAR85d59aoGhRpQzDQiZaQSvDzxxl1VJEEajFMYn4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360831495"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="360831495"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="986093986"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="986093986"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 00:21:59 -0700
Message-ID: <0e4ed22f-19cf-a92e-1117-6587fbe6e1e7@linux.intel.com>
Date:   Thu, 31 Aug 2023 15:21:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/27 16:44, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when no one is using it (the reference count is decremented
> in iommu_sva_unbind_device()).
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
>   include/linux/iommu.h     | 10 +++-------
>   kernel/fork.c             |  1 -
>   3 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 0a4a1ed40814c..35366f51ad27d 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -15,6 +15,7 @@ static DEFINE_IDA(iommu_global_pasid_ida);
>   /* Allocate a PASID for the mm within range (inclusive) */
>   static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   {
> +	struct iommu_mm_data *iommu_mm = NULL;

No need to initialize this variable.

>   	int ret = 0;
>   
>   	if (min == IOMMU_PASID_INVALID ||
> @@ -33,11 +34,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>   		goto out;
>   	}
>   
> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +	if (!iommu_mm) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>   	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(iommu_mm);
>   		goto out;
> +	}
> +
> +	iommu_mm->pasid = ret;
> +	mm->iommu_mm = iommu_mm;
> +	INIT_LIST_HEAD(&mm->iommu_mm->sva_domains);

If you change the order of the two lines above, it will look more
comfortable.

>   
> -	mm->pasid = ret;
>   	ret = 0;
>   out:
>   	mutex_unlock(&iommu_sva_lock);
> @@ -82,16 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   
>   	mutex_lock(&iommu_sva_lock);
>   	/* Search for an existing domain. */
> -	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
> -						IOMMU_DOMAIN_SVA);
> -	if (IS_ERR(domain)) {
> -		ret = PTR_ERR(domain);
> -		goto out_unlock;
> -	}
> -
> -	if (domain) {
> -		domain->users++;
> -		goto out;
> +	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
> +		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
> +		if (!ret) {
> +			domain->users++;
> +			goto out;
> +		}
>   	}
>   
>   	/* Allocate a new domain and set it on device pasid. */
> @@ -105,6 +113,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>   	if (ret)
>   		goto out_free_domain;
>   	domain->users = 1;
> +	list_add(&domain->next, &mm->iommu_mm->sva_domains);
> +
>   out:
>   	mutex_unlock(&iommu_sva_lock);
>   	handle->dev = dev;
> @@ -137,8 +147,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   	struct device *dev = handle->dev;
>   
>   	mutex_lock(&iommu_sva_lock);
> +	iommu_detach_device_pasid(domain, dev, pasid);
>   	if (--domain->users == 0) {
> -		iommu_detach_device_pasid(domain, dev, pasid);
> +		list_del(&domain->next);
>   		iommu_domain_free(domain);
>   	}
>   	mutex_unlock(&iommu_sva_lock);
> @@ -218,4 +229,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>   		return;
>   
>   	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
> +	kfree(mm->iommu_mm);
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 937f3abc26f2e..cfbd35ceb375f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -109,6 +109,7 @@ struct iommu_domain {
>   		struct {	/* IOMMU_DOMAIN_SVA */
>   			struct mm_struct *mm;
>   			int users;
> +			struct list_head next;

It looks better if you add a comment to describe how this list node is
used and how the list is protected.

>   		};
>   	};
>   };
> @@ -1177,17 +1178,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>   }
>   
>   #ifdef CONFIG_IOMMU_SVA
> -static inline void mm_pasid_init(struct mm_struct *mm)
> -{
> -	mm->pasid = IOMMU_PASID_INVALID;
> -}
>   static inline bool mm_valid_pasid(struct mm_struct *mm)
>   {
> -	return mm->pasid != IOMMU_PASID_INVALID;
> +	return mm->iommu_mm ? true : false;
>   }
>   static inline u32 mm_get_pasid(struct mm_struct *mm)
>   {
> -	return mm->pasid;
> +	return mm->iommu_mm ? mm->iommu_mm->pasid : IOMMU_PASID_INVALID;
>   }
>   static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
>   {
> @@ -1213,7 +1210,6 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   {
>   	return IOMMU_PASID_INVALID;
>   }
> -static inline void mm_pasid_init(struct mm_struct *mm) {}
>   static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
>   static inline u32 mm_get_pasid(struct mm_struct *mm)
>   {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2e12b6d2b180..f06392dd1ca8a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1274,7 +1274,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	mm_init_cpumask(mm);
>   	mm_init_aio(mm);
>   	mm_init_owner(mm, p);
> -	mm_pasid_init(mm);
>   	RCU_INIT_POINTER(mm->exe_file, NULL);
>   	mmu_notifier_subscriptions_init(mm);
>   	init_tlb_flush_pending(mm);

This patch overall looks good to me. With above nits addressed,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
