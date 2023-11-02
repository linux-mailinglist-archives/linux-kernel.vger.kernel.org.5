Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA07E7DFCB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377550AbjKBW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377541AbjKBW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:58:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069E133
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:58:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5701a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965904; x=1699570704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrMi2pda8iI+1qoWu6hsdaBgRBrAzn7qmnoDmrGGZAY=;
        b=oB/3S/12rOiK31eNza5po3o8y9G23H/O16q/Zg2IYJeSADecbGG8ro7OPB0r6y9BLZ
         i+ddBRsWoXXfCZg1aCyBoCI9nZHsdeHxKO5te8GlFZE11ib98RT4Vaxtj17WwM8TeTI0
         xdyDA5+ETA0lFkSVt0oDJ58c24i2yO2qetlCZsUuub3OIFx8LGC0v2CRRZu+pzJi99No
         E9kCFWEEt9SY0/PB+ZKsJGmDI6DINmhZGs49VYQrSs8xFEKhQqISXacw2e8lN9qNBKD5
         AXNKvXEhGamd682fTyGdy+jD94IojYvQyGioNINxGMqj0ctssmsJe7um5exG7wjq4jEE
         CChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965904; x=1699570704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrMi2pda8iI+1qoWu6hsdaBgRBrAzn7qmnoDmrGGZAY=;
        b=TwHcMhSZEqZc+Kk5J9LdcD/AEZoBCVd7UmRQoRA6m9HNg6fsiPwaik08Nz+MkNmtwF
         0/kR7PZc3xD7cG4qbrZap4tBTxMzPc/D+YXWDKdmP/ydkUSw6FMpbtKjmhypUPALhVCt
         ER+i3DULiWLMjqhc6yBju8DVz+sSXlVIze7ZH6AVnkWlbVmUFlvs76VtpUo3LbNyx4Hf
         M8bd1ZBbQFTNNlE2JXPlnnzc0dMAAJccVjQlMfLN6bLvNBHsZJOdlindiG/oG/rS2EFp
         feGxZitpmfzc9d2yVxEetSKKDa3f0d8R6Ag1MgFsapn9/FSkuzs32S9mTctAkXna3TLJ
         /A+Q==
X-Gm-Message-State: AOJu0YxNU30BUaP9wWLXSUDdOxPAQKfqxerm3TowvOpy3swJpfYvRBhW
        rATurmuypRI/r/bpyI2tYrxUcac8Z/Uv7B6c0qPE3A==
X-Google-Smtp-Source: AGHT+IG0BArASdMJbMUbpoe2gYKor1U6iQ7UkM4Smk/41kVT0VTqFoWNCGF9VfCVbvz6ETbil/91GNroRgubCI0rb8g=
X-Received: by 2002:a50:cd8d:0:b0:543:7d1b:a103 with SMTP id
 p13-20020a50cd8d000000b005437d1ba103mr137718edi.2.1698965903371; Thu, 02 Nov
 2023 15:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-3-namhyung@kernel.org>
In-Reply-To: <20231102222653.4165959-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 15:58:11 -0700
Message-ID: <CAP-5=fXOZK6Ym=EwidvcWtVdEe65iyiK9Fe7XxLW=+SSQu-kSA@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf annotate: Split struct annotated_branch
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

On Thu, Nov 2, 2023 at 3:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The cycles info is only meaninful when sample has branch stacks.  To

nit: meaningful

