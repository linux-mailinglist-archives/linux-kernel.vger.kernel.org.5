Return-Path: <linux-kernel+bounces-161265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980038B49D5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63DF1C205BC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671FFBED;
	Sun, 28 Apr 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+QUlFSk"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EFBA41
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714282590; cv=none; b=gUEPs1qnNCgwzOwUNhb1WbrZeXeotWOxiYSZrs78/XTSQPCkcoTvdeMAp/f0/cESu4S/xB4K41o2d8l6fpZTyKIqs4sB7UsBWKbkrqhbUuC89uMaeesaML0Uah8RXRbGyns7aOThEmU4BdETDWzyc3O/6djElaxsmZVM/cKSylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714282590; c=relaxed/simple;
	bh=ds3FTpAVnoEQPwjyBLlVVQYAf2s8bYy/yXDtibgv24Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dTKK60WqQCyVpMXEj0eoo3uCKss8Ac0+h5uK6YPgKRR0IaA5aMUxwGhkAMyS5t37R88D3TnYnqi9GsvexQVhhx+x8Uh0l5mrSQe7dD0Od4OQ1qOSMP6SM08f/pbbwOnyL49jDI95kj0sbIEfcYORVEf8UtlOHRpHzvHmLx/Csa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+QUlFSk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d0b7ffaso6577287276.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 22:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714282588; x=1714887388; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEMBdRiSYAzLnQF6W26QVCloinXfU92DZLk227BSKkk=;
        b=h+QUlFSkXNj/FTzkYofHlX4Mqx2McsxdsrFP+DlVlLonnd28OaQf+7vSk3VvQJNeQk
         ME8JaeC3T2g/rX45zfGnB0LFwZ/cPc/qzviBxoa5vqPfcm9BMUUB2A91tElv81VvI0xu
         tuWZ4GKw5tix4u87ogM5FZLPWnDksWpLzfvmLE5TBueSNobCIPpWRO5EVypPmQ5TSNA4
         fgwILvILLX2CSU9jlIPuFZybGVBxdQpIRmvtKM/P+GiVpwtUyAXiFipMLoLHr9ihqA4Q
         Y/+uu8qlxOmrwOWMXfihfbEguuwk1jXxox+dF6NOlujriq6yW3FgsVxqLJo0esnW2nyX
         7q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714282588; x=1714887388;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEMBdRiSYAzLnQF6W26QVCloinXfU92DZLk227BSKkk=;
        b=ezPT6PTLM37pHndb9KF8QuOF8l0Kgx+oRoWt6lBRnWY98VTMOi0ZC1/5F5LwSlP2NR
         LS5Hyw9AdMRmb1z7ejhpYgdmhgMb/Q38lSzYewoibjdu91CThhLCu0wnNCtByrsoKv5D
         MP8JdqbSy941njTAwJbaUgq3Vi++ZPhIZW3Sxc1GYxrO8en4flPeGJF9TGIzgK7aza5N
         RMKoJXvc3dXNkvSRqrc985SAlrD6IcIWAW/pwSH57wjwcZ8qWPJcFX/RMJvFNAsJT536
         LR4OHTiQKIm42ewL6/VQxkNd0ox169gyc93Wug15OFZBFXJC3YlBHzOPZTlEKe44cP5T
         Xs1g==
X-Forwarded-Encrypted: i=1; AJvYcCUU2chntkrmwhqpb5n3PrbjpNp7fzAoYjPUwInMikoa43TAQsh0B0jAO0mJMFQ/cpFY7Swx8SsnGE1lIasx1COdNT7OEfAhbDgVs+Sk
X-Gm-Message-State: AOJu0YxnQYYQ86HkQpp/kmgVrcXsZE5SuqvRu+9tKP9nZlzmkGl/dcIi
	9HorSgdHXbi2Xg6ZcZtImos4oegAY2+N2zOVlY7/ZaF2TG4KMnxvEMNihXGsGnydPxlSPJD5ZLR
	gUn0iFg==
