Return-Path: <linux-kernel+bounces-85892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B886BCA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63B91C2197C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242A16423;
	Thu, 29 Feb 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q4LXKtwd"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DC20335
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165906; cv=none; b=FlpjosrCQ1dOpWul1J0vQf4/ACV8L5pSm5DC9M1T25KnWuh1g7MCBE5EMAvEkTYwW/oSbGJ5bzn44A9YVX9XAhZKB31O2J4Zg7H044H/Hl867LfdndroqnBzz3sfY8iGi7UTLNaa+TDB8hr9lNub+KIIpp9uYki8pVLDjp/U6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165906; c=relaxed/simple;
	bh=SNeE1H2bSvNelRyZsRJeUUph4hutQUY+T7ny61PsnSo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=L30p6t7pWDbSiaSrBsaXk/M3H+FGG/X1++ZMbTrMvkuOri3Tsiom9EtGVmcsJ+wE3g0sdSJCfHuGeCWjpQuzbUCjQ1mmNngPR5fmOeNg2vTwomLMQlY66Hedp/XZQuiM0X2cOCIp6yvUZhNyuvoMe3cAEzHfZTnAwrKRRDd+cGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q4LXKtwd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so671387276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165903; x=1709770703; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9aZM8JSI75x3Nv5IZnCmGh+gLHZGhZIzWCbKV2hRuI=;
        b=Q4LXKtwdwN6AQWuzlOJBKhCj7s4G6FBP9DnemaBa1biautNdnZip8ui+Z5XpbgH7Rs
         on/fQHF5VZJZWMpEIz2lVF9P+UBmKjOyG5drxwHxwWcLM5hzZm+hfDtZqKUtmKP9Kew+
         X/3JGhvKhM2NZ5V7RzB3wr0lAUt4zoxM5dP/i+ASAw/hVN5l6BxLfFtwIweerRzhIgME
         MMp1drRG4gc6R9m/mF1D9JQaCmsobTupDlo0+te9piuvQ+m3hyfsJeAi2PDEBQt+qINc
         WCJAfJDOyX7BM5GuiMgw/Ldh08a2UV9mmgNoOgTTwGgMYA6XADTWLvRbIbtXPuUHWWp/
         YP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165903; x=1709770703;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9aZM8JSI75x3Nv5IZnCmGh+gLHZGhZIzWCbKV2hRuI=;
        b=r3wnquhzC20KgSZiT8JnB1I8AO8kloEpPOA3SOqOh8dzmkqc5D8LhxPIFG5jXbrsLS
         7G895oxQYO9UKdgrIJwFsA2IH27v1zvv8bOtTKc+P2yrNJUWRdjglj7VusmQSVnTPXuV
         ofwdvUXA253kKB8hfpv99gk8idQ8ILLvMVzoz07jxWh0jxTupt3jsnL9zx5jlhZpooad
         6Ud+l7kPiNrL6Ke6DgO3JAs5auPtme3OSW0V9DZe6FOQMYDI+bDl3tvcWgrhaq4wpXVG
         Li2NyqvxvuhFVCn02L7CDnKmOSvg7ukgZ5RZ2lTheXb+UdsvCYgeKns5ZbnfyS4sysFD
         tJtw==
X-Forwarded-Encrypted: i=1; AJvYcCUcdLUb4Y/OwNzR7C92bt14IPvHZr+A5rl6SCPnuRqMmW9AFZaTdRo+cHvH8WuXHKDuBYnVO+AMs6H7Rw0mLp0bi/2x2d+GuBkuet77
X-Gm-Message-State: AOJu0Ywy6NvTkc/hMUneeshR0DS1tk0nZTTWlGABUnpnVfG/dNi6zKUh
	QDURqsnkjpteUdZMp/CLM/z3563ftG7U9nnqet7iQpMKF3qSi1kKZJ0cpBtg9xp/a8XDT6wxVHQ
	S4VbN5A==
X-Google-Smtp-Source: AGHT+IFclBXaulwGLyHKgmDX3fdhdlzOA1oCM6xIgLIenj8gqb/f6kzn7lLC0pwUH1BMotojcewKwsc0F/Tm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dc6:e5e9:f3af with SMTP
 id w10-20020a056902100a00b00dc6e5e9f3afmr193174ybt.9.1709165903628; Wed, 28
 Feb 2024 16:18:23 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:45 -0800
Message-Id: <20240229001806.4158429-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/20] Python generated Intel metrics
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate twenty sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
twelve core metrics.

The cstate metrics require the event encoding fix of:
https://lore.kernel.org/lkml/20240228170529.4035675-1-irogers@google.com/

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

Ian Rogers (20):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add cycles breakdown metric for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1040 +++++++++++++++++++++++-
 1 file changed, 1037 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


