Return-Path: <linux-kernel+bounces-120731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D418088DC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6152A27A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414B5475D;
	Wed, 27 Mar 2024 11:10:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9894EB4F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537834; cv=none; b=jd0jm7zUQZGPXKpAq9HSAbQABLShC+P1eZlkg0Swt0PYWSOVpFRocDag2AXsiyEm361fpemws7pGLR2Ds2V233Kvtlpgl1zO6iylpidY8fA4jc2lnO98xv4m8u4lhgZJL84qMaI6Sg/0UZk8pP2Twn9UImxsiCk9XE/gBxaIG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537834; c=relaxed/simple;
	bh=424D7nE7uOxj3knbxc/ZbegJctB7xbdQzrHXRBGEUwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwWzseh+3ZsGRNmpc0+vHclIZltiY4tqiy8iGaih5DECRXBimrt5W8Fnki/AtNlEfqhkj/URbu4G/fYYR32VLdc8q2thWeMDiczSpeqydE7rM5YHxDc7vC07M7NcADSIEUHaipJQGeYszWdliXA9nHpwEFatlIxy4JWnSH3F6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D432F4;
	Wed, 27 Mar 2024 04:11:04 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69F913F694;
	Wed, 27 Mar 2024 04:10:28 -0700 (PDT)
Message-ID: <2a19f555-56db-403f-a774-65a1e9381a78@arm.com>
Date: Wed, 27 Mar 2024 11:10:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
Content-Language: en-GB
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Hildenbrand <david@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Eric Chanudet <echanude@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
 <ZgP9zfHz2NfiQqSZ@vm3>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZgP9zfHz2NfiQqSZ@vm3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 11:06, Itaru Kitayama wrote:
> On Tue, Mar 26, 2024 at 10:14:45AM +0000, Ryan Roberts wrote:
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
> 
> The series was applied cleanly on top of v6.9-rc1+ of Linus's master
> branch, and boots fine on M1 VM with 14GB of memory.
> 
> Just out of curiosity, how did you measure the boot time and obtain the
> breakdown of the execution times of each phase?

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 495b732d5af3..8a9d47115784 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -792,7 +792,14 @@ static void __init create_idmap(void)

 void __init paging_init(void)
 {
+       u64 start, end;
+
+       start = __arch_counter_get_cntvct();
        map_mem(swapper_pg_dir);
+       end = __arch_counter_get_cntvct();
+
+       pr_err("map_mem: time=%llu us\n",
+               ((end - start) * 1000000) / arch_timer_get_cntfrq());

        memblock_allow_resize();

> 
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thanks!

> 
> Thanks,
> Itaru.
> 
>>
>> Thanks,
>> Ryan
>>
>>
>> Ryan Roberts (3):
>>   arm64: mm: Don't remap pgtables per- cont(pte|pmd) block
>>   arm64: mm: Don't remap pgtables for allocate vs populate
>>   arm64: mm: Lazily clear pte table mappings from fixmap
>>
>>  arch/arm64/include/asm/fixmap.h  |   5 +-
>>  arch/arm64/include/asm/mmu.h     |   8 +
>>  arch/arm64/include/asm/pgtable.h |   4 -
>>  arch/arm64/kernel/cpufeature.c   |  10 +-
>>  arch/arm64/mm/fixmap.c           |  11 +
>>  arch/arm64/mm/mmu.c              | 364 +++++++++++++++++++++++--------
>>  include/linux/pgtable.h          |   8 +
>>  7 files changed, 307 insertions(+), 103 deletions(-)
>>
>> --
>> 2.25.1
>>


