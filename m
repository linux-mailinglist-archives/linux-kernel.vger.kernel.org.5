Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA47858CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjHWNQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjHWNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F90E10EA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA2666204
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D18C43397
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796562;
        bh=QKJJjn83ob/5yAvKizopvqVOkgvZuyTTOxo11SmLPkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uxcVM/Uew7ziubZulJw+nXt08z8kJg6XEQIU1UXhLnmPsTrUk68Udqy0xtW0rEPk2
         1qiYxJiszz19EOtKo5hHObRclvfYbvnDmgnb8sM7GrqP7jJMEFtaJBO7xqjC0Oa+nO
         DxiWBzITW/5jlJZFItzgnf7R+t62EnNAjUvUQFbpEuA45+K7X8L+W5iPJgCxYPSTxE
         ND5JmV3dqAF0T1pTc5H2njgVbPJgIku7s8bIsqGBQb36G+Rq6CdR53+zaxfBL3i8vi
         0by3PTZLVswDx7l+Uo/MzC9no+JuccBm7dbXqM0S7SryoFZ++NMOdnNRHrcp9HwofP
         XYiFOwD3hK3+Q==
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-565403bda57so3203859a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:16:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YznkBpfCkKEu7w08cPbvda2FDoXfEQLr/NE/WOUffh+4qDh/0T8
        6b/ItkalYZkWQb5iZtWPMgXJfe1t6tx8akA9wNIo9A==
X-Google-Smtp-Source: AGHT+IH+O0B1KAVPtpf0VVTwHJlGhbqctSJ12fUVZjMaR0qnmyfct1bdMkpPCvkqlXhi+UC9QT/4rJVi4Kt5r8+lyVY=
X-Received: by 2002:a17:90b:2251:b0:26f:a180:8675 with SMTP id
 hk17-20020a17090b225100b0026fa1808675mr3483905pjb.19.1692796561809; Wed, 23
 Aug 2023 06:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230821160849.531668-1-david@redhat.com> <20230821160849.531668-4-david@redhat.com>
In-Reply-To: <20230821160849.531668-4-david@redhat.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 23 Aug 2023 06:15:49 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMAt4ACLYE9fLwiqjdTjG82d0Nt_V4xKnrR-FejiQuX-w@mail.gmail.com>
Message-ID: <CAF8kJuMAt4ACLYE9fLwiqjdTjG82d0Nt_V4xKnrR-FejiQuX-w@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 3/4] mm/swap: inline folio_set_swap_entry()
 and folio_swap_entry()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Chris Li <chrisl@kernel.org>

Chris

On Mon, Aug 21, 2023 at 9:09=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Let's simply work on the folio directly and remove the helpers.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/swap.h | 12 +-----------
>  mm/memory.c          |  2 +-
>  mm/shmem.c           |  6 +++---
>  mm/swap_state.c      |  7 +++----
>  mm/swapfile.c        |  2 +-
>  mm/util.c            |  2 +-
>  mm/vmscan.c          |  2 +-
>  mm/zswap.c           |  4 ++--
>  8 files changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 82859a1944f5..603acf813873 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -333,25 +333,15 @@ struct swap_info_struct {
>                                            */
>  };
>
> -static inline swp_entry_t folio_swap_entry(struct folio *folio)
> -{
> -       return folio->swap;
> -}
> -
>  static inline swp_entry_t page_swap_entry(struct page *page)
>  {
>         struct folio *folio =3D page_folio(page);
> -       swp_entry_t entry =3D folio_swap_entry(folio);
> +       swp_entry_t entry =3D folio->swap;
>
>         entry.val +=3D page - &folio->page;
>         return entry;
>  }
>
> -static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t=
 entry)
