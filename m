Return-Path: <linux-kernel+bounces-62239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC49851D74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB14B26776
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72ED45BF0;
	Mon, 12 Feb 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHdh4dJ/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE145970
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764351; cv=none; b=BY2iYOO8revn3GEBKRjOvIX3NQE8zEt/F3Re00tiAVwAo1lD09I59BWzMlLKcZzBLuXAPfvS7FxVfpVDIjjDbkXVv8PCJa/0u/U2uCUPJESKuZirTwREEiBtgrd9PbLswdD2UJa3MyGo5Ns0NXrI2PP0Gf2k10oMBmNc02b9XpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764351; c=relaxed/simple;
	bh=kq2gDZXW4atNH6jHCSAioIQIj7W9ZIfsPic+NuVBLPE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=AydlVKzQdFpBs2eRb84yV7qYV5paBj+4srUIbwUzzZGT0wX2IjVo7VCcWKmxFkHmD1C2/Pp5CXXkHq+SEHxLgtTJHBQ8PHhwreTv+y33gz4dtubSUlf5N64IiIcY9sKkzN4pIgthAX18594DkV97K+NA0/ES8wcN5ys7S/ZdjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHdh4dJ/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60753c3fab9so14583667b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764347; x=1708369147; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/PJeKzS6BQLSmrUIcfcoDlL9jp1b7n/jV99AnuH7tUg=;
        b=YHdh4dJ/s9bsXLSl7WrBR9rC37y5VDpK4U/OTWW+cWUHSTHVXExGFEiuAgdOJ3kcUm
         TwfG5did7h015HR5xtu1TcNFBWxYu+ct5O6cf9AmB1+Hw0LQ2aoOEKPSx5qcUpf9h89f
         zVmRJvzEgOWKcD969EH6A2vQw4wffYbqDpE7J8dA1UTWc0RRsoIzgYikziADZ7aAfJZp
         EDkgmlL8DNDyhyIfams96UQ+Z5UMdZkAMTB7uusefD7SUVy/hFSZiMnLtO+/gMXcDFrJ
         Eh6Fx4QznsqBQip/HqXl09DYcVDZ5bHvA2v5dDpsx8xhYfIL6J2A4gH+EXnG2+C0tmFg
         jukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764347; x=1708369147;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PJeKzS6BQLSmrUIcfcoDlL9jp1b7n/jV99AnuH7tUg=;
        b=ezqPk+6hqVBKalW037auT/bvOKnT7jVUsZF9NwWk59q41q20a74t/BnILCJH7EA6Oj
         SvpPSI7YkOoM3PKHhdM5fHOROUUMxKYfaMoUI/DYTn9Hjl+n1Tc7Ttym0NCoqe6lywwD
         ihqTcKVMLxTFHe6A879xWSOVpsB4Mh2sQZ/rTQcNltAmczXTgmCujz1y+4RrEuN1RzLG
         jCamMwjHLhRvXFGBggWQCFkFvlKHZhwPvgVn+7F0NqStg461VJgHW9MI+st6+yebR6WO
         XgmTbgQqYYyKYxSpXSUmow/6AfoCfgxQIA6o2FZrd0u3wVfnGbn1AxTHTdzAkYYAIYWT
         Tr0w==
X-Forwarded-Encrypted: i=1; AJvYcCWYS1XpHZ8XKSaFFEn7zvCRLGycQLBQRrHVl4LaaBiQ5JgKMbeuDbKJ7Z14WQ50tlT26b5sgWXw5kHjjqH07ETQ/K1TX4V0i+beT3jr
X-Gm-Message-State: AOJu0YwU91VjsnSS2nSiaWun6UG8M8m0sUQrWu8rwz5jJn1tOA0VuyEa
	SKg6cOBQ2DPRsC2J9W4kus+Kg+u0KvLC/X37LdWny3O87jOcZOorSec7IlXgVbUC/ndOLvUPly0
	Io9dOuQ==
X-Google-Smtp-Source: AGHT+IEuj2PSJ7drnwS/N7pgsbF79uuXX/skTkoq1JlqOrNDIKF77Ouw0jnO0S3GBuB1ps9JJGo6+dUHHaE0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a81:920c:0:b0:5ff:6ec3:b8da with SMTP id
 j12-20020a81920c000000b005ff6ec3b8damr72459ywg.1.1707764347288; Mon, 12 Feb
 2024 10:59:07 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:50 -0800
Message-Id: <20240212185858.68189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 0/8] Run tests in parallel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If command line option '-p' is provided, start/fork all tests in the
main thread and then gather them in order at the end. On a laptop test
time was reduced from 5 minutes 21 seconds to 1 minute 50 seconds. The
option isn't default as the test shows up perf and test flakes.

The '-v' option is modified so that 'perf test -v' will give verbose
output only from failing tests.

v3 - fix a crash if shell test directory isn't found, remove merged patch.
v2 - fix parallel test output/verbose issue
v1 - initial PoC

Ian Rogers (8):
  perf thread_map: Skip exited threads when scanning /proc
  perf list: Add scandirat compatibility function
  perf tests: Avoid fork in perf_has_symbol test
  tools subcmd: Add a no exec function call option
  perf test: Rename builtin-test-list and add missed header guard
  perf tests: Use scandirat for shell script finding
  perf tests: Run time generate shell test suites
  perf tests: Add option to run tests in parallel

 tools/lib/subcmd/run-command.c                |   2 +
 tools/lib/subcmd/run-command.h                |   2 +
 tools/perf/tests/Build                        |   2 +-
 tools/perf/tests/builtin-test-list.c          | 207 ----------
 tools/perf/tests/builtin-test-list.h          |  12 -
 tools/perf/tests/builtin-test.c               | 369 ++++++++++--------
 tools/perf/tests/shell/lib/perf_has_symbol.sh |   2 +-
 tools/perf/tests/tests-scripts.c              | 257 ++++++++++++
 tools/perf/tests/tests-scripts.h              |   9 +
 tools/perf/util/print-events.c                |  12 +-
 tools/perf/util/thread_map.c                  |   9 +-
 tools/perf/util/util.c                        |  19 +
 tools/perf/util/util.h                        |   8 +
 13 files changed, 507 insertions(+), 403 deletions(-)
 delete mode 100644 tools/perf/tests/builtin-test-list.c
 delete mode 100644 tools/perf/tests/builtin-test-list.h
 create mode 100644 tools/perf/tests/tests-scripts.c
 create mode 100644 tools/perf/tests/tests-scripts.h

-- 
2.43.0.687.g38aa6559b0-goog


