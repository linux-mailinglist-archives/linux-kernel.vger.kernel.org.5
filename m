Return-Path: <linux-kernel+bounces-70788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AABF859C65
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6941F21D44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF512031E;
	Mon, 19 Feb 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JumMgzjC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520220315
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325671; cv=none; b=N6ZBspetFjxWleTglf3SDGiOgAh5tPgleebOuHdX7cdETsw49z60lqyom2M8pn3/gKo5JkSLH7H17zUP5xon6xi4KWGpSUBn+0ItAiJTMsXVI4eauvnX1gNv9tIAS50qoOuE7ovxm0NAoP+43Nj4lBCobTPKB+oVU0p4IgsRYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325671; c=relaxed/simple;
	bh=zVewlNBgGUCgfrE63kzp5qI6dYvDrVJ46HT15RFP0tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmwYNY6m69d0rKwWtvSfR/KXQ1YwxC41h0VOFsE85kDZCqx1ohiebm3VRpV58F5k4Jd9JkyiGiLYDKznCxGhA29yZ04ErbyfE13aTxD+VOwakiOokzSXZD6kDlfMSWzYtChvpmP8HOySgAp1KwXg6vJ/2n9zLDNUba5frZx6O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JumMgzjC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708325670; x=1739861670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zVewlNBgGUCgfrE63kzp5qI6dYvDrVJ46HT15RFP0tM=;
  b=JumMgzjCqnMZKjexu/9nAoikkLe7wFLjzQ1HAkuER3w1JlEmRO6cMw6h
   guuBLKoJMaq4A/IrsMUk9pxEyOPz+k1xqKyqbadVVn7Zt+fphLIUdKOtW
   Ju3+ac2ikCH1Q/Z707ykM/QofMMs9tZjA4RU/wTeNRZeNfu3Ed+wNfZqU
   FosJRtl+cozH2QiTvi6NGEpKa+eGAvAR9CyULpzCX8sh/EgEhfsDSx13j
   bzW9vNQLwrWvOMXdNrLaqRo7Xbsbm9NFfnZgNa7WZoRzhHxR52feX+DOL
   Ss4jDbUfp39zVVjTn/PzRtzQcswof0TuYLIADQoMSw292sCyqfBkxl0Zu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="5353150"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="5353150"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="35181702"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.209.179]) ([10.254.209.179])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:54:26 -0800
Message-ID: <0da83c5c-0e35-4087-aacf-6831060cab8e@linux.intel.com>
Date: Mon, 19 Feb 2024 14:54:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-3-baolu.lu@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240215072249.4465-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/2024 3:22 PM, Lu Baolu wrote:
> The existing IO page fault handler currently locates the PCI device by
> calling pci_get_domain_bus_and_slot(). This function searches the list
> of all PCI devices until the desired device is found. To improve lookup
> efficiency, a helper function named device_rbtree_find() is introduced
> to search for the device within the rbtree. Replace
> pci_get_domain_bus_and_slot() in the IO page fault handling path.
>
> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h |  1 +
>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>   drivers/iommu/intel/svm.c   | 14 ++++++--------
>   3 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 54eeaa8e35a9..f13c228924f8 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
>   void iommu_flush_write_buffer(struct intel_iommu *iommu);
>   struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>   					       const struct iommu_user_data *user_data);
> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   void intel_svm_check(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 09009d96e553..d92c680bcc96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, const struct rb_node *rhs)
>   	return device_rid_cmp_key(&key, rhs);
>   }
>   
> +/*
> + * Looks up an IOMMU-probed device using its source ID.
> + *
> + * If the device is found:
> + *  - Increments its reference count.
> + *  - Returns a pointer to the device.
> + *  - The caller must call put_device() after using the pointer.
> + *
> + * If the device is not found, returns NULL.
> + */
> +struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
> +{
> +	struct device_domain_info *info;
> +	struct device *dev = NULL;
> +	struct rb_node *node;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);

Though per iommu device rbtree isn't a big tree, given already holds spin_lock
why still needs irq off ?


Thanks,
Ethan

> +	node = rb_find(&rid, &iommu->device_rbtree, device_rid_cmp_key);
> +	if (node) {
> +		info = rb_entry(node, struct device_domain_info, node);
> +		dev = info->dev;
> +		get_device(dev);
> +	}
> +	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
> +
> +	return dev;
> +}
> +
>   static int device_rbtree_insert(struct intel_iommu *iommu,
>   				struct device_domain_info *info)
>   {
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index b644d57da841..717b7041973c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -645,7 +645,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   	struct intel_iommu *iommu = d;
>   	struct page_req_dsc *req;
>   	int head, tail, handled;
> -	struct pci_dev *pdev;
> +	struct device *dev;
>   	u64 address;
>   
>   	/*
> @@ -691,21 +691,19 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
>   			goto prq_advance;
>   
> -		pdev = pci_get_domain_bus_and_slot(iommu->segment,
> -						   PCI_BUS_NUM(req->rid),
> -						   req->rid & 0xff);
>   		/*
>   		 * If prq is to be handled outside iommu driver via receiver of
>   		 * the fault notifiers, we skip the page response here.
>   		 */
> -		if (!pdev)
> +		dev = device_rbtree_find(iommu, req->rid);
> +		if (!dev)
>   			goto bad_req;
>   
> -		intel_svm_prq_report(iommu, &pdev->dev, req);
> -		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
> +		intel_svm_prq_report(iommu, dev, req);
> +		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
>   				 req->priv_data[0], req->priv_data[1],
>   				 iommu->prq_seq_number++);
> -		pci_dev_put(pdev);
> +		put_device(dev);
>   prq_advance:
>   		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>   	}

