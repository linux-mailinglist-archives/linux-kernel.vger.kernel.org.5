Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5D7FE5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbjK3BZy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 20:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:25:53 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A8510C6;
        Wed, 29 Nov 2023 17:25:59 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2839b418f7fso503293a91.2;
        Wed, 29 Nov 2023 17:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701307559; x=1701912359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXtHLSq+EKlXiK3+DIMCv+P/V741jLaA1RjUhoggFmU=;
        b=Qr4qYWr3yWT6JK5ClVizV3aFkkYOijAunQiCHU1no5jqn7jB+/gXAefkaBE+LEy/Wp
         MSqwPHnkwFCePuJKNLLHSp+Qu60fsFncQEyPlXwtx1xQCxSiE02eGSRhCQxJ+5vLkkDF
         hvxPCcW4JT/rC3lxPX2DRskckc1WfYc4D3skZ5i5wByMTN6He42p5DnHqrLWxvQWkNa4
         3PXl411tGGIIqr8tJNke/TStoDXkjZIZvz3M5OfAduBhi8fdVJzXyKBv/PR3xYZCtWWU
         mo6YmFO/P53Xs2KmGEUTmXH6B15FPuP30OguHn9gpXtro2mBEYDn5+WIbeLW4O+65ORE
         IbsA==
X-Gm-Message-State: AOJu0YzIV4X2KauNXALsTITA4OTuMsVY0Jex7n8jrquPxiNDtthhPBl9
        F14odfjn5CMkWvN7Fc/ifgzcjMDt4ZzOZ6wHxvw=
X-Google-Smtp-Source: AGHT+IHa1AJ7Hpi63469LJdM3guOkATtiHbJQ3T7XZ0tXpBMHJfhv4rUPUxZD7PBYyixDJ71HBhw4DrCZ+EJYckGEdg=
X-Received: by 2002:a17:90b:3c2:b0:285:772b:91a3 with SMTP id
 go2-20020a17090b03c200b00285772b91a3mr20174672pjb.27.1701307558816; Wed, 29
 Nov 2023 17:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-3-irogers@google.com>
In-Reply-To: <20231127220902.1315692-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 17:25:47 -0800
Message-ID: <CAM9d7cgEpzGUyWrA0vuTKMfj6ojaeDEFCzCDzB3CjRn-TtTtuA@mail.gmail.com>
Subject: Re: [PATCH v5 02/50] libperf: Lazily allocate/size mmap event copy
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> The event copy in the mmap is used to have storage to read an
> event. Not all users of mmaps read the events, such as perf
> record. The amount of buffer was also statically set to
> PERF_SAMPLE_MAX_SIZE rather than the amount necessary from the
> header's event size. Switch to a model where the event_copy is
> reallocated if too small to the event's size. This adds the potential
> for the event to move, so if a copy of the event pointer were stored
> it could be broken. All the current users do:
>
>   while(event = perf_mmap__read_event()) { ... }
>
> and so they would be broken due to the event being overwritten if they
> had stored the pointer. Manual inspection and address sanitizer
> testing also shows the event pointer not being stored.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/lib/perf/include/internal/mmap.h |  3 ++-
>  tools/lib/perf/mmap.c                  | 21 ++++++++++++++++++---
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
> index 5a062af8e9d8..5f08cab61ece 100644
> --- a/tools/lib/perf/include/internal/mmap.h
> +++ b/tools/lib/perf/include/internal/mmap.h
> @@ -33,7 +33,8 @@ struct perf_mmap {
>         bool                     overwrite;
>         u64                      flush;
>         libperf_unmap_cb_t       unmap_cb;
> -       char                     event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
> +       void                    *event_copy;
> +       size_t                   event_copy_sz;
>         struct perf_mmap        *next;
>  };
>
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 2184814b37dd..c829db7bf1fa 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -19,6 +19,7 @@
>  void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
>                      bool overwrite, libperf_unmap_cb_t unmap_cb)
>  {
> +       /* Assume fields were zero initialized. */
>         map->fd = -1;
>         map->overwrite = overwrite;
>         map->unmap_cb  = unmap_cb;
> @@ -51,13 +52,19 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
>
>  void perf_mmap__munmap(struct perf_mmap *map)
>  {
> -       if (map && map->base != NULL) {
> +       if (!map)
> +               return;
> +
> +       free(map->event_copy);
> +       map->event_copy = NULL;
> +       map->event_copy_sz = 0;
> +       if (map->base) {
>                 munmap(map->base, perf_mmap__mmap_len(map));
>                 map->base = NULL;
>                 map->fd = -1;
>                 refcount_set(&map->refcnt, 0);
>         }
> -       if (map && map->unmap_cb)
> +       if (map->unmap_cb)
>                 map->unmap_cb(map);
>  }
>
> @@ -223,9 +230,17 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
>                  */
>                 if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
>                         unsigned int offset = *startp;
> -                       unsigned int len = min(sizeof(*event), size), cpy;
> +                       unsigned int len = size, cpy;
>                         void *dst = map->event_copy;
>
> +                       if (size > map->event_copy_sz) {
> +                               dst = realloc(map->event_copy, size);
> +                               if (!dst)
> +                                       return NULL;
> +                               map->event_copy = dst;
> +                               map->event_copy_sz = size;
> +                       }
> +
>                         do {
>                                 cpy = min(map->mask + 1 - (offset & map->mask), len);
>                                 memcpy(dst, &data[offset & map->mask], cpy);
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
