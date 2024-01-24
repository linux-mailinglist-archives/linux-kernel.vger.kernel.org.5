Return-Path: <linux-kernel+bounces-36955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3083A977
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6341C21A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCB63407;
	Wed, 24 Jan 2024 12:17:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F360DD1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098668; cv=none; b=NWsqKVoA8Y7H9gy7Z7ebXiiCkcOlcRoplZ0fAA8X3o4wOzaaBAuvvKwzPA19RCmSAiwHb3e3qX3lTzp7iAFRylGOMNqQbSi+lweHqk2mzAozzPeYax553ioBLpUNNDIcUJCLpRFagqDmbu36ennB4/wq1/CwnZ6oqzMlrVih4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098668; c=relaxed/simple;
	bh=7ik0T6h7iohciMw8WCAm0dXcdceLY6GB4Rx+mKnSQUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g400jpP/SNg78/nOC+bnvomspnC775DSzBuTNDkH1+zIZ8A0NN5kaa4TD4triBG0m4uEJfhmwrNvqEkb6v3yEH2IifwIIDfivwWaNCtUOjEbUivpjuvwVEtGlYEd6BkmHxygl6etAziLg1Ko2jeiiIPFWFHy+q/FuYIhdN6eV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E644A1FB;
	Wed, 24 Jan 2024 04:18:30 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E96873F5A1;
	Wed, 24 Jan 2024 04:17:44 -0800 (PST)
Message-ID: <10c1980a-df07-4f69-93e5-c1c50b106a13@arm.com>
Date: Wed, 24 Jan 2024 12:17:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a threshold to avoid potential
 soft lockup
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>, "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc: will@kernel.org, joro@8bytes.org, nicolinc@nvidia.com,
 mshavit@google.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240115114040.6279-1-zhangzekun11@huawei.com>
 <20240115153152.GA50608@ziepe.ca>
 <e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com>
 <20240118142243.GI50608@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240118142243.GI50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/01/2024 2:22 pm, Jason Gunthorpe wrote:
> On Thu, Jan 18, 2024 at 07:21:10PM +0800, zhangzekun (A) wrote:
>>> What is the rest of the call chain? How did you get into such a large
>>> invalidation?
>> we are doing some test with qemu virtual machines. The testing platform has
>> 96 cores and 960GB memories. It will enable 64 virtual machines and every
>> virtual machine will cost 8G memories. When batching closing these 64
>> virtaul machine concurrently, we will get soft lockup.
>>
>>   WARN: soft lockup - CPU#18 stuck for 11s! [worker:3219]
>> ....
>> Call trace:
>>   dump_backtrace+0x0/0x200
>>   show_stack+0x20/0x30
>>   dump_stack+0xf0/0x138
>>   watchdog_print_info+0x48/0x54
>>   watchdog_process_before_softlockup+0x9c/0xa0
>>   watchdog_timer_fn+0x1ac/0x2f0
>>   __run_hrtimer+0x98/0x2b4
>>   __hrtimer_run_queues+0xc0/0x13c
>>   hrtimer_interrupt+0x150/0x3e4
>>   arch_timer_handler_phys+0x3c/0x50
>>   handle_percpu_devid_irq+0x90/0x1f4
>>   __handle_domain_irq+0x84/0xfc
>>   gic_handle_irq+0x88/0x2b0
>>   el1_irq+0xb8/0x140
>>   ktime_get+0x3c/0xac
>>   arm_smmu_cmdq_poll_until_not_full+0xb0/0x1a0
>>   arm_smmu_cmdq_issue_cmdlist+0x194/0x5f4
>>   __arm_smmu_tlb_inv_range+0x114/0x22c
>>   arm_smmu_tlb_inv_walk+0x88/0x120
>>   __arm_lpae_unmap+0x188/0x2c0
>>   __arm_lpae_unmap+0x104/0x2c0
>>   arm_lpae_unmap+0x68/0x80
>>   arm_smmu_unmap+0x24/0x40
>>   __iommu_unmap+0xd8/0x210
>>   iommu_unmap_fast+0x18/0x24
>>   unmap_unpin_fast+0x7c/0x140 [vfio_iommu_type1]
>>   vfio_unmap_unpin+0x14c/0x3ac [vfio_iommu_type1]
>>   vfio_remove_dma+0x38/0x124 [vfio_iommu_type1]
>>   vfio_iommu_type1_detach_group+0x4b8/0x4e0 [vfio_iommu_type1]
>>   __vfio_group_unset_container+0x58/0x18c [vfio]
>>   vfio_group_try_dissolve_container+0x80/0x94 [vfio]
>>   vfio_group_put_external_user+0x20/0x54 [vfio]
>>   kvm_vfio_destroy+0xa8/0x12c
>>   kvm_destroy_vm+0x20c/0x300
>>   kvm_put_kvm+0x74/0xa0
>>   kvm_vcpu_release+0x20/0x30
>>   __fput+0xc4/0x270
>>   ____fput+0x18/0x24
>>   task_work_run+0xd0/0x1a0
>>   do_exit+0x1d8/0x480
>>   do_group_exit+0x40/0x130
>>   get_signal+0x1f8/0x744
>>   do_signal+0x98/0x204
>>   do_notify_resume+0x15c/0x1e0
>>   work_pending+0xc/0xa4
> 
> I see, that is interesting.
> 
> I think iommufd is close to substantialy improving this. It already
> has the domain destruction ordering:
>   - Remove all domain attachments
>   - Read back phys addrs, unmap and unpin
>   - iommu_domain_free()

