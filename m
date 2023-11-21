Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9072F7F343A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjKUQuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjKUQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:50:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB092
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:50:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F068C433CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700585447;
        bh=KpSLWpoYDnujgiguvqs0R2yyZ8foM4ACeYZogrkU4I0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fj+SX4vd92/6IemEiaZl2gnc4DSB2SfGdJOOqij4ynK4zkVgM7aRMiRUzjuWiIyZh
         Ewnanqnc+KrE260cYqPD5RM0DTRyDBkOBvwDUevGWzWcdfKbrhuHriLTLI7GcRHSIi
         QOfSvA8+uhUmPkp+8SuuXD9SdD3aQb961yIzH16NDjhk0irH0j4wtqPth50VLMqti4
         fI31pVxWLVwUnTKVxIUoi/ENz4G/qEo8h6IHHfkz/UbQzdNE1pC9GoPxD5AjwrSeXo
         NcCUWFj1Ux1f320IlRuIlrt5d/bWx4y7lWkrSQmLzwqG73iGiv++e+xNYFekFnXk1S
         7HtdRJ7DW4qVA==
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6c115026985so5878287b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:50:47 -0800 (PST)
X-Gm-Message-State: AOJu0YzVwVIK93AYfFYcIMlQH1fTnRY5qUpwlNwbA9rnUol/2MJ9BWiL
        XBDqxpEXDm7vmLEO47TP7ICDp8cWnO0AryLqJ4LW8w==
X-Google-Smtp-Source: AGHT+IGLX8mYLdYfH8QqAbn+qSj6k0Gjc4JdO2QcOM6cfVZXNWpqQt9x+BXh4uZHmsdQxNX018/aYoCkLbjJbJQq20U=
X-Received: by 2002:a05:6a20:394a:b0:18b:284f:e725 with SMTP id
 r10-20020a056a20394a00b0018b284fe725mr114850pzg.16.1700585446584; Tue, 21 Nov
 2023 08:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-14-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-14-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 08:50:35 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMe3K1bUCWFSWB7c2tw6KKWr49MJMfu2q-ET5tM6vWXXA@mail.gmail.com>
Message-ID: <CAF8kJuMe3K1bUCWFSWB7c2tw6KKWr49MJMfu2q-ET5tM6vWXXA@mail.gmail.com>
Subject: Re: [PATCH 13/24] swap: simplify swap_cache_get_folio
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

I agree the resulting code is marginally better.

However, this change does not bring enough value to justify a stand alone p=
atch.
It has no impact on the resulting kernel.

It would be much better if the code was checkin like this, or if you
are modifying this function, rewrite it better. In my opinion, doing
very trivial code shuffling for the sake of cleaning up is not
justifiable for the value it brings.
For one it will make the git blame less obvious who actually changed
that code for what reason. I am against trivial code shuffling.

Chris

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Rearrange the if statement, reduce the code indent, no feature change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 58 ++++++++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 91461e26a8cc..3b5a34f47192 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -336,41 +336,39 @@ static inline bool swap_use_vma_readahead(struct sw=
ap_info_struct *si)
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *v=
mf)
>  {
> +       bool vma_ra, readahead;
>         struct folio *folio;
>
>         folio =3D filemap_get_folio(swap_address_space(entry), swp_offset=
(entry));
> -       if (!IS_ERR(folio)) {
> -               bool vma_ra =3D swap_use_vma_readahead(swp_swap_info(entr=
y));
> -               bool readahead;
> +       if (IS_ERR(folio))
> +               return NULL;
>
> -               /*
> -                * At the moment, we don't support PG_readahead for anon =
THP
> -                * so let's bail out rather than confusing the readahead =
stat.
> -                */
> -               if (unlikely(folio_test_large(folio)))
> -                       return folio;
> -
> -               readahead =3D folio_test_clear_readahead(folio);
> -               if (vmf && vma_ra) {
> -                       unsigned long ra_val;
> -                       int win, hits;
> -
> -                       ra_val =3D GET_SWAP_RA_VAL(vmf->vma);
> -                       win =3D SWAP_RA_WIN(ra_val);
> -                       hits =3D SWAP_RA_HITS(ra_val);
> -                       if (readahead)
> -                               hits =3D min_t(int, hits + 1, SWAP_RA_HIT=
S_MAX);
> -                       atomic_long_set(&vmf->vma->swap_readahead_info,
> -                                       SWAP_RA_VAL(vmf->address, win, hi=
ts));
> -               }
> +       /*
> +        * At the moment, we don't support PG_readahead for anon THP
> +        * so let's bail out rather than confusing the readahead stat.
> +        */
> +       if (unlikely(folio_test_large(folio)))
> +               return folio;
>
> -               if (readahead) {
> -                       count_vm_event(SWAP_RA_HIT);
> -                       if (!vmf || !vma_ra)
> -                               atomic_inc(&swapin_readahead_hits);
> -               }
> -       } else {
> -               folio =3D NULL;
> +       vma_ra =3D swap_use_vma_readahead(swp_swap_info(entry));
> +       readahead =3D folio_test_clear_readahead(folio);
> +       if (vmf && vma_ra) {
> +               unsigned long ra_val;
> +               int win, hits;
> +
> +               ra_val =3D GET_SWAP_RA_VAL(vmf->vma);
> +               win =3D SWAP_RA_WIN(ra_val);
> +               hits =3D SWAP_RA_HITS(ra_val);
> +               if (readahead)
> +                       hits =3D min_t(int, hits + 1, SWAP_RA_HITS_MAX);
> +               atomic_long_set(&vmf->vma->swap_readahead_info,
> +                               SWAP_RA_VAL(vmf->address, win, hits));
> +       }
> +
> +       if (readahead) {
> +               count_vm_event(SWAP_RA_HIT);
> +               if (!vmf || !vma_ra)
> +                       atomic_inc(&swapin_readahead_hits);
>         }
>
>         return folio;
> --
> 2.42.0
>
>
