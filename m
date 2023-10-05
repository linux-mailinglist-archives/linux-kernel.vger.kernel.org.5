Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B37BAEAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjJEWNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJEWNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:13:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103389E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:13:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502f29ed596so2288e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696544029; x=1697148829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b693Y1Dasdqb+Bvft8PNzQSfqB0Z0L3RovrSOC+5XI=;
        b=sCLwAeaz0t9ZjGeS6R9zkR2xjglgBaa07fBOA3jdnfyFwNwfMs9N3rp8DTF0+3ITwe
         tP8W3cwBEW2vY95SCt6k5nkC+5mEkN+yGLuokbLLNbqxvyk+fTo81/bCePqTZ1Dgvof0
         AbJm7Lc98b7upM8f7FCp4SXHlGEk00bHJe5lUcpMUtw7jEZ1doUgWKz9u/6RHnIJrFze
         b5ApZ1zBWVD3OHw8J2x/WB2LiUm2bPCa4wpvlAa/WZsBxWvRkrBAyLNmcBao6w5eNmo0
         pNhFvLehK9Qfqsid+9ApsLKr89jASI4BBI781BqZzLfzoEACtdMQq4G0/bFPo3Z+xRVT
         bBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544029; x=1697148829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b693Y1Dasdqb+Bvft8PNzQSfqB0Z0L3RovrSOC+5XI=;
        b=dfbcbla83Nz56NZMzoY9QZPlz9fxpQEqcg8aKpeMlo3x2XA5nBfWxGPGPKQ5eYXsGG
         JfqQvCqmlZs/2O58cxIelmpboidn5B6hqxmFImpsPq0tDNI+Pj/+ByCxSoxtnFnvSsoK
         Yelp0k49OPnVV5rWSs4GVYNn/YEEMQ4Xh3/bQgSTqJlL15rGleuWMepFXqYEYb0PpsTg
         my5aHtlj89ojaqbJJhvkw6KKHF/knffrSW6CYdkmvsq+CJWJ4Lygn03gCTIBuOOpufPA
         YAuTTPLILDQhVsIzOINBgZSFXt/jb0QYNuSWLiPEpL2bUbSZ7r9xIWKncrRaCzPz79y8
         zqeA==
X-Gm-Message-State: AOJu0YxR1RbMjwtW0iaybrc8lCi2CbRS5uBpCYlEugE66o7YFY0TUjBA
        sdZcN9NBuJIiGZA0CG5iBNJPnqN7k+O77syqOyNQSQ==
X-Google-Smtp-Source: AGHT+IG8HhLz8amGBqIHMMBtl0b/29dYhbEuhdIISKcNvI4MG0ZYoDVF8mHIW7OiuKwFk+16uSpRmWRSqtNc5nTXsEI=
X-Received: by 2002:ac2:59c2:0:b0:501:b029:1a47 with SMTP id
 x2-20020ac259c2000000b00501b0291a47mr84104lfn.1.1696544029164; Thu, 05 Oct
 2023 15:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230928004431.1926969-1-irogers@google.com>
In-Reply-To: <20230928004431.1926969-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Oct 2023 15:13:37 -0700
Message-ID: <CAP-5=fW6dBQQ7XnDm+Ye7R2bksNrWWwZJ+X33QnDvcjqjgtU5Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Fix for term values that are raw events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, Sep 27, 2023 at 5:44=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Raw events can be strings like 'r0xead' but the 0x is optional so they
> can also be 'read'. On IcelakeX uncore_imc_free_running has an event
> called 'read' which may be programmed as:
> ```
> $ perf stat -e 'uncore_imc_free_running/event=3Dread/' -a sleep 1
> ```
> However, the PE_RAW type isn't allowed on the right of a term, even
> though in this case we just want to interpret it as a string. This
> leads to the following error on IcelakeX:
> ```
> $ perf stat -e 'uncore_imc_free_running/event=3Dread/' -a sleep 1
> event syntax error: '..nning/event=3Dread/'
>                                   \___ parser error
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>     -e, --event <event> event selector. use 'perf list' to list available=
 events
> ```
> Fix this by allowing raw types on the right of terms and treat them as
> strings, just as is already done for PE_LEGACY_CACHE. Make this
> consistent by just entirely removing name_or_legacy and always using
> name_or_raw that covers all three cases.
>
> Fixes: 6fd1e5191591 ("perf parse-events: Support PMUs for legacy cache ev=
ents")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. As this is affecting IcelakeX, Kan?

Thanks,
Ian

> ---
>  tools/perf/util/parse-events.y | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index 4d9f3922a33d..de098caf0c1c 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -78,7 +78,7 @@ static void free_list_evsel(struct list_head* list_evse=
l)
>  %type <str> PE_MODIFIER_BP
>  %type <str> PE_EVENT_NAME
>  %type <str> PE_DRV_CFG_TERM
> -%type <str> name_or_raw name_or_legacy
> +%type <str> name_or_raw
>  %destructor { free ($$); } <str>
>  %type <term> event_term
>  %destructor { parse_events_term__delete ($$); } <term>
> @@ -669,8 +669,6 @@ event_term
>
>  name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
>
> -name_or_legacy: PE_NAME | PE_LEGACY_CACHE
> -
>  event_term:
>  PE_RAW
>  {
> @@ -685,7 +683,7 @@ PE_RAW
>         $$ =3D term;
>  }
>  |
> -name_or_raw '=3D' name_or_legacy
> +name_or_raw '=3D' name_or_raw
>  {
>         struct parse_events_term *term;
>         int err =3D parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE=
_USER, $1, $3, &@1, &@3);
> @@ -765,7 +763,7 @@ PE_TERM_HW
>         $$ =3D term;
>  }
>  |
> -PE_TERM '=3D' name_or_legacy
> +PE_TERM '=3D' name_or_raw
>  {
>         struct parse_events_term *term;
>         int err =3D parse_events_term__str(&term, $1, /*config=3D*/NULL, =
$3, &@1, &@3);
> --
> 2.42.0.515.g380fc7ccd1-goog
>
