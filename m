Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F379270F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjIEQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbjIEBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604DCC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:44:26 -0700 (PDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Yygd7IDMNkWpX-ihH3Rs3w-1; Mon, 04 Sep 2023 21:44:24 -0400
X-MC-Unique: Yygd7IDMNkWpX-ihH3Rs3w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-56f75e70190so1522861a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 18:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878263; x=1694483063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQW2KndfwtP2I1AjKed8tFR+5QRfGki+EjdaWAewRO8=;
        b=T2+iW4BhsgAEh3BVvsrdgLt4ttsxIBYdg5cGd2z0R9WhC3aFx/3kZ8DYJT5axj+1Fx
         5ZCsA/H8v80PHVo9MkwxyMoL4gleCEEsr2vNbvvpqTn34vfE+77VsPwA2cbHROPCl5am
         oYbh89eBXUvGXA7Njkucma1SczlOaYgefHomDV5Xzd6y4zUte4c8vPk8qBUCtK7aLQM8
         ekuH9doabjSqXBoPIYDCw2Wf57AFLmfcjLBGrU5os+/VQUHFtC4roxt2zmBRsOSuAdM7
         w9u4vzdgSnNJr6guNsTh5HNGCU8x3tk9VYmy48++9ROH3KtxEdExvQJAkCcSkBRhSLIs
         zGqQ==
X-Gm-Message-State: AOJu0YzhVlYTSOfIv8/fjwqQn8RExurDvANWudNwRun1aZqIqrYdQ0wG
        9S13QA1rKM6Ws2Dw5g6D0gLnq2llJy0DwknkbSyIz+S1Lbe3xOZQyVuEFKTgdyzI+19EHUaNTVt
        nEw3qMBjda1eXNLq+yedNaPkI
X-Received: by 2002:a17:903:1109:b0:1bb:d280:5e0b with SMTP id n9-20020a170903110900b001bbd2805e0bmr10398660plh.18.1693878262915;
        Mon, 04 Sep 2023 18:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEKZzcW+A3cuAAhqNgpfv304pASYRfHBd9EplUbPImawEVwKwMcSnY/3qBgX8KadUCJk/fqg==
X-Received: by 2002:a17:903:1109:b0:1bb:d280:5e0b with SMTP id n9-20020a170903110900b001bbd2805e0bmr10398637plh.18.1693878262482;
        Mon, 04 Sep 2023 18:44:22 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001adf6b21c77sm8126024pld.107.2023.09.04.18.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 18:44:22 -0700 (PDT)
Message-ID: <726d291b-ba18-da36-088d-0f0f2ea5a8b4@redhat.com>
Date:   Tue, 5 Sep 2023 11:44:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] KVM: arm64: Fix soft-lockup on relaxing PTE permission
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, qperret@google.com,
        ricarkol@google.com, tabba@google.com, bgardon@google.com,
        zhenyzha@redhat.com, yihyu@redhat.com, shan.gavin@gmail.com
References: <20230904072826.1468907-1-gshan@redhat.com>
 <86r0nee4a9.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <86r0nee4a9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 9/4/23 18:22, Marc Zyngier wrote:
> On Mon, 04 Sep 2023 08:28:26 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> We observed soft-lockup on the host in a specific scenario where
>> the host on Ampere's Altra Max CPU has 64KB base page size and the
>> guest has 4KB base page size, 64 vCPUs and 13GB memory. The guest's
>> memory is backed by 512MB huge pages via hugetlbfs. All the 64 vCPUs
>> are simultaneously trapped into the host due to permission page faults,
>> to request adding the execution permission to the corresponding PMD
>> entry, before the soft-lockup is raised on the host. On handling the
>> parallel requests, the instruction cache for the 512MB huge page is
>> invalidated by mm_ops->icache_inval_pou() in stage2_attr_walker() on
>> 64 hardware CPUs. Unfortunately, the instruction cache invalidation
>> on one CPU interfere with that on another CPU in the hardware level.
>> It takes 37 seconds for mm_ops->icache_inval_pou() to finish in the
>> worst case.
> 
> What really annoys me is that we keep piling all sort of hacks just to
> paper over the fact that this HW is absolutely terrible (cue Russell's
> text replication patches). Why stick so many CPUs in a single system
> if the interconnect is unable to scale?
> 
> We already have added non-shareable invalidation to cope with similar
> issues, and this is only adding insult to injury. What does Ampere
> say about this?
> 

Could you please provide a linker to Russell's text replication patches?
Another intention of posting this patch is to seek Ampere folks' advices.
Maybe it's a known issue to them.

>>
>> So we can't scale out to handle the permission faults at will.
> 
> The *HW* cannot scale. Bad HW.
> 

Ok.

