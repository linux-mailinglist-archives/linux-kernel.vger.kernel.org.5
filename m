Return-Path: <linux-kernel+bounces-87929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F886DB2B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92FB3B224BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4750A88;
	Fri,  1 Mar 2024 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UXrONnm"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81882F53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271413; cv=none; b=ajJ1zu6sTipvhf1wDjA7EyHrfYJFzL98y81E+Yj+33vdmdZtU/rboSReLZIVQosF7B5cagY2lcr8VdOSzkVaMGIvo8/yzidmPFQgQE0/7KBuhSaKO4T9QM+S6Gi0pyYtQ6bgENqkHLc1qJNxLlB6hBR9CaTZtLMVER7I2uq2b+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271413; c=relaxed/simple;
	bh=HgQFSvlCrQADFz3kGSpi6YyQyXREUPyNAOV62rIkpi8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=FHFNSNhtt//Bj8u9BfZFdBP3v4MyI9uKcbl+2hNhiwdgD9uZ3wDQNJaKsN6mP4qtCywW5eRo2tS5VI44+gehfQmAIriJmTRmPd5zxCk70KSNc26qxl3Qo1UO7lFJjc52wjNfAAxrPrvUkLpWJTGOTGHkje/egVag75jb6MOZIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3UXrONnm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so3175240276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271411; x=1709876211; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lzDqYvXErE70KiqRsWc/Sm3PCB8or2RKw3JobeAHpbU=;
        b=3UXrONnm57dTiYjWLHke4q/85a0b5kFR0fNMFgs3Gu/2Fgu7eUfNwCaAZDy1Uq77B7
         6AAgaVCs1VBlHolioHuXUHiE0luVrmC+jbX0nE+RxnjOVZ1OYRdNJ94BmPTkq0Zy9o3Y
         tBTYw3C7aA64W9JBzg4irQ1NJM2sZGJB3HaZtFbqGoBooABSp51XaBFhCnNxK0cp+K0U
         Bf1t/M9UYejKKT9i3AjiFMhlVCQ0fWn3DyCV78CHa6E9QG/badnTTvtL25nT5Mhw44b4
         rl9/CKkihGvLYSdN5qml5iLHBbn3H/u24e1VbWbfu7FRb+/HlzufWjpLvyqaASy8qXQw
         xwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271411; x=1709876211;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzDqYvXErE70KiqRsWc/Sm3PCB8or2RKw3JobeAHpbU=;
        b=hlR983b7OD0OpOuDWKYalfHyz0riejgjX9iBzHGOFKqcxrErufb9NPA6wUe3IYfhiE
         LYFl9+2nVDkOa+Y2V2QNrAv5dR7Hla00WvW0Pbw0626KxdugHJoQWQBMmFXLcMLlw3lG
         BUubntZIL9vLNnuxA9wnQb+34++VYp2Fy+Ye1Xu/IGkTjZZf1U/U7TM7j3O8Btf7VIQg
         eMBOw5qK1jvlveINnc7MTsfG1XBENMd6IYknQLpGgjM8+wk+thumFlgNLt0jBX33RMWp
         k72jxHyINl7qq6e4ugGxv27dIcp7W2mNaUnpRlbhtdSqJt6PS/9SPXpjgQfW2v3OKOJd
         Xrsg==
X-Forwarded-Encrypted: i=1; AJvYcCVn4dASEy3rKORjs5moW1rW3c2WOy6+1uV8YcNeQEB7OSg66ouetiOQHyOmMLcZq2dQRGgUgwl24H8XCI959u3KNl2mheWvyLjnNj0a
X-Gm-Message-State: AOJu0YyQ3SNF4BngcGcp3Cc93FtqmMhV/xZWofDYR8/3/teDUgfD84Im
	MiQkXlHPUNo0/AH5QkB8kdZrpuxsvcsFkVDwoPTkc+um0HC6O1VJatBId+/ZWm1Jxdhs4M2oqjX
	L4/fGsQ==
X-Google-Smtp-Source: AGHT+IHOU5Sza8dEsNHRDsES+qJxRSg8TaryNa7FDJ10j4a0TwQ24VECLaH1u+MByIz4Kb5VnwSLhBYwyhh8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1741:b0:dc7:5c0d:f177 with SMTP
 id bz1-20020a056902174100b00dc75c0df177mr134040ybb.6.1709271410883; Thu, 29
 Feb 2024 21:36:50 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:38 -0800
Message-Id: <20240301053646.1449657-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 0/7] Thread memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next 6 patches (now 7) from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
now the initial maps fixes have landed:
https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/

Separate out and reimplement threads to use a hashmap for lower memory
consumption and faster look up. The fixes a regression in memory usage
where reference count checking switched to using non-invasive tree
nodes.  Reduce threads default size by 32 times and improve locking
discipline. Also, fix regressions where tids had become unordered to
make `perf report --tasks` and `perf trace --summary` output easier to
read.

v4. Add read lock to threads__for_each_thread, Namhyung.
v3. Factor threads out of machine in 1 patch, then move threads
    functions in a second.
v2: improve comments and a commit message.

Ian Rogers (7):
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf machine: Move machine's threads into its own abstraction
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/perf/builtin-report.c           | 217 +++++++++-------
 tools/perf/builtin-trace.c            |  41 ++--
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   4 +-
 tools/perf/util/machine.c             | 341 +++++++-------------------
 tools/perf/util/machine.h             |  30 +--
 tools/perf/util/rb_resort.h           |   5 -
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 190 ++++++++++++++
 tools/perf/util/threads.h             |  35 +++
 11 files changed, 478 insertions(+), 394 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.44.0.278.ge034bb2e1d-goog