I don't think the story here has changed from when I first remember this 
being discussed probably 7 or 8 years ago - what VFIO has always really 
wanted for this situation is to know when it's doing a complete teardown 
and just detach and free the domain, then unpin the pages afterwards, 
without wasting any time at all on frivolous unmapping. However so far 
it's worked out that minor low-level tweaks like the unmap_fast API have 
kept kept the overhead tolerable enough that nobody's been inspired to 
attempt the bigger task.

However for SMMU in particular it's almost certainly confounded by 
io_pgtable_tlb_flush_walk() being a bit rubbish for the situation that I 
bet is happening here - if we don't have range invalidate, then 
pessimistically invalidating a 1GB table at 4KB granularity without even 
looking isn't likely to save much time over doing a more accurate 
recursive invalidation even in the worst case that the whole thing 
*does* turn out to be mapped as pages. But in the likely case that there 
are at least some intermediate-level block mappings in there, it's an 
instant win. I recall I had along-standing to-do item to get rid of 
tlb_flush_walk from io-pgtable altogether, although that may have been 
tied in to the freelist stuff; I'd need to find time to page it all back 
in to remember exactly why...

Thanks,
Robin.

> Currently smmu continues to issue ASID invalidations for the domain
> even though there no references to it. However this is pretty
> pointless here as we are going to free the ASID right away.
> 
> I'm going to make a series to allow smmu to support multi-instances on
> a single domain. In this case when the domain looses all its
> attachments it looses all its instances too and it won't have to do
> *anything* for invalidation in this workflow.
> 
> Ie your flow will boil down to a single ASID invalidation once the
> domain attachments are all removed, then on invalidations during unmap
> and no invaludation at free. This would be a significantly faster
> teardown I suspect.
> 
>> Thanks for your patch, the patch described below make sense to me. After
>> spliting TLB invalidate operations according to domain stage,
>> arm_smmu_tlb_inv_*_s1() can be used both in SVA codes and original smmu
>> codes, and can implement arm_smmu_tlb_inv_all_s1() just using
>> arm_smmu_tlb_inv_range_s1() by passing a special size. But the current
>> smmu-v3 driver has not move "asid" into "struct smmu_domain", we still need
>> to pass the exact asid from SVA.
> 
> Yes, it is not intended to be applied on the current kernel, there are
> a lot of structural problems with how SVA works there..
> 
> Jason

