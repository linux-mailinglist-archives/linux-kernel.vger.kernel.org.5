Return-Path: <linux-kernel+bounces-123494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27619890982
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15181F221BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFF1384B6;
	Thu, 28 Mar 2024 19:43:38 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D21EA6E;
	Thu, 28 Mar 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655018; cv=none; b=spP/LjrZDdU/EkFE3/VxeEqnUjQ2pBHC6XFKh52O8HeFVjIypwBJp8GC/oPGs1IUJ84uvGWrObn39p7GKXxfYy+5QkiYFzGwqBRr833oZC/xfFXN1Klo1euFFkX86NgqICvxOKf4T8Qah9F+QNTdqZOWQo/WW3u3lrj3e9lzJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655018; c=relaxed/simple;
	bh=wVbolrjWZzz2tt9Oifs/rvTBBYKri0+NsQlX4e5KS64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxS4VS3onFpP6wwIxj9oOFHPZW9jR0M/YKZr3zQaHLFi8XTJ2BpdoNX/NGud+XT1PL847oEKFfs9Xq6d5oHyP4ZZnrX22evNztmLiNPhfcxitzVdvm2EwaPTs2FiUjyGRC1adZp4aip8D5GUVSGo5bhMlmwAoGdBOsKkNvLssiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0f3052145so13364085ad.2;
        Thu, 28 Mar 2024 12:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655016; x=1712259816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RcH3WlR5p8M951HGkZcZ60zaN5AVgReTZhMk/mJonw=;
        b=wFEUHmS+/e4EveWBMRBTw86/7VrDBsPvZCOdk9Yfr0lWBK8eGxRXTvp3Vk24wdhRuW
         0L+RkWS1BTaCq8Vc10ZyT+2N0c7K24a4FdalpCd5JdHT+rBbQpLLsIqBVnApU6H8ezGS
         g35QIwJ8R6zo1EB02ZGFvBReccfXOAqXBmssqgD+BhOUpY9TglED1pvachEUrjW6/xsc
         6I7QpAxs8fMTJo2bYurq+dRJPoMUsVNwmgdIF0DlC0XssNJuvUexyqldzmakIa9fJgIt
         +vYLPgBZAEOko9oZqiceTXD5Ay2TPGjKT96q2bTWTXMs1H7d+/WBwBbzVGE13TFCVK8E
         SkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn5MC+lRcJjFqSHNCSlHlhWWgBKsdr/D9f5Q4e6geNCsXLoUzT+nvsOgO5DxJZwSVipM83qALtb75ttK//Zymht0o4fe4tPUcCuUJ2/4y15J0RWVe6SvGxrZWY55vIbwFtF8PU5+ujCfDHhP6mgQ==
X-Gm-Message-State: AOJu0YxabwJG04XUZLI9/XuvcHelQbFje8nchI3R+E0jm7ayc9vLfW9N
	HyCdC+bgYneXiVMkp0RndvYXlF/Mkz8M1lQfO0TjhSO3MK8mFm8+rMAaIUSbwk9jTpgJy3egQux
	n1eqMMka3WTsW1EnfOB7EUA3A6Lk=
X-Google-Smtp-Source: AGHT+IEBy1aXrFyajdyPasnTT+M2+3ji66+7MTzin+appbvLi1fFoh1gGL28SLeTeKZ+74mvQXyRSKDtxEUpCrnoMoU=
X-Received: by 2002:a17:902:d507:b0:1e0:bd7f:194 with SMTP id
 b7-20020a170902d50700b001e0bd7f0194mr560608plg.36.1711655016218; Thu, 28 Mar
 2024 12:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326202859.960577-1-weilin.wang@intel.com> <CAP-5=fVAKRa7LsvyuNhjQpQuQyY5hvQ7yBnaWjeAJFYtS648Xg@mail.gmail.com>
In-Reply-To: <CAP-5=fVAKRa7LsvyuNhjQpQuQyY5hvQ7yBnaWjeAJFYtS648Xg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 28 Mar 2024 12:43:24 -0700
Message-ID: <CAM9d7ci+8m1-Hcm9OjkaLk4ZOs6J0ah+pg0phyQGA_HVX9Qb-A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/6] TPEBS counting mode support
To: Ian Rogers <irogers@google.com>
Cc: weilin.wang@intel.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 28, 2024 at 9:36=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Mar 26, 2024 at 1:29=E2=80=AFPM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Changes in v5:
> > - Update code and add comments for better code quality [Ian]
> >
> > v4: https://lore.kernel.org/all/20240312234921.812685-1-weilin.wang@int=
el.com/
> >
> > Weilin Wang (6):
> >   perf stat: Parse and find tpebs events when parsing metrics to prepar=
e
> >     for perf record sampling
> >   perf stat: Fork and launch perf record when perf stat needs to get
> >     retire latency value for a metric.
> >   perf stat: Add retire latency values into the expr_parse_ctx to
> >     prepare for final metric calculation
> >   perf stat: Create another thread for sample data processing
> >   perf stat: Add retire latency print functions to print out at the ver=
y
> >     end of print out
> >   perf vendor events intel: Add MTL metric json files
> >
> >  tools/perf/builtin-stat.c                     |  211 +-
> >  .../arch/x86/meteorlake/metricgroups.json     |  127 +
> >  .../arch/x86/meteorlake/mtl-metrics.json      | 2551 +++++++++++++++++
> >  tools/perf/util/data.c                        |    3 +
> >  tools/perf/util/data.h                        |    5 +
> >  tools/perf/util/metricgroup.c                 |   88 +-
> >  tools/perf/util/metricgroup.h                 |   22 +-
> >  tools/perf/util/stat-display.c                |   65 +
> >  tools/perf/util/stat-shadow.c                 |   19 +
> >  tools/perf/util/stat.h                        |    4 +
> >  10 files changed, 3076 insertions(+), 19 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgro=
ups.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metri=
cs.json
>
> Thanks Weilin,
>
> I'm happy with this series, my Reviewed-by is on all the patches.
> Arnaldo/Namhyung, could we land this for the sake of Meteorlake metric
> enablement? For the sake of tools, for the series:
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Let me review this series again.

Thanks,
Namhyung

