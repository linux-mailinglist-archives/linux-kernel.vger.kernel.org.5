Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA279EE52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjIMQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjIMQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:34:31 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5D19A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:34:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34df0f0a5beso1115ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694622866; x=1695227666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWFFHFQX+xYywYbbSeTK3OfCUdymYd0gdqigI2aRV9M=;
        b=olZSaljD7gc3EvQKp6lTos7gCt9aMJEWG2JHdlkz/SEWg9Ai3zVCs6xXP9RvLVbgKe
         xAuYOWZBhMB40MGL2/C40FUF5UGEXvhHQ4Ha8fomYli2YWdimrItgsbkrUVL/sbnP4zv
         vbirh+CRf7oa0jAqAXRYLXthSCqzctj0KZ8bmsoftxyYaKy4dYNklfBl9fbGFUYajLW/
         9Wv0++X2xp79w8zyNnQ2PU3mmmnvr+ydBUKMDcRVzr44MiN89Sf9rTT1pdaKyQ/HD5vq
         9tCi0d5CcAL/tcTV4P6B5h6ij+S9sOR6wC35hkLQg0LYW1xb+NIJ59CsZEKaaAOv1oKa
         yPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694622866; x=1695227666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWFFHFQX+xYywYbbSeTK3OfCUdymYd0gdqigI2aRV9M=;
        b=p37hDaanvprhyzyHFgVqOVZ+ndWvZdVnA2BdmEcOAXCiTLsX2QfF7nDStnQ1IKbQvo
         FQsICQtQkMdqqfBP2U+0x6ZIzGV3dnMpZIs9MMI5FzazrCjOWlfOwBPcbjha1rrLPq7z
         mdu1OyXno+WpjdtfoxX4ZbQbYQRIagfe4i20Vc9iJyVq1Fxb6JaAGmJoc565ZvWmR/eu
         HExvOP5TFNOlde5vTPxDsQzx/hrRseKOMcWobVaEBdpnJb2gVc/LpQ0zGOxAhW6+jz9t
         JLwHJgVxqEtideSn88TjRrnY50rc0kTJJEq9oVCMgDdxUGNl6BUAyxgoORu74p1FYxJX
         QTXQ==
X-Gm-Message-State: AOJu0YyaeAH5oQ5nOc/fUIvotbrJKfUOxsBPUOzJttklxZecCXF23rkZ
        znNdUh0vF8uv26vs8DWkGA0OSsME7eYRt9E+tjU5zA==
X-Google-Smtp-Source: AGHT+IEKS208SWdQd9dgGwQPG6bVOOpc6SEiQ5B15krpRmG4Yc1z+XAUux8EP1cxOaOUmixUwGrwEN7aKblkLl9v/UU=
X-Received: by 2002:a92:c263:0:b0:34d:ff4c:5e3a with SMTP id
 h3-20020a92c263000000b0034dff4c5e3amr289482ild.10.1694622866155; Wed, 13 Sep
 2023 09:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230913153355.138331-1-james.clark@arm.com> <20230913153355.138331-2-james.clark@arm.com>
