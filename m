Return-Path: <linux-kernel+bounces-133796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A089A8D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BE8B22041
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764E18029;
	Sat,  6 Apr 2024 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8QItgEn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5BB1B812
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712376563; cv=none; b=oxMBryoHlYgL/mCuKtgOjhBGF5CXASilI5zOHiFHMR9T5N3a8hsxa+NjGIUr0YyYJTd++BgidCK9NXlUPiM2JiPZhBLRU0uCJB+f+lwkuqBtb84VmeNM1g4J1TVkpHejImUQAPJG4xJP2c/kPhkUksSI/JF+8ioVVcKLGA8gFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712376563; c=relaxed/simple;
	bh=juPnXzP618xWObDkf1iUj+LsRWuVKPa2Y4ItrduMxq0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H2uYO83FGyVbP6PM+NbRbn0Ejf5ffqsRM9i464KJptltz6Jyf0z5UZqhKe8NrQvTfKiJwq8MeRsxBlIhdvVK0qXdnzu8R45tiTd7J3binWR/M/PIONSd9/YLmXEceHAFsDsuhnQXs31LMyKSbFwu90vy9+36CmkeULmDYSd51Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8QItgEn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so48308067b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 21:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712376561; x=1712981361; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6CfeKOKugD2wHzsxUq+tzYMTN2fGH3EGK3TX/G0kaY=;
        b=U8QItgEneV0nrbeFlyb00Ii1SS5i04UN6IZrhpWjLgjAQF1z56K1sudQSWhH6THENP
         XkBQNQD9uWjB88HJ2d6HqTF+tBvpvAvJx9rJSXwnXfIiXf/CQrjAd4AU5iDiARLKsvEp
         Yrlfz7RNwLtLL4+EtvKbPfcphSNEN9Z9/N432sSrJVExqNbLMbGAPGNWizbayqaCVdIv
         jBo3P1ubEx15MFTqphEWoKpQOl8hy5qTDOobtxG/WNSmG56EHqA5iD+eJUBo1pIGKtuv
         y3G+iqmrdB4gRhZdyN/BKe5VsomhdLfb6xqPsZjk6Ziko0C3zW8iaabJlyxGWNCs49Na
         VVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712376561; x=1712981361;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6CfeKOKugD2wHzsxUq+tzYMTN2fGH3EGK3TX/G0kaY=;
        b=KsDfa9rzPf+T3zZwyC6lqFp4gCR/m7dXdQoB1IVqKymYJxG/1OGzhkhjnrLo+sG0rB
         fAJ70lQ8hbJdix8stT4lVyHWwbyq2q62wierraxXIAOSUHEnGeUFOaiejVF7UirGQGxD
         Q4Epxlm4HjXjOJSKiKLmUQoWHKa7gP7ol4tlhanCjGsRQX4lV1yI1BcCbmZrMZA2GWN/
         1BAyeO6eRzruPbQILLSOKz30aYmc8IOXonrQgmnvoBX8qkqjFnYHqRCXvDozjZog9Fdl
         vz/7oHBMX/NPcag86AsGYalcj91ZlOF2gzcxW6xgnnMjbFUvJyovL/29ZM7Vuuj3EVQ9
         TJiA==
X-Forwarded-Encrypted: i=1; AJvYcCUgC0VnwYAuN2+Nox5XHPo/qpBvbp3BjtxSKhzRt/uBWBYMrJc0ESJC8qc4LF47vtFlUu6nhdujyBthEemcqcSfet1cwlnsJMqVD9mH
X-Gm-Message-State: AOJu0YwRYmbzqK6ZqAwORiZ8YDEGKh0xOymuHc1P6CBm4OnBlPkQSUSX
	XH8acNdEmakW2LIihdpQwZ0PjIgJrGCkXY+67kT817l/8nQ5B6/W4mfPMISCsa2pnSOzyQCNDi1
	ZAHbhDA==
X-Google-Smtp-Source: AGHT+IGKdPN5hUTbwKOwQZ1f9rtbG1LHGY0ZdYTo9IZKVqZ2bXxgEHgJCHIFKCtc+jY7dFopC7vL4/p0oAeC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51c1:e2b:9198:3cdc])
 (user=irogers job=sendgmr) by 2002:a05:690c:4509:b0:615:19db:8ee0 with SMTP
 id gt9-20020a05690c450900b0061519db8ee0mr767763ywb.1.1712376560891; Fri, 05
 Apr 2024 21:09:20 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:09:11 -0700
In-Reply-To: <20240406040911.1603801-1-irogers@google.com>
Message-Id: <20240406040911.1603801-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240406040911.1603801-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 2/2] perf bench uprobe: Add uretprobe variant of uprobe benchmarks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kees Cook <keescook@chromium.org>, 
	Andrei Vagin <avagin@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Name benchmarks with _ret at the end to avoid creating a new set of
