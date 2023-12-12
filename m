Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F780FB57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378014AbjLLX0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjLLX0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:26:34 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A09B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:26:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50beed2a46eso1497e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702423599; x=1703028399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrt2s01oMZVD4mhR15uTSmxZTKdPalmcYJucqtImqko=;
        b=XN+XxYf31SslepDApLBoMqqnVxyZIchqVOjOoP0ufTpTIHCjfRoRmCxIvcocJkDyNn
         26EHQaMb95eOPy0VN5g5TnjitrXuemhFU9FDULXohLuj0eaF6EVQ/AO8bvZAiunE8bN4
         AMg/TAhFyRwOlfWGuT9LW3+E8GvcsPjVwfMmyoPKjg/cZScoEoWWe7KIEy15NaKrdQ8G
         TA4o6JzgSd+VpQfMV2jsYUhhFCXP1r4eKt0FSLSpESEDRtbsFHsg4YnyjiIsY2ex3hpu
         M9Kjgep6QLnDq+jLmDZTLOd7P1KH09QgWbJE48oG6K5KMOcSTpeUv7IN2vvjGHKIhMkV
         5xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423599; x=1703028399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrt2s01oMZVD4mhR15uTSmxZTKdPalmcYJucqtImqko=;
        b=ACXGXl4sPPn6CmMkHFuXafHcsj2j+vK3kEEYt8poiQ6SEoCo94C4jOPArvTnzfwZzZ
         VK3k6NSPZiQwy+q4vObRA02QJ75NzjWuk8VDru74KLXDCMmOP9cz60n+GUhHzGdaVJZG
         RBcZNmoQ4zoYjtR1w8nCOvTJ5NYTuSJ1AC2OZhOk91Rdn1ArVb2WyHZUO8b9k2YyF6J2
         QmxZER14G+JTjTa2+PxHG1lVDwe/MRp9jBQsaRGYZuvqnGy+Q6H/1dKMnlPiuEJGh8l+
         LXsrrI1L+H9//WFeJImjiYrcF9+cHDowGEz7N4WHTMUSDlbnPz3tqgcSHYHef9+4dGif
         1h0w==
X-Gm-Message-State: AOJu0YwzX6+GVxTJJ7klbxw+ydptTs3p+fiiKO82B8I0sZqOfQyA4XUi
        z9aYpqAZnR8ZY5lvjpf91lJATOw75vZ6Jba4mEQ+bg==
X-Google-Smtp-Source: AGHT+IHnAXl/bM8sb+akXNIjO3WtnqzYgqYnJROqM0OXHKZ2Tp0uHSq5BzSUbTCSJ9WOBYraJ+JL60uEaTWJN7OgsPk=
X-Received: by 2002:a05:6512:6c9:b0:50d:1a0e:ce06 with SMTP id
 u9-20020a05651206c900b0050d1a0ece06mr226121lff.5.1702423598909; Tue, 12 Dec
 2023 15:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20231212230224.1473300-1-weilin.wang@intel.com> <20231212230224.1473300-2-weilin.wang@intel.com>
In-Reply-To: <20231212230224.1473300-2-weilin.wang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 15:26:27 -0800
Message-ID: <CAP-5=fUNkFvSxCz=Tss6FSR2xZPGkteVgfeRWMjgCAosDj-CLg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/18] perf stat: Add new field in stat_config to
 enable hardware aware grouping.
To:     weilin.wang@intel.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
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

