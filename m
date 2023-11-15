Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8B7EBCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjKOFaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOFaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:30:12 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564FCBC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:30:09 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41ea9c5e83cso217421cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700026208; x=1700631008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTzcIPkoY+7GW1ili0ZNzFlDS034xJPkgo2VpEAsmP0=;
        b=SNf3uKE+Z54w7zvEQz1/1eAWSWTDTGSpswTdTMtkhUp/sj9DZLGxBlJjl7xBAVHQQi
         yxCn6tUQVXxdFmJU9pezYN5fq2/Cn7l39akqKAnX4SRKLY5uJHh4tHd+ilAxvBnCqWCE
         NIGiWGA7ynuKquUt+R1oT5CrJyPJUy8NhJ7Pks4Ickc3gt5eT9f2wkxH3ISw1WY2WLgA
         MZ+arPaX+i77J2RgXmsqT7wgrbzMlhHP2eAsw+56Mb37dBsLt7xMmPcgZHc1iktSAnSB
         kqQMI0yrM2kRAv/3Ssadu5YJSnQ5THCTXE+ybCgN8COE0iXR/jReEECtRAD013g+1rS6
         3Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700026208; x=1700631008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTzcIPkoY+7GW1ili0ZNzFlDS034xJPkgo2VpEAsmP0=;
        b=GyJEuT9oFK6WPumYSy0JwC5TR23FP42uKR5pmvF9J1U6gTqQOknK+dJdGpOznz4Nd6
         PdhQ27wg4JHsZAAmmpsRONthst9GEbXsQBmztvp4a/uGcb+ghOmozicQHxuwYnihnVM7
         oNnLXdJzgwa8D+1tTD/cebjhmXg2JfOBq+A9v5FXolf4Km7TtLkE/fsEl1pjG8zFQRrN
         9/o1f+uOJx6piDCRpO6SON3GQ7Ot4iPGu6b7fkNQzoqRZuHta3GdSfXgJWrHzEXuKylW
         jTzqNIiZUOz8xX+SAmH/eDg9wWVR6kxyXM7yLFnklDpGK5IrwssVHZpyO5wGMSHlblRN
         rgwg==
X-Gm-Message-State: AOJu0Yw88xLWuLoxCycsrU/JvqJpr+3/EQJFRvPL5iFBXsPWkKHAb0e/
        JTC+IaQMuAFRHZVddi8wGUB+PhJP6nPRU04RVVFl4A==
X-Google-Smtp-Source: AGHT+IHUr6z14WJsN3TUSijIcq+5nnoZHkgJAE3wpifyY0eVdTqQajfKgjJu5h9UzTSgd5pRAfwdHPpZTnI18SRRQkQ=
X-Received: by 2002:a05:622a:420d:b0:421:bc7d:dc84 with SMTP id
 cp13-20020a05622a420d00b00421bc7ddc84mr179532qtb.2.1700026208232; Tue, 14 Nov
 2023 21:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20231115050123.982876-1-liushixin2@huawei.com>
In-Reply-To: <20231115050123.982876-1-liushixin2@huawei.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 14 Nov 2023 22:29:31 -0700
Message-ID: <CAOUHufZVp_U_R-MtfMwmi1VQgQLBvvSac6OOf4TWbEsUWbNjkQ@mail.gmail.com>
Subject: Re: [PATCH v9] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 9:24=E2=80=AFPM Liu Shixin <liushixin2@huawei.com> =
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
>
> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
> If the number is not zero, return true and set swapcache_only to 1.
> When scan anon lru list in swapcache_only mode, non-swapcache pages will
> be skipped to isolate in order to accelerate reclaim efficiency.
>
> However, in swapcache_only mode, the scan count still increased when scan
> non-swapcache pages because there are large number of non-swapcache pages
> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> is skipped and do not count, the scan of pages in isolate_lru_folios() ca=
n
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
> v8->v9: Move the swapcache check after can_demote() and refector
>         can_reclaim_anon_pages() a bit.
> v7->v8: Reset swapcache_only at the beginning of can_reclaim_anon_pages()=
.
> v6->v7: Reset swapcache_only to zero after there are swap spaces.
> v5->v6: Fix NULL pointing derefence and hung task problem reported by Sac=
hin.
>
>  include/linux/swap.h |  6 ++++++
>  mm/memcontrol.c      |  8 ++++++++
>  mm/vmscan.c          | 47 ++++++++++++++++++++++++++++++++------------
>  3 files changed, 48 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6dd6575b905..3ba146ae7cf5 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -659,6 +659,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry=
_t entry, unsigned int nr_p
>  }
>
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct folio *folio);
>  #else
>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t e=
ntry)
> @@ -681,6 +682,11 @@ static inline long mem_cgroup_get_nr_swap_pages(stru=
ct mem_cgroup *memcg)
>         return get_nr_swap_pages();
>  }
>
> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *=
memcg)
> +{
> +       return total_swapcache_pages();
> +}
> +
>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>  {
>         return vm_swap_full();
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..a76ec540d4a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7865,6 +7865,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgrou=
p *memcg)
>         return nr_swap_pages;
>  }
>
> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
> +{
> +       if (mem_cgroup_disabled())
> +               return total_swapcache_pages();
> +
> +       return memcg_page_state(memcg, NR_SWAPCACHE);
> +}
> +
>  bool mem_cgroup_swap_full(struct folio *folio)
>  {
>         struct mem_cgroup *memcg;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 506f8220c5fe..62a1c75f74ad 100644
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
> @@ -312,25 +315,34 @@ static inline bool can_reclaim_anon_pages(struct me=
m_cgroup *memcg,
>                                           int nid,
>                                           struct scan_control *sc)
>  {
> -       if (memcg =3D=3D NULL) {
> -               /*
> -                * For non-memcg reclaim, is there
> -                * space in any swap device?
> -                */
> -               if (get_nr_swap_pages() > 0)
> -                       return true;
> -       } else {
> -               /* Is the memcg below its swap limit? */
> -               if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
> -                       return true;
> -       }
> +       if (sc)
> +               sc->swapcache_only =3D 0;
> +
> +       /*
> +        * For non-memcg reclaim, is there space in any swap device?
> +        * Or is the memcg below its swap limit?
> +        */
> +       if ((!memcg && get_nr_swap_pages() > 0) ||
> +           (memcg && mem_cgroup_get_nr_swap_pages(memcg) > 0))
> +               return true;
>
>         /*
>          * The page can not be swapped.
>          *
>          * Can it be reclaimed from this node via demotion?
>          */
> -       return can_demote(nid, sc);
> +       if (can_demote(nid, sc))
> +               return true;
> +
> +       /* Is there any swapcache pages to reclaim? */
> +       if ((!memcg && total_swapcache_pages() > 0) ||
> +           (memcg && mem_cgroup_get_nr_swapcache_pages(memcg) > 0)) {

The above can return false positives if there are multiple nodes, so
it needs to be per node or lruvec, i.e., node_page_state() or
lruvec_page_state_local().