X-Google-Smtp-Source: AGHT+IHzqyKnSGf7Pk6gDt60ZrjYNxljd0CkcvR8nELq18HPFE76znx0vCTgauxHqqYDBN6fFbSAyL6qVedt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:eaaa:2f79:c83c:9def])
 (user=irogers job=sendgmr) by 2002:a25:aa63:0:b0:de4:654f:9ad0 with SMTP id
 s90-20020a25aa63000000b00de4654f9ad0mr702348ybi.6.1714282588141; Sat, 27 Apr
 2024 22:36:28 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:36:15 -0700
In-Reply-To: <20240428053616.1125891-1-irogers@google.com>
Message-Id: <20240428053616.1125891-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v2 3/3] perf evsel: Add retirement latency event support
From: Ian Rogers <irogers@google.com>
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a retirement latency event is processed it sets a flag on the
evsel. This change makes it so that when the flag is set evsel
opening, reading and exiting report values from child perf record and
perf report processes.

Something similar was suggested by Namhyung Kim in:
https://lore.kernel.org/lkml/CAM9d7cgdQQn5GYB7t++xuoMdeqPXiEkkcop69+rD06RAnu9-EQ@mail.gmail.com/

This is trying to add support for retirement latency directly in
events rather than through metric changes, as suggested by Weilin Wang in:
https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 186 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h |   3 +
 2 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a0a8aee7d6b9..17c123cddde3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -22,6 +22,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <signal.h>
 #include <stdlib.h>
 #include <perf/evsel.h>
 #include "asm/bug.h"
@@ -58,6 +59,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include <subcmd/run-command.h>
 
 #include <linux/ctype.h>
 
@@ -493,6 +495,162 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 }
 #endif
 
