Return-Path: <linux-kernel+bounces-145597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117818A5851
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDC0B23124
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261182887;
	Mon, 15 Apr 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tusoZvZb"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BE67A1A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200357; cv=none; b=shNTFMygwfpDTmzhxZIz9JiHgfPGaW7D9oL/CL/rq/lavAo8LzIZbBaXmm/acYzKkAhH6jGI6wfr/kVKS8Vu21TfqGL+rkuZxkT1LtuOkAJT6ryQ0fVf3oNN7B9a5rKJdNGXb76Ai8vA1IpLz+Nc31XBp0diwyp5y1UE3ZFfKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200357; c=relaxed/simple;
	bh=h/VKgYZeWQnV48tMKbUZGNBLB4TAFR12aWgeBSIN/oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=I4QGcbcqNsuw0Uc6btqAfVMTFuvyDKPMRy/Zbee1T00yfpnatAcZyUXT0zFRWmVeHX8N3nhaS/yoJbjvLZJSLT2GP/dKmScn6FTvGfKhqzIQiuR+A3cLp6NHw9rKZ+G2cHqtj+E93heDyizddb6L8ZfLjz6VUG/uSI5sh+jud5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tusoZvZb; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a0c8c5f18so5125ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713200355; x=1713805155; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEib3GfoMjSsGAGLxyonIryZVPQ97O3Yy2s2kSrwbjg=;
        b=tusoZvZbej9Psx4dmuAx+x3Afx0MB4zdp5kXmlkaWeuQZ6PscxC0Ocn3IAXzsTt7Wa
         9DwRPRsFW2b0HCavwtcxTTmlRNVxoxE4LylJjglbS+4ZnULnEYnWBaSwM68O2ujnw6pX
         Qxl1Bzu0mlVm1p/pn/gc7Ch+7lZfcnnLCwaVx7AQdNgyVVQDoqJxEdNf/sKtVO8GgsLH
         Fy/3PQ/TdNApqOQba8um+udBo+fjjONCT3Fmgg1FogDXRZB6E9paUt+LZ87yeZynBkJ4
         NM731VnZpD0kHlZUn14xBHB+qG2rw2Rk3qNA5EqfPiB5X4kWk6j6JxQsz6Xkj0f2Qjt+
         t0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200355; x=1713805155;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEib3GfoMjSsGAGLxyonIryZVPQ97O3Yy2s2kSrwbjg=;
        b=rFXpbkSDG+yHg/hGaP4K2/5SflmAy82TTgImPyyNz5ZZnZgWPZJ7I89Z8l33TDbu5P
         GQ0SaR082jFxngW8g+/wpo8LOlnRWuWPeDNJ0Ehz4yvwAT/bqVVEzSg2EWkgGTtk6nxV
         CCG1ghgRiQoJz73MLWOhM2Vz5EAU7HMI0P++azNKQ/N0ziVuw/JjUqvoMPeLjgELzO0U
         8Hbzi+1nynoxMbfHzy6lLqiXPI1aI9YShx/oLolBB8Q/a4jyuhJo4GmqpMSt5itVwCL9
         SYvLgtRsJBLgBXEe3ntIrdBGy2YBJ4bnelqkaXzW+JAsXnMiHneIHGkrK/rRFET9s4pJ
         tDKg==
X-Forwarded-Encrypted: i=1; AJvYcCVMaeTAbwgXdyX5w/RytuRxR2uiH9LBHkpTPMJkYcpwGbraPUBclfMsFLiAjruzDfmbfXapd5fvQRiMnqsF+VJQztxeDqOnlIQSHyJ5
X-Gm-Message-State: AOJu0Yz7U+XNfC3nOfpFkrqcIjulujFjk76IfRqo5T40mFp6186ICS6I
	hUgzWzAqOy/Ee+x/J2Absq1RAiiFkucePDrQqMQNkzm0PudtDU4a5+2fDNkAHmN0JRWF1puITxm
	XhHKV/hzI4kjyIk0j3yaUjXvl/mPh96gPYwc2
X-Google-Smtp-Source: AGHT+IHk3Q1DJ27BgyWaA1tZ68jUswiQUBjNiPkdLY2pHmnY2/6xbO2ks9X9CrEfiHqM0rpPNqR4Dkwl29fBB23MtN8=
X-Received: by 2002:a05:6e02:591:b0:36a:fcc9:64eb with SMTP id
 c17-20020a056e02059100b0036afcc964ebmr425184ils.5.1713200354212; Mon, 15 Apr
 2024 09:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Apr 2024 09:59:00 -0700
Message-ID: <CAP-5=fWhPTWiRjiUW7vRCetm26fYgOWfHzV4Qig3rSfe-x5VLQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Consistently prefer sysfs/json events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 11:36=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> As discussed in:
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com=
/
> preferring sysfs/json events consistently (with or without a given
> PMU) will enable RISC-V's hope to customize legacy events in the perf
> tool.
>
> Some minor clean-up is performed on the way.

A side-effect of prioritizing sysfs/json events over legacy hardware
events is that the hard coded metric logic in stat-shadow fails:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-shadow.c?h=3Dperf-tools-next#n100
This is because the hard coded metrics assume that legacy events will
be used. Rather than make the hard coded metrics match sysfs/json I
think it is better to remove the hard coded metrics. This is because
the hard coded metrics lack checks on things like grouping that rather
than fix should be transitioned to json metrics. My preference for the
json metrics is to generate them using the python generation scripts
that are out for review.

Thanks,
Ian

> Ian Rogers (9):
>   perf parse-events: Factor out '<event_or_pmu>/.../' parsing
>   perf parse-events: Directly pass PMU to parse_events_add_pmu
>   perf parse-events: Avoid copying an empty list
>   perf pmu: Refactor perf_pmu__match
>   perf tests parse-events: Use branches rather than cache-references
>   perf parse-events: Legacy cache names on all PMUs and lower priority
>   perf parse-events: Handle PE_TERM_HW in name_or_raw
>   perf parse-events: Constify parse_events_add_numeric
>   perf parse-events: Prefer sysfs/json hardware events over legacy
>
>  tools/perf/tests/parse-events.c |   6 +-
>  tools/perf/util/parse-events.c  | 201 ++++++++++++++++++++++----------
>  tools/perf/util/parse-events.h  |  16 +--
>  tools/perf/util/parse-events.l  |  76 ++++++------
>  tools/perf/util/parse-events.y  | 166 +++++++++-----------------
>  tools/perf/util/pmu.c           |  27 +++--
>  tools/perf/util/pmu.h           |   2 +-
>  7 files changed, 262 insertions(+), 232 deletions(-)
>
> --
> 2.44.0.683.g7961c838ac-goog
>

