Return-Path: <linux-kernel+bounces-135764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C5B89CAF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4871C2154C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF7F143C4B;
	Mon,  8 Apr 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PypqGfGY"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3481442F8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598200; cv=none; b=VeYFj+8KYlj1vs5LEfu04M0PgW5HFUE1BKYgsKQivxamEbzgO8DA3Um0eZYC5iRbo9FcDl8cK2loM8d6DefaCuuH6dwrd4iCPmsRtXT5xABPJUFQoAguKk1P2xuBgOM8au1dblJjXmSW26hfK4/NC5tqNqh06C7HUeeUhrXZCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598200; c=relaxed/simple;
	bh=H2PE/GB3XZXbKK0MPBBxodmAP3qkf5eQdb8eETRj5aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIDByMGS4drNa+5B7L/z0vtLne898C3OCNv7sFPBFvNWOtgJMfOriqN/J4nMcYjOJ6cMojednA+g69789TvaeniWyMh9z75oHARb41K8nCLKPeZRTI45r4XsiyiBrZBDPHqH45H9SORYzhQ/aB3AQW8A1j4KYGe3LuF7/Qp2U/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PypqGfGY; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a267bb43aso5065ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712598198; x=1713202998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o69fGCwZ1aseKAM0E/aWrXAFTCP5YJpyGENWlXq4WVE=;
        b=PypqGfGYsO6afGs/QxT8c6B3RFm1JbcYI1Qr5XrNuyfpLuTne5d6IXZ+r0U9Ij2G5s
         NoC4myH63wgBzt9lcS3fLYsjbfmw1YYYe/MSQGHtmY7HfbQRzzktZcB01iTOLM+IF+D3
         yO0AvRQ6tPcdVHOlaaVtPam+I1ckk3VuCrnBPUJND11EjGc3diVirAXfPr8P0Q9+UmT5
         f3r2gP66wo1YwKcBLALCzT+584W979rXoJqBvSKigZ4ywpQNPDj+ceA6YHF20HNUEIFJ
         Fd58UXXWP8YNHeYSoEr0eKkP0MXJw9LjjaMN187kX0CcfaJB8o+b7wq0Isz134KyzV9D
         UWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598198; x=1713202998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o69fGCwZ1aseKAM0E/aWrXAFTCP5YJpyGENWlXq4WVE=;
        b=rSXfHzUTCDcVcXK2tfS+UpThNfMmrwaTcys2/FL/EJyt2hoEn+pN+so7YTlL13+1us
         SounoLtks5okIEUTOBE5yNpmNV8s3LBbGgcx48zNkrmNoshMLzDcw4V4aAJgO0a1ennB
         T0uKy/C6kJSjRKvcAUA8tCh98zuu+SB4giGmqPmZWgnZH/G9jo2y6eBmUy3v52/EarCX
         /+SiAwjPCfCAEONy2y2iO1DQIfrAErPLPg1+n+LSkd/fh8v18ko3zkxg6KDlXh4S5wrq
         7JzoClvDoQEZIUpslZ3pUjfwcmTOuFZ+zUVyK6v9Xp6KlKwvKawZnf0z/wZegQ9RyAAm
         OV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPtwNr+8tUpUvOWXND1Hl9jx8pInsme89Q44uuI+q2KsKm8vdXDHJMowQ55KCdLaiq9vzX00msc13XqyCApKb8SLFArPz0vDEB8UTX
X-Gm-Message-State: AOJu0YzLazj39S9o9erIiUhj4CoR2YSiJZX4uBrZXVxdOUcZooDfMKjS
	ocJwuXPpU2mclRYS3KSRtQnRqhsSuVQO7Hx8CgGmOf2SD3S/vefwocQk66dVhwhQjd0zpZ2vZCe
	bPTRPIqJnVneT2RSYBHH8eGNPsotgpkcSriBI
