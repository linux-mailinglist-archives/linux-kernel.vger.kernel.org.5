Return-Path: <linux-kernel+bounces-85877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC386BC99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84301C210CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB21102;
	Thu, 29 Feb 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8EToDgm"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C9107B3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165745; cv=none; b=Wkw7nfvTCcSarGrVobsc0V7VJK0cqv2WCBXDfm9NxA8IamZmKO5doSEAsx4zdXqNdeXv5ki3NDcYWOSWuePy1amsdOy5O7jJxUazpCNCqnZ407Lthh1kmwJZloiA9l8HfqhXrsnPeb7vDN6PtoNQMz07Y9AMwMwvb/mHoXocFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165745; c=relaxed/simple;
	bh=w/dBhGtqOiet87mj9CIQnP4Eds9GW8q+8jq3/Y99j+Q=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Iaoo1ZhHF0dc5gdvm3hUGhxxSzuvhGkovxipTUyCxaEmUEC8vU+QrQRN7yK+IZxfxbFCTjvnIztHTRBkke4M0P7pSWdBNWdKbGVKnBzgJfm6T2FafXeeWcMEIaunr3n151+wNL+EE2X2BRjqu5rqJkojHor1gnRVoQsNvBc+Dvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8EToDgm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso695073276.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165742; x=1709770542; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dcL9AcUcVelYgbT04eVXrPkevsg/BMkfHE93xGttlPQ=;
        b=c8EToDgm3weolB5MosjoVzxiKMjJhwCczhCLU6c4JRdhkzC+UTLpnTzNV5ofHhZxCh
         n3VM45pP3GyRjTswNoq8WK3EJSISyzG550UXdZXecDQUJofvpuWWzznR0aLx/6pvlAhl
         mdrHq5dSkDTTSjGQvyCbSB2X8wy2mFReBpe7OEsI4g0LzRuGX+BhAMEUjtGUzdbnxrpX
         5DL9wlB4X4Vy0upWgubY3KYcjtRcx+jvR3mYvjcNw2pT8NDsTJDPNiZs4moGrm+GP7J/
         BZXYNjzx/ZePPvtbkzSmG2xWPsdn1rSM6nPA01zAoV8vyG7STB6c0/E+uBDXpnrHQRi9
         bTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165742; x=1709770542;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcL9AcUcVelYgbT04eVXrPkevsg/BMkfHE93xGttlPQ=;
        b=sTmb2bqdHudN7RhVyuvGJt5cJHUPC/zx8HP4kHNPYEyx4MJEEZl5Srq9GsXBEl9xlj
         Anjo3KAip/kC6F0nIyR9HwgSmgWBsYFkgyhD77D73xOD9Axr5mTOigm66A9LbzszuBi7
         dQf/lVBolXnIsDpNVukkZiRQoLE/DGd4C/HED5SHlUXSIsiayzrEqtd7fUBvYAqVMr+2
         iAEC/OHA9jBY4zb4TVt3/jZTuuOJ5Vg+pE/H0YacVQErWD/XuMdA2lQIhQpqByNd2tDs
         LUm9eEwuPZCYDnTWSiMyEmrAH8MGij7cBfkPrvO+DnITBJixIx4ibDxCafEyzFVgSZ6F
         V0jA==
X-Forwarded-Encrypted: i=1; AJvYcCVDR0DxS5fTSQ9xfHabPwtMlVNpQt6m2TC5BWNULCGoTZJ/mb8VV5vpqBLRCVQWB7+ekYyCUndnlpX5bgXiXuuvCEhpWk759s8BsvXX
X-Gm-Message-State: AOJu0YwP41dNKWsLsrAoGm6SV75pfMQ9qO+ijMmcGdGK2es68k6vwbFP
	NN1nXEE/hjTCgHppQAps/aXy54+Y961DN5lGklJsobLZWs+iZbGUw02d2WJ68Bb2PQGzSnBTgD2
	ZzloLGw==
X-Google-Smtp-Source: AGHT+IGND6Qa1OhIK+/LURQLPHsXWevjR53gBA3AGOP9QOSuPeaerLixCesSaoA8q007Yg/DowVW9VFapZST
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:250d:b0:dc6:f877:ea7b with SMTP
 id dt13-20020a056902250d00b00dc6f877ea7bmr198122ybb.9.1709165742694; Wed, 28
 Feb 2024 16:15:42 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:24 -0800
Message-Id: <20240229001537.4158049-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/13] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

Ian Rogers (13):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD
  perf jevents: Add cycles breakdown metric for AMD

 tools/perf/pmu-events/amd_metrics.py | 642 ++++++++++++++++++++++++++-
 1 file changed, 639 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


