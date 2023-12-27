Return-Path: <linux-kernel+bounces-11791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F1681EBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28771C221AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC123D7;
	Wed, 27 Dec 2023 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgT7qPFn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181F23A6;
	Wed, 27 Dec 2023 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703646200; x=1735182200;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ku0cvgjSyljgDuQ59NAwnQl5wGFzA78P+anngskXiPQ=;
  b=LgT7qPFnb5uLxfHCu1DtIWMfkC+pkazsaJla/keYOIOCNsYxgtiZLHCq
   bZajv0fkFLzS1ATqk6J76TFdWfI+j7/M5HBcB0dBML06Y0+AG5thM5vaf
   /VWFBdFnNuVkoE7Tn8g97teI6lKcw/RgaxS3euQYtpyZvHUWSDfdIhXWI
   9UyzczKxy+saSsIDS4oGSCF0+2mmS8XBBgcukUxqbOKH//y6R5L/ZDLWn
   iqFp9fALhmEsoVM+neuQbeZsQC0qLVoCF0xiKuTDkdkjAwhZqJlxAowPC
   pKMcc01YB780jtPnh7WBOXprLJOCSxkh+dOtAYlO5teckR1PfLXkxJtgB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="15076684"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="15076684"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:03:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="20177524"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.28.66]) ([10.255.28.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:03:16 -0800
Message-ID: <85c96e7d-de2d-46a8-b1d6-f970312b4449@linux.intel.com>
Date: Wed, 27 Dec 2023 11:03:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 5/5] iommu/vt-d: don't loop for timeout device-TLB
 invalidation request forever
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231227025923.536148-1-haifeng.zhao@linux.intel.com>
 <20231227025923.536148-6-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231227025923.536148-6-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/27/2023 10:59 AM, Ethan Zhao wrote:
> When the device-TLB invalidation (ATS invalidation) timeout happens, the
> qi_submit_sync() will restart and loop for the invalidation request
> forever till it is done, it will block another invalidation thread such
> as the fq_timer to issue invalidation request, cause the system lockup as
> following
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


--- ---

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
> --- ---
>
> (the left part of exception see the hotplug case of ATS capable device)
>
> If one endpoint device just no response to the device-TLB invalidation
> request, but is not gone, it will bring down the whole system, to avoid
> such case, don't try the timeout device-TLB request forever.
>
> and as synchronous program model of current qi_submit_sync() implementation
> we couldn't wait for the enough time as PCIe spec said 1min+50%, just break
> it in current sync model. (PCIe spec r6.1, sec 10.3.1)
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 76903a8bf963..206ab0b7294f 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1457,7 +1457,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   	reclaim_free_desc(qi);
>   	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>   
> -	if (rc == -EAGAIN)
> +	if (rc == -EAGAIN && type !=QI_DIOTLB_TYPE && type != QI_DEIOTLB_TYPE)
>   		goto restart;
>   
>   	if (iotlb_start_ktime)

