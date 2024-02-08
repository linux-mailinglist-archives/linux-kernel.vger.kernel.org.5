Return-Path: <linux-kernel+bounces-57749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54484DCF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7681C269AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D646BFCD;
	Thu,  8 Feb 2024 09:30:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56256BFC8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384636; cv=none; b=aSuaJW9+pVmd7+EagGkWE2gHHjjJJ1zQEKkoLZy8cVk2PbSxG3zKszfxEHZLFUaRDA+LnODPe2nVJVAQp7bdxv7vF4xYBs2pL53lojvGmbsPNNA7jDS1pFdY6yuo/w7GnJUa4nQUtG3t9xP/wMTzlgMf8OP1yjFVypM+pzP7f88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384636; c=relaxed/simple;
	bh=5C6sJ4Hr7tt9D4Dgm04VuiGy5wshhvDFlkBHWWCFKEw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TxUy2NG7aZqMT9KTdlOhw7pz6QaR5J2H5G56y75h4eD7imxX0ZtfGX/GnPMvOWfGNT2F0g549PLPcDlemruJxCqWqGDazJFeqCRfabSBWx38oBebjKlDZ+BEj1gnixGIAcZdlHmNyoUbUFIiISnOy4QbBgp28WbfBhX9J8td4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TVsBV0TYwz1xnS0;
	Thu,  8 Feb 2024 17:29:22 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 95E17140336;
	Thu,  8 Feb 2024 17:30:30 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 17:30:29 +0800
Subject: Re: [PATCH v3 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable
 safely
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>,
	<anshuman.khandual@arm.com>, <willy@infradead.org>,
	<wangkefeng.wang@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <20240113094436.2506396-3-sunnanyong@huawei.com>
 <ZcN13R1L1CYu9gs1@FVFF77S0Q05N.cambridge.arm.com>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <2372364b-d02a-9082-de6b-d17655ad229a@huawei.com>
Date: Thu, 8 Feb 2024 17:30:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcN13R1L1CYu9gs1@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)

On 2024/2/7 20:21, Mark Rutland wrote:

> On Sat, Jan 13, 2024 at 05:44:35PM +0800, Nanyong Sun wrote:
>> Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
>> BBM(break-before-make) logic when change the page table of vmemmap
>> address, they will under the init_mm.page_table_lock.
>> If a translation fault of vmemmap address concurrently happened after
>> pte/pmd cleared, vmemmap page fault handler will acquire the
>> init_mm.page_table_lock to wait for vmemmap update to complete,
>> by then the virtual address is valid again, so PF can return and
>> access can continue.
> Is that wait bounded? ... and is it event guaranteed to make progress?
>
> Under a hypervisor, the vCPU doing the BBM could be preempted between the break
> and the make, so the thread waiting might be waiting a long time for that to
> come back and finish the make step.
>
> Further, under PREEMPT_RT regular spinlocks don't inhibit preemption, and I suspect
> that means this can deadlock on RT -- the thread doing the BBM could be
> preempted, the newly-scheduled thread could try to access the vmemmap, and then
> get stuck in the fault handler (e.g. on a single CPU system). There's nothing
> below describing how that's prevented.
>
> I've concerned this may be subtly broken, and it feels like this is going to be
> *very* painful to maintain and test. IMO this is trying to be overly clever and
> I'd much rather that we avoided the transient broken step. On CPUs with
> FEAT_BBM level 2 we can avoid that broken step, can we make this depend
> dynamically on whether the CPU has FEAT_BBM?
If I understand correctly, FEAT_BBM is only used for changing block 
size. But in HVO
we not only need changing block size in vmemmap_split_pmd(), but also 
need changing
output address of PTE in vmemmap_remap_pte().
So I would like to ask if FEAT_BBM can cover these scenarios?
>
>> In other case, do the traditional kernel fault.
>>
>> Implement vmemmap_flush_tlb_all/range on arm64 with nothing
>> to do because tlb already flushed in every single BBM.
>>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> ---
>>
>> +
>> +/*
>> + * PMD mapped vmemmap should has been split as PTE mapped
>> + * by HVO now, here we only check this case, other cases
>> + * should fail.
> Sorry, I can't parse what this is trying to say.
>
>> + * Also should check the addr is healthy enough that will not cause
>> + * a level2 or level3 translation fault again after page fault
>> + * handled with success, so we need check both bits[1:0] of PMD and
>> + * PTE as ARM Spec mentioned below:
> Which spec? Iassume you mean the ARM ARM? Are you referring to a specific part
> within that?

Yes, I referenced section D5.8.1 "Types of MMU faults" from Arm ARM.

>
>> + * A Translation fault is generated if bits[1:0] of a translation
>> + * table descriptor identify the descriptor as either a Fault
>> + * encoding or a reserved encoding.
>> + */
>> +static inline bool vmemmap_addr_healthy(unsigned long addr)
>> +{
>> +	pmd_t *pmdp, pmd;
>> +	pte_t *ptep, pte;
>> +
>> +	pmdp = pmd_off_k(addr);
>> +	pmd = pmdp_get(pmdp);
>> +	if (!pmd_table(pmd))
>> +		return false;
> Is a block (i.e. hugetlb) entry not considered healthy? I thought the whole
> point of this optimization was that you'd use a block PMD entry?
Yes, this patch only condiser the user is HVO and then recheck here, and 
in HVO, only PMD split and
PTE remap can happen. Any other scenarios should be treated as regular 
kernel fault and then panic.
>
>> +
>> +	ptep = pte_offset_kernel(pmdp, addr);
>> +	pte = ptep_get(ptep);
>> +	return (pte_val(pte) & PTE_TYPE_MASK) == PTE_TYPE_PAGE;
>> +}
>> +
>> +static bool vmemmap_handle_page_fault(unsigned long addr,
>> +				      unsigned long esr)
>> +{
>> +	bool ret;
>> +
>> +	if (likely(!vmemmap_fault_may_fixup(addr, esr)))
>> +		return false;
>> +
>> +	spin_lock(&init_mm.page_table_lock);
>> +	ret = vmemmap_addr_healthy(addr);
>> +	spin_unlock(&init_mm.page_table_lock);
> As above, I'm pretty sure this is only safe is the code doing the BBM has IRQs
> disabled, otherwise the thread can be preempted, and we can get stuck in here
> while the entry is broken.
>
> So at minimum this needs some explanation of why that doesn't happen in a
> comment.
>
>
> As above, if this happens with IRQs unmasked, the thread can potentially be
> preempted and we can get stuck in the fault handler (at least on RT).
>
> I can't tell whether this is safe, and I think that at minimum this needs
> comments and/or lockdep assertions, but I'd much rather we didn't try to play
> this sort of game.
>
> Mark.
>
> .

For IRQ context problem, I wonder if take a new spin lock with irq 
disabled can solve it?

eg.

+void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
+{
+	spin_lock_irq(NEW_LOCK);
+	pte_clear(&init_mm, addr, ptep);
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	set_pte_at(&init_mm, addr, ptep, pte);
+	spin_unlock_irq(NEW_LOCK);
+}