benchmarks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/bench.h                    |  2 ++
 tools/perf/bench/uprobe.c                   | 20 +++++++++++++++++---
 tools/perf/builtin-bench.c                  |  2 ++
 tools/perf/util/bpf_skel/bench_uprobe.bpf.c | 16 ++++++++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index faa18e6d2467..9f736423af53 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -46,6 +46,8 @@ int bench_breakpoint_enable(int argc, const char **argv);
 int bench_uprobe_baseline(int argc, const char **argv);
 int bench_uprobe_empty(int argc, const char **argv);
 int bench_uprobe_trace_printk(int argc, const char **argv);
+int bench_uprobe_empty_ret(int argc, const char **argv);
+int bench_uprobe_trace_printk_ret(int argc, const char **argv);
 int bench_pmu_scan(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index b722ff88fe7d..0b90275862e1 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -26,9 +26,11 @@
 static int loops = LOOPS_DEFAULT;
 
 enum bench_uprobe {
-        BENCH_UPROBE__BASELINE,
-        BENCH_UPROBE__EMPTY,
-        BENCH_UPROBE__TRACE_PRINTK,
+	BENCH_UPROBE__BASELINE,
+	BENCH_UPROBE__EMPTY,
+	BENCH_UPROBE__TRACE_PRINTK,
+	BENCH_UPROBE__EMPTY_RET,
+	BENCH_UPROBE__TRACE_PRINTK_RET,
 };
 
 static const struct option options[] = {
@@ -81,6 +83,8 @@ static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 	case BENCH_UPROBE__BASELINE:							break;
 	case BENCH_UPROBE__EMPTY:	 bench_uprobe__attach_uprobe(empty);		break;
 	case BENCH_UPROBE__TRACE_PRINTK: bench_uprobe__attach_uprobe(trace_printk);	break;
+	case BENCH_UPROBE__EMPTY_RET:	 bench_uprobe__attach_uprobe(empty_ret);	break;
+	case BENCH_UPROBE__TRACE_PRINTK_RET: bench_uprobe__attach_uprobe(trace_printk_ret); break;
 	default:
 		fprintf(stderr, "Invalid bench: %d\n", bench);
 		goto cleanup;
@@ -197,3 +201,13 @@ int bench_uprobe_trace_printk(int argc, const char **argv)
 {
 	return bench_uprobe(argc, argv, BENCH_UPROBE__TRACE_PRINTK);
 }
+
+int bench_uprobe_empty_ret(int argc, const char **argv)
+{
+	return bench_uprobe(argc, argv, BENCH_UPROBE__EMPTY_RET);
+}
+
+int bench_uprobe_trace_printk_ret(int argc, const char **argv)
+{
+	return bench_uprobe(argc, argv, BENCH_UPROBE__TRACE_PRINTK_RET);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 1a8898d5b560..2c1a9f3d847a 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -109,6 +109,8 @@ static struct bench uprobe_benchmarks[] = {
 	{ "baseline",	"Baseline libc usleep(1000) call",				bench_uprobe_baseline,	},
 	{ "empty",	"Attach empty BPF prog to uprobe on usleep, system wide",	bench_uprobe_empty,	},
 	{ "trace_printk", "Attach trace_printk BPF prog to uprobe on usleep syswide",	bench_uprobe_trace_printk,	},
+	{ "empty_ret",	"Attach empty BPF prog to uretprobe on usleep, system wide",	bench_uprobe_empty_ret,	},
+	{ "trace_printk_ret", "Attach trace_printk BPF prog to uretprobe on usleep syswide", bench_uprobe_trace_printk_ret,},
 	{ NULL,	NULL, NULL },
 };
 
diff --git a/tools/perf/util/bpf_skel/bench_uprobe.bpf.c b/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
index 2c55896bb33c..a01c7f791fcd 100644
--- a/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
+++ b/tools/perf/util/bpf_skel/bench_uprobe.bpf.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 
 unsigned int nr_uprobes;
+unsigned int nr_uretprobes;
 
 SEC("uprobe")
 int BPF_UPROBE(empty)
@@ -20,4 +21,19 @@ int BPF_UPROBE(trace_printk)
 	return 0;
 }
 
+SEC("uretprobe")
+int BPF_URETPROBE(empty_ret)
+{
+	return 0;
+}
+
+SEC("uretprobe")
+int BPF_URETPROBE(trace_printk_ret)
+{
+	char fmt[] = "perf bench uretprobe %u";
+
+	bpf_trace_printk(fmt, sizeof(fmt), ++nr_uretprobes);
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.44.0.478.gd926399ef9-goog


