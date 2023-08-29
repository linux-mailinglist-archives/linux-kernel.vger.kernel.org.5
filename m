Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13678D0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjH2Xrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbjH2XrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:47:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C71E4C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:46:56 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so147441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693352796; x=1693957596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNESNzS8H7HloFGrnNDC9hzuF7ca6TLXzvSjPqP5meo=;
        b=PrSQfbFdRABEyL7f7SzZy4J8Ate2zEzIYtg6uvrpOLS1XjgUt0yZDfyiXgBUQBLMq7
         9fMgPWhFDd4G2MiPrmKqGB2XNmZITqpVzKbcAwcGbv8+hV+qlZvLpLqk2onSqwGrH4BO
         wk9V/XZuyUHlXWNIDmswURYHTdjnWMN9sX2ZollzBYRPk/zLCWKK5C90PUgANyywSXw6
         n04hCnOB2RC05i9NKTcBrrxD1XcutMOFyoAR8S0XZfV5DXzeYV0EgoC8/h5DCgjUkJcv
         GXHxZwaN+vM30SG+6eR66OcJxh3VldSz/LH+wwAhNtgR5zP499iXDgFvLBfqwZtLwWVu
         PTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693352796; x=1693957596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNESNzS8H7HloFGrnNDC9hzuF7ca6TLXzvSjPqP5meo=;
        b=W1i6Yt+KKX1uWU1jwCSbeKKtkuL08Gn/2QeR8xOtnEqmNPsCYQdQ4/YnCm26zWxJDa
         hik37EGRzbb4m7NU/7cvKBbSV3ACg2uvh4yP1ALYVNEoeAET+ekVJC/nv1ceRk++Fdm0
         vLVpdonpuIvJEfR2e2N6AL9doeG/8jpmzC2YkC6lw/1md9MGGVr6CwNclWYNXJipa+ig
         q/JevxaQdxHXBKRiBLtZ7fDE1uslWriRxjfhtW+hzsm4RQUM19eel8tk5JVJcMvnLmdy
         rhDpPi8lAW/XQXHxt4Zu0ZMfXtppT/RXpo8SiF1PtB+ZoUtZEdaHY17jDa/yem9sYwPn
         lUwg==
X-Gm-Message-State: AOJu0Yzk+2Kgx2SvYzUwLe3SB/WOGZrz0XXqd3gRUgoTFS5DBrC6GJR5
        up7Zq7RimSHS9jSNVojwIZ1Bb/pnc5TxT0rD8GFbGw==
X-Google-Smtp-Source: AGHT+IGFzuNrdQwx+gcjJ/4P8AiC/7DjZKZuVab25Yd9qcBWANhU+cpxSWO22rABwfjPzAUpIJaN1xRtD5Q2tfIC9SQ=
X-Received: by 2002:a05:622a:1a23:b0:3ef:5f97:258f with SMTP id
 f35-20020a05622a1a2300b003ef5f97258fmr411100qtb.16.1693352795557; Tue, 29 Aug
 2023 16:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230816114841.1679234-1-james.clark@arm.com> <20230816114841.1679234-5-james.clark@arm.com>
