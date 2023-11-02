Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D537DFCA6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377534AbjKBWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKBWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:53:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80853184
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:53:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso36835e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965591; x=1699570391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74mPwWD5M0b2kFU0MdNGIOkGXTx63ZGOAD5crEqHXGw=;
        b=1aANjZqiJIU7SZl+PaEixZ1MaPwEgDedmsAee8vp6G7//h26IEW26OZes0aUBb8jrk
         SBhdIJ2UjNBuCqIz2wYlrFB4OAR3Hc19k1I3zwv5PnCAk/8kJMpqwI8TXw6GcjB/pvTH
         Qz6qT1NKT7D10ZXZfouFnAwFyy7hXFVm6s/mnavPYyYgyf24Z07FenzuL1ZX+EKzPjzQ
         yIYanjlIhwbVBXaE3iakzoOtJmbvSczW4TG6XasMqMbeLvB/TEYjOZc2svNAdakFP8SQ
         X8+JLSKjd6jfVdAvKjZFiyWw701eq/rQ7LvD271YpqgXABudQRBc3ffVgZbATOpnAYdp
         h+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965591; x=1699570391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74mPwWD5M0b2kFU0MdNGIOkGXTx63ZGOAD5crEqHXGw=;
        b=uPXMQuHG3TgZ4Auc8KDgsgiz3/ZpZnQpHpMd8SqJQ37WtmPUKUJ01YXp+xR1h0gakU
         RxrCTCtIPY6n5MtJX6UTRPaJcHEsuMwSWQ/LozF85G3rR3W/O38ZXK393N6WL0XOUAJm
         02t/XE6szuGkTLKS/P3a1WK7Ip/6GrKLDndIeYCctmkNtSzJqNzykaxYmC0uwkT9XNHV
         AyPbot5ChMlCjM6LTsBGH0svaf2aIRpdgZdiLA4fOFmnCQcEixE9h4p+eyRYFKztAYNk
         TJRwyIbAMoAfFkvNwv6P2MXc3QAaTH0AW5XSuKxYcQE/7tLTWtosyjWvAgMG3NTpZ0j5
         LzSw==
X-Gm-Message-State: AOJu0YyvYeUDzMDl94yqq1T7SOz+TnXA06vJW3+6wv3i6HAtdEbMwYgz
        gb38D+iaAzLl7uOG9y7LeUVFGDnOotUHRTCd08etDg==
X-Google-Smtp-Source: AGHT+IHw5LIGPGt8HwqAJJO3XVCBDAKbPOAYhmS2RlNB7RAyuX/WNObiSkvk+Xj5TqGKCLhzRVcqq7ql4prXxfVvmDc=
X-Received: by 2002:a05:600c:1d14:b0:3f7:3e85:36a with SMTP id
 l20-20020a05600c1d1400b003f73e85036amr111817wms.7.1698965590459; Thu, 02 Nov
 2023 15:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-2-namhyung@kernel.org>
