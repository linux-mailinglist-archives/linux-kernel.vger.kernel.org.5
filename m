Return-Path: <linux-kernel+bounces-161263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D88B49D3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0451F2174B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04AB642;
	Sun, 28 Apr 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V95qcKcs"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9C748E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714282585; cv=none; b=CqG3tsM8/w0Ci987IAgnLZ+Cc64r7iukGNwz8aUen1fDKX7ptJbXmLowSqUq82kYOFP08L+c97q23WGyq/uqkmmXIALRa8ImzM0LYOeeFQ0FPOFU1rvBGAXUPn20ZFIxQH3QkqYBZoKhV99INDIS0ax9OtucwqvUy0XG19wVGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714282585; c=relaxed/simple;
	bh=EWdP+7COA2xba+bx5qQfd0FHHHhd2CSIwhRcuRcZK4U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rpa0tp5FBdN/r5HW/6YVOA0PCXxRizWCk+z2RofnsPdPCGAcXq0y8+RZwlY8W3WUxcMDlVqTnQvZw5pgcn2+SNYW+rws67eu7ehZ/1iS89NWzRBEyDGO9RhzkG4jaxhy2SEhfMsVf/us/JX5is+8zVOqMR0mkp5YvFkeEK7C2N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V95qcKcs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e4d22f83a7so32740895ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714282583; x=1714887383; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsdmaBlcSPO/fRHlcFv0cg2y7UrKxiHMlbNG9JYitIs=;
        b=V95qcKcs825ZPzS1E6Wk0q51RL44mtbJn8xvvwree1no7HFUnJaOs07lO9mXpo8JO7
         STs/RhY26PBFXv8WnX/AkweGSQXrXu86hHxjrJvIVXJJ5Z8pLNLb3HOwdH3UNpMxRDqu
         GATM24bDcTlVggX/7xFOVJcl/HC1kDuFDPfRWhaodjQ13YW58+Ox15/gOFyK+J2jwsri
         h712+a6qWDJyvZnzrqviiHA6ALUrM1dZ7lR5/N7zUfggn1HUUGzgTy8QqNSTLed4O+3z
         plQA3voDKFd5MVSB4YRj6byv+n4o9BmPdnNfK+E1qn7N3Ss911TQcvAe/h1sQzgZR66M
         RbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714282583; x=1714887383;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsdmaBlcSPO/fRHlcFv0cg2y7UrKxiHMlbNG9JYitIs=;
        b=wBleikTV+fKzhCkB3+2GQ+coj1PuBWS9JSTUuSaO11kdo2rFhVnz+tq1CO/UD35SVY
         PjnYvRfGdul4wgXNTT84UJiBLZivhISUrcn64X5O0K/YLvf6sW9y2yYCGs6GKXSaLFwI
         bAJCS3xr2q6suAvrXrj3ouuoZinZGZv6ic9otxYHM2ZiZ7Rqz065WKB6x4TkrfbS98VH
         WAdtjQnYY2zdJ6Qwr9ZRL51DvF/eGO5I/GyAKjie6LZeXcTKbhSHzUPhBH2kGjs7gBaD
         6ly+IIht1Q/CF60ioEQsOMhiKi6GRF4ctzJ10BcbSPDSMAzPwull3OFyxFSNJTZUgBzG
         7gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj9Xt4zLud0kB8qf1EeOy9vXiHoEa7If0OYIcYdEpOU3bUfPzBkPh8LsdzosY3D2zIfePbAny0xCIBtqzeTa46BFRW33vOxguFZsZY
X-Gm-Message-State: AOJu0YwY+Q5mjyR0Hh9h+nt/ypEOV0a7NX1D/mdVnQaLHyepxNvk+WtG
	9oHSbtW2tP5WKiHU4fzraYttR3dJ1UcXqc+67uH5dPMiLRrIxurRSy3F74+1KGPzCRLafRX9ajL
	bqB1Ttg==
X-Google-Smtp-Source: AGHT+IFmAmFeL0NHyMvi9/pFcmepNocBq8xT8lE6DutuOHSb2FJufJTaSCPx21H2vi9U0VDIaCXqv4Gb5Jel
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:eaaa:2f79:c83c:9def])
 (user=irogers job=sendgmr) by 2002:a17:902:e888:b0:1e5:1158:e44d with SMTP id
 w8-20020a170902e88800b001e51158e44dmr507815plg.2.1714282582913; Sat, 27 Apr
 2024 22:36:22 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:36:13 -0700
