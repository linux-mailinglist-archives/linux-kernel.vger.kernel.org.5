Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0430E7D73C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJYTBL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:01:09 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC810E;
        Wed, 25 Oct 2023 12:01:08 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-565e54cb93aso99560a12.3;
        Wed, 25 Oct 2023 12:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260467; x=1698865267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFFp1teDPTWctvGkI7bKcJj5VRaVw2/baBUihjKuLl8=;
        b=YOsPyctpJ841e2DNiD87/TjFzFrBqL5IYKn1+0iG4LmAZGo03FhqIujqkmLBfR4Pbr
         dSS/3GRo6rZjIjwXvyD/kkQeaE0t1Wqzlmtf8N8ONYd4EQUpExDdr9E+XoGXAM/4HN3H
         GXpoYqOvXt2DF57MlbVaD4c7/cQGnMDvQisNmaCLnt+OzgSrQ17IhiR96R8xZyAfaGo6
         nw5C/4HoHUUzJnBbiruZIX8pZi5BsS2vWqwlfeqwmLfG7jigVgd20prYvkx8tZbRAWGE
         rh3zk9X2Qk8+1IDblpooSpCSnXj0RVz0H43yDDqn2a1pXnZePuI9pVRQdQ1qkH4I2ACs
         zc4A==
X-Gm-Message-State: AOJu0YzTptOYgmIUZSSciTbsEpHcQRdqgaKA6skVDz7pYuy/rJm28RVq
        oJJY0pPExCqxIfNZbzvGolioWcpHiIrb+Poy3TpwJ8afy9Q=
X-Google-Smtp-Source: AGHT+IHdfdJTZRIPepX8FQ+H7h+vOc2whDrTlCapGWKT2dM5oWBx0JJg09yVoS0zsJY7Tls/djhijSwzE9/tCpZ8JA4=
X-Received: by 2002:a17:90b:608:b0:27d:44ce:cf7a with SMTP id
 gb8-20020a17090b060800b0027d44cecf7amr14544657pjb.5.1698260467237; Wed, 25
 Oct 2023 12:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-21-irogers@google.com>
In-Reply-To: <20231024222353.3024098-21-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Oct 2023 12:00:56 -0700
Message-ID: <CAM9d7cgMVcr-ZV2m=9B=B82PmGgWDWecBvt+fMhk-Yhzk_Q5Ow@mail.gmail.com>
Subject: Re: [PATCH v3 20/50] perf record: Be lazier in allocating lost
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 3:25 PM Ian Rogers <irogers@google.com> wrote:
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

Sorry for naively choosing the max size. :-p
It could be sizeof(*lost) + machine->id_hdr_size.

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
> 2.42.0.758.gaed0368e0e-goog
>
