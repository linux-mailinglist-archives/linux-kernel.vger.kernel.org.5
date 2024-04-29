Return-Path: <linux-kernel+bounces-163010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B88B6365
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F462835CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D281411F2;
	Mon, 29 Apr 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo8u/OKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CE1411E4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422043; cv=none; b=h0XwNqhwytkKA/YoFPECtNhGdKWtZS05fPnaAe+3ZyTDCDLUZsgVNHAXcg6I6MZOBs/45YF+r2zall1ah1MEdPiWNJqd+9Kf2tCjkBGIJ2T/v4nzcbpjz0IQ6+gzh2c+5eFQ/Cj3RxK5mBGpWuf9o8aWObXXxY2MKSJR4CEZFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422043; c=relaxed/simple;
	bh=wPkf1AvhBcq0B1qbhRRs+Vbu1NpYyvhkCNxOzOM6p18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0sv9+5xnmq4EwQodMjoj7OXvRuoWuYFAk1IWAxNlw4TavVnHdb2jO3DH/rKmopzpB3mJGFwtfnGnjupt8dsyVvOa8YW+JKOcsPkUm2Ij7P8Gx/gIlJIaUzHDcHWnsNZ9oSj7di2p81+Qblz8VgydxU+ttZxavRYfSDEplqdBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo8u/OKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EBDC4AF18;
	Mon, 29 Apr 2024 20:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714422043;
	bh=wPkf1AvhBcq0B1qbhRRs+Vbu1NpYyvhkCNxOzOM6p18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uo8u/OKvUVKxZhfhuQUBaKTDZlofaBJv5TyfDGjuVGenTpku0rm16lDKssLOaDLQ2
	 4VLRD6e4or/raRlyHJSKyqSR0Q98es7hIcLhJTyEGGxWdKp+vvQ8nCqy6Bz9DQoAXg
	 C1Ngu4aUxv0LlMbvpoPxAjUqkTZrbDsTgOss5Vrwnl661WFadpsPkztL1oWC1OlN3+
	 3pjRec0V6xxIQevVSwsvGjQaWEmGNqhsws0wew0f5UrNDhmtjqkztrRgTkSKryoA85
	 97ZHY6mo7rzY2QusBP32qZjAp2dzXqq79nxmvWlR8l4weUVFvD6KHfmTtRWYJnyzVf
	 zPDkgyKouv7tQ==
From: SeongJae Park <sj@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	willy@infradead.org,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
Date: Mon, 29 Apr 2024 13:20:40 -0700
Message-Id: <20240429202040.187453-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429132308.38794-3-ioworker0@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lance,

On Mon, 29 Apr 2024 21:23:07 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> folios, start the pagewalk first, then call split_huge_pmd_address()
> to split the folio.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h |  2 ++
>  mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
>  mm/rmap.c               | 26 +++++++++++++++++++------
>  3 files changed, 44 insertions(+), 26 deletions(-)
> 
[...]
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7e2575d669a9..e42f436c7ff3 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  	if (flags & TTU_SYNC)
>  		pvmw.flags = PVMW_SYNC;
>  
> -	if (flags & TTU_SPLIT_HUGE_PMD)
> -		split_huge_pmd_address(vma, address, false, folio);
> -
>  	/*
>  	 * For THP, we have to assume the worse case ie pmd for invalidation.
>  	 * For hugetlb, it could be much worse if we need to do pud
> @@ -1650,6 +1647,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  	range.end = vma_address_end(&pvmw);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				address, range.end);
> +	if (flags & TTU_SPLIT_HUGE_PMD) {
> +		range.start = address & HPAGE_PMD_MASK;
> +		range.end = (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
> +	}

I found the latest mm-unstable fails one[1] of my build configuration
with below error message.  And 'git bisect' points this patch.

      CC      mm/rmap.o
    In file included from <command-line>:
    .../linux/mm/rmap.c: In function 'try_to_unmap_one':
    .../linux/include/linux/compiler_types.h:460:38: error: call to '__compiletime_assert_455' declared with attribute error: BUILD_BUG failed
      460 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |                                      ^
    .../linux/include/linux/compiler_types.h:441:4: note: in definition of macro '__compiletime_assert'
      441 |    prefix ## suffix();    \
          |    ^~~~~~
    .../linux/include/linux/compiler_types.h:460:2: note: in expansion of macro '_compiletime_assert'
      460 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
          |  ^~~~~~~~~~~~~~~~~~~
    .../linux/include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
          |                                     ^~~~~~~~~~~~~~~~~~
    .../linux/include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
       59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
          |                     ^~~~~~~~~~~~~~~~
    .../linux/include/linux/huge_mm.h:97:28: note: in expansion of macro 'BUILD_BUG'
       97 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
          |                            ^~~~~~~~~
    .../linux/include/linux/huge_mm.h:104:34: note: in expansion of macro 'HPAGE_PMD_SHIFT'
      104 | #define HPAGE_PMD_SIZE ((1UL) << HPAGE_PMD_SHIFT)
          |                                  ^~~~~~~~~~~~~~~
    .../linux/include/linux/huge_mm.h:103:27: note: in expansion of macro 'HPAGE_PMD_SIZE'
      103 | #define HPAGE_PMD_MASK (~(HPAGE_PMD_SIZE - 1))
          |                           ^~~~~~~~~~~~~~
    .../linux/mm/rmap.c:1651:27: note: in expansion of macro 'HPAGE_PMD_MASK'
     1651 |   range.start = address & HPAGE_PMD_MASK;
          |                           ^~~~~~~~~~~~~~

I haven't looked into the code yet, but seems this code need to handle
CONFIG_PGTABLE_HAS_HUGE_LEAVES undefined case?  May I ask your opinion?

[1] https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_arm64.sh


Thanks,
SJ
[...]