X-Google-Smtp-Source: AGHT+IEeG/FwH20PcyNoEQBrj8RDz9zltceExEaxpKho6p4OqiPHg9QN5lhHZ8qa/25VzT3speLJhhYhtyLKMRTk1d0=
X-Received: by 2002:a92:c841:0:b0:368:9438:fa09 with SMTP id
 b1-20020a92c841000000b003689438fa09mr2714ilq.24.1712598197559; Mon, 08 Apr
 2024 10:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329064803.3058900-1-irogers@google.com>
In-Reply-To: <20240329064803.3058900-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Apr 2024 10:43:04 -0700
Message-ID: <CAP-5=fWB=W1xf52b7x5npE+cHQSJR+aZfVd+bg0wkBJq=AwhDQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>, 
	Bhaskara Budiredla <bbudiredla@marvell.com>, Will Deacon <will@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:48=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The mrvl_ddr_pmu is uncore and has a hexadecimal address suffix while
> the previous PMU sorting/merging code assumes uncore PMU names start
> with uncore_ and have a decimal suffix. Because of the previous
> assumption it isn't possible to wildcard the mrvl_ddr_pmu.
>
> Modify pmu_name_len_no_suffix but also remove the suffix number out
> argument, this is because we don't know if a suffix number of say 10
> is in hexadecimal or decimal. As the only use of the suffix number is
> in comparisons, it is safe there to compare the values as hexadecimal.
>
> Add a set of PMUs tests for pmu_name_len_no_suffix and pmu_name_cmp.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Here is a link to how marvell encode their PMU names that this
patch is hoping to fix:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/drivers/perf/marvell_cn10k_ddr_pmu.c?h=3Dperf-tools-next#n675

Thanks,
Ian

> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/pmus.c         | 108 ++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   2 +
>  tools/perf/util/pmu.c           |   2 +-
>  tools/perf/util/pmus.c          |  51 ++++++++-------
>  tools/perf/util/pmus.h          |   7 ++-
>  7 files changed, 146 insertions(+), 26 deletions(-)
>  create mode 100644 tools/perf/tests/pmus.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index c7f9d9676095..a7bab6e9300f 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -14,6 +14,7 @@ perf-y +=3D perf-record.o
>  perf-y +=3D evsel-roundtrip-name.o
>  perf-$(CONFIG_LIBTRACEEVENT) +=3D evsel-tp-sched.o
>  perf-y +=3D fdarray.o
> +perf-y +=3D pmus.o
>  perf-y +=3D pmu.o
>  perf-y +=3D pmu-events.o
>  perf-y +=3D hists_common.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index d13ee7683d9d..c90f270a469a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -68,6 +68,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__parse_events,
>         &suite__expr,
>         &suite__PERF_RECORD,
> +       &suite__pmus,
>         &suite__pmu,
>         &suite__pmu_events,
>         &suite__dso_data,
> diff --git a/tools/perf/tests/pmus.c b/tools/perf/tests/pmus.c
> new file mode 100644
> index 000000000000..6279c925e689
> --- /dev/null
> +++ b/tools/perf/tests/pmus.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include "pmus.h"
> +#include "tests.h"
> +#include <string.h>
> +#include <linux/kernel.h>
> +
> +static const char * const uncore_chas[] =3D {
> +       "uncore_cha_0",
> +       "uncore_cha_1",
> +       "uncore_cha_2",
> +       "uncore_cha_3",
> +       "uncore_cha_4",
> +       "uncore_cha_5",
> +       "uncore_cha_6",
> +       "uncore_cha_7",
> +       "uncore_cha_8",
> +       "uncore_cha_9",
> +       "uncore_cha_10",
> +       "uncore_cha_11",
> +       "uncore_cha_12",
> +       "uncore_cha_13",
> +       "uncore_cha_14",
> +       "uncore_cha_15",
> +       "uncore_cha_16",
> +       "uncore_cha_17",
> +       "uncore_cha_18",
> +       "uncore_cha_19",
> +       "uncore_cha_20",
> +       "uncore_cha_21",
> +       "uncore_cha_22",
> +       "uncore_cha_23",
> +       "uncore_cha_24",
> +       "uncore_cha_25",
> +       "uncore_cha_26",
> +       "uncore_cha_27",
> +       "uncore_cha_28",
> +       "uncore_cha_29",
> +       "uncore_cha_30",
> +       "uncore_cha_31",
> +};
> +
> +static const char * const mrvl_ddrs[] =3D {
> +       "mrvl_ddr_pmu_87e1b0000000",
> +       "mrvl_ddr_pmu_87e1b1000000",
> +       "mrvl_ddr_pmu_87e1b2000000",
> +       "mrvl_ddr_pmu_87e1b3000000",
> +       "mrvl_ddr_pmu_87e1b4000000",
> +       "mrvl_ddr_pmu_87e1b5000000",
> +       "mrvl_ddr_pmu_87e1b6000000",
> +       "mrvl_ddr_pmu_87e1b7000000",
> +       "mrvl_ddr_pmu_87e1b8000000",
> +       "mrvl_ddr_pmu_87e1b9000000",
> +       "mrvl_ddr_pmu_87e1ba000000",
> +       "mrvl_ddr_pmu_87e1bb000000",
> +       "mrvl_ddr_pmu_87e1bc000000",
> +       "mrvl_ddr_pmu_87e1bd000000",
> +       "mrvl_ddr_pmu_87e1be000000",
> +       "mrvl_ddr_pmu_87e1bf000000",
> +};
> +
> +static int test__name_len(struct test_suite *test __maybe_unused, int su=
btest __maybe_unused)
> +{
> +       TEST_ASSERT_EQUAL("cpu", pmu_name_len_no_suffix("cpu"), (int)strl=
en("cpu"));
> +       TEST_ASSERT_EQUAL("i915", pmu_name_len_no_suffix("i915"), (int)st=
rlen("i915"));
> +       for (size_t i =3D 0; i < ARRAY_SIZE(uncore_chas); i++) {
> +               TEST_ASSERT_EQUAL("Strips uncore_cha suffix",
> +                               pmu_name_len_no_suffix(uncore_chas[i]),
> +                               (int)strlen("uncore_cha"));
> +       }
> +       for (size_t i =3D 0; i < ARRAY_SIZE(mrvl_ddrs); i++) {
> +               TEST_ASSERT_EQUAL("Strips mrvl_ddr_pmu suffix",
> +                               pmu_name_len_no_suffix(mrvl_ddrs[i]),
> +                               (int)strlen("mrvl_ddr_pmu"));
> +       }
> +       return TEST_OK;
> +}
> +
> +static int test__name_cmp(struct test_suite *test __maybe_unused, int su=
btest __maybe_unused)
> +{
> +       TEST_ASSERT_EQUAL("cpu", pmu_name_cmp("cpu", "cpu"), 0);
> +       TEST_ASSERT_EQUAL("i915", pmu_name_cmp("i915", "i915"), 0);
> +       TEST_ASSERT_VAL("i915", pmu_name_cmp("cpu", "i915") < 0);
> +       TEST_ASSERT_VAL("i915", pmu_name_cmp("i915", "cpu") > 0);
> +       for (size_t i =3D 1; i < ARRAY_SIZE(uncore_chas); i++) {
> +               TEST_ASSERT_VAL("uncore_cha suffixes ordered lt",
> +                               pmu_name_cmp(uncore_chas[i-1], uncore_cha=
s[i]) < 0);
> +               TEST_ASSERT_VAL("uncore_cha suffixes ordered gt",
> +                               pmu_name_cmp(uncore_chas[i], uncore_chas[=
i-1]) > 0);
> +       }
> +       for (size_t i =3D 1; i < ARRAY_SIZE(mrvl_ddrs); i++) {
> +               TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered lt",
> +                               pmu_name_cmp(mrvl_ddrs[i-1], mrvl_ddrs[i]=
) < 0);
> +               TEST_ASSERT_VAL("mrvl_ddr_pmu suffixes ordered gt",
> +                               pmu_name_cmp(mrvl_ddrs[i], mrvl_ddrs[i-1]=
) > 0);
> +       }
> +       return TEST_OK;
> +}
> +
> +static struct test_case tests__pmus[] =3D {
> +       TEST_CASE("PMU name combining", name_len),
> +       TEST_CASE("PMU name comparison", name_cmp),
> +       {       .name =3D NULL, }
> +};
> +
> +struct test_suite suite__pmus =3D {
> +       .desc =3D "PMUs test",
> +       .test_cases =3D tests__pmus,
> +};
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 3aa7701ee0e9..03278f0f7698 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -3,6 +3,7 @@
>  #define TESTS_H
>
>  #include <stdbool.h>
> +#include <debug.h>
>
>  enum {
>         TEST_OK   =3D  0,
> @@ -81,6 +82,7 @@ DECLARE_SUITE(PERF_RECORD);
>  DECLARE_SUITE(perf_evsel__roundtrip_name_test);
>  DECLARE_SUITE(perf_evsel__tp_sched_test);
>  DECLARE_SUITE(syscall_openat_tp_fields);
> +DECLARE_SUITE(pmus);
>  DECLARE_SUITE(pmu);
>  DECLARE_SUITE(pmu_events);
>  DECLARE_SUITE(attr);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f39cbbc1a7ec..b0cca5841f90 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1657,7 +1657,7 @@ static char *format_alias(char *buf, int len, const=
 struct perf_pmu *pmu,
>  {
>         struct parse_events_term *term;
>         int pmu_name_len =3D skip_duplicate_pmus
> -               ? pmu_name_len_no_suffix(pmu->name, /*num=3D*/NULL)
> +               ? pmu_name_len_no_suffix(pmu->name)
>                 : (int)strlen(pmu->name);
>         int used =3D snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->nam=
e, alias->name);
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 16505071d362..b4ddcd0ade26 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -39,31 +39,44 @@ static bool read_sysfs_all_pmus;
>
>  static void pmu_read_sysfs(bool core_only);
>
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> +int pmu_name_len_no_suffix(const char *str)
>  {
>         int orig_len, len;
>
>         orig_len =3D len =3D strlen(str);
>
> -       /* Non-uncore PMUs have their full length, for example, i915. */
> -       if (!strstarts(str, "uncore_"))
> -               return len;
> -
>         /*
>          * Count trailing digits and '_', if '_{num}' suffix isn't presen=
t use
>          * the full length.
>          */
> -       while (len > 0 && isdigit(str[len - 1]))
> +       while (len > 0 && isxdigit(str[len - 1]))
>                 len--;
>
> -       if (len > 0 && len !=3D orig_len && str[len - 1] =3D=3D '_') {
> -               if (num)
> -                       *num =3D strtoul(&str[len], NULL, 10);
> +       if (len > 0 && len !=3D orig_len && str[len - 1] =3D=3D '_')
>                 return len - 1;
> -       }
> +
>         return orig_len;
>  }
>
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
> +{
> +       unsigned long lhs_num =3D 0, rhs_num =3D 0;
> +       int lhs_pmu_name_len =3D pmu_name_len_no_suffix(lhs_pmu_name);
> +       int rhs_pmu_name_len =3D pmu_name_len_no_suffix(rhs_pmu_name);
> +       int ret =3D strncmp(lhs_pmu_name, rhs_pmu_name,
> +                       lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_nam=
e_len : rhs_pmu_name_len);
> +
> +       if (lhs_pmu_name_len !=3D rhs_pmu_name_len || ret !=3D 0 || lhs_p=
mu_name_len =3D=3D 0)
> +               return ret;
> +
> +       if (lhs_pmu_name_len + 1 < (int)strlen(lhs_pmu_name))
> +               lhs_num =3D strtoul(&lhs_pmu_name[lhs_pmu_name_len + 1], =
NULL, 16);
> +       if (rhs_pmu_name_len + 1 < (int)strlen(rhs_pmu_name))
> +               rhs_num =3D strtoul(&rhs_pmu_name[rhs_pmu_name_len + 1], =
NULL, 16);
> +
> +       return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +}
> +
>  void perf_pmus__destroy(void)
>  {
>         struct perf_pmu *pmu, *tmp;
> @@ -164,20 +177,10 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, =
const char *name)
>  static int pmus_cmp(void *priv __maybe_unused,
>                     const struct list_head *lhs, const struct list_head *=
rhs)
>  {
> -       unsigned long lhs_num =3D 0, rhs_num =3D 0;
>         struct perf_pmu *lhs_pmu =3D container_of(lhs, struct perf_pmu, l=
ist);
>         struct perf_pmu *rhs_pmu =3D container_of(rhs, struct perf_pmu, l=
ist);
> -       const char *lhs_pmu_name =3D lhs_pmu->name ?: "";
> -       const char *rhs_pmu_name =3D rhs_pmu->name ?: "";
> -       int lhs_pmu_name_len =3D pmu_name_len_no_suffix(lhs_pmu_name, &lh=
s_num);
> -       int rhs_pmu_name_len =3D pmu_name_len_no_suffix(rhs_pmu_name, &rh=
s_num);
> -       int ret =3D strncmp(lhs_pmu_name, rhs_pmu_name,
> -                       lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_nam=
e_len : rhs_pmu_name_len);
>
> -       if (lhs_pmu_name_len !=3D rhs_pmu_name_len || ret !=3D 0 || lhs_p=
mu_name_len =3D=3D 0)
> -               return ret;
> -
> -       return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> +       return pmu_name_cmp(lhs_pmu->name ?: "", rhs_pmu->name ?: "");
>  }
>
>  /* Add all pmus in sysfs to pmu list: */
> @@ -297,11 +300,11 @@ static struct perf_pmu *perf_pmus__scan_skip_duplic=
ates(struct perf_pmu *pmu)
>                 pmu_read_sysfs(/*core_only=3D*/false);
>                 pmu =3D list_prepare_entry(pmu, &core_pmus, list);
>         } else
> -               last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?:=
 "", NULL);
