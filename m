Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2F7BB122
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjJFFQz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 01:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:16:54 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433EB6;
        Thu,  5 Oct 2023 22:16:53 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-27777174297so1243249a91.3;
        Thu, 05 Oct 2023 22:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696569413; x=1697174213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvOcOTq7EGq7pb4ud31/t54x6a89DswpBEw1W3QbZUs=;
        b=hZbFruqRHnSWW7gPkGnhbmT44HqSGq3QEou8dlb8Bjd+8n2KBtfyJP/3hTmNU8mTQz
         +E1191c0anUm3nah1o8LQeajdOlFjnWC1NnzU4dJEJUE+8flDzwEAHaQczo0dfjIaSDB
         4q3oOwRZF0v//YSo2VaedaiUNXGeUucRMwgsdwBoMLBdhlhUKF2z1SwrhxtSEpOu8xWn
         pbwlgxHU6LI3S8B+KW3+FFlD8Kclw47B+pEz0UmrA4RvmenKgk5rbshZm1D81TDtdtZQ
         x/i5DrkzcQ95gVktVW1e5/GTxKtJCfjwWAsm9byrABnY6UU1KevUyxmeiUI60jb0E2sB
         eGFA==
X-Gm-Message-State: AOJu0YznQpWx5k/s3XWDtL1zi8lgwsVS/AtUGaFF1eXTOolqyvbA6B5e
        yN2SvGOYXFWcKR/D/H49qKPO31RzHXld4dM0SeE=
X-Google-Smtp-Source: AGHT+IEK6gO0T+4a8ZQyLrPLlrfk6DrilTZFAjOwG3Fw7YTYyoFMJuqaVen5V45YspNz65z9glpUA8IHi+QxR7ll5Kg=
X-Received: by 2002:a17:90b:1a8c:b0:274:bf7a:60ed with SMTP id
 ng12-20020a17090b1a8c00b00274bf7a60edmr7425081pjb.12.1696569412716; Thu, 05
 Oct 2023 22:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZR66Qgbcltt+zG7F@kernel.org>
In-Reply-To: <ZR66Qgbcltt+zG7F@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 5 Oct 2023 22:16:40 -0700
Message-ID: <CAM9d7cgnB0jLTz+PNiJgkJL_LU5Y6oQX9HALJEGqh3v_ngPzxQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf symbols: Add 'intel_idle_ibrs' to the list of
 idle symbols
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Oct 5, 2023 at 6:29 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> This is a longstanding to do list entry: we need a way to see that a
> sample took place while in idle state, as the current way to do it is
> to infer that by the name of the functions that in such state have
> more samples, IOW: a hack.
>
> Maybe we can do flip a bit in samples that take place inside the
> enter/exit idle section in do_idle()?
>
> But till then, add one more :-\
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> cc: Frédéric Weisbecker <fweisbec@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>,
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/symbol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5b54d2639df4740e..3c7f483bf85bbdaf 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -718,6 +718,7 @@ static bool symbol__is_idle(const char *name)
>                 "cpu_startup_entry",
>                 "idle_cpu",
>                 "intel_idle",
> +               "intel_idle_ibrs",
>                 "default_idle",
>                 "native_safe_halt",
>                 "enter_idle",
> --
> 2.41.0
>
