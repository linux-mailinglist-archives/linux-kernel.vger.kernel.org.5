Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673FA7BD35F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbjJIGbP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 02:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJIGbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:31:14 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF98A4;
        Sun,  8 Oct 2023 23:31:12 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3376430a12.3;
        Sun, 08 Oct 2023 23:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696833072; x=1697437872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD0Fv9cM67zX2LwKdhCrzGLuQATLW6HXC5O4/Nd4nTE=;
        b=XQx9nJdNInB7FMmd3ZJTpmO4FS24dWqb1hmTV34meNbtFJzWEWbYnEPI4nCnz5MGug
         h8JeDO/etFa9bWZt7S70L9lC8il0yulMAgzIEF6fprs7MJpcrkzIJPbagJ81F+d+pqw6
         9/8znFo5jqUqbb5h2a99ige5sucIMWMfRl/WrbwQQngNn6tvlDdHX+G1J525e+6kD7Ef
         oS2sYP5qfHxC9Ut/rXsFkHsK/SFz4omAMk9FZBndx17pijibbI0emY9RXlPG7PJ9gfYV
         4eo4pFhgi3IHhqtYrjyB5UU2yAaaoTAwaL0DwvDxiT5NpViiI3X8wOt3NjijZ9VBH851
         Qd3Q==
X-Gm-Message-State: AOJu0YyGTJJBPrjacvj0F4QVe8W2wA9LGSf3rWYsQYKT2sQS/E/hQdrj
        KHbjHi3+UHISKo83F9O1IFaEwI9O+waVvOMbHN/V3occ
X-Google-Smtp-Source: AGHT+IEOQspT2cmBHQKFmpyVLLR+19S0QFb8macQedL/e+/KbEJLcVDbtXZ0lZH43XNvVA3aOx01YcU7aI64n/+lMyk=
X-Received: by 2002:a17:90b:11cc:b0:277:6d6a:33ba with SMTP id
 gv12-20020a17090b11cc00b002776d6a33bamr14075416pjb.28.1696833072180; Sun, 08
 Oct 2023 23:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-14-irogers@google.com>
In-Reply-To: <20231005230851.3666908-14-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 8 Oct 2023 23:31:01 -0700
Message-ID: <CAM9d7cj-ANu1j-6WxGDQ_+pJtDt1xfyuGCNyC_dTpCDECZZgCQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] perf svghelper: Avoid memory leak
To:     Ian Rogers <irogers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
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

On Thu, Oct 5, 2023 at 4:09 PM Ian Rogers <irogers@google.com> wrote:
>
> On success path the sib_core and sib_thr values weren't being
> freed. Detected by clang-tidy.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-lock.c   | 1 +
>  tools/perf/util/svghelper.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index d4b22313e5fc..1b40b00c9563 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2463,6 +2463,7 @@ static int parse_call_stack(const struct option *opt __maybe_unused, const char
>                 entry = malloc(sizeof(*entry) + strlen(tok) + 1);
>                 if (entry == NULL) {
>                         pr_err("Memory allocation failure\n");
> +                       free(s);
>                         return -1;
>                 }
>

This is unrelated.  Please put it in a separate patch.

Thanks,
Namhyung


> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index 0e4dc31c6c9c..1892e9b6aa7f 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
>         int i, nr_cpus;
>         struct topology t;
>         char *sib_core, *sib_thr;
> +       int ret = -1;
>
>         nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
>
> @@ -799,11 +800,11 @@ int svg_build_topology_map(struct perf_env *env)
>
>         scan_core_topology(topology_map, &t, nr_cpus);
>
> -       return 0;
> +       ret = 0;
>
>  exit:
>         zfree(&t.sib_core);
>         zfree(&t.sib_thr);
>
> -       return -1;
> +       return ret;
>  }
> --
> 2.42.0.609.gbb76f46606-goog
>
