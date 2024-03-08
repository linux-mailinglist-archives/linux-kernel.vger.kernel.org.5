Return-Path: <linux-kernel+bounces-96381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8F875B76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7152C1F225B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19808632;
	Fri,  8 Mar 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfrtRmJG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED868163
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857176; cv=none; b=fypDdxxbysf934GC1X2/FmlvA3Nuc9jD49Nnt1FgUOY5waY4CxBImtbBzKTJqiVIT5ixSdtyw1D7pzzFLuq4VhnELSHD4KJt9Gra9wuVqBcfrCwVv4WDg0l8TJbIEAPBSxmlz+wrQpzzDP91aG6X5+rJOrRcmEpXtTiAdoPNg7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857176; c=relaxed/simple;
	bh=41OGcxDXHE9reRyhpUNhOqjp5DIntWx9erI9QUJZ7zM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=B8MYrtY0cgcaM9a+42tSF6O2QV94o2nz5XPNcb88sSP0R2Nmm7s4zBs2c0SaZLXsl1fsdxQU16oAVJRcwDHpb/NFbLZZ1C/ikaxZfBuNQgLrN7wk+Uo2Q3LALzxEDUgOUoOueJnaOKO1fkDR4OPXNnW+nqVzN2KiDOaFlVm18pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfrtRmJG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so3035391276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857174; x=1710461974; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=De+xXG9LErpx0jsehLOAYTZORpUzSmU7F+YMDvAGffE=;
        b=lfrtRmJGg9W8iRwkRhBBdvZpYoH+RwfbIKDOAp+IjVKwyl19jfUOTy0F9+0qGR4mG9
         ari+gJ0P/aKFPVa1l+EIGJrXGCJdQJV4YyToA6qV7m93/vrC+RzqFya5ZP74PDnpzCf3
         eQiOOJbqONhh/ENrWi53ej6pupp0vo0vCRYR4Y7094buNYsVtucbjkwyrk0lp5xgbls7
         U1f4mw2smZNQG2nClM9dbHA0e/e2aLtqRIL47sJvvV9AJzEjE3AH+aX98osWwafANe9k
         58UxjFw0rqd2Ac5K1zUwxsiha/4K1LXFj5YuNZUvbCypUnWsC9Eq1rIt8R6mrEXkkbLq
         FwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857174; x=1710461974;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=De+xXG9LErpx0jsehLOAYTZORpUzSmU7F+YMDvAGffE=;
        b=cfU53pnKW3Yjy9SqNRWJLpsXQ1TWVFo3Xl9L3xev/7mQpuWH2YOXvcrVZik9YSPplk
         B26fdxrlNu7bsu5dqF1vSqyz2aH51le6PzhDl0pK4QZjc5D+ry9CCC0x/yOtK++4MPOD
         51JrmCdzrfI6r/2Rk6Tl5PVYTqObLK1T5kGIEWoAwvmNhxyL0nhn8jNexFsoIaFWxcaF
         8VbpCuKyEaqT7fWxRXqrjRyCkYy3PzkWLoFXk4XxAkS+mu1xiHHe2/Bisp5mkAvuzzvt
         q77uRUbxNpjmsUpGNpp5An4uspFWR1DCkZYWZKqapduAXAbV9rOL1qYchtLwchbPEpuL
         EeJw==
X-Forwarded-Encrypted: i=1; AJvYcCWlzb9VIqBDcSr9RaU8kt3ZPi3VbWYg1sKLKJCyXcdk0N8o3UgYxQJ3wydgmsKwbYc+v0k1aPtIjWEhLwdvzWarEX5MrgORiOFhOv5q
X-Gm-Message-State: AOJu0YzBD9ynq9kbpjjI1CYDQ96v1Zggzskx1ibIeStCCmZXtWEDoviP
	Yx14qRbK5kHJFPIdtwOnz9EWN4z1rc8JB2O8qaAYavUjRoKhCH/p5Qnzd7vPUtRExsSoyi2hiQa
	TBmt/hA==
X-Google-Smtp-Source: AGHT+IHNsQE0fEVEtOu1phuNJbGl8EvuyfUoDyFIcxYP78HmFEzRfUDobphGohVDT9DtbXgpL2DDOGV/1fHt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a25:310a:0:b0:dc6:b7c2:176e with SMTP id
 x10-20020a25310a000000b00dc6b7c2176emr84209ybx.4.1709857173521; Thu, 07 Mar
 2024 16:19:33 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:09 -0800
Message-Id: <20240308001915.4060155-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 0/6] Extra verbose/perf-list details
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add more encoding detail and raw event details in perf list. Add PMU
name and reverse lookup from config to event name to
perf_event_attr_fprintf. This makes the verbose output easier to read,
and the perf list information more specific.

v3. Fix to reverse lookup to ensure or aliases are loaded and if
    getting the config value fails for an event/alias just continue to
    the next one.
v2. Address feedback from Kan Liang, "Raw hardware event descriptor"
    becomes "Raw event descriptor" add assert to keep term numbers in
    sync, fix a commit message.

Ian Rogers (6):
  perf list: Add tracepoint encoding to detailed output
  perf pmu: Drop "default_core" from alias names
  perf list: Allow wordwrap to wrap on commas
  perf list: Give more details about raw event encodings
  perf tools: Use pmus to describe type from attribute
  perf tools: Add/use PMU reverse lookup from config to name

 tools/perf/builtin-list.c                 | 21 ++++-
 tools/perf/util/perf_event_attr_fprintf.c | 26 +++++--
 tools/perf/util/pmu.c                     | 82 +++++++++++++++++++-
 tools/perf/util/pmu.h                     |  4 +
 tools/perf/util/pmus.c                    | 94 +++++++++++++++++++++++
 tools/perf/util/pmus.h                    |  1 +
 tools/perf/util/print-events.c            | 55 +++++++------
 7 files changed, 242 insertions(+), 41 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


