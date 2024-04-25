Return-Path: <linux-kernel+bounces-158205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2128B1CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08061C22F52
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A327FBC6;
	Thu, 25 Apr 2024 08:40:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7604767A1A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034437; cv=none; b=q5uaa2yNuP8Niqj91WAU2cHZefAqxBTaaXZRjaYaWGnvt3K5SIsTcjkbuEIMcYiO1ivCswF5tg51BAEN/USsprBGUtyUt0Yo1854YLNHSgLnlXOnA35/3esDjfy8HFzH/6eJqwlLbTKgnht+T/zcPXzyQNaV4dc3o26Adi8af/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034437; c=relaxed/simple;
	bh=AGnqlrYQQssGfXFlA+1i0ZCyJ1n/SAZ8YpV8ZEQW3VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omU/2BU9OpLP63vP1/SVShkJp8Ilt6grveNUyjkpHwWIKzWNAbcw88rZtPEZv4vHzcggg4iQ6vmuwzmFlOEFdCJzCMBC0vlp8eAnYPJa4Zu/4QRgT1BoB3q90nS8mxQrkGsBnM1GWLGZAUII4sjywqqRyUuIhocpwqdcNNDFfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEE601007;
	Thu, 25 Apr 2024 01:40:56 -0700 (PDT)
Received: from [10.57.75.12] (unknown [10.57.75.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46F023F64C;
	Thu, 25 Apr 2024 01:40:27 -0700 (PDT)
Message-ID: <2b7231a5-fced-43b1-ad56-39de6261e551@arm.com>
Date: Thu, 25 Apr 2024 09:40:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arm64/mm: Move PTE_PROT_NONE and
 PMD_PRESENT_INVALID
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-2-ryan.roberts@arm.com> <Zik2zs0cBeJ_AzED@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zik2zs0cBeJ_AzED@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 17:43, Catalin Marinas wrote:
> On Wed, Apr 24, 2024 at 12:10:16PM +0100, Ryan Roberts wrote:
>> Previously PTE_PROT_NONE was occupying bit 58, one of the bits reserved
>> for SW use when the PTE is valid. This is a waste of those precious SW
>> bits since PTE_PROT_NONE can only ever be set when valid is clear.
>> Instead let's overlay it on what would be a HW bit if valid was set.
>>
>> We need to be careful about which HW bit to choose since some of them
>> must be preserved; when pte_present() is true (as it is for a
>> PTE_PROT_NONE pte), it is legitimate for the core to call various
>> accessors, e.g. pte_dirty(), pte_write() etc. There are also some
>> accessors that are private to the arch which must continue to be
>> honoured, e.g. pte_user(), pte_user_exec() etc.
>>
>> So we choose to overlay PTE_UXN; This effectively means that whenever a
>> pte has PTE_PROT_NONE set, it will always report pte_user_exec() ==
>> false, which is obviously always correct.
>>
>> As a result of this change, we must shuffle the layout of the
>> arch-specific swap pte so that PTE_PROT_NONE is always zero and not
>> overlapping with any other field. As a result of this, there is no way
>> to keep the `type` field contiguous without conflicting with
>> PMD_PRESENT_INVALID (bit 59), which must also be 0 for a swap pte. So
>> let's move PMD_PRESENT_INVALID to bit 60.
> 
> I think we discussed but forgot the details. What was the reason for not
> using, say, bit 60 for PTE_PROT_NONE to avoid all the swap bits
> reshuffling? Clearing or setting of the PTE_PROT_NONE bit is done via
> pte_modify() and this gets all the new permission bits anyway. With POE
> support (on the list for now), PTE_PROT_NONE would overlap with
> POIndex[0] but I don't think we ever plan to read this field (other than
> maybe ptdump). The POIndex field is set from the vma->vm_page_prot (Joey
> may need to adjust vm_get_page_prot() in his patches to avoid setting a
> pkey on a PROT_NONE mapping).
> 

Copy/pasting your comment from the other patch into this one since its easier to
discuss it all together:

  Ah, I did not realise we need to free up bit 3 from the swap pte as
  well. Though maybe patch 1 is fine as is but for the record, it would be
  good to justify the decision to go with PTE_UXN.

While we need a new bit in the swap pte for uffd-wp, its just a SW bit - it
could go anywhere. I chose bit 3 because it was free after all the other shuffling.

As for choosing PTE_UXN for PTE_PROT_NONE, I wanted to choose a bit that would
definitely never lead to confusion if ever interpretted as its HW meaning, since
as far as the core-mm is concerned, the pte is either present or its not, and if
it is present, then it is completely valid to call all the pte_*() helpers. By
definition, if PTE_PROT_NONE is set, then the PTE is not executable in user
space, so any helpers that continue to interpret the bit position as UXN will
still give sensible answers.

Yes, I could have just put PTE_PROT_NONE in bit position 60 and avoided all the
shuffling. But in the past you have pushed back on using the PBHA bits due to
out of tree patches using them. I thought it was better to just sidestep having
to think about it by not using them. Additionally, as you point out, I didn't
want to risk overlapping with the POIndex and that causing subtle bugs.

But then... PMD_PRESENT_INVALID. Which already turns out to be violating my
above considerations. Ugh. I considered moving that to NS, but it would have
required splitting the offset field into 2 discontiguous parts in the swap pte.
In the end, I decided its ok in any position because its transient; its just a
temp marker and the pte will soon get set again from scratch so it doesn't
matter is adding the marker is destructive.

Personally I think there is less risk of a future/subtle bug by putting
PTE_PROT_NONE over PTE_UXN. But if you prefer to reduce churn by putting it at
bit 60 then I'm ok with that.

