Return-Path: <linux-kernel+bounces-57677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62EC84DC1B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACC91F23364
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681976D1AE;
	Thu,  8 Feb 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMLR9sKF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F56D1DA;
	Thu,  8 Feb 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382427; cv=none; b=hYskdplYnV6cS04n2m78L7GcbN0tZ6l7QRITXWtqsygr0B9HNZntBZQw8mTGK6dNE0eLyWSE8rmQEjFzg5rVD8vHE0ui4Vg7vnrvWVT23QH8W0e65n7LMTtXx7rjp+NzmMVoh4JWA3Wx4HaOKaw2jT327SIAJN/Vqp7GHl6f8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382427; c=relaxed/simple;
	bh=liuCnYvj43a4tXuQpW3mnRUkdN4KcCl1EfuqJpVLEwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LntnfmXP+av6Nxq/0jA5FlJpr8t7CA9+YGjCEalo9auAvMLRx3nAbsAtm55I9rwtqMQUXc4lXzq5CgRXL5xxlAeqlytWssUJcOA5jmPvGzfN3fnfWDHgU4uKJsl6MNY4BQx7MP/l5UitcYXIxuBMD2VBSYVNCqjJbAAefg/KYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMLR9sKF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382425; x=1738918425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=liuCnYvj43a4tXuQpW3mnRUkdN4KcCl1EfuqJpVLEwo=;
  b=WMLR9sKF0sFT/KEY/V6MJnG+SS1Tks+O41UrBvzZBRd/pqk8Nm92C613
   Owiwl2wcMPkyYNk7YVqMGswETfW6qYzCa+mZ0rDkW8TPPgG9gD0rXCw5y
   gL1ACtmQPl4kKZFYMmf6RPSEjny6+TMA6TAoQy1SnC8o/I8QUPbbqC3yD
   /WLrZOFlg1Wp7vV+aq/qWPCYTlPgKKDw+R9UU9sxhZ5Yv7UxmBFUqG/jG
   m2W13HiZuvZfsq/7aDD7nwWEWlr1ZSKZ3BFUsYopypwJoXGfLFWC4zhWp
   +6a+Ws12uyHETlRA5D+Pm8t5zWvfDvqmWL2Fcl9pXUeWz2k+Q6WPYWm37
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1329202"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1329202"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:53:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1589486"
Received: from lnielsex-mobl.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:53:40 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V3 1/2] perf tools: Make it possible to see perf's kernel and module memory mappings
Date: Thu,  8 Feb 2024 10:53:25 +0200
Message-Id: <20240208085326.13432-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208085326.13432-1-adrian.hunter@intel.com>
References: <20240208085326.13432-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Dump kmaps if using 'perf --debug kmaps' or verbose > 2 (e.g. -vvv) for
tools 'perf script' and 'perf report' if there is no browser.

Example:

  $ perf --debug kmaps script 2>&1 >/dev/null | grep kvm.intel
  build id event received for /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko: 0691d75e10e72ebbbd45a44c59f6d00a5604badf [20]
  Map: 0-3a3 4f5d8 [kvm_intel].modinfo
  Map: 0-5240 5f280 [kvm_intel]__versions
  Map: 0-30 64 [kvm_intel].note.Linux
  Map: 0-14 644c0 [kvm_intel].orc_header
  Map: 0-5297 43680 [kvm_intel].rodata
  Map: 0-5bee 3b837 [kvm_intel].text.unlikely
  Map: 0-7e0 41430 [kvm_intel].noinstr.text
  Map: 0-2080 713c0 [kvm_intel].bss
  Map: 0-26 705c8 [kvm_intel].data..read_mostly
  Map: 0-5888 6a4c0 [kvm_intel].data
  Map: 0-22 70220 [kvm_intel].data.once
  Map: 0-40 705f0 [kvm_intel].data..percpu
  Map: 0-1685 41d20 [kvm_intel].init.text
  Map: 0-4b8 6fd60 [kvm_intel].init.data
  Map: 0-380 70248 [kvm_intel]__dyndbg
  Map: 0-8 70218 [kvm_intel].exit.data
  Map: 0-438 4f980 [kvm_intel]__param
  Map: 0-5f5 4ca0f [kvm_intel].rodata.str1.1
  Map: 0-3657 493b8 [kvm_intel].rodata.str1.8
  Map: 0-e0 70640 [kvm_intel].data..ro_after_init
  Map: 0-500 70ec0 [kvm_intel].gnu.linkonce.this_module
  Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko

The example above shows how the module section mappings are all wrong
except for the main .text mapping at 0xffffffffc13a7000.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V3:
    - re-base

Changes in V2:
    - add dump to perf report (if no browser) as well as perf script
    - add 'perf --debug kmaps' option also to dump kmaps


 tools/perf/Documentation/perf.txt |  2 ++
 tools/perf/builtin-report.c       |  2 ++
 tools/perf/builtin-script.c       |  3 +++
 tools/perf/util/debug.c           |  3 +++
 tools/perf/util/debug.h           |  1 +
 tools/perf/util/python.c          |  1 +
 tools/perf/util/session.c         | 11 +++++++++++
 tools/perf/util/session.h         |  2 ++
 8 files changed, 25 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index a7cf7bc2f968..09f516f3fdfb 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -63,6 +63,8 @@ OPTIONS
                              in browser mode
           perf-event-open  - Print perf_event_open() arguments and
                              return value
+          kmaps            - Print kernel and module maps (perf script
+                             and perf report without browser)
 
 --debug-file::
 	Write debug output to a specified file.
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ccb91fe6b876..8e16fa261e6f 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1766,6 +1766,8 @@ int cmd_report(int argc, const char **argv)
 	} else
 		ret = 0;
 
+	if (!use_browser && (verbose > 2 || debug_kmaps))
+		perf_session__dump_kmaps(session);
 error:
 	if (report.ptime_range) {
 		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index af63b7c37c8a..24baa8284add 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4378,6 +4378,9 @@ int cmd_script(int argc, const char **argv)
 
 	flush_scripting();
 
+	if (verbose > 2 || debug_kmaps)
+		perf_session__dump_kmaps(session);
+
 out_delete:
 	if (script.ptime_range) {
 		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index e282b4ceb4d2..c39ee0fcb8cf 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -33,6 +33,7 @@
 #endif
 
 int verbose;
+int debug_kmaps;
 int debug_peo_args;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
@@ -229,6 +230,7 @@ static struct sublevel_option debug_opts[] = {
 	{ .name = "stderr",		.value_ptr = &redirect_to_stderr},
 	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
 	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
+	{ .name = "kmaps",		.value_ptr = &debug_kmaps },
 	{ .name = NULL, }
 };
 
@@ -267,6 +269,7 @@ int perf_quiet_option(void)
 	/* For debug variables that are used as bool types, set to 0. */
 	redirect_to_stderr = 0;
 	debug_peo_args = 0;
+	debug_kmaps = 0;
 
 	return 0;
 }
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index de8870980d44..35a7a5ae762e 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 
 extern int verbose;
+extern int debug_kmaps;
 extern int debug_peo_args;
 extern bool quiet, dump_trace;
 extern int debug_ordered_events;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8761f51b5c7c..075c0f79b1b9 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -181,6 +181,7 @@ int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
  * implementing 'verbose' and 'eprintf'.
  */
 int verbose;
+int debug_kmaps;
 int debug_peo_args;
 
 int eprintf(int level, int var, const char *fmt, ...);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 199d3e8df315..06d0bd7fb459 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2720,6 +2720,17 @@ size_t perf_session__fprintf(struct perf_session *session, FILE *fp)
 	return machine__fprintf(&session->machines.host, fp);
 }
 
+void perf_session__dump_kmaps(struct perf_session *session)
+{
+	int save_verbose = verbose;
+
+	fflush(stdout);
+	fprintf(stderr, "Kernel and module maps:\n");
+	verbose = 0; /* Suppress verbose to print a summary only */
+	maps__fprintf(machine__kernel_maps(&session->machines.host), stderr);
+	verbose = save_verbose;
+}
+
 struct evsel *perf_session__find_first_evtype(struct perf_session *session,
 					      unsigned int type)
 {
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index ee3715e8563b..5064c6ec11e7 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -133,6 +133,8 @@ size_t perf_session__fprintf_dsos_buildid(struct perf_session *session, FILE *fp
 size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp,
 				       bool skip_empty);
 
+void perf_session__dump_kmaps(struct perf_session *session);
+
 struct evsel *perf_session__find_first_evtype(struct perf_session *session,
 					    unsigned int type);
 
-- 
2.34.1


