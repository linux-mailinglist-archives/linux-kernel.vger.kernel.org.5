Return-Path: <linux-kernel+bounces-10120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5AA81D07D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D501F231E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD1035EE9;
	Fri, 22 Dec 2023 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jH76MHds"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A033CFA;
	Fri, 22 Dec 2023 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703288165; x=1734824165;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5lXU4Zx0LwUlfSo9nAOyDB6xfslI8gJovnHRYo3QpeA=;
  b=jH76MHdskDA1xkLSxDqskwvsCEm/qVCtXiGyX2UQJh0/QycOIYRX9AKg
   WFfLtQLhwLKG9h/Nn4NR7AiMbc/zf717MCvpPyKfXMBO3O4pc58HZuAz8
   C9t6PdLP7y1+s9Ya50rjnR+6uHl4PL8Ib46iNR4Sb9ZXyXdNq437x80DE
   /Y9wYoQrtPv+VmGhAOmjeZP/dmPYSQLhCxanK8MqLXc0ChN2Rq2IR+GSs
   xkoDx8daVgap0hwzY3nMQRMrqC0VxJ1Kx1b+M8fvY3lV9WOyBlWHd5zAJ
   8iE2HbQgRYTsr6NGtxgqjbWT1yNEDI2Hijcc7oT0rlqafxsWxNz7PXDlk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="3007607"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="3007607"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:36:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="777190812"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="777190812"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:36:01 -0800
Message-ID: <07285ebd-ae7f-4c4a-a926-8c52a2da8da6@linux.intel.com>
Date: Sat, 23 Dec 2023 07:35:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/3] iommu/vt-d: abort the devTLB invalidation
 waiting if device is removed
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231222104108.18499-1-haifeng.zhao@linux.intel.com>
 <20231222104108.18499-4-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231222104108.18499-4-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/22/2023 6:41 PM, Ethan Zhao wrote:
> Even the devTLB invalidation request is just submitted and waiting it
> to be done/timeout in qi_submit_sync(), it is possible device is removed
> or powered-off. try to break it out in such rare but possible case.
>
> This patch is sent for more comment. not tested, only passed compiling.
>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c  |  3 ++-
>   drivers/iommu/intel/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23cb80d62a9a..d8637ab93387 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1422,7 +1422,8 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>   	 */
>   	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
>   
> -	while (qi->desc_status[wait_index] != QI_DONE) {
> +	while (qi->desc_status[wait_index] != QI_DONE &&
> +			qi->desc_status[wait_index] != QI_ABORT) {

Another way is checking pci_device_is_present() here and bail out,

how about it ?

>   		/*
>   		 * We will leave the interrupts disabled, to prevent interrupt
>   		 * context to queue another cmd while a cmd is already submitted
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 897159dba47d..33075d0688bc 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4472,10 +4472,46 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	return &iommu->iommu;
>   }
>   
> +static void intel_iommu_abort_devtlib_invalidate(struct device *dev)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct q_inval *qi = iommu->qi;
> +	struct qi_desc *desc, *idesc;
> +	int index, offset, shift;
> +	u16 sid, qdep, pfsid
> +	unsigned long flags;
> +
> +	if (!dev_is_pci(info->dev) || !info->ats_enabled || !qi)
> +		return;
> +	if (!pci_dev_is_disconnected(to_pci_dev(dev)))
> +		return;
> +
> +	sid = info->bus << 8 | info->devfn;
> +	qdep = info->ats_qdep;
> +	pfsid = info->pfsid;
> +
> +	raw_spin_lock_irqsave(&qi->q_lock, flags);
> +	for (index = 1; index < QI_LENGTH; index++) {
> +		offset = index << shift;
> +		desc = qi->desc + offset;
> +		if (desc->qw0 & QI_IWD_TYPE) {
> +			offset = (index-1) << shift;
> +			idesc = qi->desc + offset;
> +			if (idesc->qw0 & QI_DEV_EIOTLB_SID(sid)) {
> +				if (qi->desc_status[index] == QI_IN_USE)
> +					qi->desc_status[index] = QI_ABORT;
> +			}
> +		}
> +	}
> +	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> +
> +}
>   static void intel_iommu_release_device(struct device *dev)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   
> +	intel_iommu_abort_devtlib_invalidate(dev);

Wonder if there is lock something prevent pciehp_ist() supprise_removal

interrupt response re-enter to get here when another safe_removal is in 
process,

if so ,  see above

>   	dmar_remove_one_dev_info(dev);
>   	intel_pasid_free_table(dev);
>   	intel_iommu_debugfs_remove_dev(info);