> +               last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?:=
 "");
>
>         if (use_core_pmus) {
>                 list_for_each_entry_continue(pmu, &core_pmus, list) {
> -                       int pmu_name_len =3D pmu_name_len_no_suffix(pmu->=
name ?: "", /*num=3D*/NULL);
> +                       int pmu_name_len =3D pmu_name_len_no_suffix(pmu->=
name ?: "");
>
>                         if (last_pmu_name_len =3D=3D pmu_name_len &&
>                             !strncmp(last_pmu_name, pmu->name ?: "", pmu_=
name_len))
> @@ -313,7 +316,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicat=
es(struct perf_pmu *pmu)
>                 pmu =3D list_prepare_entry(pmu, &other_pmus, list);
>         }
>         list_for_each_entry_continue(pmu, &other_pmus, list) {
> -               int pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?: =
"", /*num=3D*/NULL);
> +               int pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?: =
"");
>
>                 if (last_pmu_name_len =3D=3D pmu_name_len &&
>                     !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len=
))
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 94d2a08d894b..624c2d53fc30 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -2,10 +2,15 @@
>  #ifndef __PMUS_H
>  #define __PMUS_H
>
> +#include <stdbool.h>
> +#include <linux/list.h>
> +
>  struct perf_pmu;
>  struct print_callbacks;
>
> -int pmu_name_len_no_suffix(const char *str, unsigned long *num);
> +int pmu_name_len_no_suffix(const char *str);
> +/* Exposed for testing only. */
> +int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
>
>  void perf_pmus__destroy(void);
>
> --
> 2.44.0.478.gd926399ef9-goog
>

