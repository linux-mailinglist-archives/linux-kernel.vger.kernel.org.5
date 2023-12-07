Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6746B80926C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjLGUfE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjLGUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:34:36 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E11BDA;
        Thu,  7 Dec 2023 12:34:34 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1104523a12.2;
        Thu, 07 Dec 2023 12:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981273; x=1702586073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eK7GmkC+MOlgnAqTreiUYrmfw87lLVr1vlz5i4mdHs=;
        b=TeP2gVpD4syeKBQ21b4/nUP3tT/OhylW2otHS7NNKwOIZeDrBBFixQXAsUwjy2zZlS
         tazf/rDlUi96RcjnUNnfaC1LsTPA/0AD+ttA/Jdyd5Auf7u11HL385My4hQvMowNh1Ns
         ItHLYLP51UZ/qeTD9I77djlZtBbogPpvFX1Wf/QqTUSTWdbzPUBnkyI6une3/CkMf+0K
         SRFXKtOuUnY9urGpQTD5/eQYfNK1NasRs5eEiYS3xYkJh70CUUd03UUDmfvXjq71dOa2
         xvpth4dQK9+FJbGHqtGHfcxoMZ302U94s1t5SleytAGNbdjJGQzaEqjFIIVek3sAe446
         Wz8w==
X-Gm-Message-State: AOJu0YwDUWbKRmxjxpQvYw0k6oxffhsBBvhXsi/tAtxZayvvCKGb6uZL
        k7SEDfI/rBNHIa+ko4Iqcu6kRrV5gRvkhEEBpHg=
X-Google-Smtp-Source: AGHT+IHmEL8krtJsjXUO7c7ScOqGojZcZI20DcGgMy7M3cpewmpq6sVH0ytC82O5lueQ2qt9BVL7nQ3jHALMxQoXWRw=
X-Received: by 2002:a05:6a20:4ba9:b0:18f:97c:8a50 with SMTP id
 fu41-20020a056a204ba900b0018f097c8a50mr2705672pzb.123.1701981273120; Thu, 07
 Dec 2023 12:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <20231128175441.721579-5-namhyung@kernel.org>
 <ZXIoRDWBPEjUpYuP@kernel.org>
In-Reply-To: <ZXIoRDWBPEjUpYuP@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 7 Dec 2023 12:34:21 -0800
Message-ID: <CAM9d7ch6BRTYoES2atnM8G_qpS6B6Z-oVWD04ZHBBOB9ND11zw@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf annotate: Use global annotation_options
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 12:17 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Nov 28, 2023 at 09:54:37AM -0800, Namhyung Kim escreveu:
> > Now it can directly use the global options and no need to pass it as an
> > argument.
>
> At this point the build breaks when using GTK2=1 on the make command
> line, as done in 'make -C tools/perf build-test', so I had to add the
> following patch on top of this 4/8 patch:

Oops, I forgot to test with it.  Thanks for fixing this!

Thanks,
Namhyung

>
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index a53a4e711899f20d..9c1e2b2b5bc0b730 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -365,7 +365,6 @@ static void hists__find_annotations(struct hists *hists,
>                         int ret;
>                         int (*annotate)(struct hist_entry *he,
>                                         struct evsel *evsel,
> -                                       struct annotation_options *options,
>                                         struct hist_browser_timer *hbt);
>
>                         annotate = dlsym(perf_gtk_handle,
> @@ -375,7 +374,7 @@ static void hists__find_annotations(struct hists *hists,
>                                 return;
>                         }
>
> -                       ret = annotate(he, evsel, &annotate_opts, NULL);
> +                       ret = annotate(he, evsel, NULL);
>                         if (!ret || !ann->skip_missing)
>                                 return;
>
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 2effac77ca8c6742..394861245fd3e48f 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -162,7 +162,6 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
>  }
>
>  static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
> -                               struct annotation_options *options,
>                                 struct hist_browser_timer *hbt)
>  {
>         struct dso *dso = map__dso(ms->map);
> @@ -176,7 +175,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
>         if (dso->annotate_warned)
>                 return -1;
>
> -       err = symbol__annotate(ms, evsel, options, NULL);
> +       err = symbol__annotate(ms, evsel, NULL);
>         if (err) {
>                 char msg[BUFSIZ];
>                 dso->annotate_warned = true;
> @@ -244,10 +243,9 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
>
>  int hist_entry__gtk_annotate(struct hist_entry *he,
>                              struct evsel *evsel,
> -                            struct annotation_options *options,
>                              struct hist_browser_timer *hbt)
>  {
> -       return symbol__gtk_annotate(&he->ms, evsel, options, hbt);
> +       return symbol__gtk_annotate(&he->ms, evsel, hbt);
>  }
>
>  void perf_gtk__show_annotations(void)
> diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
> index 1e84dceb52671385..a2b497f03fd6e478 100644
> --- a/tools/perf/ui/gtk/gtk.h
> +++ b/tools/perf/ui/gtk/gtk.h
> @@ -56,13 +56,11 @@ struct evsel;
>  struct evlist;
>  struct hist_entry;
>  struct hist_browser_timer;
> -struct annotation_options;
>
>  int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
>                              struct hist_browser_timer *hbt, float min_pcnt);
>  int hist_entry__gtk_annotate(struct hist_entry *he,
>                              struct evsel *evsel,
> -                            struct annotation_options *options,
>                              struct hist_browser_timer *hbt);
>  void perf_gtk__show_annotations(void);
>
