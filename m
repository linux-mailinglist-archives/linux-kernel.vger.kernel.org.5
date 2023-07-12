Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA237511D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjGLU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGLU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:29:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B161995
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:29:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-401d1d967beso24891cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689193786; x=1691785786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYEhqtsCFgnxUsrxAXzlsfjXutPKO/4GrN4GfHlOkLw=;
        b=R1elMqVd8GauM+jyHEu6R4P2hHe4DQyh8MARF5aCperoL46YLrLuxQASTaLVmcjjIS
         kiXvEGxP8WVknrVVS85b5dvkp6yff5ZwLlMyH3QpW8coiYnO9XlvPA5TdG4txX9IJhyU
         JEyaKnXli8526Zrexmkcu9vk7vaoFA9VoIvePAgJx8kJX0I6WtGwDxNe/WPrTg7S6mGn
         SSEmygKYp2cuPviiAEJjhgz0eJagx/GcOQ5iInt5QDwUFh96p5OYoAD+CyQunOMj9BIR
         xtDxTegKGBh6+5Jk+OJXeI/fCRBkRg82JqGLnxgDi59FEFASaDmHLN9xGoKCnhgLmtvl
         efhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689193786; x=1691785786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYEhqtsCFgnxUsrxAXzlsfjXutPKO/4GrN4GfHlOkLw=;
        b=eAEGR4QPDzogsheLLh9eDKwYpfvp9MTiat4rMkb4ev8/jX/n+KfJnEIwByupltc89d
         Ip+y4yj16kXIT/9d1n3RvUgSWfAhAEGzEK742RDl6VAFElWBG9JGVZGC6FtjqwVQP5oi
         6wFvQuais4ncdUlRbCRfj3v1IfnhNvRE2q+LPZMSORBwQod2rpUwz3FcWBwIwkl5lMbp
         EniQ/LSaUl2dOS1tOvgylHqTAbmesOVkgsRckjasCHnWjunc8N06h5UAg1uLFptfPX1A
         n229WDkdVUi/s2S4R/MrAo6XtOg2MyYeRjmj9E1aBzLwjan1OS9z5TOhVOnh+z5GJef/
         bMmw==
X-Gm-Message-State: ABy/qLZpYVU3aLXMkEi6NUt07QuDJHxj+X3x90gmzwNz2kc0uxTWlzAg
        amvxYSOBr6E2fuEA+Q0XmwEF7+5SfqUwt1at7byj9A==
X-Google-Smtp-Source: APBJJlGCrzevPZYv4cL5+wbXLWCmqe62dJDGYJXMikF27y1mKUStZmxXRZd0OeXslPHHC9HPJB4ECgnZJDI2m7anUJw=
X-Received: by 2002:a05:622a:178a:b0:3f9:56c:1129 with SMTP id
 s10-20020a05622a178a00b003f9056c1129mr290908qtk.5.1689193786205; Wed, 12 Jul
 2023 13:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230712065250.1450306-1-irogers@google.com> <ZK7+i63XprkGwjCE@kernel.org>
