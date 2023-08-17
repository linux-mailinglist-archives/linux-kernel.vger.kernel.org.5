Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E427677FD43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354099AbjHQRvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348454AbjHQRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:51:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B26FD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:51:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so24711cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692294676; x=1692899476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oivqyRvWG/YKwukNMhntDN6iZGmo8MOwJsjmKSG1WWk=;
        b=IgixazWFvG4Yx9ahjzRT/HQ1hZbmEgwOV55ti+GwbM6Recb4vPU2+LuEVARoRyBeVQ
         TVtiWNy7YpnZSpDjj253lIPBLtoUmLVZCFqMw82FUwiDgvYIM9ljWoLCVngzZMfLwtb7
         UhRlW0bI4I7lUahmf0i6dDVzRaTW/w3ooxo2EGnub0ljhhd9UBmNOHRo9aSWwZm7MRfj
         jua/1w3vvIUfJXkafCKuuZfWxaMg06hgVxi7Q3L1/VfNGcfPd2U9cOcIiuhHNRVpOdKg
         tWRww30Fz7dne25sYpAojIqCxtV036Kfp2XsqXR4XLNsdry6Ef/80z3xobJghYLSl7ss
         XDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294676; x=1692899476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oivqyRvWG/YKwukNMhntDN6iZGmo8MOwJsjmKSG1WWk=;
        b=ESd1eXit+M1nne1/MYevGg3mXbCh5X7sOCWbFiJnx8IBVZk1S276D41yK8xtnhw/K0
         UfRYOJuCs1xlKQrVLkcipxC6EI5uxkpnAeJvxL1dDgH/4WD0D03b/z9upFM7wfn8LYlh
         F6wg7WrSp97mgvXPGuFb0kUAqGt3EHxNU+9ur/t8XqAAfN2eXHdokI2iWjxPJPaC5l5R
         kVedVmnXkHwstLg2fFV6Zt4BX+6VDIQ4MO0ImSkhpITrUUCQVEpLRN04fMvy2nDCjWv2
         rpSIGbnZ/tP8wf7Kba+Hy8sbLp7as6SiL0nxVh1Rz2qh+x1WLXXfQTDOPl1R3YeYsaW6
         l2uA==
X-Gm-Message-State: AOJu0YwXP8oS8pzqC2TIX7B5BtxanZrXDr+TV8NIC8Qfu/+5y/zJwilG
        7luK5cMSqpc9BIXXeB58ix9fzGZtIN/7Pcbn3RyRTQ==
X-Google-Smtp-Source: AGHT+IF0lWSkbOiEZjnYKiS0dsWS8vHHxzK/J7u+QdeptFCKXMhkIM2ItVe7GHxbGF+d+2mks54FsPNdfs8xFc/QM+g=
X-Received: by 2002:a05:622a:1448:b0:3f6:97b4:1a4d with SMTP id
 v8-20020a05622a144800b003f697b41a4dmr16622qtx.23.1692294676306; Thu, 17 Aug
 2023 10:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230817170656.731066-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230817170656.731066-1-andriy.shevchenko@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Aug 2023 10:51:04 -0700
Message-ID: <CAP-5=fUn9wrgz13HHxq=BDBoOVXHfR-MT-xt5zLmy74oWhQONw@mail.gmail.com>
Subject: Re: [rfc, PATCH v1 1/1] min_heap: Make use of cmp_func_t and
 swap_func_t types
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:09=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The types.h defines standard types for comparator and swap functions.
> Convert min_heap to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/min_heap.h | 8 ++++----
>  kernel/events/core.c     | 4 ++--
>  lib/test_min_heap.c      | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 44077837385f..14da37caa235 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -26,8 +26,8 @@ struct min_heap {
>   */
>  struct min_heap_callbacks {
>         int elem_size;
> -       bool (*less)(const void *lhs, const void *rhs);
> -       void (*swp)(void *lhs, void *rhs);
> +       cmp_func_t less;

This looks wrong. A cmp_func_t will return -1, for less-than, 0 for
equal, +1 for greater-than whilst the less function here is just
providing less-than as true/false. This is done to avoid common
pitfalls around minimum integer.

> +       swap_func_t swp;

Why pass a size argument when we're specifying the swap function to use any=
way?

Thanks,
Ian

>  };
>
>  /* Sift the element at pos down the heap. */
> @@ -55,7 +55,7 @@ void min_heapify(struct min_heap *heap, int pos,
>                 }
>                 if (smallest =3D=3D parent)
>                         break;
> -               func->swp(smallest, parent);
> +               func->swp(smallest, parent, func->elem_size);
>                 if (smallest =3D=3D left)
>                         pos =3D (pos * 2) + 1;
>                 else
> @@ -127,7 +127,7 @@ void min_heap_push(struct min_heap *heap, const void =
*element,
>                 parent =3D data + ((pos - 1) / 2) * func->elem_size;
>                 if (func->less(parent, child))
>                         break;
> -               func->swp(parent, child);
> +               func->swp(parent, child, func->elem_size);
>         }
>  }
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4c72a41f11af..fa344b916290 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3639,7 +3639,7 @@ void __perf_event_task_sched_out(struct task_struct=
 *task,
>         perf_cgroup_switch(next);
>  }
>
> -static bool perf_less_group_idx(const void *l, const void *r)
> +static int perf_less_group_idx(const void *l, const void *r)
>  {
>         const struct perf_event *le =3D *(const struct perf_event **)l;
>         const struct perf_event *re =3D *(const struct perf_event **)r;
> @@ -3647,7 +3647,7 @@ static bool perf_less_group_idx(const void *l, cons=
t void *r)
>         return le->group_index < re->group_index;
>  }
>
> -static void swap_ptr(void *l, void *r)
> +static void swap_ptr(void *l, void *r, int size)
>  {
>         void **lp =3D l, **rp =3D r;
>
> diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
> index 7b01b4387cfb..63d0b2f6c060 100644
> --- a/lib/test_min_heap.c
> +++ b/lib/test_min_heap.c
> @@ -11,17 +11,17 @@
>  #include <linux/printk.h>
>  #include <linux/random.h>
>
> -static __init bool less_than(const void *lhs, const void *rhs)
> +static __init int less_than(const void *lhs, const void *rhs)
>  {
>         return *(int *)lhs < *(int *)rhs;
>  }
>
> -static __init bool greater_than(const void *lhs, const void *rhs)
> +static __init int greater_than(const void *lhs, const void *rhs)
>  {
>         return *(int *)lhs > *(int *)rhs;
>  }
>
> -static __init void swap_ints(void *lhs, void *rhs)
> +static __init void swap_ints(void *lhs, void *rhs, int size)
>  {
>         int temp =3D *(int *)lhs;
>
> --
> 2.40.0.1.gaa8946217a0b
>
