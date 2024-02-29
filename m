Return-Path: <linux-kernel+bounces-87596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283B86D652
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988C92894E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CCF6D518;
	Thu, 29 Feb 2024 21:46:10 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5D6D501;
	Thu, 29 Feb 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243170; cv=none; b=CRLHDx17/EG9DPIC7ZFBee7fu4JxQVgUlOsvqZloDoBNu1esKRT6mdc+xpwtolBhlaLIPV5/TTjjvlWG4px7CR/HL2AV4VLSE1RB55bzb10zG04YQKPv0r+t4jTOmLflQBSgj9XE63sIXhzlLQjUtqHyVEpihleVAf3qduazwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243170; c=relaxed/simple;
	bh=TBV7p/A9ZyHEDsiJkjjc53X01jTLQ40txA1U2ZF54Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXcp5jQxaLq1BVzhdPfDRMHPjWzCRI+zt3xenP7ZrTreLNqd/mIUZElmGEK4oM0vPyK77ZpPTJTF4PJiPYi7KlaEKSEffhy5dL1sxdytxjZwbYE18K/o+UflQOIsMas7UJ+/aamedWAFBrtho0aDD03cwPXLzRTCLmlIG+qVyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so1041715a91.3;
        Thu, 29 Feb 2024 13:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709243168; x=1709847968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfW4L51998L0TyuxV9PTpRygcmWU5mrA12noE0Cj0WQ=;
        b=nnSVOxOasuLmjL0znTZC7O6FpZmc76Wv1XzGfF48dCIdspys0erA5ku7X4i+vyESgR
         z3CsV+rC2KgAnGh73d8QbC9Uu5YPLqT5M9Zx6c+uXCeKdCU7zh5dHUReFbzY8H+lCSiG
         AK7qSf+SvQLdiwT2PdeRJy2PLT1R8XQi3jy5f3/uLtAEBIzGHb7aa45/oSu9ERkuydKZ
         93DggwuqsHwNr3FzOsVlAH3W67qNWvuHtsJzA9DWTYc8GuTFWmMXuYA1HKSdEhHpSOuN
         onuH+bSiLdJSd4Da6glP6Bb9ZlEacJaljM5orMfNGpvdz5tWIuJ7Y2A9bxYhGpo0pR8b
         36+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrbEpxXCSPO7yVidpUgrUfadT9eYzor+K2BN4GjtukWmkWUFD2XaY5juo0hbNKslDPdVvrP0I4Q2zetQzDhf+Fa5ID3JIbw9+BJ+bR9E1GANCcl5/P1gwx/kua7tAw+gqTlx4qzdSUpK+Jm2EgiQ==
X-Gm-Message-State: AOJu0Yy/HRkGHpJOk6ENK2LwNkyUG+NmZCLE9E6SBkaBTnpUDQ3bQB10
	8Qljc27Xy2uJJI20fRSMITqsmsDXmUvwtvlWZF8YMZnymAvl1L2c5boqMY8ayElhs53Uz9HJGuH
	TVAKXVAUBaQutKyJOPy9vOEIcBbA=
X-Google-Smtp-Source: AGHT+IGQQY+PNZqNy5SmeBd/wFkrNpFy/J39DvnWrygEt+Xrua7aIMppiLuKjugwfCdpUZ2aa1hJchliX0OOFCfzEDw=
X-Received: by 2002:a17:90a:3d05:b0:29b:f79:2b75 with SMTP id
 h5-20020a17090a3d0500b0029b0f792b75mr346296pjc.7.1709243167868; Thu, 29 Feb
 2024 13:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229070757.796244-1-irogers@google.com>
