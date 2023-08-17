Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277C477FD23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354051AbjHQRlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354052AbjHQRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:40:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64F830F3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:40:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so18978866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692294030; x=1692898830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ikpFEortTkhR9FkYMVNm4OpmTIcy4GBbKE28Gs4DMM=;
        b=JrMGk72KwiMR3DfJFBNV8+vS8+nfjQMpLlO7/FDwvfNeikZGp7HiVfNKFyW4v0cMRN
         npOEqv5efZpXFJz22/KuCr3TOl9eplI/oMLnzIdtrC5CrT/fZXjPGsj/i6EfLVfmKwc5
         u3UiEwnJuCjbGsam1VZNVHq0puPG7E9hjbxR6lXuCi8ge9vGDxCYTnRvLx+8aICfxLS3
         s2R/1h3pfgmOax210y4oz2v1/LOlMRgCq14v6osvaSalpWsnPvH0j0HY/v9hI8USQgfu
         G/OmH2ZM6IlZibO0KH7rnOStxZ0uCENsIoq1xd8z5DA7bgvORg+ywb44O3CwlalQ3BS2
         oBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294030; x=1692898830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ikpFEortTkhR9FkYMVNm4OpmTIcy4GBbKE28Gs4DMM=;
        b=cYZezcGZ71+Vtlwil0sU9yyOo8uVUdpasAzuEfvMb7ZjxhpqbEPXFlFJ1PhOXpu5Jq
         cKO/8bo/M6t7IwfGBOlTd6J2IkHQ9mb8sU34tsUgqSJYtdt4ZrhR/+Mb502PioXjZQxM
         xlBsWC+TsPVG4kqIw4u14qp8Htl52G+xjX6+WV/bLdYOX3mU0LLnXte2YIyavGXtP8R8
         ANJMZa3AHFWOcJeS2yigZEAouotC1KggUL0jqYL9axd6tgt25l52RaDJZsrsqCQlPw+o
         6zwo8IJ8qCUqaWOTZW/q0lFPDaaSW9+jaCmo7ZU00aaiep524edZYpUDKKaj0cyrspAf
         oxTA==
X-Gm-Message-State: AOJu0Yy38Ej2Hha6udEqWFsHYjX1D5lyoeRUnpiVvjLM3siS+CXLpmb8
        p3nXCnlWiMSDpR6x6gtJZSVARH703xCOyfELntkn+A==
X-Google-Smtp-Source: AGHT+IEeGH8KfSrsteafcVZhsWsAM+IUREYx0ej8iM01CDXYJAncm2jImtnXMofSotTS/W450HE4b92/fcvzKHU1Z/o=
X-Received: by 2002:a17:907:761a:b0:99e:f3:67ae with SMTP id
 jx26-20020a170907761a00b0099e00f367aemr60648ejc.31.1692294029908; Thu, 17 Aug
 2023 10:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230817164733.2475092-1-nphamcs@gmail.com>
In-Reply-To: <20230817164733.2475092-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 17 Aug 2023 10:39:53 -0700
Message-ID: <CAJD7tkYnhTOTR8OOzvmC4dbctEE951dfbAm=wZN7gEXvLNLRng@mail.gmail.com>
Subject: Re: [PATCH] workingset: ensure memcg is valid for recency check
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        kernel-team@meta.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 9:47=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> In eviction recency check, we are currently not holding a local
> reference to the memcg that the refaulted folio belonged to when it was
> evicted. This could cause serious memcg lifetime issues, for e.g in the
> memcg hierarchy traversal done in mem_cgroup_get_nr_swap_pages(). This
> has occurred in production:

Doesn't workingset_refault() call workingset_test_recent() under RCU?
Shouldn't this guarantee the validity of the memcg?

