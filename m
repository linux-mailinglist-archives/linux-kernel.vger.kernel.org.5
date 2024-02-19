Return-Path: <linux-kernel+bounces-70663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F53859AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F8D1C2109F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE52257D;
	Mon, 19 Feb 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfUPBW1I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881C20F1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708310753; cv=none; b=WTON8CZBkcU+JlVlVQbn3/BnjUudBH2LQZAzPA3mFyxjUzm59z4htoKvHilJeh2ZqKDoJR/m+UHP8r59+XrD4mipHlzWw2zqY7yGAA/TSAtAoqTN5uRNvL9nMksQFqoM+EqFPc6cYOPCCNBvD7RSKkhYEoFxQBS9H9g04scqTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708310753; c=relaxed/simple;
	bh=jLKo4UyGeYxJZoyOzIUF8wJoLEiraRcY6Lb44gvdGHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pv0jH5RhjzK3BMXYyM92dmhmabQBapYP7/cbQa7EeXzy1bCxuR94EuAM0T6dsBPnRnrzcp7G2S7U/HJ6AMWEVy/h6bfgKd57Ls1NFERdmYqj2mz2Uq3HrCBa6pToPaJhDxMKH63kIqS7oLbr3ab1y4waTWDn2uqBVd/UXiYAlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfUPBW1I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708310752; x=1739846752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jLKo4UyGeYxJZoyOzIUF8wJoLEiraRcY6Lb44gvdGHY=;
  b=SfUPBW1IoAd7+gMJB85Km0OM6FdQMNwibqLLZ0u3qbGmNlp9Kdb3Rjax
   y66tT6xEcHtCToLgBXPmaXsy/Y80qA39WeB0uqEu8dk2/y4surPglFctc
   SOOMx4g04wnD3JYf8mQCOf6kRpmUzqZujlJwJqvSJpj6resheHKdLuCGt
   I3n4bCCmlrwdcAqk0yoT21Jqbm4sVNN/tz1cQUMbtbAqFZedztNGeRJjj
   DghHAGIi9Kji7qHWX/byyA2qRjAqdhZHRcK+ek3BvTcRF/5nvjhzkfVDo
   /Op8nz7QxsFYlu5OJvH9i26ruzUOgbhf3/GisRU3uHZ+7c2z+zDib1XS5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13484224"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13484224"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="27527006"
