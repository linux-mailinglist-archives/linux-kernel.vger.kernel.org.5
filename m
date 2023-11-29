Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B183A7FDC14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbjK2P6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjK2P6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:58:21 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19543D46
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:58:28 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7c4ed6740c7so812212241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701273507; x=1701878307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvIYvtqU0arhalNfrboD1I7LGBKoYlMorHiQQOVTcUQ=;
        b=X7XvcuMpH1ZOeG0fWD5oMSEMpTMUWsxICTFeRVqKgsbWmeSybyTZrUHFjJRN/ZPc6s
         MkGlX8Iv+tvF5ouPC8vBS4MpDEm2G5DZFa/VyOse+D6c+//0HzP8D7218trWH6nIv8WG
         j2xg/3Cnb1xOojrwK5Jrp6kUESmJr7GpO/pw3dppjhSS3i1H6WcztbF8ZNtGIfsik6Dm
         l42bwebvrNOPKDM4Pp2FfGSPtBd1c7FVUBVi5FHIlNBviLbOqCHygNAwbCMj1DN6mh5f
         c2HhhSbMwx1DUtfeRKCpLkv6gTgynuyiIXHPctzvytVWR7/hY5QeppSiiqx4NuJo1diP
         eQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273507; x=1701878307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvIYvtqU0arhalNfrboD1I7LGBKoYlMorHiQQOVTcUQ=;
        b=eKEdG1adGJ8tABdnmmjrm023hxByyQbbkJpZh8UAqaxC1ZzX4hacZZGyaHEJIx0H2y
         EVNDp9FwzC49Ap+Q+Nl/hZFv9iEp7QcRthWdqZzrsk1RQZ0nNlVzITOgBejh8rLlvsG7
         n92rF+BPjovUhKp7JAWpxDq4DqNl6T7X7YEsMDGBAHDSgW1Gq1cOKbIQiVP2ANvAd87a
         7u/rxpSrtAWPuIEUfDYTpcl02cbp638/ioksDGWXp0iUvvyZLBrHX6f3hToc8ZFaFmBV
         9BwbOjnjK/hI+vm9jw9O/YQBNvrfJTmi7g4CM7gJV3jKuiSqGCizM8CxH78ZSzNHkfvY
         7H/A==
X-Gm-Message-State: AOJu0YxladM5kfUVwtuvPrzrLW97upLOMfrRTgfm68Z0jNgCVGV2ZONY
        UkuqaLCtd3JliVfWURukZeGt3eWUas1JnUDH+U+i1w==
X-Google-Smtp-Source: AGHT+IFrFNrDFwV2WBYvXYmyAqhDBak35lw7vEiNQv6Jt04vbkDAAJiX/LMh2CynijscTm1lgV09PDrBEeBNFwC9GNk=
X-Received: by 2002:a05:6102:2fa:b0:464:4c9d:6f1d with SMTP id
 j26-20020a05610202fa00b004644c9d6f1dmr1575751vsj.23.1701273506271; Wed, 29
 Nov 2023 07:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20231129154718.326330-1-acme@kernel.org> <20231129154718.326330-3-acme@kernel.org>
In-Reply-To: <20231129154718.326330-3-acme@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Nov 2023 16:57:47 +0100
Message-ID: <CANpmjNMftTuqPwmujNx5e+ajgdYtik9uL6dt62Ucotc7oz-uUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests sigtrap: Skip if running on a kernel with
 sleepable spinlocks
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, 29 Nov 2023 at 16:47, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> There are issues as reported that need some more investigation on the
> RT kernel front, till that is addressed, skip this test.
>
> This test is already skipped for multiple hardware architectures where
> the tested kernel feature is not supported.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  tools/perf/tests/sigtrap.c | 46 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index a1bc7c776254ed2f..e6fd934b027a3d0c 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -103,6 +103,34 @@ static bool attr_has_sigtrap(void)
>
>         return __btf_type__find_member_by_name(id, "sigtrap") != NULL;
>  }
> +
> +static bool kernel_with_sleepable_spinlocks(void)
> +{
> +       const struct btf_member *member;
> +       const struct btf_type *type;
> +       const char *type_name;
> +       int id;
> +
> +       if (!btf__available())
> +               return false;
> +
> +       id = btf__find_by_name_kind(btf, "spinlock", BTF_KIND_STRUCT);
> +       if (id < 0)
> +               return false;
> +
> +       // Only RT has a "lock" member for "struct spinlock"
> +       member = __btf_type__find_member_by_name(id, "lock");
> +       if (member == NULL)
> +               return false;
> +
> +       // But check its type as well
> +       type = btf__type_by_id(btf, member->type);
> +       if (!type || !btf_is_struct(type))
> +               return false;
> +
> +       type_name = btf__name_by_offset(btf, type->name_off);
> +       return type_name && !strcmp(type_name, "rt_mutex_base");
> +}
>  #else  /* !HAVE_BPF_SKEL */
>  static bool attr_has_sigtrap(void)
>  {
> @@ -125,6 +153,11 @@ static bool attr_has_sigtrap(void)
>         return ret;
>  }
>
> +static bool kernel_with_sleepable_spinlocks(void)
> +{
> +       return false;
> +}
> +
>  static void btf__exit(void)
>  {
>  }
> @@ -166,7 +199,7 @@ static int run_test_threads(pthread_t *threads, pthread_barrier_t *barrier)
>
>  static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrier)
>  {
> -       int ret;
> +       int ret, expected_sigtraps;
>
>         ctx.iterate_on = 3000;
>
> @@ -175,7 +208,16 @@ static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrie
>         ret = run_test_threads(threads, barrier);
>         TEST_ASSERT_EQUAL("disable failed", ioctl(fd, PERF_EVENT_IOC_DISABLE, 0), 0);
>
> -       TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
> +       expected_sigtraps = NUM_THREADS * ctx.iterate_on;
> +
> +       if (ctx.signal_count < expected_sigtraps && kernel_with_sleepable_spinlocks()) {
> +               pr_debug("Expected %d sigtraps, got %d, running on a kernel with sleepable spinlocks.\n",
> +                        expected_sigtraps, ctx.signal_count);
> +               pr_debug("See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/\n");

No changes from the RT side since? A fix exists, but apparently not
good enough... Sigh.

> +               return TEST_SKIP;
> +       } else
> +               TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, expected_sigtraps);
> +
>         TEST_ASSERT_EQUAL("missing signals or incorrectly delivered", ctx.tids_want_signal, 0);
>         TEST_ASSERT_VAL("unexpected si_addr", ctx.first_siginfo.si_addr == &ctx.iterate_on);
>  #if 0 /* FIXME: enable when libc's signal.h has si_perf_{type,data} */
> --
> 2.41.0
>
