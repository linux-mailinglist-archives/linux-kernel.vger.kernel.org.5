Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1D17E482C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbjKGSW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344064AbjKGSWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:22:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A48D57
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:22:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1124a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699381338; x=1699986138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSdU7JREs9y037k7A1zlejJTgak839c0Dl/WV2+r01M=;
        b=G2BtguinQ/SZN1+vz8JuNQ6y66+NYqLp6AAx5xDUqCYmKNKbJPgCxnAhSA42Nrgi2m
         K+YpI3DmQXkS+NW7IFU7/frRak8QYSPTIs3iht9nKGc1sUHIA/wPwfe4ZiBTb9eV+BB1
         dCarsrzssnyYoVymToL1bFpC8uapG5eJYP86mk3ZGPUMVkZJtJn6/DqHkuqJJ56ZG9TV
         OYgvsbuwZV2pMckoffBBqsVA+7OvI/YjoR1tbJf4+EF0fVbH3JTSG4uvz38odi7twYUt
         8nM/Ey5q2Zf9IB3Oj2YcDQjP+uJhMFSy6Lyk0pWxjIx1NWQXPqVtaaHztztfcRMzTf7h
         cn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381338; x=1699986138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSdU7JREs9y037k7A1zlejJTgak839c0Dl/WV2+r01M=;
        b=qbuCnXMp8ZFwzrSL6s21dpCiarv95XSK4FEPJaEYo0zyw5GCZcrHAR282Xeqb3gqhT
         x6YUySggEMmmirOA1knvcmQvDgH0+YGXjwoNp7NJvayBHpSKe75eeM3cYptWewb7XLHe
         cCO+W029ib5/d3IVjsd2BR8IrPijgfw/O1MEqN1iFHUsHHwpk2CReaTm25iSLut25hB2
         poGUkjjIWctctpN14vxSNFDfVzL4aTWWWgvS/PUTk91UBInsxOv7KwK94f4Ji0z5zReE
         uLxnW4TN7Dsrsd1WZtq679YLJaZ9o8oKg6yAQDNR3s0qQzngLRND7slv6iBNKU502FBy
         W89Q==
X-Gm-Message-State: AOJu0YxAmVDzrQ8aPKPMlo4Gl9aVoyg8rR07i2PLQBJq24pJEc3GIa9Z
        nJRWZxaJ7wlnGTIvOaVtGCrqLAfNPh9zyfnVH/B5uw==
X-Google-Smtp-Source: AGHT+IF96PYByCpsndEWOpjoTz6tR833V1rQ03p9fIw/MrLGg4+a1GsiZv6rwJzA46I1JXGG4tK3hVrSHXICLP+Arng=
X-Received: by 2002:a05:6402:528e:b0:544:e37e:d597 with SMTP id
 en14-20020a056402528e00b00544e37ed597mr139332edb.7.1699381338190; Tue, 07 Nov
 2023 10:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20231107083331.901-1-ravi.bangoria@amd.com>
In-Reply-To: <20231107083331.901-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Nov 2023 10:22:06 -0800
Message-ID: <CAP-5=fUkU6OBCEWeaXZ2KqeKDcXF_ZTzwwMVq=uy8CcpK90MyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default
 event on certain Zen2 processors
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, namhyung@kernel.org, kim.phillips@amd.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        changbin.du@huawei.com, yangjihong1@huawei.com,
        zwisler@chromium.org, wangming01@loongson.cn,
        chenhuacai@kernel.org, kprateek.nayak@amd.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 12:34=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> By default, Perf uses precise cycles event when no explicit event is
> specified by user. Precise cycles event is forwarded to ibs_op// pmu
> on AMD. However, IBS has hw issue on certain Zen2 processors where
> it might raise NMI without sample_valid bit set, which causes Unknown
> NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
> Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
> use non-precise cycles as default event on affected processors.
>
> This does not prevent user to use explicit precise cycles event or
> ibs_op// pmu directly.
>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks Ravi,

We read max_precise from sysfs:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n984

But it appears not to be used:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/evsel.c?h=3Dperf-tools-next#n1323

I think:
```
if (evsel->precise_max)
    attr->precise_ip =3D 3;
```
should be:
```
if (evsel->precise_max)
    attr->precise_ip =3D evsel->pmu->max_precise;
```

Presumably this is misreporting as some non-zero value on the buggy
systems - if it doesn't we can declare victory here. If not we can
modify max_precise's calculation on perf's struct pmu for cpu for AMD
so that we just hardwire it to zero in arch code.