>
> [ 155757.793456] BUG: kernel NULL pointer dereference, address: 000000000=
00000c0
> [ 155757.807568] #PF: supervisor read access in kernel mode
> [ 155757.818024] #PF: error_code(0x0000) - not-present page
> [ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
> [ 155757.839985] Oops: 0000 [#1] SMP
> [ 155757.846444] CPU: 7 PID: 1380944 Comm: ThriftSrv-pri3- Kdump: loaded =
Tainted: G S                 6.4.3-0_fbk1_rc0_594_g8d0cbcaa67ba #1
> [ 155757.870808] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive M=
P, BIOS YMM16 05/24/2021
> [ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> [ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 00 48=
 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 74 42=
 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
> [ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
> [ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: ffff888=
280183000
> [ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: ffff888=
bbc2d1000
> [ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: ffff888=
ad9cedba0
> [ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: ffff888=
b23a7b000
> [ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 000007f=
fffc71354
> [ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000) kn=
lGS:0000000000000000
> [ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 0000000=
0007706e0
> [ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> [ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> [ 155758.091376] PKRU: 55555554
> [ 155758.096957] Call Trace:
> [ 155758.102016]  <TASK>
> [ 155758.106502]  ? __die+0x78/0xc0
> [ 155758.112793]  ? page_fault_oops+0x286/0x380
> [ 155758.121175]  ? exc_page_fault+0x5d/0x110
> [ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
> [ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> [ 155758.148060]  workingset_test_recent+0xda/0x1b0
> [ 155758.157133]  workingset_refault+0xca/0x1e0
> [ 155758.165508]  filemap_add_folio+0x4d/0x70
> [ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
> [ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
> [ 155758.191738]  filemap_read+0x68d/0xdf0
> [ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
> [ 155758.207981]  ? __napi_schedule+0x55/0x90
> [ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
> [ 155758.224601]  do_syscall_64+0x3d/0x80
> [ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [ 155758.242473] RIP: 0033:0x7f62c29153b5
> [ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f7 ff=
 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
> [ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX: 00=
00000000000011
> [ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 00007f6=
2c29153b5
> [ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 0000000=
000000076
> [ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 0000000=
064d5230c
> [ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 0000000=
00003c041
> [ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 0000000=
00027d450
> [ 155758.376661]  </TASK>
>
> This patch fixes the issue by getting a local reference inside
> unpack_shadow().
>
> Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs refaul=
t container")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/workingset.c | 57 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index da58a26d0d4d..c20b26bb6cb1 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -206,10 +206,11 @@ static void *pack_shadow(int memcgid, pg_data_t *pg=
dat, unsigned long eviction,
>         return xa_mk_value(eviction);
>  }
>

> -static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat=
,
> -                         unsigned long *evictionp, bool *workingsetp)
> +static void unpack_shadow(void *shadow, struct mem_cgroup **memcgp,
> +                       pg_data_t **pgdat, unsigned long *evictionp, bool=
 *workingsetp)

We should probably document that we are returning a memcg with a ref
on it, or change the name to put "get" and "memcg" in there somewhere.
Alternatively we could separate the function that gets the memcg from
the shadow (e.g. get_memcg_from_shadow or so).

I would also hold an RCU read lock here so that the call to
mem_cgroup_from_id() is valid. I know all callers currently do, but it
may change later. Alternatively we can add an assertion or a warning.

>  {
>         unsigned long entry =3D xa_to_value(shadow);
> +       struct mem_cgroup *memcg;
>         int memcgid, nid;
>         bool workingset;
>
> @@ -220,7 +221,24 @@ static void unpack_shadow(void *shadow, int *memcgid=
p, pg_data_t **pgdat,
>         memcgid =3D entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
>         entry >>=3D MEM_CGROUP_ID_SHIFT;
>
> -       *memcgidp =3D memcgid;
> +       /*
> +        * Look up the memcg associated with the stored ID. It might
> +        * have been deleted since the folio's eviction.
> +        *
> +        * Note that in rare events the ID could have been recycled
> +        * for a new cgroup that refaults a shared folio. This is
> +        * impossible to tell from the available data. However, this
> +        * should be a rare and limited disturbance, and activations
> +        * are always speculative anyway. Ultimately, it's the aging
> +        * algorithm's job to shake out the minimum access frequency
> +        * for the active cache.
> +        */
> +       memcg =3D mem_cgroup_from_id(memcgid);
> +       if (memcg && css_tryget(&memcg->css))
> +               *memcgp =3D memcg;
> +       else
> +               *memcgp =3D NULL;
> +
>         *pgdat =3D NODE_DATA(nid);
>         *evictionp =3D entry;
>         *workingsetp =3D workingset;
> @@ -262,15 +280,16 @@ static void *lru_gen_eviction(struct folio *folio)
>  static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec *=
*lruvec,
>                                 unsigned long *token, bool *workingset)
>  {
> -       int memcg_id;
>         unsigned long min_seq;
>         struct mem_cgroup *memcg;
>         struct pglist_data *pgdat;
>
> -       unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
> +       unpack_shadow(shadow, &memcg, &pgdat, token, workingset);
> +       if (!mem_cgroup_disabled() && !memcg)
> +               return false;
>
> -       memcg =3D mem_cgroup_from_id(memcg_id);
>         *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> +       mem_cgroup_put(memcg);
>
>         min_seq =3D READ_ONCE((*lruvec)->lrugen.min_seq[file]);
>         return (*token >> LRU_REFS_WIDTH) =3D=3D (min_seq & (EVICTION_MAS=
K >> LRU_REFS_WIDTH));
> @@ -421,36 +440,29 @@ bool workingset_test_recent(void *shadow, bool file=
, bool *workingset)
>         unsigned long refault_distance;
>         unsigned long workingset_size;
>         unsigned long refault;
> -       int memcgid;
>         struct pglist_data *pgdat;
>         unsigned long eviction;
>
>         if (lru_gen_enabled())
>                 return lru_gen_test_recent(shadow, file, &eviction_lruvec=
, &eviction, workingset);
>
> -       unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
> -       eviction <<=3D bucket_order;
> -
> +       unpack_shadow(shadow, &eviction_memcg, &pgdat, &eviction, working=
set);
>         /*
> -        * Look up the memcg associated with the stored ID. It might
> -        * have been deleted since the folio's eviction.
> +        * When memcg is enabled, we only get !memcg here if the
> +        * eviction group has been deleted. In that case, ignore
> +        * the refault.
>          *
> -        * Note that in rare events the ID could have been recycled
> -        * for a new cgroup that refaults a shared folio. This is
> -        * impossible to tell from the available data. However, this
> -        * should be a rare and limited disturbance, and activations
> -        * are always speculative anyway. Ultimately, it's the aging
> -        * algorithm's job to shake out the minimum access frequency
> -        * for the active cache.
> +        * When memcg is disabled, we always get NULL since there
> +        * is no root_mem_cgroup for !CONFIG_MEMCG. Continue; the
> +        * mem_cgroup_lruvec() will get us the global lruvec.
>          *
> -        * XXX: On !CONFIG_MEMCG, this will always return NULL; it
> -        * would be better if the root_mem_cgroup existed in all
> +        * XXX: It would be better if the root_mem_cgroup existed in all
>          * configurations instead.
>          */
> -       eviction_memcg =3D mem_cgroup_from_id(memcgid);
>         if (!mem_cgroup_disabled() && !eviction_memcg)
>                 return false;
>
> +       eviction <<=3D bucket_order;
>         eviction_lruvec =3D mem_cgroup_lruvec(eviction_memcg, pgdat);
>         refault =3D atomic_long_read(&eviction_lruvec->nonresident_age);
>
> @@ -493,6 +505,7 @@ bool workingset_test_recent(void *shadow, bool file, =
bool *workingset)
>                 }
>         }
>
> +       mem_cgroup_put(eviction_memcg);
>         return refault_distance <=3D workingset_size;
>  }
>
> --
> 2.34.1
>
>
