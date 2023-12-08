Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9B809E13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573298AbjLHIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjLHIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:24:28 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720D10E6;
        Fri,  8 Dec 2023 00:24:34 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca09601127so22166081fa.1;
        Fri, 08 Dec 2023 00:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702023873; x=1702628673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1kGhyXtMTFSjjyasBV5OG9ebXYVFLat/dfOyblLSe0=;
        b=TW+pOdfZZw8tBcERkHaGT2csGITNybTVFqsCTQIMD8phr6dvAXC/MH1MtuMXAJ1ecQ
         7gfjaGGsImnrj3wD13cwvge6Rf0ksHwB9FZ7jtWCLAtzsRqAvmY8UkqNuxnGO+TrjLmJ
         5TG9GW/47gyz4ck1niIIyEUcu/WA68hB0GpzA83FDjIqiUqPA7lYux8jCaQn7CAe0ON6
         J19D0xOxsUVxnOsARYGkSng79shD+CYKnix0ybkv8TETz6st0PYztU0JHaEDzQ7D3Nvu
         tm7MNSgCTHlrz7WFeH72HTkWZTC/j+J3/Nhqq97Jjn4tnEO53QGzpDlphBdP+V5rNsSD
         frHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702023873; x=1702628673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1kGhyXtMTFSjjyasBV5OG9ebXYVFLat/dfOyblLSe0=;
        b=Bp52jKqkvSnEG9LZlrpZTubpsoGFYaF/Zv0Y1Em66OVvd6mjWF8OVZQqFIMTRnxBdU
         ryyzflAVQRLVdWSl2hUaB/maRVKIjtsdJk8IB8Eqmfyp4gicYYwlHjKxYUFPAi9l8/6j
         +HEQ26w5sjN4Z/+eeOyi2UvmqzZDsqzj8+JzstbQzPEP+H7bBdDCF2+Ojld3901vWtcN
         8av24RsPDrEtlLD3DJQGVyWQMzcqsqm3U5FRNUUiPiB1yxfH2HMOMhT1G6aE2eH/ghMT
         7H8Y4EiVzvKRnrl32Lhe+tm/GaPyb7ClFg6f9Hp4c1AT2P6Ns8QYRACg4pVrM/zkyT+M
         8rfg==
X-Gm-Message-State: AOJu0YzKVphwNNUJCjdESQC4DDrDP2vPAKn2lZw+TAasMabd+sPDvm0x
        Dii8i4TP05YhJqUQFfEYXOztyzAGHktCd+kh3eA=
X-Google-Smtp-Source: AGHT+IGEP/0Mz4/66HU4lbcxJhc/kRgZejykqTwYWzMRlMXac7tXrKifGewcaAJtR7VKF58Wo2wMUJqL1Sfvnegfn5E=
X-Received: by 2002:a2e:22c5:0:b0:2ca:22fd:8804 with SMTP id
 i188-20020a2e22c5000000b002ca22fd8804mr2035980lji.11.1702023872344; Fri, 08
 Dec 2023 00:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com>
In-Reply-To: <20231208061407.2125867-1-yuzhao@google.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 8 Dec 2023 16:24:15 +0800
Message-ID: <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=888=E6=97=A5=E5=
=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Unmapped folios accessed through file descriptors can be
> underprotected. Those folios are added to the oldest generation based
> on:
> 1. The fact that they are less costly to reclaim (no need to walk the
>    rmap and flush the TLB) and have less impact on performance (don't
>    cause major PFs and can be non-blocking if needed again).
> 2. The observation that they are likely to be single-use. E.g., for
>    client use cases like Android, its apps parse configuration files
>    and store the data in heap (anon); for server use cases like MySQL,
>    it reads from InnoDB files and holds the cached data for tables in
>    buffer pools (anon).
>
> However, the oldest generation can be very short lived, and if so, it
> doesn't provide the PID controller with enough time to respond to a
> surge of refaults. (Note that the PID controller uses weighted
> refaults and those from evicted generations only take a half of the
> whole weight.) In other words, for a short lived generation, the
> moving average smooths out the spike quickly.
>
> To fix the problem:
> 1. For folios that are already on LRU, if they can be beyond the
>    tracking range of tiers, i.e., five accesses through file
>    descriptors, move them to the second oldest generation to give them
>    more time to age. (Note that tiers are used by the PID controller
>    to statistically determine whether folios accessed multiple times
>    through file descriptors are worth protecting.)
> 2. When adding unmapped folios to LRU, adjust the placement of them so
>    that they are not too close to the tail. The effect of this is
>    similar to the above.
>
> On Android, launching 55 apps sequentially:
>                            Before     After      Change
>   workingset_refault_anon  25641024   25598972   0%
>   workingset_refault_file  115016834  106178438  -8%

Hi Yu,

Thanks you for your amazing works on MGLRU.

I believe this is the similar issue I was trying to resolve previously:
https://lwn.net/Articles/945266/
The idea is to use refault distance to decide if the page should be
place in oldest generation or some other gen, which per my test,
worked very well, and we have been using refault distance for MGLRU in
multiple workloads.

