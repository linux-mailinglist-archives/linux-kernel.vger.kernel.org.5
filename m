Return-Path: <linux-kernel+bounces-138950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C44389FC78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A4F28E48B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE541791FB;
	Wed, 10 Apr 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G55rm0Mp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFA1791E8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765280; cv=none; b=h/MDR7Ovp1/R/JH/F6P9Xffkn36Be9mfGWdvTkmA5eM2fIc0PX7azLK+/thjWCTlYe+30pzKPTzPk19kEbY+4+xmpMjKKeRLaAjBldIBzkBioqpwZn5HYdPAj8J8rOfl/PHMSon1j5Rb4vNaN/wMRcexmT2ZdRsRvgCqBsZgP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765280; c=relaxed/simple;
	bh=O9vyfiYW4qJ4aR4aUCNu5ffJRmKK3JS+Eqhztirud48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TT3Cozil6ne6yKlwZFajtlvMvE16N69z8uIzDBGhGzYQbuiCGVlrMm2ga8qbkXFqETY5fMVHy6EYg1MyIXYmu6NQF+0gv5w+PTQ4RyIYr6p+CJlDJ6oo4sKKLe0F8/Zv23LOzSTCaCdVcHl5NPnQqB6JxehN5JhQyAxT4+UBRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G55rm0Mp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e062f3a47bso176935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712765278; x=1713370078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQntAKieGT0i/s8HiScw2bDeUzaEYfiblRtqNRVHdc4=;
        b=G55rm0MpB+CuWSLQ4HA9r/JG8GQ2mmtobGvRzbxtVwHW6XaU+jfhREkJzBKApFwt3z
         IeiMfaZOWuY8LeJ9rqc/sUCi/nkpm831h7BrnXdOit7EtV8tjxvWIP7LjvPKqxp0uJKw
         mCkyBTmhfJLh+lqBaPwWZQ+4DAsevlyapaGbx57g6FMWS3SuobM6F3QZczsrbODUgROD
         6EMYa8pGYbh7vhT/6n+g7nPUUSBMBXtWHtcv5hM+/w1StyVaLEzL7yte8VwuL1LN5PSA
         AUgBLfyjojBL/nyg/vC3u2a5Uz5Llag/LozY6rpb18zLb7cgS8KI7YzKdP5c+JAXRV6/
         lOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712765278; x=1713370078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQntAKieGT0i/s8HiScw2bDeUzaEYfiblRtqNRVHdc4=;
        b=elsejRUvPxjjWI/uv9vH6PTi1GygOu6VP2L3IcOEBuOUpoJ12R5ZVrDoG6y1SQrVGI
         CduITttjbDWlsFybyzvlqmEcKZitkoqb5mEADSYlbpLL+kkY9tri6rSXeZLrEZkiO5Xi
         QkhqiVpeqzgZYDTytwGvtub2TObUaKofas/Ur1cWzYZzoCPEMUg3LbaPZnuDg5RfWPIt
         c33VHeisD8eNwZiighMp3tcWTKe1b325FjS8CxtmWMIWZ1/+H38CGLVklbzT4cwC8ABO
         HvoYj26W6zHkJIgiRI6rhrA3urjmGV+9OiLK4EtFPKMK3ARL6L+jBI6wY+VozjE+VqPE
         eU1A==
X-Forwarded-Encrypted: i=1; AJvYcCV2I/YlZPQsyxCvXpUpAwdV10EKX9b6CHnQkFJiFimeoHsZAwuCH/Gis66xNAsIJJe6hyLgy/kSzSE/0dov2MpINKgGZZOgCsiOaZm9
X-Gm-Message-State: AOJu0Yw5b5UMBAhSPMdXmkO/I+f1+cdFJZA0KQo6KlMHjfkmPZ3HlllR
	Tv4gR7knb0yZof6ny46YefbiQdogsGgg+GnU/4BDrNS/3IJ3BzhmwqFipsnAPi+eKdjop7i8rdV
	9Ygfx8sUWx5ijEjg+duDhVugsImK6d5r+EXJY