+static int evsel__start_retire_latency_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
+					  int cpu_map_idx)
+{
+	char buf[16];
+	int pipefd[2];
+	int err, i;
+	struct perf_cpu cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
+	struct child_process *child_record =
+		xyarray__entry(evsel->children, cpu_map_idx, 0);
+	struct child_process *child_report =
+		xyarray__entry(evsel->children, cpu_map_idx, 1);
+	char *event = strdup(evsel__name(evsel));
+	/* TODO: the dummy event also won't be used, but there's no option to disable. */
+	const char *record_argv[15] = {
+		[0] = "perf",
+		[1] = "record",
+		[2] = "--synth=no",
+		[3] = "--no-bpf-event",
+		[4] = "-W",
+		[5] = "-o",
+		[6] = "-",
+		[7] = "-e",
+	};
+	const char *report_argv[] = {
+		[0] = "perf",
+		[1] = "report",
+		[2] = "-i",
+		[3] = "-",
+		[4] = "-q",
+		[5] = "-F",
+		[6] = "retire_lat",
+		NULL,
+	};
+
+	if (evsel->core.attr.sample_period) /* no sampling */
+		return -EINVAL;
+
+	if (!event)
+		return -ENOMEM;
+
+	/* Change the R modifier to the maximum precision one. */
+	for (i = strlen(event) - 1; i > 0; i--) {
+		if (event[i] == 'R')
+			break;
+		if (event[i] == ':' || event[i] == '/')
+			i = 0;
+	}
+	if (i <= 0) {
+		pr_err("Expected retired latency 'R'\n");
+		return -EINVAL;
+	}
+	event[i] = 'P';
+
+	i = 8;
+	record_argv[i++] = event;
+	if (verbose) {
+		record_argv[i++] = verbose > 1 ? "-vv" : "-v";
+	}
+	if (cpu.cpu >= 0) {
+		record_argv[i++] = "-C";
+		snprintf(buf, sizeof(buf), "%d", cpu.cpu);
+		record_argv[i++] = buf;
+	} else {
+		record_argv[i++] = "-a";
+	}
+	/* TODO: use something like the control fds to control perf record behavior. */
+	record_argv[i++] = "sleep";
+	record_argv[i++] = "0.1";
+
+	if (pipe(pipefd) < 0) {
+		free(event);
+		return -errno;
+	}
+
+	child_record->argv = record_argv;
+	child_record->pid = -1;
+	child_record->no_stdin = 1;
+	if (verbose)
+		child_record->err = fileno(stderr);
+	else
+		child_record->no_stderr = 1;
+	child_record->out = pipefd[1];
+	err = start_command(child_record);
+	free(event);
+	if (err)
+		return err;
+
+	child_report->argv = report_argv;
+	child_report->pid = -1;
+	if (verbose)
+		child_report->err = fileno(stderr);
+	else
+		child_report->no_stderr = 1;
+	child_report->in = pipefd[0];
+	child_report->out = -1;
+	return start_command(child_report);
+}
+
+static int evsel__finish_retire_latency_cpu(struct evsel *evsel, int cpu_map_idx)
+{
+	struct child_process *child_record =
+		xyarray__entry(evsel->children, cpu_map_idx, 0);
+	struct child_process *child_report =
+		xyarray__entry(evsel->children, cpu_map_idx, 1);
+
+	if (child_record->pid > 0)
+		finish_command(child_record);
+	if (child_report->pid > 0)
+		finish_command(child_report);
+	return 0;
+}
+
+static int evsel__read_retire_latency(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	struct child_process *child_record = xyarray__entry(evsel->children, cpu_map_idx, 0);
+	struct child_process *child_report = xyarray__entry(evsel->children, cpu_map_idx, 1);
+	struct perf_counts_values *count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	char buf[256];
+	int err;
+
+	kill(child_record->pid, SIGTERM);
+	err = read(child_report->out, buf, sizeof(buf));
+	if (err < 0 || strlen(buf) == 0)
+		return -1;
+
+	count->val = atoll(buf);
+	count->ena = 1;
+	count->run = 1;
+	count->id = 0;
+	count->lost = 0;
+
+	/*
+	 * TODO: The SIGCHLD from the children exiting will cause interval mode
+	 *       to stop, use the control fd to avoid this.
+	 */
+	err = evsel__finish_retire_latency_cpu(evsel, cpu_map_idx);
+	if (err)
+		return err;
+
+	/* Restart the counter. */
+	return evsel__start_retire_latency_cpu(evsel, evsel->core.cpus, cpu_map_idx);
+}
+
+static int evsel__finish_retire_latency(struct evsel *evsel)
+{
+	int idx;
+
+	perf_cpu_map__for_each_idx(idx, evsel->core.cpus) {
+		int err = evsel__finish_retire_latency_cpu(evsel, idx);
+
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
 	"cycles",
 	"instructions",
@@ -1465,6 +1623,10 @@ static void evsel__free_config_terms(struct evsel *evsel)
 
 void evsel__exit(struct evsel *evsel)
 {
+	if (evsel->children) {
+		evsel__finish_retire_latency(evsel);
+		zfree(&evsel->children);
+	}
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
 	bpf_counter__destroy(evsel);
@@ -1778,6 +1940,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__read_tool(evsel, cpu_map_idx, thread);
 
+	if (evsel->retire_lat)
+		return evsel__read_retire_latency(evsel, cpu_map_idx, thread);
+
 	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
 
@@ -1993,10 +2158,22 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		threads = empty_thread_map;
 	}
 
-	if (evsel->core.fd == NULL &&
+	if (!evsel->retire_lat && evsel->core.fd == NULL &&
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
+	if (evsel->retire_lat && evsel->children == NULL) {
+		/*
+		 * Use ylen of 2, [0] is the record and [1] is the report
+		 * command. Currently retirement latency doesn't support
+		 * per-thread mode.
+		 */
+		evsel->children = xyarray__new(perf_cpu_map__nr(cpus), /*ylen=*/2,
+					sizeof(struct child_process));
+		if (!evsel->children)
+			return -ENOMEM;
+	}
+
 	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
 	if (evsel->cgrp)
 		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
@@ -2209,6 +2386,13 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 
+		if (evsel->retire_lat) {
+			err = evsel__start_retire_latency_cpu(evsel, cpus, idx);
+			if (err)
+				goto out_close;
+			continue;
+		}
+
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
 retry_open:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index bd8e84954e34..3c0806436e64 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -177,6 +177,9 @@ struct evsel {
 	__u64 start_time;
 	/* Is the tool's fd for /proc/pid/stat or /proc/stat. */
 	bool pid_stat;
+
+	/* Used for retire_lat child process. */
+	struct xyarray *children;
 };
 
 struct perf_missing_features {
-- 
2.44.0.769.g3c40516874-goog