In-Reply-To: <20231102222653.4165959-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 15:52:58 -0700
Message-ID: <CAP-5=fV=huOH7_8ba_xRT5V4RZUZ0O54OkHcRRHzuSPH_SemCA@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf annotate: Split struct cycles_info
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 3:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The cycles info is used only when branch stack is provided.  Split them
> into a separate struct and lazy allocate them to save some memory.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c |  2 +-
>  tools/perf/util/annotate.c        | 34 ++++++++++++++++++-------------
>  tools/perf/util/annotate.h        | 14 ++++++++-----
>  3 files changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index ccdb2cd11fbf..d2470f87344d 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -337,7 +337,7 @@ static void annotate_browser__calc_percent(struct ann=
otate_browser *browser,
>                                 max_percent =3D percent;
>                 }
>
> -               if (max_percent < 0.01 && pos->al.ipc =3D=3D 0) {
> +               if (max_percent < 0.01 && (!pos->al.cycles || pos->al.cyc=
les->ipc =3D=3D 0)) {
>                         RB_CLEAR_NODE(&pos->al.rb_node);
>                         continue;
>                 }
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 82956adf9963..3e7f75827270 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1100,8 +1100,8 @@ static void annotation__count_and_fill(struct annot=
ation *notes, u64 start, u64
>                 for (offset =3D start; offset <=3D end; offset++) {
>                         struct annotation_line *al =3D notes->offsets[off=
set];
>
> -                       if (al && al->ipc =3D=3D 0.0) {
> -                               al->ipc =3D ipc;
> +                       if (al && al->cycles && al->cycles->ipc =3D=3D 0.=
0) {
> +                               al->cycles->ipc =3D ipc;
>                                 cover_insn++;
>                         }
>                 }
> @@ -1134,13 +1134,18 @@ void annotation__compute_ipc(struct annotation *n=
otes, size_t size)
>                 if (ch && ch->cycles) {
>                         struct annotation_line *al;
>
> +                       al =3D notes->offsets[offset];
> +                       if (al && al->cycles =3D=3D NULL) {
> +                               al->cycles =3D zalloc(sizeof(*al->cycles)=
);
> +                               if (al->cycles =3D=3D NULL)
> +                                       continue;
> +                       }
>                         if (ch->have_start)
>                                 annotation__count_and_fill(notes, ch->sta=
rt, offset, ch);
> -                       al =3D notes->offsets[offset];
>                         if (al && ch->num_aggr) {
> -                               al->cycles =3D ch->cycles_aggr / ch->num_=
aggr;
> -                               al->cycles_max =3D ch->cycles_max;
> -                               al->cycles_min =3D ch->cycles_min;

Thanks for doing this! Would it make sense to do the zalloc here to be
lazier about allocation?

Ian

> +                               al->cycles->avg =3D ch->cycles_aggr / ch-=
>num_aggr;
> +                               al->cycles->max =3D ch->cycles_max;
> +                               al->cycles->min =3D ch->cycles_min;
>                         }
>                         notes->have_cycles =3D true;
>                 }
> @@ -1225,6 +1230,7 @@ static void annotation_line__exit(struct annotation=
_line *al)
>  {
>         zfree_srcline(&al->path);
>         zfree(&al->line);
> +       zfree(&al->cycles);
>  }
>
>  static size_t disasm_line_size(int nr)
> @@ -3083,8 +3089,8 @@ static void __annotation_line__write(struct annotat=
ion_line *al, struct annotati
>         int printed;
>
>         if (first_line && (al->offset =3D=3D -1 || percent_max =3D=3D 0.0=
)) {
> -               if (notes->have_cycles) {
> -                       if (al->ipc =3D=3D 0.0 && al->cycles =3D=3D 0)
> +               if (notes->have_cycles && al->cycles) {
> +                       if (al->cycles->ipc =3D=3D 0.0 && al->cycles->avg=
 =3D=3D 0)
>                                 show_title =3D true;
>                 } else
>                         show_title =3D true;
> @@ -3121,17 +3127,17 @@ static void __annotation_line__write(struct annot=
ation_line *al, struct annotati
>         }
>
>         if (notes->have_cycles) {
> -               if (al->ipc)
> -                       obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH =
- 1, al->ipc);
> +               if (al->cycles && al->cycles->ipc)
> +                       obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH =
- 1, al->cycles->ipc);
>                 else if (!show_title)
>                         obj__printf(obj, "%*s", ANNOTATION__IPC_WIDTH, " =
");
>                 else
>                         obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - =
1, "IPC");
>
>                 if (!notes->options->show_minmax_cycle) {
> -                       if (al->cycles)
> +                       if (al->cycles && al->cycles->avg)
>                                 obj__printf(obj, "%*" PRIu64 " ",
> -                                          ANNOTATION__CYCLES_WIDTH - 1, =
al->cycles);
> +                                          ANNOTATION__CYCLES_WIDTH - 1, =
al->cycles->avg);
>                         else if (!show_title)
>                                 obj__printf(obj, "%*s",
>                                             ANNOTATION__CYCLES_WIDTH, " "=
);
> @@ -3145,8 +3151,8 @@ static void __annotation_line__write(struct annotat=
ion_line *al, struct annotati
>
>                                 scnprintf(str, sizeof(str),
>                                         "%" PRIu64 "(%" PRIu64 "/%" PRIu6=
4 ")",
> -                                       al->cycles, al->cycles_min,
> -                                       al->cycles_max);
> +                                       al->cycles->avg, al->cycles->min,
> +                                       al->cycles->max);
>
>                                 obj__printf(obj, "%*s ",
>                                             ANNOTATION__MINMAX_CYCLES_WID=
TH - 1,
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 962780559176..16d27952fd5c 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -130,6 +130,13 @@ struct annotation_data {
>         struct sym_hist_entry    he;
>  };
>
> +struct cycles_info {
> +       float                    ipc;
> +       u64                      avg;
> +       u64                      max;
> +       u64                      min;
> +};
> +
>  struct annotation_line {
>         struct list_head         node;
>         struct rb_node           rb_node;
> @@ -137,12 +144,9 @@ struct annotation_line {
>         char                    *line;
>         int                      line_nr;
>         char                    *fileloc;
> -       int                      jump_sources;
> -       float                    ipc;
> -       u64                      cycles;
> -       u64                      cycles_max;
> -       u64                      cycles_min;
>         char                    *path;
> +       struct cycles_info      *cycles;
> +       int                      jump_sources;
>         u32                      idx;
>         int                      idx_asm;
>         int                      data_nr;
> --
> 2.42.0.869.gea05f2083d-goog
>