In-Reply-To: <20230816114841.1679234-5-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Aug 2023 16:46:23 -0700
Message-ID: <CAP-5=fVZxtgxj62EFNzweNfENVHrc8DwExcUGH-3odz=ZmMrQA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] perf jevents: Add a new expression builtin strcmp_cpuid_str()
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, john.g.garry@oracle.com,
        renyu.zj@linux.alibaba.com, acme@kernel.org,
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
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 4:52=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> This will allow writing formulas that are conditional on a specific
> CPU type or CPU version. It calls through to the existing
> strcmp_cpuid_str() function in Perf which has a default weak version,
> and an arch specific version for x86 and arm64.
>
> The function takes an 'ID' type value, which is a string. But in this
> case Arm CPU IDs are hex numbers prefixed with '0x'. metric.py
> assumes strings are only used by event names, and that they can't start
> with a number ('0'), so an additional change has to be made to the
> regex to convert hex numbers back to 'ID' types.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm64/util/pmu.c | 18 +-----------------
>  tools/perf/pmu-events/metric.py  | 17 +++++++++++++++--
>  tools/perf/util/expr.c           | 18 ++++++++++++++++++
>  tools/perf/util/expr.h           |  1 +
>  tools/perf/util/expr.l           |  1 +
>  tools/perf/util/expr.y           |  8 +++++++-
>  tools/perf/util/pmu.c            | 17 +++++++++++++++++
>  tools/perf/util/pmu.h            |  1 +
>  8 files changed, 61 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/uti=
l/pmu.c
> index 512a8f13c4de..615084eb88d8 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -2,28 +2,12 @@
>
>  #include <internal/cpumap.h>
>  #include "../../../util/cpumap.h"
> +#include "../../../util/header.h"
>  #include "../../../util/pmu.h"
>  #include "../../../util/pmus.h"
>  #include <api/fs/fs.h>
>  #include <math.h>
>
> -static struct perf_pmu *pmu__find_core_pmu(void)
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
> -
>  const struct pmu_metrics_table *pmu_metrics_table__find(void)
>  {
>         struct perf_pmu *pmu =3D pmu__find_core_pmu();
> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metr=
ic.py
> index 85a3545f5b6a..0e9ec65d92ae 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -413,6 +413,10 @@ def has_event(event: Event) -> Function:
>    # pylint: disable=3Dinvalid-name
>    return Function('has_event', event)
>
> +def strcmp_cpuid_str(event: str) -> Function:
> +  # pylint: disable=3Dredefined-builtin
> +  # pylint: disable=3Dinvalid-name
> +  return Function('strcmp_cpuid_str', event)
>
>  class Metric:
>    """An individual metric that will specifiable on the perf command line=
."""
> @@ -541,14 +545,23 @@ def ParsePerfJson(orig: str) -> Expression:
>    """
>    # pylint: disable=3Deval-used
>    py =3D orig.strip()
> +  # First try to convert everything that looks like a string (event name=
) into Event(r"EVENT_NAME").
> +  # This isn't very selective so is followed up by converting some unwan=
ted conversions back again
>    py =3D re.sub(r'([a-zA-Z][^-+/\* \\\(\),]*(?:\\.[^-+/\* \\\(\),]*)*)',
>                r'Event(r"\1")', py)
> +  # If it started with a # it should have been a literal, rather than an=
 event name
>    py =3D re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
> +  # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF)""=
) back to a constant,
> +  # but keep it wrapped in Event(), otherwise Python drops the 0x prefix=
 and it gets interpreted as
> +  # a double by the Bison parser
> +  py =3D re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py=
)
> +  # Convert accidentally converted scientific notation constants back
>    py =3D re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
> -  keywords =3D ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', '=
has_event']
> +  # Convert all the known keywords back from events to just the keyword
> +  keywords =3D ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', '=
has_event', 'strcmp_cpuid_str',
> +              'cpuid_not_more_than']
>    for kw in keywords:
>      py =3D re.sub(rf'Event\(r"{kw}"\)', kw, py)
> -
>    try:
>      parsed =3D ast.parse(py, mode=3D'eval')
>    except SyntaxError as e:
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 7410a165f68b..0985a3cbc6f9 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -13,6 +13,8 @@
>  #include <util/expr-bison.h>
>  #include <util/expr-flex.h>
>  #include "util/hashmap.h"
> +#include "util/header.h"
> +#include "util/pmu.h"
>  #include "smt.h"
>  #include "tsc.h"
>  #include <api/fs/fs.h>
> @@ -495,3 +497,19 @@ double expr__has_event(const struct expr_parse_ctx *=
ctx, bool compute_ids, const
>         evlist__delete(tmp);
>         return ret;
>  }
> +
> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx __maybe_u=
nused,
> +                      bool compute_ids __maybe_unused, const char *test_=
id)
> +{
> +       double ret;
> +       struct perf_pmu *pmu =3D pmu__find_core_pmu();
> +       char *cpuid =3D perf_pmu__getcpuid(pmu);
> +
> +       if (!cpuid)
> +               return NAN;
> +
> +       ret =3D !strcmp_cpuid_str(test_id, cpuid);
> +
> +       free(cpuid);
> +       return ret;
> +}
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 3c1e49b3e35d..c0cec29ddc29 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -55,5 +55,6 @@ double expr_id_data__value(const struct expr_id_data *d=
ata);
>  double expr_id_data__source_count(const struct expr_id_data *data);
>  double expr__get_literal(const char *literal, const struct expr_scanner_=
ctx *ctx);
>  double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_id=
s, const char *id);
> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx, bool com=
pute_ids, const char *id);
>
>  #endif
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index dbb117414710..0feef0726c48 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -114,6 +114,7 @@ if          { return IF; }
>  else           { return ELSE; }
>  source_count   { return SOURCE_COUNT; }
>  has_event      { return HAS_EVENT; }
> +strcmp_cpuid_str       { return STRCMP_CPUID_STR; }

For the sake of coverage, it'd be nice to have a test case like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/expr.c?h=3Dtmp.perf-tools-next#n257

>  {literal}      { return literal(yyscanner, sctx); }
>  {number}       { return value(yyscanner); }
>  {symbol}       { return str(yyscanner, ID, sctx->runtime); }
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 65d54a6f29ad..6c93b358cc2d 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -39,7 +39,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
>         } ids;
>  }
>
> -%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT =
EXPR_ERROR
> +%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT =
STRCMP_CPUID_STR EXPR_ERROR
>  %left MIN MAX IF
>  %left '|'
>  %left '^'
> @@ -207,6 +207,12 @@ expr: NUMBER
>         $$.ids =3D NULL;
>         free($3);
>  }
> +| STRCMP_CPUID_STR '(' ID ')'
> +{
> +       $$.val =3D expr__strcmp_cpuid_str(ctx, compute_ids, $3);
> +       $$.ids =3D NULL;
> +       free($3);
> +}
>  | expr '|' expr
>  {
>         if (is_const($1.val) && is_const($3.val)) {
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index d5406effc169..a7f05e4dda97 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1790,3 +1790,20 @@ void perf_pmu__delete(struct perf_pmu *pmu)
>         zfree(&pmu->alias_name);
>         free(pmu);
>  }
> +
> +struct perf_pmu *pmu__find_core_pmu(void)

I think as this is scanning all PMUs it more logically belongs in
pmus.c than pmu.c.

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

The RC_CHK_ACCESS can be avoided using perf_cpu_map__nr.

Not all CPUs need to be online. I think the number for the PMU is
bound by the number online while cpu__max_cpu gives the maximum
present. It is common to workaround SMT vulnerabilities by making
cores offline in which case this would never be true. I think the
following is nearly equivalent and simpler:

perf_pmus__num_core_pmus > 1 ? NULL : perf_pmus__scan_core(NULL);

Thanks,
Ian

> +                       return NULL;
> +
> +               return pmu;
> +       }
> +       return NULL;
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 6b414cecbad2..7ff925224165 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -289,5 +289,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_=
name, const char *filename,
>  struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, con=
st char *lookup_name);
>  struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head =
*core_pmus);
>  void perf_pmu__delete(struct perf_pmu *pmu);
> +struct perf_pmu *pmu__find_core_pmu(void);
>
>  #endif /* __PMU_H */
> --
> 2.34.1
>
