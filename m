Return-Path: <linux-kernel+bounces-168410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F648BB843
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F85286A26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC784A56;
	Fri,  3 May 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riVmmT3U"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C482492
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778935; cv=none; b=tvH0YU2Dw+X86YX3/x0AzEmr4pg3WPA8kUGirGgaxa3sEbeBTu8PSpGYLrcnjwLOX/t9yxvN6eqOnm7VzPTIAsWWkyU/v7NVwuZC2HVdwGIEa7WJmUC6K27ZhCdiL+fw+k+GwaNN8ZbH6QdnGyKZv/HtlaiqigYevkEER0eC4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778935; c=relaxed/simple;
	bh=Wu152A3MYMOCDYS3ka/VAXl1xnRoga+OJkp5CTqqtUQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=J2o29nTaJ0V9vzGI2PUVg5MLoTG5bCkPDGPw+Frhm/Fn2p8SiwfyLOICqQOYKOLXUXKN6ySKrWGs85TFLBGDnNtWZvKntcP7Qyt+7ObIdgisvwrkavD6zfG3I7O7uz8ZU/wEYXIN7TYlRc+Psd89xaMmPq9nrOPRAy19kraZCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riVmmT3U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be530d024so2811527b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714778933; x=1715383733; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OUK2QAHKg6XvqT3wnheppijLOvk2sbqSOL0kLnQxZzs=;
        b=riVmmT3UgEErp0R4uu4ogKJkyI6XSlDJMYf9mqTx4NRc/9JwgHqM6B6BfFKAFybJl/
         5BxDWDpZt8RHF50XIG7+/00rAqPRBq6tQ5DZTCgzVkohbRfuQCDDUi6yNtxzqFoI2Eau
         DYEZxUOPH+vHNT5kFZrB6uvMv5ZtC9kGyamFWhg6v52QFUjWH6ZTvIc+v8RKYlhYYJri
         SN3/mpCH/tC2kX7YGFG4B8Bj+cIAQWbckC+8spsY7vM3MbeyiKVVDNYXLphT7CHFeP5Z
         4emwEvgYNaBQxo+/aDl9a4hHPuQysTiJOg0E0IvqL4rklYnyJrpd0qK94lhCqkgxSYKA
         igNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714778933; x=1715383733;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUK2QAHKg6XvqT3wnheppijLOvk2sbqSOL0kLnQxZzs=;
        b=aStXm5p75TMckCvid2903wwrVlAXCk80OoI2GdOFoUTqkpgm5v/fafHlGmbKN7ZCrx
         rR0qjau1eRCBXu06dDukmH5aZWNFpb9yNj77i/1ZRcj9uMiIUZPdJBvgtv6kB0uVUVwc
         psrw4jilrmOeLHiZoY5h7y+Eh4mywtOtFF7KgJDPnlfmNHFX+t0bmMMwlDGNgpR0P29D
         fYaxSbO4/n9XUPHHZ6qvijg10DeFlOgDnNpxqpXYYd8RUTELFx4OGwp8fdIPSzKNrVqu
         Sf0G5wTLA/06+Hfc8Sqd1I4FPwPoRwSKBOMSQ9DZHrYQ3G4mHu3Cfhi24forseXUsO7J
         tw9g==
X-Forwarded-Encrypted: i=1; AJvYcCU4+PEfWDuiYqG7kgdpAml0vgYLLPq8jH/t3sa1yu2YjPSJNcTvEiwLqEuSI/8VfdWvWcHa3ohW1FgRoy3Hhkon5DRlhSbYTrUgn2J5
X-Gm-Message-State: AOJu0YxRApo4E8ZUivR1vs+AgPJUvVZiIH6Ue75Gqt/ZY8DLocguwx0i
	nxjuPHOo4SWhQ6/vPfXlhYkM7Y0ZTv6r6g0Ok3FgcCWOMhkYgVmnhu+ybdwe3xLaJ/RGN6XwdhT
	SLsF79w==
X-Google-Smtp-Source: AGHT+IEDqcJkl+OXCSr9M83AsaQ1rdc0vrYm9SEHU47sm3AVxkiZ/UKhhhQf4XhbVm2AIUdjvM0J4Z/Zu9Qe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dec4:52bb:942:da64])
 (user=irogers job=sendgmr) by 2002:a05:6902:c0b:b0:de5:3003:4b83 with SMTP id
 fs11-20020a0569020c0b00b00de530034b83mr587523ybb.8.1714778932760; Fri, 03 May
 2024 16:28:52 -0700 (PDT)
