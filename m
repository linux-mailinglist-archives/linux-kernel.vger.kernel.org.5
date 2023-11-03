Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C37DFDB2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377631AbjKCBNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKCBNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:13:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5470A138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:13:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9db6cf8309cso206631266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698974023; x=1699578823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWiim298JmY2K3eaEg81rgkFs5lehta1Zy+MHKdRXqA=;
        b=cUNUvIaS/QM5ZDJp6eijheHdBVgPKwp6AulAImhvnOIPa9VzoK0R+I9SKTXZ0vgWow
         /UcVeonNcj4bncoF5voIzKgrKC42ngJgtqfWXmKpz5XLbLH3k1Y+EkrJeExKcyazrQtr
         3mrktXTfv+DLguHDaXbS43naeqJoA+hNwRNzg5kIJvOu024uBh3zYCNpiYLGTdYRnwtW
         oKugKINmZg9FCoX6wfAHfSwECg7YS5QRfh6CMKbuOv722cWbbBpDtHOLL7Xrdh3vpOm3
         qd8SaO35SiZd8EarkSx5XclW68K73mQuTiI+2jJpFvplWKzvvqi5ruXW6QFyY6yuwFX5
         9zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698974023; x=1699578823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWiim298JmY2K3eaEg81rgkFs5lehta1Zy+MHKdRXqA=;
        b=khnucQGTWytwxujPYNmXpieqQnBtTwo6PT1N+NsMnGlCtkxubP2aUDuvk6go60Skvr
         mP8lI/AondkrVSRN/YtmNXWGlLeZu+NcfIWLntxlf5ATAR5uYWXOpx8dvY9d0LpREdTv
         D+e8GCq4QLyfecUj2RtXFwkRZoF4/ylr9noKUzFRTqpckTLZARSVpBwMminIqRH3W3BI
         Vs9Xx3syi6lpDS8gPllGXKL3UoX3BMb9GxZ7lm64DEF2HsIsXCL2NSQMNpe7+Cv4Ic9k
         iFwGU5OVImcuAxnfF2I+5mtk1DGoWtGvnRjoB0+bFEQrag2gfL+tif2rvUv79/x5DKAf
         0KHg==
X-Gm-Message-State: AOJu0Yxmj4yzReHb4pdo3ftV8EI+0DRjATc3nXjtf7LXOBiF4fY5JNJE
        CojXbN++MA7CwLdvFYXi03j+bVkbMaTCe41o5nipFg==
X-Google-Smtp-Source: AGHT+IGlpE6TTe9XNhJ0AybqX9PCAlVVCLu0itRX0G7PJTd4BiiDmA0ePpE56cYI6D2zo9p/naFSUryTo4jAPJqdjgQ=
X-Received: by 2002:a17:907:a088:b0:9be:45b3:1c3b with SMTP id
 hu8-20020a170907a08800b009be45b31c3bmr6638726ejc.60.1698974022590; Thu, 02
 Nov 2023 18:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231102234236.1784543-1-nphamcs@gmail.com>