In-Reply-To: <20230913153355.138331-2-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Sep 2023 09:34:13 -0700
Message-ID: <CAP-5=fWt650UXifUDvVLacqsKOEU4V1P2XdabZy5UrDVaPqPiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf pmu: Move pmu__find_core_pmu() to pmus.c
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 8:34=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> pmu__find_core_pmu() more logically belongs in pmus.c because it
> iterates over all PMUs, so move it to pmus.c
>
> At the same time rename it to perf_pmus__find_core_pmu() to match the
> naming convention in this file.
>
> list_prepare_entry() can't be used in perf_pmus__scan_core() anymore now
> that it's called from the same compilation unit. This is with -O2
> (specifically -O1 -ftree-vrp -finline-functions
> -finline-small-functions) which allow the bounds of the array
> access to be determined at compile time. list_prepare_entry() subtracts
> the offset of the 'list' member in struct perf_pmu from &core_pmus,
> which isn't a struct perf_pmu. The compiler sees that pmu results in
> &core_pmus - 8 and refuses to compile. At runtime this works because
> list_for_each_entry_continue() always adds the offset back again before
> dereferencing ->next, but it's technically undefined behavior. With
> -fsanitize=3Dundefined an additional warning is generated.
>
> Using list_first_entry_or_null() to get the first entry here avoids
> doing &core_pmus - 8 but has the same result and fixes both the compile
> warning and the undefined behavior warning. There are other uses of
> list_prepare_entry() in pmus.c, but the compiler doesn't seem to be
> able to see that they can also be called with &core_pmus, so I won't
> change any at this time.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/arm64/util/pmu.c |  6 +++---
>  tools/perf/tests/expr.c          |  2 +-
>  tools/perf/util/expr.c           |  2 +-
>  tools/perf/util/pmu.c            | 17 -----------------
>  tools/perf/util/pmu.h            |  2 +-
>  tools/perf/util/pmus.c           | 20 +++++++++++++++++++-
>  6 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/uti=
l/pmu.c
> index 615084eb88d8..3d9330feebd2 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -10,7 +10,7 @@
>
>  const struct pmu_metrics_table *pmu_metrics_table__find(void)
>  {
> -       struct perf_pmu *pmu =3D pmu__find_core_pmu();
> +       struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
>
>         if (pmu)
>                 return perf_pmu__find_metrics_table(pmu);
> @@ -20,7 +20,7 @@ const struct pmu_metrics_table *pmu_metrics_table__find=
(void)
>
>  const struct pmu_events_table *pmu_events_table__find(void)
>  {
> -       struct perf_pmu *pmu =3D pmu__find_core_pmu();
> +       struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
>
>         if (pmu)
>                 return perf_pmu__find_events_table(pmu);
> @@ -32,7 +32,7 @@ double perf_pmu__cpu_slots_per_cycle(void)
>  {
>         char path[PATH_MAX];
>         unsigned long long slots =3D 0;
> -       struct perf_pmu *pmu =3D pmu__find_core_pmu();
> +       struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
>
>         if (pmu) {
>                 perf_pmu__pathname_scnprintf(path, sizeof(path),
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 78544092ef0c..e3aa9d4fcf3a 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -76,7 +76,7 @@ static int test__expr(struct test_suite *t __maybe_unus=
ed, int subtest __maybe_u
>         struct expr_parse_ctx *ctx;
>         bool is_intel =3D false;
>         char strcmp_cpuid_buf[256];
> -       struct perf_pmu *pmu =3D pmu__find_core_pmu();
> +       struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
>         char *cpuid =3D perf_pmu__getcpuid(pmu);
>         char *escaped_cpuid1, *escaped_cpuid2;
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 4488f306de78..7be23b3ac082 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -509,7 +509,7 @@ double expr__strcmp_cpuid_str(const struct expr_parse=
_ctx *ctx __maybe_unused,
>                        bool compute_ids __maybe_unused, const char *test_=
id)
>  {
>         double ret;
> -       struct perf_pmu *pmu =3D pmu__find_core_pmu();
> +       struct perf_pmu *pmu =3D perf_pmus__find_core_pmu();
>         char *cpuid =3D perf_pmu__getcpuid(pmu);
>
>         if (!cpuid)
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index e2159854ab26..f50a5636633f 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2050,20 +2050,3 @@ void perf_pmu__delete(struct perf_pmu *pmu)
>         zfree(&pmu->id);
>         free(pmu);
>  }
> -
> -struct perf_pmu *pmu__find_core_pmu(void)
> -{
> -       struct perf_pmu *pmu =3D NULL;
> -
> -       while ((pmu =3D perf_pmus__scan_core(pmu))) {
> -               /*
> -                * The cpumap should cover all CPUs. Otherwise, some CPUs=
 may
> -                * not support some events or have different event IDs.
> -                */
> -               if (RC_CHK_ACCESS(pmu->cpus)->nr !=3D cpu__max_cpu().cpu)
> -                       return NULL;
> -
> -               return pmu;
> -       }
> -       return NULL;
> -}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index bd5d804a6736..d7b46085642d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -264,6 +264,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_=
name, const char *filename,
>  struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, con=
st char *lookup_name);
>  struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head =
*core_pmus);
>  void perf_pmu__delete(struct perf_pmu *pmu);
> -struct perf_pmu *pmu__find_core_pmu(void);
> +struct perf_pmu *perf_pmus__find_core_pmu(void);
>
>  #endif /* __PMU_H */
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 6631367c756f..cec869cbe163 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -10,6 +10,7 @@
>  #include <pthread.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include "cpumap.h"
>  #include "debug.h"
>  #include "evsel.h"
>  #include "pmus.h"
> @@ -268,7 +269,7 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu=
 *pmu)
>  {
>         if (!pmu) {
>                 pmu_read_sysfs(/*core_only=3D*/true);
> -               pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> +               return list_first_entry_or_null(&core_pmus, typeof(*pmu),=
 list);
>         }
>         list_for_each_entry_continue(pmu, &core_pmus, list)
>                 return pmu;
> @@ -592,3 +593,20 @@ struct perf_pmu *evsel__find_pmu(const struct evsel =
*evsel)
>         }
>         return pmu;
>  }
> +
> +struct perf_pmu *perf_pmus__find_core_pmu(void)
> +{
> +       struct perf_pmu *pmu =3D NULL;
> +
> +       while ((pmu =3D perf_pmus__scan_core(pmu))) {
> +               /*
> +                * The cpumap should cover all CPUs. Otherwise, some CPUs=
 may
> +                * not support some events or have different event IDs.
> +                */
> +               if (RC_CHK_ACCESS(pmu->cpus)->nr !=3D cpu__max_cpu().cpu)
> +                       return NULL;
> +
> +               return pmu;
> +       }
> +       return NULL;
> +}
> --
> 2.34.1
>
