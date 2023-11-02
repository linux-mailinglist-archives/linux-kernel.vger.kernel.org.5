Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BAD7DFD5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjKBX4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjKBX4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:56:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D4192
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:56:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50931d0bb04so1819e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698969363; x=1699574163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=655oA7OKDcu91aw4GqFY5zeS2TBodJXNtrwxTf8vVRY=;
        b=R3ga4TMP1YSD6orm+zNiZK+G7VanRkgDZVm7K0dX/8Nns825wggpubCC9wI4ILFibW
         Gv+S+o1Uu9OeeSDL8wSHJOU2yerMnVOlQxGePAb/YIAZEYpIkan8Zr0OeVGanRos+Urc
         /+C4YqmV+7JPuIdVdG885bFbwBbZEQPSc2AqCzgvxDhmOFCiXakQ+HmTFmDGHyVO5vaY
         4NgioDzh3k5VBxRM9UxQvxw8Uxdsq5tqSSSx9dGbuJYbSEECRNWiZZfWUvDXtCgIEKr8
         yN2oizXusyn8J4KhsPbY+jXF4VDb++JLr+SD/6rd5LoGvwW0VWf4g9ozwLqE3/SzXchM
         zcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698969363; x=1699574163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=655oA7OKDcu91aw4GqFY5zeS2TBodJXNtrwxTf8vVRY=;
        b=S/4DUb/zVJJx0n/7/bi2Zmt2PH1SuqQPWPJwezo5+EOE+FtQEsDtKlQFjQaUu9BffQ
         Z/aR1UeuUYWBTp0bmyKBfaLiS6GAr4/qvKlASrftYc9NWNsQ3xJjIQ+96ECGx2niVz3x
         7x8XqWe/9bsLoTEqP7a62vd29VZknSnfvOH5nHNA21CXK5761Ue+ge5K3va3r6R21CVn
         lZMbLcUhtNdmobRPmjqWKclvdarqhIUbkCXdH/0PJmy26n4HrN4K0CJdSIpW+woVWc38
         LYZuQ7K9rU+qWvRUdL5rd1grQv/FUsk6cQMhX6E9kp2KziPQIcNd4Pk8k93vabD6qRb6
         yXEg==
X-Gm-Message-State: AOJu0YxOu22CGFX+pVoqzgHF6q8BsOTW1FyLLCr0FVUNiv5vRQ1shHi0
        N+RdZLzUIp2ankkNWgTaXPioPp2oYQQuSyORdTtOeA==
X-Google-Smtp-Source: AGHT+IE/o8eAvzxS2JXI7MiIr3nBo4t/9x2ApeDCA/2FMhkXv0hjBENRL7yDmvoZLqaEGa59p8kcuEpsMm1kHrA5q/A=
X-Received: by 2002:a05:6512:2387:b0:507:9a37:1483 with SMTP id
 c7-20020a056512238700b005079a371483mr99832lfv.3.1698969362729; Thu, 02 Nov
 2023 16:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231102234013.4188687-1-namhyung@kernel.org>