In-Reply-To: <ZK7+i63XprkGwjCE@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 13:29:34 -0700
Message-ID: <CAP-5=fWOTn0rNMqpX6jan8aHcEZ1_Hjbk6uw6r3vKzhRiDPorQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Avoid segv if PMU lookup fails for
 legacy cache terms
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 12, 2023 at 12:27=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 11, 2023 at 11:52:50PM -0700, Ian Rogers escreveu:
> > libfuzzer found the following command could segv:
> > ```
> > $ perf stat -e cpu/L2,L2/ true
> > ```
> > This is because the L2 term rewrites the perf_event_attr type to
> > PERF_TYPE_HW_CACHE which then fails the PMU lookup for the second
> > legacy cache term.
> >
> > The new failure is consistent with repeated hardware terms:
> > ```
> > $ perf stat -e cpu/L2,L2/ true
> > event syntax error: 'cpu/L2,L2/'
> >                             \___ Failed to find PMU for type 3
> >
> > Initial error:
> > event syntax error: 'cpu/L2,L2/'
> >                             \___ Failed to find PMU for type 3
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list avail=
able events
> > $ perf stat -e cpu/cycles,cycles/ true
> > event syntax error: 'cpu/cycles,cycles/'
> >                                 \___ Failed to find PMU for type 0
> >
> > Initial error:
> > event syntax error: 'cpu/cycles,cycles/'
> >                                 \___ Failed to find PMU for type 0
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -e, --event <event>   event selector. use 'perf list' to list avail=
able events
> > ```
>
> I added the Fixes as requested:
>
> Fixes: 6fd1e5191591f9d5 ("perf parse-events: Support PMUs for legacy cach=
e events")
>
> Please check if the patch below helps a bit giving more info to the
> user, but still a bit cryptic:
>
> =E2=AC=A2[acme@toolbox perf-tools]$ perf stat -e cpu/L2,L2/ true
> event syntax error: 'cpu/L2,L2/'
>                             \___ Failed to find PMU for perf_event_attr.t=
ype 3 (PERF_TYPE_HW_CACHE)
>
> Initial error:
> event syntax error: 'cpu/L2,L2/'
>                             \___ Failed to find PMU for perf_event_attr.t=
ype 3 (PERF_TYPE_HW_CACHE)
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>     -e, --event <event>   event selector. use 'perf list' to list availab=
le events
> =E2=AC=A2[acme@toolbox perf-tools]$
>
> And the other case is needs more patching, so better leave this for 6.6.
>
>
> =E2=AC=A2[acme@toolbox perf-tools]$ perf stat -e cpu/cycles,cycles/ true
> event syntax error: 'cpu/cycles,cycles/'
>                                 \___ Failed to find PMU for type 0
>
> Initial error:
> event syntax error: 'cpu/cycles,cycles/'
>                                 \___ Failed to find PMU for type 0
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>     -e, --event <event>   event selector. use 'perf list' to list availab=
le events
> =E2=AC=A2[acme@toolbox perf-tools]$

The stringify looks good. Something strange is the value there is a
u64 by type is a __u32 in the perf_event_attr.

Thanks!
Ian

> - Arnaldo
>
> diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fpri=
ntf.h
> index c8a9fac2f2ddc0f2..044612774a962020 100644
> --- a/tools/perf/util/evsel_fprintf.h
> +++ b/tools/perf/util/evsel_fprintf.h
> @@ -4,6 +4,7 @@
>
>  #include <stdio.h>
>  #include <stdbool.h>
> +#include <linux/types.h>
>
>  struct evsel;
>
> @@ -45,6 +46,8 @@ int sample__fprintf_sym(struct perf_sample *sample, str=
uct addr_location *al,
>
>  typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void =
*);
>
> +const char *stringify_perf_type_id(u64 value);
> +
>  int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>                              attr__fprintf_f attr__fprintf, void *priv);
>  #endif // __PERF_EVSEL_H
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index acde097e327cce8c..8678469cf974070a 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -25,6 +25,7 @@
>  #include "asm/bug.h"
>  #include "util/parse-branch-options.h"
>  #include "util/evsel_config.h"
> +#include "util/evsel_fprintf.h"
>  #include "util/event.h"
>  #include "util/bpf-filter.h"
>  #include "util/util.h"
> @@ -1219,9 +1220,11 @@ static int config_term_pmu(struct perf_event_attr =
*attr,
>                 if (!pmu) {
>                         char *err_str;
>
> -                       if (asprintf(&err_str, "Failed to find PMU for ty=
pe %d", attr->type) >=3D 0)
> +                       if (asprintf(&err_str, "Failed to find PMU for pe=
rf_event_attr.type %d (%s)", attr->type,
> +                                    stringify_perf_type_id(attr->type)) =
>=3D 0) {
>                                 parse_events_error__handle(err, term->err=
_term,
>                                                            err_str, /*hel=
p=3D*/NULL);
> +                       }
>                         return -EINVAL;
>                 }
>                 if (perf_pmu__supports_legacy_cache(pmu)) {
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index 2247991451f3aa1b..ce97371eda027271 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -74,7 +74,7 @@ static void __p_read_format(char *buf, size_t size, u64=
 value)
>  }
>
>  #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
> -static const char *stringify_perf_type_id(u64 value)
> +const char *stringify_perf_type_id(u64 value)
>  {
>         switch (value) {
>         ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
