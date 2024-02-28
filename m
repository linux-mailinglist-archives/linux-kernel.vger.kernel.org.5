Return-Path: <linux-kernel+bounces-84545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8FD86A817
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF9B23C66
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C638219F6;
	Wed, 28 Feb 2024 05:43:48 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508671D6AA;
	Wed, 28 Feb 2024 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709099027; cv=none; b=utX0Ml0ivqZD+f8SWYIH4X2ZosTeCAAg917Dl2OL4lAb0WKZiaxR263QzW5rwyriOVSkp7bn1DJet+hy3VacYicK15ETuGvQ++QMeSWlZXmCSHsPbvia6Vfa6cNjKm/ZalJwAZj+k0FOmpL4YFXUpiDMlROT1MSjnchqh7pEPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709099027; c=relaxed/simple;
	bh=ghmdVO2l8+qnylPp5BiMESK8wnMUSpdlyDToGt+DawA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwR7EvDNtiNtJf02yd89PkgBv4DarRZcn/I7MoR+apLCM1qbU29hYD8hx5Et70uw2PxrGeGpik/zx/X6GY3K1XjN5/IvCZzs0KwhKpNXZ8Cg3BSF28B5pb3CywEU+kqzI8ZgfTZGttrSa4iGvb0WKdF+MVlaGjzSFoqSI7p2/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29aa8c4710bso409199a91.1;
        Tue, 27 Feb 2024 21:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709099026; x=1709703826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbp3GUJDXTUR8rBNnC4XYTGjfFdtu7RF4U45tc4UUeU=;
        b=V2KoPvABsDTbXxlbxAZmLUHrptE1HxY4l+T3OM5vD6uvk6WdJvvGtknC2LT84ZM8ou
         Xkn+27UPby0W9dfpwvnUovmhkbEsccOxlVeeyMKs4RHE+0IE5t726Qbuk+mJ7/52i/F0
         ZVl0qkXnLNkNh1pjL1TfOKLTELkRwhWN7w3bCtHvHeXfwDWBbJ7MrZzSeouoL7ntkfTL
         lGWbmDllqBhU7/sp+tZcAw8+XcaNYhIM2+dageBC8oPduZgkgwg8PYK7Y1h7G5+37CNT
         nhRpPLYCR51KDns/fyFky/tLncNZCfEQzOfqR37ZgUgFcgV3ekRjUfLMzvfNeaFVD8Dk
         aKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL8+gUlSktce+CwgqLz+gEdHw3WMyt97LrcDDF+X5Lx+hjeNbjGVvRuAzcOyKSCZtb488bX5r0FREjqOl2SEjusLP8vRj/CoB9seqm5c9eGIewjE6FmpQyfWaozlnEbZqP4kqxP2lYF/vmX1PjQA==
X-Gm-Message-State: AOJu0YxyKBgU75Ve8gaUOE+uZxP2FwrfEAbmatAa5XyGjj+TzN8/alcA
	8ZCfYNB8X8WteLECpAgnND3UUA5PXxz+YsZyGMYlSYH/Ya0OqjZ+vKEqPU5WCtmyHyaYN6fRvvD
	qArtBUHxft4F2GeeCF8G+wtjG3nx7Qjso
X-Google-Smtp-Source: AGHT+IFUAfQJYY7FcuN/1QiinwRz7q/kmUBrshJBSv1AuSKsJBAUgHgIPhc/z03nrXsgVYvlqPMEzjIZJL9cao4kOIk=
X-Received: by 2002:a17:90a:6306:b0:299:d975:89ea with SMTP id
 e6-20020a17090a630600b00299d97589eamr1929308pjj.21.1709099025575; Tue, 27 Feb
 2024 21:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228005230.287113-1-namhyung@kernel.org> <20240228005230.287113-3-namhyung@kernel.org>