I think I prefer this approach as it is fixing max_precise in a more
generic way. If someone were to specify "cycles:P" on the command line
then it wouldn't trigger the bug, similarly for perf script and other
places. Wdyt?

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/evlist.c | 34 +++++++++++++++++++++++++++++++
>  tools/perf/builtin-record.c       |  2 +-
>  tools/perf/builtin-top.c          |  2 +-
>  tools/perf/util/evlist.c          | 12 ++++++++++-
>  tools/perf/util/evlist.h          |  2 ++
>  5 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index b1ce0c52d88d..f4478179c91b 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -5,6 +5,8 @@
>  #include "util/evlist.h"
>  #include "util/parse-events.h"
>  #include "util/event.h"
> +#include "util/env.h"
> +#include "linux/string.h"
>  #include "topdown.h"
>  #include "evsel.h"
>
> @@ -92,3 +94,35 @@ int arch_evlist__cmp(const struct evsel *lhs, const st=
ruct evsel *rhs)
>         /* Default ordering by insertion index. */
>         return lhs->core.idx - rhs->core.idx;
>  }
> +
> +/*
> + * Precise cycles event is forwarded to ibs_op// pmu on AMD. However, IB=
S
> + * has hw issue on certain Zen2 processors where it might raise NMI with=
out
> + * sample_valid bit set, which causes Unknown NMI warnings. So default t=
o
> + * non-precise cycles event on affected processors.
> + */
> +const char *arch_evlist__default_cycles_event(bool can_profile_kernel)
> +{
> +       struct perf_env env =3D { .total_mem =3D 0, };
> +       unsigned int family, model, stepping;
> +       bool is_amd;
> +       int ret;
> +
> +       perf_env__cpuid(&env);
> +       is_amd =3D env.cpuid && strstarts(env.cpuid, "AuthenticAMD");
> +       if (!is_amd)
> +               goto out;
> +
> +       ret =3D sscanf(env.cpuid, "%*[^,],%u,%u,%u", &family, &model, &st=
epping);
> +       if (ret =3D=3D 3 && family =3D=3D 0x17 && (
> +           (model >=3D 0x30 && model <=3D 0x3f) ||
> +           (model >=3D 0x60 && model <=3D 0x7f) ||
> +           (model >=3D 0x90 && model <=3D 0x9f))) {
> +               perf_env__exit(&env);
> +               return can_profile_kernel ? "cycles" : "cycles:u";
> +       }
> +
> +out:
> +       perf_env__exit(&env);
> +       return can_profile_kernel ? "cycles:P" : "cycles:Pu";
> +}
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index dcf288a4fb9a..e58d8ac8a77b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4150,7 +4150,7 @@ int cmd_record(int argc, const char **argv)
>         if (rec->evlist->core.nr_entries =3D=3D 0) {
>                 bool can_profile_kernel =3D perf_event_paranoid_check(1);
>
> -               err =3D parse_event(rec->evlist, can_profile_kernel ? "cy=
cles:P" : "cycles:Pu");
> +               err =3D parse_event(rec->evlist, evlist__default_cycles_e=
vent(can_profile_kernel));
>                 if (err)
>                         goto out;
>         }
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..21368421eddd 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1666,7 +1666,7 @@ int cmd_top(int argc, const char **argv)
>
>         if (!top.evlist->core.nr_entries) {
>                 bool can_profile_kernel =3D perf_event_paranoid_check(1);
> -               int err =3D parse_event(top.evlist, can_profile_kernel ? =
"cycles:P" : "cycles:Pu");
> +               int err =3D parse_event(top.evlist, evlist__default_cycle=
s_event(can_profile_kernel));
>
>                 if (err)
>                         goto out_delete_evlist;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index e36da58522ef..406ed851cafc 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -90,6 +90,16 @@ struct evlist *evlist__new(void)
>         return evlist;
>  }
>
> +const char * __weak arch_evlist__default_cycles_event(bool can_profile_k=
ernel)
> +{
> +       return can_profile_kernel ? "cycles:P" : "cycles:Pu";
> +}
> +
> +const char *evlist__default_cycles_event(bool can_profile_kernel)
> +{
> +       return arch_evlist__default_cycles_event(can_profile_kernel);
> +}
> +
>  struct evlist *evlist__new_default(void)
>  {
>         struct evlist *evlist =3D evlist__new();
> @@ -100,7 +110,7 @@ struct evlist *evlist__new_default(void)
>                 return NULL;
>
>         can_profile_kernel =3D perf_event_paranoid_check(1);
> -       err =3D parse_event(evlist, can_profile_kernel ? "cycles:P" : "cy=
cles:Pu");
> +       err =3D parse_event(evlist, evlist__default_cycles_event(can_prof=
ile_kernel));
>         if (err) {
>                 evlist__delete(evlist);
>                 evlist =3D NULL;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 98e7ddb2bd30..7267b4fb1981 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -91,6 +91,8 @@ struct evsel_str_handler {
>
>  struct evlist *evlist__new(void);
>  struct evlist *evlist__new_default(void);
> +const char *arch_evlist__default_cycles_event(bool can_profile_kernel);
> +const char *evlist__default_cycles_event(bool can_profile_kernel);
>  struct evlist *evlist__new_dummy(void);
>  void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>                   struct perf_thread_map *threads);
> --
> 2.41.0
>
