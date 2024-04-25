Return-Path: <linux-kernel+bounces-159330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4718B2D35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675E31C2145A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B074156675;
	Thu, 25 Apr 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zqcNn8Wb"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CF156228
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084906; cv=none; b=g5QwsqTPpFmncs+emwfM4uk0OtKJZWAQ7jWno2GrNQ+tDPuO1B3opnyPEx74mvG0icrtfI9Ntmw4+QcNk3mCFTIb6adtHawTBHivjvCZMJUI7h2D0XzHQef7Knhw3FMXk/X/JiWQSNxhKmXnjbQDWOlU5AWgsy7BE25o61JtHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084906; c=relaxed/simple;
	bh=oxGSOLNPdfHpQYTSm/hGakG/iwIzMGgaLkQImWnGLjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Dwhin9fWI3i6pYmH3N0D05AnxUJQmdnjAj+jSDgMugit83QkpPAIeldpFJYEpj6tRDMMnNPFS1JNf6zSYDm7TlpRivbPHqAtl++ujtC+gwUBxw9W+BfQEhmCxM0oD+waWSlmclMe8vp9+suOHQ382DZldqmy+YRGJElPbfJKv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zqcNn8Wb; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36b3738f01cso37575ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714084904; x=1714689704; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72dpbNrttk8py6uXjyBWtA37O8ks8mKcpQBV78r/mRQ=;
        b=zqcNn8WbgapFYp7OIbXfY00lWEoDjKCVlbSWbb9/WuFhZRa0tN6H1/MkPM5c7MZYHH
         VAA+rUAt3PmkyfG8AqM0AwYX12C3XoE/2StZLpKPNHKi6mQKxN/hgADPyV1b5nAPm0R4
         kmPK2Q+c0gmby9u3pDfOT5ROzIdev7YWeAOIc4WdN6KbQu39vgxe2nvPsnhDr1O/XB0J
         M5Rd7619QLCSsXblAhx2X4WwTIBI7I8MXOHVSWr80BZK5vhV2C7c8Pf3A4RvbkpwXB4T
         2Y40GqBT3Q0gNCUZaWDprPPYCS1xVLV/ByST4oweDN8XJzxiYQ3Mw8bTpoCIAe0tQ+D2
         ggYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084904; x=1714689704;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72dpbNrttk8py6uXjyBWtA37O8ks8mKcpQBV78r/mRQ=;
        b=s0zPGB/bg9LtN4KqFuglOxKRXlunTRW0+87PLaQA6kAVmZL4lB1RKMVWKHwgETZHUL
         +OMYqual/cMAu5xq9IvXnCLIfYFi1jzAyMSvSOPYD4F2otRMpem21o32hYXAvIekBflV
         bx+JKQGzand9jiGIulHgRTa4cKhrNvi/lSO5ONyK3xFedL5ZIzEH3QHuBXMl5Fycvh1I
         V/jHAxtAthnWzL9zPnhw8ttH+GZJO7jPxpLzOLHeN5GdcU7erVpSqLcjeg0uhJYkDGWI
         1gPULXhIedUh59sd8ZvuwS/tIdTE+TH8JJsFF8GcsLqLxP+NuqbdMzkRiRYwROw+5Vu7
         TR4w==
X-Forwarded-Encrypted: i=1; AJvYcCVyHMete/oSewo2mm2/YBtAvIGhWpfZZGBjvhoVOgdY+DW69I1zEtKViJ1AMlWUA4ifKK25Mc6hwiMt0AOfwXBl5WPpCN6cSbnuSGSq
X-Gm-Message-State: AOJu0YxxPZMcVCwRio8ckI2M4YxZ/NgYTxX+bdWzCZXjNS1Hfa86OxFS
	chufpNKVKTIbKUKrBJPQTEFb9/dGQe/8beVz5MwM+l3d95Amm2174ylyNe6s1BmfVvRuVmQuQ75
	xxk4eHL8hxfFyMiIgYvi64wTa9yH2Cb7kCNw4
X-Google-Smtp-Source: AGHT+IHO5QqtzXcXeR2dvYokk9K4IIju2HkHxTqgaAiF7cgesnW2Bl6zjmMWkLdEddMASLs6OyUmdiVOsQlsZKcWDhc=
X-Received: by 2002:a05:6e02:dee:b0:36c:19db:c567 with SMTP id
 m14-20020a056e020dee00b0036c19dbc567mr60918ilj.26.1714084904313; Thu, 25 Apr
 2024 15:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425223406.471120-1-irogers@google.com>
In-Reply-To: <20240425223406.471120-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Apr 2024 15:41:30 -0700
Message-ID: <CAP-5=fWryq6-W35ZyP4PAHJoJSA_7d2YV7zTG3vuL+WGa=_Mmw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Retirement latency perf stat support
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:34=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Support 'R' as a retirement latency modifier on events. When present
> the evsel will fork perf record and perf report commands, parsing the
> perf report output as the count value. The intent is to do something
> similar to Weilin's series:
> https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.c=
om/
>
> While the 'R' and the retirement latency are Intel specific, in the
> future I can imagine more evsel like commands that require child
> processes. We can make the logic more generic at that point.
>
> The code is untested on hardware that supports retirement latency, and
> with metrics with retirement latency in them. The record is also of
> sleep and various things need tweaking but I think v1 is good enough
> for people to give input.
>
> The first patch stops opening a dummy event for tool events. I came
> across this while looking into the issue and we can likely just pick
> it first. I kept it in the series for cleanliness sake.
>
> The code has benefitted greatly from Weilin's work and Namhyung's
> great review input.

I forgot to mention this is based on the tmp.perf-tools-next branch
due to the recent parse events clean ups that have already landed
there:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/lo=
g/?h=3Dtmp.perf-tools-next

Thanks,
Ian

> Ian Rogers (3):
>   perf evsel: Don't open tool events
>   perf parse-events: Add a retirement latency modifier
>   perf evsel: Add retirement latency event support
>
>  tools/perf/util/evsel.c        | 186 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/evsel.h        |   4 +
>  tools/perf/util/parse-events.c |   2 +
>  tools/perf/util/parse-events.h |   1 +
>  tools/perf/util/parse-events.l |   3 +-
>  5 files changed, 192 insertions(+), 4 deletions(-)
>
> --
> 2.44.0.769.g3c40516874-goog
>

