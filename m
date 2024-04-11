Return-Path: <linux-kernel+bounces-140212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A268A0D12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1A4285A62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ADD145B1D;
	Thu, 11 Apr 2024 09:59:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DCC13DDDD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829595; cv=none; b=mJSAEzjgJ97m10m2Kz1BtsNV86SQN0TSczqH4bi55F/bWWR3UKJ3Dw2BrDjwNVzqyS8SZdGVn+xn6AO8/03HmDjzgg3nY3agbvbuYZZ3/kuLdYdad84QSdBX8aOjWFc5wqbJLkSEu4QR4rzlNIBkCQaoYv0AaJyibtCXhtCkbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829595; c=relaxed/simple;
	bh=4oY73UJTLx3uZRMDHoun0ygcgTzy2FJmMwP6pncs3aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFNo5n4k0sHNI+A3UvIEFJgsGMw6Mo7NIIQefNb/5bibvqh/Sw5A/h8e2za4d4eQPBbBkMs9ztL1iVV0EWG//GmgODxVfc1mB1AFS1Kc1umc9V/CqtRpxb2UaX7/SHL2NJOab8FL9k4S3u+7SAmgGuKp1ZelZKdW4Lig3ayKVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15ABB113E;
	Thu, 11 Apr 2024 03:00:23 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92C4F3F6C4;
	Thu, 11 Apr 2024 02:59:51 -0700 (PDT)
Message-ID: <a63f059a-a506-48f7-8292-b09debf23e1c@arm.com>
Date: Thu, 11 Apr 2024 10:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: tlb: Fix TLBI RANGE operand
Content-Language: en-GB
To: Marc Zyngier <maz@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 akpm@linux-foundation.org, oliver.upton@linux.dev, apopple@nvidia.com,
 rananta@google.com, mark.rutland@arm.com, v-songbaohua@oppo.com,
 yangyicong@hisilicon.com, shahuang@redhat.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-2-gshan@redhat.com>
 <7a929104-5f09-4ff6-8792-4a9e93bc0894@arm.com> <86wmp5sj0u.wl-maz@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <86wmp5sj0u.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 09:45, Marc Zyngier wrote:
> On Mon, 08 Apr 2024 09:29:31 +0100,
> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 05/04/2024 04:58, Gavin Shan wrote:
>>> KVM/arm64 relies on TLBI RANGE feature to flush TLBs when the dirty
>>> pages are collected by VMM and the page table entries become write
>>> protected during live migration. Unfortunately, the operand passed
>>> to the TLBI RANGE instruction isn't correctly sorted out due to the
>>> commit 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()").
>>> It leads to crash on the destination VM after live migration because
>>> TLBs aren't flushed completely and some of the dirty pages are missed.
>>>
>>> For example, I have a VM where 8GB memory is assigned, starting from
>>> 0x40000000 (1GB). Note that the host has 4KB as the base page size.
>>> In the middile of migration, kvm_tlb_flush_vmid_range() is executed
>>> to flush TLBs. It passes MAX_TLBI_RANGE_PAGES as the argument to
>>> __kvm_tlb_flush_vmid_range() and __flush_s2_tlb_range_op(). SCALE#3
>>> and NUM#31, corresponding to MAX_TLBI_RANGE_PAGES, isn't supported
>>> by __TLBI_RANGE_NUM(). In this specific case, -1 has been returned
>>> from __TLBI_RANGE_NUM() for SCALE#3/2/1/0 and rejected by the loop
>>> in the __flush_tlb_range_op() until the variable @scale underflows
>>> and becomes -9, 0xffff708000040000 is set as the operand. The operand
>>> is wrong since it's sorted out by __TLBI_VADDR_RANGE() according to
>>> invalid @scale and @num.
>>>
>>> Fix it by extending __TLBI_RANGE_NUM() to support the combination of
>>> SCALE#3 and NUM#31. With the changes, [-1 31] instead of [-1 30] can
>>> be returned from the macro, meaning the TLBs for 0x200000 pages in the
>>> above example can be flushed in one shoot with SCALE#3 and NUM#31. The
>>> macro TLBI_RANGE_MASK is dropped since no one uses it any more. The
>>> comments are also adjusted accordingly.
>>
>> Perhaps I'm being overly pedantic, but I don't think the bug is
>> __TLBI_RANGE_NUM() not being able to return 31; It is clearly documented that it
>> can only return in the range [-1, 30] and a maximum of (MAX_TLBI_RANGE_PAGES -
>> 1) pages are supported.
> 
> I guess "clearly" is pretty relative. I find it misleading that we
> don't support the full range of what the architecture offers and have
> these odd limitations.
> 
>> The bug is in the kvm caller, which tries to call __flush_tlb_range_op() with
>> MAX_TLBI_RANGE_PAGES; clearly out-of-bounds.
> 
> Nobody disputes that point, hence the Fixes: tag pointing to the KVM
> patch. But there are two ways to fix it: either reduce the amount KVM
> can use for range invalidation, or fix the helper to allow the full
> range offered by the architecture.
> 
>> So personally, I would prefer to fix the bug first. Then separately
>> enhance the infrastructure to support NUM=31.
> 
> I don't think this buys us much, apart from making it harder for
> people to know what they need/want/randomly-elect to backport.

Yeah fair enough. Like I said, I'm being pedantic. And the final state
(supporting NUM=31) is clearly the right outcome. So as long as there is no risk
that backporting the enhancement triggers other bugs, then this is fine for me.

> 
>>> Fixes: 117940aa6e5f ("KVM: arm64: Define kvm_tlb_flush_vmid_range()")
>>
>> I would argue that the bug was actually introduced by commit 360839027a6e
>> ("arm64: tlb: Refactor the core flush algorithm of __flush_tlb_range"), which
>> separated the tlbi loop from the range size validation in __flush_tlb_range().
>> Before this, all calls would have to go through __flush_tlb_range() and
>> therefore anything bigger than (MAX_TLBI_RANGE_PAGES - 1) pages would cause the
>> whole mm to be flushed. Although I get that bisect will lead to this one, so
>> that's probably the right one to highlight.
> 
> I haven't tried to bisect it, only picked this as the obviously
> culprit.
> 
> To your point, using __flush_tlb_range() made little sense for KVM --
> what would be the vma here? Splitting the helper out was, I think the
> correct decision. But we of course lost sight of the __TLBI_RANGE_NUM
> limitation in the process.

Indeed. I'm just wondering whether it could have been factored out so that the
size check and the decision about full invalidate vs per-va/range invalidate
remained in the common code.

I'm not volunteering to make that change though. So I guess what we have now is
good enough for the time being.

Thanks,
Ryan

> 
>> I get why it was split, but perhaps it should have been split at a higher level;
>> If tlbi range is not supported, then KVM will flush the whole vmid. Would it be
>> better for KVM to follow the same pattern as __flush_tlb_range_nosync() and
>> issue per-block tlbis upto a max of MAX_DVM_OPS before falling back to the whole
>> vmid? And if tlbi range is supported, KVM uses it regardless of the size of the
>> range, whereas __flush_tlb_range_nosync() falls back to flush_tlb_mm() at a
>> certain size. It's not clear why this divergence is useful?
> 
> That'd be a definitive improvement indeed, and would bring back some
> much needed consistency.
> 
>>> Cc: stable@kernel.org # v6.6+
>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>> Suggested-by: Marc Zyngier <maz@kernel.org>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>
>> Anyway, the implementation looks correct, so:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Thanks for that!
> 
> 	M.
> 