Received: from yuhanliu-mobl.ccr.corp.intel.com (HELO [10.254.209.179]) ([10.254.209.179])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:45:47 -0800
Message-ID: <eace2ec0-0b8b-450d-b05f-7b7ca3e473a7@linux.intel.com>
Date: Mon, 19 Feb 2024 10:45:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240215072249.4465-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/15/2024 3:22 PM, Lu Baolu wrote:
> Use a red-black tree(rbtree) to track devices probed by the driver's
> probe_device callback. These devices need to be looked up quickly by
> a source ID when the hardware reports a fault, either recoverable or
> unrecoverable.
>
> Fault reporting paths are critical. Searching a list in this scenario
> is inefficient, with an algorithm complexity of O(n). An rbtree is a
> self-balancing binary search tree, offering an average search time
> complexity of O(log(n)). This significant performance improvement
> makes rbtrees a better choice.
>
> Furthermore, rbtrees are implemented on a per-iommu basis, eliminating
> the need for global searches and further enhancing efficiency in
> critical fault paths. The rbtree is protected by a spin lock with
> interrupts disabled to ensure thread-safe access even within interrupt
> contexts.
>
> Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h |  7 +++++
>   drivers/iommu/intel/dmar.c  |  3 +-
>   drivers/iommu/intel/iommu.c | 62 +++++++++++++++++++++++++++++++++++--
>   3 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index cf9a28c7fab8..54eeaa8e35a9 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -716,6 +716,11 @@ struct intel_iommu {
>   	struct q_inval  *qi;            /* Queued invalidation info */
>   	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
>   
> +	/* rb tree for all probed devices */
> +	struct rb_root device_rbtree;
> +	/* protect the device_rbtree */
> +	spinlock_t device_rbtree_lock;
> +
>   #ifdef CONFIG_IRQ_REMAP
>   	struct ir_table *ir_table;	/* Interrupt remapping info */
>   	struct irq_domain *ir_domain;
> @@ -749,6 +754,8 @@ struct device_domain_info {
>   	struct intel_iommu *iommu; /* IOMMU used by this device */
>   	struct dmar_domain *domain; /* pointer to domain */
>   	struct pasid_table *pasid_table; /* pasid table */
> +	/* device tracking node(lookup by PCI RID) */
> +	struct rb_node node;
>   #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
>   	struct dentry *debugfs_dentry; /* pointer to device directory dentry */
>   #endif
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23cb80d62a9a..f9b63c2875f7 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1095,7 +1095,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   	iommu->agaw = agaw;
>   	iommu->msagaw = msagaw;
>   	iommu->segment = drhd->segment;
> -
> +	iommu->device_rbtree = RB_ROOT;
> +	spin_lock_init(&iommu->device_rbtree_lock);
>   	iommu->node = NUMA_NO_NODE;
>   
>   	ver = readl(iommu->reg + DMAR_VER_REG);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a81a2be9b870..09009d96e553 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -96,6 +96,55 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
>   	return re->hi & VTD_PAGE_MASK;
>   }
>   
> +static int device_rid_cmp_key(const void *key, const struct rb_node *node)
> +{
> +	struct device_domain_info *info =
> +		rb_entry(node, struct device_domain_info, node);
> +	const u16 *rid_lhs = key;
> +
> +	if (*rid_lhs < PCI_DEVID(info->bus, info->devfn))
> +		return -1;
> +
> +	if (*rid_lhs > PCI_DEVID(info->bus, info->devfn))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int device_rid_cmp(struct rb_node *lhs, const struct rb_node *rhs)
> +{
> +	struct device_domain_info *info =
> +		rb_entry(lhs, struct device_domain_info, node);
> +	u16 key = PCI_DEVID(info->bus, info->devfn);
> +
> +	return device_rid_cmp_key(&key, rhs);
> +}
> +
> +static int device_rbtree_insert(struct intel_iommu *iommu,
> +				struct device_domain_info *info)
> +{
> +	struct rb_node *curr;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> +	curr = rb_find_add(&info->node, &iommu->device_rbtree, device_rid_cmp);
> +	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
> +	if (curr)
> +		dev_warn(info->dev, "device already in rbtree\n");
> +
> +	return curr ? -EEXIST : 0;
> +}
> +
> +static void device_rbtree_remove(struct device_domain_info *info)
> +{
> +	struct intel_iommu *iommu = info->iommu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> +	rb_erase(&info->node, &iommu->device_rbtree);
> +	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
> +}
> +
>   /*
>    * This domain is a statically identity mapping domain.
>    *	1. This domain creats a static 1:1 mapping to all usable memory.
> @@ -4264,25 +4313,34 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	}
>   
>   	dev_iommu_priv_set(dev, info);
> +	ret = device_rbtree_insert(iommu, info);
> +	if (ret)
> +		goto free;
>   
>   	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>   		ret = intel_pasid_alloc_table(dev);
>   		if (ret) {
>   			dev_err(dev, "PASID table allocation failed\n");
> -			kfree(info);
> -			return ERR_PTR(ret);
> +			goto clear_rbtree;
>   		}
>   	}
>   
>   	intel_iommu_debugfs_create_dev(info);
>   
>   	return &iommu->iommu;
> +clear_rbtree:
> +	device_rbtree_remove(info);
> +free:
> +	kfree(info);
> +
> +	return ERR_PTR(ret);
>   }
>   
>   static void intel_iommu_release_device(struct device *dev)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   
> +	device_rbtree_remove(info);

Perhpas too early here to remove dev from the rbtree, if it is wanted in
devTLB invalidation steps in intel_pasid_tear_down_entry().

Thanks,
Ethan

>   	dmar_remove_one_dev_info(dev);
>   	intel_pasid_free_table(dev);
>   	intel_iommu_debugfs_remove_dev(info);

