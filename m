Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB27FC42D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345643AbjK1TVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbjK1TVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:21:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927121998
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:21:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b35199f94so12175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701199272; x=1701804072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2kX/2e3hW2xYuQeL6N8B1cfHiFYGSQRCDO5Myxr9Ek=;
        b=Q+yjBtnfYkpbLTeio0fdiG/FnCqPVL1DIezBqIQYe93Yg6vhAmN7a17yWqyUZONXO9
         T9ZuqkrtSDaUOhu872WfQpxPd1vXb9AHs9Wglx/umiaYGoI/riEekoHSYL2jAwLhUuv2
         Oi4HcwulemIOLIrKPYhlDIIdvBMI9JT3KA2gn3iZ1wEeocus8qxeMyGb59dKf5i83Y4A
         H/u2e+3wyWbThIyNCHf0oG+tQLCNydt6UlnBzcvIEMKPY2neRS6cDNhdMNQ+17dz13qs
         au9Bu4N+0D4unmP/oo/vyys8fsV8rjwkpdZNQTdN2Y5Wri/iSGEdC77y17uoa0EytJ0s
         QrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701199272; x=1701804072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2kX/2e3hW2xYuQeL6N8B1cfHiFYGSQRCDO5Myxr9Ek=;
        b=t7fESfgb92y8w4kcSA4V7AkK26ZDGNuOsZMDwmdEwn+TbJqcgvE0k3K4WesSbkbU+a
         GjYrXHFqCOURNm2LFVEhif5ZZCBI9mS3D4YigNxswBMQsw+bGeacRHZqB/eVfCJag14U
         u7OEH8DtdGJgso8NMqmPHJHCdcAd3VEg8sVX/X1wOH+tdKUKj1HbJbtEfqPHAne/Ztmm
         Q0LAXp1d4TmFsTzAMOBiKNPe5VmkP2E4fVR95+fKVThzJyvRV8bFWHZH+RGZvBtsosTp
         AdKeEyCwQZ6gYtIsEFV/VXsLIR3G1lbfl2NvLjqywGt8QCfFHPSmIrUsI2xiYPr14nqL
         2Wxg==
X-Gm-Message-State: AOJu0Yx3Cb8zRLxr1UN51USIJVPytgUy2+bTpBRvRpNAh1NA1fOcXxJk
        bOebmpDL+9j/yLhIipxj1nNVQZszgH73ocKt1vFXOA==
X-Google-Smtp-Source: AGHT+IGoTRXABDJu4fFnrO34y3AjBm9f0fTVxjrSDkONHExUrC8SGFUFb0XGpc0OBSgrty2clYzV4fiSTs5y0jTGKN8=
X-Received: by 2002:a05:600c:5112:b0:40b:2979:9cc2 with SMTP id
 o18-20020a05600c511200b0040b29799cc2mr820326wms.1.1701199271844; Tue, 28 Nov
 2023 11:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <20231128175441.721579-7-namhyung@kernel.org>
In-Reply-To: <20231128175441.721579-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Nov 2023 11:20:59 -0800
Message-ID: <CAP-5=fW3f_96=rWeYg-qpL2T9VjLKnqnmq8T4dvaixWEo-0NRA@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf annotate: Ensure init/exit for global options
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

On Tue, Nov 28, 2023 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Now it only cares about the global options so it can just handle it
> without the argument.

If annotate_opts were accessed by a function then you could
pthread_once the initialization on the first call to get
annotate_opts. Removing annotation_options__init/exit would remove
some potential for error.

Thanks,
Ian


> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-annotate.c |  8 ++++----
>  tools/perf/builtin-report.c   |  8 ++++----
>  tools/perf/builtin-top.c      |  8 ++++----
>  tools/perf/util/annotate.c    | 19 +++++++++++--------
>  tools/perf/util/annotate.h    |  8 ++++----
>  5 files changed, 27 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index 87af95634879..9b3dd456a1ee 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -616,13 +616,13 @@ int cmd_annotate(int argc, const char **argv)
>         set_option_flag(options, 0, "show-total-period", PARSE_OPT_EXCLUS=
IVE);
>         set_option_flag(options, 0, "show-nr-samples", PARSE_OPT_EXCLUSIV=
E);
>
> -       annotation_options__init(&annotate_opts);
> +       annotation_options__init();
>
>         ret =3D hists__init();
>         if (ret < 0)
>                 return ret;
>
> -       annotation_config__init(&annotate_opts);
> +       annotation_config__init();
>
>         argc =3D parse_options(argc, argv, options, annotate_usage, 0);
>         if (argc) {
> @@ -652,7 +652,7 @@ int cmd_annotate(int argc, const char **argv)
>                         return -ENOMEM;
>         }
>
> -       if (annotate_check_args(&annotate_opts) < 0)
> +       if (annotate_check_args() < 0)
>                 return -EINVAL;
>
>  #ifdef HAVE_GTK2_SUPPORT
> @@ -733,7 +733,7 @@ int cmd_annotate(int argc, const char **argv)
>  #ifndef NDEBUG
>         perf_session__delete(annotate.session);
>  #endif
> -       annotation_options__exit(&annotate_opts);
> +       annotation_options__exit();
>
>         return ret;
>  }
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index bc0d986c1e0c..17fb171e898b 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1430,7 +1430,7 @@ int cmd_report(int argc, const char **argv)
>          */
>         symbol_conf.keep_exited_threads =3D true;
>
> -       annotation_options__init(&annotate_opts);
> +       annotation_options__init();
>
>         ret =3D perf_config(report__config, &report);
>         if (ret)
> @@ -1464,7 +1464,7 @@ int cmd_report(int argc, const char **argv)
>                         return -ENOMEM;
>         }
>
> -       if (annotate_check_args(&annotate_opts) < 0) {
> +       if (annotate_check_args() < 0) {
>                 ret =3D -EINVAL;
>                 goto exit;
>         }
> @@ -1696,7 +1696,7 @@ int cmd_report(int argc, const char **argv)
>                          */
>                         symbol_conf.priv_size +=3D sizeof(u32);
>                 }
> -               annotation_config__init(&annotate_opts);
> +               annotation_config__init();
>         }
>
>         if (symbol__init(&session->header.env) < 0)
> @@ -1750,7 +1750,7 @@ int cmd_report(int argc, const char **argv)
>         zstd_fini(&(session->zstd_data));
>         perf_session__delete(session);
>  exit:
> -       annotation_options__exit(&annotate_opts);
> +       annotation_options__exit();
>         free(sort_order_help);
>         free(field_order_help);
>         return ret;
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 60399e4233ee..0de963ca3196 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1608,7 +1608,7 @@ int cmd_top(int argc, const char **argv)
>         if (status < 0)
>                 return status;
>
> -       annotation_options__init(&annotate_opts);
> +       annotation_options__init();
>
>         annotate_opts.min_pcnt =3D 5;
>         annotate_opts.context  =3D 4;
> @@ -1660,7 +1660,7 @@ int cmd_top(int argc, const char **argv)
>         if (status)
>                 goto out_delete_evlist;
>
> -       if (annotate_check_args(&annotate_opts) < 0)
> +       if (annotate_check_args() < 0)
>                 goto out_delete_evlist;
>
>         if (!top.evlist->core.nr_entries) {
> @@ -1786,7 +1786,7 @@ int cmd_top(int argc, const char **argv)
>         if (status < 0)
>                 goto out_delete_evlist;
>
> -       annotation_config__init(&annotate_opts);
> +       annotation_config__init();
>
>         symbol_conf.try_vmlinux_path =3D (symbol_conf.vmlinux_name =3D=3D=
 NULL);
>         status =3D symbol__init(NULL);
> @@ -1839,7 +1839,7 @@ int cmd_top(int argc, const char **argv)
>  out_delete_evlist:
>         evlist__delete(top.evlist);
>         perf_session__delete(top.session);
> -       annotation_options__exit(&annotate_opts);
> +       annotation_options__exit();
>
>         return status;
>  }
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index daff9af552f4..626ff3baeb85 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -3416,8 +3416,10 @@ static int annotation__config(const char *var, con=
st char *value, void *data)
>         return 0;
>  }
>
> -void annotation_options__init(struct annotation_options *opt)
> +void annotation_options__init(void)
>  {
> +       struct annotation_options *opt =3D &annotate_opts;
> +
>         memset(opt, 0, sizeof(*opt));
>
>         /* Default values. */
> @@ -3428,16 +3430,15 @@ void annotation_options__init(struct annotation_o=
ptions *opt)
>         opt->percent_type =3D PERCENT_PERIOD_LOCAL;
>  }
>
> -
> -void annotation_options__exit(struct annotation_options *opt)
> +void annotation_options__exit(void)
>  {
> -       zfree(&opt->disassembler_style);
> -       zfree(&opt->objdump_path);
> +       zfree(&annotate_opts.disassembler_style);
> +       zfree(&annotate_opts.objdump_path);
>  }
>
> -void annotation_config__init(struct annotation_options *opt)
> +void annotation_config__init(void)
>  {
> -       perf_config(annotation__config, opt);
> +       perf_config(annotation__config, &annotate_opts);
>  }
>
>  static unsigned int parse_percent_type(char *str1, char *str2)
> @@ -3491,8 +3492,10 @@ int annotate_parse_percent_type(const struct optio=
n *opt __maybe_unused, const c
>         return err;
>  }
>
> -int annotate_check_args(struct annotation_options *args)
> +int annotate_check_args(void)
>  {
> +       struct annotation_options *args =3D &annotate_opts;
> +
>         if (args->prefix_strip && !args->prefix) {
>                 pr_err("--prefix-strip requires --prefix\n");
>                 return -1;
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 857c5fa0e6b1..4283eb4522b2 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -428,14 +428,14 @@ static inline int symbol__tui_annotate(struct map_s=
ymbol *ms __maybe_unused,
>  }
>  #endif
>
> -void annotation_options__init(struct annotation_options *opt);
> -void annotation_options__exit(struct annotation_options *opt);
> +void annotation_options__init(void);
> +void annotation_options__exit(void);
>
> -void annotation_config__init(struct annotation_options *opt);
> +void annotation_config__init(void);
>
>  int annotate_parse_percent_type(const struct option *opt, const char *_s=
tr,
>                                 int unset);
>
> -int annotate_check_args(struct annotation_options *args);
> +int annotate_check_args(void);
>
>  #endif /* __PERF_ANNOTATE_H */
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
