Return-Path: <linux-kernel+bounces-163274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0798B6810
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187FB1F22899
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506CDDAA;
	Tue, 30 Apr 2024 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcptQFBg"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4266FB0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445549; cv=none; b=UDKiieW3VGhMuoaPZ18j4F8AuDgc7/ax1Eecsj5pPFOdlAB507rxSBdbfOE7h7RNSkvT50Um4eOIylO8zcHd4rcJCPCNF0ZX9zw3FsEimD1VUQup7QTWTI8byC/WIuSFAqlvultD0puwOOApclbfkwA8fB4EWYRI1i8p4pQNmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445549; c=relaxed/simple;
	bh=JmzK1q0EGoSafd9C6nM4zHYa9w8NdwCmO1jsFQ/IA9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhevbE+MAsZ4FonmMhlmuap5faAwV4+hxiDy2nvHabbnviiVK1/XVw7FDsQptOrQrBHXDlUQVyLhRogbZODUZ5NLRmVYlcyKeMLxUDT0aD3nZQJKSj8MdBsD6+lDLmyde89y/bngth91/73V9dPXQElA6v1Iu7MOenzwMy6GN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcptQFBg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43989e6ca42so114751cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714445547; x=1715050347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqkGLjUvwIi+WZb9DeaU3ZOZzub03nQXf8QCdwOdixw=;
        b=xcptQFBgVQhtEuYaZZ/G5vA0YIulOZa3t+m5zq40VqMmlUlpkdFaE/Y5nt0Xtyjy9s
         fsXHU4qkEWfXjeA6C7n74altcORE+zFzCeqx6/O30UPwxS9Yr6GQ3xV2/FjWDM4bg/eG
         yYerMpz1tQHQ/INTp5Dzcx5LnVfSRiznYxG+OeKSdI7CMTxmqf9pIkbcjyl3arbM0NB+
         guXBvdYmbg1GS2cLvdSDtxSP+6C8z3tAZmqJm5/Hb0a+8LSBJ0Kuev56FSKBNqbld3Uo
         nHsAP78psI1NpyTRbpG/fAsNV+nH6gTDTC1OxnNjx/721i1WkZdzfmGsPP+CZkkw5Raq
         xGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714445547; x=1715050347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqkGLjUvwIi+WZb9DeaU3ZOZzub03nQXf8QCdwOdixw=;
        b=T3zPe+F3MVTJFb/C9aodUYirvzDNW34krRYueXf6vpAMGUUabPRfUQl1QkVrdse3UQ
         MovOjLRksRtj0Iya1Q98UGCWyIwYiaCj7aakR75FouXPM7Z6oXuxWyUEclGLoHgysjun
         W3fQh37qCcaaku4pOU3viBsl1Pb6XaLP3b3JXOknQ0pQEABUjN0rU8JGepO5hr26G7Bw
         CR2x/pAwB6Yl593Ygoxm2jdKy9SKMLFF0KdW/HBaii2W69DRoPYYO7yJT2aZdKI0RqSY
         3kRaUz+gAzVuu755o4wiq/W+/boLrB6lh1u1Ow2CA43f9SJWuVifpaL4TJYDU5hukfOk
         pf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQTQGNZcmid7OPjVmPq6u+LyUZ/fpf+1Et4GbUarPFlwQImLbeyGB3MQt9VCAxaJb8k4e67CChJRV/9AHiwAj0I9llV1Y/pw3OzlwZ
X-Gm-Message-State: AOJu0Yx6I6oJgt9n5xjRTpxVI2cBkl26xl0p8n11q1jPwCYcFthA9V2i
	uJRJtbPlzBfuSFKcG+4DPlRZSUy/s3alvX54gESEOrUCDkaULzZecz9LLfQh3M2VQBBxA7z3KFr
	PUhsF8Z26QsL/QzQ4zN6UjHuTR/Lzr+JV/NVM
