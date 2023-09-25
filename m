Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E97ACDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjIYBuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjIYBus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:50:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395B10A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695606641; x=1727142641;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zf5XrVJUq0MZ51PJoqNIbQ8PveMr4Q+eb7PdneYWNB0=;
  b=gQAVfeGJAkZqePnj/IrmbKshbWz/SQ46nB3LOl97Wa9olIvpIcScSIBa
   x/gGrNfjKBVe4mCNMrliDy2yGKe4BwaNdCmQQguCBYwkT2wY+kXZIUaSg
   dCUVaAFZ04oxQH6AJs/zlc0qgC/Y9B8lkXuY0Dg/DjcwFutf/t6aZerRG
   /GcxSu14rhf7pVmP2ITKArNhOKTKuP44al1SKoLdt4Sdz0EOK5+/MSRCB
   os17badHQZUD95VPo33phnD+S3KCABWjuu8grdImH25xZjmhpJmHqpgJk
   4nD8YQX+/Hx7lwBgIb8uYy3WnGJ9ZXrcKbnrmw5n0eo4gqbLLa8/OCfj8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447632371"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="447632371"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 18:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741733745"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="741733745"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 24 Sep 2023 18:50:37 -0700
Message-ID: <6a0abdd4-3c81-c7dd-1cbf-a3c04762dd41@linux.intel.com>
Date:   Mon, 25 Sep 2023 09:47:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iommu/vt-d: debugfs: Create/remove debugfs file
 per {device, pasid}
Content-Language: en-US
To:     Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230922151636.77139-1-Jingqi.liu@intel.com>
 <20230922151636.77139-3-Jingqi.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230922151636.77139-3-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 11:16 PM, Jingqi Liu wrote:
