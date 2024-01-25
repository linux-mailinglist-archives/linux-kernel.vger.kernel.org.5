Return-Path: <linux-kernel+bounces-37982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A236C83B930
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D582E1C2273A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FD0101F7;
	Thu, 25 Jan 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbQc4cW8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4710A05;
	Thu, 25 Jan 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161886; cv=none; b=P/8j+ay0/G9eFEuEFy/CDyeQcoh0h5WViSKuEHx6oGcPlHecvT6ylQq1fUGWyqNRSI0NVbc2iHYz12SYeOWlm59kBCZq8L6sWPz1ZiUcdFx3MahsEMCWi2pADBgaypOspeHE6FD9RsGdQRhUxc+As+In1XgF1RyHr2YqYg18+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161886; c=relaxed/simple;
	bh=dJn0iZwDo3YjbbXFWkfRSJfzznH/m2xLg/1aaKwYlwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRoJqOuzn3m7nqGu6+qptsFSUK27/m/D7BJuLxWS1F30hvjsQa2hh76fN77cOENA6oI4wQ00KNbyRakTdvNCBXZ7vGr6kswdBDna2NLyB+n59NEfZf6Ib7uLZadkL/a12aW8k/yGS9wfc362FKBL2j215k/zCRV+HOIAkfIq6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbQc4cW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AF8C433C7;
	Thu, 25 Jan 2024 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706161886;
	bh=dJn0iZwDo3YjbbXFWkfRSJfzznH/m2xLg/1aaKwYlwE=;
	h=From:To:Cc:Subject:Date:From;
	b=fbQc4cW8pjU2Miv/8zP1E8CxGxB9HjJzs9YEylsWJIGgviEIx9hN+pVJdqZ7aBDcl
	 WHiUlarxsElM+Q+goHTGlifR+VvCumRtqAVznohp4PCrvXcj1FW7lAbEzPLuIr/zUE
	 ANbZ8pqcGRmUfxupKKPBdflTPq2jgxE6yIGs1kuhET/QCKi/2J43pir1ob2qvP1wg+
	 Wt/8XJm1r07q+U7Czi8Iy2ugyGdMEWYrWRqYk1r+K7gFAXAabWXUd/nCU4gIAfadph
	 ChpH5b/R7ap+KXHuYXaiV09E5n4g+TFlvRFxEja808DF3iwIKQqyGW/AXp5a62F54G
	 46ndNA4Hyg1jQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH RESEND] perf tools: Add -H short option for --hierarchy
Date: Wed, 24 Jan 2024 21:51:24 -0800
Message-ID: <20240125055124.1579617-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found the hierarchy mode useful, but it's easy to make a typo when
using it.  Let's add a short option for that.

Also update the documentation. :)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt | 29 ++++++++++++++++++++-
 tools/perf/Documentation/perf-top.txt    | 32 +++++++++++++++++++++++-
 tools/perf/builtin-report.c              |  2 +-
 tools/perf/builtin-top.c                 |  2 +-
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 38f59ac064f7..d8b863e01fe0 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -531,8 +531,35 @@ include::itrace.txt[]
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
+-H::
 --hierarchy::
-	Enable hierarchical output.
+	Enable hierarchical output.  In the hierarchy mode, each sort key groups
+	samples based on the criteria and then sub-divide it using the lower
+	level sort key.
+
+	For example:
+	In normal output:
+
+	  perf report -s dso,sym
+	  # Overhead  Shared Object      Symbol
+	      50.00%  [kernel.kallsyms]  [k] kfunc1
+	      20.00%  perf               [.] foo
+	      15.00%  [kernel.kallsyms]  [k] kfunc2
+	      10.00%  perf               [.] bar
+	       5.00%  libc.so            [.] libcall
+
+	In hierarchy output:
+
+	  perf report -s dso,sym --hierarchy
+	  #   Overhead  Shared Object / Symbol
+	      65.00%    [kernel.kallsyms]
+	        50.00%    [k] kfunc1
+	        15.00%    [k] kfunc2
+	      30.00%    perf
+	        20.00%    [.] foo
+	        10.00%    [.] bar
+	       5.00%    libc.so
+	         5.00%    [.] libcall
 
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 3c202ec080ba..a754875fa5bb 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -261,8 +261,38 @@ Default is to monitor all CPUS.
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
+-H::
 --hierarchy::
-	Enable hierarchy output.
+	Enable hierarchical output.  In the hierarchy mode, each sort key groups
+	samples based on the criteria and then sub-divide it using the lower
+	level sort key.
+
+	For example, in normal output:
+
+	  perf report -s dso,sym
+	  #
+	  # Overhead  Shared Object      Symbol
+	  # ........  .................  ...........
+	      50.00%  [kernel.kallsyms]  [k] kfunc1
+	      20.00%  perf               [.] foo
+	      15.00%  [kernel.kallsyms]  [k] kfunc2
+	      10.00%  perf               [.] bar
+	       5.00%  libc.so            [.] libcall
+
+	In hierarchy output:
+
+	  perf report -s dso,sym --hierarchy
+	  #
+	  #   Overhead  Shared Object / Symbol
+	  # ..........  ......................
+	      65.00%    [kernel.kallsyms]
+	        50.00%    [k] kfunc1
+	        15.00%    [k] kfunc2
+	      30.00%    perf
+	        20.00%    [.] foo
+	        10.00%    [.] bar
+	       5.00%    libc.so
+	         5.00%    [.] libcall
 
 --overwrite::
 	Enable this to use just the most recent records, which helps in high core count
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f2ed2b7e80a3..ccb91fe6b876 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1410,7 +1410,7 @@ int cmd_report(int argc, const char **argv)
 		    "only show processor socket that match with this filter"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
 		    "Show raw trace event output (do not use print fmt or plugins)"),
-	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
+	OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index baf1ab083436..03cf45088fd8 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1573,7 +1573,7 @@ int cmd_top(int argc, const char **argv)
 		    "add last branch records to call history"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
 		    "Show raw trace event output (do not use print fmt or plugins)"),
-	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
+	OPT_BOOLEAN('H', "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
 	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
 		    "Use a backward ring buffer, default: no"),
-- 
2.43.0.429.g432eaa2c6b-goog


