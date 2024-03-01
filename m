Return-Path: <linux-kernel+bounces-88958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE01486E8D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A62E1C20BAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD039AF4;
	Fri,  1 Mar 2024 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1smm4ibY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924341E88A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319376; cv=none; b=Eoy6OdjmQ526xyzVaMFRBBDyWxNt1OVECGdUA1CDsCr0GnbcFNxZVKmTsu+mZtb9gDTj3Wq39YHCLhsNz5zxPMtiZEdXQ1mZ/O+cjNljQsTjSVVlf2OTJmeOwHDQi/nQpQPtRJ2ULuoUN2ZyghAvNX8K2JNwqWN3SYjqc6mgdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319376; c=relaxed/simple;
	bh=s4bOpKkEyr3a4raxuApEAoRlDPTKEZCi/jhQ8r/Irq8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ZNUwKEz4cAJ14b+qsM8svPIjV8neXZ/Is0iUtPJS5XIkkqi26pok0a8PrLNTi1f+HJO9drL/fj/iVJzhlqXTjsYXy4WhV0EOvgonkRSf5iD44Wd8dZjLMfaEtpDiCjMZ3b87O+E1qGkXNMLUpCIsKDQ1+jvO+6QapzMUt5Tq3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1smm4ibY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so4192163276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319373; x=1709924173; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EcOYmXkq65ioOJSl10z1+hp5KpsWk2JUO79k5YV9sVg=;
        b=1smm4ibYfmArau7YMzRBeEjbBm49i/CsXhHDQLRMnS1RoyEUKDp2J9MHSjx31c0wnw
         GVBzZ5UTz1q+uKPf8Wtgcy5R8pvUdm4K03HrtFyuXR+3dABt6bWohBhpaXOXEgSqdQhy
         LD72BL8eMcwEjM9lEdascvpEhbvhGFzmOH31IRbhjpgQFIjZ7nVm276QPjxeArD/1qqY
         GKMX2kaDIMPYzqc8o9ahHHAyx4+W7vQ1F1lKnXykjrct96uGn8ytrtia+KXgo+kO7gd9
         13VE7rlR363nz1h53cMncMSegA/BaQ63r1jxz/4Cw4A+a+Dxi4Q9SBOn4F7yKGzawLXk
         OJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319373; x=1709924173;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcOYmXkq65ioOJSl10z1+hp5KpsWk2JUO79k5YV9sVg=;
        b=dEkD9k2HAgjL0paRuUM8eW0Xl5w6jlEoA41nYzVfHiXNuhZXA/igRQiJF+nMVh+Qd6
         WgjCUPA4lnCCj5W4tww+EU4AS9zp8ukRKR422/ttBKQryXX8HYJRr/LUkfSPprPL/III
         qYE+qAkCyD3kTcPqIFxJEWqVtumBfx5SvyYSidMUEs9M47tWy4Cx1TKYs+6hU/IKjGj2
         SO1esEMw3HoITe6YApDm+YaccFAj+J//mzGDEjSbBAGsLa3/ube0yUM0STq8uWUPQTAm
         6Ceo7L9BKSBdTexxHcckpnwBIwbah7ZoV3pDqxgWhl0dSaVek7L3So/Y3sD/gVCkZhQy
         UWCw==
X-Forwarded-Encrypted: i=1; AJvYcCXhh4rTSAjhAiDpid6W0heIne4FOLntox8FInPa36XSFMJsmTqKLtqN6DbB2At2lRKMT1dd2arAWeDkRxgwrS5RhTiXzIloSVCyFJL6
X-Gm-Message-State: AOJu0YzJd1QEh6KLUweclLknCTnu3QqlCJKWLnAat90NwaeFoZitFr8y
	BU09tBh5g5q+54njDUQ/m0HmU6o8TIG7bNJ3/11P+EbmnOIGhFCSVZzL3Je68C23uzpD0vysgXY
	PYQh0Gg==
X-Google-Smtp-Source: AGHT+IEOwR1WhD2r8OkY2eAG5BVEXVGAIhJ03e9RybE9XCQau2Lv0BzDpkHR3mIFTsdrfZQtp0wEQxqkgqKN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:aba3:0:b0:dc8:27e6:cde1 with SMTP id
 v32-20020a25aba3000000b00dc827e6cde1mr95220ybi.5.1709319373729; Fri, 01 Mar
 2024 10:56:13 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:39 -0800
Message-Id: <20240301185559.2661241-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 00/20] Python generated Intel metrics
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate nineteen sets of additional metrics for Intel. Rapl and Idle
metrics aren't specific to Intel but are placed here for ease and
convenience. Smi and tsx metrics are added so they can be dropped from
the per model json files. There are four uncore sets of metrics and
eleven core metrics. Add a CheckPmu function to metric to simplify
detecting the presence of hybrid PMUs in events.

The cstate metrics require the event encoding fix of:
https://lore.kernel.org/lkml/20240228170529.4035675-1-irogers@google.com/

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, spelling and other improvements suggested by Kan Liang
    <kan.liang@linux.intel.com>.

Ian Rogers (20):
  perf jevents: Add RAPL metrics for all Intel models
  perf jevents: Add idle metric for Intel models
  perf jevents: Add smi metric group for Intel models
  perf jevents: Add tsx metric group for Intel models
  perf jevents: Add CheckPmu to see if a PMU is in loaded json events
  perf jevents: Add br metric group for branch statistics on Intel
  perf jevents: Add software prefetch (swpf) metric group for Intel
  perf jevents: Add ports metric group giving utilization on Intel
  perf jevents: Add L2 metrics for Intel
  perf jevents: Add load store breakdown metrics ldst for Intel
  perf jevents: Add ILP metrics for Intel
  perf jevents: Add context switch metrics for Intel
  perf jevents: Add FPU metrics for Intel
  perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
  perf jevents: Add mem_bw metric for Intel
  perf jevents: Add local/remote "mem" breakdown metrics for Intel
  perf jevents: Add dir breakdown metrics for Intel
  perf jevents: Add C-State metrics from the PCU PMU for Intel
  perf jevents: Add local/remote miss latency metrics for Intel
  perf jevents: Add upi_bw metric for Intel

 tools/perf/pmu-events/intel_metrics.py | 1023 +++++++++++++++++++++++-
 tools/perf/pmu-events/metric.py        |    7 +
 2 files changed, 1027 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