In-Reply-To: <20240428053616.1125891-1-irogers@google.com>
Message-Id: <20240428053616.1125891-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v2 1/3] perf evsel: Refactor tool events
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

Tool events unnecessarily open a dummy perf event which is useless
even with `perf record` which will still open a dummy event. Change
the behavior of tool events so:

 - duration_time - call `rdclock` on open and then report the count as
   a delta since the start in evsel__read_counter. This moves code out
   of builtin-stat making it more general purpose.

 - user_time/system_time - open the fd as either `/proc/pid/stat` or
   `/proc/stat` for cases like system wide. evsel__read_counter will
   read the appropriate field out of the procfs file. These values
   were previously supplied by wait4, if the procfs read fails then
   the wait4 values are used, assuming the process/thread terminated.
   By reading user_time and system_time this way, interval mode can be
   supported.

Opening any of the tool events for `perf record` returns invalid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c |  74 ++++++-------
 tools/perf/util/evsel.c   | 223 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h   |   6 +
 3 files changed, 259 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 65a3dd7ffac3..428e9721b908 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -255,45 +255,37 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
 					   process_synthesized_event, NULL);
 }
 
-static int read_single_counter(struct evsel *counter, int cpu_map_idx,
-			       int thread, struct timespec *rs)
-{
-	switch(counter->tool_event) {
-		case PERF_TOOL_DURATION_TIME: {
-			u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
-			struct perf_counts_values *count =
-				perf_counts(counter->counts, cpu_map_idx, thread);
-			count->ena = count->run = val;
-			count->val = val;
-			return 0;
-		}
-		case PERF_TOOL_USER_TIME:
-		case PERF_TOOL_SYSTEM_TIME: {
-			u64 val;
-			struct perf_counts_values *count =
-				perf_counts(counter->counts, cpu_map_idx, thread);
-			if (counter->tool_event == PERF_TOOL_USER_TIME)
-				val = ru_stats.ru_utime_usec_stat.mean;
-			else
-				val = ru_stats.ru_stime_usec_stat.mean;
-			count->ena = count->run = val;
-			count->val = val;
-			return 0;
-		}
-		default:
-		case PERF_TOOL_NONE:
-			return evsel__read_counter(counter, cpu_map_idx, thread);
-		case PERF_TOOL_MAX:
-			/* This should never be reached */
-			return 0;
+static int read_single_counter(struct evsel *counter, int cpu_map_idx, int thread)
+{
+	int err = evsel__read_counter(counter, cpu_map_idx, thread);
+
+	/*
+	 * Reading user and system time will fail when the process
+	 * terminates. Use the wait4 values in that case.
+	 */
+	if (err &&
+	    (counter->tool_event == PERF_TOOL_USER_TIME ||
+	     counter->tool_event == PERF_TOOL_SYSTEM_TIME)) {
+		u64 val;
+		struct perf_counts_values *count =
+			perf_counts(counter->counts, cpu_map_idx, thread);
+
+		if (counter->tool_event == PERF_TOOL_USER_TIME)
+			val = ru_stats.ru_utime_usec_stat.mean;
+		else
+			val = ru_stats.ru_stime_usec_stat.mean;
+		count->ena = count->run = val;
+		count->val = val;
+		return 0;
 	}
+	return err;
 }
 
 /*
  * Read out the results of a single counter:
  * do not aggregate counts across CPUs in system-wide mode
  */
-static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_map_idx)
+static int read_counter_cpu(struct evsel *counter, int cpu_map_idx)
 {
 	int nthreads = perf_thread_map__nr(evsel_list->core.threads);
 	int thread;
@@ -311,7 +303,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
 		 * (via evsel__read_counter()) and sets their count->loaded.
 		 */
 		if (!perf_counts__is_loaded(counter->counts, cpu_map_idx, thread) &&
-		    read_single_counter(counter, cpu_map_idx, thread, rs)) {
+		    read_single_counter(counter, cpu_map_idx, thread)) {
 			counter->counts->scaled = -1;
 			perf_counts(counter->counts, cpu_map_idx, thread)->ena = 0;
 			perf_counts(counter->counts, cpu_map_idx, thread)->run = 0;
@@ -340,7 +332,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
 	return 0;
 }
 
-static int read_affinity_counters(struct timespec *rs)
+static int read_affinity_counters(void)
 {
 	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity saved_affinity, *affinity;
@@ -361,10 +353,8 @@ static int read_affinity_counters(struct timespec *rs)
 		if (evsel__is_bpf(counter))
 			continue;
 
-		if (!counter->err) {
-			counter->err = read_counter_cpu(counter, rs,
-							evlist_cpu_itr.cpu_map_idx);
-		}
+		if (!counter->err)
+			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
 	}
 	if (affinity)
 		affinity__cleanup(&saved_affinity);
@@ -388,11 +378,11 @@ static int read_bpf_map_counters(void)
 	return 0;
 }
 
-static int read_counters(struct timespec *rs)
+static int read_counters(void)
 {
 	if (!stat_config.stop_read_counter) {
 		if (read_bpf_map_counters() ||
-		    read_affinity_counters(rs))
+		    read_affinity_counters())
 			return -1;
 	}
 	return 0;
@@ -423,7 +413,7 @@ static void process_interval(void)
 
 	evlist__reset_aggr_stats(evsel_list);
 
-	if (read_counters(&rs) == 0)
+	if (read_counters() == 0)
 		process_counters();
 
 	if (STAT_RECORD) {
@@ -911,7 +901,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * avoid arbitrary skew, we must read all counters before closing any
 	 * group leaders.
 	 */
-	if (read_counters(&(struct timespec) { .tv_nsec = t1-t0 }) == 0)
+	if (read_counters() == 0)
 		process_counters();
 
 	/*
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..a0a8aee7d6b9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/bitops.h>
+#include <api/io.h>
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <linux/hw_breakpoint.h>
@@ -30,6 +31,7 @@
 #include "counts.h"
 #include "event.h"
 #include "evsel.h"
+#include "time-utils.h"
 #include "util/env.h"
 #include "util/evsel_config.h"
 #include "util/evsel_fprintf.h"
@@ -1600,11 +1602,183 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 	return evsel__process_group_data(leader, cpu_map_idx, thread, data);
 }
 
+static int read_stat_field(int fd, struct perf_cpu cpu, int field, __u64 *val)
+{
+	char buf[256];
+	struct io io;
+	int c, i;
+
+	io__init(&io, fd, buf, sizeof(buf));
+
+	/* Skip lines to relevant CPU. */
+	for (i = -1; i < cpu.cpu; i++) {
+		do {
+			c = io__get_char(&io);
+			if (c == -1)
+				return -EINVAL;
+		} while (c != '\n');
+	}
+	/* Skip to "cpu". */
+	c = io__get_char(&io);
+	if (c != 'c')
+		return -EINVAL;
+	c = io__get_char(&io);
+	if (c != 'p')
+		return -EINVAL;
+	c = io__get_char(&io);
+	if (c != 'u')
+		return -EINVAL;
+	/* Skip N of cpuN. */
+	do {
+		c = io__get_char(&io);
+		if (c == -1)
+			return -EINVAL;
+	} while (c != ' ');
+
+	i = 1;
+	while (true) {
+		c = io__get_dec(&io, val);
+		if (c != ' ')
+			break;
+		if (field == i)
+			return 0;
+		i++;
+	}
+	return -EINVAL;
+}
+
+static int read_pid_stat_field(int fd, int field, __u64 *val)
+{
+	char buf[256];
+	struct io io;
+	int c, i;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	c = io__get_dec(&io, val);
+	if (c != ' ')
+		return -EINVAL;
+	if (field == 1)
+		return 0;
+
+	/* Skip comm. */
+	c = io__get_char(&io);
+	if (c != '(')
+		return -EINVAL;
+	do {
+		c = io__get_char(&io);
+		if (c == -1)
+			return -EINVAL;
+	} while (c != ')');
+	if (field == 2)
+		return -EINVAL;
+
+	/* Skip state */
+	c = io__get_char(&io);
+	if (c != ' ')
+		return -EINVAL;
+	c = io__get_char(&io);
+	if (c == -1)
+		return -EINVAL;
+	if (field == 3)
+		return -EINVAL;
+
+	/* Loop over numeric fields*/
+	c = io__get_char(&io);
+	if (c != ' ')
+		return -EINVAL;
+
+	i = 4;
+	while (true) {
+		c = io__get_dec(&io, val);
+		if (c == -1)
+			return -EINVAL;
+		if (c == -2) {
+			/* Assume a -ve was read */
+			c = io__get_dec(&io, val);
+			*val *= -1;
+		}
+		if (c != ' ')
+			return -EINVAL;
+		if (field == i)
+			return 0;
+		i++;
+	}
+	return -EINVAL;
+}
+
+static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	__u64 cur_time, delta_start;
+	int fd, err = 0;
+	struct perf_counts_values *count;
+	bool adjust = false;
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+
+	switch (evsel->tool_event) {
+	case PERF_TOOL_DURATION_TIME:
+		/*
+		 * Pretend duration_time is only on the first CPU and thread, or
+		 * else aggregation will scale duration_time by the number of
+		 * CPUs/threads.
+		 */
+		if (cpu_map_idx == 0 && thread == 0)
+			cur_time = rdclock();
+		else
+			cur_time = evsel->start_time;
+		break;
+	case PERF_TOOL_USER_TIME:
+	case PERF_TOOL_SYSTEM_TIME: {
+		bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+
+		fd = FD(evsel, cpu_map_idx, thread);
+		lseek(fd, SEEK_SET, 0);
+		if (evsel->pid_stat) {
+			/* The event exists solely on 1 CPU. */
+			if (cpu_map_idx == 0)
+				err = read_pid_stat_field(fd, system ? 15 : 14, &cur_time);
+			else
+				cur_time = 0;
+		} else {
+			/* The event is for all threads. */
+			if (thread == 0) {
+				struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus,
+									cpu_map_idx);
+
+				err = read_stat_field(fd, cpu, system ? 3 : 1, &cur_time);
+			} else {
+				cur_time = 0;
+			}
+		}
+		adjust = true;
+		break;
+	}
+	case PERF_TOOL_NONE:
+	case PERF_TOOL_MAX:
+	default:
+		err = -EINVAL;
+	}
+	if (err)
+		return err;
+
+	delta_start = cur_time - evsel->start_time;
+	if (adjust) {
+		__u64 ticks_per_sec = sysconf(_SC_CLK_TCK);
+
+		delta_start *= 1000000000 / ticks_per_sec;
+	}
+	count->val    = delta_start;
+	count->ena    = count->run = delta_start;
+	count->lost   = 0;
+	return 0;
+}
+
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	u64 read_format = evsel->core.attr.read_format;
+	if (evsel__is_tool(evsel))
+		return evsel__read_tool(evsel, cpu_map_idx, thread);
 
