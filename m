Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB578042FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbjLDX7Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 18:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjLDX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:59:15 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81EF0;
        Mon,  4 Dec 2023 15:59:21 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58e31b5b0d0so1356842eaf.3;
        Mon, 04 Dec 2023 15:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734361; x=1702339161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrF8ef6vtfAi2l/W5MvD4pO5HMtgyjQUpfkKX/tTrNQ=;
        b=wExA0ENVLhI5PGJsv95fYObiUkZhaSKak36QJCLGdq5idi48tmASTqnA1J/ICfIxOM
         XxmUXXNDgU+JzcFzBdV++4GwYIwmx9qLCyzzoiNezJit8wFmAkl/EMsB8Uo0SAGuFlUp
         YlqZV7UQM6/6p1X+Qyi72vSi1YX5hTUOKSaeQdABk2l+O/8y2JsIcHgtf2hht1xDT2AZ
         csqXjjVFGJyr/3kHuYNdzmtAw+UEZrxMsR6QdUKn9x9EPpAK96jK1g+slIQPGuecpoEf
         z3QYoyWylVRK50D4sj+gXnYyoOdIpOVAlWZGCdSz7E1fd6iUfQmcOSMyp1/GWlGqJ4Dr
         50rw==
X-Gm-Message-State: AOJu0YxBabi0VgC5hICuX0zA/XVY28ctDCtQ4vpyFJE5tgm1z51K2QpF
        6dwYZdUS3Jr7yrvAzLypV7tOp9mzFlVzJ9bX4X4=
X-Google-Smtp-Source: AGHT+IFTkz6IhlwuQD3AsUgd5OF2zYsUl/iCDkz4fmoYJf7pqeUoFkOHf3n1oaLx90nG60CQY0OvyHl6rE+l/cmf5nA=
X-Received: by 2002:a05:6358:9101:b0:170:2bb4:c893 with SMTP id
 q1-20020a056358910100b001702bb4c893mr2736501rwq.54.1701734360538; Mon, 04 Dec
 2023 15:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-19-irogers@google.com>
In-Reply-To: <20231127220902.1315692-19-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 15:59:09 -0800
Message-ID: <CAM9d7chbysNaH++LQgeskZ_LRAF7KuErexapDTWRf-zsgPOq1g@mail.gmail.com>
Subject: Re: [PATCH v5 18/50] perf maps: Refactor maps__fixup_overlappings
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

On Mon, Nov 27, 2023 at 2:10 PM Ian Rogers <irogers@google.com> wrote:
>
> Rename to maps__fixup_overlap_and_insert as the given mapping is
> always inserted. Factor out first_ending_after as a utility
> function. Minor variable name changes. Switch to using debug_file()
> rather than passing a debug FILE*.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/maps.c   | 62 ++++++++++++++++++++++++----------------
>  tools/perf/util/maps.h   |  2 +-
>  tools/perf/util/thread.c |  3 +-
>  3 files changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index f13fd3a9686b..40df08dd9bf3 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -334,20 +334,16 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
>         return args.printed;
>  }
>
> -int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
> +/*
> + * Find first map where end > new->start.

s/new/map/.

> + * Same as find_vma() in kernel.
> + */
> +static struct rb_node *first_ending_after(struct maps *maps, const struct map *map)
>  {
>         struct rb_root *root;
>         struct rb_node *next, *first;
> -       int err = 0;
> -
> -       down_write(maps__lock(maps));
>
>         root = maps__entries(maps);
> -
> -       /*
> -        * Find first map where end > map->start.
> -        * Same as find_vma() in kernel.
> -        */
>         next = root->rb_node;
>         first = NULL;
>         while (next) {
> @@ -361,8 +357,22 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>                 } else
>                         next = next->rb_right;
>         }
> +       return first;
> +}
> +
> +/*
> + * Adds new to maps, if new overlaps existing entries then the existing maps are
> + * adjusted or removed so that new fits without overlapping any entries.
> + */
> +int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)

Do we really need this rename (map -> new)?  It seems just to create
unnecessary diffs.  Also I'd like to avoid 'new' as it's a keyword in C++
although we don't compile with C++ compilers.

