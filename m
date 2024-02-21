Return-Path: <linux-kernel+bounces-74183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77485D0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF151C225E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30773A1DD;
	Wed, 21 Feb 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4KxbSolZ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872039FF5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499175; cv=none; b=H5hm6711b8b5ZbDnnavJGGuDeGRcF2NYLYQENbbD+Yi96kivfwhlTxxPfcADtOOHdtqZ1HAaWeOJ71md3RSBrkiL9F8ZgSRfVboZ386ZQvTNW6xPTcAmzzvkQKoKl/ZlrHtp1BoRdLJav0F66jixFKQR79ZfP9YaraD0XoW4yxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499175; c=relaxed/simple;
	bh=ucw1oB/aDQazlCOmBtmTSnqnpwL1CdVmsF+2tTqZ0rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BergTVz5ZWSJBQccu/uerSEerzv5sPAvUqAGy4uAiyOG5dFsx1OottCGrrOCUnBltVUOmmZUaz5QDPcLjTtqrSs8h0Dinpdph40WQKPsGMaPPkePZ/tIpy7kFMqHVZdThK59O/K0IA7nzn8JxLELeUlvmQA1HtTg5HIjsohjcnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4KxbSolZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5ce88b51cso114475ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499173; x=1709103973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnQ/n92FxcTsGaUbm/14SxL77HTAOChffs/GZeezlI0=;
        b=4KxbSolZ0Wlls8vzYcEsTbS9dS7FCFJOICxchKUBb3CX8MIryLyqNElKzkguY3D7Hr
         5yBIRCLKhRq/3VKB+feoZ50CeypwwbH+F+YB3GmubIhXvlEVf0ZMjhIAO8SFdUurFcE/
         C3+fZBzcyM6MArZMhCAa530hXeNWnRsJfx1xTO63PcV2YJgCQ3KzlWVQPijQ9ZuFSEJT
         Bnw3bA2uEtUfBbhPgGkPL6iFXNhYjbtlYHCtRFB0GglJHMe7PI293EYbNvfCf6IsP7fW
         WP0CW21K0zzgeluDJYVxzg9LKO7UeNKIf4A3EARhPwm+4HPBMilJah10ISKI8pGcJ0Cx
         gbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499173; x=1709103973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnQ/n92FxcTsGaUbm/14SxL77HTAOChffs/GZeezlI0=;
        b=aa78kMlYSgP/eXoAkl4Kl1KQt36DIXW6vhk8pgymR7X8DxtFgKuXQ1ZRie4GOZjnRk
         AZqdogoev8JaNB2SIecEGf3Ar5wI7vCRK6QCgAoS4upKafmso6BPL63x26MDbSWN/zYA
         EcRZQMz6YP+r7wGiukDVbOpUSiYDSdb9zo/0pyoJ8P6eIG54kAy7pV69SQg0GOhZvrSe
         uXED8lShXudRF8UvJtpfC+7SESyaze0Dk7ZBHtGLKp1Gwx0wMaWKWe4C2vVL3KK7ZrsV
         9R9tAaAdhYFFhAtt6agQopTsrxF33lOWtoTc+UflY4y73Nng/SUMvUEcxj1R0Ze9HCCi
         J5QA==
X-Forwarded-Encrypted: i=1; AJvYcCWwwvm0mHXPg/M6Ar4EHmeeyo48HLjOFvLXqGGFVZqH/e7W2OrZJnDa7lfzFf7klZoqSZojP5NdDjQZpb3kxZFDzpOrujD5MH+rALrw
X-Gm-Message-State: AOJu0YwvXG524sfAo27o1bYCaiAaBXkf174he98W3PAwGmzJP3nj/dvZ
	jbJ84wKwJSTGDDwNryUXvoYEaccXe8Rj4NUdrVrR8B4qum/M9xygkP1/b2xfOWRDY9zgkvp19ZM
	IKUGAx2ia64GREQ+oFfbI0DrcqEA6RzfEfDer
X-Google-Smtp-Source: AGHT+IHFPPu+DxhW/aPfe190vFcQ4Hq7lMas2sRvqOn6GQiiqPZEqapARvFjGyGPHlzY9QX4x3T07OWnp+pQJp1oAyQ=
X-Received: by 2002:a17:902:c703:b0:1d9:310c:73be with SMTP id
 p3-20020a170902c70300b001d9310c73bemr109614plp.13.1708499172680; Tue, 20 Feb
 2024 23:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221064527.4157979-1-irogers@google.com> <20240221064527.4157979-3-irogers@google.com>
In-Reply-To: <20240221064527.4157979-3-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Feb 2024 23:05:59 -0800
Message-ID: <CAP-5=fVoCtm5LoPhtuazZvVFDb74n5kZ+tmUM4XdP1D856kykg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf stat: Fix metric-only aggregation index
 1;115;0c Aggregation index was being computed using the evsel's cpumap which
 may have a different (typically the same or fewer) entries.
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, subject got messed up. Will resend.

Thanks,
Ian

On Tue, Feb 20, 2024 at 10:45=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Before:
> ```
> $ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>        MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  me=
mory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_to=
tal MB/s  memory_bandwidth_total
> CPU0                            12.8                           0.0       =
                   12.9                          12.7                      =
     0.0                          12.6
> CPU1
>
>        1.007806367 seconds time elapsed
> ```
>
> After:
> ```
> $ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>        MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  me=
mory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_to=
tal MB/s  memory_bandwidth_total
> CPU0                            15.4                           0.0       =
                   15.3                          15.0                      =
     0.0                          14.9
> CPU18                            0.0                           0.0       =
                   13.5                           5.2                      =
     0.0                          11.9
>
>        1.007858736 seconds time elapsed
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>                           =
       |
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index ae37395f90c0..bfc1d705f437 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1137,11 +1137,16 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
>                         u64 ena, run, val;
>                         double uval;
>                         struct perf_stat_evsel *ps =3D counter->stats;
> -                       int aggr_idx =3D perf_cpu_map__idx(evsel__cpus(co=
unter), cpu);
> +                       int aggr_idx =3D 0;
>
> -                       if (aggr_idx < 0)
> +                       if (!perf_cpu_map__has(evsel__cpus(counter), cpu)=
)
>                                 continue;
>
> +                       cpu_aggr_map__for_each_idx(aggr_idx, config->aggr=
_map) {
> +                               if (config->aggr_map->map[aggr_idx].cpu.c=
pu =3D=3D cpu.cpu)
> +                                       break;
> +                       }
> +
>                         os->evsel =3D counter;
>                         os->id =3D aggr_cpu_id__cpu(cpu, /*data=3D*/NULL)=
;
>                         if (first) {
> --
> 2.44.0.rc1.240.g4c46232300-goog
>