> save the memory for normal cases, move those fields to annotated_branch
> and dynamically allocate it when needed.  Also move cycles_hist from
> annotated_source as it's related here.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c   | 97 ++++++++++++++++++++----------------
>  tools/perf/util/annotate.h   | 17 ++++---
>  tools/perf/util/block-info.c |  4 +-
>  tools/perf/util/sort.c       | 14 +++---
>  4 files changed, 72 insertions(+), 60 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 3e7f75827270..2fa1ce3a0858 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -810,7 +810,6 @@ static __maybe_unused void annotated_source__delete(s=
truct annotated_source *src
>         if (src =3D=3D NULL)
>                 return;
>         zfree(&src->histograms);
> -       zfree(&src->cycles_hist);
>         free(src);
>  }
>
> @@ -845,18 +844,6 @@ static int annotated_source__alloc_histograms(struct=
 annotated_source *src,
>         return src->histograms ? 0 : -1;
>  }
>
> -/* The cycles histogram is lazily allocated. */
> -static int symbol__alloc_hist_cycles(struct symbol *sym)
> -{
> -       struct annotation *notes =3D symbol__annotation(sym);
> -       const size_t size =3D symbol__size(sym);
> -
> -       notes->src->cycles_hist =3D calloc(size, sizeof(struct cyc_hist))=
;
> -       if (notes->src->cycles_hist =3D=3D NULL)
> -               return -1;
> -       return 0;
> -}
> -
>  void symbol__annotate_zero_histograms(struct symbol *sym)
>  {
>         struct annotation *notes =3D symbol__annotation(sym);
> @@ -865,9 +852,10 @@ void symbol__annotate_zero_histograms(struct symbol =
*sym)
>         if (notes->src !=3D NULL) {
>                 memset(notes->src->histograms, 0,
>                        notes->src->nr_histograms * notes->src->sizeof_sym=
_hist);
> -               if (notes->src->cycles_hist)
> -                       memset(notes->src->cycles_hist, 0,
> -                               symbol__size(sym) * sizeof(struct cyc_his=
t));
> +       }
> +       if (notes->branch && notes->branch->cycles_hist) {
> +               memset(notes->branch->cycles_hist, 0,
> +                      symbol__size(sym) * sizeof(struct cyc_hist));
>         }
>         annotation__unlock(notes);
>  }
> @@ -958,23 +946,33 @@ static int __symbol__inc_addr_samples(struct map_sy=
mbol *ms,
>         return 0;
>  }
>
> +static struct annotated_branch *annotation__get_branch(struct annotation=
 *notes)
