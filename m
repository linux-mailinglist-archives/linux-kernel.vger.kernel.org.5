Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5CD7DFD20
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbjKBXAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKBXAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:00:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218E199
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:00:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso585e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698966016; x=1699570816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey+0UZmqeDT35g7wTG4FnvGKbLWcaZI1zn+iqlGpZ+g=;
        b=gRawZkewNySGdGrRrcPdMuNVhxNRAjcgOlzkPhyhkmCN/vXyz9wLI9vj9+aEhaQYlX
         8ltAamGsxQSK3ySawEay16iNTcdQBfZu50c3a9MpOuTNYtvuLp4hENimqT4aamp5ByHK
         2sjjhZAd7EqAIQJC662Lnp1hLFFeBsmmoyhUUmmApZqTcI9IbDFYLs7AQLk/ROQpNEEW
         rTR3X6Nj+ntd/LWMIaSOR0icUEx4gEO8cbhzzJ+NtjnOeXupgIv8/sAE24MOxX+eMJZx
         emCenJ7O0BANrnmiYX90aMqZRa6M5tXkORnhW7dR0kNoXU+1R3fxKMFOFjgbAd6wauHX
         SaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698966016; x=1699570816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ey+0UZmqeDT35g7wTG4FnvGKbLWcaZI1zn+iqlGpZ+g=;
        b=ozTIbBBYXmCD+eezRXZGrvUWXxE/qofA7241xD7isshKbAH6pxXTAvsSoIHIBlAHj/
         E0l2Xario+b5zbECPbZ+HqxGyI/ev2qJNdYRFNmF1jmRnFRdvI/ug2WCxg8omqAmlerF
         AjvvYDfz6KG5UCxYbUqPIA3kWtASEQs2/C53QIUrUDXXesoVAIvq4q5pm1nJuRYOakRO
         MMxIiZYC1t665/oHGwENeoDksJiAueD9ef5d6OTu0hRb8AUKzD+bJcdDi9pGHhxzl5P8
         SVOsBNZEZUG/XIMmSsW0uAENbLuZ5DTufRVTD1JQXY//9Zo1/IAWXETMvhQ5u4PWOmK3
         nEYA==
X-Gm-Message-State: AOJu0YwmPubrYdSCRYArUg5TwAbB4cfa2f5OOIiGuF1fdUEIw45ITgVF
        gJ/O8b88OaULQzcfMptreTzUxQXL5TdMZygkImIgUg==
X-Google-Smtp-Source: AGHT+IFk9wIcw7DZ/GhEh4JDFTHO4gxx88PSv5XGz+bWg2wGg6tft3zCuo7mV5Op1vUb4W7kVUdxCiyWsUK+BdCtXQY=
X-Received: by 2002:a19:9153:0:b0:501:b029:1a47 with SMTP id
 y19-20020a199153000000b00501b0291a47mr73630lfj.1.1698966015632; Thu, 02 Nov
 2023 16:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-5-namhyung@kernel.org>
In-Reply-To: <20231102222653.4165959-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 16:00:03 -0700
Message-ID: <CAP-5=fURuJ9bgZngdJL0jbhWCJwq_==bAm1AxXHoagYz7D3srA@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf annotate: Move some fields to annotated_source
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

