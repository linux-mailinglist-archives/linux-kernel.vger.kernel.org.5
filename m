Return-Path: <linux-kernel+bounces-73616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33485C529
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02251C20E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017DD14A0B9;
	Tue, 20 Feb 2024 19:50:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62937142
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458648; cv=none; b=Ll91lr78usSvnvTyTEJWms+T2n2cJ+wqLqEZ32rIwNwf7640arOYkJ5KAc6jInx7GxMfqvOJQ6izkzoHx2B3NwtgN51W1ak3nj0PqJvZjnlFHeT9+Wm76s7/kfcIKDbmepLguES5pnJDboGvBx7egj+WFsM8LojhP77qykx+FPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458648; c=relaxed/simple;
	bh=ZHNJV10QT5ZCkniFfESwb5/+Afun37K5/tpp9k6AKJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3gADkIutKdDNRrN6WsJ9ft4etHhAMc2rn1XPU5M/gProhvYi3aUQ8srgXH5afTHoXwSdaLJnECpgpjola/S49ugLFAspahBu8RJAtrjTIXIhRlQyfLYnil0ubE99UPZVVc8lhQENntZlEOal8YhS1NcoLdf3OKVVUYemfUJoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 171D1FEC;
	Tue, 20 Feb 2024 11:51:24 -0800 (PST)
Received: from [172.20.10.9] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F7F3F73F;
	Tue, 20 Feb 2024 11:50:39 -0800 (PST)
Message-ID: <061b8c8a-51cc-46b0-8a2d-90bf6c6ce5d8@arm.com>
Date: Tue, 20 Feb 2024 20:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/18] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-13-ryan.roberts@arm.com> <Zc9UQy-mtYAzNWm2@arm.com>
 <892caa6a-e4fe-4009-aa33-0570526961c5@arm.com> <Zc-Tqqfksho3BHmU@arm.com>
 <f9fc2b31-11cb-4969-8961-9c89fea41b74@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f9fc2b31-11cb-4969-8961-9c89fea41b74@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 19:54, John Hubbard wrote:
> On 2/16/24 08:56, Catalin Marinas wrote:
> ...
>>> The problem is that the contpte_* symbols are called from the ptep_* inline
>>> functions. So where those inlines are called from modules, we need to make sure
>>> the contpte_* symbols are available.
>>>
>>> John Hubbard originally reported this problem against v1 and I enumerated all
>>> the drivers that call into the ptep_* inlines here:
>>> https://lore.kernel.org/linux-arm-kernel/b994ff89-1a1f-26ca-9479-b08c77f94be8@arm.com/#t
>>>
>>> So they definitely need to be exported. Perhaps we can tighten it to
> 
> Yes. Let's keep the in-tree modules working.
> 
>>> EXPORT_SYMBOL_GPL(), but I was being cautious as I didn't want to break anything
>>> out-of-tree. I'm not sure what the normal policy is? arm64 seems to use ~equal
>>> amounts of both.
> 
> EXPORT_SYMBOL_GPL() seems appropriate and low risk. As Catalin says below,
> these really are deeply core mm routines, and any module operating at this
> level is not going to be able to survive on EXPORT_SYMBOL alone, IMHO.
> 
> Now, if only I could find an out of tree module to test that claim on... :)
> 
> 
>> I don't think we are consistent here. For example set_pte_at() can't be
>> called from non-GPL modules because of __sync_icache_dcache. OTOH, such
>> driver is probably doing something dodgy. Same with
>> apply_to_page_range(), it's GPL-only (called from i915).
>>
>> Let's see if others have any view over the next week or so, otherwise
>> I'd go for _GPL and relax it later if someone has a good use-case (can
>> be a patch on top adding _GPL).
> 
> I think going directly to _GPL for these is fine, actually.

OK I'll send out a patch to convert these to _GPL on my return on Monday.
Hopefully Andrew will be able to squash the patch into the existing series.

> 
> 
> thanks,


