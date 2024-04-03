Return-Path: <linux-kernel+bounces-130544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123388979C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEED62859DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC1F155A29;
	Wed,  3 Apr 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9n3T+Jw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45888155301
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175847; cv=none; b=s7EDr9GLO4z6j4x5FR0MIZFPwZFDIdJY6zuQLEwml1C3/KAWlGB38tw+xCAvgOuWvZOtZhHFxWLPhvfhsk1JiMXff3qLS68FRvO7wEG3cEKRLIf2uDkYdJcBibntyBRdY5yxLXoeU0o4fE4yXWH6hTEX9F39NJLnfDux2Cpsbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175847; c=relaxed/simple;
	bh=EKlQoR2IwAcNBhIZaP0pvhBaPu27ciSZd+tBUsZpkgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loKPdFisIRJczQ+xt48pSn671VpyZDz1UtVSJIaDS41B5gyORzGipxyl1qD2z7Ni/CVbP8a9v3L1TOl2q9ZjGN5+szMc50S33387zsT9y6p+SU5yuaD7KA90+Dxaw58LpI9mH1HANICrgwS2wTcMbv6PX6kWp6infYJjKNSqE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9n3T+Jw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e277154d4cso10685ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712175845; x=1712780645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKlQoR2IwAcNBhIZaP0pvhBaPu27ciSZd+tBUsZpkgU=;
        b=W9n3T+JwHYw8by+O13xUUQf3XoAo9/+pu3NuIpyQyS6Ar+0iSr047lRELjtnm3cOCM
         /eU/F6qdRAc8Q3OiIaL06C5pvGg+XnfKXycCT4WHg88W+SQM3uRB29CQNdk5qP6Vy2OL
         4QOY0phQEkKKzCdUKh2WtZVmoySDOyixzdOcRwthxPSGcQWOIHknT7QuGwgYwIgrs0kb
         djJ+O3SDwH38lJTMs16zEdGHUwthf5Y2CJbEkQYHJ/bBpZH7bh15phcrPultLz7I7wwk
         GV2oxjqy6A11t+CCE2QCkCRN6F4/Zo+FsuR+bgfmj13pjGbzpgC/UfxoEqRzqd22hLJn
         kFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712175845; x=1712780645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKlQoR2IwAcNBhIZaP0pvhBaPu27ciSZd+tBUsZpkgU=;
        b=TcWNktMWV49m9M++mgvAVcAWorM9/hn4RwFc0pPe+/CZtXwIDO5XxgcTbiKaf+lIJ2
         st3uuY78h0mcOCCEVVssBuJ9X5SpAf8w07ns/aGvMJk5eo/4mmsrqNKTHQy4gQpWLGVM
         /qLUz5E7iVPxFi/Hgrr4/cBAIf4mJpZWRYJSMTC7qwcBm70b/zPJGCeBBvvbhC0e7eXI
         yMNH9GP0zBVumg2Bugu6by6/dlK2fNDjyb7J0Fp1616lj1eAQWS2bC2qZMlKPav1fOL+
         kNvXzvEx6TJSzZMjdBUtqradnQVgyEFI8X+SIXggTXENdHwGb8vTQ4QZiiELm2jNhmVO
         OQuw==
X-Forwarded-Encrypted: i=1; AJvYcCVuWK8W/bfFLBlKCya+jq15INuXuvtY0N3BujGQ75dz3PB8d9UvaNgBxf9Ms5Cs8+Nh2LBSulIarBX8cQGmJWt09OjqGZsOvzNeH2ib
X-Gm-Message-State: AOJu0Yw7q/BsGH+iFEo6BQdjJ+8GVYAnSZdcllG2yI0NBJE+3K0NuaEM
	8qjaCDjDEqvDruzsX6SBOThVjUBvodEqSQWhHxBx//lUcLv27L2LMEJg9bEahRDpiAidohyF48m
	zGLOK6LEmmoU8UMadNgVIh+stMPbnvVY4ya6L
X-Google-Smtp-Source: AGHT+IGaQ1rrzpJ2yRKs3uqUHY1o4iZdBddjpY4n6NwPtk4ppMDyXIl26yh4emb/jApyta9gcqzTCpVEMrBseUTr15c=
X-Received: by 2002:a17:902:f551:b0:1e0:a977:d88 with SMTP id
 h17-20020a170902f55100b001e0a9770d88mr306363plf.13.1712175845279; Wed, 03 Apr
 2024 13:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164636.3429091-1-irogers@google.com> <Zg2jdJ3-LNRkL95T@tassilo>
In-Reply-To: <Zg2jdJ3-LNRkL95T@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Apr 2024 13:23:51 -0700
Message-ID: <CAP-5=fU1ZC2dAr-U9kecXxxVAyyx3BtnQVOAax2PtvzEfAKjyg@mail.gmail.com>
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:44=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Wed, Apr 03, 2024 at 09:46:36AM -0700, Ian Rogers wrote:
> > Rather than place metrics without a metric group in "No_group" place
> > them in a a metric group that is their name. Still allow such metrics
> > to be selected if "No_group" is passed, this change just impacts perf
> > list.
>
> But what's the point of it? It will just make perf list more verbose,
> but I don't see any advantage.

So it is possible to list all metrics, that's not changed here. The
thing I'm looking to change is that when a metric is standalone it
appears in "perf list metricgroups". The reason is that a metric group
can gather a bunch of related metrics, say some form of read, write
and total bandwidth, whereas something like an idle metric
("d_ratio(max(msr@tsc@ - msr@mperf@, 0), msr@tsc@)") that could get
placed in No_group is more useful if it appears in a metric group of
"idle". I'd put forward that nobody ever wants to run "idle" as part
of "No_group" whereas being able to see it as a thing in metricgroups
is useful. I want to be able to run "perf list metricgroups" and get
groups of 1 or more metrics that someone might want to pass to "perf
stat -M", currently this just shows when there is a group of more than
1 metric as there is no practice of putting a metric like "idle" into
a metric group called "idle". We could update all metrics to make it
so that when they don't have a metric group we add them to one with
their name. We could do this in jevents.py. Those changes would make
the No_group logic redundant, so we should remove it. Just updating
the No_group logic in the perf command seemed like the minimal
approach.

Thanks,
Ian

> -Andi

