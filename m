Return-Path: <linux-kernel+bounces-133707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6589A79B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F691F22B9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E5374C6;
	Fri,  5 Apr 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ge0+Nhsy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC92C1BA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712360518; cv=none; b=j+sI8s0fleUZVIrbZaWU+ArrEXMza57lytBEpZGMXtlD0Tg6vkDZ+PvtuntsKPZLq+bbXtGmreJJ5wFPcRs+Q9xp6+qeIhfBGu5EBlETIULvoqOMmtf5LAcemYckyHni+T+f/IjsP+xjjOJUqy7j/4ez8bbgRLJntS07hRpnRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712360518; c=relaxed/simple;
	bh=w8Kwq/WskFZvkKyjoPGgyWzgPyPvXyYnh4uIK0TJyJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTXgOExFJc2/KWag+tvF57aKY+JFPn/Fl4a7RMKHefA4rMVZCLbD/C6Wm6Z6LeS5tVymipUmaIQIGgHEGul2EHrOxQ8nTpXUIbBxHCT7jtJ6S+pjrihPNBR8r0T3Eg2Q1qKDzirr3xpFWt9shmQ7UJXu1d/urdfanJVA4hdZmpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ge0+Nhsy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2add0b990so60855ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712360516; x=1712965316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfevWNOIm2n/bg5ng8kzCCoEm0rtL0MBosGvA1jLHV0=;
        b=ge0+NhsyhL7DPAjIJ7ZlQNVwqViPHWZyxFkxaj7nUaa4esliWPC20V8M/WvjZt2sDO
         /niuU7Ja9wDWyorYC70hTx9/JCd0HUNRBBPE/sE7A3qTRHm1LBj/Tel1UGYbBYdq8LLH
         FyyPo559CMffbtJqvLDslSiXTY0UfI21XUzNFV9aos9yjYJAxSIfgH/vZogKgbqlIxQw
         YFlIU8yI5HtrhEC7eiI8rHoGmIg8au3DoJy2p7HUWDZnc5/w3HbiVTwSTifl2uuXUJUZ
         xgbqmeOLu7dUgkYLgobXp2a5sPzmE1o3H+L1Ol9qo87dcjcbDwTjd6T5kMtGF1vTcti3
         WiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712360516; x=1712965316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfevWNOIm2n/bg5ng8kzCCoEm0rtL0MBosGvA1jLHV0=;
        b=f0GSoEE/bY3EWRn+9NWqWLVAbPivqT5KykYWIGh5dXUEmQdTWnFpB8Af+UqwNqW1fH
         /MUyjJ7hXHIit/RuRYUfit4SZKOZbFh2GStL8Izi8KUawm6AvV/QLyMPzp+NNnstdlCI
         VoI/Kxv7vTvB2raW2IS9T1VxXfnPKcObudBTa5ghzfc3t6ycOlDYqq2eK3aOkuSX3jcI
         +xPah2XqTt1yhA09jJvYbDFzWHRPwsT8tBfWMaI39UXHWz7RDOpssqjZvQdN6dvx3aFt
         K5Abs+tqUtD+2hI1PKiDQtYaJ/hHkDYPdMjldveDoAjGtzruqECGKwHvoK/Dz55apHtT
         VA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW9uE80luos+SdFp0a6U0WxeLrQqD+jK25TuXuFKvvrbSVtcL4onCQxbhZ7tPgoWXgtcRL4w589iBnrU16l4XXrK1ivuq5bROKXCoB
X-Gm-Message-State: AOJu0YxGq6wWSLEnMhWXw7sEdPcpSHBTCxcQBUxDgg48s4e6Ht2UU6zB
	Xb+vmOkmrf03EysnoJuUpCNsJW6yoI2CVphHvxegiC5dg+J0YWFW1QQW8ILEyALj+s9kHVw3Iq8
	exofHzNpNcPgWU5tXw+gm/vYbuLUlbSkckaj+
X-Google-Smtp-Source: AGHT+IEfd/ee+OVZj2lpDpdK0+JyB26WYotuuxq3NskTle96PsOoi5evd6gVO81E1DavaEnBTJXZ9GmQ7AKUA5h4L88=
X-Received: by 2002:a17:903:2345:b0:1e2:3991:9e9 with SMTP id
 c5-20020a170903234500b001e2399109e9mr95117plh.0.1712360515704; Fri, 05 Apr
 2024 16:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404175716.1225482-1-namhyung@kernel.org> <20240404175716.1225482-10-namhyung@kernel.org>
