Return-Path: <linux-kernel+bounces-141297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F38A1C41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B4C2861BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817A15CD46;
	Thu, 11 Apr 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM38g1xS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74915B986
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852069; cv=none; b=KAulxWl8jCcZ/NmzoGtgX9Pfh21VSmgjxLV/EyG9UFfc3WVGRCc7Vfs8lJKViDGTB2n9SCnCvoftIYLHA/t9fgU7UOw5MoZVelJ1zY67aybwEhBfhzEBU6oD7s7U3kEUVdzlpJ1PjLw1b4/5G3vzyCR0YgQIfMDJd2HRxPhTMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852069; c=relaxed/simple;
	bh=uy6pGGPi2qIFBjcqu+esBQhfAfEpW75so9lpYL8foVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQ0yK4Wpc05Ejf2ym47QUvEgBqxCGoAJxrASRyVmUv136anYBCwJ7RP1VNAgcJBDRAsi3/LPxQ4L+47h25uh6JeCBoSqlWPzKYYc3f7orM0Ch9AZ0kLhfJweUJy3hLAeJrveUKU7HqDt6lJ4O1u7a0BWcX+Mne4h3to7R/TSkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM38g1xS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B668C113CD;
	Thu, 11 Apr 2024 16:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852068;
	bh=uy6pGGPi2qIFBjcqu+esBQhfAfEpW75so9lpYL8foVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YM38g1xSJomnSJBxpc1G3XJXuXFXfzuZmZw9W1ZEJ2gQ5zLFk89wRK3YeEd05lTLE
	 AAQ5RrPsZ5STh/Mt3QsaebAuGXzLhY0x8u9SLtyZjSLakLJFJsOPWjUHpDYpQw4UsE
	 EGpr+8ZyDBFn0cJIG0DdXdWmcKPdYbHUmmc3RgjxJyX7211rYBWIDupiicGBP5ulWC
	 pU8h5N9KPShuMKX+zU5CTgJIwDXvd2hwSdddZaIhBWMU6GOshdqKWpzhP3BCMhNy2g
	 xirdpOcf8E+xuqkj36d9IEYmTi06aCT/RwyYVyb///3tCpj5gaiPT7lAiPhSSDeVQ0
	 Rg0oZvpbCDGEw==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
Date: Thu, 11 Apr 2024 09:14:25 -0700
Message-Id: <20240411161425.77677-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411014636.14023-1-21cnbao@gmail.com>
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

On Thu, 11 Apr 2024 13:46:36 +1200 Barry Song <21cnbao@gmail.com> wrote:

> >> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
> >>  	}
> >> 
> > From the latest mm-unstable tree, I get below kunit build failure and
> > 'git bisect' points this patch.
> > 
> >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> >     [16:07:40] Configuring KUnit Kernel ...
> >     [16:07:40] Building KUnit Kernel ...
> >     Populating config with:
> >     $ make ARCH=um O=../kunit.out/ olddefconfig
> >     Building with:
> >     $ make ARCH=um O=../kunit.out/ --jobs=36
> >     ERROR:root:.../mm/memory.c: In function ‘do_swap_page’:
> >     .../mm/memory.c:4169:17: error: implicit declaration of function ‘count_mthp_stat’ [-Werror=implicit-function-declaration]
> >      4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
> >           |                 ^~~~~~~~~~~~~~~
> >     .../mm/memory.c:4169:53: error: ‘MTHP_STAT_ANON_SWPIN_REFAULT’ undeclared (first use in this function)
> >      4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
> >           |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     .../mm/memory.c:4169:53: note: each undeclared identifier is reported only once for each function it appears in
> >     cc1: some warnings being treated as errors
> > 
> > My kunit build config doesn't have CONFIG_TRANSPARE_HUGEPAGE.  Maybe that's the
> > reason and this patch, or the patch that introduced the function and the enum
> > need to take care of the case?
> 
> Hi SeongJae,
> Thanks very much, can you check if the below fix the build? If yes, I will
> include this fix while sending v3.

Thank you for quick and kind reply :) I confirmed this fixes the build failure.

> 
> Subject: [PATCH] mm: fix build errors on CONFIG_TRANSPARENT_HUGEPAGE=N
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index acc023795a4d..1d587d1eb432 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4142,6 +4142,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>  			&vmf->ptl);
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* We hit large folios in swapcache */
>  	if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio)) {
>  		int nr = folio_nr_pages(folio);
> @@ -4171,6 +4172,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>  check_pte:
> +#endif
>  	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
>  		goto out_nomap;
>  
> -- 
> 2.34.1
> 
> 

