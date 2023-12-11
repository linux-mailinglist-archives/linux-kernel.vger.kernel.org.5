Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C980DAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbjLKTjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:39:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A840D0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:39:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1895a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702323554; x=1702928354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPV7uaNearP8zA9kFBJU663Ft/w8jrukP3TLLhPBA30=;
        b=3cmCFq8FmHqgF+WuC7o5gZO9EJYKFAGWCFRD30llvKwDtZdrxjf6In9tblQoRp6cPe
         Lx9/WoS9PEG4vJqttQCkrXorppqXu0ivUbsGxvqYVzrjrIHDu8XNcpR6hBoDi+toal50
         FEKyQXZStWJUJjZFmSa3Rn11NvpItkAHNWqtHMxHLaU4nQPi0ewQkNYgEpAhX/fI+kRM
         lEq7d0mcfDxk2uxbmiBCbm81X4O+7QP4oh0JYzTfRAn3eo6RzyKvRLJyZQraZWLI4Ije
         BXCyUNGxHxcfaZP2pF8y5KvOW4MHoY/KnrvanIp8jrMQDd2uL+rgja0kAJDGDppNsOMe
         KpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323554; x=1702928354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPV7uaNearP8zA9kFBJU663Ft/w8jrukP3TLLhPBA30=;
        b=mp4LZBiYQwSKwm89zHwmaWPOIzq9SnDZNdb1IkaDfLVrz+b7ljjxshbSpKCbgY7u0G
         upG43i1LpElJwhBy9t/1UYDM9euZN1p4Mu+QpI+/x4Qx7NwqgiyVFPcTCIiltj6T6rB6
         gdb4JkVO3vWPzua5nL/lU6SxtXskHe0MJnF3k7lFeQluVPgLhj2zzRxLgD9d9eYuOiTg
         ri69hl2z2Jy+60r7K725LGrP3lWMq1tCUDk2ibkZ1L+RiafVu5YpfQZ3J9srRA+ji0zR
         F9ZsDOXJ5duChLaFJX6CN8KUVFNQRx+NkZBeHtLPN7RGLw6AHXA4Pr6BrjTKh9gahi3p
         TAOw==
X-Gm-Message-State: AOJu0YyUhQv3glJJQu6FMs+ergSk2stx7J1Ca5wVnvz8MpqRLlJYdXQ+
        zadILC3kVmqYjyQyvqWr80+MXUxTc81sTPVKNnyixw==
X-Google-Smtp-Source: AGHT+IFWyamAY0Cu76Wft3lhUxLjx5elTdoJdS0w8kWDI8gqkyOHd+DLn77UDcxpDlIqEXRNnBp8BckkP2sDSGEDCIU=
X-Received: by 2002:a50:f618:0:b0:54b:8f42:e3dc with SMTP id
 c24-20020a50f618000000b0054b8f42e3dcmr278764edn.2.1702323553565; Mon, 11 Dec
 2023 11:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20231129223540.2247030-1-irogers@google.com>
In-Reply-To: <20231129223540.2247030-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Dec 2023 11:39:02 -0800
Message-ID: <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix help message for --metric-no-threshold option
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

On Wed, Nov 29, 2023 at 2:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Copy-paste error led to help message for metric-no-threshold repeating
> that of metric-no-merge.
>
> Reported-by: Stephane Eranian <eranian@google.com>
> Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a3af805a1d57..c77a3308d3fb 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1255,7 +1255,7 @@ static struct option stat_options[] =3D {
>         OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
>                        "don't try to share events between metrics in a gr=
oup"),
>         OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_thre=
shold,
> -                      "don't try to share events between metrics in a gr=
oup  "),
> +                      "disable adding events for the metric threshold ca=
lculation"),
>         OPT_BOOLEAN(0, "topdown", &topdown_run,
>                         "measure top-down statistics"),
>         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