In-Reply-To: <20240229070757.796244-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 29 Feb 2024 13:45:56 -0800
Message-ID: <CAM9d7chNekmdJyPbOOzZVhR+cBWajscSg3pVFKN4A4evKwFXjg@mail.gmail.com>
Subject: Re: [PATCH v1] libperf evlist: Avoid out-of-bounds access
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:08=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Parallel testing appears to show a race between allocating and setting
> evsel ids. As there is a bounds check on the xyarray it yields a segv
> like:
>
> ```
> AddressSanitizer:DEADLYSIGNAL
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> =3D=3D484408=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000=
00000010
>
> =3D=3D484408=3D=3DThe signal is caused by a WRITE memory access.
>
> =3D=3D484408=3D=3DHint: address points to the zero page.
>
>     #0 0x55cef5d4eff4 in perf_evlist__id_hash tools/lib/perf/evlist.c:256
>     #1 0x55cef5d4f132 in perf_evlist__id_add tools/lib/perf/evlist.c:274
>     #2 0x55cef5d4f545 in perf_evlist__id_add_fd tools/lib/perf/evlist.c:3=
15
>     #3 0x55cef5a1923f in store_evsel_ids util/evsel.c:3130
>     #4 0x55cef5a19400 in evsel__store_ids util/evsel.c:3147
>     #5 0x55cef5888204 in __run_perf_stat tools/perf/builtin-stat.c:832
>     #6 0x55cef5888c06 in run_perf_stat tools/perf/builtin-stat.c:960
>     #7 0x55cef58932db in cmd_stat tools/perf/builtin-stat.c:2878
> ...
> ```
>
> Avoid this crash by early exiting the perf_evlist__id_add_fd and
> perf_evlist__id_add is the access is out-of-bounds.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

While I'm ok with this change, the real fix would be changing
evsel_store__ids() to use xyarray__max_{x,y} for fd instead
of cpu and thread map numbers.

Thanks,
Namhyung

> ---
>  tools/lib/perf/evlist.c                  | 18 ++++++++++++------
>  tools/lib/perf/include/internal/evlist.h |  4 ++--
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 058e3ff10f9b..c6d67fc9e57e 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -248,10 +248,10 @@ u64 perf_evlist__read_format(struct perf_evlist *ev=
list)
>
>  static void perf_evlist__id_hash(struct perf_evlist *evlist,
>                                  struct perf_evsel *evsel,
> -                                int cpu, int thread, u64 id)
> +                                int cpu_map_idx, int thread, u64 id)
>  {
>         int hash;
> -       struct perf_sample_id *sid =3D SID(evsel, cpu, thread);
> +       struct perf_sample_id *sid =3D SID(evsel, cpu_map_idx, thread);
>
>         sid->id =3D id;
>         sid->evsel =3D evsel;
> @@ -269,21 +269,27 @@ void perf_evlist__reset_id_hash(struct perf_evlist =
*evlist)
>
>  void perf_evlist__id_add(struct perf_evlist *evlist,
>                          struct perf_evsel *evsel,
> -                        int cpu, int thread, u64 id)
> +                        int cpu_map_idx, int thread, u64 id)
>  {
> -       perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
> +       if (!SID(evsel, cpu_map_idx, thread))
> +               return;
> +
> +       perf_evlist__id_hash(evlist, evsel, cpu_map_idx, thread, id);
>         evsel->id[evsel->ids++] =3D id;
>  }
>
>  int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>                            struct perf_evsel *evsel,
> -                          int cpu, int thread, int fd)
> +                          int cpu_map_idx, int thread, int fd)
>  {
>         u64 read_data[4] =3D { 0, };
>         int id_idx =3D 1; /* The first entry is the counter value */
>         u64 id;
>         int ret;
>
> +       if (!SID(evsel, cpu_map_idx, thread))
> +               return -1;
> +
>         ret =3D ioctl(fd, PERF_EVENT_IOC_ID, &id);
>         if (!ret)
>                 goto add;
> @@ -312,7 +318,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist=
,
>         id =3D read_data[id_idx];
>
>  add:
> -       perf_evlist__id_add(evlist, evsel, cpu, thread, id);
> +       perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
>         return 0;
>  }
>
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/in=
clude/internal/evlist.h
> index d86ffe8ed483..f43bdb9b6227 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -126,11 +126,11 @@ u64 perf_evlist__read_format(struct perf_evlist *ev=
list);
>
>  void perf_evlist__id_add(struct perf_evlist *evlist,
>                          struct perf_evsel *evsel,
> -                        int cpu, int thread, u64 id);
> +                        int cpu_map_idx, int thread, u64 id);
>
>  int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>                            struct perf_evsel *evsel,
> -                          int cpu, int thread, int fd);
> +                          int cpu_map_idx, int thread, int fd);
>
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>