Date: Fri,  3 May 2024 16:28:49 -0700
Message-Id: <20240503232849.17752-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v3] perf evsel: Refactor tool events
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
   By reading user_time and system_time this way, interval mode, per
   PID and per CPU can be supported although there are restrictions
   given what the files provide (e.g. per PID can't be combined with
   per CPU).

Opening any of the tool events for `perf record` is changed to return
invalid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3. v1 and v2 were posted as RFCs with retirement latency patches,
    this patch is now posted as standalone cleanup as we consider
    alternatives with the retirement latency implementation. The patch
    is updated to hopefully fix Namhyung's review feedback. user_time
    and system_time are opened with an all online CPUs cpu
    map. evsel's saved_times needs to be an xyarray to handle saving
    the original time value per PID or per CPU.
---
 tools/perf/builtin-stat.c      |  75 +++++------
 tools/perf/util/evsel.c        | 226 ++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h        |  14 ++
 tools/perf/util/parse-events.c |   7 +-
 4 files changed, 277 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 65a3dd7ffac3..01fc61d69b43 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -255,45 +255,38 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
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
+	if (err && cpu_map_idx == 0 &&
+	    (counter->tool_event == PERF_TOOL_USER_TIME ||
+	     counter->tool_event == PERF_TOOL_SYSTEM_TIME)) {
+		u64 val, *start_time;
+		struct perf_counts_values *count =
+			perf_counts(counter->counts, cpu_map_idx, thread);
+
+		start_time = xyarray__entry(counter->start_times, cpu_map_idx, thread);
+		if (counter->tool_event == PERF_TOOL_USER_TIME)
+			val = ru_stats.ru_utime_usec_stat.mean;
+		else
+			val = ru_stats.ru_stime_usec_stat.mean;
+		count->ena = count->run = *start_time + val;
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
@@ -311,7 +304,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
 		 * (via evsel__read_counter()) and sets their count->loaded.
 		 */
 		if (!perf_counts__is_loaded(counter->counts, cpu_map_idx, thread) &&
-		    read_single_counter(counter, cpu_map_idx, thread, rs)) {
+		    read_single_counter(counter, cpu_map_idx, thread)) {
 			counter->counts->scaled = -1;
 			perf_counts(counter->counts, cpu_map_idx, thread)->ena = 0;
 			perf_counts(counter->counts, cpu_map_idx, thread)->run = 0;
@@ -340,7 +333,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
 	return 0;
 }
 
-static int read_affinity_counters(struct timespec *rs)
+static int read_affinity_counters(void)
 {
 	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity saved_affinity, *affinity;
@@ -361,10 +354,8 @@ static int read_affinity_counters(struct timespec *rs)
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
@@ -388,11 +379,11 @@ static int read_bpf_map_counters(void)
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
@@ -423,7 +414,7 @@ static void process_interval(void)
 
 	evlist__reset_aggr_stats(evsel_list);
 
-	if (read_counters(&rs) == 0)
+	if (read_counters() == 0)
 		process_counters();
 
 	if (STAT_RECORD) {
@@ -911,7 +902,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * avoid arbitrary skew, we must read all counters before closing any
 	 * group leaders.
 	 */
-	if (read_counters(&(struct timespec) { .tv_nsec = t1-t0 }) == 0)
+	if (read_counters() == 0)
 		process_counters();
 
 	/*
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..d98415e1f0b7 100644
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
@@ -1487,6 +1489,9 @@ void evsel__exit(struct evsel *evsel)
 	evsel->per_pkg_mask = NULL;
 	zfree(&evsel->metric_events);
 	perf_evsel__object.fini(evsel);
+	if (evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
+	    evsel->tool_event == PERF_TOOL_USER_TIME)
+		xyarray__delete(evsel->start_times);
 }
 
 void evsel__delete(struct evsel *evsel)
@@ -1600,11 +1605,173 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 	return evsel__process_group_data(leader, cpu_map_idx, thread, data);
 }
 
+static bool read_until_char(struct io *io, char e)
+{
+	char c;
+
+	do {
+		c = io__get_char(io);
+		if (c == -1)
+			return false;
+	} while (c != e);
+	return true;
+}
+
+static int read_stat_field(int fd, struct perf_cpu cpu, int field, __u64 *val)
+{
+	char buf[256];
+	struct io io;
+	int i;
+
+	io__init(&io, fd, buf, sizeof(buf));
+
+	/* Skip lines to relevant CPU. */
+	for (i = -1; i < cpu.cpu; i++) {
+		if (!read_until_char(&io, '\n'))
+			return -EINVAL;
+	}
+	/* Skip to "cpu". */
+	if (io__get_char(&io) != 'c') return -EINVAL;
+	if (io__get_char(&io) != 'p') return -EINVAL;
+	if (io__get_char(&io) != 'u') return -EINVAL;
+
+	/* Skip N of cpuN. */
+	if (!read_until_char(&io, ' '))
+		return -EINVAL;
+
+	i = 1;
+	while (true) {
+		if (io__get_dec(&io, val) != ' ')
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
+	if (io__get_dec(&io, val) != ' ')
+		return -EINVAL;
+	if (field == 1)
+		return 0;
+
+	/* Skip comm. */
+	if (io__get_char(&io) != '(' || !read_until_char(&io, ')'))
+		return -EINVAL;
+	if (field == 2)
+		return -EINVAL; /* String can't be returned. */
+
+	/* Skip state */
+	if (io__get_char(&io) != ' ' || io__get_char(&io) == -1)
+		return -EINVAL;
+	if (field == 3)
+		return -EINVAL; /* String can't be returned. */
+
+	/* Loop over numeric fields*/
+	if (io__get_char(&io) != ' ')
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
+	__u64 *start_time, cur_time, delta_start;
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
+		start_time = &evsel->start_time;
+		if (cpu_map_idx == 0 && thread == 0)
+			cur_time = rdclock();
+		else
+			cur_time = *start_time;
+		break;
+	case PERF_TOOL_USER_TIME:
+	case PERF_TOOL_SYSTEM_TIME: {
+		bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+
+		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
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
+	delta_start = cur_time - *start_time;
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
@@ -1823,6 +1990,14 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
+	if ((evsel->tool_event == PERF_TOOL_SYSTEM_TIME ||
+	     evsel->tool_event == PERF_TOOL_USER_TIME) &&
+	    !evsel->start_times) {
+		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
+		if (!evsel->start_times)
+			return -ENOMEM;
+	}
+
 	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
 	if (evsel->cgrp)
 		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
@@ -2005,6 +2180,13 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
@@ -2037,6 +2219,46 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
+			if (evsel->tool_event == PERF_TOOL_USER_TIME ||
+			    evsel->tool_event == PERF_TOOL_SYSTEM_TIME) {
+				bool system = evsel->tool_event == PERF_TOOL_SYSTEM_TIME;
+				__u64 *start_time = NULL;
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
+				start_time = xyarray__entry(evsel->start_times, idx, thread);
+				if (pid > -1) {
+					err = read_pid_stat_field(fd, system ? 15 : 14,
+								  start_time);
+				} else {
+					struct perf_cpu cpu;
+
+					cpu = perf_cpu_map__cpu(evsel->core.cpus, idx);
+					err = read_stat_field(fd, cpu, system ? 3 : 1,
+							      start_time);
+				}
+				if (err)
+					goto out_close;
+				continue;
+			}
+
 			group_fd = get_group_fd(evsel, idx, thread);
 
 			if (group_fd == -2) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..d592dd9fb969 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -170,6 +170,20 @@ struct evsel {
 
 	/* for missing_features */
 	struct perf_pmu		*pmu;
+
+	/* For tool events */
+	/* Beginning time subtracted when the counter is read. */
+	union {
+		/* duration_time is a single global time. */
+		__u64 start_time;
+		/*
+		 * user_time and system_time read an initial value potentially
+		 * per-CPU or per-pid.
+		 */
+		struct xyarray *start_times;
+	};
+	/* Is the tool's fd for /proc/pid/stat or /proc/stat. */
+	bool pid_stat;
 };
 
 struct perf_missing_features {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0f308b4db2b9..a8866c0ce4b6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -308,11 +308,16 @@ static int add_event_tool(struct list_head *list, int *idx,
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_DUMMY,
 	};
+	const char *cpu_list = NULL;
 
+	if (tool_event == PERF_TOOL_DURATION_TIME) {
+		/* Duration time is gathered globally, pretend it is only on CPU0. */
+		cpu_list = "0";
+	}
 	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
 			    /*metric_id=*/NULL, /*pmu=*/NULL,
 			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
-			    /*cpu_list=*/"0");
+			    cpu_list);
 	if (!evsel)
 		return -ENOMEM;
 	evsel->tool_event = tool_event;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


