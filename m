Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA1778305
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjHJV6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHJV6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:58:22 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E5128
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:58:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-407db3e9669so42421cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704701; x=1692309501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke602Br9cN9vLFujDuIONwAWbUm8gd3UyR7/g4Jw0Qo=;
        b=mS682DNdE0F6/vOE1IliBycnl9Mos8LtKWCJ7sNvUqTOrR52hXWnyFR/PlThnVtwUc
         J1Wwk8b5b+vuB/EJQlODt+xi0+Gm3S8xDrnWRfep6NbRkfN4nstQ1WqXLsbLGtZmS1sH
         H0DBeQLfdIJp828tFb4jskAIZtwySJdjU4f86+znq6dkSmHvP1gfxI2tkrxNKbFFwprF
         PnSJr22ASI77fSodBsuZR6Ev+P4LAdziMXwNseyO818Ro6qRvyHJUCL7r0QNi2akXUML
         yumePc8kmRxisOny4VQj7UJ3awjgrC7s9XtkxD87vGxhW/wviwPzOsaXUgADUl6CDzUl
         o+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704701; x=1692309501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ke602Br9cN9vLFujDuIONwAWbUm8gd3UyR7/g4Jw0Qo=;
        b=b4gm0+kfAt2J3DP3DnaznW+cbrZW6yOGs3YoetVlvt8ImhyravRk682glmA3Nxr8td
         CRh5wrzkaz0WVPtUHj7900RcJsno/J7Xanik0QD1Xm/dOW5gvN5/JqLBJBoQuiUFwJaS
         nO4XTvb/a2eewgKOMx/nUBzc3kfD6O3NGkbOKpEIkGfahuBcHNAu3KzQzISoqv7Cxx5J
         iGfRny7anu9jg8i9GiGA6lV7AN7VlwgleJ05YgwcuzX8c5W/OCkDLo6P4HFgaaq0jH9A
         lGsWE9vTDT8jEvHArKaNCSTmu2aBprqGtckdo+LP50WZXE2gafxxUlh3ksX3ieUGXBw2
         gbOQ==
X-Gm-Message-State: AOJu0Yy9xYsqJ2YirRNsRZ6aUpivVd2eODU2NcxurC3MyIMiZ3ISrndj
        b+qfQ/hicn76YnVpt6wKS1AFa3Dt1+d9CZrBcxSYNg==
X-Google-Smtp-Source: AGHT+IEDLsOWMc94Yk+4/NJ+6Osl88TEvlbmQPsCl9gLHXiNnFKjcoaSyq/gV3oHWpauQ5T/5rV0dLf7IZTUw4yrE5w=
X-Received: by 2002:a05:622a:54:b0:3ef:5f97:258f with SMTP id
 y20-20020a05622a005400b003ef5f97258fmr87584qtw.16.1691704701290; Thu, 10 Aug
 2023 14:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZM0pjfOe6R4X/cql@kernel.org>
In-Reply-To: <ZM0pjfOe6R4X/cql@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 14:58:09 -0700
Message-ID: <CAP-5=fUc5QCg9YYgk5hfxojB5_NSpcTJcwSSP2EzGMOoWaqHoQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf probe: Make synthesize_perf_probe_point()
 private to probe-event.c
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 9:38=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Not used in any other place, so just make it static.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/probe-event.c | 4 +++-
>  tools/perf/util/probe-event.h | 1 -
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.=
c
> index 2835d87cb97771f9..1a5b7fa459b23204 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -53,6 +53,8 @@
>  bool probe_event_dry_run;      /* Dry run flag */
>  struct probe_conf probe_conf =3D { .magic_num =3D DEFAULT_PROBE_MAGIC_NU=
M };
>
> +static char *synthesize_perf_probe_point(struct perf_probe_point *pp);
> +
>  #define semantic_error(msg ...) pr_err("Semantic error :" msg)
>
>  int e_snprintf(char *str, size_t size, const char *format, ...)
> @@ -2010,7 +2012,7 @@ char *synthesize_perf_probe_arg(struct perf_probe_a=
rg *pa)
>  }
>
>  /* Compose only probe point (not argument) */
> -char *synthesize_perf_probe_point(struct perf_probe_point *pp)
> +static char *synthesize_perf_probe_point(struct perf_probe_point *pp)
>  {
>         struct strbuf buf;
>         char *tmp, *ret =3D NULL;
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.=
h
> index 8ad5b1579f1d37b6..7e3b6c3d1f7447a7 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -137,7 +137,6 @@ int parse_probe_trace_command(const char *cmd, struct=
 probe_trace_event *tev);
>  char *synthesize_perf_probe_command(struct perf_probe_event *pev);
>  char *synthesize_probe_trace_command(struct probe_trace_event *tev);
>  char *synthesize_perf_probe_arg(struct perf_probe_arg *pa);
> -char *synthesize_perf_probe_point(struct perf_probe_point *pp);
>
>  int perf_probe_event__copy(struct perf_probe_event *dst,
>                            struct perf_probe_event *src);
> --
> 2.37.1
>
