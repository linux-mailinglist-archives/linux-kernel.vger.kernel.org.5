Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2E807A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442838AbjLFVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbjLFVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:08:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A93D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:08:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so156e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701896926; x=1702501726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSF2AuF7azVAXQQAi6DDhpsXcqp9y9TeIZRginIvWVo=;
        b=JOSIq32WRCSDKk8fNAAU6p+kKXpqJOiDH7wefsnnXUItM2MfMZfN+39v9MzPxGO2Qn
         69QzMKapav8T2XJCIBCzLoMn5waUaUsCFvTFQrqIf3kHX2OfdqJGBxvkE8F1nicN5540
         6Qqzmtz4fQJEQZuE8T645CmXLrbJxz2cvD/8Ofxokss8QFYRrsi634PLSOsbrwVsnRMe
         V1ihVEymk0YL3qXJqRQBMs+apkh0cuUH8i15S1F8axs4gtWyC06fXLT3p01kdj98xZR+
         pn+YHJoyXqel7m43ttZmd1CX1AFoCMq8Z8/ThP7R5nO8Q8oH/pIHnBPsF3FI9dTU+nzA
         kLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896926; x=1702501726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSF2AuF7azVAXQQAi6DDhpsXcqp9y9TeIZRginIvWVo=;
        b=q9oYp3fbRU6LCpeSpIOLINohVBJZwpIIUQqz1sXcwxKwdOfa6q9Vb+zzLR+YgDkKsy
         jQV2U5EoEM0UX+owcWfc8+kn8FM6tgzqGC42zFQLhQTCkf3QmTw0wt1zLhuRZEqaA5VQ
         T08zLdJd5OkkfK+I839OOHdrPjzxCic+LDk1Ml6XXuq8Tps/MgnPopdHF8/k9e4nwSqC
         +Lo1JHqnUxjqMqUmcEDTO7oXJvICiuFnHsbVnUFYBuaX2oJAyL9PxeMshjoeGaw7dLBv
         vjDq9L1AQOAiYC627P3AUVo6MwPyYIOmJ3uacPduitKO0cSJ0Qg0NWaUze52DgwtXPfK
         eSnA==
X-Gm-Message-State: AOJu0Ywz0rxOAAftQZFn8YI2+2YJ40UP+5qpcgQr5a+SLlOBgMAqaOO0
        DsVFlQTxy/Mm4FXB0hWAWc3up1TqgLAqPwsvb/M3og==
X-Google-Smtp-Source: AGHT+IEn5mxgyLCSxkAigkUkkbJii21OI1dcQltKNGtSsZdpRjItI9ZvY9fWVnKm/3BH+BAoRSydZn9y+jXMw68FQAw=
X-Received: by 2002:ac2:549c:0:b0:50b:fcb7:15af with SMTP id
 t28-20020ac2549c000000b0050bfcb715afmr60015lfk.3.1701896925649; Wed, 06 Dec
 2023 13:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20231206201324.184059-1-kan.liang@linux.intel.com> <20231206201324.184059-5-kan.liang@linux.intel.com>