> -{
> -       folio->swap =3D entry;
> -}
> -
>  /* linux/mm/workingset.c */
>  bool workingset_test_recent(void *shadow, bool file, bool *workingset);
>  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_=
pages);
> diff --git a/mm/memory.c b/mm/memory.c
> index ff13242c1589..c51800dbfa9b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3831,7 +3831,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                                 folio_add_lru(folio);
>
>                                 /* To provide entry to swap_readpage() */
> -                               folio_set_swap_entry(folio, entry);
> +                               folio->swap =3D entry;
>                                 swap_readpage(page, true, NULL);
>                                 folio->private =3D NULL;
>                         }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7a0c1e19d9f8..fc1afe9dfcfe 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1657,7 +1657,7 @@ static int shmem_replace_folio(struct folio **folio=
p, gfp_t gfp,
>         int error;
>
>         old =3D *foliop;
> -       entry =3D folio_swap_entry(old);
> +       entry =3D old->swap;
>         swap_index =3D swp_offset(entry);
>         swap_mapping =3D swap_address_space(entry);
>
> @@ -1678,7 +1678,7 @@ static int shmem_replace_folio(struct folio **folio=
p, gfp_t gfp,
>         __folio_set_locked(new);
>         __folio_set_swapbacked(new);
>         folio_mark_uptodate(new);
> -       folio_set_swap_entry(new, entry);
> +       new->swap =3D entry;
>         folio_set_swapcache(new);
>
>         /*
> @@ -1800,7 +1800,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         /* We have to do this with folio locked to prevent races */
>         folio_lock(folio);
>         if (!folio_test_swapcache(folio) ||
> -           folio_swap_entry(folio).val !=3D swap.val ||
> +           folio->swap.val !=3D swap.val ||
>             !shmem_confirm_swap(mapping, index, swap)) {
>                 error =3D -EEXIST;
>                 goto unlock;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 2f2417810052..b3b14bd0dd64 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -100,7 +100,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_=
t entry,
>
>         folio_ref_add(folio, nr);
>         folio_set_swapcache(folio);
> -       folio_set_swap_entry(folio, entry);
> +       folio->swap =3D entry;
>
>         do {
>                 xas_lock_irq(&xas);
> @@ -156,8 +156,7 @@ void __delete_from_swap_cache(struct folio *folio,
>                 VM_BUG_ON_PAGE(entry !=3D folio, entry);
>                 xas_next(&xas);
>         }
> -       entry.val =3D 0;
> -       folio_set_swap_entry(folio, entry);
> +       folio->swap.val =3D 0;
>         folio_clear_swapcache(folio);
>         address_space->nrpages -=3D nr;
>         __node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
> @@ -233,7 +232,7 @@ bool add_to_swap(struct folio *folio)
>   */
>  void delete_from_swap_cache(struct folio *folio)
>  {
> -       swp_entry_t entry =3D folio_swap_entry(folio);
> +       swp_entry_t entry =3D folio->swap;
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>
>         xa_lock_irq(&address_space->i_pages);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index bd9d904671b9..e52f486834eb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1536,7 +1536,7 @@ static bool swap_page_trans_huge_swapped(struct swa=
p_info_struct *si,
>
>  static bool folio_swapped(struct folio *folio)
>  {
> -       swp_entry_t entry =3D folio_swap_entry(folio);
> +       swp_entry_t entry =3D folio->swap;
>         struct swap_info_struct *si =3D _swap_info_get(entry);
>
>         if (!si)
> diff --git a/mm/util.c b/mm/util.c
> index cde229b05eb3..f31e2ca62cfa 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -764,7 +764,7 @@ struct address_space *folio_mapping(struct folio *fol=
io)
>                 return NULL;
>
>         if (unlikely(folio_test_swapcache(folio)))
> -               return swap_address_space(folio_swap_entry(folio));
> +               return swap_address_space(folio->swap);
>
>         mapping =3D folio->mapping;
>         if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c7c149cb8d66..6f13394b112e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1423,7 +1423,7 @@ static int __remove_mapping(struct address_space *m=
apping, struct folio *folio,
>         }
>
>         if (folio_test_swapcache(folio)) {
> -               swp_entry_t swap =3D folio_swap_entry(folio);
> +               swp_entry_t swap =3D folio->swap;
>
>                 if (reclaimed && !mapping_exiting(mapping))
>                         shadow =3D workingset_eviction(folio, target_memc=
g);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7300b98d4a03..412b1409a0d7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1190,7 +1190,7 @@ static void zswap_fill_page(void *ptr, unsigned lon=
g value)
>
>  bool zswap_store(struct folio *folio)
>  {
> -       swp_entry_t swp =3D folio_swap_entry(folio);
> +       swp_entry_t swp =3D folio->swap;
>         int type =3D swp_type(swp);
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> @@ -1370,7 +1370,7 @@ bool zswap_store(struct folio *folio)
>
>  bool zswap_load(struct folio *folio)
>  {
> -       swp_entry_t swp =3D folio_swap_entry(folio);
> +       swp_entry_t swp =3D folio->swap;
>         int type =3D swp_type(swp);
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> --
> 2.41.0
>
>
