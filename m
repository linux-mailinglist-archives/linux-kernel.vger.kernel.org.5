Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD85800162
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjLACFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLACFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:05:36 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364AF2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:05:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a187cd4eb91so187536566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701396341; x=1702001141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPAyt2cpj8YitcbF/ZXsY/VZI0FRxkT2rx6bb0Jhrv0=;
        b=opodncZmY3ip+uRvFDRDbPFMkNJG0xC9PLYjg9GY3swEJQT9NhrNwkTny2jAH8yFly
         xwntoNuOp+XO448jmwHBpijOzExb5KdbS28WcFVlCqSJlGvHPsY/5i7RWMiv/Grlvtj6
         gBdHoPE7BcxRSTZs8QW3pEbOufEQLSgsEJ+0MnmLl2q0FdeI5L/i8ZYloDkEot+ERa9S
         ixhrLaRg1tfei7RAIPugBFx1hSzA1890T3XIgWGA9iAxlxph7yN3ZCFBNydwktYQWLoo
         1PjWc7op8bQ/0V4sXHH4R0TfLOxP31jWojEHL2QoqSA/ihTd6zdg7RwIoh/8/7t9yYVj
         mCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701396341; x=1702001141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPAyt2cpj8YitcbF/ZXsY/VZI0FRxkT2rx6bb0Jhrv0=;
        b=H4rRjls5r0PlChzVDTUUt0SVlh6dS6TF2fMVbD/n5OAtYqRs8DCQ4dziRi6xfvPXpN
         A9tQCW4ls2dUR8/XXSWDzJMI5ECO2tc8N51qI3mVV7C/yi0HyLRIJE1GgVO3uK2jHx13
         HoQQi8vh+tN20FjlMbIyIdkq1IGXN9MKE3FhoAznWKNa0Ame9FHqacJbBOUXc3Cj7j1b
         oLcV/TWkEM6F2Ad/dJg9Y7CPkv1j6h3tZB/XDE4ZddesiB9N4DgEZMLHvI7ZlCJ0UEoI
         gImKI+5VOD3PMwlQ91YYSYakDan+GUByoWdYAE/y/iwB7/VpuQtidojPWcwjQbkmWdjy
         ocHA==
X-Gm-Message-State: AOJu0YySKyDt9Moyh9sOj39+CUk1ib7of2ps3wnSmkeV0u9h+uO1yVuq
        7ckVtVdl167Y4h3hTet72yPSgHgcZwUP59gpyCm2Mg==
X-Google-Smtp-Source: AGHT+IHCWvetEn5bIjknsZ5SNFidPRGBu7iJZJNJAX9WtyEXizm24lRATxkMRAfd1FM3w1m3E6lh7LQtXHeGYezWHO4=
X-Received: by 2002:a17:906:108f:b0:a19:4a1d:e5d4 with SMTP id
 u15-20020a170906108f00b00a194a1de5d4mr275873eju.59.1701396341082; Thu, 30 Nov
 2023 18:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130153658.527556-2-schatzberg.dan@gmail.com> <ec8abbff-8e17-43b3-a210-fa615e71217d@vivo.com>
In-Reply-To: <ec8abbff-8e17-43b3-a210-fa615e71217d@vivo.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Nov 2023 18:05:02 -0800
Message-ID: <CAJD7tkY-npqRXmwJU6kH1srG0c+suiDfffsoc44ngP4x9H0kLA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
To:     Huan Yang <11133793@vivo.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>         unsigned long anon_cost, file_cost, total_cost;
> -       int swappiness = mem_cgroup_swappiness(memcg);
> +       int swappiness = sc->swappiness ?
> +               *sc->swappiness : mem_cgroup_swappiness(memcg);
>
> Should we use "unlikely" here to indicate that sc->swappiness is an unexpected behavior?
> Due to current use case only apply in proactive reclaim.

On a system that is not under memory pressure, the rate of proactive
reclaim could be higher than reactive reclaim. We should only use
likely/unlikely when it's obvious a scenario will happen most of the
time. I don't believe that's the case here.

>
>         u64 fraction[ANON_AND_FILE];
>         u64 denominator = 0;    /* gcc */
>         enum scan_balance scan_balance;
> @@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
>             mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>                 return 0;
>
> +       if (sc->swappiness)
> +               return *sc->swappiness;
>
> Also there.
>
> +
>         return mem_cgroup_swappiness(memcg);
>  }
>
> @@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                            unsigned long nr_pages,
>                                            gfp_t gfp_mask,
> -                                          unsigned int reclaim_options)
> +                                          unsigned int reclaim_options,
> +                                          int *swappiness)
>  {
>         unsigned long nr_reclaimed;
>         unsigned int noreclaim_flag;
> @@ -6448,6 +6456,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                 .may_unmap = 1,
>                 .may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>                 .proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> +               .swappiness = swappiness,
>         };
>         /*
>          * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> --
> 2.34.1
>
> My previous patch attempted to ensure fully deterministic semantics under extreme swappiness.
> For example, when swappiness is set to 200, only anonymous pages will be reclaimed.
> Due to code in MGLRU isolate_folios will try scan anon if no scanned, will try other type.(We do not want
> it to attempt this behavior.)
> How do you think about extreme swappiness scenarios?

I think having different semantics between swappiness passed to
proactive reclaim and global swappiness can be confusing. If it's
needed to have a swappiness value that says "anon only no matter
what", perhaps we should introduce such a new value and make it
supported by both global and proactive reclaim swappiness? We could
support writing "max" or something similar instead of a special value
to mean that.

Writing such value to global swappiness may cause problems and
premature OOMs IIUC, but that would be misconfiguration. If we think
that's dangerous, we can introduce this new value but make it valid
only for proactive reclaim for now.
