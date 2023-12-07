Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F35808E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjLGRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443194AbjLGRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:05:43 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150E210F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:05:50 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9d1962bbbso748785a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701968749; x=1702573549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/gQwCYDHPBBWnGreQGj5kMmktVS56VhncbMZUIjTkxA=;
        b=N/nxXtBZdALdkfa05rASSt+SKtNvnIxvZ9lp2fYxAANLa2BIwY3Uy5QkBvcimzBTjS
         2+ukcvhC6xj0NLeLo7Ae2/MiIiIVs8lttDZK3rTY7nTSwCXvAY0Oa9dWfuxgnhJgRUoN
         rPNpCOnFwDgw16ZpMxxQL3/8P93M3A+DgBuLAS7aKY7NTx7dgMBODbwkx9BRlQvEYoch
         l/vTd9SCrh/30LFxRA8KZo4vembEIafl63CEWfjKG+9X2Iyg2M/g8ONleNv39jtZ0N3+
         5q3wZtzRYEe/y/7DVLc3lt4r5IgrHTrWtyWU1s0otBK75Ckbl6Qtvdwktk00wBBBnSh+
         4p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968749; x=1702573549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gQwCYDHPBBWnGreQGj5kMmktVS56VhncbMZUIjTkxA=;
        b=Bqv0xNlSs0jDOt+J6xe01BSeb86Vnz/W7qR+A6mAP0vHYdkht6h466QF5owJt1FQEv
         Utxn3yaMzVlKUG6OxMAuZAn6jr5i3rj8ktlcHkAfd8CynVYNM1D+E2rrGhadgPttHFLt
         Z7PWEMov2cJUkygOKIGgedGRi+ClR9DE2HNnoXl8rjyNUftaiDKPf9yW3t3X8pvGhrHd
         z7jit9vA4C63FoimHlo8+tuWrixyzAlj9bQ+uHWvkEUZwWgk7ywgsCp2oB7wN5UnP0Bc
         OkOQWpRiVOT7B0DhtxqHiPCL1rvMSarV4iVuxc+jcKO94m2lXwbfFuer2O6d8A0RC24w
         5jyA==
X-Gm-Message-State: AOJu0YyjC4EaUAVscDVWy4OiNpFsMpHvO4GlL2Hp0DyXr/M338zBowZZ
        lv4lQGBHvPB27cZPm5HgL/EtyC4qDV/Grk6/AWkCLw==
X-Google-Smtp-Source: AGHT+IF4nJjAccTc+VF4SuAKFW4kIPR8iNtdeRIf4Ey84+2bpA53GJ5Bnp23SGyiRFLX1R/TpK0sBvk/IlcMGvxka3U=
X-Received: by 2002:a05:6358:5e14:b0:16d:f743:4107 with SMTP id
 q20-20020a0563585e1400b0016df7434107mr2967267rwn.3.1701968748863; Thu, 07 Dec
 2023 09:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-2-khuey@kylehuey.com>
In-Reply-To: <20231207163458.5554-2-khuey@kylehuey.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 Dec 2023 18:05:10 +0100
Message-ID: <CANpmjNNi1WoE0gsq5TSv8ys68YcF2o+LtWiDj+=bZ3Y46oP7Jw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf: Reorder overflow handler ahead of event_limit/sigtrap
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 7 Dec 2023 at 17:35, Kyle Huey <me@kylehuey.com> wrote:
>
> The perf subsystem already allows an overflow handler to clear pending_kill
> to suppress a fasync signal (although nobody currently does this). Allow an
> overflow handler to suppress the other visible side effects of an overflow,
> namely event_limit accounting and SIGTRAP generation.
>
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> ---
>  kernel/events/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b704d83a28b2..19fddfc27a4a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9541,6 +9541,12 @@ static int __perf_event_overflow(struct perf_event *event,
>          */
>
>         event->pending_kill = POLL_IN;
> +
> +       READ_ONCE(event->overflow_handler)(event, data, regs);
> +
> +       if (!event->pending_kill)
> +               return ret;

It's not at all intuitive that resetting pending_kill to 0 will
suppress everything else, too. There is no relationship between the
fasync signals and SIGTRAP. pending_kill is for the former and
pending_sigtrap is for the latter. One should not affect the other.

A nicer solution would be to properly undo the various pending_*
states (in the case of pending_sigtrap being set it should be enough
to reset pending_sigtrap to 0, and also decrement
event->ctx->nr_pending).

Although I can see why this solution is simpler. Perhaps with enough
comments it might be clearer.

Preferences?
