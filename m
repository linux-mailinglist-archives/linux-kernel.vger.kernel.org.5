Return-Path: <linux-kernel+bounces-11723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6C81EAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13A51F21B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F076127;
	Tue, 26 Dec 2023 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd3nc8JO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159A5681
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 23:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC824C433CA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 23:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703634227;
	bh=luo28ZsGZSYxOzipOFMWzpMKPFeyk/y69hfg/+x8Kzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hd3nc8JOVCdQoHylkgPr3I+vqT8jOttn5b7xmLJfLR4Xf2DwPTB26nvOxeQmzBdkB
	 lBa2ZXR6/Pl3TeBSwBkGRrsgt83QkbfdSP39/bZYqETg9K3dxzrU60OidsyLApsaXw
	 qFRSMr/6FMRNtCieqgYbAvGMnptM4wGfJkrFUDu49t6OJEeYVBu/hrsjs4tmBPJYx7
	 uQECc6c8jyi1IxsUgFhlqOIB3cke6qngD+r5M6D/7DHNyb9Cwf5mK5wCIgVPEST/w8
	 5C5YGb/sX3wuNrCRC+httxC0aY8NTemEtyPOIQghPvGoTNy17YABmHyVT2oXv5oMe2
	 1Grjefg/XmBvw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1f060e059a3so4050489fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 15:43:47 -0800 (PST)
X-Gm-Message-State: AOJu0YwsI5tdHNzHwQFfaowmA+en4ysvgMs1nzkc6z04ju6H4Wrs3RnQ
	teXnBYFFkP21LmJ8rKRn/Bw5VOdi0GDYM5xwsJmENz7pnZb6
X-Google-Smtp-Source: AGHT+IE9y5Vm0/4zQMf6C6O6fucsvlOQ2p64dPM7ELlvZg/mboRxWrEB7pIt/8qLf1Eb+EiqHHtyA0bty6CQ2wR1Y68=
X-Received: by 2002:a05:6870:1713:b0:204:4149:976b with SMTP id
 h19-20020a056870171300b002044149976bmr10633270oae.0.1703634227088; Tue, 26
 Dec 2023 15:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-2-ryncsn@gmail.com>
In-Reply-To: <20231222102255.56993-2-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Dec 2023 15:43:35 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNPCvNyjy71Q9Kncq26ndAwSWhVH1cJ8s=1Exr=AmLgSA@mail.gmail.com>
Message-ID: <CAF8kJuNPCvNyjy71Q9Kncq26ndAwSWhVH1cJ8s=1Exr=AmLgSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, lru_gen: batch update counters on againg
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

Some early feedback on your patch. I am still working  my way through
your patches.
Might have more questions.