>> They
>> need to be serialized to some extent with the help of a interval tree,
>> to track IPA ranges, currently under service. For the incoming permission
>> faults, the vCPU is asked to bail for a retry if its IPA range is being
>> served since the vCPU can't proceed its execution.
>>
>> Fixes: 1577cb5823ce ("KVM: arm64: Handle stage-2 faults in parallel")
>> Cc: stable@vger.kernel.org # v6.2+
> 
> Please drop these two tags. There is no correctness problem in what
> you describe, only HW that does not scale.
> 

Ok.

>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_host.h     |  4 ++
>>   arch/arm64/include/asm/kvm_pgtable.h  |  3 +-
>>   arch/arm64/kvm/hyp/nvhe/mem_protect.c |  4 +-
>>   arch/arm64/kvm/hyp/pgtable.c          | 25 +++++++++---
>>   arch/arm64/kvm/mmu.c                  | 55 ++++++++++++++++++++++++++-
>>   5 files changed, 83 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index d3dd05bbfe23..a457720b5caf 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -175,6 +175,10 @@ struct kvm_s2_mmu {
>>   	struct kvm_mmu_memory_cache split_page_cache;
>>   	uint64_t split_page_chunk_size;
>>   
>> +	/* Page fault ranges */
>> +	struct mutex		fault_ranges_mutex;
>> +	struct rb_root_cached	fault_ranges;
>> +
> 
> How is that going to work for NV, where we have multiple concurrent
> IPA spaces for the same VM, each with its own stage-2?
> 
> And this begs another question: what happens when *another* VM does
> the same thing? If the HW gets wedged by concurrent vcpus in the same
> VM, it may get just as wedged by a concurrent VM...
> 
> What happens if the vcpus perform icache invalidation *in the guest*?
> 

Right, I forgot the NV case when the patch was posted. Frankly, I'm still
learning the spec to understand how NV is working. I spent some time on
the NV patches, posted a while ago. If I understood the code correctly,
those multiple concurent IPA spaces (struct kvm_s2_mmu) are multiplexed to
create the shadow stage-2 page table. Since the fault ranges and the serialization
imposed by it is only sensible to host hypervisor, I don't think it's going
to work for the NV case.

   https://lore.kernel.org/kvmarm/20230515173103.1017669-28-maz@kernel.org/

>>   	struct kvm_arch *arch;
>>   };
>>   
>> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
>> index 929d355eae0a..dca0bf81616f 100644
>> --- a/arch/arm64/include/asm/kvm_pgtable.h
>> +++ b/arch/arm64/include/asm/kvm_pgtable.h
>> @@ -149,7 +149,8 @@ struct kvm_pgtable_mm_ops {
>>   	void*		(*phys_to_virt)(phys_addr_t phys);
>>   	phys_addr_t	(*virt_to_phys)(void *addr);
>>   	void		(*dcache_clean_inval_poc)(void *addr, size_t size);
>> -	void		(*icache_inval_pou)(void *addr, size_t size);
>> +	int		(*icache_inval_pou)(struct kvm_s2_mmu *mmu,
>> +					    void *addr, u64 ipa, size_t size);
>>   };
>>   
>>   /**
>> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
>> index 9d703441278b..9bbe7c641770 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
>> @@ -223,10 +223,12 @@ static void clean_dcache_guest_page(void *va, size_t size)
>>   	hyp_fixmap_unmap();
>>   }
>>   
>> -static void invalidate_icache_guest_page(void *va, size_t size)
>> +static int invalidate_icache_guest_page(struct kvm_s2_mmu *mmu,
>> +					void *va, u64 ipa, size_t size)
>>   {
>>   	__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
>>   	hyp_fixmap_unmap();
>> +	return 0;
>>   }
>>   
>>   int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index f7a93ef29250..fabfdb4d1e00 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -875,6 +875,7 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
>>   	u64 granule = kvm_granule_size(ctx->level);
>>   	struct kvm_pgtable *pgt = data->mmu->pgt;
>>   	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
>> +	int ret;
>>   
>>   	if (!stage2_leaf_mapping_allowed(ctx, data))
>>   		return -E2BIG;
>> @@ -903,8 +904,14 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
>>   					       granule);
>>   
>>   	if (!kvm_pgtable_walk_skip_cmo(ctx) && mm_ops->icache_inval_pou &&
>> -	    stage2_pte_executable(new))
>> -		mm_ops->icache_inval_pou(kvm_pte_follow(new, mm_ops), granule);
>> +	    stage2_pte_executable(new)) {
>> +		ret = mm_ops->icache_inval_pou(data->mmu,
>> +					       kvm_pte_follow(new, mm_ops),
>> +					       ALIGN_DOWN(ctx->addr, granule),
>> +					       granule);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	stage2_make_pte(ctx, new);
>>   
>> @@ -1101,6 +1108,7 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
>>   }
>>   
>>   struct stage2_attr_data {
>> +	struct kvm_s2_mmu		*mmu;
>>   	kvm_pte_t			attr_set;
>>   	kvm_pte_t			attr_clr;
>>   	kvm_pte_t			pte;
>> @@ -1113,6 +1121,8 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
>>   	kvm_pte_t pte = ctx->old;
>>   	struct stage2_attr_data *data = ctx->arg;
>>   	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
>> +	u64 granule = kvm_granule_size(ctx->level);
>> +	int ret;
>>   
>>   	if (!kvm_pte_valid(ctx->old))
>>   		return -EAGAIN;
>> @@ -1133,9 +1143,13 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
>>   		 * stage-2 PTE if we are going to add executable permission.
>>   		 */
>>   		if (mm_ops->icache_inval_pou &&
>> -		    stage2_pte_executable(pte) && !stage2_pte_executable(ctx->old))
>> -			mm_ops->icache_inval_pou(kvm_pte_follow(pte, mm_ops),
>> -						  kvm_granule_size(ctx->level));
>> +		    stage2_pte_executable(pte) && !stage2_pte_executable(ctx->old)) {
>> +			ret = mm_ops->icache_inval_pou(data->mmu,
>> +					kvm_pte_follow(pte, mm_ops),
>> +					ALIGN_DOWN(ctx->addr, granule), granule);
>> +			if (ret)
>> +				return ret;
>> +		}
>>   
>>   		if (!stage2_try_set_pte(ctx, pte))
>>   			return -EAGAIN;
>> @@ -1152,6 +1166,7 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
>>   	int ret;
>>   	kvm_pte_t attr_mask = KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI;
>>   	struct stage2_attr_data data = {
>> +		.mmu		= pgt->mmu,
>>   		.attr_set	= attr_set & attr_mask,
>>   		.attr_clr	= attr_clr & attr_mask,
>>   	};
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index d3b4feed460c..a778f48beb56 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -267,9 +267,58 @@ static void clean_dcache_guest_page(void *va, size_t size)
>>   	__clean_dcache_guest_page(va, size);
>>   }
>>   
>> -static void invalidate_icache_guest_page(void *va, size_t size)
>> +static struct interval_tree_node *add_fault_range(struct kvm_s2_mmu *mmu,
>> +						  u64 ipa, size_t size)
>>   {
>> +	struct interval_tree_node *node;
>> +	unsigned long start = ipa, end = start + size - 1; /* inclusive */
> 
> Maybe just rename 'ipa' to 'start'?
> 

Yes.

>> +
>> +	mutex_lock(&mmu->fault_ranges_mutex);
> 
> Don't we hold the rwlock at this at this stage, which actively
> prevents things like taking a mutex? Have you tested this with
> lockdep?
> 

The rwlock (kvm->mmu_lock) has been held by readers or writers, depending on
the function call path, and you're right a lockdep issue exists:

[  161.600875] =============================
[  161.604872] [ BUG: Invalid wait context ]
[  161.608870] 6.5.0-gavin+ #11 Not tainted
[  161.612781] -----------------------------
[  161.616778] qemu-system-aar/3598 is trying to lock:
[  161.621644] ffff8000b0947dd0 (&mmu->fault_ranges_mutex){....}-{3:3}, at: invalidate_icache_guest_page+0x48/0x160
[  161.631813] other info that might help us debug this:
[  161.636852] context-{4:4}
[  161.639460] 4 locks held by qemu-system-aar/3598:
[  161.644151]  #0: ffff3fff93b1b1e8 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x88/0xa08
[  161.652494]  #1: ffff8000b0948660 (&kvm->srcu){.+.+}-{0:0}, at: kvm_handle_guest_abort+0xf0/0x4f8
[  161.661357]  #2: ffff8000b0947018 (&(kvm)->mmu_lock){++++}-{2:2}, at: user_mem_abort+0x1b4/0x7d8
[  161.670132]  #3: ffffc23c11b09230 (rcu_read_lock){....}-{1:2}, at: kvm_pgtable_walk+0x114/0x228
[  161.678821] stack backtrace:
[  161.681690] CPU: 133 PID: 3598 Comm: qemu-system-aar Not tainted 6.5.0-gavin+ #11
[  161.689160] Hardware name: FOXCONN Mt. Collins/Mt. Collins, BIOS 0ACOC017 (SCP: 1.08.20210825) 10/22/2021
[  161.698713] Call trace:
[  161.701148]  dump_backtrace+0x9c/0x120
[  161.704886]  show_stack+0x1c/0x30
[  161.708189]  dump_stack_lvl+0xe0/0x168
[  161.711927]  dump_stack+0x14/0x20
[  161.715230]  __lock_acquire+0x828/0x968
[  161.719056]  lock_acquire.part.0+0xec/0x268
[  161.723227]  lock_acquire+0x94/0x150
[  161.726791]  __mutex_lock+0x98/0x830
[  161.730355]  mutex_lock_nested+0x28/0x38
[  161.734266]  invalidate_icache_guest_page+0x48/0x160
[  161.739219]  stage2_map_walker_try_leaf+0x140/0x1e8
[  161.744085]  stage2_map_walker+0xf8/0x1a0
[  161.748082]  kvm_pgtable_visitor_cb.isra.0+0x3c/0x78
[  161.753035]  __kvm_pgtable_visit+0x188/0x268
[  161.757292]  __kvm_pgtable_walk+0x90/0xc8
[  161.761290]  __kvm_pgtable_visit+0xb4/0x268
[  161.765461]  __kvm_pgtable_walk+0x90/0xc8
[  161.769458]  kvm_pgtable_walk+0xd4/0x228
[  161.773369]  kvm_pgtable_stage2_map+0x110/0x130
[  161.777888]  user_mem_abort+0x67c/0x7d8
[  161.781712]  kvm_handle_guest_abort+0x3e4/0x4f8
[  161.786231]  handle_exit+0x70/0x1c8
[  161.789709]  kvm_arch_vcpu_ioctl_run+0x29c/0x668
[  161.794315]  kvm_vcpu_ioctl+0x300/0xa08
[  161.798139]  __arm64_sys_ioctl+0xa8/0xf0
[  161.802051]  invoke_syscall.constprop.0+0x7c/0xd0
[  161.806745]  do_el0_svc+0xb4/0xd0
[  161.810049]  el0_svc+0x68/0x278
[  161.813179]  el0t_64_sync_handler+0x134/0x150
[  161.817524]  el0t_64_sync+0x17c/0x180


>> +
>> +	node = interval_tree_iter_first(&mmu->fault_ranges, start, end);
>> +	if (node) {
>> +		node = NULL;
>> +		goto unlock;
>> +	}
>> +
>> +	node = kzalloc(sizeof(*node), GFP_KERNEL_ACCOUNT);
>> +	if (!node)
>> +		goto unlock;
> 
> That's not going to work -- why do you think we avoid all dynamic
> allocation on this path?
> 

Right, dynamic allocation should be avoided in this path and it can be
put into the stack as you suggested later.

>> +
>> +	node->start = start;
>> +	node->last = end;
>> +	interval_tree_insert(node, &mmu->fault_ranges);
>> +
>> +unlock:
>> +	mutex_unlock(&mmu->fault_ranges_mutex);
>> +	return node;
>> +}
>> +
>> +static void remove_fault_range(struct kvm_s2_mmu *mmu,
>> +			       struct interval_tree_node *node)
>> +{
>> +	mutex_lock(&mmu->fault_ranges_mutex);
>> +
>> +	interval_tree_remove(node, &mmu->fault_ranges);
>> +	kfree(node);
>> +
>> +	mutex_unlock(&mmu->fault_ranges_mutex);
>> +}
>> +
>> +
>> +static int invalidate_icache_guest_page(struct kvm_s2_mmu *mmu,
>> +					void *va, u64 ipa, size_t size)
>> +{
>> +	struct interval_tree_node *node;
>> +
>> +	node = add_fault_range(mmu, ipa, size);
>> +	if (!node)
>> +		return -EAGAIN;
>> +
>>   	__invalidate_icache_guest_page(va, size);
>> +	remove_fault_range(mmu, node);
> 
> Given that we add and remove the node in the same function, why can't
> we allocate the node on the stack instead?
> 

Yes, definitely.

>> +
>> +	return 0;
>>   }
>>   
>>   /*
>> @@ -859,6 +908,10 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
>>   	mmu->split_page_chunk_size = KVM_ARM_EAGER_SPLIT_CHUNK_SIZE_DEFAULT;
>>   	mmu->split_page_cache.gfp_zero = __GFP_ZERO;
>>   
>> +	/* Initialize the page fault ranges */
>> +	mutex_init(&mmu->fault_ranges_mutex);
>> +	mmu->fault_ranges = RB_ROOT_CACHED;
>> +
>>   	mmu->pgt = pgt;
>>   	mmu->pgd_phys = __pa(pgt->pgd);
>>   	return 0;
> 
> I really wonder why we should add this complexity, rather than doing a
> full i-cache invalidation instead. Given what you describe, I don't
> think it would be worse.
> 

Yes, Oliver already shared the patch and it worked for me. So please ignore
this patch since the code suggested by Oliver is more sensible and robust,
especially for the NV case.

Thanks,
Gavin

