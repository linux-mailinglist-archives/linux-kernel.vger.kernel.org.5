Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A87FE67F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbjK3CJs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 21:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3CJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:09:46 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F5BD;
        Wed, 29 Nov 2023 18:09:53 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c628bf8d2eso9715a12.1;
        Wed, 29 Nov 2023 18:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701310192; x=1701914992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovI0zY83WFzXVjFngO+tObf/AjtMhdLqbooVZa7zEB0=;
        b=k/H8w4/HfR/JOLvoTw2CdtCuled8aDxUqVGTgZ/CtAKdKT/v59atGqf8PnwRqPzJmz
         syE0Erw7zQh/xoVerIpJ7y0JccGD3bHfuFKhWqFwPZFwtrgvzE/qRlzLRoPb2rK2ei5U
         9L2AscsNC5C3/A7aBmLtsadsoMcjofUq/UfRy5gjgIhOsXKYTBSubg5/sQdgTHwM4TdV
         x2kYlGLIzwMMCfOFA3p5aeRPm4xa46yUTrZCiodJhZFkw1QzoBMYYAdkLdUvdd3MtmJv
         Xdb7EI2QapoDRVpLSxyaom8SW69bOepOlfCrrgCOrKkV9trcwLsVbtV8kLC/goMMm9Oh
         jyKA==
X-Gm-Message-State: AOJu0YyNyGQWaHzxfyi0DYG8gqNwdpg5s7er6nbOJT+m63BNd3QXVwRm
        8euVd12gTbyAsphhNH7YbPjRm00KSzXPdtkMipk=
X-Google-Smtp-Source: AGHT+IFL/oWGodxfj2gIxGZ0pIi1lOlv+rNGoAZqFmmjDpiR73lQCuWvwh7JFyX9GUBVKGsurdz0lS4edmFhsSFU8hs=
X-Received: by 2002:a17:90a:dc08:b0:285:6622:ed1 with SMTP id
 i8-20020a17090adc0800b0028566220ed1mr34013929pjv.10.1701310192576; Wed, 29
 Nov 2023 18:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-9-irogers@google.com>
In-Reply-To: <20231127220902.1315692-9-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 18:09:41 -0800
Message-ID: <CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com>
Subject: Re: [PATCH v5 08/50] perf record: Be lazier in allocating lost
 samples buffer
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> Wait until a lost sample occurs to allocate the lost samples buffer,
> often the buffer isn't necessary. This saves a 64kb allocation and
> 5.3kb of peak memory consumption.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9b4f3805ca92..b6c8c1371b39 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
>  static void record__read_lost_samples(struct record *rec)
>  {
>         struct perf_session *session = rec->session;
> -       struct perf_record_lost_samples *lost;
> +       struct perf_record_lost_samples *lost = NULL;
>         struct evsel *evsel;
>
>         /* there was an error during record__open */
>         if (session->evlist == NULL)
>                 return;
>
> -       lost = zalloc(PERF_SAMPLE_MAX_SIZE);

To minimize the allocation size, this can be
sizeof(*lost) + session->machines.host.id_hdr_size
instead of PERF_SAMPLE_MAX_SIZE.

Thanks,
Namhyung


> -       if (lost == NULL) {
> -               pr_debug("Memory allocation failed\n");
> -               return;
> -       }
> -
> -       lost->header.type = PERF_RECORD_LOST_SAMPLES;
> -
>         evlist__for_each_entry(session->evlist, evsel) {
>                 struct xyarray *xy = evsel->core.sample_id;
>                 u64 lost_count;
> @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct record *rec)
>                                 }
>
>                                 if (count.lost) {
> +                                       if (!lost) {
> +                                               lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> +                                               if (!lost) {
> +                                                       pr_debug("Memory allocation failed\n");
> +                                                       return;
> +                                               }
> +                                               lost->header.type = PERF_RECORD_LOST_SAMPLES;
> +                                       }
>                                         __record__save_lost_samples(rec, evsel, lost,
>                                                                     x, y, count.lost, 0);
>                                 }
> @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct record *rec)
>                 }
>
>                 lost_count = perf_bpf_filter__lost_count(evsel);
> -               if (lost_count)
> +               if (lost_count) {
> +                       if (!lost) {
> +                               lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> +                               if (!lost) {
> +                                       pr_debug("Memory allocation failed\n");
> +                                       return;
> +                               }
> +                               lost->header.type = PERF_RECORD_LOST_SAMPLES;
> +                       }
>                         __record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
>                                                     PERF_RECORD_MISC_LOST_SAMPLES_BPF);
> +               }
>         }
>  out:
>         free(lost);
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