On Thu, Nov 2, 2023 at 3:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Some fields in the struct annotation are only used with annotated_source
> so better to be moved there in order to reduce memory consumption for
> other symbols.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/ui/browsers/annotate.c | 12 ++++++------
>  tools/perf/util/annotate.c        | 17 +++++++++--------
>  tools/perf/util/annotate.h        | 14 +++++++-------
>  3 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index d2470f87344d..1b42db70c998 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -384,7 +384,7 @@ static bool annotate_browser__toggle_source(struct an=
notate_browser *browser)
>                 if (al->idx_asm < offset)
>                         offset =3D al->idx;
>
> -               browser->b.nr_entries =3D notes->nr_entries;
> +               browser->b.nr_entries =3D notes->src->nr_entries;
>                 notes->options->hide_src_code =3D false;
>                 browser->b.seek(&browser->b, -offset, SEEK_CUR);
>                 browser->b.top_idx =3D al->idx - offset;
> @@ -402,7 +402,7 @@ static bool annotate_browser__toggle_source(struct an=
notate_browser *browser)
>                 if (al->idx_asm < offset)
>                         offset =3D al->idx_asm;
>
> -               browser->b.nr_entries =3D notes->nr_asm_entries;
> +               browser->b.nr_entries =3D notes->src->nr_asm_entries;
>                 notes->options->hide_src_code =3D true;
>                 browser->b.seek(&browser->b, -offset, SEEK_CUR);
>                 browser->b.top_idx =3D al->idx_asm - offset;
> @@ -435,7 +435,7 @@ static void ui_browser__init_asm_mode(struct ui_brows=
er *browser)
>  {
>         struct annotation *notes =3D browser__annotation(browser);
>         ui_browser__reset_index(browser);
> -       browser->nr_entries =3D notes->nr_asm_entries;
> +       browser->nr_entries =3D notes->src->nr_asm_entries;
>  }
>
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
> @@ -860,7 +860,7 @@ static int annotate_browser__run(struct annotate_brow=
ser *browser,
>                                            browser->b.height,
>                                            browser->b.index,
>                                            browser->b.top_idx,
> -                                          notes->nr_asm_entries);
> +                                          notes->src->nr_asm_entries);
>                 }
>                         continue;
>                 case K_ENTER:
> @@ -991,8 +991,8 @@ int symbol__tui_annotate(struct map_symbol *ms, struc=
t evsel *evsel,
>
>         ui_helpline__push("Press ESC to exit");
>
> -       browser.b.width =3D notes->max_line_len;
> -       browser.b.nr_entries =3D notes->nr_entries;
> +       browser.b.width =3D notes->src->max_line_len;
> +       browser.b.nr_entries =3D notes->src->nr_entries;
>         browser.b.entries =3D &notes->src->source,
>         browser.b.width +=3D 18; /* Percentage */
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 92a9adf9d5eb..ee7b8e1848a8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2808,19 +2808,20 @@ void annotation__mark_jump_targets(struct annotat=
ion *notes, struct symbol *sym)
>  void annotation__set_offsets(struct annotation *notes, s64 size)
>  {
>         struct annotation_line *al;
> +       struct annotated_source *src =3D notes->src;
>
> -       notes->max_line_len =3D 0;
> -       notes->nr_entries =3D 0;
> -       notes->nr_asm_entries =3D 0;
> +       src->max_line_len =3D 0;
> +       src->nr_entries =3D 0;
> +       src->nr_asm_entries =3D 0;
>
> -       list_for_each_entry(al, &notes->src->source, node) {
> +       list_for_each_entry(al, &src->source, node) {
>                 size_t line_len =3D strlen(al->line);
>
> -               if (notes->max_line_len < line_len)
> -                       notes->max_line_len =3D line_len;
> -               al->idx =3D notes->nr_entries++;
> +               if (src->max_line_len < line_len)
> +                       src->max_line_len =3D line_len;
> +               al->idx =3D src->nr_entries++;
>                 if (al->offset !=3D -1) {
> -                       al->idx_asm =3D notes->nr_asm_entries++;
> +                       al->idx_asm =3D src->nr_asm_entries++;
>                         /*
>                          * FIXME: short term bandaid to cope with assembl=
y
>                          * routines that comes with labels in the same co=
lumn
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index d8a221591926..c51ceb857bd6 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -268,10 +268,13 @@ struct cyc_hist {
>   * returns.
>   */
>  struct annotated_source {
> -       struct list_head   source;
> -       int                nr_histograms;
> -       size_t             sizeof_sym_hist;
> -       struct sym_hist    *histograms;
> +       struct list_head        source;
> +       int                     nr_histograms;
> +       size_t                  sizeof_sym_hist;
> +       struct sym_hist         *histograms;
> +       int                     nr_entries;
> +       int                     nr_asm_entries;
> +       u16                     max_line_len;
>  };
>
>  struct annotated_branch {
> @@ -289,9 +292,6 @@ struct LOCKABLE annotation {
>         struct annotation_line  **offsets;
>         int                     nr_events;
>         int                     max_jump_sources;
> -       int                     nr_entries;
> -       int                     nr_asm_entries;
> -       u16                     max_line_len;
>         struct {
>                 u8              addr;
>                 u8              jumps;
> --
> 2.42.0.869.gea05f2083d-goog
>
