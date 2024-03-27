Return-Path: <linux-kernel+bounces-121893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8798D88EF05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B959E1C348EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1614F9F6;
	Wed, 27 Mar 2024 19:12:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0714F138
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566732; cv=none; b=FKWdDpik5DeyRenB60t8ClnxmdfslCjeJCd37JnU2nnHpH48NkLg6OIkFO5KOgwp6Vt+fdog1kncBe4oyie9ZV3Xmpu8kmYUXJINNpGiuh3j+S57OxAAT/830pHZyjUkAK4oMh7b6vvYq3iMW6Fds9+Pl0p5ZQxIYxMWYSExEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566732; c=relaxed/simple;
	bh=/u/cfnccQhrohJN6KgP39BxmpL0wLRKgMCQWFFSwq3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLrWwwCSst78MIvxVLQvq8xC0sjM38zjm5ndud4r4fuZSl0ppzg3PXRUEETVPeQx5x2X/IPFloTOmyaOD1JsJr+45GqTssW1jGj0PmJJaUi54OYdKGVFEpfAZtMuJeHwp90UX/dvksf+1e5TaTz/2lm1xmkThjdDmcyBOH8Tvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498272F4;
	Wed, 27 Mar 2024 12:12:44 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54E773F694;
	Wed, 27 Mar 2024 12:12:08 -0700 (PDT)
Message-ID: <ec1d0885-9cda-496c-870c-fa8e1dcab974@arm.com>
Date: Wed, 27 Mar 2024 19:12:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Hildenbrand <david@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240326101448.3453626-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 10:14, Ryan Roberts wrote:
> Hi All,
> 
> It turns out that creating the linear map can take a significant proportion of
> the total boot time, especially when rodata=full. And a large portion of the
> time it takes to create the linear map is issuing TLBIs. This series reworks the
> kernel pgtable generation code to significantly reduce the number of TLBIs. See
> each patch for details.
> 
> The below shows the execution time of map_mem() across a couple of different
> systems with different RAM configurations. We measure after applying each patch
> and show the improvement relative to base (v6.9-rc1):
> 
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
> no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
> no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
> lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)

I've just appended an additional patch to this series. This takes us to a ~95%
reduction overall:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
base           |  151   (0%) | 2191   (0%) | 8990   (0%) | 17443   (0%)
no-cont-remap  |   77 (-49%) |  429 (-80%) | 1753 (-80%) |  3796 (-78%)
no-alloc-remap |   77 (-49%) |  375 (-83%) | 1532 (-83%) |  3366 (-81%)
lazy-unmap     |   63 (-58%) |  330 (-85%) | 1312 (-85%) |  2929 (-83%)
batch-barriers |   11 (-93%) |   61 (-97%) |  261 (-97%) |   837 (-95%)

Don't believe the intermediate block-based pgtable idea will now be neccessary
so I don't intend to persue that. It might be that we choose to drop the middle
two patchs; I'm keen to hear opinions.

Thanks,
Ryan


> 
> This series applies on top of v6.9-rc1. All mm selftests pass. I haven't yet
> tested all VA size configs (although I don't anticipate any issues); I'll do
> this as part of followup.
> 
> Thanks,
> Ryan
> 
> 
> Ryan Roberts (3):
>   arm64: mm: Don't remap pgtables per- cont(pte|pmd) block
>   arm64: mm: Don't remap pgtables for allocate vs populate
>   arm64: mm: Lazily clear pte table mappings from fixmap
> 
>  arch/arm64/include/asm/fixmap.h  |   5 +-
>  arch/arm64/include/asm/mmu.h     |   8 +
>  arch/arm64/include/asm/pgtable.h |   4 -
>  arch/arm64/kernel/cpufeature.c   |  10 +-
>  arch/arm64/mm/fixmap.c           |  11 +
>  arch/arm64/mm/mmu.c              | 364 +++++++++++++++++++++++--------
>  include/linux/pgtable.h          |   8 +
>  7 files changed, 307 insertions(+), 103 deletions(-)
> 
> --
> 2.25.1
> 


