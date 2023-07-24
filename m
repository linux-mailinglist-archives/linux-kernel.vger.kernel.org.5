Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E27600D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGXVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:02:00 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F911E70
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:01:59 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-440ad406bc8so1225591137.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690232518; x=1690837318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwEv6m7WdEj0WSS/WT/tsZ81hOCgU00T3UAZ9HdZAtM=;
        b=ZXJZqU++vguNApIwgPzo62X8jAfLDKCBIFCtO0mpcS9spwAkiHrJzjk3NqFkmjzfUJ
         00W5rK4Im2ZLUNSjWMonuSYFVPgD8zpl6ZQdlEvys7eXO3FIpf57vu1SQFRoHiQ1qC8/
         PnZlXRVgzntWJdt92inSsTgCxwbzn3SijHCpCqHJHrkAISuXS7tWqmyfiUDdgZ9fH17a
         Xu+A8LW0LEpsgVEfA3+ZXDrcitcAT9LYOM0ADJfrw4tSxp7RaNbqFUwsfrQ7XFNnnuBs
         z1dzEXCIAVkaEXj7JfwKwv521RnbBdchV5jPs7lA15JjkKx3v3d5BG0lhYYIhc1GlFAX
         77JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690232518; x=1690837318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwEv6m7WdEj0WSS/WT/tsZ81hOCgU00T3UAZ9HdZAtM=;
        b=TxvOpdxYRl2mx6gDbjCsww9J5cvq4Nair79I+r1tT5DlaEKwEGoD7VHdqoHMGdeHHA
         4p+KcuaWuqMpNtUGpiM2HhHzs0q8hOtzi52wyhYHFLyRiadZPss3HR9NS5Q8uiMJTPqx
         Q8OBINexmyee5u96h52KCjMjveE4QSfLnndluYaxpTYgwVgSWPXPJ0LbfTZp7ySmaLm1
         t6FMt1H72+RBSUKQd+SRJECndRkwXjRumvZidi63oNDYt9xWy6r+sJpv7/Yi9fQRQ9FG
         RMxhyii8w9plSryXR/G7BqhYSlRUpJXwzTv66AssD7AvitFGwsq8DVbJ/IAik9H0HS0C
         F/HA==
X-Gm-Message-State: ABy/qLZ/WKqoToskZd/2HgUHyVQ5KHRrcW9fpqDFnTSODBnCXv91kkEg
        Rk/0zOYEm/OrG2GJI6hbpacTkaXejylkEWtau2tl9w==
X-Google-Smtp-Source: APBJJlErB59jzrRIhB+T/J9RpOvQv83sc4JBVzJJ4GXRhV/iU5dwS7hKGJz9QozlSrr9AqlTgzi1XIEgW6D/7n8VTUk=
X-Received: by 2002:a67:ef84:0:b0:443:6392:71ea with SMTP id
 r4-20020a67ef84000000b00443639271eamr2866297vsp.34.1690232518329; Mon, 24 Jul
 2023 14:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com> <20230724201247.748146-3-irogers@google.com>
In-Reply-To: <20230724201247.748146-3-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 14:01:46 -0700
Message-ID: <CAKwvOdkkfkoOE7G__gJ1cQq5i2o4bauk7pqudb3vd2R7sneoYg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf parse-events: Avoid use uninitialized warning
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev, maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 1:13=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> With GCC LTO a potential use uninitialized is spotted:
> ```
> In function =E2=80=98parse_events_config_bpf=E2=80=99,
>     inlined from =E2=80=98parse_events_load_bpf=E2=80=99 at util/parse-ev=
ents.c:874:8:
> util/parse-events.c:792:37: error: =E2=80=98error_pos=E2=80=99 may be use=
d uninitialized [-Werror=3Dmaybe-uninitialized]
>   792 |                                 idx =3D term->err_term + error_po=
s;
>       |                                     ^
> util/parse-events.c: In function =E2=80=98parse_events_load_bpf=E2=80=99:
> util/parse-events.c:765:13: note: =E2=80=98error_pos=E2=80=99 was declare=
d here
>   765 |         int error_pos;
>       |             ^
> ```
> So initialize at declaration.

This common pattern in C is error prone (conditional assignment in the
callee; callers maybe forget to initialize, then unconditionally use
the value). Clang's static analyzer can spot these, but isn't run for
tools/ AFAIK.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index acde097e327c..da29061ecf49 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -762,7 +762,7 @@ parse_events_config_bpf(struct parse_events_state *pa=
rse_state,
>                         struct list_head *head_config)
>  {
>         struct parse_events_term *term;
> -       int error_pos;
> +       int error_pos =3D 0;
>
>         if (!head_config || list_empty(head_config))
>                 return 0;
> --
> 2.41.0.487.g6d72f3e995-goog
>


--=20
Thanks,
~Nick Desaulniers
