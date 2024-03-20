Return-Path: <linux-kernel+bounces-108297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651F8808E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD65428479F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E0EDC;
	Wed, 20 Mar 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKOpz1ce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE936AAD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896896; cv=none; b=D1C5Skuek0Y+LcPEipYWCzlRGBod75NMf2UZY7amx4wlvz32N7j4NG/+x4COeYMnxg9hmVgCdmk94ZH28PvmTVJBrNXHuvwyH5Bx4SBeMUabbm4kjfRIazu874LX1VspIbUJotD3ol1scqbFN9qfA+XPayO2pcIPZkZE3cl32HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896896; c=relaxed/simple;
	bh=nnMf808ajpnDLmond0xA2ZLLqRSciBTRCP3q7GcYqYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IK8nbpvRifGAefK0WL/zH9Uii9RjOFf6IeTsPQeKM7MwqjqH4DczXl48CsVZSoY5+M/pSi++TXR/fb5DGmp/SuTX+zsH3gOpS5UJP6KtBFvayNEw8xWELQfhlY3zMM2bCBN8sxNn71ZNYZOEIfsVzLxxgSGhfIDmX1OKacpWfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKOpz1ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC48C433F1;
	Wed, 20 Mar 2024 01:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710896896;
	bh=nnMf808ajpnDLmond0xA2ZLLqRSciBTRCP3q7GcYqYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKOpz1ceVhYxg0iOs/mEJqd/YUABBTvuStL3MPaexagY79bO7sgFpQKVBy/y9Phc7
	 RWEYxByOG3O9ytDXIkOrZ2tM3Hyz3zDsKsDxNG6YeOkCVtZGSH4VShgZbOzBx6g820
	 MYO7zKI2f+3dU+bUT5Rei+wDY7ZyDUcryxTNTpgbkwMRv4OzIeTpni+EUHudMgv1BA
	 2BhPYI6arblArpiD47Qzm5x/djXSOZAAgENoaYjDslEFVJjeXsdaffyesRP/X4+nbo
	 5BjE0WHxYCHhJ9G66k0GVAxh1p+H6nzz1lUv3svx5B83KBn+kxlgnk0/lLTy4BkJtz
	 w17ryKKIXyd8A==
From: SeongJae Park <sj@kernel.org>
To: Zi Yan <zi.yan@sent.com>
Cc: linux-mm@kvack.org,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/migrate: split source folio if it is on deferred split list
Date: Tue, 19 Mar 2024 18:08:13 -0700
Message-Id: <20240320010813.136765-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319154753.253262-1-zi.yan@sent.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 19 Mar 2024 11:47:53 -0400 Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> If the source folio is on deferred split list, it is likely some subpages
> are not used. Split it before migration to avoid migrating unused subpages.
> 
> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> did not check if a THP is on deferred split list before migration, thus,
> the destination THP is never put on deferred split list even if the source
> THP might be. The opportunity of reclaiming free pages in a partially
> mapped THP during deferred list scanning is lost, but no other harmful
> consequence is present[1].
> 
> From v2:
> 1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].
> 
> From v1:
> 1. Used dst to get correct deferred split list after migration
>    (per Ryan Roberts).
> 
> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 22 ------------------
>  mm/internal.h    | 23 +++++++++++++++++++
>  mm/migrate.c     | 60 +++++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 72 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9859aa4f7553..c6d4d0cdf4b3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  	return pmd;
>  }
>  
> -#ifdef CONFIG_MEMCG
> -static inline
> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> -{
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> -
> -	if (memcg)
> -		return &memcg->deferred_split_queue;
> -	else
> -		return &pgdat->deferred_split_queue;
> -}
> -#else
> -static inline
> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> -{
> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> -
> -	return &pgdat->deferred_split_queue;
> -}
> -#endif
> -
>  void folio_prep_large_rmappable(struct folio *folio)
>  {
>  	if (!folio || !folio_test_large(folio))
> diff --git a/mm/internal.h b/mm/internal.h
> index d1c69119b24f..8fa36e84463a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  				   unsigned long addr, pmd_t *pmd,
>  				   unsigned int flags);
>  
> +#ifdef CONFIG_MEMCG
> +static inline
> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
> +{
> +	struct mem_cgroup *memcg = folio_memcg(folio);
> +	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> +
> +	if (memcg)
> +		return &memcg->deferred_split_queue;
> +	else
> +		return &pgdat->deferred_split_queue;
> +}
> +#else
> +static inline
> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
> +{
> +	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> +
> +	return &pgdat->deferred_split_queue;
> +}
> +#endif

I found this breaks the build when CONFIG_TRANSPARENT_HUGEPAGE is not set, with
below error:

    .../lib/../mm/internal.h: In function 'get_deferred_split_queue':
    .../lib/../mm/internal.h:1127:22: error: 'struct pglist_data' has no member named 'deferred_split_queue'
     1127 |         return &pgdat->deferred_split_queue;
          |                      ^~

Since the code was in hugepage.c, maybe the above chunk need to be wrapped by
#ifdef CONFIG_TRANSPARENT_HUGEPAGE?  I confirmed below change is fixing the
build on my setup.


Thanks,
SJ

[...]

-------------------------------------- >8 -------------------------------------
diff --git a/mm/internal.h b/mm/internal.h
index dce2b9f5e6cd..fe9f69ceb140 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1106,6 +1106,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
                                   unsigned long addr, pmd_t *pmd,
                                   unsigned int flags);

+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifdef CONFIG_MEMCG
 static inline
 struct deferred_split *get_deferred_split_queue(struct folio *folio)
@@ -1126,7 +1127,8 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)

        return &pgdat->deferred_split_queue;
 }
-#endif
+#endif /* CONFIG_MEMCG */
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */


 /*