In-Reply-To: <20240404175716.1225482-10-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 5 Apr 2024 16:41:43 -0700
Message-ID: <CAP-5=fXecm7N5+2dP_qkF1B21mQ-WJwwic9TspDyo7atbiojSA@mail.gmail.com>
Subject: Re: [PATCH 9/9] perf annotate: Move start field struct to annotated_source
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:57=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It's only used in perf annotate output which means functions with actual
> samples.  No need to consume memory for every symbol (annotation).
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 10 +++++-----
>  tools/perf/util/annotate.h |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5f79ae0bccfd..4db49611c386 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -909,9 +909,9 @@ int symbol__annotate(struct map_symbol *ms, struct ev=
sel *evsel,
>         args.arch =3D arch;
>         args.ms =3D *ms;
>         if (annotate_opts.full_addr)
> -               notes->start =3D map__objdump_2mem(ms->map, ms->sym->star=
t);
> +               notes->src->start =3D map__objdump_2mem(ms->map, ms->sym-=
>start);
>         else
> -               notes->start =3D map__rip_2objdump(ms->map, ms->sym->star=
t);
> +               notes->src->start =3D map__rip_2objdump(ms->map, ms->sym-=
>start);
>
>         return symbol__disassemble(sym, &args);
>  }
> @@ -1456,9 +1456,9 @@ void annotation__toggle_full_addr(struct annotation=
 *notes, struct map_symbol *m
>         annotate_opts.full_addr =3D !annotate_opts.full_addr;
>
>         if (annotate_opts.full_addr)
> -               notes->start =3D map__objdump_2mem(ms->map, ms->sym->star=
t);
> +               notes->src->start =3D map__objdump_2mem(ms->map, ms->sym-=
>start);
>         else
> -               notes->start =3D map__rip_2objdump(ms->map, ms->sym->star=
t);
> +               notes->src->start =3D map__rip_2objdump(ms->map, ms->sym-=
>start);
>
>         annotation__update_column_widths(notes);
>  }
> @@ -1766,7 +1766,7 @@ static void __annotation_line__write(struct annotat=
ion_line *al, struct annotati
>                 int color =3D -1;
>
>                 if (!annotate_opts.use_offset)
> -                       addr +=3D notes->start;
> +                       addr +=3D notes->src->start;
>
>                 if (!annotate_opts.use_offset) {
>                         printed =3D scnprintf(bf, sizeof(bf), "%" PRIx64 =
": ", addr);
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index d22b9e9a2fad..d5c821c22f79 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -270,6 +270,7 @@ struct annotated_source {
>         int                     nr_entries;
>         int                     nr_asm_entries;
>         int                     max_jump_sources;
> +       u64                     start;

This introduces a 4 byte hole:

```
struct annotated_source {
       struct list_head           source;               /*     0    16 */
       struct sym_hist *          histograms;           /*    16     8 */
       struct hashmap *           samples;              /*    24     8 */
       int                        nr_histograms;        /*    32     4 */
       int                        nr_events;            /*    36     4 */
       int                        nr_entries;           /*    40     4 */
       int                        nr_asm_entries;       /*    44     4 */
       int                        max_jump_sources;     /*    48     4 */

       /* XXX 4 bytes hole, try to pack */

       u64                        start;                /*    56     8 */
       /* --- cacheline 1 boundary (64 bytes) --- */
       struct {
               u8                 addr;                 /*    64     1 */
               u8                 jumps;                /*    65     1 */
               u8                 target;               /*    66     1 */
               u8                 min_addr;             /*    67     1 */
               u8                 max_addr;             /*    68     1 */
               u8                 max_ins_name;         /*    69     1 */
               u16                max_line_len;         /*    70     2 */
       } widths;                                        /*    64     8 */

       /* size: 72, cachelines: 2, members: 10 */
       /* sum members: 68, holes: 1, sum holes: 4 */
       /* last cacheline: 8 bytes */
};
```

If you sort variables from largest to smallest then it generally
avoids holes (so max_line_len violates this, but it doesn't introduce
padding). Anyway, a simple fix is to just shuffle things a little.

Thanks,
Ian

>         struct {
>                 u8              addr;
>                 u8              jumps;
> @@ -312,7 +313,6 @@ struct annotated_branch {
>  };
>
>  struct LOCKABLE annotation {
> -       u64                     start;
>         struct annotated_source *src;
>         struct annotated_branch *branch;
>  };
> --
> 2.44.0.478.gd926399ef9-goog
>

