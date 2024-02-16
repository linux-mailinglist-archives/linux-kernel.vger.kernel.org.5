Return-Path: <linux-kernel+bounces-69508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADF858A63
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DA91F2177E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DADF14A098;
	Fri, 16 Feb 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzBfo8QJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6E714A08D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127716; cv=none; b=rJnCk4PIvWLBqzYFyCfdPkmMVym9KCAlCwlqc/GPAmybgEevJ2yNP1/rm2IdBluWfB05Gclfri8I5M0aBleepu+YxvLnNpFdkVukKVCq8Qlx4xm2/5agvOKW2HE5FGl4t+Iuhz1d3x5rFJKgcv1NDseoHZAm78Y+FMeC5emuyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127716; c=relaxed/simple;
	bh=1Dvtya1H7/PzNMqdtVJUl8hBgvbrmgnqki4J5eyi26c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=PiDLHErpIoefxa0e2IM2YyFvksQaCypFwosfsCb4AHks27UXqYErcvoF400s8JMlhag+3+2SMaKHahkm5zmQGSNRzeBkqgCU39jeEPi/pWiR9rKawyPAx6PR2IrYPpco6RrrscqZHzXT5RfpVdPXLfgeurCV0Ryj2VAyLceGzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzBfo8QJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso3663996276.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127712; x=1708732512; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBl8zgtekWPhTI5Bs2qcCKwIbqRGQ//OBxDNQEaVnho=;
        b=bzBfo8QJpzn1By3LMJZsELSoCDcddZwgB8ZPp4ZcOptyOoiQJkOBtt1GMXAo2dkyqM
         eL2id5WuZwVoBz1LTV5Ev+oMLKPHXG8XWA3jP54Rv+ng2KInBbFhDcINI4IUzBVURTlq
         WpS9GDgQCBIYPj3o0aa+d24e9nva2wVrgo/r2MFPc0E+XdUFPR1w/pLmzy0wrGheezLV
         ZrY6rt4pmqd/60sVd29qIU5Dg5WbWn/xYHki8WcWyAvfzuNm66j2/KqT6WLQHrAjCJky
         rbT5uevgEEMNsczT59YK84u9j4FFr+1YnWn+E1eLFBC2ZEcAb5murXDhnQ9aZLeOAY0O
         Ta8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127712; x=1708732512;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBl8zgtekWPhTI5Bs2qcCKwIbqRGQ//OBxDNQEaVnho=;
        b=hYhRTegkMN5wYr/eTZk/uyWdNGkoKZQfypRxV1MHuqPrUcHv07q0FTzJ8ba9jVPYZ5
         FG1tKrkctfsZY/CZm9oYWNB3IIIkMMVuAOBQQBRESgdnyA2r52R5t7Z2w7cu/qJan4vt
         BoVTFGrrJ01KHcYwMnvyKpnf+lsg9Lci0D+1u1/I739OI5PBislp5vbzhLBW8nYFRPUx
         L1qalIZCDiBHQ3cxJRCIyjDlO2S4byQzzmiVz9hh1j206qlF+TudUGnpBJvMvG6mFRUr
         LxVG+dAAd9MgnzuT/fiUs/7Jogbj3kz2WDzE8MzAkrdpQqlyegmRTdQ1HbrHzTpXIhwD
         6Crg==
X-Forwarded-Encrypted: i=1; AJvYcCW1YZ3mgZuyTF/Zu2PkMcg5hMo5mDbtzWr6QCkX/nSrw1M7N+E1M7BDuqE3EgQaaXaoOMTEO+7dmnomARtO7tUY0gzoyx7CqO85AH+b
X-Gm-Message-State: AOJu0Yzj9EfDfziwXwm7O8IweBbHqadWq65fnutiKEcthz0cvazQh3bp
	RbbHOCBmWgA+P2wpixS8d8oiJwoRwCO7UB3dmKsdNKziJusBJRKjspmkHIhix2Ns8HqMqU4azCf
	o+l/t+A==
X-Google-Smtp-Source: AGHT+IEMz+3RYNoGBF343NN7VH7kEkTuo9e+7EPD1rOracd954OtISvpyHGwVvDYBFvc29zPAHCM8qIzo6wC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a05:6902:1005:b0:dc7:59d9:7b46 with SMTP
 id w5-20020a056902100500b00dc759d97b46mr224264ybt.3.1708127712581; Fri, 16
 Feb 2024 15:55:12 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:54 -0800
Message-Id: <20240216235203.229256-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 0/8] Run tests in parallel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
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

v5 - fix a -Wunused-result
v4 - fix bug in width computation.
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
 tools/perf/tests/builtin-test.c               | 378 ++++++++++--------
 tools/perf/tests/shell/lib/perf_has_symbol.sh |   2 +-
 tools/perf/tests/tests-scripts.c              | 256 ++++++++++++
 tools/perf/tests/tests-scripts.h              |   9 +
 tools/perf/util/print-events.c                |  12 +-
 tools/perf/util/thread_map.c                  |   9 +-
 tools/perf/util/util.c                        |  19 +
 tools/perf/util/util.h                        |   8 +
 13 files changed, 508 insertions(+), 410 deletions(-)
 delete mode 100644 tools/perf/tests/builtin-test-list.c
 delete mode 100644 tools/perf/tests/builtin-test-list.h
 create mode 100644 tools/perf/tests/tests-scripts.c
 create mode 100644 tools/perf/tests/tests-scripts.h

-- 
2.44.0.rc0.258.g7320e95886-goog