X-Google-Smtp-Source: AGHT+IHkgFwaqmVNXxgWoRcPJejObaLzomDfvKNjI0+ZhUiWoLBiKSua4LS1YiLP9oMS4NqaFJGGVWD3V+ksq8njPAo=
X-Received: by 2002:ac8:5d88:0:b0:439:ef72:75fb with SMTP id
 d8-20020ac85d88000000b00439ef7275fbmr88618qtx.1.1714445546707; Mon, 29 Apr
 2024 19:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-3-irogers@google.com>
 <CAM9d7cgcC-qO63neiCtyovC6qiAprMs=HKF66XvfiBqZrOiXXg@mail.gmail.com>
In-Reply-To: <CAM9d7cgcC-qO63neiCtyovC6qiAprMs=HKF66XvfiBqZrOiXXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Apr 2024 19:52:15 -0700
Message-ID: <CAP-5=fU13Df2HdeS6jXhViv+tJt+aF1KQ_yAaK_f-DBtuLewUg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] perf parse-events: Add a retirement latency modifier
To: Namhyung Kim <namhyung@kernel.org>
Cc: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Song Liu <song@kernel.org>, James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Retirement latency is a separate sampled count used on newer Intel
> > CPUs.
>
> Can you please update the "event modifiers" section in the perf list
> documentation too?

Will do, currently the only users are TMA metrics.

> Also I'm curious if we have a doc for the JSON metric format.

Nope, nor a schema. It'd be worth setting it up and say using it in
the jevents.py parser. Perhaps the json format can be the same as the
`perf list -j` json output too.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.h        | 1 +
> >  tools/perf/util/parse-events.c | 2 ++
> >  tools/perf/util/parse-events.h | 1 +
> >  tools/perf/util/parse-events.l | 3 ++-
> >  4 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 43f6fd1dcb4d..bd8e84954e34 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -98,6 +98,7 @@ struct evsel {
> >                 bool                    bpf_counter;
> >                 bool                    use_config_name;
> >                 bool                    skippable;
> > +               bool                    retire_lat;
> >                 int                     bpf_fd;
> >                 struct bpf_object       *bpf_obj;
> >                 struct list_head        config_terms;
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 0f308b4db2b9..9c2a76ec8c99 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1818,6 +1818,8 @@ static int parse_events__modifier_list(struct par=
se_events_state *parse_state,
> >                         evsel->weak_group =3D true;
> >                 if (mod.bpf)
> >                         evsel->bpf_counter =3D true;
> > +               if (mod.retire_lat)
> > +                       evsel->retire_lat =3D true;
> >         }
> >         return 0;
> >  }
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 5695308efab9..eb94d1247dae 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -201,6 +201,7 @@ struct parse_events_modifier {
> >         bool hypervisor : 1;    /* 'h' */
> >         bool guest : 1;         /* 'G' */
> >         bool host : 1;          /* 'H' */
> > +       bool retire_lat : 1;    /* 'R' */
> >  };
> >
> >  int parse_events__modifier_event(struct parse_events_state *parse_stat=
e, void *loc,
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 08ea2d845dc3..85015f080240 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -209,6 +209,7 @@ static int modifiers(struct parse_events_state *par=
se_state, yyscan_t scanner)
> >                 CASE('W', weak);
> >                 CASE('e', exclusive);
> >                 CASE('b', bpf);
> > +               CASE('R', retire_lat);
> >                 default:
> >                         return PE_ERROR;
> >                 }
> > @@ -250,7 +251,7 @@ drv_cfg_term        [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*=
?\.:]+)?
> >   * If you add a modifier you need to update check_modifier().
> >   * Also, the letters in modifier_event must not be in modifier_bp.
> >   */
> > -modifier_event [ukhpPGHSDIWeb]{1,15}
> > +modifier_event [ukhpPGHSDIWebR]{1,16}
> >  modifier_bp    [rwx]{1,3}
> >  lc_type        (L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instr=
uction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branche=
s|bpu|btb|bpc|node)
> >  lc_op_result   (load|loads|read|store|stores|write|prefetch|prefetches=
|speculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
> > --
> > 2.44.0.769.g3c40516874-goog
> >