X-Google-Smtp-Source: AGHT+IGJstmEj1XUFY34LSDgFUBaClLQ/9p78uMzbyL2cRc7G5dE+yDawDKh0XUCAv7+t9BJLvl36zI/jgsD4Ixi/Zs=
X-Received: by 2002:a17:902:e842:b0:1e2:3991:9e9 with SMTP id
 t2-20020a170902e84200b001e2399109e9mr261613plg.0.1712765278065; Wed, 10 Apr
 2024 09:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410104450.15602-1-adrian.hunter@intel.com>
In-Reply-To: <20240410104450.15602-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 09:07:42 -0700
Message-ID: <CAP-5=fXw+HEnyiry=6LWhpPcexbNu=CzknNfcjr=MHa78ujkpw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Simplify is_event_supported()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:45=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Simplify is_event_supported by using sys_perf_event_open() directly like
> other perf API probe functions and move it into perf_api_probe.c where
> other perf API probe functions reside.
>
> A side effect is that the probed events do not appear when debug prints
> are enabled, which is beneficial because otherwise they can be confused
> with selected events.
>
> This also affects "Test per-thread recording" in
> "Miscellaneous Intel PT testing" which expects the debug prints of
> only selected events to appear between the debug prints:
> "perf record opening and mmapping events" and
> "perf record done opening and mmapping events"
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

nit:
Closes: https://lore.kernel.org/lkml/ZhVfc5jYLarnGzKa@x1/

> ---
>  tools/perf/util/perf_api_probe.c | 40 +++++++++++++++++++++++++
>  tools/perf/util/perf_api_probe.h |  2 ++
>  tools/perf/util/pmus.c           |  1 +
>  tools/perf/util/print-events.c   | 50 +-------------------------------
>  tools/perf/util/print-events.h   |  1 -
>  5 files changed, 44 insertions(+), 50 deletions(-)
>
> diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_=
probe.c
> index 1de3b69cdf4a..13acb34a4e1c 100644
> --- a/tools/perf/util/perf_api_probe.c
> +++ b/tools/perf/util/perf_api_probe.c
> @@ -195,3 +195,43 @@ bool perf_can_record_cgroup(void)
>  {
>         return perf_probe_api(perf_probe_cgroup);
>  }
> +
> +bool is_event_supported(u8 type, u64 config)
> +{
> +       struct perf_event_attr attr =3D {
> +               .type =3D type,
> +               .config =3D config,
> +               .disabled =3D 1,
> +       };
> +       int fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);

It looks like this is a change to the actual perf_event_open
arguments, I don't think it is an issue but wanted to flag it.

