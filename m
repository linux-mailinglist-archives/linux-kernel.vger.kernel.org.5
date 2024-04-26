Return-Path: <linux-kernel+bounces-160500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D38B3E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD8A281028
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6315D5A2;
	Fri, 26 Apr 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tfQSsGok"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E9614AD38
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152895; cv=none; b=GzgQuuTOqZeLEpzw6FNAHWN3EBduCVFqDR8OH0d9y1ssje+7vg5rQj8NkcneHB5yovckeMXUhoJ3PouR4sA7kvAsl1NKI6tTW7pfaZ4FHSvFWC3xocddNxUdj0lUzBGXa6tU67NYLpiSqSoF0ipOyqESk4c9mdn4saKyNuTuc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152895; c=relaxed/simple;
	bh=M7MCq3gs44Cfubxbn7R+zLW7YEL4ySsQodTHkHwiDB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urN4NUWk+ocfhR0xHehJnQDUbz36pVLNoKa4fQ/XiOIlwG9csdaXZ9HbT4lpnZVdT6Ijkjnmr7kV1zTO0chujIURiayVTg0VZC3iSpzEyQ8gBAs+oXvAYEFBHzYV1aIAk+pa4DQbSqKRglW9uYDLJ2IqoP1mUnIuPo7MAlacSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfQSsGok; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c3a731125so7165ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714152893; x=1714757693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwnxU0oF0334HTgx3GEo/litvzvaDeyp1NlSPNJ3+zo=;
        b=tfQSsGokwk9ESMY7pq8gVIHG3tzUiDG9nPsukTPc2402FEsEs+RF16lze96h887mei
         imcbbtj6tcW/mTF2Eq+TfgcsRKP3xoxzGXhkPOX79LYJXDJebngzfzich0enX+xgh3Bc
         JSjPH/oSe53z3D1nOaDHRz+SDtI9pWuOQ3JPMtfAFvmHLlMDL1dHN8heOCnKv6SRoZZL
         b/Y7VctjD3cvcmHoFGvOWu/ONM9QisH8dZyBG4Ldip//yOLjiKMADOtH/dhOkozR3ijy
         AzoOhRIbGNL3CbLKoTnW+Y2pFAm866K709I0fv1TLxzyXCaotBFinlFFBziguy3LVgPd
         wlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152893; x=1714757693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwnxU0oF0334HTgx3GEo/litvzvaDeyp1NlSPNJ3+zo=;
        b=Otq80rLOMoC60p8vNspy/olRYFdlaT6crhjSunVgUKF/Zoh/mCQTdLHpJ7KB9Ni7DL
         4M8DAqRQMGQgxbr9h5tEfnTE2jf/uql+3fm1K9KWdKG2VjlW1hmyfSVu+ZYWqpYlrkR3
         MYZ0/8Qnso7N0swR5rmQcriw7pjR4nnv5uZG4W2NJMFrY9Do5zVVK1hJQFX69QCIS6qg
         U7q4h1VcP8UW6YqjBzvFiObw/HyluYWHsu2bGEJK36a1ctWZEtA2gblindZmU/TorTWj
         lLc4RcP/kMDP0Rkuj1qaoiNOvBOqbLcPjqAPj/4qDvn8KFs4GcS4h73PfFzw9hAJSXjD
         uf7A==
X-Forwarded-Encrypted: i=1; AJvYcCXgW2yFxcAdxrftx1qtYsfC27TfJOaktz5CJIrC+fSdc/G+qv7LZeHNbJ2eTR9Wq7PhHTeHMXkGxVZ6rBYQ/3mJ84n8DmA2SB+YufOl
X-Gm-Message-State: AOJu0YymCL3eDZ5GUTpeRfs1sOcIWp4vgq0dSIj4VUMrDN4vbYj1iVhg
	PavlIEf9IIcV6qUEOMjk7bCws20FB4eLPvHfT0piC9hVlJJf/JWsPWNb212jjGYtLXoviz60xYl
	EK0UyXIz7LrHtTsreMTR2eNIcC6rj05dNT8TU
X-Google-Smtp-Source: AGHT+IEWKMoGOp9KyRycHyqFobnSOhK4XS18mXMmynUmz8BwO2R+xHvsiU9+bs53UbGjif/7zWdDZqlTXlEY+yg4K5s=
X-Received: by 2002:a05:6e02:13e1:b0:36b:902:71ec with SMTP id
 w1-20020a056e0213e100b0036b090271ecmr1670ilj.8.1714152892896; Fri, 26 Apr
 2024 10:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425223406.471120-1-irogers@google.com> <53dfaeae-b4eb-479e-938f-d0022c4f2416@linux.intel.com>
In-Reply-To: <53dfaeae-b4eb-479e-938f-d0022c4f2416@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Apr 2024 10:34:39 -0700
Message-ID: <CAP-5=fX520Nvd7V_UNDn5yQV-o0-ADYNe7XqdjHUmRVtEC_5tw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Retirement latency perf stat support
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:22=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
> On 2024-04-25 6:34 p.m., Ian Rogers wrote:
> > Support 'R' as a retirement latency modifier on events. When present
> > the evsel will fork perf record and perf report commands, parsing the
> > perf report output as the count value. The intent is to do something
> > similar to Weilin's series:
> > https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel=
com/
> >
> > While the 'R' and the retirement latency are Intel specific, in the
> > future I can imagine more evsel like commands that require child
> > processes. We can make the logic more generic at that point.
> >
>
> I think in generic what we want is the weight/latency information of the
> event. 'W' is already occupied by the weak group. Maybe 'L' is a more
> generic name than 'R'. With the event modifier, perf collects and report
> the weight/latency information of the event in a perf stat command.
>
> Not just changing the evsel, I think a proper output is still required.
> It's possible that an end user can use it without metrics. E.g.,
> perf stat -e cycles,instructions:L
> A possible generic output maybe
>
> 1,931,099,931   cycles
>   801,826,458   instructions    # Avg Weight1 1000
>                                 # Avg Weight2 800
>                                 # Avg Weight3 500

I think this is good but we need to work toward it. This change is
opening a separate perf record per CPU, we should really open one perf
record and then read each counter separately in the perf report
output. We shouldn't really fork a perf record, we should gather
multiple weights, and so on.. There isn't a notion in the current
counts abstraction that you have multiple counts, and that will need
feeding through into all the aggregation code.

Thanks,
Ian

> Thanks,
> Kan
>
> > The code is untested on hardware that supports retirement latency, and
> > with metrics with retirement latency in them. The record is also of
> > sleep and various things need tweaking but I think v1 is good enough
> > for people to give input.
> >
> > The first patch stops opening a dummy event for tool events. I came
> > across this while looking into the issue and we can likely just pick
> > it first. I kept it in the series for cleanliness sake.
> >
> > The code has benefitted greatly from Weilin's work and Namhyung's
> > great review input.
> >
> > Ian Rogers (3):
> >   perf evsel: Don't open tool events
> >   perf parse-events: Add a retirement latency modifier
> >   perf evsel: Add retirement latency event support
> >
> >  tools/perf/util/evsel.c        | 186 ++++++++++++++++++++++++++++++++-
> >  tools/perf/util/evsel.h        |   4 +
> >  tools/perf/util/parse-events.c |   2 +
> >  tools/perf/util/parse-events.h |   1 +
> >  tools/perf/util/parse-events.l |   3 +-
> >  5 files changed, 192 insertions(+), 4 deletions(-)
> >