On Fri, Dec 22, 2023 at 2:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> When lru_gen is aging, it will update mm counters page by page,
> which causes a higher overhead if age happens frequently or there
> are a lot of pages in one generation getting moved.
> Optimize this by doing the counter update in batch.
>
> Although most __mod_*_state has its own caches the overhead
> is still observable.
>
> Tested in a 4G memcg on a EPYC 7K62 with:
>
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
>     -a 0766 -t 16 -B binary &
>
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys \
>     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
>     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
>
> Average result of 18 test runs:
>
> Before: 44017.78 Ops/sec
> After:  44687.08 Ops/sec (+1.5%)
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b4ca3563bcf4..e3b4797b9729 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3095,9 +3095,47 @@ static int folio_update_gen(struct folio *folio, i=
nt gen)
>         return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
>  }
>
> +/*
> + * Update LRU gen in batch for each lru_gen LRU list. The batch is limit=
ed to
> + * each gen / type / zone level LRU. Batch is applied after finished or =
aborted
> + * scanning one LRU list.
> + */
> +struct gen_update_batch {
> +       int delta[MAX_NR_GENS];
> +};
> +
> +static void lru_gen_update_batch(struct lruvec *lruvec, bool type, int z=
one,
"type" need to be int, it is either  LRU_GEN_FILE or LRU_GEN_ANON.

Ideally the type is an enum that defines LRU_GEN_FILE or LRU_GEN_ANON.
bool is not the right C type of "type" here. The rest of the code uses
"int" for type as well.

I saw you use "bool type" in other patches as well. All need to change
to "int type".

Chris

> +                                struct gen_update_batch *batch)
> +{
> +       int gen;
> +       int promoted =3D 0;
> +       struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> +       enum lru_list lru =3D type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANO=
N;
> +
> +       for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
> +               int delta =3D batch->delta[gen];
> +
> +               if (!delta)
> +                       continue;
> +
> +               WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
> +                          lrugen->nr_pages[gen][type][zone] + delta);
> +
> +               if (lru_gen_is_active(lruvec, gen))
> +                       promoted +=3D delta;
> +       }
> +
> +       if (promoted) {
> +               __update_lru_size(lruvec, lru, zone, -promoted);
> +               __update_lru_size(lruvec, lru + LRU_ACTIVE, zone, promote=
d);
> +       }
> +}
> +
>  /* protect pages accessed multiple times through file descriptors */
> -static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, boo=
l reclaiming)
> +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio,
> +                        bool reclaiming, struct gen_update_batch *batch)
>  {
> +       int delta =3D folio_nr_pages(folio);
>         int type =3D folio_is_file_lru(folio);
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
> @@ -3120,7 +3158,8 @@ static int folio_inc_gen(struct lruvec *lruvec, str=
uct folio *folio, bool reclai
>                         new_flags |=3D BIT(PG_reclaim);
>         } while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
>
> -       lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> +       batch->delta[old_gen] -=3D delta;
> +       batch->delta[new_gen] +=3D delta;
>
>         return new_gen;
>  }
> @@ -3663,6 +3702,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int =
type, bool can_swap)
>  {
>         int zone;
>         int remaining =3D MAX_LRU_BATCH;
> +       struct gen_update_batch batch =3D { };
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
>
> @@ -3681,12 +3721,15 @@ static bool inc_min_seq(struct lruvec *lruvec, in=
t type, bool can_swap)
>                         VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=
=3D type, folio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one, folio);
>
> -                       new_gen =3D folio_inc_gen(lruvec, folio, false);
> +                       new_gen =3D folio_inc_gen(lruvec, folio, false, &=
batch);
>                         list_move_tail(&folio->lru, &lrugen->folios[new_g=
en][type][zone]);
>
> -                       if (!--remaining)
> +                       if (!--remaining) {
> +                               lru_gen_update_batch(lruvec, type, zone, =
&batch);
>                                 return false;
> +                       }
>                 }
> +               lru_gen_update_batch(lruvec, type, zone, &batch);
>         }
>  done:
>         reset_ctrl_pos(lruvec, type, true);
> @@ -4197,7 +4240,7 @@ static int lru_gen_memcg_seg(struct lruvec *lruvec)
>   ***********************************************************************=
*******/
>
>  static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struc=
t scan_control *sc,
> -                      int tier_idx)
> +                      int tier_idx, struct gen_update_batch *batch)
>  {
>         bool success;
>         int gen =3D folio_lru_gen(folio);
> @@ -4239,7 +4282,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         if (tier > tier_idx || refs =3D=3D BIT(LRU_REFS_WIDTH)) {
>                 int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
>
> -               gen =3D folio_inc_gen(lruvec, folio, false);
> +               gen =3D folio_inc_gen(lruvec, folio, false, batch);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
>
>                 WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
> @@ -4249,7 +4292,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>
>         /* ineligible */
>         if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
> -               gen =3D folio_inc_gen(lruvec, folio, false);
> +               gen =3D folio_inc_gen(lruvec, folio, false, batch);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
>                 return true;
>         }
> @@ -4257,7 +4300,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         /* waiting for writeback */
>         if (folio_test_locked(folio) || folio_test_writeback(folio) ||
>             (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> -               gen =3D folio_inc_gen(lruvec, folio, true);
> +               gen =3D folio_inc_gen(lruvec, folio, true, batch);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
>         }
> @@ -4323,6 +4366,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         for (i =3D MAX_NR_ZONES; i > 0; i--) {
>                 LIST_HEAD(moved);
>                 int skipped_zone =3D 0;
> +               struct gen_update_batch batch =3D { };
>                 int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                 struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
>
> @@ -4337,7 +4381,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>
>                         scanned +=3D delta;
>
> -                       if (sort_folio(lruvec, folio, sc, tier))
> +                       if (sort_folio(lruvec, folio, sc, tier, &batch))
>                                 sorted +=3D delta;
>                         else if (isolate_folio(lruvec, folio, sc)) {
>                                 list_add(&folio->lru, list);
> @@ -4357,6 +4401,8 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>                         skipped +=3D skipped_zone;
>                 }
>
> +               lru_gen_update_batch(lruvec, type, zone, &batch);
> +
>                 if (!remaining || isolated >=3D MIN_LRU_BATCH)
>                         break;
>         }
> --
> 2.43.0
>
>

