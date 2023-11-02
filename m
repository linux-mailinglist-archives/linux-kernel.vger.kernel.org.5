Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928C7DFD24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377565AbjKBXBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjKBXBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:01:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193FA193
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:01:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so14095e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698966059; x=1699570859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a/GtAxkpRNkq4Wv7MJVvEI6nRPwiDosiVmVdshmOnc=;
        b=ktDwKlH7HwLUbYAcJ4yuPUgk40Jpo6xHf+DpqGBHRZD67wXFN+sz7PyTRjBEDuQUQl
         lvC/94kRrn44ZJ2bHaRB6aPUZl5vtaAJOlkPl8i1C9KIJ5sU+LLTH2yKFdTowh69SiyM
         cfqRtwUT2EyqFY6ZcTE4LYvnrijktoE7T8X97JQsY9n3sGZZkjXOvvV93knqb7vKBqrg
         AxoqId6egHe1pSB0/c37TMxEDvIQpZSuURd6S38f//Ghs3qYhowjW8VePNK+MllAEofK
         NHZKA+fw1zdtWjj/uJydm70+tleVBDgjD82fl8QkrMVFWqH0BhTY9qRbzHVuJBmsC0mH
         D6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698966059; x=1699570859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5a/GtAxkpRNkq4Wv7MJVvEI6nRPwiDosiVmVdshmOnc=;
        b=Yk5bdjXoPyzScZhtSLWXuYfWwDZHpLmCPBTELJXWqL/bWwUB4866e1zcUywcZL6cAn
         01k59o5aborWV5tKczxxhtViinKEeZyNkwu2YIoah7CJYTUWL8sQiaDUx9moxROfKcsm
         Tu6ATNktOKkxjav6vcvdKReXNZC5GzMNeeWTS2WnBt6eVG/0htQzkvnzWTTEpAyoHX+Z
         VzQFk/vpHxcj8SvjEawNohyIuQe0QRzd70No3PuUC8dQjj93Ukc+DehnjMHyxdNjPUKa
         6bgYgr8eTrdo29WBwiYgRxbK8SEApIyXeQJidgjI7Aan6uVGo9vgk2PS5wZK6Z+cu4rc
         dpww==
X-Gm-Message-State: AOJu0YyQT858nmugpWrN/hdz20ULMTs620kkHiWXC1cKSk1edYBmr0Cr
        1F/EqtqqepnkC50oVZRFNmDj4GCNds88/hoJBvM9mQ==
X-Google-Smtp-Source: AGHT+IEXIuOBWHFSzhoMqHUnGKDi/rq+VfG5udY5nxPoxuaWx0asotg3PeW2O87+Hzn8PGhwnELjulSOC7/NY+uwmg4=
X-Received: by 2002:a05:600c:43c5:b0:405:35bf:7362 with SMTP id
 f5-20020a05600c43c500b0040535bf7362mr128127wmn.0.1698966059275; Thu, 02 Nov
 2023 16:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-6-namhyung@kernel.org>
In-Reply-To: <20231102222653.4165959-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 16:00:47 -0700
Message-ID: <CAP-5=fX_unZUBAjrVSM=4w5u9T0r_ewv1RC=xKgpWFhu919yXQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf annotate: Move offsets to annotated_source
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

