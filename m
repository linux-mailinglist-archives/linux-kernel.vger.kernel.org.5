Return-Path: <linux-kernel+bounces-146321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C18A637F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4DF1C20F04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339303D3B8;
	Tue, 16 Apr 2024 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QU8zkirR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829F339A0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248147; cv=none; b=CsFetj9uRBVWe3H2TW5p25TFg+5WN4dFa0ode/O/CdkglrtjPiA6w14dKdAsNz+kXv4Po/UHW5b8gS1jjD19Gi3oTgV2CrbNq1b4ULyNTutUlmkP3USGOfij+QMFdKcehaNg5pfbBVRnKuDJd5aEgjO/Lcalg2pPWJbNULolD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248147; c=relaxed/simple;
	bh=4jPYXab6p6VLgWMH/RuxotfZX+DXM3OFg+TT8Arejkc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=l1XeVubV0XH6Sx066ghu1HwlSGe0vVAuwPu9E/Ak2oupnN5GcFEjLojw5SPYgKUHbUEUO8nPq8K4HPUNHwZu4RlYH/p/lPp75L6kjItqDFuJSG7a8opIW5mBocTxkMAqsGagJHhU7odouTpphwtVVzJD3pRPNZeCCKAkRJOHYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QU8zkirR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61892d91207so52177397b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248144; x=1713852944; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1L5nQxmaIBseTv3eUkvLYgl4v+fhf+bdZ7bLGNPrKqs=;
        b=QU8zkirRLFa/J+XFgK13oEFZ9QTZcG8t9yzs/QfYgDX/9SxvIUPyuGMs2shh1hWZV+
         FPNcFgp33pl6sYaLd4GiQSmLugE9vNK4+/zpZycJm4R/qL6C9XGaQL48zCTBbsYu4/tZ
         rSCrkmpkQy4CikqLIvFXX3BpOWTyYwG/LM6ZxfRz1afbVouUgIxzv+gVCnPdxVFlDE51
         pPOEhLratWiTWncNs7e6ItAZnnmcD7CT4KC85dx6dR2nWPp78eOt9vzVrJN59VHTHfir
         1eCPh3xw0/+W0LtFVrFSKwRLr6L13JZ9C7Dmi5cYTamRXx/0rg1rDZOC4Jvxme1l40+U
         uXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248144; x=1713852944;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1L5nQxmaIBseTv3eUkvLYgl4v+fhf+bdZ7bLGNPrKqs=;
        b=jBW2sxid+A4t/CXUdiWI+AP0QlS9hCfHx4ODVMQG26x0Y4FBKLaAEolc253uTiNHs1
         LfiEtpJmq30iAOcuh88S6fxLqlvoH/QVYg9Kx7SbdzG4I6QulgRrX2eotERWQQU1sh4Z
         tAhnvImnahDAILZ3WhwBBJObptsNsxui+HoO3xxOx7NN2keA60z0hzSHOKrCulnC6ThP
         DdwKdbe1Ew/YFfcjPvb8Xlw5I7F31FtWGRdKzA6cJOMuweReT+2iv2oUtZstj1yBKU4b
         NrvHgX6jO5sla3rVzS3c27LTKz9tVubijYrGBxwgIa5vKpvAl3oyMWIsKYk8Vl4LJVt+
         MroQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYX+D/f9OvL8Uc5k67CmwPnvvWCkZPBgW8oAKEoUlgTnwHJD1D7k+dUWpOws0qEA22yJ/5VcTL3pmvmnT/90TFaglAZe6Xhq0Gohsm
X-Gm-Message-State: AOJu0YzsdVdBp8riR4T09iw0UgyYWBYl7ip//lLFdhz+63zFzKvQER2p
	mV4VXF0kiTd3HF/XZ/WiTpCYcS8bm4Xu1pnOjXXagMHEWxXkcdak5b8RiBZObPZ7LtfQ1tQsas4
	QEa8L1g==
X-Google-Smtp-Source: AGHT+IEA3B55PHeFnorQTRTaPmQGXFGj867ryFo0kz7N/R3DDO6sXqkF9UwTo2cE7HmZ5sd27AE/abgmLPXz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a0d:d74e:0:b0:611:747a:daac with SMTP id
 z75-20020a0dd74e000000b00611747adaacmr3417811ywd.0.1713248144106; Mon, 15 Apr
 2024 23:15:44 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:16 -0700
Message-Id: <20240416061533.921723-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 00/16] Consistently prefer sysfs/json events
From: Ian Rogers <irogers@google.com>
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

As discussed in:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
preferring sysfs/json events consistently (with or without a given
PMU) will enable RISC-V's hope to customize legacy events in the perf
tool.

Some minor clean-up is performed on the way.

v2. Additional cleanup particularly adding better error messages. Fix
    some line length issues on the earlier patches.

Ian Rogers (16):
  perf parse-events: Factor out '<event_or_pmu>/.../' parsing
  perf parse-events: Directly pass PMU to parse_events_add_pmu
  perf parse-events: Avoid copying an empty list
  perf pmu: Refactor perf_pmu__match
  perf tests parse-events: Use branches rather than cache-references
  perf parse-events: Legacy cache names on all PMUs and lower priority
  perf parse-events: Handle PE_TERM_HW in name_or_raw
  perf parse-events: Constify parse_events_add_numeric
  perf parse-events: Prefer sysfs/json hardware events over legacy
  perf parse-events: Inline parse_events_update_lists
  perf parse-events: Improve error message for bad numbers
  perf parse-events: Inline parse_events_evlist_error
  perf parse-events: Improvements to modifier parsing
  perf parse-event: Constify event_symbol arrays
  perf parse-events: Minor grouping tidy up
  perf parse-events: Tidy the setting of the default event name

 tools/perf/tests/parse-events.c |   6 +-
 tools/perf/util/parse-events.c  | 482 ++++++++++++++++----------------
 tools/perf/util/parse-events.h  |  49 ++--
 tools/perf/util/parse-events.l  | 196 +++++++++----
 tools/perf/util/parse-events.y  | 261 +++++++----------
 tools/perf/util/pmu.c           |  27 +-
 tools/perf/util/pmu.h           |   2 +-
 7 files changed, 540 insertions(+), 483 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


