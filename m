Return-Path: <linux-kernel+bounces-108110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA1880614
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07911F2314F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D13BBD7;
	Tue, 19 Mar 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQVtpJzh"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38F38FA8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880421; cv=none; b=dsxdMPvcD2VGGWRop8RXMOAG8cIZryPZzDPWbRHLmvEGXD8AuQ5fRYrp/LHpVrwm0w7EruqCTcbKCzRKP2oXW3C1xVF+XbxR2m/1pmwQ/wYEoQkb1daqmpm7A42XDVKR8KC1Scd1i5p5633/HEzj+BAAQ6r3coJMOyPaXHBam1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880421; c=relaxed/simple;
	bh=Eok2DGTMs9IQ05hXDYxc0HToH4eXhUzDfxur7FtwE/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJzEBFeFZ90lCB1KkaMIFgFNvOOmbnaIBmeBNakZZERL6iJ4bErZu+UfFa1wbcYcRTq3xLEa0SuxAT43hOvJ0H4HftDV9v+9943pDKOxGejm+ILJHGp+mjlSohnt03Fj0NxGCbphMAk7bVgTtGIYuieaASH77058/GHwxXH+R6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQVtpJzh; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-366abfd7b09so33025ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710880419; x=1711485219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7PpDNpShgz+B/PDR36qmkNusndcc30e4ilE7bZHSuo=;
        b=RQVtpJzhd0g7iDyp2STlM2a+1mir7pn6WJlOV8tKr5IreGlXdYDRlLLVcR1KwOZ3NJ
         oMdmXuLCdJKMdU3eUIvybNaiIwGdfysBWjhcFOpNtL1SJ6uwzGXOBucnYymsJ5H5x74Z
         8rp1rQo/6rsJtsWvaKwGTY4T5kHxJ8bvDJqSMsEtaH7KG1n3LcSdQQQHFiFrx3MwT9yf
         +aHj6p6P81F428UX1PdeZkGEZP5BpR+ZcmeZsHCWmr24iUxb5vIb6AKXpA5K98dezg4o
         DevZrZm2C7Z7I+5yf+8DtBSb8hRtz046IAtzv39tfVqD7TTmyjXxK0gB6Hmcyp+K33FR
         BD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710880419; x=1711485219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7PpDNpShgz+B/PDR36qmkNusndcc30e4ilE7bZHSuo=;
        b=QOw/P9ntljlfwcjlLMNj+UwpaLl7ogSwmEKQlXSQC95tjVuL8XHewcuZYdrnHkCiJs
         laO2ogFxGG/7tRcc+AUEerbIJHE50JBW2ZvNFrr8xTqn0OwQx/jnQqCKxaFWyUu5uApD
         SfysioH52sYYd/vUvI4msO/1K/hVm/OY3nm4jRNfbHvnGbeZeOzJV7lc1thER3POdjlx
         /5dM7dCMk5uSGjVmG3PsqBQr4vH9Md+PEVHQ01ckx6HDEwjTWjBUmVcQgznEpZjVlcEr
         /AZ3ae1OVzSK5uLkznMfUfCLwba3qT3uh4CYln56cqVkwVgPmcJbTxY0KWLz+1F2Fpss
         M62w==
X-Forwarded-Encrypted: i=1; AJvYcCVkWKxUp89v1cFbPSnGraDk/rSBwPGYT1njPZOpJXKkttdoLYA6hP7FJ+qQ3qj2D2NuyA4/KRyZnAWhEbsgGdK78o4ak9d2oc8BoI7X
X-Gm-Message-State: AOJu0YxCjsPxarmXo+Bv9AtaTxr8oBxlUx8LpTINiiTq1noF36u7X4wF
	GbWHRF/EkI2yRoEbFlDZxHby+PMsXhoobQ0FPcl+++O2Eye+zyFgpc6ocoxI9DdT19kqZN6RoNU
	szuxPeQlEGfP586UfFEmD+U3pGD01hCG6wu6h
X-Google-Smtp-Source: AGHT+IGsTVhS/2yhbQDJCUv6iNQsxl/+sTPLGwMubE605DJqqvDFBD6eN/G9bEceIBxeW0iy/i36FAP6lq2oS2NcOgg=
X-Received: by 2002:a05:6e02:219b:b0:363:c7a9:c5a2 with SMTP id
 j27-20020a056e02219b00b00363c7a9c5a2mr71438ila.28.1710880418724; Tue, 19 Mar
 2024 13:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319091429.2056555-1-spring.cxz@gmail.com>
In-Reply-To: <20240319091429.2056555-1-spring.cxz@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 13:33:24 -0700
Message-ID: <CAP-5=fWD3bmeDoG626gds_R85JrWEAKrd_6hau6LfZXGnD=_NQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf evlist: Fix 'perf record -C xx' failed issue
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, yangchen11@lixiang.com, 
	zhouchunhua@lixiang.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zangchunxin@lixiang.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:14=E2=80=AFAM Chunxin Zang <spring.cxz@gmail.com>=
 wrote:
>
> The cpu has 8 performance-cores and 8 efficient-cores on my pc.
> 0-15 are performance-cores
> 16-23 are 8 efficient-cores
>
> When I run "perf record -C xxx", the command fails if xxx all belong to
> performance cores or efficient cores
>
> The results are as follows
>
>   # perf record -C 12
>   WARNING: A requested CPU in '12' is not supported by PMU 'cpu_atom' (CP=
Us 16-23) for event 'cycles:P'
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) f=
or event (cpu_atom/cycles:P/).
>   /bin/dmesg | grep -i perf may provide additional information.
>
>   # perf record -C 14-17
>   WARNING: A requested CPU in '14-17' is not supported by PMU 'cpu_atom' =
(CPUs 16-23) for event 'cycles:P'
>   WARNING: A requested CPU in '14-17' is not supported by PMU 'cpu_core' =
(CPUs 0-15) for event 'cycles:P'
>   ^C[ perf record: Woken up 1 times to write data ]
>
> The reason is that the cpu_map of 'cpu_atom'-evsel is empty, causing
> the sys_perf_event_open() result to fail.
>
> Changes in v2:
> - fix memory leak about 'intersect'
>
> Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
> ---
>  tools/perf/util/evlist.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 55a300a0977b..babbde29341f 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2499,7 +2499,7 @@ void evlist__check_mem_load_aux(struct evlist *evli=
st)
>  void evlist__warn_user_requested_cpus(struct evlist *evlist, const char =
*cpu_list)
>  {
>         struct perf_cpu_map *user_requested_cpus;
> -       struct evsel *pos;
> +       struct evsel *pos, *tmp;
>
>         if (!cpu_list)
>                 return;
> @@ -2508,18 +2508,28 @@ void evlist__warn_user_requested_cpus(struct evli=
st *evlist, const char *cpu_lis
>         if (!user_requested_cpus)
>                 return;
>
> -       evlist__for_each_entry(evlist, pos) {
> +       evlist__for_each_entry_safe(evlist, tmp, pos) {
>                 struct perf_cpu_map *intersect, *to_test;
>                 const struct perf_pmu *pmu =3D evsel__find_pmu(pos);
>
>                 to_test =3D pmu && pmu->is_core ? pmu->cpus : cpu_map__on=
line();

Perhaps this would be clearer if we just made sure requested uncore
CPUs were online. Uncore cpu maps are weird, they say the default CPU
but other CPUs are valid. It'd be worth testing the impact of this
change on uncore events.

>                 intersect =3D perf_cpu_map__intersect(to_test, user_reque=
sted_cpus);
> -               if (!perf_cpu_map__equal(intersect, user_requested_cpus))=
 {
> -                       char buf[128];
> +               if (!intersect) {
> +                       evlist__remove(evlist, pos);
> +                       evsel__delete(pos);
> +                       perf_cpu_map__put(intersect);

evlist__warn_user_requested_cpus seems like a wrong function name if
evsels are being removed. Perhaps something like
evlist__remove_empty_cpu_map_evsels. It seems this change will remove
warnings in cases like:

$ perf record cpu_atom/cycles/ -C 0 ...

I wonder that we need a flag in the evsel to say when an event comes
from wildcard expansion so we only don't warn/remove in that case.

Wrt memory leaks, try compiling with EXTRA_CFLAGS=3D"-fsanitize=3Daddress"
which also incorporates leak sanitizer.

Thanks,
Ian

> +                       continue;
> +               }
> +
> +               if (!perf_cpu_map__is_subset(user_requested_cpus, interse=
ct)) {
> +                       char buf_test[128];
> +                       char buf_intersect[128];
>
> -                       cpu_map__snprint(to_test, buf, sizeof(buf));
> -                       pr_warning("WARNING: A requested CPU in '%s' is n=
ot supported by PMU '%s' (CPUs %s) for event '%s'\n",
> -                               cpu_list, pmu ? pmu->name : "cpu", buf, e=
vsel__name(pos));
> +                       cpu_map__snprint(to_test, buf_test, sizeof(buf_te=
st));
> +                       cpu_map__snprint(intersect, buf_intersect, sizeof=
(buf_intersect));
> +                       pr_warning("WARNING: A requested CPU '%s' in '%s'=
 is not supported by "
> +                                  "PMU '%s' (CPUs %s) for event '%s'\n",=
 buf_intersect, cpu_list,
> +                                  pmu ? pmu->name : "cpu", buf_test, evs=
el__name(pos));
>                 }
>                 perf_cpu_map__put(intersect);
>         }
> --
> 2.34.1
>