In-Reply-To: <20240228005230.287113-3-namhyung@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 21:43:33 -0800
Message-ID: <CAM9d7cgY+S+JzE1N0eWx=LxTy+0cewugdGaNr6RkNCOQAE2D7g@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf annotate: Calculate instruction overhead using hashmap
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Use annotated_source.samples hashmap instead of addr array in the
> struct sym_hist.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/gtk/annotate.c | 14 +++++++++---
>  tools/perf/util/annotate.c   | 44 ++++++++++++++++++++++++------------
>  tools/perf/util/annotate.h   | 11 +++++++++
>  3 files changed, 52 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 394861245fd3..93ce3d47e47e 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -28,21 +28,29 @@ static const char *const col_names[] =3D {
>  static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *=
sym,
>                                  struct disasm_line *dl, int evidx)
>  {
> +       struct annotation *notes;
>         struct sym_hist *symhist;
> +       struct sym_hist_entry *entry;
>         double percent =3D 0.0;
>         const char *markup;
>         int ret =3D 0;
> +       u64 nr_samples =3D 0;
>
>         strcpy(buf, "");
>
>         if (dl->al.offset =3D=3D (s64) -1)
>                 return 0;
>
> -       symhist =3D annotation__histogram(symbol__annotation(sym), evidx)=
;
> -       if (!symbol_conf.event_group && !symhist->addr[dl->al.offset].nr_=
samples)
> +       notes =3D symbol__annotation(sym);
> +       symhist =3D annotation__histogram(notes, evidx);
> +       entry =3D annotated_source__hist_entry(notes->src, evidx, dl->al.=
offset);
> +       if (entry)
> +               nr_samples =3D entry->nr_samples;
> +
> +       if (!symbol_conf.event_group && nr_samples =3D=3D 0)
>                 return 0;
>
> -       percent =3D 100.0 * symhist->addr[dl->al.offset].nr_samples / sym=
hist->nr_samples;
> +       percent =3D 100.0 * nr_samples / symhist->nr_samples;
>
>         markup =3D perf_gtk__get_percent_color(percent);
>         if (markup)
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 7a70e4d35c9b..e7859f756252 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2368,17 +2368,25 @@ static int symbol__disassemble(struct symbol *sym=
, struct annotate_args *args)
>         return err;
>  }
>
> -static void calc_percent(struct sym_hist *sym_hist,
> -                        struct hists *hists,
> +static void calc_percent(struct annotation *notes,
> +                        struct evsel *evsel,
>                          struct annotation_data *data,
>                          s64 offset, s64 end)
>  {
> +       struct hists *hists =3D evsel__hists(evsel);
> +       int evidx =3D evsel->core.idx;
> +       struct sym_hist *sym_hist =3D annotation__histogram(notes, evidx)=
;
>         unsigned int hits =3D 0;
>         u64 period =3D 0;
>
>         while (offset < end) {
> -               hits   +=3D sym_hist->addr[offset].nr_samples;
> -               period +=3D sym_hist->addr[offset].period;
> +               struct sym_hist_entry *entry;
> +
> +               entry =3D annotated_source__hist_entry(notes->src, evidx,=
 offset);
> +               if (entry) {
> +                       hits   +=3D entry->nr_samples;
> +                       period +=3D entry->period;
> +               }
>                 ++offset;
>         }
>
> @@ -2415,16 +2423,13 @@ static void annotation__calc_percent(struct annot=
ation *notes,
>                 end  =3D next ? next->offset : len;
>
>                 for_each_group_evsel(evsel, leader) {
> -                       struct hists *hists =3D evsel__hists(evsel);
>                         struct annotation_data *data;
> -                       struct sym_hist *sym_hist;
>
>                         BUG_ON(i >=3D al->data_nr);
>
> -                       sym_hist =3D annotation__histogram(notes, evsel->=
core.idx);
>                         data =3D &al->data[i++];
>
> -                       calc_percent(sym_hist, hists, data, al->offset, e=
nd);
> +                       calc_percent(notes, evsel, data, al->offset, end)=
;
>                 }
>         }
>  }
> @@ -2619,14 +2624,19 @@ static void print_summary(struct rb_root *root, c=
onst char *filename)
>
>  static void symbol__annotate_hits(struct symbol *sym, struct evsel *evse=
l)
>  {
> +       int evidx =3D evsel->core.idx;
>         struct annotation *notes =3D symbol__annotation(sym);
> -       struct sym_hist *h =3D annotation__histogram(notes, evsel->core.i=
dx);
> +       struct sym_hist *h =3D annotation__histogram(notes, evidx);
>         u64 len =3D symbol__size(sym), offset;
>
> -       for (offset =3D 0; offset < len; ++offset)
> -               if (h->addr[offset].nr_samples !=3D 0)
> +       for (offset =3D 0; offset < len; ++offset) {
> +               struct sym_hist_entry *entry;
> +
> +               entry =3D annotated_source__hist_entry(notes->src, evidx,=
 offset);
> +               if (entry && entry->nr_samples !=3D 0)
>                         printf("%*" PRIx64 ": %" PRIu64 "\n", BITS_PER_LO=
NG / 2,
> -                              sym->start + offset, h->addr[offset].nr_sa=
mples);
> +                              sym->start + offset, entry->nr_samples);
> +       }
>         printf("%*s: %" PRIu64 "\n", BITS_PER_LONG / 2, "h->nr_samples", =
h->nr_samples);
>  }
>
> @@ -2855,8 +2865,14 @@ void symbol__annotate_decay_histogram(struct symbo=
l *sym, int evidx)
>
>         h->nr_samples =3D 0;
>         for (offset =3D 0; offset < len; ++offset) {
> -               h->addr[offset].nr_samples =3D h->addr[offset].nr_samples=
 * 7 / 8;
> -               h->nr_samples +=3D h->addr[offset].nr_samples;
> +               struct sym_hist_entry *entry;
> +
> +               entry =3D annotated_source__hist_entry(notes->src, evidx,=
 offset);
> +               if (entry =3D=3D NULL)
> +                       continue;
> +
> +               entry->nr_samples =3D entry->nr_samples * 7 / 8;
> +               h->nr_samples +=3D entry->nr_samples;
>         }
>  }
>
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index a2b0c8210740..3362980a5d3d 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -356,6 +356,17 @@ static inline struct sym_hist *annotation__histogram=
(struct annotation *notes, i
>         return annotated_source__histogram(notes->src, idx);
>  }
>
> +static inline struct sym_hist_entry *
> +annotated_source__hist_entry(struct annotated_source *src, int idx, u64 =
offset)
> +{
> +       struct sym_hist_entry *entry;
> +       long key =3D offset << 16 | idx;
> +
> +       if (!hashmap__find(src->samples, key, &entry))

Hmm.. then I've realized that it requires the header file anyway.
This code is needed by multiple places for stdio, tui, gtk output.

Thanks,
Namhyung


> +               return NULL;
> +       return entry;
> +}
> +
>  static inline struct annotation *symbol__annotation(struct symbol *sym)
>  {
>         return (void *)sym - symbol_conf.priv_size;
> --
> 2.44.0.rc1.240.g4c46232300-goog
>
>

