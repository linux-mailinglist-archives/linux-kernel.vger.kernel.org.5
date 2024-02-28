Return-Path: <linux-kernel+bounces-84265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B718586A454
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74801C24062
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90ED4A1A;
	Wed, 28 Feb 2024 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuEpe6D9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399943FE1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079306; cv=none; b=Ey0sVe198+c+JpQkKdGckY2rvjOKeUreL9VCwBQqyD7A5AQ3sm1qyyoo+k24MmLsNu2wWB/CNTLGHGJxn9udFdw9QHbxuWEvyve4nsMigyjcEYXF7dCLil7bdndUAFastp+h+5eSX9njKaPhe7MgROwTFcLwdBOkCjC8FjYsyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079306; c=relaxed/simple;
	bh=OdKHnKl7doxKIzicvERJ1M7c5v4jJA6BjcEqfg89J+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0BZcyRWvzedknmv8L62nG+V/LJHPI0R5g7ZDlH3H4CimX+wzcThhf1xErcJPKO7sBMcuMCz375UOOEWKy88QilXAV8OmwjJD5OCl6ruJl3241F+hBSYRfB+wR6Vg60szGdPDTxGHmlg5FiEhzHgSOT3+uzY2vcedASc1yKOBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuEpe6D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9120C433F1;
	Wed, 28 Feb 2024 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709079305;
	bh=OdKHnKl7doxKIzicvERJ1M7c5v4jJA6BjcEqfg89J+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuEpe6D9vtju2zi5caO/QSjUV4lsptwksUFatD2c5sJ57T9lNhA0SeCRsTtqWHDfM
	 AB6VwCOVTc/2+6HPHyvsivHV2PTBBwoHjfbOJ+d+IutkU6fKgp3l6fTIphkXOYz1BZ
	 AeoiUxxcYoHOaGfkCj7+eBY55mqE4azb7mbHHHbVOUkF0YutvmNs/nw49UIwVs4U0n
	 Y6us+NUjbtoeAPRVWNg5FVvlhNIAn+WWfVfj5DEVfkdp7m0/KKki95jVMnKkIVP75e
	 Rjvv1Zo7REHfHSIWyDjpgUdLhzAiwohwxRFCUIejuwFh6U4uNOAeQFicCtisoruu29
	 yYCEhJRraee0w==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>
Subject: Re: [PATCH v2] mm: make folio_pte_batch available outside of mm/memory.c
Date: Tue, 27 Feb 2024 16:15:01 -0800
Message-Id: <20240228001501.160138-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGsJ_4wWzG-37D82vqP_zt+Fcbz+URVe5oXLBc4M5wbN8A_gpQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 13:10:06 +1300 Barry Song <21cnbao@gmail.com> wrote:

> On Wed, Feb 28, 2024 at 10:54 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Tue, 27 Feb 2024 23:42:01 +1300 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > madvise, mprotect and some others might need folio_pte_batch to check if
> > > a range of PTEs are completely mapped to a large folio with contiguous
> > > physical addresses. Let's make it available in mm/internal.h.
> >
> > Hi Barry,
> >
> >
> > I found this patch makes some of my build test that not setting CONFIG_MMU
> > fails with multiple errors including below:
> >
> >     In file included from .../mm/nommu.c:43:
> >     .../mm/internal.h: In function '__pte_batch_clear_ignored':
> >     .../mm/internal.h:98:23: error: implicit declaration of function 'pte_mkclean'; did you mean 'page_mkclean'? [-Werror=implicit-function-declaration]
> >        98 |                 pte = pte_mkclean(pte);
> >           |                       ^~~~~~~~~~~
> >           |                       page_mkclean
> >
> > Enabling CONFIG_MMU made the build success.  I haven't had a time to look into
> > the code yet.  May I ask your opinion?
> 
> i guess it is because we have moved some func from memory.c to
> headfile. and this headfile is included by lots of
> files in mm.  memory.c, for itself, will only be compiled with enabled
> CONFIG_MMU:
> mmu-$(CONFIG_MMU)       := highmem.o memory.o mincore.o \
>                            mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
>                            msync.o page_vma_mapped.o pagewalk.o \
>                            pgtable-generic.o rmap.o vmalloc.o
> 
> Does the below fix your build?
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index fa9e2f7db506..4e57680b74e1 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -83,6 +83,8 @@ static inline void *folio_raw_mapping(struct folio *folio)
>         return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>  }
> 
> +#ifdef CONFIG_MMU
> +
>  /* Flags for folio_pte_batch(). */
>  typedef int __bitwise fpb_t;
> 
> @@ -172,6 +174,7 @@ static inline int folio_pte_batch(struct folio
> *folio, unsigned long addr,
> 
>         return min(ptep - start_ptep, max_nr);
>  }
> +#endif /* CONFIG_MMU */
> 
>  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>                                                 int nr_throttled);

Yes, applying the above diff fixed mine :)


Thanks,
SJ

[...]