> +
> +       if (fd < 0) {
> +               /*
> +                * The event may fail to open if the paranoid value
> +                * /proc/sys/kernel/perf_event_paranoid is set to 2
> +                * Re-run with exclude_kernel set; we don't do that by
> +                * default as some ARM machines do not support it.
> +                */
> +               attr.exclude_kernel =3D 1;

I worry about the duplicated fallback logic getting out of sync,
perhaps we could have a quiet option for evsel__open option, or better
delineate the particular log entries. I don't really have a good
alternative idea and kind of like that detecting an event is available
loses the evsel baggage. I would kind of like event parsing just to
give 1 or more perf_event_attr for similar reasons.

Assuming there are no better ideas on how to approach this:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +               fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> +       }
> +
> +       if (fd < 0) {
> +               /*
> +                * The event may fail to open if the PMU requires
> +                * exclude_guest to be set (e.g. as the Apple M1 PMU
> +                * requires).
> +                * Re-run with exclude_guest set; we don't do that by
> +                * default as it's equally legitimate for another PMU
> +                * driver to require that exclude_guest is clear.
> +                */
> +               attr.exclude_guest =3D 1;
> +               fd =3D sys_perf_event_open(&attr, 0, -1, -1, 0);
> +       }
> +
> +       if (fd < 0)
> +               return false;
> +
> +       close(fd);
> +       return true;
> +}
> diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_=
probe.h
> index b104168efb15..820f6a03221a 100644
> --- a/tools/perf/util/perf_api_probe.h
> +++ b/tools/perf/util/perf_api_probe.h
> @@ -4,6 +4,7 @@
>  #define __PERF_API_PROBE_H
>
>  #include <stdbool.h>
> +#include <linux/types.h>
>
>  bool perf_can_aux_sample(void);
>  bool perf_can_comm_exec(void);
> @@ -13,5 +14,6 @@ bool perf_can_record_text_poke_events(void);
>  bool perf_can_sample_identifier(void);
>  bool perf_can_record_build_id(void);
>  bool perf_can_record_cgroup(void);
> +bool is_event_supported(u8 type, u64 config);
>
>  #endif // __PERF_API_PROBE_H
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 2fd369e45832..5442442e0508 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -13,6 +13,7 @@
>  #include "cpumap.h"
>  #include "debug.h"
>  #include "evsel.h"
> +#include "perf_api_probe.h"
>  #include "pmus.h"
>  #include "pmu.h"
>  #include "print-events.h"
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index 3f38c27f0157..a25be2b2c774 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -20,6 +20,7 @@
>  #include "evsel.h"
>  #include "metricgroup.h"
>  #include "parse-events.h"
> +#include "perf_api_probe.h"
>  #include "pmu.h"
>  #include "pmus.h"
>  #include "print-events.h"
> @@ -239,55 +240,6 @@ void print_sdt_events(const struct print_callbacks *=
print_cb, void *print_state)
>         strlist__delete(sdtlist);
>  }
>
> -bool is_event_supported(u8 type, u64 config)
> -{
> -       bool ret =3D true;
> -       struct evsel *evsel;
> -       struct perf_event_attr attr =3D {
> -               .type =3D type,
> -               .config =3D config,
> -               .disabled =3D 1,
> -       };
> -       struct perf_thread_map *tmap =3D thread_map__new_by_tid(0);
> -
> -       if (tmap =3D=3D NULL)
> -               return false;
> -
> -       evsel =3D evsel__new(&attr);
> -       if (evsel) {
> -               ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> -
> -               if (!ret) {
> -                       /*
> -                        * The event may fail to open if the paranoid val=
ue
> -                        * /proc/sys/kernel/perf_event_paranoid is set to=
 2
> -                        * Re-run with exclude_kernel set; we don't do th=
at by
> -                        * default as some ARM machines do not support it=
.
> -                        */
> -                       evsel->core.attr.exclude_kernel =3D 1;
> -                       ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> -               }
> -
> -               if (!ret) {
> -                       /*
> -                        * The event may fail to open if the PMU requires
> -                        * exclude_guest to be set (e.g. as the Apple M1 =
PMU
> -                        * requires).
> -                        * Re-run with exclude_guest set; we don't do tha=
t by
> -                        * default as it's equally legitimate for another=
 PMU
> -                        * driver to require that exclude_guest is clear.
> -                        */
> -                       evsel->core.attr.exclude_guest =3D 1;
> -                       ret =3D evsel__open(evsel, NULL, tmap) >=3D 0;
> -               }
> -
> -               evsel__delete(evsel);
> -       }
> -
> -       perf_thread_map__put(tmap);
> -       return ret;
> -}
> -
>  int print_hwcache_events(const struct print_callbacks *print_cb, void *p=
rint_state)
>  {
>         struct perf_pmu *pmu =3D NULL;
> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-event=
s.h
> index bf4290bef0cd..5d241b33b5a3 100644
> --- a/tools/perf/util/print-events.h
> +++ b/tools/perf/util/print-events.h
> @@ -38,6 +38,5 @@ void print_symbol_events(const struct print_callbacks *=
print_cb, void *print_sta
>                          unsigned int max);
>  void print_tool_events(const struct print_callbacks *print_cb, void *pri=
nt_state);
>  void print_tracepoint_events(const struct print_callbacks *print_cb, voi=
d *print_state);
> -bool is_event_supported(u8 type, u64 config);
>
>  #endif /* __PERF_PRINT_EVENTS_H */
> --
> 2.34.1
>

