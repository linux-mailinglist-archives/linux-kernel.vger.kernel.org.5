Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D287F6531
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjKWRTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjKWRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:19:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF21725
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9296FC116A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759955;
        bh=IdgHI2lDjcmt4qEFhrLPvoD8tNuqkVTcDgzNfvZ85sc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZuPn6na8swcN5XZ87KuRw8VlUEvGyFw4xJWJoFCixX95Ila96E2rGljhlyRXKIpU6
         XPHCeBAiqw8KqqxLoD2ZURqP4BB2cq9o2XPeI9dwYYx6MOy0AI0PwRbBcuTjxlzHFf
         IeY1u/FostorSZJYlmbbIFp1QI2c+3JRYJhU8nywhJ+Th9L1qDHc32QNaiTezSdYEC
         4Y/TsxpwtntcLo7g+1wxrHO9bSyMgm4n5YWULvHTpkVcjsVSlnDk73qotD5LH5iDzw
         745G/cvwvkWhLbM5fVF3+2qlkKeTY+GIjhcjeUs+lE+rozOfbJCowoBTwOMxlmqUm6
         s2e7GiMNzqDPA==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28396255b81so850856a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:15 -0800 (PST)
X-Gm-Message-State: AOJu0YxjLIt/qPjbiLI2KMen5ULIi/zGyaVng+IuoUk6p5pLiWUCQKNs
        s5axZxRwIJrqQAZVL5rwkYC6CIqRTI1GRYMrDWvsEA==
X-Google-Smtp-Source: AGHT+IE3pl7gcLotSh+vx8sl8UGkyahEEMwps0Q2TRd4gl8uT97Aak8+By2TDnyAl7ynK5oyAvf5WB7kcMP9vxTQL70=
X-Received: by 2002:a17:90b:4b4f:b0:27d:8ad:69f9 with SMTP id
 mi15-20020a17090b4b4f00b0027d08ad69f9mr144759pjb.2.1700759954942; Thu, 23 Nov
 2023 09:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20231121090624.1814733-1-liushixin2@huawei.com>
In-Reply-To: <20231121090624.1814733-1-liushixin2@huawei.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 23 Nov 2023 09:19:00 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPPk0nPMyp+pjOdN0sJ4StL63MF+haXJYBTRki2uLywyQ@mail.gmail.com>
Message-ID: <CAF8kJuPPk0nPMyp+pjOdN0sJ4StL63MF+haXJYBTRki2uLywyQ@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shixin,

On Tue, Nov 21, 2023 at 12:08=E2=80=AFAM Liu Shixin <liushixin2@huawei.com>=
 wrote:
>
> When spaces of swap devices are exhausted, only file pages can be
> reclaimed.  But there are still some swapcache pages in anon lru list.
> This can lead to a premature out-of-memory.
>
> The problem is found with such step:
>
>  Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
>  memory limit, then runs an program to allocates about 15MB memory.
>
> The problem occurs occasionally, which may need about 100 times [1].

Just out of my curiosity, in your usage case, how much additional
memory in terms of pages or MB can be freed by this patch, using
current code as base line?
Does the swap cache page reclaimed in swapcache_only mode, all swap
count drop to zero, and the only reason to stay in swap cache is to
void page IO write if we need to swap that page out again?

> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
> If the number is not zero, return true and set swapcache_only to 1.
> When scan anon lru list in swapcache_only mode, non-swapcache pages will
> be skipped to isolate in order to accelerate reclaim efficiency.

Here you said non-swapcache will be skipped if swapcache_only =3D=3D 1

>
> However, in swapcache_only mode, the scan count still increased when scan
> non-swapcache pages because there are large number of non-swapcache pages
> and rare swapcache pages in swapcache_only mode, and if the non-swapcache

Here you suggest non-swapcache pages will also be scanned even when
swapcache_only =3D=3D 1. It seems to contradict what you said above. I
feel that I am missing something here.

> is skipped and do not count, the scan of pages in isolate_lru_folios() ca=
n

Can you clarify which "scan of pages", are those pages swapcache pages
or non-swapcache pages?

