Return-Path: <linux-kernel+bounces-12805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5EC81FA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDDC1F24807
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8BF9D7;
	Thu, 28 Dec 2023 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYQd7W9P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216EF51F;
	Thu, 28 Dec 2023 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703783412; x=1735319412;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=fvNycKJ59548debCMBgo+kpKi4EiiPZDgZTIRntv2+c=;
  b=KYQd7W9Pa4Jdu73NbIi8/maMBrxxuipsuXbpes/p4mdGIjeujQg+RMIw
   FnWlOBa0mKulbE0XIxHNo7PX0ulAwlnSPMean4NmlbpU4bUg+Z9+5ZFtI
   VphecjYb/QYMvXUU3K8uwUr1z0CHSZfg83r0drmtko6PstPb5b5ewiAax
   TFZD+heib471QwOHBkorhHFxjD/996wXpHp/xnzavsJjYD0ijnMLJ0+uT
   io3zQXqzAdMbaKLMatLPulfehl4xRRuPzLg6wrYPqWoBI2QCDjB91XGhS
   rqgxXyhJVir/+KQ4gNrw3kOUmSVy2SjqkWGHUptvlEWv16iL+pIPXaTTG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="9960119"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="9960119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 09:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="951850672"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="951850672"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.169.62]) ([10.249.169.62])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 09:10:07 -0800
Message-ID: <df070366-0aa4-437d-a48f-310dd0db41a8@linux.intel.com>
Date: Fri, 29 Dec 2023 01:10:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: kevin.tian@intel.com, bhelgaas@google.com, baolu.lu@linux.intel.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
 <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231228170504.720794-3-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/29/2023 1:05 AM, Ethan Zhao wrote:
> When the ATS Invalidation request timeout happens, the qi_submit_sync()
> will restart and loop for the invalidation request forever till it is
> done, it will block another Invalidation thread such as the fq_timer
> to issue invalidation request, cause the system lockup as following
>
> [exception RIP: native_queued_spin_lock_slowpath+92]
>
> RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002
>
> RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000
>
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0
>
> RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000
>
> R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000
>
> R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980
>
> ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
#12 [ffffb202f268cdc8] native_queued_spin_lock_slowpath at ffffffffa9d1025c

#13 [ffffb202f268cdc8] do_raw_spin_lock at ffffffffa9d121f1

#14 [ffffb202f268cdd8] _raw_spin_lock_irqsave at ffffffffaa51795b

#15 [ffffb202f268cdf8] iommu_flush_dev_iotlb at ffffffffaa20df48

#16 [ffffb202f268ce28] iommu_flush_iova at ffffffffaa20e182

#17 [ffffb202f268ce60] iova_domain_flush at ffffffffaa220e27

#18 [ffffb202f268ce70] fq_flush_timeout at ffffffffaa221c9d

#19 [ffffb202f268cea8] call_timer_fn at ffffffffa9d46661

#20 [ffffb202f268cf08] run_timer_softirq at ffffffffa9d47933

#21 [ffffb202f268cf98] __softirqentry_text_start at ffffffffaa8000e0

#22 [ffffb202f268cff0] asm_call_sysvec_on_stack at ffffffffaa60114f

This part get lost perhpas I append "----" here.


Thanks,

Ethan

>
> (the left part of exception see the hotplug case of ATS capable device)
>
> If one endpoint device just no response to the ATS Invalidation request,
> but is not gone, it will bring down the whole system, to avoid such
> case, don't try the timeout ATS Invalidation request forever.
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 0a8d628a42ee..9edb4b44afca 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1453,7 +1453,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   	reclaim_free_desc(qi);
>   	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>   
> -	if (rc == -EAGAIN)
> +	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != QI_DEIOTLB_TYPE)
>   		goto restart;
>   
>   	if (iotlb_start_ktime)