> +{
> +
> +       struct rb_node *next;
> +       int err = 0;

Maybe you can add this line or let the caller pass it to reduce the diff.

    FILE *fp = debug_file();

Thanks,
Namhyung

> +
> +       down_write(maps__lock(maps));
>
> -       next = first;
> +       next = first_ending_after(maps, new);
>         while (next && !err) {
>                 struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
>                 next = rb_next(&pos->rb_node);
> @@ -371,27 +381,27 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>                  * Stop if current map starts after map->end.
>                  * Maps are ordered by start: next will not overlap for sure.
>                  */
> -               if (map__start(pos->map) >= map__end(map))
> +               if (map__start(pos->map) >= map__end(new))
>                         break;
>
>                 if (verbose >= 2) {
>
>                         if (use_browser) {
>                                 pr_debug("overlapping maps in %s (disable tui for more info)\n",
> -                                        map__dso(map)->name);
> +                                        map__dso(new)->name);
>                         } else {
> -                               fputs("overlapping maps:\n", fp);
> -                               map__fprintf(map, fp);
> -                               map__fprintf(pos->map, fp);
> +                               pr_debug("overlapping maps:\n");
> +                               map__fprintf(new, debug_file());
> +                               map__fprintf(pos->map, debug_file());
>                         }
>                 }
>
> -               rb_erase_init(&pos->rb_node, root);
> +               rb_erase_init(&pos->rb_node, maps__entries(maps));
>                 /*
>                  * Now check if we need to create new maps for areas not
>                  * overlapped by the new map:
>                  */
> -               if (map__start(map) > map__start(pos->map)) {
> +               if (map__start(new) > map__start(pos->map)) {
>                         struct map *before = map__clone(pos->map);
>
>                         if (before == NULL) {
> @@ -399,7 +409,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>                                 goto put_map;
>                         }
>
> -                       map__set_end(before, map__start(map));
> +                       map__set_end(before, map__start(new));
>                         err = __maps__insert(maps, before);
>                         if (err) {
>                                 map__put(before);
> @@ -407,11 +417,11 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>                         }
>
>                         if (verbose >= 2 && !use_browser)
> -                               map__fprintf(before, fp);
> +                               map__fprintf(before, debug_file());
>                         map__put(before);
>                 }
>
> -               if (map__end(map) < map__end(pos->map)) {
> +               if (map__end(new) < map__end(pos->map)) {
>                         struct map *after = map__clone(pos->map);
>
>                         if (after == NULL) {
> @@ -419,23 +429,25 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>                                 goto put_map;
>                         }
>
> -                       map__set_start(after, map__end(map));
> -                       map__add_pgoff(after, map__end(map) - map__start(pos->map));
> -                       assert(map__map_ip(pos->map, map__end(map)) ==
> -                               map__map_ip(after, map__end(map)));
> +                       map__set_start(after, map__end(new));
> +                       map__add_pgoff(after, map__end(new) - map__start(pos->map));
> +                       assert(map__map_ip(pos->map, map__end(new)) ==
> +                               map__map_ip(after, map__end(new)));
>                         err = __maps__insert(maps, after);
>                         if (err) {
>                                 map__put(after);
>                                 goto put_map;
>                         }
>                         if (verbose >= 2 && !use_browser)
> -                               map__fprintf(after, fp);
> +                               map__fprintf(after, debug_file());
>                         map__put(after);
>                 }
>  put_map:
>                 map__put(pos->map);
>                 free(pos);
>         }
> +       /* Add the map. */
> +       err = __maps__insert(maps, new);
>         up_write(maps__lock(maps));
>         return err;
>  }
> diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
> index b94ad5c8fea7..62e94d443c02 100644
> --- a/tools/perf/util/maps.h
> +++ b/tools/perf/util/maps.h
> @@ -133,7 +133,7 @@ struct addr_map_symbol;
>
>  int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams);
>
> -int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp);
> +int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
>
>  struct map *maps__find_by_name(struct maps *maps, const char *name);
>
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index b6986a81aa6d..3d47b5c5528b 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -345,8 +345,7 @@ int thread__insert_map(struct thread *thread, struct map *map)
>         if (ret)
>                 return ret;
>
> -       maps__fixup_overlappings(thread__maps(thread), map, stderr);
> -       return maps__insert(thread__maps(thread), map);
> +       return maps__fixup_overlap_and_insert(thread__maps(thread), map);
>  }
>
>  struct thread__prepare_access_maps_cb_args {
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