> +{
> +       if (notes =3D=3D NULL)
> +               return NULL;
> +
> +       if (notes->branch =3D=3D NULL)
> +               notes->branch =3D zalloc(sizeof(*notes->branch));
> +
> +       return notes->branch;
> +}
> +
>  static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
>  {
>         struct annotation *notes =3D symbol__annotation(sym);
> +       struct annotated_branch *branch;
>
> -       if (notes->src =3D=3D NULL) {
> -               notes->src =3D annotated_source__new();
> -               if (notes->src =3D=3D NULL)
> -                       return NULL;
> -               goto alloc_cycles_hist;
> -       }
> +       branch =3D annotation__get_branch(notes);
> +       if (branch =3D=3D NULL)
> +               return NULL;
> +
> +       if (branch->cycles_hist =3D=3D NULL) {
> +               const size_t size =3D symbol__size(sym);
>
> -       if (!notes->src->cycles_hist) {
> -alloc_cycles_hist:
> -               symbol__alloc_hist_cycles(sym);
> +               branch->cycles_hist =3D calloc(size, sizeof(struct cyc_hi=
st));
>         }
>
> -       return notes->src->cycles_hist;
> +       return branch->cycles_hist;
>  }
>
>  struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
> @@ -1083,6 +1081,14 @@ static unsigned annotation__count_insn(struct anno=
tation *notes, u64 start, u64
>         return n_insn;
>  }
>
> +static void annotated_branch__delete(struct annotated_branch *branch)
> +{
> +       if (branch) {
> +               free(branch->cycles_hist);
> +               free(branch);
> +       }
> +}
> +
>  static void annotation__count_and_fill(struct annotation *notes, u64 sta=
rt, u64 end, struct cyc_hist *ch)
>  {
>         unsigned n_insn;
> @@ -1091,6 +1097,7 @@ static void annotation__count_and_fill(struct annot=
ation *notes, u64 start, u64
>
>         n_insn =3D annotation__count_insn(notes, start, end);
>         if (n_insn && ch->num && ch->cycles) {
> +               struct annotated_branch *branch;
>                 float ipc =3D n_insn / ((double)ch->cycles / (double)ch->=
num);
>
>                 /* Hide data when there are too many overlaps. */
> @@ -1106,10 +1113,11 @@ static void annotation__count_and_fill(struct ann=
otation *notes, u64 start, u64
>                         }
>                 }
>
> -               if (cover_insn) {
> -                       notes->hit_cycles +=3D ch->cycles;
> -                       notes->hit_insn +=3D n_insn * ch->num;
> -                       notes->cover_insn +=3D cover_insn;
> +               branch =3D annotation__get_branch(notes);
> +               if (cover_insn && branch) {
> +                       branch->hit_cycles +=3D ch->cycles;
> +                       branch->hit_insn +=3D n_insn * ch->num;
> +                       branch->cover_insn +=3D cover_insn;
>                 }
>         }
>  }
> @@ -1118,19 +1126,19 @@ void annotation__compute_ipc(struct annotation *n=
otes, size_t size)
>  {
>         s64 offset;
>
> -       if (!notes->src || !notes->src->cycles_hist)
> +       if (!notes->branch || !notes->branch->cycles_hist)
>                 return;
>
> -       notes->total_insn =3D annotation__count_insn(notes, 0, size - 1);
> -       notes->hit_cycles =3D 0;
> -       notes->hit_insn =3D 0;
> -       notes->cover_insn =3D 0;
> +       notes->branch->total_insn =3D annotation__count_insn(notes, 0, si=
ze - 1);
> +       notes->branch->hit_cycles =3D 0;
> +       notes->branch->hit_insn =3D 0;
> +       notes->branch->cover_insn =3D 0;
>
>         annotation__lock(notes);
>         for (offset =3D size - 1; offset >=3D 0; --offset) {
>                 struct cyc_hist *ch;
>
> -               ch =3D &notes->src->cycles_hist[offset];
> +               ch =3D &notes->branch->cycles_hist[offset];
>                 if (ch && ch->cycles) {
>                         struct annotation_line *al;
>
> @@ -1147,7 +1155,6 @@ void annotation__compute_ipc(struct annotation *not=
es, size_t size)
>                                 al->cycles->max =3D ch->cycles_max;
>                                 al->cycles->min =3D ch->cycles_min;
>                         }
> -                       notes->have_cycles =3D true;
>                 }
>         }
>         annotation__unlock(notes);
> @@ -1305,6 +1312,7 @@ int disasm_line__scnprintf(struct disasm_line *dl, =
char *bf, size_t size, bool r
>  void annotation__exit(struct annotation *notes)
>  {
>         annotated_source__delete(notes->src);
> +       annotated_branch__delete(notes->branch);
>  }
>
>  static struct sharded_mutex *sharded_mutex;
> @@ -3058,13 +3066,14 @@ static void disasm_line__write(struct disasm_line=
 *dl, struct annotation *notes,
>  static void ipc_coverage_string(char *bf, int size, struct annotation *n=
otes)
>  {
>         double ipc =3D 0.0, coverage =3D 0.0;
> +       struct annotated_branch *branch =3D annotation__get_branch(notes)=
;
>
> -       if (notes->hit_cycles)
> -               ipc =3D notes->hit_insn / ((double)notes->hit_cycles);
> +       if (branch && branch->hit_cycles)
> +               ipc =3D branch->hit_insn / ((double)branch->hit_cycles);
>
> -       if (notes->total_insn) {
> -               coverage =3D notes->cover_insn * 100.0 /
> -                       ((double)notes->total_insn);
> +       if (branch && branch->total_insn) {
> +               coverage =3D branch->cover_insn * 100.0 /
> +                       ((double)branch->total_insn);
>         }
>
>         scnprintf(bf, size, "(Average IPC: %.2f, IPC Coverage: %.1f%%)",
> @@ -3089,7 +3098,7 @@ static void __annotation_line__write(struct annotat=
ion_line *al, struct annotati
>         int printed;
>
>         if (first_line && (al->offset =3D=3D -1 || percent_max =3D=3D 0.0=
)) {
> -               if (notes->have_cycles && al->cycles) {
> +               if (notes->branch && al->cycles) {
>                         if (al->cycles->ipc =3D=3D 0.0 && al->cycles->avg=
 =3D=3D 0)
>                                 show_title =3D true;
>                 } else
> @@ -3126,7 +3135,7 @@ static void __annotation_line__write(struct annotat=
ion_line *al, struct annotati
>                 }
>         }
>
> -       if (notes->have_cycles) {
> +       if (notes->branch) {
>                 if (al->cycles && al->cycles->ipc)
>                         obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH =
- 1, al->cycles->ipc);
>                 else if (!show_title)
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 16d27952fd5c..9c199629305d 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -271,17 +271,20 @@ struct annotated_source {
>         struct list_head   source;
>         int                nr_histograms;
>         size_t             sizeof_sym_hist;
> -       struct cyc_hist    *cycles_hist;
>         struct sym_hist    *histograms;
>  };
>
> -struct LOCKABLE annotation {
> -       u64                     max_coverage;
> -       u64                     start;
> +struct annotated_branch {

nit: it'd be really cool to have more comments with these structs,
explaining how they get used.

Thanks,
Ian

>         u64                     hit_cycles;
>         u64                     hit_insn;
>         unsigned int            total_insn;
>         unsigned int            cover_insn;
> +       struct cyc_hist         *cycles_hist;
> +};
> +
> +struct LOCKABLE annotation {
> +       u64                     max_coverage;
> +       u64                     start;
>         struct annotation_options *options;
>         struct annotation_line  **offsets;
>         int                     nr_events;
> @@ -297,8 +300,8 @@ struct LOCKABLE annotation {
>                 u8              max_addr;
>                 u8              max_ins_name;
>         } widths;
> -       bool                    have_cycles;
>         struct annotated_source *src;
> +       struct annotated_branch *branch;
>  };
>
>  static inline void annotation__init(struct annotation *notes __maybe_unu=
sed)
> @@ -312,10 +315,10 @@ bool annotation__trylock(struct annotation *notes) =
EXCLUSIVE_TRYLOCK_FUNCTION(tr
>
>  static inline int annotation__cycles_width(struct annotation *notes)
>  {
> -       if (notes->have_cycles && notes->options->show_minmax_cycle)
> +       if (notes->branch && notes->options->show_minmax_cycle)
>                 return ANNOTATION__IPC_WIDTH + ANNOTATION__MINMAX_CYCLES_=
WIDTH;
>
> -       return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__C=
YCLES_WIDTH : 0;
> +       return notes->branch ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES=
_WIDTH : 0;
>  }
>
>  static inline int annotation__pcnt_width(struct annotation *notes)
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index 591fc1edd385..08f82c1f166c 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -129,9 +129,9 @@ int block_info__process_sym(struct hist_entry *he, st=
ruct block_hist *bh,
>         al.sym =3D he->ms.sym;
>
>         notes =3D symbol__annotation(he->ms.sym);
> -       if (!notes || !notes->src || !notes->src->cycles_hist)
> +       if (!notes || !notes->branch || !notes->branch->cycles_hist)
>                 return 0;
> -       ch =3D notes->src->cycles_hist;
> +       ch =3D notes->branch->cycles_hist;
>         for (unsigned int i =3D 0; i < symbol__size(he->ms.sym); i++) {
>                 if (ch[i].num_aggr) {
>                         struct block_info *bi;
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 80e4f6132740..27b123ccd2d1 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -583,21 +583,21 @@ static int hist_entry__sym_ipc_snprintf(struct hist=
_entry *he, char *bf,
>  {
>
>         struct symbol *sym =3D he->ms.sym;
> -       struct annotation *notes;
> +       struct annotated_branch *branch;
>         double ipc =3D 0.0, coverage =3D 0.0;
>         char tmp[64];
>
>         if (!sym)
>                 return repsep_snprintf(bf, size, "%-*s", width, "-");
>
> -       notes =3D symbol__annotation(sym);
> +       branch =3D symbol__annotation(sym)->branch;
>
> -       if (notes->hit_cycles)
> -               ipc =3D notes->hit_insn / ((double)notes->hit_cycles);
> +       if (branch && branch->hit_cycles)
> +               ipc =3D branch->hit_insn / ((double)branch->hit_cycles);
>
> -       if (notes->total_insn) {
> -               coverage =3D notes->cover_insn * 100.0 /
> -                       ((double)notes->total_insn);
> +       if (branch && branch->total_insn) {
> +               coverage =3D branch->cover_insn * 100.0 /
> +                       ((double)branch->total_insn);
>         }
>
>         snprintf(tmp, sizeof(tmp), "%-5.2f [%5.1f%%]", ipc, coverage);
> --
> 2.42.0.869.gea05f2083d-goog
>
