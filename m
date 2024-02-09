Return-Path: <linux-kernel+bounces-59135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FA84F1C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B2C1C23F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2574664B7;
	Fri,  9 Feb 2024 08:54:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503B804
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468884; cv=none; b=Ik0gIaYhDSgY03SR5Mw5M5UAOL/PcoNUwc7P/zVUReVHJB1Dz3WrjqC3kaeDnaN6ZxM5jIvAn+wm8hAZ/sXMhfR60vjvsWFP6HdxkanFj4jnEGZxv6V1MR39RszwR/mSRtJHzctR+35rpk865WJgPqzYkF/Ovo7P/fIjdx1b6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468884; c=relaxed/simple;
	bh=RfbvJW3bVSCTDbolic6/qdFK1ddPZ5mzAShGpX98YPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofnSrf4lDCAnpqRoeepDQT+6iggO/1JvM/Scdtjid5eAHYjVkXHbZmnQj2JzRKjRThtP7sRXpuSHlvKTOnvDvCOD8oMiAOeqrdTycfviaRNV3vyF6aSeVWLBk3kDi9chcugJ4zIzvIeMexvAhCfDTt2HpcS9mIlozDIjXdwNS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D4E6DA7;
	Fri,  9 Feb 2024 00:55:22 -0800 (PST)
Received: from [10.57.65.115] (unknown [10.57.65.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6688A3F762;
	Fri,  9 Feb 2024 00:54:36 -0800 (PST)
Message-ID: <3ba54c94-8e44-4dd6-9a25-2cf81b07336f@arm.com>
Date: Fri, 9 Feb 2024 08:54:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/25] Transparent Contiguous PTEs for User Mappings
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <ZcUQqfg39zCS2BAv@FVFF77S0Q05N.cambridge.arm.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZcUQqfg39zCS2BAv@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 17:34, Mark Rutland wrote:
> On Fri, Feb 02, 2024 at 08:07:31AM +0000, Ryan Roberts wrote:
>> Hi All,
> 
> Hi Ryan,
> 
> I assume this is the same as your 'features/granule_perf/contpte-lkml_v' branch
> on https://gitlab.arm.com/linux-arm/linux-rr/

Yep - great detective work! features/granule_perf/contpte-lkml_v5 corresponds
exactly to what I posted with all the dependencies in place.

> 
> I've taken a quick look, and I have a few initial/superficial comments before
> digging into the detail on the important changes.

Thanks for doing this!

> 
>> Patch Layout
>> ============
>>
>> In this version, I've split the patches to better show each optimization:
>>
>>   - 1-2:    mm prep: misc code and docs cleanups
> 
> I'm not confident enough to comment on patch 2, but these look reasonable to
> me.

Thanks. David has acked patch 2 already so I think we are good there.

> 
>>   - 3-8:    mm,arm,arm64,powerpc,x86 prep: Replace pte_next_pfn() with more
>>             general pte_advance_pfn()
> 
> These look fine to me.

Thanks!

> 
>>   - 9-18:   arm64 prep: Refactor ptep helpers into new layer
> 
> The result of patches 9-17 looks good to me, but the intermediate stages where
> some functions are converted is a bit odd, and it's a bit painful for review
> since you need to skip ahead a few patches to see the end result to tell that
> the conversions are consistent and complete.
> 
> IMO it'd be easier for review if that were three patches:
> 
> 1) Convert READ_ONCE() -> ptep_get()
> 2) Convert set_pte_at() -> set_ptes()
> 3) All the "New layer" renames and addition of the trivial wrappers

Yep that makes sense. I'll start prepping that today. I'll hold off reposting
until I have your comments on 19-25. I'm also hoping that David will repost the
zap series today so that it can get into mm-unstable by mid-next week. Then I'll
repost on top of that, hopefully by end of next week, folding in all your
comments. This should give planty of time to soak in linux-next.

Thanks,
Ryan

> 
> Patch 18 looks fine to me.
> 
>>   - 19:     functional contpte implementation
>>   - 20-25:  various optimizations on top of the contpte implementation
> 
> I'll try to dig into these over the next few days.
> 
> Mark.


