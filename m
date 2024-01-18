Return-Path: <linux-kernel+bounces-30048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3383185B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F26E2854FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F2F241E6;
	Thu, 18 Jan 2024 11:21:20 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F27200DA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576879; cv=none; b=b45yDP8mBQBqN7ZXbwcjXbMYgEWuhpFI5qk/iWFce6foNDNbxzj8dqtnof2NwuNEOfEr4vFs4VZ9bgE3uljzwBys33HasnwUXV0Y98spP/Du9wnp8WpNlRxviRSyXYwFlVdAZT4QvMf9WnerP41tFJTDolxpwmhlgofai0AtNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576879; c=relaxed/simple;
	bh=bVoU7O+uKsasNyPlrV3QC6NCUVEsmNtLSAAdaktX984=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=XoKP9s9wQ9bvkCrXgPUXqFk5uZJ+I2VBv6Jgx0krp1iWPtxmJetJJAUO1I+hpM95NtXYoGek26qC2jBlLVfpLVz3yfAeq3/DzykKG2Rt5InD1ZkGelwj5fn9KgMuTVe/9i/+ylgj/q4nYu2g0+RvEpouGMVzi/hcqs66ZK+qayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TG0f93v1PzsW4T;
	Thu, 18 Jan 2024 19:20:17 +0800 (CST)
