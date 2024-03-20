Return-Path: <linux-kernel+bounces-108318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F488091F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B1284572
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3469748E;
	Wed, 20 Mar 2024 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+GmKUdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE22C9A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898715; cv=none; b=hTJRju3lMr3cZHsBirezMRiz5AY2bAAb/LWk8Q2jziPo+tqiHt578yJVcnrW55FMlQIzlrZqQfTqVMq+xRxJg+eh6mGmyzEpFoMTVDQdTRIHdFEQtdTZqvNj4zTK+/IuvFe54lPnsTS5d1oIqHxKiNgAPNaJme1apz4iJ6u4wyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898715; c=relaxed/simple;
	bh=CvGzi2JUuAESgZ3a+287tNAc0BTPO9JfC0auMivjC9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKERu8i6ofTbBoyMjntzQmYfQ86f86QRAt2LGricILI2kifXqMeeEyqeOvigJKqh0CIpaWzkT9AgVd4HQPcOwpk/Ia8chcd7ztAlw366nZf5BSuotT4Ey2nk5uL/Gw9ZcWU8i9RutwfSbgcnOhLrKNOU6FdLpMME8dznTv/JC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+GmKUdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5D7C43390;
	Wed, 20 Mar 2024 01:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710898714;
	bh=CvGzi2JUuAESgZ3a+287tNAc0BTPO9JfC0auMivjC9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+GmKUdhLTLW1RpyyMsNGAHJ/aHHsO/p2tz2+QWIWw3aylQ9shXLEEyefkBdYFM9L
	 ahsOKMwAuDxbohgfjOeFlEwAeL8MJSfEGQ3iztdJK+ei+o2srXhPOB3qNPiaoOJ3wN
	 WoZUJ1yokm5E2W+LIwAkE+TvOHxHEUcM2YxGnc+i/9NO0Vg44+9UyU2HIOqmDsMvGk
	 5aMO8YPjqI/c7YUPz30Ijx1fi+mAz8zcg+QcmY5TqubGohG3lH8HO5gH7O1wMRIYlK
	 oYthDE/ArcmvMuUojosRO9Euf1cz8Pvboo4pqQzdH1tcTpcMmW53EmyIr+Ik5HjE4E
	 b44bpO/CJlwYg==
From: SeongJae Park <sj@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/migrate: split source folio if it is on deferred split list
Date: Tue, 19 Mar 2024 18:38:31 -0700
Message-Id: <20240320013831.119613-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <28D1C313-8333-4F87-9B1D-47E77789A853@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Mar 2024 21:16:37 -0400 Zi Yan <ziy@nvidia.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 4354 bytes --]
> 
> On 19 Mar 2024, at 21:09, Zi Yan wrote:
> 
> > On 19 Mar 2024, at 21:08, SeongJae Park wrote:
> >
> >> Hello,
> >>
> >> On Tue, 19 Mar 2024 11:47:53 -0400 Zi Yan <zi.yan@sent.com> wrote:
> >>
> >>> From: Zi Yan <ziy@nvidia.com>
> >>>
> >>> If the source folio is on deferred split list, it is likely some subpages
> >>> are not used. Split it before migration to avoid migrating unused subpages.
> >>>
> >>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> >>> did not check if a THP is on deferred split list before migration, thus,
> >>> the destination THP is never put on deferred split list even if the source
> >>> THP might be. The opportunity of reclaiming free pages in a partially
> >>> mapped THP during deferred list scanning is lost, but no other harmful
> >>> consequence is present[1].
> >>>
> >>> From v2:
> >>> 1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].
> >>>
> >>> From v1:
> >>> 1. Used dst to get correct deferred split list after migration
> >>>    (per Ryan Roberts).
> >>>
> >>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
> >>> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
> >>>
> >>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> >>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>> ---
> >>>  mm/huge_memory.c | 22 ------------------
> >>>  mm/internal.h    | 23 +++++++++++++++++++
> >>>  mm/migrate.c     | 60 +++++++++++++++++++++++++++++++++++++++---------
> >>>  3 files changed, 72 insertions(+), 33 deletions(-)
> >>>
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 9859aa4f7553..c6d4d0cdf4b3 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
> >>>  	return pmd;
> >>>  }
> >>>
> >>> -#ifdef CONFIG_MEMCG
> >>> -static inline
> >>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> >>> -{
> >>> -	struct mem_cgroup *memcg = folio_memcg(folio);
> >>> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> >>> -
> >>> -	if (memcg)
> >>> -		return &memcg->deferred_split_queue;
> >>> -	else
> >>> -		return &pgdat->deferred_split_queue;
> >>> -}
> >>> -#else
> >>> -static inline
> >>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> >>> -{
> >>> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> >>> -
> >>> -	return &pgdat->deferred_split_queue;
> >>> -}
> >>> -#endif
> >>> -
> >>>  void folio_prep_large_rmappable(struct folio *folio)
> >>>  {
> >>>  	if (!folio || !folio_test_large(folio))
> >>> diff --git a/mm/internal.h b/mm/internal.h
> >>> index d1c69119b24f..8fa36e84463a 100644
> >>> --- a/mm/internal.h
> >>> +++ b/mm/internal.h
> >>> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
> >>>  				   unsigned long addr, pmd_t *pmd,
> >>>  				   unsigned int flags);
> >>>
> >>> +#ifdef CONFIG_MEMCG
> >>> +static inline
> >>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
> >>> +{
> >>> +	struct mem_cgroup *memcg = folio_memcg(folio);
> >>> +	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> >>> +
> >>> +	if (memcg)
> >>> +		return &memcg->deferred_split_queue;
> >>> +	else
> >>> +		return &pgdat->deferred_split_queue;
> >>> +}
> >>> +#else
> >>> +static inline
> >>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
> >>> +{
> >>> +	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> >>> +
> >>> +	return &pgdat->deferred_split_queue;
> >>> +}
> >>> +#endif
> >>
> >> I found this breaks the build when CONFIG_TRANSPARENT_HUGEPAGE is not set, with
> >> below error:
> >>
> >>     .../lib/../mm/internal.h: In function 'get_deferred_split_queue':
> >>     .../lib/../mm/internal.h:1127:22: error: 'struct pglist_data' has no member named 'deferred_split_queue'
> >>      1127 |         return &pgdat->deferred_split_queue;
> >>           |                      ^~
> >>
> >> Since the code was in hugepage.c, maybe the above chunk need to be wrapped by
> >> #ifdef CONFIG_TRANSPARENT_HUGEPAGE?  I confirmed below change is fixing the
> >> build on my setup.
> >
> > Thanks. Will fix it in the next version.
> 
> Actually, since get_deferred_split_queue() is used in mm/migrate.c, that
> part needs to be guarded by CONFIG_TRANSPARENT_HUGEPAGE as well.

You're right.  I also just confirmed that build breaks with below error when
CONFIG_TRANSPARENT_HUGEPAGE is not set but CONFIG_MIGRATION is set.

    ERROR:root:.../mm/migrate.c: In function ‘migrate_pages_batch’:
    .../mm/migrate.c:1682:49: error: implicit declaration of function ‘get_deferred_split_queue’ [-Werror=implicit-function-declaration]
     1682 |                                                 get_deferred_split_queue(folio);
          |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~


Thanks,
SJ

> 
> --
> Best Regards,
> Yan, Zi