There are a few issues left in my previous RFC series, like anon pages
in MGLRU shouldn't be considered, I wanted to collect feedback or test
cases, but unfortunately it seems didn't get too much attention
upstream.

I think both this patch and my previous series are for solving the
file pages underpertected issue, and I did a quick test using this
series, for mongodb test, refault distance seems still a better
solution (I'm not saying these two optimization are mutually exclusive
though, just they do have some conflicts in implementation and solving
similar problem):

Previous result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 905 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate
  STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
------------------------------------------------------------------
  TOTAL           2542            27121571486.2   0.09 txn/s

This patch:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 900 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate
  STOCK_LEVEL     1594            27061522574.4   0.06 txn/s
------------------------------------------------------------------
  TOTAL           1594            27061522574.4   0.06 txn/s

Unpatched version is always around ~500.

I think there are a few points here:
- Refault distance make use of page shadow so it can better
distinguish evicted pages of different access pattern (re-access
distance).
- Throttled refault distance can help hold part of workingset when
memory is too small to hold the whole workingset.

So maybe part of this patch and the bits of previous series can be
combined to work better on this issue, how do you think?

>
> Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Tested-by: Kalesh Singh <kaleshsingh@google.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/mm_inline.h | 23 ++++++++++++++---------
>  mm/vmscan.c               |  2 +-
>  mm/workingset.c           |  6 +++---
>  3 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 9ae7def16cb2..f4fe593c1400 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -232,22 +232,27 @@ static inline bool lru_gen_add_folio(struct lruvec =
*lruvec, struct folio *folio,
>         if (folio_test_unevictable(folio) || !lrugen->enabled)
>                 return false;
>         /*
> -        * There are three common cases for this page:
> -        * 1. If it's hot, e.g., freshly faulted in or previously hot and
> -        *    migrated, add it to the youngest generation.
> -        * 2. If it's cold but can't be evicted immediately, i.e., an ano=
n page
> -        *    not in swapcache or a dirty page pending writeback, add it =
to the
> -        *    second oldest generation.
> -        * 3. Everything else (clean, cold) is added to the oldest genera=
tion.
> +        * There are four common cases for this page:
> +        * 1. If it's hot, i.e., freshly faulted in, add it to the younge=
st
> +        *    generation, and it's protected over the rest below.
> +        * 2. If it can't be evicted immediately, i.e., a dirty page pend=
ing
> +        *    writeback, add it to the second youngest generation.
> +        * 3. If it should be evicted first, e.g., cold and clean from
> +        *    folio_rotate_reclaimable(), add it to the oldest generation=
.
> +        * 4. Everything else falls between 2 & 3 above and is added to t=
he
> +        *    second oldest generation if it's considered inactive, or th=
e
> +        *    oldest generation otherwise. See lru_gen_is_active().
>          */
>         if (folio_test_active(folio))
>                 seq =3D lrugen->max_seq;
>         else if ((type =3D=3D LRU_GEN_ANON && !folio_test_swapcache(folio=
)) ||
>                  (folio_test_reclaim(folio) &&
>                   (folio_test_dirty(folio) || folio_test_writeback(folio)=
)))
> -               seq =3D lrugen->min_seq[type] + 1;
> -       else
> +               seq =3D lrugen->max_seq - 1;
> +       else if (reclaiming || lrugen->min_seq[type] + MIN_NR_GENS >=3D l=
rugen->max_seq)
>                 seq =3D lrugen->min_seq[type];
> +       else
> +               seq =3D lrugen->min_seq[type] + 1;

For example. maybe still keep the pages on oldest gen by default, but
if the page have a eligible shadow, then put it on min_seq + 1?

>
>         gen =3D lru_gen_from_seq(seq);
>         flags =3D (gen + 1UL) << LRU_GEN_PGOFF;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4e3b835c6b4a..e67631c60ac0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4260,7 +4260,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         }
>
>         /* protected */
> -       if (tier > tier_idx) {
> +       if (tier > tier_idx || refs =3D=3D BIT(LRU_REFS_WIDTH)) {
>                 int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
>
>                 gen =3D folio_inc_gen(lruvec, folio, false);
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 7d3dacab8451..2a2a34234df9 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -313,10 +313,10 @@ static void lru_gen_refault(struct folio *folio, vo=
id *shadow)
>          * 1. For pages accessed through page tables, hotter pages pushed=
 out
>          *    hot pages which refaulted immediately.
>          * 2. For pages accessed multiple times through file descriptors,
> -        *    numbers of accesses might have been out of the range.
> +        *    they would have been protected by sort_folio().
>          */
> -       if (lru_gen_in_fault() || refs =3D=3D BIT(LRU_REFS_WIDTH)) {
> -               folio_set_workingset(folio);
> +       if (lru_gen_in_fault() || refs >=3D BIT(LRU_REFS_WIDTH) - 1) {
> +               set_mask_bits(&folio->flags, 0, LRU_REFS_MASK | BIT(PG_wo=
rkingset));
>                 mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + type, =
delta);
>         }

Also this can combine with refault distance check for setting the
reference flag.