> eventually lead to hung task, just as Sachin reported [2].
>
> By the way, since there are enough times of memory reclaim before OOM, it
> is not need to isolate too much swapcache pages in one times.
>
> [1]. https://lore.kernel.org/lkml/CAJD7tkZAfgncV+KbKr36=3DeDzMnT=3D9dZOT0=
dpMWcurHLr6Do+GA@mail.gmail.com/
> [2]. https://lore.kernel.org/linux-mm/CAJD7tkafz_2XAuqE8tGLPEcpLngewhUo=
=3D5US14PAtSM9tLBUQg@mail.gmail.com/
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Tested-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> v9->v10: Use per-node swapcache suggested by Yu Zhao.
> v8->v9: Move the swapcache check after can_demote() and refector
>         can_reclaim_anon_pages() a bit.
> v7->v8: Reset swapcache_only at the beginning of can_reclaim_anon_pages()=
.
> v6->v7: Reset swapcache_only to zero after there are swap spaces.
> v5->v6: Fix NULL pointing derefence and hung task problem reported by Sac=
hin.
>
>  mm/vmscan.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 506f8220c5fe..1fcc94717370 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -136,6 +136,9 @@ struct scan_control {
>         /* Always discard instead of demoting to lower tier memory */
>         unsigned int no_demotion:1;
>
> +       /* Swap space is exhausted, only reclaim swapcache for anon LRU *=
/
> +       unsigned int swapcache_only:1;
> +
>         /* Allocation order */
>         s8 order;
>
> @@ -308,10 +311,36 @@ static bool can_demote(int nid, struct scan_control=
 *sc)
>         return true;
>  }
>
> +#ifdef CONFIG_SWAP
> +static bool can_reclaim_swapcache(struct mem_cgroup *memcg, int nid)
> +{
> +       struct pglist_data *pgdat =3D NODE_DATA(nid);
> +       unsigned long nr_swapcache;
> +
> +       if (!memcg) {
> +               nr_swapcache =3D node_page_state(pgdat, NR_SWAPCACHE);
> +       } else {
> +               struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat)=
;
> +
> +               nr_swapcache =3D lruvec_page_state_local(lruvec, NR_SWAPC=
ACHE);
> +       }
> +
> +       return nr_swapcache > 0;
> +}
> +#else
> +static bool can_reclaim_swapcache(struct mem_cgroup *memcg, int nid)
> +{
> +       return false;
> +}
> +#endif
> +
>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>                                           int nid,
>                                           struct scan_control *sc)
>  {
> +       if (sc)
> +               sc->swapcache_only =3D 0;
> +

Minor nitpick. The sc->swapcache_only is first set to 0 then later set
to 1. Better use a local variable then write to sc->swapcache_only in
one go. If the scan_control has more than one thread accessing it, the
threads can see the flicker of 0->1 change.  I don't think that is the
case in our current code, sc is created on stack. There are other
minor benefits as The "if (sc) test" only needs to be done once, one
store instruction.

Chris

>         if (memcg =3D=3D NULL) {
>                 /*
>                  * For non-memcg reclaim, is there
> @@ -330,7 +359,17 @@ static inline bool can_reclaim_anon_pages(struct mem=
_cgroup *memcg,
>          *
>          * Can it be reclaimed from this node via demotion?
>          */
> -       return can_demote(nid, sc);
> +       if (can_demote(nid, sc))
> +               return true;
> +
> +       /* Is there any swapcache pages to reclaim in this node? */
> +       if (can_reclaim_swapcache(memcg, nid)) {
> +               if (sc)
> +                       sc->swapcache_only =3D 1;
> +               return true;
> +       }
> +
> +       return false;
>  }
>
>  /*
> @@ -1642,6 +1681,15 @@ static unsigned long isolate_lru_folios(unsigned l=
ong nr_to_scan,
>                  */
>                 scan +=3D nr_pages;
>
> +               /*
> +                * Count non-swapcache too because the swapcache pages ma=
y
> +                * be rare and it takes too much times here if not count
> +                * the non-swapcache pages.
> +                */
> +               if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
> +                   !folio_test_swapcache(folio)))
> +                       goto move;
> +
>                 if (!folio_test_lru(folio))
>                         goto move;
>                 if (!sc->may_unmap && folio_mapped(folio))
> --
> 2.25.1
>
>