-	if (read_format & PERF_FORMAT_GROUP)
+	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
 
 	return evsel__read_one(evsel, cpu_map_idx, thread);
@@ -2005,6 +2179,13 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
 
+	if (evsel->tool_event == PERF_TOOL_DURATION_TIME) {
+		if (evsel->core.attr.sample_period) /* no sampling */
+			return -EINVAL;
+		evsel->start_time = rdclock();
+		return 0;
+	}
+
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
 		return err;
@@ -2037,6 +2218,44 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
+			if (evsel->tool_event == PERF_TOOL_USER_TIME ||
+			    evsel->tool_event == PERF_TOOL_SYSTEM_TIME) {
+				bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+
+				if (evsel->core.attr.sample_period) {
+					/* no sampling */
+					err = -EINVAL;
+					goto out_close;
+				}
+				if (pid > -1) {
+					char buf[64];
+
+					snprintf(buf, sizeof(buf), "/proc/%d/stat", pid);
+					fd = open(buf, O_RDONLY);
+					evsel->pid_stat = true;
+				} else {
+					fd = open("/proc/stat", O_RDONLY);
+				}
+				FD(evsel, idx, thread) = fd;
+				if (fd < 0) {
+					err = -errno;
+					goto out_close;
+				}
+				if (pid > -1) {
+					err = read_pid_stat_field(fd, system ? 15 : 14,
+								  &evsel->start_time);
+				} else {
+					struct perf_cpu cpu;
+
+					cpu = perf_cpu_map__cpu(evsel->core.cpus, idx);
+					err = read_stat_field(fd, cpu, system ? 3 : 1,
+							      &evsel->start_time);
+				}
+				if (err)
+					goto out_close;
+				continue;
+			}
+
 			group_fd = get_group_fd(evsel, idx, thread);
 
 			if (group_fd == -2) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..43f6fd1dcb4d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -170,6 +170,12 @@ struct evsel {
 
 	/* for missing_features */
 	struct perf_pmu		*pmu;
+
+	/* For tool events */
+	/* Beginning time subtracted when the counter is read. */
+	__u64 start_time;
+	/* Is the tool's fd for /proc/pid/stat or /proc/stat. */
+	bool pid_stat;
 };
 
 struct perf_missing_features {
-- 
2.44.0.769.g3c40516874-goog