Received: from kwepemd100006.china.huawei.com (unknown [7.221.188.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 87D4918005B;
	Thu, 18 Jan 2024 19:21:12 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemd100006.china.huawei.com (7.221.188.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 18 Jan 2024 19:21:11 +0800
Message-ID: <e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com>
Date: Thu, 18 Jan 2024 19:21:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a threshold to avoid potential
 soft lockup
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240115114040.6279-1-zhangzekun11@huawei.com>
 <20240115153152.GA50608@ziepe.ca>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <20240115153152.GA50608@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100006.china.huawei.com (7.221.188.47)



在 2024/1/15 23:31, Jason Gunthorpe 写道:
> On Mon, Jan 15, 2024 at 07:40:40PM +0800, Zhang Zekun wrote:
>> The commit d5afb4b47e13 ("iommu/arm-smmu-v3: Fix soft lockup triggered
>> by arm_smmu_mm_invalidate_range") has fix a soft lockup problem when
>> running SVA case, but code paths from iommu_unmap and dma APIs still
>> remain unfixed which could also cause potential soft lockup.
>>
>> When cmdq is quite busy and don't have much space for batch submitting
>> cmds, and size passed to __arm_smmu_tlb_inv_range() is large (1G in this
>> case), the following softlockup is triggered.
>>
>> WARN: soft lockup - CPU#71 stuck for 12s! [qemu-kvm:1303]
>> ...
>> Call trace:
>>   dump_backtrace+0x0/0x200
>>   show_stack+0x20/0x30
>>   dump_stack+0xf0/0x138
>>   watchdog_print_info+0x48/0x54
>>   watchdog_process_before_softlockup+0x9c/0xa0
>>   watchdog_timer_fn+0x1ac/0x2f0
>>   __run_hrtimer+0x98/0x2b4
>>   __hrtimer_run_queues+0xc0/0x13c
>>   hrtimer_interrupt+0x150/0x3e4
>>   arch_timer_handler_phys+0x3c/0x50
>>   handle_percpu_devid_irq+0x90/0x1f4
>>   __handle_domain_irq+0x84/0xfc
>>   gic_handle_irq+0x88/0x2b0
>>   el1_irq+0xb8/0x140
>>   arm_smmu_cmdq_issue_cmdlist+0x184/0x5f4
>>   __arm_smmu_tlb_inv_range+0x114/0x22c
>>   arm_smmu_tlb_inv_walk+0x88/0x120
>>   __arm_lpae_unmap+0x188/0x2c0
>>   __arm_lpae_unmap+0x104/0x2c0
>>   arm_lpae_unmap+0x68/0x80
>>   arm_smmu_unmap+0x24/0x40
>>   __iommu_unmap+0xd8/0x210
>>   iommu_unmap+0x44/0x9c
>> ...
> What is the rest of the call chain? How did you get into such a large
> invalidation?
we are doing some test with qemu virtual machines. The testing platform 
has 96 cores and 960GB memories. It will enable 64 virtual machines and 
every virtual machine will cost 8G memories. When batching closing these 
64 virtaul machine concurrently, we will get soft lockup.

  WARN: soft lockup - CPU#18 stuck for 11s! [worker:3219]
...
Call trace:
  dump_backtrace+0x0/0x200
  show_stack+0x20/0x30
  dump_stack+0xf0/0x138
  watchdog_print_info+0x48/0x54
  watchdog_process_before_softlockup+0x9c/0xa0
  watchdog_timer_fn+0x1ac/0x2f0
  __run_hrtimer+0x98/0x2b4
  __hrtimer_run_queues+0xc0/0x13c
  hrtimer_interrupt+0x150/0x3e4
  arch_timer_handler_phys+0x3c/0x50
  handle_percpu_devid_irq+0x90/0x1f4
  __handle_domain_irq+0x84/0xfc
  gic_handle_irq+0x88/0x2b0
  el1_irq+0xb8/0x140
  ktime_get+0x3c/0xac
  arm_smmu_cmdq_poll_until_not_full+0xb0/0x1a0
  arm_smmu_cmdq_issue_cmdlist+0x194/0x5f4
  __arm_smmu_tlb_inv_range+0x114/0x22c
  arm_smmu_tlb_inv_walk+0x88/0x120
  __arm_lpae_unmap+0x188/0x2c0
  __arm_lpae_unmap+0x104/0x2c0
  arm_lpae_unmap+0x68/0x80
  arm_smmu_unmap+0x24/0x40
  __iommu_unmap+0xd8/0x210
  iommu_unmap_fast+0x18/0x24
  unmap_unpin_fast+0x7c/0x140 [vfio_iommu_type1]
  vfio_unmap_unpin+0x14c/0x3ac [vfio_iommu_type1]
  vfio_remove_dma+0x38/0x124 [vfio_iommu_type1]
  vfio_iommu_type1_detach_group+0x4b8/0x4e0 [vfio_iommu_type1]
  __vfio_group_unset_container+0x58/0x18c [vfio]
  vfio_group_try_dissolve_container+0x80/0x94 [vfio]
  vfio_group_put_external_user+0x20/0x54 [vfio]
  kvm_vfio_destroy+0xa8/0x12c
  kvm_destroy_vm+0x20c/0x300
  kvm_put_kvm+0x74/0xa0
  kvm_vcpu_release+0x20/0x30
  __fput+0xc4/0x270
  ____fput+0x18/0x24
  task_work_run+0xd0/0x1a0
  do_exit+0x1d8/0x480
  do_group_exit+0x40/0x130
  get_signal+0x1f8/0x744
  do_signal+0x98/0x204
  do_notify_resume+0x15c/0x1e0
  work_pending+0xc/0xa4
>> @@ -228,7 +219,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>>   	 */
>>   	size = end - start;
>>   	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
>> -		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
>> +		if (size >= CMDQ_MAX_TLBI_OPS(PAGE_SIZE) * PAGE_SIZE)
>>   			size = 0;
>>   	} else {
>>   		if (size == ULONG_MAX)
> I would like to see the SVA code rely on the common invalidation
> infrastructure, this should be pushed down into the invalidation logic
> not be in the SVA code. With some adjustments we can get common
> functions for all this and push the decision making into the actual
> function.
Thanks for your patch, the patch described below make sense to me. After 
spliting TLB invalidate operations according to domain stage, 
arm_smmu_tlb_inv_*_s1() can be used both in SVA codes and original smmu 
codes, and can implement arm_smmu_tlb_inv_all_s1() just using 
arm_smmu_tlb_inv_range_s1() by passing a special size. But the current 
smmu-v3 driver has not move "asid" into "struct smmu_domain", we still 
need to pass the exact asid from SVA.
>
> Something like this, on top of my "part 3" branch
> https://github.com/jgunthorpe/linux/commits/smmuv3_newapi/
> split into more patches:
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 5ab976f6b108dd..b30cce97b01d06 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -30,7 +30,6 @@ static int arm_smmu_realloc_s1_domain_asid(struct arm_smmu_device *smmu,
>   					   struct arm_smmu_domain *smmu_domain)
>   {
>   	struct arm_smmu_master_domain *master_domain;
> -	u32 old_asid = smmu_domain->asid;
>   	struct arm_smmu_cd target_cd;
>   	unsigned long flags;
>   	int ret;
> @@ -68,9 +67,6 @@ static int arm_smmu_realloc_s1_domain_asid(struct arm_smmu_device *smmu,
>   					&target_cd);
>   	}
>   	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> -
> -	/* Clean the ASID we are about to assign to a new translation */
> -	arm_smmu_tlb_inv_asid(smmu, old_asid);
>   	return 0;
>   }
>   
> @@ -175,24 +171,12 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>   	 * range. So do a simple translation here by calculating size correctly.
>   	 */
>   	size = end - start;
> -	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
> -		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
> -			size = 0;
> -	} else {
> -		if (size == ULONG_MAX)
> -			size = 0;
> -	}
> +	if (size == ULONG_MAX)
> +		size = 0;
>   
> -	if (!smmu_domain->btm_invalidation) {
> -		ioasid_t asid = READ_ONCE(smmu_domain->asid);
> -
> -		if (!size)
> -			arm_smmu_tlb_inv_asid(smmu_domain->smmu, asid);
> -		else
> -			arm_smmu_tlb_inv_range_asid(start, size, asid,
> -						    PAGE_SIZE, false,
> -						    smmu_domain);
> -	}
> +	if (!smmu_domain->btm_invalidation)
> +		arm_smmu_tlb_inv_range_s1(start, size, PAGE_SIZE, false,
> +					  smmu_domain);
>   
>   	arm_smmu_atc_inv_domain(smmu_domain, start, size);
>   }
> @@ -228,7 +212,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	}
>   	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>   
> -	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->asid);
> +	arm_smmu_tlb_inv_all_s1(smmu_domain);
>   	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
>   }
>   
> @@ -506,6 +490,8 @@ static int arm_smmu_share_asid(struct arm_smmu_device *smmu,
>   		ret = arm_smmu_realloc_s1_domain_asid(smmu, old_s1_domain);
>   		if (ret)
>   			goto out_restore_s1;
> +		/* Clean the ASID since it was just recovered */
> +		arm_smmu_tlb_inv_all_s1(smmu_domain);
>   	}
>   
>   	smmu_domain->btm_invalidation = true;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b07e0692eb78ea..79c85791b0c3d5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -90,6 +90,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
>   static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>   				    struct arm_smmu_device *smmu);
>   static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> +static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain *smmu_domain);
>   
>   static void parse_driver_options(struct arm_smmu_device *smmu)
>   {
> @@ -965,17 +966,6 @@ static int arm_smmu_page_response(struct device *dev,
>   }
>   
>   /* Context descriptor manipulation functions */
> -void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
> -{
> -	struct arm_smmu_cmdq_ent cmd = {
> -		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> -			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
> -		.tlbi.asid = asid,
> -	};
> -
> -	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> -}
> -
>   #define NUM_ENTRY_QWORDS                                                \
>   	(max(sizeof(struct arm_smmu_ste), sizeof(struct arm_smmu_cd)) / \
>   	 sizeof(u64))
> @@ -2106,8 +2096,6 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>   static void arm_smmu_tlb_inv_context(void *cookie)
>   {
>   	struct arm_smmu_domain *smmu_domain = cookie;
> -	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	struct arm_smmu_cmdq_ent cmd;
>   
>   	/*
>   	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
> @@ -2116,13 +2104,10 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>   	 * insertion to guarantee those are observed before the TLBI. Do be
>   	 * careful, 007.
>   	 */
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		arm_smmu_tlb_inv_asid(smmu, READ_ONCE(smmu_domain->asid));
> -	} else {
> -		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> -		cmd.tlbi.vmid	= smmu_domain->vmid;
> -		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> -	}
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> +		arm_smmu_tlb_inv_all_s1(smmu_domain);
> +	else
> +		arm_smmu_tlb_inv_all_s2(smmu_domain);
>   	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
>   }
>   
> @@ -2197,47 +2182,69 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>   	arm_smmu_cmdq_batch_submit(smmu, &cmds);
>   }
>   
> -static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
> -					  size_t granule, bool leaf,
> -					  struct arm_smmu_domain *smmu_domain)
> +static bool arm_smmu_inv_range_too_big(struct arm_smmu_device *smmu,
> +				       size_t size, size_t granule)
>   {
> -	struct arm_smmu_cmdq_ent cmd = {
> -		.tlbi = {
> -			.leaf	= leaf,
> -		},
> -	};
> +	unsigned max_ops;
>   
> -	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
> -				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
> -		cmd.tlbi.asid	= smmu_domain->asid;
> -	} else {
> -		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
> -		cmd.tlbi.vmid	= smmu_domain->vmid;
> -	}
> -	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
> +	/* 0 size means invalidate all */
> +	if (!size || size == SIZE_MAX)
> +		return true;
>   
> -	/*
> -	 * Unfortunately, this can't be leaf-only since we may have
> -	 * zapped an entire table.
> -	 */
> -	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
> +	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV)
> +		return false;
> +
> +	max_ops = 1 << (ilog2(granule) - 3);
> +	return size >= max_ops * granule;
>   }
>   
> -void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
> -				 size_t granule, bool leaf,
> -				 struct arm_smmu_domain *smmu_domain)
> +void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size, size_t granule,
> +			       bool leaf, struct arm_smmu_domain *smmu_domain)
>   {
>   	struct arm_smmu_cmdq_ent cmd = {
>   		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
>   			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
>   		.tlbi = {
> -			.asid	= asid,
> +			.asid	= READ_ONCE(smmu_domain->asid),
>   			.leaf	= leaf,
>   		},
>   	};
>   
> -	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
> +	if (arm_smmu_inv_range_too_big(smmu_domain->smmu, size, granule)) {
> +		cmd.opcode = smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
> +				     CMDQ_OP_TLBI_EL2_ASID :
> +				     CMDQ_OP_TLBI_NH_ASID,
> +		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
> +	} else{
> +		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
> +					 smmu_domain);
> +	}
> +}
> +
> +static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
> +				      size_t granule, bool leaf,
> +				      struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.opcode	= CMDQ_OP_TLBI_S2_IPA,
> +		.tlbi = {
> +			.vmid	= smmu_domain->vmid,
> +			.leaf	= leaf,
> +		},
> +	};
> +
> +	if (arm_smmu_inv_range_too_big(smmu_domain->smmu, size, granule)) {
> +		cmd.opcode = CMDQ_OP_TLBI_S12_VMALL;
> +		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
> +	} else {
> +		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
> +					 smmu_domain);
> +	}
> +}
> +
> +static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain *smmu_domain)
> +{
> +	arm_smmu_tlb_inv_range_s2(0, 0, PAGE_SIZE, false, smmu_domain);
>   }
>   
>   static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
> @@ -2253,7 +2260,15 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
>   static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
>   				  size_t granule, void *cookie)
>   {
> -	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
> +	struct arm_smmu_domain *smmu_domain = cookie;
> +
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> +		arm_smmu_tlb_inv_range_s1(iova, size, granule, false,
> +					  smmu_domain);
> +	else
> +		arm_smmu_tlb_inv_range_s2(iova, size, granule, false,
> +					  smmu_domain);
> +	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
>   }
>   
>   static const struct iommu_flush_ops arm_smmu_flush_ops = {
> @@ -2379,7 +2394,7 @@ void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain)
>   	if ((smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
>   	     smmu_domain->domain.type == IOMMU_DOMAIN_SVA) &&
>   	    smmu_domain->asid) {
> -		arm_smmu_tlb_inv_asid(smmu, smmu_domain->asid);
> +		arm_smmu_tlb_inv_all_s1(smmu_domain);
>   
>   		/* Prevent SVA from touching the CD while we're freeing it */
>   		mutex_lock(&smmu->asid_lock);
> @@ -3183,13 +3198,23 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
>   				struct iommu_iotlb_gather *gather)
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	size_t size = gather->end - gather->start + 1;
>   
>   	if (!gather->pgsize)
>   		return;
>   
> -	arm_smmu_tlb_inv_range_domain(gather->start,
> -				      gather->end - gather->start + 1,
> -				      gather->pgsize, true, smmu_domain);
> +	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> +		arm_smmu_tlb_inv_range_s1(gather->start, size, gather->pgsize,
> +					  true, smmu_domain);
> +	else
> +		arm_smmu_tlb_inv_range_s2(gather->start, size, gather->pgsize,
> +					  true, smmu_domain);
> +
> +	/*
> +	 * Unfortunately, this can't be leaf-only since we may have
> +	 * zapped an entire table.
> +	 */
> +	arm_smmu_atc_inv_domain(smmu_domain, gather->start, size);
>   }
>   
>   static phys_addr_t
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index d65c716d4fc04f..9f5537ef97caff 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -834,10 +834,13 @@ void arm_smmu_remove_pasid(struct arm_smmu_master *master,
>   int arm_smmu_domain_alloc_id(struct arm_smmu_device *smmu,
>   			     struct arm_smmu_domain *smmu_domain);
>   void arm_smmu_domain_free_id(struct arm_smmu_domain *smmu_domain);
> -void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
> -void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
> -				 size_t granule, bool leaf,
> -				 struct arm_smmu_domain *smmu_domain);
> +void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size, size_t granule,
> +			       bool leaf, struct arm_smmu_domain *smmu_domain);
> +static inline void arm_smmu_tlb_inv_all_s1(struct arm_smmu_domain *smmu_domain)
> +{
> +	arm_smmu_tlb_inv_range_s1(0, 0, PAGE_SIZE, false, smmu_domain);
> +}
> +
>   int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>   			    unsigned long iova, size_t size);
>   


