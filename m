Return-Path: <linux-kernel+bounces-121614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6788EADB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888A11F33A06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D112FF6E;
	Wed, 27 Mar 2024 16:11:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D8912F5A6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555872; cv=none; b=dl3DdanwimOqZjQDW5HFXmzDikSt8DbAMwAyTTobG5oPnj7sm/GQG/hlo15oSH1+Ixa/n7dXO+9yQcE5WoAB7tbAjoBNwgAJ/uvBo3wUxKwESlMe4WzVUU5PPcM7ZBHLdfXRBHjwzkRomcHzx8uGT39K6yNNAeNnMB5D+uUdMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555872; c=relaxed/simple;
	bh=djUaWyW3WZ1b6+xLy3zzOrIuvZR5qHIzetV6eB/S9l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUouL4AAij3E+o25DZoIwjg3Nw2IJCzpXmazMurtjH3t/t6c9ngugnlIK65CLNjpNb6GITpOZF1DZF1vOQj9zzoDIthdLa0hYNo82Qs7lFVthjbcC8q9jU9Q7EOh0OBlDBVbGYT+uQI0AQ5ATB3dcuQLAy/NS8sZZKcHK2EJETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B27F2F4;
	Wed, 27 Mar 2024 09:11:44 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99C323F64C;
	Wed, 27 Mar 2024 09:11:08 -0700 (PDT)
Message-ID: <05cca7de-2dc1-4dae-abd5-da757dd9eaea@arm.com>
Date: Wed, 27 Mar 2024 16:11:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
 <CAMj1kXEEi2ZXs+1qwR97zod5Z+TerPKcKZBN8LGZ5XTRV0_-rg@mail.gmail.com>
 <e1078fe2-0b0b-48c6-8d24-3b2e835201b1@arm.com>
 <CAMj1kXGtNYce5cOwUc+X5ceyxLGzD1xUEx7JRXqg7+4XQMAORw@mail.gmail.com>
 <7f69758c-b849-48ca-b279-569469183e91@arm.com>
 <CAMj1kXGVNWrm6=sWixL3PiXr1DQN_buvm1YxQW2+zALgd3b-hA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXGVNWrm6=sWixL3PiXr1DQN_buvm1YxQW2+zALgd3b-hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 15:57, Ard Biesheuvel wrote:
> On Wed, 27 Mar 2024 at 17:01, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/03/2024 13:36, Ard Biesheuvel wrote:
>>> On Wed, 27 Mar 2024 at 12:43, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 27/03/2024 10:09, Ard Biesheuvel wrote:
> ...
>>>
>>> I think a mix of the fixmap approach with a 1:1 map could work here:
>>> - use TTBR0 to create a temp 1:1 map of DRAM
>>> - map page tables lazily as they are allocated but using a coarse mapping
>>> - avoid all TLB maintenance except at the end when tearing down the 1:1 mapping.
>>
>> Yes that could work I think. So to make sure I've understood:
>>
>>  - create a 1:1 map for all of DRAM using block and cont mappings where possible
>>      - use memblock_phys_alloc_*() to allocate pgtable memory
>>      - access via fixmap (should be minimal due to block mappings)
> 
> Yes but you'd only need the fixmap for pages that are not in the 1:1
> map yet, so after an initial ramp up you wouldn't need it at all,
> assuming locality of memblock allocations and the use of PMD mappings.
> The only tricky thing here is ensuring that we are not mapping memory
> that we shouldn't be touching.

That sounds a bit nasty though. I think it would be simpler to just reuse the
machinery we have, doing the 1:1 map using blocks and fixmap; It should be a
factor of 512 better than what we have, so probably not a problem at that point.
That way, we can rely on memblock to tell us what to map. If its still
problematic I can add a layer to support 1G mappings too.

> 
>>  - install it in TTBR0
>>  - create all the swapper mappings as normal (no block or cont mappings)
>>      - use memblock_phys_alloc_*() to alloc pgtable memory
>>      - phys address is also virtual address due to installed 1:1 map
>>  - Remove 1:1 map from TTBR0
>>  - memblock_phys_free() all the memory associated with 1:1 map
>>
> 
> Indeed.

One question on the state of TTBR0 at entrance to paging_init(); what is it? I
need to know so I can set it back after.

Currently I'm thinking I can do:

cpu_install_ttbr0(my_dram_idmap, TCR_T0SZ(vabits_actual));
<create swapper>
cpu_set_reserved_ttbr0();
local_flush_tlb_all();

But is it ok to leave the reserved pdg in ttbr0, or is it expecting something else?

> 
>> That sounds doable on top of the first 2 patches in this series - I'll have a
>> crack. The only missing piece is depth-first 1:1 map traversal to free the
>> tables. I'm guessing something already exists that I can repurpose?
>>
> 
> Not that I am aware of, but that doesn't sound too complicated.