In-Reply-To: <20231102234013.4188687-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 16:55:50 -0700
Message-ID: <CAP-5=fUuDB6W8yUaWu_7SVK5CGBuRLHh8amERQ2dqka_eOX6XQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Simplify object code reading test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 4:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> It tries cycles (or cpu-clock on s390) event with exclude_kernel bit to
> open.  But other arch on a VM can fail with the hardware event and need
> to fallback to the software event in the same way.
>
> So let's get rid of the cpuid check and use generic fallback mechanism
> using an array of event candidates.  Now event in the odd index excludes
> the kernel so use that for the return value.
>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/code-reading.c | 76 ++++++++++-----------------------
>  1 file changed, 23 insertions(+), 53 deletions(-)
>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-read=
ing.c
> index 3af81012014e..047ba297c6fa 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -511,38 +511,6 @@ static void fs_something(void)
>         }
>  }
>
> -#ifdef __s390x__
> -#include "header.h" // for get_cpuid()
> -#endif
> -
> -static const char *do_determine_event(bool excl_kernel)
> -{
> -       const char *event =3D excl_kernel ? "cycles:u" : "cycles";
> -
> -#ifdef __s390x__
> -       char cpuid[128], model[16], model_c[16], cpum_cf_v[16];
> -       unsigned int family;
> -       int ret, cpum_cf_a;
> -
> -       if (get_cpuid(cpuid, sizeof(cpuid)))
> -               goto out_clocks;
> -       ret =3D sscanf(cpuid, "%*[^,],%u,%[^,],%[^,],%[^,],%x", &family, =
model_c,
> -                    model, cpum_cf_v, &cpum_cf_a);
> -       if (ret !=3D 5)            /* Not available */
> -               goto out_clocks;
> -       if (excl_kernel && (cpum_cf_a & 4))
> -               return event;
> -       if (!excl_kernel && (cpum_cf_a & 2))
> -               return event;
> -
> -       /* Fall through: missing authorization */
> -out_clocks:
> -       event =3D excl_kernel ? "cpu-clock:u" : "cpu-clock";
> -
> -#endif
> -       return event;
> -}
> -
>  static void do_something(void)
>  {
>         fs_something();
> @@ -583,8 +551,10 @@ static int do_test_code_reading(bool try_kcore)
>         int err =3D -1, ret;
>         pid_t pid;
>         struct map *map;
> -       bool have_vmlinux, have_kcore, excl_kernel =3D false;
> +       bool have_vmlinux, have_kcore;
>         struct dso *dso;
> +       const char *events[] =3D { "cycles", "cycles:u", "cpu-clock", "cp=
u-clock:u", NULL };
> +       int evidx =3D 0;
>
>         pid =3D getpid();
>
> @@ -618,7 +588,7 @@ static int do_test_code_reading(bool try_kcore)
>
>         /* No point getting kernel events if there is no kernel object */
>         if (!have_vmlinux && !have_kcore)
> -               excl_kernel =3D true;
> +               evidx++;
>
>         threads =3D thread_map__new_by_tid(pid);
>         if (!threads) {
> @@ -646,7 +616,7 @@ static int do_test_code_reading(bool try_kcore)
>                 goto out_put;
>         }
>
> -       while (1) {
> +       while (events[evidx]) {
>                 const char *str;
>
>                 evlist =3D evlist__new();
> @@ -657,7 +627,7 @@ static int do_test_code_reading(bool try_kcore)
>
>                 perf_evlist__set_maps(&evlist->core, cpus, threads);
>
> -               str =3D do_determine_event(excl_kernel);
> +               str =3D events[evidx];
>                 pr_debug("Parsing event '%s'\n", str);
>                 ret =3D parse_event(evlist, str);
>                 if (ret < 0) {
> @@ -675,32 +645,32 @@ static int do_test_code_reading(bool try_kcore)
>
>                 ret =3D evlist__open(evlist);
>                 if (ret < 0) {
> -                       if (!excl_kernel) {
> -                               excl_kernel =3D true;
> -                               /*
> -                                * Both cpus and threads are now owned by=
 evlist
> -                                * and will be freed by following perf_ev=
list__set_maps
> -                                * call. Getting reference to keep them a=
live.
> -                                */
> -                               perf_cpu_map__get(cpus);
> -                               perf_thread_map__get(threads);
> -                               perf_evlist__set_maps(&evlist->core, NULL=
, NULL);
> -                               evlist__delete(evlist);
> -                               evlist =3D NULL;
> -                               continue;
> -                       }
> +                       evidx++;
>
> -                       if (verbose > 0) {
> +                       if (events[evidx] =3D=3D NULL && verbose > 0) {
>                                 char errbuf[512];
>                                 evlist__strerror_open(evlist, errno, errb=
uf, sizeof(errbuf));
>                                 pr_debug("perf_evlist__open() failed!\n%s=
\n", errbuf);
>                         }
>
> -                       goto out_put;
> +                       /*
> +                        * Both cpus and threads are now owned by evlist
> +                        * and will be freed by following perf_evlist__se=
t_maps
> +                        * call. Getting reference to keep them alive.
> +                        */
> +                       perf_cpu_map__get(cpus);
> +                       perf_thread_map__get(threads);
> +                       perf_evlist__set_maps(&evlist->core, NULL, NULL);
> +                       evlist__delete(evlist);
> +                       evlist =3D NULL;
> +                       continue;
>                 }
>                 break;
>         }
>
> +       if (events[evidx] =3D=3D NULL)
> +               goto out_put;
> +
>         ret =3D evlist__mmap(evlist, UINT_MAX);
>         if (ret < 0) {
>                 pr_debug("evlist__mmap failed\n");
> @@ -721,7 +691,7 @@ static int do_test_code_reading(bool try_kcore)
>                 err =3D TEST_CODE_READING_NO_KERNEL_OBJ;
>         else if (!have_vmlinux && !try_kcore)
>                 err =3D TEST_CODE_READING_NO_VMLINUX;
> -       else if (excl_kernel)
> +       else if (evidx % 2)
>                 err =3D TEST_CODE_READING_NO_ACCESS;

Perhaps it would be more intention revealing to do:

if (strstr(events[evidx], ":u"))

rather than the "evidx % 2".

Thanks,
Ian

>         else
>                 err =3D TEST_CODE_READING_OK;
> --
> 2.42.0.869.gea05f2083d-goog
>
