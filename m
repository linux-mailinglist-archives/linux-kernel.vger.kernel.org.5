Return-Path: <linux-kernel+bounces-120682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9088DB65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD71B1F27F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A874F1F1;
	Wed, 27 Mar 2024 10:43:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A28225D9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536200; cv=none; b=TVVvHmRcKJM2QukPmAlIXI2zK4OGpBCYYQ5sz28kzhdiWxKu++/WIQjI1lvoumGgP+hkqOqBvFuuaSv3ADuA37OJSMlRPLXmHx5huByvqRFHncQ6BB/fHK24ogp88w//FWZUJyZSL4hC3X5rdFz7Feq0rC3Yfv74H2GF+MPMwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536200; c=relaxed/simple;
	bh=7g4XIr2NhS8M2o8/S8aRYxM/ziuBm7aT3Fbm2qvofKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uE29/ZR4lKG0NGoacKV9c/pC9iVjMom/xvw59gNTXp1UDY7rqMiyU9OyIHA+hv+P39m8ucLKmpbwho73Jk6vaeBdEAahm29WRb7LR0mw/iQuoJcRY7QjXQ+3SVoBbhGvJSOLITv+Tj9htTQjEhkuFs5aOqlxqf35JBfVSbEffgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1D622F4;
	Wed, 27 Mar 2024 03:43:51 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C9883F694;
	Wed, 27 Mar 2024 03:43:15 -0700 (PDT)
Message-ID: <e1078fe2-0b0b-48c6-8d24-3b2e835201b1@arm.com>
Date: Wed, 27 Mar 2024 10:43:14 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXEEi2ZXs+1qwR97zod5Z+TerPKcKZBN8LGZ5XTRV0_-rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 10:09, Ard Biesheuvel wrote:
> Hi Ryan,
> 
> On Tue, 26 Mar 2024 at 12:15, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi All,
>>
>> It turns out that creating the linear map can take a significant proportion of
>> the total boot time, especially when rodata=full. And a large portion of the
>> time it takes to create the linear map is issuing TLBIs. This series reworks the
>> kernel pgtable generation code to significantly reduce the number of TLBIs. See
>> each patch for details.
>>
>> The below shows the execution time of map_mem() across a couple of different
>> systems with different RAM configurations. We measure after applying each patch
>> and show the improvement relative to base (v6.9-rc1):
>>
>>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
>> ---------------|-------------|-------------|-------------|-------------
>>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
>> ---------------|-------------|-------------|-------------|-------------
>> base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
>> no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
>> no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
>> lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)
>>
>> This series applies on top of v6.9-rc1. All mm selftests pass. I haven't yet
>> tested all VA size configs (although I don't anticipate any issues); I'll do
>> this as part of followup.
>>
> 
> These are very nice results!
> 
> Before digging into the details: do we still have a strong case for
> supporting contiguous PTEs and PMDs in these routines?

We are currently using contptes and pmds for the linear map when rodata=[on|off]
IIRC? I don't see a need to remove the capability personally.

Also I was talking with Mark R yesterday and he suggested that an even better
solution might be to create a temp pgtable that maps the linear map with pmds,
switch to it, then create the real pgtable that maps the linear map with ptes,
then switch to that. The benefit being that we can avoid the fixmap entirely
when creating the second pgtable - we think this would likely be significantly
faster still.

My second patch adds the infrastructure to make this possible. But your changes
for LPA2 make it significantly more effort; since that change we are now using
the swapper pgtable when we populate the linear map into it - the kernel is
already mapped and that isn't done in paging_init() anymore. So I'm not quite
sure how we can easily make that work at the moment.

Thanks,
Ryan