In-Reply-To: <20231206201324.184059-5-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 13:08:34 -0800
Message-ID: <CAP-5=fUDiDWT3oEqS5NmVn-muhC+P=g5rW2aEyAgAQLS=UYxQw@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf mem: Clean up perf_mem_event__supported()
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 6, 2023 at 12:13=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> For some ARCHs, e.g., ARM and AMD, to get the availability of the
> mem-events, perf checks the existence of a specific PMU. For the other
> ARCHs, e.g., Intel and Power, perf has to check the existence of some
> specific events.
>
> The current perf only iterates the mem-events-supported PMUs. It's not
> required to check the existence of a specific PMU anymore.
>
> Rename sysfs_name to event_name, which stores the specific mem-events.
> Perf only needs to check those events for the availability of the
> mem-events.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/arm64/util/mem-events.c   |  8 ++++----
>  tools/perf/arch/powerpc/util/mem-events.c |  8 ++++----
>  tools/perf/arch/x86/util/mem-events.c     | 20 ++++++++++----------
>  tools/perf/util/mem-events.c              | 16 +++++++++-------
>  tools/perf/util/mem-events.h              |  2 +-
>  5 files changed, 28 insertions(+), 26 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/ar=
m64/util/mem-events.c
> index eb2ef84f0fc8..590dddd6b0ab 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -2,10 +2,10 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>
> -#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .event_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] =3D {
> -       E("spe-load",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D0,min_latency=3D%u/",      "arm_spe_0",    true,   0),
> -       E("spe-store",  "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D0,s=
tore_filter=3D1/",                     "arm_spe_0",    false,  0),
> -       E("spe-ldst",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D1,min_latency=3D%u/",      "arm_spe_0",    true,   0),
> +       E("spe-load",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D0,min_latency=3D%u/",      NULL,   true,   0),
> +       E("spe-store",  "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D0,s=
tore_filter=3D1/",                     NULL,   false,  0),
> +       E("spe-ldst",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D1,min_latency=3D%u/",      NULL,   true,   0),
>  };
> diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/=
powerpc/util/mem-events.c
> index b7883e38950f..72a6ac2b52f5 100644
> --- a/tools/perf/arch/powerpc/util/mem-events.c
> +++ b/tools/perf/arch/powerpc/util/mem-events.c
> @@ -2,10 +2,10 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>
> -#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .event_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
>  struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX] =3D {
> -       E("ldlat-loads",        "%s/mem-loads/",        "cpu/events/mem-l=
oads",         false,  0),
> -       E("ldlat-stores",       "%s/mem-stores/",       "cpu/events/mem-s=
tores",        false,  0),
> -       E(NULL,                 NULL,                   NULL,            =
               false,  0),
> +       E("ldlat-loads",        "%s/mem-loads/",        "mem-loads",    f=
alse,  0),
> +       E("ldlat-stores",       "%s/mem-stores/",       "mem-stores",   f=
alse,  0),
> +       E(NULL,                 NULL,                   NULL,           f=
alse,  0),
>  };
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/=
util/mem-events.c
> index f0e66a0151a0..b776d849fc64 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -9,24 +9,24 @@
>
>  #define MEM_LOADS_AUX          0x8203
>
> -#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .event_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
>  struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] =3D {
> -       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "%s/eve=
nts/mem-loads",  true,   0),
> -       E("ldlat-stores",       "%s/mem-stores/P",              "%s/event=
s/mem-stores", false,  0),
> -       E(NULL,                 NULL,                           NULL,    =
               false,  0),
> +       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "mem-lo=
ads",    true,   0),
> +       E("ldlat-stores",       "%s/mem-stores/P",              "mem-stor=
es",   false,  0),
> +       E(NULL,                 NULL,                           NULL,    =
       false,  0),
>  };
>
>  struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] =
=3D {
> -       E("ldlat-loads",        "{%s/mem-loads-aux/,%s/mem-loads,ldlat=3D=
%u/}:P", "%s/events/mem-loads",  true,   MEM_LOADS_AUX),
> -       E("ldlat-stores",       "%s/mem-stores/P",              "%s/event=
s/mem-stores", false,  0),
> -       E(NULL,                 NULL,                           NULL,    =
               false,  0),
> +       E("ldlat-loads",        "{%s/mem-loads-aux/,%s/mem-loads,ldlat=3D=
%u/}:P", "mem-loads",    true,   MEM_LOADS_AUX),
> +       E("ldlat-stores",       "%s/mem-stores/P",              "mem-stor=
es",   false,  0),
> +       E(NULL,                 NULL,                           NULL,    =
       false,  0),
>  };
>
>  struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] =3D {
> -       E(NULL,         NULL,           NULL,           false,  0),
> -       E(NULL,         NULL,           NULL,           false,  0),
> -       E("mem-ldst",   "%s//",         "ibs_op",       false,  0),
> +       E(NULL,         NULL,           NULL,   false,  0),
> +       E(NULL,         NULL,           NULL,   false,  0),
> +       E("mem-ldst",   "%s//",         NULL,   false,  0),
>  };
>
>  bool is_mem_loads_aux_event(struct evsel *leader)
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 3a60cbcd6d8e..9ea9e9a868c4 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -17,12 +17,12 @@
>
>  unsigned int perf_mem_events__loads_ldlat =3D 30;
>
> -#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .event_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
>  struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] =3D {
> -       E("ldlat-loads",        "%s/mem-loads/,ldlat=3D%u/P",     "cpu/ev=
ents/mem-loads",         true,   0),
> -       E("ldlat-stores",       "%s/mem-stores/P",              "cpu/even=
ts/mem-stores",        false,  0),
> -       E(NULL,                 NULL,                           NULL,    =
                       false,  0),
> +       E("ldlat-loads",        "%s/mem-loads/,ldlat=3D%u/P",     "mem-lo=
ads",    true,   0),
> +       E("ldlat-stores",       "%s/mem-stores/P",              "mem-stor=
es",   false,  0),
> +       E(NULL,                 NULL,                           NULL,    =
       false,  0),
>  };
>  #undef E
>
> @@ -150,12 +150,14 @@ int perf_mem_events__parse(struct perf_pmu *pmu, co=
nst char *str)
>  static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *=
pmu,
>                                       struct perf_mem_event *e)
>  {
> -       char sysfs_name[100];
>         char path[PATH_MAX];
>         struct stat st;
>
> -       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->nam=
e);
> -       scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
> +       if (!e->event_name)
> +               return true;
> +
> +       scnprintf(path, PATH_MAX, "%s/devices/%s/events/%s", mnt, pmu->na=
me, e->event_name);
> +
>         return !stat(path, &st);
>  }
>
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index d257cf67d6d9..d2875d731da8 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -18,7 +18,7 @@ struct perf_mem_event {
>         u32             aux_event;
>         const char      *tag;
>         const char      *name;
> -       const char      *sysfs_name;
> +       const char      *event_name;
>  };
>
>  struct mem_info {
> --
> 2.35.1
>
