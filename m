Return-Path: <linux-kernel+bounces-139518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1078A03E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08891F238B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D322085;
	Wed, 10 Apr 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V78ag95D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C25138E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790942; cv=none; b=gJ5ZvtxS08vcgGFTSwCJAvaugqGsQY56pn7by+EAVFldenhLcRs7B7QY64Ez34wwgsrsxwA7Qd5rmNsXVZc0Ba8yzQ3h4aUrkmJQrSEiEN54X/N4WwrQLZpkwbGfMthmDdKW0lo9yJzis2Dkz6v5FMKnIqXqtHYrW6GV4BZ04Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790942; c=relaxed/simple;
	bh=RG8EDwScn2pYwAp6imeAEaKH30shjBDDs2FDWBIIxsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSL8/qWV6kxhPBVtzEsNIi98gaUBP/b3acfxmJmITfZQQsX5qJOdj3o+9sORacYIRm+pkkEUiTiOrwug+1/vg2/wNcuzap38H6J2tCsWjvuQd9MUMCjaMalyji+Q5zmTvwH17cxlmRvk1t7iDCaIrjjRM0dElk2aT2xsUObf5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V78ag95D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB5FC433C7;
	Wed, 10 Apr 2024 23:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712790942;
	bh=RG8EDwScn2pYwAp6imeAEaKH30shjBDDs2FDWBIIxsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V78ag95DM2OQzdzXqdQc0VPA12CdXdwyKfa/n0L8utxcuegK+NFdYhB8xZ9cPOgxE
	 UT7vbVQ7pDnUSgtSc3EMQbuCT5GMTp1JeUdEQaEiUCRQ6SC7xLMZaT2mObm9UtbqLg
	 uFWWu+6AX5UG5D1LqDG/38bpXJn6Zo0/cjcG9x8AXYcS1LKDuf6rlPuNOndOQTACgC
	 ebl5LTM5WwjDsUDELVHz/ZPxm4uIfc50KtSzdUFTCj82Omyp8PdwgjOj4TBaD2udPM
	 INJ+q+mwv1+WXyUOpdyAAv3TMqW8dtmjXAatq88UZFwAUCCgo0imrLHR9wwcE67gFL
	 Z3mX3vUgQBlyQ==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
Date: Wed, 10 Apr 2024 16:15:38 -0700
Message-Id: <20240410231538.131175-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409082631.187483-6-21cnbao@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Barry,

On Tue,  9 Apr 2024 20:26:31 +1200 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> Currently, we are handling the scenario where we've hit a
> large folio in the swapcache, and the reclaiming process
> for this large folio is still ongoing.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/huge_mm.h | 1 +
>  mm/huge_memory.c        | 2 ++
>  mm/memory.c             | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c8256af83e33..b67294d5814f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -269,6 +269,7 @@ enum mthp_stat_item {
>  	MTHP_STAT_ANON_ALLOC_FALLBACK,
>  	MTHP_STAT_ANON_SWPOUT,
>  	MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +	MTHP_STAT_ANON_SWPIN_REFAULT,
>  	__MTHP_STAT_COUNT
>  };
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d8d2ed80b0bf..fb95345b0bde 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
>  
>  static struct attribute *stats_attrs[] = {
>  	&anon_alloc_attr.attr,
>  	&anon_alloc_fallback_attr.attr,
>  	&anon_swpout_attr.attr,
>  	&anon_swpout_fallback_attr.attr,
> +	&anon_swpin_refault_attr.attr,
>  	NULL,
>  };
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 9818dc1893c8..acc023795a4d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		nr_pages = nr;
>  		entry = folio->swap;
>  		page = &folio->page;
> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
>  	}

From the latest mm-unstable tree, I get below kunit build failure and
'git bisect' points this patch.

    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
    [16:07:40] Configuring KUnit Kernel ...
    [16:07:40] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    Building with:
    $ make ARCH=um O=../kunit.out/ --jobs=36
    ERROR:root:.../mm/memory.c: In function ‘do_swap_page’:
    .../mm/memory.c:4169:17: error: implicit declaration of function ‘count_mthp_stat’ [-Werror=implicit-function-declaration]
     4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
          |                 ^~~~~~~~~~~~~~~
    .../mm/memory.c:4169:53: error: ‘MTHP_STAT_ANON_SWPIN_REFAULT’ undeclared (first use in this function)
     4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
          |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    .../mm/memory.c:4169:53: note: each undeclared identifier is reported only once for each function it appears in
    cc1: some warnings being treated as errors

My kunit build config doesn't have CONFIG_TRANSPARE_HUGEPAGE.  Maybe that's the
reason and this patch, or the patch that introduced the function and the enum
need to take care of the case?


Thanks,
SJ

[...]

