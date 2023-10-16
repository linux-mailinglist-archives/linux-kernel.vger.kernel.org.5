Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00947C9D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJPDIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:08:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4DFAD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697425686; x=1728961686;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p+48ZSPJM1piPoo3GP0Lvs5oUgCN8lXIKD63ICulS9c=;
  b=dsKZcMjyFNoF+siOdS/ji7TwBRc8QB85+041j8LWA2v0r5vkhDbjP1zp
   rvDnYM/d9Kc4bdps5tv5jl5DPA8MOKZC5cSeLWrTwcA9XcO1q7LvoICZJ
   ntyBo3cPdlkGqlz27seE436DcRmPic3kKIIwLx4JU6+XxwVnuE2umnMd3
   0/WImetRnKfKPHY4j/5Y0LRlFuc0iSw5IabMweuwO05bLhK9gvIOYLiuI
   dOCtMsJV+xftXZblmdrbvWoB4qR75J3IlgmrnJ3MLs2R4N4P7y+Jp/ycb
   XAocO+AR9e3I0XoqRR7INJ6CCCy8DUCP5p2CCgcX4jEpwG00f5lI6TfHS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385275226"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="385275226"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="784935655"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="784935655"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2023 20:08:02 -0700
Message-ID: <fd56b69d-d9ea-411c-9eaa-454b3d64f51e@linux.intel.com>
Date:   Mon, 16 Oct 2023 11:04:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATH v5 3/3] iommu/vt-d: debugfs: Support dumping a specified
 page table
Content-Language: en-US
To:     Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20231013135811.73953-1-Jingqi.liu@intel.com>
 <20231013135811.73953-4-Jingqi.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231013135811.73953-4-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 9:58 PM, Jingqi Liu wrote:
> The original debugfs only dumps all page tables without pasid. With
> pasid supported, the page table with pasid also needs to be dumped.
> 
> This patch supports dumping a specified page table in legacy mode or
> scalable mode with or without a specified pasid.
> 
> For legacy mode, according to bus number and DEVFN, traverse the root
> table and context table to get the pointer of page table in the
> context table entry, then dump the specified page table.
> 
> For scalable mode, according to bus number, DEVFN and pasid, traverse
> the root table, context table, pasid directory and pasid table to get
> the pointer of page table in the pasid table entry, then dump the
> specified page table..
> 
> Examples are as follows:
> 1) Dump the page table of device "0000:00:1f.0" that only supports
>     legacy mode.
>     $ sudo cat
>     /sys/kernel/debug/iommu/intel/0000:00:1f.0/domain_translation_struct
> 
> 2) Dump the page table of device "0000:00:0a.0" with PASID "1" that
>     supports scalable mode.
>     $ sudo cat
>     /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 154 ++++++++++++++++++++++++++--------
>   1 file changed, 120 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index 8a18a7be5215..239136727ac4 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -347,58 +347,141 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
>   	}
>   }
>   
> -static int __show_device_domain_translation(struct device *dev, void *data)
> +static int domain_translation_struct_show(struct seq_file *m,
> +					  struct device_domain_info *info,
> +					  ioasid_t pasid)
>   {
> -	struct dmar_domain *domain;
> -	struct seq_file *m = data;
> -	u64 path[6] = { 0 };
> -
> -	domain = to_dmar_domain(iommu_get_domain_for_dev(dev));
> -	if (!domain)
> -		return 0;
> +	bool scalable, found = false;
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	u16 devfn, bus, seg;
>   
> -	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
> -		   (u64)virt_to_phys(domain->pgd));
> -	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
> +	bus = info->bus;
> +	devfn = info->devfn;
> +	seg = info->segment;
>   
> -	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
> -	seq_putc(m, '\n');
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		struct context_entry *context;
> +		u64 pgd, path[6] = { 0 };
> +		u32 sts, agaw;
>   
> -	/* Don't iterate */
> -	return 1;
> -}
> +		if (seg != iommu->segment)
> +			continue;
>   
> -static int show_device_domain_translation(struct device *dev, void *data)
> -{
> -	struct iommu_group *group;
> +		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
> +		if (!(sts & DMA_GSTS_TES)) {
> +			seq_printf(m, "DMA Remapping is not enabled on %s\n",
> +				   iommu->name);
> +			continue;
> +		}
> +		if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT)
> +			scalable = true;
> +		else
> +			scalable = false;
>   
> -	group = iommu_group_get(dev);
> -	if (group) {
>   		/*
> -		 * The group->mutex is held across the callback, which will
> -		 * block calls to iommu_attach/detach_group/device. Hence,
> +		 * The iommu->lock is held across the callback, which will
> +		 * block calls to domain_attach/domain_detach. Hence,
>   		 * the domain of the device will not change during traversal.
>   		 *
> -		 * All devices in an iommu group share a single domain, hence
> -		 * we only dump the domain of the first device. Even though,
> -		 * this code still possibly races with the iommu_unmap()
> +		 * Traversing page table possibly races with the iommu_unmap()
>   		 * interface. This could be solved by RCU-freeing the page
>   		 * table pages in the iommu_unmap() path.
>   		 */
> -		iommu_group_for_each_dev(group, data,
> -					 __show_device_domain_translation);
> -		iommu_group_put(group);
> +		spin_lock(&iommu->lock);
> +
> +		context = iommu_context_addr(iommu, bus, devfn, 0);
> +		if (!context || !context_present(context))
> +			goto iommu_unlock;
> +
> +		if (scalable) {	/* scalable mode */
> +			struct pasid_dir_entry *dir_tbl, *dir_entry;
> +			struct pasid_entry *pasid_tbl, *pasid_tbl_entry;
> +			u16 pasid_dir_size, dir_idx, tbl_idx, pgtt;
> +			u64 pasid_dir_ptr;

0day robot complained:

    drivers/iommu/intel/debugfs.c: In function 
'domain_translation_struct_show':
 >> drivers/iommu/intel/debugfs.c:401:29: warning: variable 
'pasid_dir_size' set but not used [-Wunused-but-set-variable]
      401 |                         u16 pasid_dir_size, dir_idx, 
tbl_idx, pgtt;
          |                             ^~~~~~~~~~~~~~

I have removed pasid_dir_size and queue the whole series for v6.7.

Thank you!

Best regards,
baolu
