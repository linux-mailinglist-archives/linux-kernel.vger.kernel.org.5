Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3C7673A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjG1RmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjG1RmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:42:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE1F2115
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:42:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so4168718e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690566137; x=1691170937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYLF84njYUu7JSVKHy5D6nCKlYMLp+3wofRRJeXEu7E=;
        b=iziTcra8O3kMOn7bPIAuiGktuKrjNiFuJrcytTPBjE9Z/F/6KagvBYqTFcSv0A2VD7
         fT0v2rYCw920LjFd2VW/H4+JnPKVEVA0k0pjKSQK/V7Fp+Pw95jdZ6RnXE+mirtB7RXX
         dVKIW5mX6DYU1TjRy+tJe62RfohmYOUgi9H0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566137; x=1691170937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYLF84njYUu7JSVKHy5D6nCKlYMLp+3wofRRJeXEu7E=;
        b=MeP/0FUrdpqmmVXTSa3yZMm224OOjk4/bPA/KVFvTooBkp/hNSoi92xFj+r4k+qSN2
         sOUk6jICkGAISouqZoAm2ONe2SDN3y8zxm6dlHZFmwjjBDA7P52FLdoAnP9E4yOt6cII
         N+sGUnQF8GQbRuexOmTJxQbDW4MOJIeDEINhiL565RVV1JLdEkdm8h6VAlDMBzTGvLdn
         +O4DZToSUI6RhFZmfuPlN8xh1ZXY6nJS9sEoTUO4QsJ+Xuuw3Dzx2lqvwgrN+DFbFQwk
         xeNMTVzOl6+7nhSseb0fE7B47I69Qm2v2Bm8RIa/HfqvAwk6nIl1BiTcRk2HxjJy+oCm
         sbIQ==
X-Gm-Message-State: ABy/qLaB6kFoxSrIgwwa7VU3MalLIADlUlhlbMKaUheJFT12LyA22cH+
        Cp+8uiCxXIFzvViWVk1EvkFXUMdv3ch73sP2QiO7Iw==
X-Google-Smtp-Source: APBJJlG+syxVWj31WyFpRDPU//DQTURjhEbh1wZ/zUchJicEJUyhjhyKV0VnmRkXLQh+8lqsZFetH31/oxxS+EeaRmM=
X-Received: by 2002:a19:9146:0:b0:4fb:7b4c:d38c with SMTP id
 y6-20020a199146000000b004fb7b4cd38cmr2103056lfj.60.1690566137512; Fri, 28 Jul
 2023 10:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230718000737.49077-1-ivan@cloudflare.com>
In-Reply-To: <20230718000737.49077-1-ivan@cloudflare.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 28 Jul 2023 10:42:06 -0700
Message-ID: <CABWYdi2E1XozvwsZwOA80X-YbqLejj_5sxzNAh7w6R93rD5sCw@mail.gmail.com>
Subject: Re: [PATCH] perf script: print cgroup on the same line as comm
To:     linux-perf-users@vger.kernel.org
Cc:     kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 5:07=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> Commit 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> added support for printing cgroup path in perf script output.
>
> It was okay if you didn't want any stacks:
>
>     $ sudo perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgrou=
p
>     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.serv=
ice
>     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.serv=
ice
>
> With stacks it gets messier as cgroup is printed after the stack:
>
>     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,=
sym
>     jpegtran:23f4bf 3321915 [013] 404718.587488:
>                     5c554 compress_output
>                     570d9 jpeg_finish_compress
>                     3476e jpegtran_main
>                     330ee jpegtran::main
>                     326e2 core::ops::function::FnOnce::call_once (inlined=
)
>                     326e2 std::sys_common::backtrace::__rust_begin_short_=
backtrace
>     /idle.slice/polish.service
>     jpegtran:23f4bf 3321915 [031] 404718.592073:
>                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
>                 55af68e62fff [unknown]
>     /idle.slice/polish.service
>
> Let's instead print cgroup on the same line as comm:
>
>     $ perf script --comms jpegtran:23f4bf -F comm,tid,cpu,time,cgroup,ip,=
sym
>     jpegtran:23f4bf 3321915 [013] 404718.587488:  /idle.slice/polish.serv=
ice
>                     5c554 compress_output
>                     570d9 jpeg_finish_compress
>                     3476e jpegtran_main
>                     330ee jpegtran::main
>                     326e2 core::ops::function::FnOnce::call_once (inlined=
)
>                     326e2 std::sys_common::backtrace::__rust_begin_short_=
backtrace
>
>     jpegtran:23f4bf 3321915 [031] 404718.592073:  /idle.slice/polish.serv=
ice
>                     8474d jsimd_encode_mcu_AC_first_prepare_sse2.PADDING
>                 55af68e62fff [unknown]
>
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 3fd7a168bf51 ("perf script: Add 'cgroup' field for output")
> ---
>  tools/perf/builtin-script.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 200b3e7ea8da..517bf25750c8 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2199,6 +2199,17 @@ static void process_event(struct perf_script *scri=
pt,
>         if (PRINT_FIELD(RETIRE_LAT))
>                 fprintf(fp, "%16" PRIu16, sample->retire_lat);
>
> +       if (PRINT_FIELD(CGROUP)) {
> +               const char *cgrp_name;
> +               struct cgroup *cgrp =3D cgroup__find(machine->env,
> +                                                  sample->cgroup);
> +               if (cgrp !=3D NULL)
> +                       cgrp_name =3D cgrp->name;
> +               else
> +                       cgrp_name =3D "unknown";
> +               fprintf(fp, " %s", cgrp_name);
> +       }
> +
>         if (PRINT_FIELD(IP)) {
>                 struct callchain_cursor *cursor =3D NULL;
>
> @@ -2243,17 +2254,6 @@ static void process_event(struct perf_script *scri=
pt,
>         if (PRINT_FIELD(CODE_PAGE_SIZE))
>                 fprintf(fp, " %s", get_page_size_name(sample->code_page_s=
ize, str));
>
> -       if (PRINT_FIELD(CGROUP)) {
> -               const char *cgrp_name;
> -               struct cgroup *cgrp =3D cgroup__find(machine->env,
> -                                                  sample->cgroup);
> -               if (cgrp !=3D NULL)
> -                       cgrp_name =3D cgrp->name;
> -               else
> -                       cgrp_name =3D "unknown";
> -               fprintf(fp, " %s", cgrp_name);
> -       }
> -
>         perf_sample__fprintf_ipc(sample, attr, fp);
>
>         fprintf(fp, "\n");
> --
> 2.41.0
>

A friendly bump in case this slipped through the cracks.
