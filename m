Return-Path: <linux-kernel+bounces-60159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519F8500E3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D6228C5A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44B38FA5;
	Fri,  9 Feb 2024 23:52:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B2E38396
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522757; cv=none; b=k+P1+snAaYSe1boSGZez1NSYEeuEzvxrA+zX+tXXUhuRoR+4YFU8/+Ym5wSidghFYfIpUGbBNExarWXSxm8y+ebycjMyQlis/wyDPrEoFFQgIS830CloWMeMCPl4mNpNsCTS2RcWHznh9lBNPmcb9sZD1RYnaiWFDOyfz2sT4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522757; c=relaxed/simple;
	bh=wtGI/fGGZ7Pp1Rx1PpuSmg9uMmZ1GJrsRw7lFJRpuRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgD0bstSAAEB7CY6HFSNhPFDWV3XcS5SQTpQ2RgDS5w2ksIzBqzhtEwv6WrstaSDhktD3lY8oy1EXJOd1/Hmnd3AS9FdkHqVSySGIwgvJIgLcB91U7ym/vVZFtzp6wV5mXUV1DwihHkE769WTdHGdSGZzyIMIyDZ/hc6BUVOevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B35F0DA7;
	Fri,  9 Feb 2024 15:53:15 -0800 (PST)
Received: from [10.57.78.75] (unknown [10.57.78.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F327E3F5A1;
	Fri,  9 Feb 2024 15:52:29 -0800 (PST)
Message-ID: <633af0a7-0823-424f-b6ef-374d99483f05@arm.com>
Date: Fri, 9 Feb 2024 23:52:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/25] Transparent Contiguous PTEs for User Mappings
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
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
 <3ba54c94-8e44-4dd6-9a25-2cf81b07336f@arm.com>
 <216aa113-dc3f-45d4-964f-98f80969a927@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <216aa113-dc3f-45d4-964f-98f80969a927@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 22:16, David Hildenbrand wrote:
>>> 1) Convert READ_ONCE() -> ptep_get()
>>> 2) Convert set_pte_at() -> set_ptes()
>>> 3) All the "New layer" renames and addition of the trivial wrappers
>>
>> Yep that makes sense. I'll start prepping that today. I'll hold off reposting
>> until I have your comments on 19-25. I'm also hoping that David will repost the
>> zap series today so that it can get into mm-unstable by mid-next week. Then I'll
>> repost on top of that, hopefully by end of next week, folding in all your
>> comments. This should give planty of time to soak in linux-next.
> 
> Just sent out v2. Will review this series (early) next week.
> 
> Have a great weekend!

Cheers, David - you too!

> 