In-Reply-To: <20231102234236.1784543-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 2 Nov 2023 18:13:04 -0700
Message-ID: <CAJD7tkapfHVvF1KCm4iUDWGP0n5zV3GBcNAGDiYNHrpuODPPqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 2, 2023 at 4:42=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> During our experiment with zswap, we sometimes observe swap IOs due to
> occasional zswap store failures and writebacks-to-swap. These swapping
> IOs prevent many users who cannot tolerate swapping from adopting zswap
> to save memory and improve performance where possible.
>
> This patch adds the option to disable this behavior entirely: do not
> writeback to backing swapping device when a zswap store attempt fail,
> and do not write pages in the zswap pool back to the backing swap
> device (both when the pool is full, and when the new zswap shrinker is
> called).
>
> This new behavior can be opted-in/out on a per-cgroup basis via a new
> cgroup file. By default, writebacks to swap device is enabled, which is
> the previous behavior.
>
> Note that this is subtly different from setting memory.swap.max to 0, as
> it still allows for pages to be stored in the zswap pool (which itself
> consumes swap space in its current form).
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 11 +++++++
>  Documentation/admin-guide/mm/zswap.rst  |  6 ++++
>  include/linux/memcontrol.h              | 12 ++++++++
>  include/linux/zswap.h                   |  6 ++++
>  mm/memcontrol.c                         | 38 +++++++++++++++++++++++++
>  mm/page_io.c                            |  6 ++++
>  mm/shmem.c                              |  3 +-
>  mm/zswap.c                              | 14 +++++++++
>  8 files changed, 94 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 606b2e0eac4b..18c4171392ea 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1672,6 +1672,17 @@ PAGE_SIZE multiple when read back.
>         limit, it will refuse to take any more stores before existing
>         entries fault back in or are written out to disk.
>
> +  memory.zswap.writeback
> +       A read-write single value file which exists on non-root
> +       cgroups.  The default value is "1".
> +
> +       When this is set to 0, all swapping attempts to swapping devices
> +       are disabled. This included both zswap writebacks, and swapping d=
ue
> +       to zswap store failure.
> +
> +       Note that this is subtly different from setting memory.swap.max t=
o
> +       0, as it still allows for pages to be written to the zswap pool.
> +
>    memory.pressure
>         A read-only nested-keyed file.
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index 522ae22ccb84..b987e58edb70 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -153,6 +153,12 @@ attribute, e. g.::
>
>  Setting this parameter to 100 will disable the hysteresis.
>
> +Some users cannot tolerate the swapping that comes with zswap store fail=
ures
> +and zswap writebacks. Swapping can be disabled entirely (without disabli=
ng
> +zswap itself) on a cgroup-basis as follows:
> +
> +       echo 0 > /sys/fs/cgroup/<cgroup-name>/memory.zswap.writeback
> +
>  When there is a sizable amount of cold memory residing in the zswap pool=
, it
>  can be advantageous to proactively write these cold pages to swap and re=
claim
>  the memory for other use cases. By default, the zswap shrinker is disabl=
ed.
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 95f6c9e60ed1..e51eafdf2a15 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -219,6 +219,12 @@ struct mem_cgroup {
>
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         unsigned long zswap_max;
> +
> +       /*
> +        * Prevent pages from this memcg from being written back from zsw=
ap to
> +        * swap, and from being swapped out on zswap store failures.
> +        */
> +       bool zswap_writeback;
>  #endif
>
>         unsigned long soft_limit;
> @@ -1931,6 +1937,7 @@ static inline void count_objcg_event(struct obj_cgr=
oup *objcg,
>  bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
>  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
>  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> +bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg);
>  #else
>  static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  {
> @@ -1944,6 +1951,11 @@ static inline void obj_cgroup_uncharge_zswap(struc=
t obj_cgroup *objcg,
>                                              size_t size)
>  {
>  }
> +static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup =
*memcg)
> +{
> +       /* if zswap is disabled, do not block pages going to the swapping=
 device */
> +       return true;
> +}
>  #endif
>
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index cbd373ba88d2..b4997e27a74b 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -35,6 +35,7 @@ void zswap_swapoff(int type);
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>  void zswap_lruvec_state_init(struct lruvec *lruvec);
>  void zswap_lruvec_swapin(struct page *page);
> +bool is_zswap_enabled(void);
>  #else
>
>  struct zswap_lruvec_state {};
> @@ -55,6 +56,11 @@ static inline void zswap_swapoff(int type) {}
>  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)=
 {}
>  static inline void zswap_lruvec_init(struct lruvec *lruvec) {}
>  static inline void zswap_lruvec_swapin(struct page *page) {}
> +
> +static inline bool is_zswap_enabled(void)
> +{
> +       return false;
> +}
>  #endif
>
>  #endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e43b5aba8efc..8a6aadcc103c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5545,6 +5545,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *pa=
rent_css)
>         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> +       WRITE_ONCE(memcg->zswap_writeback, true);

Generally LGTM, just one question.

Would it be more convenient if the initial value is inherited from the
parent (the root starts with true)?

I can see this being useful if we want to set it to false on the
entire machine or one a parent cgroup, we can set it before creating
any children instead of setting it to 0 every time we create a new
cgroup.