On Thu, Nov 2, 2023 at 3:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The offsets array keeps pointers to struct annotation_line which is
> available in the annotated_source.  Let's move it to there.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/ui/browsers/annotate.c |  4 ++--
>  tools/perf/util/annotate.c        | 18 +++++++++---------
>  tools/perf/util/annotate.h        |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/a=
nnotate.c
> index 1b42db70c998..163f916fff68 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -188,7 +188,7 @@ static void annotate_browser__draw_current_jump(struc=
t ui_browser *browser)
>          *  name right after the '<' token and probably treating this lik=
e a
>          *  'call' instruction.
>          */
> -       target =3D notes->offsets[cursor->ops.target.offset];
> +       target =3D notes->src->offsets[cursor->ops.target.offset];
>         if (target =3D=3D NULL) {
>                 ui_helpline__printf("WARN: jump target inconsistency, pre=
ss 'o', notes->offsets[%#x] =3D NULL\n",
>                                     cursor->ops.target.offset);
> @@ -1006,6 +1006,6 @@ int symbol__tui_annotate(struct map_symbol *ms, str=
uct evsel *evsel,
>
>  out_free_offsets:
>         if(not_annotated)
> -               zfree(&notes->offsets);
> +               zfree(&notes->src->offsets);
>         return ret;
>  }
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ee7b8e1848a8..8ab2e1cf63ea 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1075,7 +1075,7 @@ static unsigned annotation__count_insn(struct annot=
ation *notes, u64 start, u64
>         u64 offset;
>
>         for (offset =3D start; offset <=3D end; offset++) {
> -               if (notes->offsets[offset])
> +               if (notes->src->offsets[offset])
>                         n_insn++;
>         }
>         return n_insn;
> @@ -1105,7 +1105,7 @@ static void annotation__count_and_fill(struct annot=
ation *notes, u64 start, u64
>                         return;
>
>                 for (offset =3D start; offset <=3D end; offset++) {
> -                       struct annotation_line *al =3D notes->offsets[off=
set];
> +                       struct annotation_line *al =3D notes->src->offset=
s[offset];
>
>                         if (al && al->cycles && al->cycles->ipc =3D=3D 0.=
0) {
>                                 al->cycles->ipc =3D ipc;
> @@ -1142,7 +1142,7 @@ void annotation__compute_ipc(struct annotation *not=
es, size_t size)
>                 if (ch && ch->cycles) {
>                         struct annotation_line *al;
>
> -                       al =3D notes->offsets[offset];
> +                       al =3D notes->src->offsets[offset];
>                         if (al && al->cycles =3D=3D NULL) {
>                                 al->cycles =3D zalloc(sizeof(*al->cycles)=
);
>                                 if (al->cycles =3D=3D NULL)
> @@ -2783,7 +2783,7 @@ void annotation__mark_jump_targets(struct annotatio=
n *notes, struct symbol *sym)
>                 return;
>
>         for (offset =3D 0; offset < size; ++offset) {
> -               struct annotation_line *al =3D notes->offsets[offset];
> +               struct annotation_line *al =3D notes->src->offsets[offset=
];
>                 struct disasm_line *dl;
>
>                 dl =3D disasm_line(al);
> @@ -2791,7 +2791,7 @@ void annotation__mark_jump_targets(struct annotatio=
n *notes, struct symbol *sym)
>                 if (!disasm_line__is_valid_local_jump(dl, sym))
>                         continue;
>
> -               al =3D notes->offsets[dl->ops.target.offset];
> +               al =3D notes->src->offsets[dl->ops.target.offset];
>
>                 /*
>                  * FIXME: Oops, no jump target? Buggy disassembler? Or do=
 we
> @@ -2830,7 +2830,7 @@ void annotation__set_offsets(struct annotation *not=
es, s64 size)
>                          * E.g. copy_user_generic_unrolled
>                          */
>                         if (al->offset < size)
> -                               notes->offsets[al->offset] =3D al;
> +                               notes->src->offsets[al->offset] =3D al;
>                 } else
>                         al->idx_asm =3D -1;
>         }
> @@ -3263,8 +3263,8 @@ int symbol__annotate2(struct map_symbol *ms, struct=
 evsel *evsel,
>         size_t size =3D symbol__size(sym);
>         int nr_pcnt =3D 1, err;
>
> -       notes->offsets =3D zalloc(size * sizeof(struct annotation_line *)=
);
> -       if (notes->offsets =3D=3D NULL)
> +       notes->src->offsets =3D zalloc(size * sizeof(struct annotation_li=
ne *));
> +       if (notes->src->offsets =3D=3D NULL)
>                 return ENOMEM;
>
>         if (evsel__is_group_event(evsel))
> @@ -3290,7 +3290,7 @@ int symbol__annotate2(struct map_symbol *ms, struct=
 evsel *evsel,
>         return 0;
>
>  out_free_offsets:
> -       zfree(&notes->offsets);
> +       zfree(&notes->src->offsets);
>         return err;
>  }
>
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index c51ceb857bd6..44af7e71a204 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -272,6 +272,7 @@ struct annotated_source {
>         int                     nr_histograms;
>         size_t                  sizeof_sym_hist;
>         struct sym_hist         *histograms;
> +       struct annotation_line  **offsets;
>         int                     nr_entries;
>         int                     nr_asm_entries;
>         u16                     max_line_len;
> @@ -289,7 +290,6 @@ struct annotated_branch {
>  struct LOCKABLE annotation {
>         u64                     start;
>         struct annotation_options *options;
> -       struct annotation_line  **offsets;
>         int                     nr_events;
>         int                     max_jump_sources;
>         struct {
> --
> 2.42.0.869.gea05f2083d-goog
>
