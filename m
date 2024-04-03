Return-Path: <linux-kernel+bounces-129638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E4896DA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF6D1F27903
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FE4141987;
	Wed,  3 Apr 2024 11:06:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC26135A5F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142394; cv=none; b=V5hLbV1Gbp62z2BcO7hEhidHM7a/dGi8VJDLr8kyVJc/bQI8RQqozqLgYjfcfrdQicWBJW55zL4bb4NwQ3JBY2WVWjEE2M3ydmkG8JwQjmOOUlBGCdwd5ozO0a3d+JLq06lUtpAkK7/bWCq7l55tUe2K5nZqMsnqbEdkajXGsoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142394; c=relaxed/simple;
	bh=Oe3Jdl4RWGcnPaKdQmGWYoniShsC0VVS9hxDqaL/GdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEwSAX6L8RUXiXsduCBQI+2oWJhs6ZD0Z2RVWsGL53hW2FIiYM0YA848WnFll97OQ+sE8ym14Se41FkOPL1seQ9N5HwEyPVdPFgbSQTLTys+NQC2wjSwwkn2viRBHaot3Dv30gryZMf5m1pnL+L8gmRVONVHYjAAYGlFWgXiM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D30E21595;
	Wed,  3 Apr 2024 04:07:02 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38F4C3F64C;
	Wed,  3 Apr 2024 04:06:30 -0700 (PDT)
Message-ID: <dfb0873f-3559-4979-94d1-39c4a7a4ca3c@arm.com>
Date: Wed, 3 Apr 2024 12:06:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm/gup: fixups for hugetlb gup rework series
Content-Language: en-GB
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, David Hildenbrand
 <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev
References: <20240403013249.1418299-1-peterx@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240403013249.1418299-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 02:32, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Hi,
> 
> This is a small patchset that will fix two known issues that got reported
> today on the previous hugetlb unification series on slow gup [1].
> 
> The first issue was reported by Ryan Roberts [2] on a test failure over
> gup_longterm.  Patch 1-2 should fix it.  Tested with 32MB hugepages on
> arm64 VM.
> 
> The second issue was reported by Nathan Chancellor [3] on a build issue
> over loongson's defconfig (loongson3_defconfig).  It can be easily
> reproduced with my own build setup [4], while patch 3 fixes it, and should
> hopefully fix similar archs where pud_pfn() is not defined even if
> pud_leaf() can return true.
> 
> For the 2nd issue, it's debatable whether it's an arch issue, because
> logically speaking pud_pfn() and pud_leaf() should either be both defined
> or both not.  But since the current fix will be the simplest and still safe
> (I at least checked loongarch doesn't support either pud dax or pud
> hugetlb), I think we can consider having this to unbreak the build first,
> assuming this could also happen to other archs.
> 
> One note is that the last 2 patches should be squashed into corresponding
> patch, while the 1st patch should be kept standalone.
> 
> Thanks,
> 
> [1] https://lore.kernel.org/r/20240327152332.950956-1-peterx@redhat.com
> [2] https://lore.kernel.org/r/adfdd89b-ee56-4758-836e-c66a0be7de25@arm.com
> [3] https://lore.kernel.org/r/ZgyKLLVZ4vN56uZE@x1n
> [4] https://gitlab.com/peterx/lkb-harness/-/blob/main/config.json?ref_type=heads#L32
> 
> Peter Xu (3):
>   mm: Allow anon exclusive check over hugetlb tail pages
>   fixup! mm/gup: handle huge pmd for follow_pmd_mask()
>   fixup! mm/arch: provide pud_pfn() fallback
> 
>  include/linux/page-flags.h |  8 +++++++-
>  include/linux/pgtable.h    |  6 +++++-
>  mm/gup.c                   |  3 ---
>  mm/internal.h              | 10 ----------
>  4 files changed, 12 insertions(+), 15 deletions(-)
> 

With these applied, gup_longterm is now passing for me on arm64. So for the series:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>