> Add a debugfs directory per pair of {device, pasid} if the mappings of
> its page table are created and destroyed by the iommu_map/unmap()
> interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
> Create a debugfs file in the directory for users to dump the page
> table corresponding to {device, pasid}. e.g.
> /sys/kernel/debug/iommu/intel/0000:00:02.0/0/domain_translation_struct.
> 
> When attaching device without pasid, create a debugfs file with
> PASID#0, i.e. RID_PASID. When attaching a domain to a pasid of device,
> create a debugfs file with the specified pasid.
> 
> When detaching without pasid, remove the directory and file for
> PASID#0. When detaching with pasid, remove the debugfs directory and
> file of the specified pasid. Remove the entire debugfs directory of
> the specified device for releasing device.
> e.g. /sys/kernel/debug/iommu/intel/0000:00:01.0
> 
> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 117 ++++++++++++++++++++++++++++++++--
>   drivers/iommu/intel/iommu.c   |  16 +++++
>   drivers/iommu/intel/iommu.h   |   4 ++
>   3 files changed, 132 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index e2a3c37943a0..9128febba3c6 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -32,6 +32,11 @@ struct iommu_regset {
>   	const char *regs;
>   };
>   
> +struct show_domain_info {
> +	struct device *dev;
> +	ioasid_t pasid;
> +};
> +
>   #define DEBUG_BUFFER_SIZE	1024
>   static char debug_buf[DEBUG_BUFFER_SIZE];
>   
> @@ -111,6 +116,8 @@ static const struct iommu_regset iommu_regs_64[] = {
>   	IOMMU_REGSET_ENTRY(VCRSP),
>   };
>   
> +static struct dentry *intel_iommu_debug;
> +
>   static int iommu_regset_show(struct seq_file *m, void *unused)
>   {
>   	struct dmar_drhd_unit *drhd;
> @@ -673,16 +680,12 @@ static const struct file_operations dmar_perf_latency_fops = {
>   
>   void __init intel_iommu_debugfs_init(void)
>   {
> -	struct dentry *intel_iommu_debug = debugfs_create_dir("intel",
> -						iommu_debugfs_dir);
> +	intel_iommu_debug = debugfs_create_dir("intel", iommu_debugfs_dir);
>   
>   	debugfs_create_file("iommu_regset", 0444, intel_iommu_debug, NULL,
>   			    &iommu_regset_fops);
>   	debugfs_create_file("dmar_translation_struct", 0444, intel_iommu_debug,
>   			    NULL, &dmar_translation_struct_fops);
> -	debugfs_create_file("domain_translation_struct", 0444,
> -			    intel_iommu_debug, NULL,
> -			    &domain_translation_struct_fops);
>   	debugfs_create_file("invalidation_queue", 0444, intel_iommu_debug,
>   			    NULL, &invalidation_queue_fops);
>   #ifdef CONFIG_IRQ_REMAP
> @@ -692,3 +695,107 @@ void __init intel_iommu_debugfs_init(void)
>   	debugfs_create_file("dmar_perf_latency", 0644, intel_iommu_debug,
>   			    NULL, &dmar_perf_latency_fops);
>   }
> +
> +/*
> + * Create a debugfs directory per pair of {device, pasid},
> + * then create the corresponding debugfs file in this directory
> + * for user to dump its page table. e.g.
> + * /sys/kernel/debug/iommu/intel/0000:00:01.0/0/domain_translation_struct
> + */
> +void intel_iommu_debugfs_create_dev_pasid(struct device *dev, u32 pasid)
> +{
> +	struct dentry *pasid_dir = NULL, *dev_dir = NULL;
> +	struct iommu_domain *domain = NULL;
> +	struct show_domain_info *sinfo;
> +	char pname[10];
> +
> +	if (pasid == IOMMU_NO_PASID) {
> +		struct device_domain_info *info = dev_iommu_priv_get(dev);
> +		if (!info)
> +			return;
> +		domain = &info->domain->domain;
> +	} else
> +		domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);

Can you just add domain as a parameter to this helper? This helper is
probably called in the process of attaching. so the domain pointers may
not be initialized yet.

> +
> +	/*
> +	 * The debugfs only dumps the page tables whose mappings are created
> +	 * and destroyed by the iommu_map/unmap() interfaces. Check the
> +	 * mapping type of the domain before creating debugfs directory.
> +	 */
> +	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
> +		return;
> +
> +	dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);

The comments of debugfs_lookup says:

/**
  * debugfs_lookup() - look up an existing debugfs file
  * @name: a pointer to a string containing the name of the file to look up.
  * @parent: a pointer to the parent dentry of the file.
  *
  * This function will return a pointer to a dentry if it succeeds.  If 
the file
  * doesn't exist or an error occurs, %NULL will be returned.  The returned
  * dentry must be passed to dput() when it is no longer needed.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */

where is the paired dput()?

Ditto to all debugfs_lookup() calls in this file.


> +	if (!dev_dir) {
> +		dev_dir = debugfs_create_dir(dev_name(dev), intel_iommu_debug);
> +		if (IS_ERR(dev_dir))
> +			return;
> +	}
> +
> +	sprintf(pname, "%x", pasid);
> +	pasid_dir = debugfs_create_dir(pname, dev_dir);
> +	if (IS_ERR(pasid_dir))
> +		return;
> +
> +	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
> +	if (!sinfo)
> +		return;
> +
> +	sinfo->dev = dev;
> +	sinfo->pasid = pasid;
> +
> +	debugfs_create_file("domain_translation_struct", 0444,
> +			    pasid_dir, sinfo,
> +			    &domain_translation_struct_fops);
> +}
> +
> +/*
> + * Remove the debugfs directory and file corresponding to each pair of
> + * {device, pasid}. There're two scenarios that will call this helper:
> + * 1) Detach the specified device with pasid.
> + * 2) IOMMU release a device.
> + */
> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 pasid)
> +{
> +	struct dentry *pasid_dir = NULL, *dev_dir = NULL;
> +	struct dentry *dentry = NULL;
> +	char pname[10];
> +
> +	dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
> +	if (!dev_dir)
> +		return;
> +
> +	/* Check if the entire debugfs directory needs to be removed. */
> +	if (pasid == IOMMU_PASID_INVALID) {
> +		struct list_head *plist;
> +		struct dentry *sub_dentry;
> +
> +		list_for_each(plist, &(dev_dir->d_subdirs)) {
> +			sub_dentry = list_entry(plist, struct dentry, d_child);
> +			if(sub_dentry) {
> +				dentry = debugfs_lookup("domain_translation_struct", sub_dentry);
> +				if (!dentry)
> +					continue;
> +
> +				if (dentry->d_inode->i_private)
> +					kfree(dentry->d_inode->i_private);
> +			}
> +		}
> +
> +		debugfs_remove_recursive(dev_dir);
> +	} else { /* Remove the directory with specified pasid. */
> +		sprintf(pname, "%x", pasid);
> +		pasid_dir = debugfs_lookup(pname, dev_dir);
> +		if (!pasid_dir)
> +			return;
> +
> +		dentry = debugfs_lookup("domain_translation_struct", pasid_dir);
> +		if (!dentry)
> +			return;
> +
> +		if (dentry->d_inode->i_private)
> +			kfree(dentry->d_inode->i_private);
> +
> +		debugfs_remove_recursive(pasid_dir);
> +	}
> +}

