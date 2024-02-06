Return-Path: <linux-kernel+bounces-54988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EEC84B5ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CD91C22D39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36148130E30;
	Tue,  6 Feb 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULo7yfc5"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180912FF76;
	Tue,  6 Feb 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224717; cv=none; b=TMgxWwzOIZP2V5BelNZzCFKhArzdoYKmKlHU4BeUcOJk3lhUMHdWMtd3lbzLpW+o5oOZOefVk7AVdAw3rO/dgEm3TBc+YWP5ZtfJLNwoYMw1rNV/qXtoyS9Rab4ok2QxnPqlqZwqDHsANTVuna8OtsnWjgq0j+F716zmxhR0Vko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224717; c=relaxed/simple;
	bh=Vp/4na1V53+tI1gIgDhwPwLFjOKMhZJaYVMauAvjYOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3jCICdMpCcgjj2dcYcLJ1g/Hdysy/wfown9WY5L1u9VGw7PMcN+XFj9ZB8XcZ0/qtwT33UEGcuy0/VUUJ1Y4Qgo1QRiGSridI5wQeA83D4skbs1kPQhjAm5uFMCyf5Lx+CbW/bmOswQSvh2ikXfn5zjaMbaOZU7DLB98mydtzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULo7yfc5; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707224715; x=1738760715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vp/4na1V53+tI1gIgDhwPwLFjOKMhZJaYVMauAvjYOs=;
  b=ULo7yfc5CnMvo7SflT4Es/1fovix3kpUn3tW3YLoWil8NvKwW1VxJre9
   nvOWG+kmRaJOClvHi+8EV2pVB/Lupym6R69mpqLJNXDa2r6LF92BOtpvt
   QS/zS5Z55W6NZAhiywG/hJOs76LsuNUxR/WjScckvf969hos7ZzZ3ndlk
   PvyRm22p3z2XOqofvBzSCWuPC2EhDC4uUu5L5M2ZHH86oEqlJGKVTUlKM
   shUg0sn6Jl19Qd5Hywih76EAyKBNwMgTSYgi5b05DfKFcbmiNcZ0XPoAI
   bbsAOkty2KeMWifMLvsjnOE1VWrAYLMnhoN4T9iWlJcsxZu9KczI/cIVu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="395161867"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="395161867"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="999419"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:05:12 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Like Xu <like.xu.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V2 1/2] perf tools: Make it possible to see perf's kernel and module memory mappings
Date: Tue,  6 Feb 2024 15:04:57 +0200
Message-Id: <20240206130458.8867-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206130458.8867-1-adrian.hunter@intel.com>
References: <20240206130458.8867-1-adrian.hunter@intel.com>
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
index ba3df49c169d..feb954a18150 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -63,6 +63,8 @@ OPTIONS
                              in browser mode
           perf-event-open  - Print perf_event_open() arguments and
                              return value
+          kmaps            - Print kernel and module maps (perf script
+                             and perf report without browser)
 
 DESCRIPTION
 -----------
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9cb1da2dc0c0..609ccc5cc362 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1731,6 +1731,8 @@ int cmd_report(int argc, const char **argv)
 	} else
 		ret = 0;
 
+	if (!use_browser && (verbose > 2 || debug_kmaps))
+		perf_session__dump_kmaps(session);
 error:
 	if (report.ptime_range) {
 		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b1f57401ff23..25c42ad3d120 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4366,6 +4366,9 @@ int cmd_script(int argc, const char **argv)
 
 	flush_scripting();
 
+	if (verbose > 2 || debug_kmaps)
+		perf_session__dump_kmaps(session);
+
 out_delete:
 	if (script.ptime_range) {
 		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 88378c4c5dd9..f21661aab1b6 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -33,6 +33,7 @@
 #endif
 
 int verbose;
+int debug_kmaps;
 int debug_peo_args;
 bool dump_trace = false, quiet = false;
 int debug_ordered_events;
@@ -221,6 +222,7 @@ static struct sublevel_option debug_opts[] = {
 	{ .name = "stderr",		.value_ptr = &redirect_to_stderr},
 	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
 	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
+	{ .name = "kmaps",		.value_ptr = &debug_kmaps },
 	{ .name = NULL, }
 };
 
@@ -259,6 +261,7 @@ int perf_quiet_option(void)
 	/* For debug variables that are used as bool types, set to 0. */
 	redirect_to_stderr = 0;
 	debug_peo_args = 0;
+	debug_kmaps = 0;
 
 	return 0;
 }
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index f99468a7f681..4664f6e9b027 100644
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
index 1e9aa8ed15b6..d62a2fdd81d6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2704,6 +2704,17 @@ size_t perf_session__fprintf(struct perf_session *session, FILE *fp)
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


