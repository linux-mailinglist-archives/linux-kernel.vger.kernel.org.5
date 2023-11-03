Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579067E087B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbjKCSuR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Nov 2023 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:50:12 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B548D4D;
        Fri,  3 Nov 2023 11:50:09 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5b97ca78da8so1928385a12.3;
        Fri, 03 Nov 2023 11:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699037408; x=1699642208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0IKeyrENj3+HzDVubIH2jlRhTJ5tEOWOpi5oD20qHw=;
        b=SDrv+vUh6iNYfedcBWa0VBZnUB11yBGc3U0hzZCNvdEmoULiwc4S6s5Bsf1Rs3IpJF
         JNw3t07cPNIMZlzLZcDkHvYbIihNmCaOFfJQ4b7CMNwSianetPLAxQo4haJK+PCwZb3X
         x9QgGmgeHensb+f+XaVVwO5zHkgQVljn4hX570zSAcxbiKetWd392tH1n7fr52WnxwZP
         pywd9Yjpac36fAmhbPih5o8u7xDDPYfFKp9iT0TmGe1DbnGFuODKr6MdkJEZijU7d+uJ
         Ebm8Xjf1fyml5jy2lKgCJdVb4wO8VPTJKMgo1Ivx490M/Ru3UGvgGVb4dtyXOFVUT5g+
         FdsA==
X-Gm-Message-State: AOJu0YyyNgWeFpc9uRcMktNzH7rnia/zrEC26qntQ13rkjFbqGzQI2t+
        2zzacmEFRm4dE2LuvVWP4SPrjUVCx1NsgPvGqH1KW8h+
X-Google-Smtp-Source: AGHT+IGICoVnM4bHgd8WPh5p0XhxYewV2XiNJHUzvAHBI9dSEJ3f8TpHjFFRhRKrKHBsVlBupOlzJYjTMK97D3HiHTI=
X-Received: by 2002:a05:6a20:3941:b0:181:8654:8279 with SMTP id
 r1-20020a056a20394100b0018186548279mr6727374pzg.47.1699037408273; Fri, 03 Nov
 2023 11:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-3-namhyung@kernel.org>
 <CAP-5=fXOZK6Ym=EwidvcWtVdEe65iyiK9Fe7XxLW=+SSQu-kSA@mail.gmail.com>
In-Reply-To: <CAP-5=fXOZK6Ym=EwidvcWtVdEe65iyiK9Fe7XxLW=+SSQu-kSA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Nov 2023 11:49:57 -0700
Message-ID: <CAM9d7cgOHv1xhY3BhxEgQEXTjJksPWYQsLRfp4qHKBYs7=Xn6g@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf annotate: Split struct annotated_branch
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
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

On Thu, Nov 2, 2023 at 3:58 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Nov 2, 2023 at 3:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The cycles info is only meaninful when sample has branch stacks.  To
>
> nit: meaningful

Oops, will fix.