On Tue, Dec 12, 2023 at 3:02=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Hardware counter and event information could be used to help creating eve=
nt
> groups that better utilize hardware counters and improve multiplexing.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/builtin-stat.c     | 8 ++++++++
>  tools/perf/util/metricgroup.c | 5 +++++
>  tools/perf/util/metricgroup.h | 1 +
>  tools/perf/util/stat.h        | 1 +
>  4 files changed, 15 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d8e5d6f7a87a..a7a8018c3511 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2061,6 +2061,7 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> +                                               stat_config.hardware_awar=
e_grouping,
>                                                 &stat_config.metric_event=
s);
>         }
>
> @@ -2094,6 +2095,7 @@ static int add_default_attributes(void)
>                                                 stat_config.metric_no_thr=
eshold,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> +                                               stat_config.hardware_awar=
e_grouping,
>                                                 &stat_config.metric_event=
s);
>         }
>
> @@ -2128,6 +2130,7 @@ static int add_default_attributes(void)
>                                                 /*metric_no_threshold=3D*=
/true,
>                                                 stat_config.user_requeste=
d_cpu_list,
>                                                 stat_config.system_wide,
> +                                               stat_config.hardware_awar=
e_grouping,
>                                                 &stat_config.metric_event=
s) < 0)
>                         return -1;
>         }
> @@ -2169,6 +2172,7 @@ static int add_default_attributes(void)
>                                                         /*metric_no_thres=
hold=3D*/true,
>                                                         stat_config.user_=
requested_cpu_list,
>                                                         stat_config.syste=
m_wide,
> +                                                       stat_config.hardw=
are_aware_grouping,
>                                                         &stat_config.metr=
ic_events) < 0)
>                                 return -1;
>
> @@ -2502,6 +2506,9 @@ int cmd_stat(int argc, const char **argv)
>                                         (const char **) stat_usage,
>                                         PARSE_OPT_STOP_AT_NON_OPTION);
>
> +       /* Set hardware_aware_grouping to false on default before complet=
ely enable it.*/
> +       stat_config.hardware_aware_grouping =3D false;

nit: we don't normally zero values like this as the curly brace
initializer will implicitly zero all non named values being
initialized.

Thanks,
Ian

> +
>         if (stat_config.csv_sep) {
>                 stat_config.csv_output =3D true;
>                 if (!strcmp(stat_config.csv_sep, "\\t"))
> @@ -2702,6 +2709,7 @@ int cmd_stat(int argc, const char **argv)
>                                         stat_config.metric_no_threshold,
>                                         stat_config.user_requested_cpu_li=
st,
>                                         stat_config.system_wide,
> +                                       stat_config.hardware_aware_groupi=
ng,
>                                         &stat_config.metric_events);
>                 zfree(&metrics);
>         }
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 0484736d9fe4..dfbcdb517b78 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1690,12 +1690,17 @@ int metricgroup__parse_groups(struct evlist *perf=
_evlist,
>                               bool metric_no_threshold,
>                               const char *user_requested_cpu_list,
>                               bool system_wide,
> +                             bool hardware_aware_grouping,
>                               struct rblist *metric_events)
>  {
>         const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
>
>         if (!table)
>                 return -EINVAL;
> +       if (hardware_aware_grouping) {
> +               pr_debug("Use hardware aware grouping instead of traditio=
nal metric grouping method\n");
> +       }
> +
>
>         return parse_groups(perf_evlist, pmu, str, metric_no_group, metri=
c_no_merge,
>                             metric_no_threshold, user_requested_cpu_list,=
 system_wide,
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index d5325c6ec8e1..779f6ede1b51 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -77,6 +77,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlis=
t,
>                               bool metric_no_threshold,
>                               const char *user_requested_cpu_list,
>                               bool system_wide,
> +                             bool hardware_aware_grouping,
>                               struct rblist *metric_events);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>                                    const struct pmu_metrics_table *table,
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 325d0fad1842..f97d6282ba3d 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -87,6 +87,7 @@ struct perf_stat_config {
>         bool                     metric_no_group;
>         bool                     metric_no_merge;
>         bool                     metric_no_threshold;
> +       bool                     hardware_aware_grouping;
>         bool                     stop_read_counter;
>         bool                     iostat_run;
>         char                     *user_requested_cpu_list;
> --
> 2.39.3
>