The above is too complex to review and maintain.

If I were to make the change, I would move the device directory
management to the IOMMU probe/release devices path, and keep the PASID
directory management in the domain attaching/detaching paths.

Or I overlooked anything?

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index dd8ff358867d..8d3c3ef1d0e2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2488,6 +2488,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   
>   	iommu_enable_pci_caps(info);
>   
> +	intel_iommu_debugfs_create_dev_pasid(dev, IOMMU_NO_PASID);
> +
>   	return 0;
>   }
>   
> @@ -3966,6 +3968,9 @@ static void dmar_remove_one_dev_info(struct device *dev)
>   
>   	domain_detach_iommu(domain, iommu);
>   	info->domain = NULL;
> +
> +	/* Remove the entire debugfs directory specified by device. */
> +	intel_iommu_debugfs_remove_dev_pasid(dev, IOMMU_PASID_INVALID);
>   }
>   
>   /*
> @@ -3997,6 +4002,12 @@ static void device_block_translation(struct device *dev)
>   
>   	domain_detach_iommu(info->domain, iommu);
>   	info->domain = NULL;
> +
> +	/*
> +	 * Remove the debugfs directory specified by device and
> +	 * RID_PASID pasid.
> +	 */
> +	intel_iommu_debugfs_remove_dev_pasid(dev, IOMMU_NO_PASID);
>   }
>   
>   static int md_domain_init(struct dmar_domain *domain, int guest_width)
> @@ -4729,6 +4740,9 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   out_tear_down:
>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>   	intel_drain_pasid_prq(dev, pasid);
> +
> +	/* Remove the debugfs directory specified by device and pasid. */
> +	intel_iommu_debugfs_remove_dev_pasid(dev, pasid);
>   }
>   
>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> @@ -4777,6 +4791,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>   	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>   
> +	intel_iommu_debugfs_create_dev_pasid(dev, pasid);
> +
>   	return 0;
>   out_detach_iommu:
>   	domain_detach_iommu(dmar_domain, iommu);
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index c18fb699c87a..250178d8014b 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -883,8 +883,12 @@ static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid
>   
>   #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
>   void intel_iommu_debugfs_init(void);
> +void intel_iommu_debugfs_create_dev_pasid(struct device *dev, u32 pasid);
> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 pasid);
>   #else
>   static inline void intel_iommu_debugfs_init(void) {}
> +void intel_iommu_debugfs_create_dev_pasid(struct device *dev, u32 pasid) {}
> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 pasid) {}
>   #endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
>   
>   extern const struct attribute_group *intel_iommu_groups[];

Best regards,
baolu