>
> > save the memory for normal cases, move those fields to annotated_branch
> > and dynamically allocate it when needed.  Also move cycles_hist from
> > annotated_source as it's related here.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c   | 97 ++++++++++++++++++++----------------
> >  tools/perf/util/annotate.h   | 17 ++++---
> >  tools/perf/util/block-info.c |  4 +-
> >  tools/perf/util/sort.c       | 14 +++---
> >  4 files changed, 72 insertions(+), 60 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 3e7f75827270..2fa1ce3a0858 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -810,7 +810,6 @@ static __maybe_unused void annotated_source__delete(struct annotated_source *src
> >         if (src == NULL)
> >                 return;
> >         zfree(&src->histograms);
> > -       zfree(&src->cycles_hist);
> >         free(src);
> >  }
> >
> > @@ -845,18 +844,6 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
> >         return src->histograms ? 0 : -1;
> >  }
> >
> > -/* The cycles histogram is lazily allocated. */
> > -static int symbol__alloc_hist_cycles(struct symbol *sym)
> > -{
> > -       struct annotation *notes = symbol__annotation(sym);
> > -       const size_t size = symbol__size(sym);
> > -
> > -       notes->src->cycles_hist = calloc(size, sizeof(struct cyc_hist));
> > -       if (notes->src->cycles_hist == NULL)
> > -               return -1;
> > -       return 0;
> > -}
> > -
> >  void symbol__annotate_zero_histograms(struct symbol *sym)
> >  {
> >         struct annotation *notes = symbol__annotation(sym);
> > @@ -865,9 +852,10 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
> >         if (notes->src != NULL) {
> >                 memset(notes->src->histograms, 0,
> >                        notes->src->nr_histograms * notes->src->sizeof_sym_hist);
> > -               if (notes->src->cycles_hist)
> > -                       memset(notes->src->cycles_hist, 0,
> > -                               symbol__size(sym) * sizeof(struct cyc_hist));
> > +       }
> > +       if (notes->branch && notes->branch->cycles_hist) {
> > +               memset(notes->branch->cycles_hist, 0,
> > +                      symbol__size(sym) * sizeof(struct cyc_hist));
> >         }
> >         annotation__unlock(notes);
> >  }
> > @@ -958,23 +946,33 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
> >         return 0;
> >  }
> >
> > +static struct annotated_branch *annotation__get_branch(struct annotation *notes)
> > +{
> > +       if (notes == NULL)
> > +               return NULL;
> > +
> > +       if (notes->branch == NULL)
> > +               notes->branch = zalloc(sizeof(*notes->branch));
> > +
> > +       return notes->branch;
> > +}
> > +
> >  static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
> >  {
> >         struct annotation *notes = symbol__annotation(sym);
> > +       struct annotated_branch *branch;
> >
> > -       if (notes->src == NULL) {
> > -               notes->src = annotated_source__new();
> > -               if (notes->src == NULL)
> > -                       return NULL;
> > -               goto alloc_cycles_hist;
> > -       }
> > +       branch = annotation__get_branch(notes);
> > +       if (branch == NULL)
> > +               return NULL;
> > +
> > +       if (branch->cycles_hist == NULL) {
> > +               const size_t size = symbol__size(sym);
> >
> > -       if (!notes->src->cycles_hist) {
> > -alloc_cycles_hist:
> > -               symbol__alloc_hist_cycles(sym);
> > +               branch->cycles_hist = calloc(size, sizeof(struct cyc_hist));
> >         }
> >
> > -       return notes->src->cycles_hist;
> > +       return branch->cycles_hist;
> >  }
> >
> >  struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
> > @@ -1083,6 +1081,14 @@ static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64
> >         return n_insn;
> >  }
> >
> > +static void annotated_branch__delete(struct annotated_branch *branch)
> > +{
> > +       if (branch) {
> > +               free(branch->cycles_hist);
> > +               free(branch);
> > +       }
> > +}
> > +
> >  static void annotation__count_and_fill(struct annotation *notes, u64 start, u64 end, struct cyc_hist *ch)
> >  {
> >         unsigned n_insn;
> > @@ -1091,6 +1097,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
> >
> >         n_insn = annotation__count_insn(notes, start, end);
> >         if (n_insn && ch->num && ch->cycles) {
> > +               struct annotated_branch *branch;
> >                 float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
> >
> >                 /* Hide data when there are too many overlaps. */
> > @@ -1106,10 +1113,11 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
> >                         }
> >                 }
> >
> > -               if (cover_insn) {
> > -                       notes->hit_cycles += ch->cycles;
> > -                       notes->hit_insn += n_insn * ch->num;
> > -                       notes->cover_insn += cover_insn;
> > +               branch = annotation__get_branch(notes);
> > +               if (cover_insn && branch) {
> > +                       branch->hit_cycles += ch->cycles;
> > +                       branch->hit_insn += n_insn * ch->num;
> > +                       branch->cover_insn += cover_insn;
> >                 }
> >         }
> >  }
> > @@ -1118,19 +1126,19 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
> >  {
> >         s64 offset;
> >
> > -       if (!notes->src || !notes->src->cycles_hist)
> > +       if (!notes->branch || !notes->branch->cycles_hist)
> >                 return;
> >
> > -       notes->total_insn = annotation__count_insn(notes, 0, size - 1);
> > -       notes->hit_cycles = 0;
> > -       notes->hit_insn = 0;
> > -       notes->cover_insn = 0;
> > +       notes->branch->total_insn = annotation__count_insn(notes, 0, size - 1);
> > +       notes->branch->hit_cycles = 0;
> > +       notes->branch->hit_insn = 0;
> > +       notes->branch->cover_insn = 0;
> >
> >         annotation__lock(notes);
> >         for (offset = size - 1; offset >= 0; --offset) {
> >                 struct cyc_hist *ch;
> >
> > -               ch = &notes->src->cycles_hist[offset];
> > +               ch = &notes->branch->cycles_hist[offset];
> >                 if (ch && ch->cycles) {
> >                         struct annotation_line *al;
> >
> > @@ -1147,7 +1155,6 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
> >                                 al->cycles->max = ch->cycles_max;
> >                                 al->cycles->min = ch->cycles_min;
> >                         }
> > -                       notes->have_cycles = true;
> >                 }
> >         }
> >         annotation__unlock(notes);
> > @@ -1305,6 +1312,7 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
> >  void annotation__exit(struct annotation *notes)
> >  {
> >         annotated_source__delete(notes->src);
> > +       annotated_branch__delete(notes->branch);
> >  }
> >
> >  static struct sharded_mutex *sharded_mutex;
> > @@ -3058,13 +3066,14 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
> >  static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
> >  {
> >         double ipc = 0.0, coverage = 0.0;
> > +       struct annotated_branch *branch = annotation__get_branch(notes);
> >
> > -       if (notes->hit_cycles)
> > -               ipc = notes->hit_insn / ((double)notes->hit_cycles);
> > +       if (branch && branch->hit_cycles)
> > +               ipc = branch->hit_insn / ((double)branch->hit_cycles);
> >
> > -       if (notes->total_insn) {
> > -               coverage = notes->cover_insn * 100.0 /
> > -                       ((double)notes->total_insn);
> > +       if (branch && branch->total_insn) {
> > +               coverage = branch->cover_insn * 100.0 /
> > +                       ((double)branch->total_insn);
> >         }
> >
> >         scnprintf(bf, size, "(Average IPC: %.2f, IPC Coverage: %.1f%%)",
> > @@ -3089,7 +3098,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >         int printed;
> >
> >         if (first_line && (al->offset == -1 || percent_max == 0.0)) {
> > -               if (notes->have_cycles && al->cycles) {
> > +               if (notes->branch && al->cycles) {
> >                         if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
> >                                 show_title = true;
> >                 } else
> > @@ -3126,7 +3135,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >                 }
> >         }
> >
> > -       if (notes->have_cycles) {
> > +       if (notes->branch) {
> >                 if (al->cycles && al->cycles->ipc)
> >                         obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->cycles->ipc);
> >                 else if (!show_title)
> > diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> > index 16d27952fd5c..9c199629305d 100644
> > --- a/tools/perf/util/annotate.h
> > +++ b/tools/perf/util/annotate.h
> > @@ -271,17 +271,20 @@ struct annotated_source {
> >         struct list_head   source;
> >         int                nr_histograms;
> >         size_t             sizeof_sym_hist;
> > -       struct cyc_hist    *cycles_hist;
> >         struct sym_hist    *histograms;
> >  };
> >
> > -struct LOCKABLE annotation {
> > -       u64                     max_coverage;
> > -       u64                     start;
> > +struct annotated_branch {
>
> nit: it'd be really cool to have more comments with these structs,
> explaining how they get used.

Yep, maybe a separate patch after the cleanup. :)

Thanks,
Namhyung


>
> >         u64                     hit_cycles;
> >         u64                     hit_insn;
> >         unsigned int            total_insn;
> >         unsigned int            cover_insn;
> > +       struct cyc_hist         *cycles_hist;
> > +};
