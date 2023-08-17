Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9599E77FE93
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354705AbjHQTeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354761AbjHQTeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:34:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57DDE3581
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:34:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4893D75;
        Thu, 17 Aug 2023 12:34:52 -0700 (PDT)
Received: from [10.57.90.41] (unknown [10.57.90.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4298B3F64C;
        Thu, 17 Aug 2023 12:34:10 -0700 (PDT)
Message-ID: <38eea9f2-7c55-86e5-c0e0-e02f419c4331@arm.com>
Date:   Thu, 17 Aug 2023 20:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v1 1/8] iommu/arm-smmu-v3: Add list of installed_smmus
Content-Language: en-GB
To:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-17 19:16, Michael Shavit wrote:
> Add a new arm_smmu_installed_smmu class to aggregate masters belonging
> to the same SMMU that a domain is attached to.
> Update usages of the domain->devices list to first iterate over this
> parent installed_smmus list.
> 
> This allows functions that batch commands to an SMMU to first iterate
> over the list of installed SMMUs before preparing the batched command
> from the set of attached masters.

I get the feeling that any purpose this serves could be achieved far 
more simply by just keeping the lists sorted by SMMU instance. Then we 
just iterate the list as normal, do per-device stuff for each device, 
and do per-instance stuff each time we see an instance that's different 
from the last one. That should represent about 3 or 4 extra lines of 
code in the places that actually do per-instance stuff, compared to 
blowing up simple per-device iterations like the comically unreadable 
first hunk below...

Thanks,
Robin.

> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  28 ++++-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 109 ++++++++++++++----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 ++-
>   3 files changed, 118 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 238ede8368d10..a4e235b4f1c4b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -48,21 +48,37 @@ static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
>   					   int ssid,
>   					   struct arm_smmu_ctx_desc *cd)
>   {
> +	struct arm_smmu_installed_smmu *installed_smmu;
>   	struct arm_smmu_master *master;
>   	unsigned long flags;
>   	int ret;
>   
> -	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> -		ret = arm_smmu_write_ctx_desc(master, ssid, cd);
> +	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
> +	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus, list) {
> +		list_for_each_entry(master, &installed_smmu->devices, list) {
> +			ret = arm_smmu_write_ctx_desc(master, ssid, cd);
> +			if (ret) {
> +				list_for_each_entry_from_reverse(
> +					master, &installed_smmu->devices, list)
> +					arm_smmu_write_ctx_desc(master, ssid,
> +								NULL);
> +				break;
> +			}
> +		}
>   		if (ret) {
> -			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
> -				arm_smmu_write_ctx_desc(master, ssid, NULL);
> +			list_for_each_entry_continue_reverse(
> +				installed_smmu, &smmu_domain->installed_smmus,
> +				list) {
> +				list_for_each_entry(
> +					master, &installed_smmu->devices, list)
> +					arm_smmu_write_ctx_desc(master, ssid,
> +								NULL);
> +			}
>   			break;
>   		}
>   	}
>   
> -	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
>   	return ret;
>   }
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f17704c35858d..cb4bf0c7c3dd6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1811,10 +1811,12 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>   			    unsigned long iova, size_t size)
>   {
>   	int i;
> +	int ret;
>   	unsigned long flags;
>   	struct arm_smmu_cmdq_ent cmd;
>   	struct arm_smmu_master *master;
>   	struct arm_smmu_cmdq_batch cmds;
> +	struct arm_smmu_installed_smmu *installed_smmu;
>   
>   	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
>   		return 0;
> @@ -1838,21 +1840,26 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>   
>   	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
>   
> -	cmds.num = 0;
> -
> -	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> -		if (!master->ats_enabled)
> -			continue;
> +	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
> +	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus, list) {
> +		cmds.num = 0;
> +		list_for_each_entry(master, &installed_smmu->devices, list) {
> +			if (!master->ats_enabled)
> +				continue;
>   
> -		for (i = 0; i < master->num_streams; i++) {
> -			cmd.atc.sid = master->streams[i].id;
> -			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
> +			for (i = 0; i < master->num_streams; i++) {
> +				cmd.atc.sid = master->streams[i].id;
> +				arm_smmu_cmdq_batch_add(installed_smmu->smmu,
> +							&cmds, &cmd);
> +			}
>   		}
> +		ret = arm_smmu_cmdq_batch_submit(installed_smmu->smmu, &cmds);
> +		if (ret)
> +			break;
>   	}
> -	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
>   
> -	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
> +	return ret;
>   }
>   
>   /* IO_PGTABLE API */
> @@ -2049,8 +2056,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>   		return NULL;
>   
>   	mutex_init(&smmu_domain->init_mutex);
> -	INIT_LIST_HEAD(&smmu_domain->devices);
> -	spin_lock_init(&smmu_domain->devices_lock);
> +	INIT_LIST_HEAD(&smmu_domain->installed_smmus);
> +	spin_lock_init(&smmu_domain->installed_smmus_lock);
>   	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
>   
>   	return &smmu_domain->domain;
> @@ -2353,9 +2360,66 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
>   	pci_disable_pasid(pdev);
>   }
>   
> -static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> +static void arm_smmu_installed_smmus_remove_device(
> +	struct arm_smmu_domain *smmu_domain,
> +	struct arm_smmu_master *master)
>   {
> +	struct arm_smmu_installed_smmu *installed_smmu;
> +	struct arm_smmu_device *smmu;
>   	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
> +	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
> +			    list) {
> +		smmu = installed_smmu->smmu;
> +		if (smmu != master->smmu)
> +			continue;
> +		list_del(&master->list);
> +		if (list_empty(&installed_smmu->devices)) {
> +			list_del(&installed_smmu->list);
> +			kfree(installed_smmu);
> +		}
> +		break;
> +	}
> +	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
> +}
> +
> +static int
> +arm_smmu_installed_smmus_add_device(struct arm_smmu_domain *smmu_domain,
> +				    struct arm_smmu_master *master)
> +{
> +	struct arm_smmu_installed_smmu *installed_smmu;
> +	struct arm_smmu_device *smmu = master->smmu;
> +	bool list_entry_found = false;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
> +	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
> +			    list) {
> +		if (installed_smmu->smmu == smmu) {
> +			list_entry_found = true;
> +			break;
> +		}
> +	}
> +	if (!list_entry_found) {
> +		installed_smmu = kzalloc(sizeof(*installed_smmu), GFP_KERNEL);
> +		if (!installed_smmu) {
> +			ret = -ENOMEM;
> +			goto unlock;
> +		}
> +		INIT_LIST_HEAD(&installed_smmu->devices);
> +		installed_smmu->smmu = smmu;
> +		list_add(&installed_smmu->list, &smmu_domain->installed_smmus);
> +	}
> +	list_add(&master->list, &installed_smmu->devices);
> +unlock:
> +	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
> +	return ret;
> +}
> +
> +static void arm_smmu_detach_dev(struct arm_smmu_master *master)
> +{
>   	struct arm_smmu_domain *smmu_domain = master->domain;
>   
>   	if (!smmu_domain)
> @@ -2363,9 +2427,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>   
>   	arm_smmu_disable_ats(master);
>   
> -	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_del(&master->domain_head);
> -	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	arm_smmu_installed_smmus_remove_device(smmu_domain, master);
>   
>   	master->domain = NULL;
>   	master->ats_enabled = false;
> @@ -2385,7 +2447,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>   static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   {
>   	int ret = 0;
> -	unsigned long flags;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct arm_smmu_device *smmu;
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> @@ -2435,9 +2496,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>   		master->ats_enabled = arm_smmu_ats_supported(master);
>   
> -	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_add(&master->domain_head, &smmu_domain->devices);
> -	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	ret = arm_smmu_installed_smmus_add_device(smmu_domain, master);
> +	if (ret) {
> +		master->domain = NULL;
> +		return ret;
> +	}
>   
>   	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>   		if (!master->cd_table.cdtab) {
> @@ -2467,9 +2530,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	return 0;
>   
>   out_list_del:
> -	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_del(&master->domain_head);
> -	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +	arm_smmu_installed_smmus_remove_device(smmu_domain, master);
>   
>   	return ret;
>   }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 83d2790b701e7..a9202d2045537 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -690,12 +690,20 @@ struct arm_smmu_stream {
>   	struct rb_node			node;
>   };
>   
> +/* List of smmu devices that a domain is installed to */
> +struct arm_smmu_installed_smmu {
> +	struct list_head	list;
> +	/* List of masters that the domain is attached to*/
> +	struct list_head	devices;
> +	struct arm_smmu_device	*smmu;
> +};
> +
>   /* SMMU private data for each master */
>   struct arm_smmu_master {
>   	struct arm_smmu_device		*smmu;
>   	struct device			*dev;
>   	struct arm_smmu_domain		*domain;
> -	struct list_head		domain_head;
> +	struct list_head		list;
>   	struct arm_smmu_stream		*streams;
>   	/* Locked by the iommu core using the group mutex */
>   	struct arm_smmu_ctx_desc_cfg	cd_table;
> @@ -731,8 +739,8 @@ struct arm_smmu_domain {
>   
>   	struct iommu_domain		domain;
>   
> -	struct list_head		devices;
> -	spinlock_t			devices_lock;
> +	struct list_head		installed_smmus;
> +	spinlock_t			installed_smmus_lock;
>   
>   	struct list_head		mmu_notifiers;
>   };
