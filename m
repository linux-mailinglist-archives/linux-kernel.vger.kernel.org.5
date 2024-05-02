Return-Path: <linux-kernel+bounces-166191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E068B975B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496871F21AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C735476B;
	Thu,  2 May 2024 09:15:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE9524D4;
	Thu,  2 May 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641315; cv=none; b=oUNQ5D7mVmDMnCSdpZ8wnnqm/ouM1ce055UC1aZAm6yCnvHXNfs4yD5F4CXrtUlM5b9P6kcN/mQIurf8WRF+V/t3C9Hi/kwcnWroycGmz05rwVxv7fKTIx0lOfScQMXUVWerCxwXUR8JVUwBeKCgrFmGlP8PrQrfJYg/UsfrzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641315; c=relaxed/simple;
	bh=V+fMi3wAVPt94aZ1od5h3gV+HlEfxFhPy0HJtK9h5wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEjlmwSdTIWvssf/EQTBht0yAFZFSvOndcN0nnbUft8ucJ2RdM0/oF5PCNT4s2/NXi6iRHUd72eZavbM7/LEOA33rUWRwgGvisk4+4nFg2Zj51CCIPZNY/CT/6tAhBZR86s6FgliiDycOs2GOsC6e0f3oup0uiphxR8Kf6jJxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9834B2F4;
	Thu,  2 May 2024 02:15:38 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.cambridge.arm.com (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.3.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB9823F71E;
	Thu,  2 May 2024 02:15:11 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v2 1/1] perf lock info: Display both map and thread by default
Date: Thu,  2 May 2024 09:14:45 +0000
Message-ID: <20240502091446.3037-2-nick.forrington@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502091446.3037-1-nick.forrington@arm.com>
References: <20240502091446.3037-1-nick.forrington@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "perf lock info" argument handling to:

Display both map and thread info (rather than an error) when neither are
specified.

Display both map and thread info (rather than just thread info) when
both are requested.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 tools/perf/Documentation/perf-lock.txt |  4 ++--
 tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index f5938d616d75..57a940399de0 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -111,11 +111,11 @@ INFO OPTIONS
 
 -t::
 --threads::
-	dump thread list in perf.data
+	dump only the thread list in perf.data
 
 -m::
 --map::
-	dump map of lock instances (address:name table)
+	dump only the map of lock instances (address:name table)
 
 
 CONTENTION OPTIONS
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 230461280e45..86c68c39aac0 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1483,11 +1483,16 @@ static int dump_info(void)
 
 	if (info_threads)
 		dump_threads();
-	else if (info_map)
+
+	if (info_map) {
+		if (info_threads)
+			fputc('\n', lock_output);
 		dump_map();
-	else {
+	}
+
+	if (!info_threads && !info_map) {
 		rc = -1;
-		pr_err("Unknown type of information\n");
+		pr_err("No lock info specified\n");
 	}
 
 	return rc;
@@ -2578,9 +2583,9 @@ int cmd_lock(int argc, const char **argv)
 
 	const struct option info_options[] = {
 	OPT_BOOLEAN('t', "threads", &info_threads,
-		    "dump thread list in perf.data"),
+		    "dump only the thread list in perf.data"),
 	OPT_BOOLEAN('m', "map", &info_map,
-		    "map of lock instances (address:name table)"),
+		    "dump only the map of lock instances (address:name table)"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -2694,6 +2699,13 @@ int cmd_lock(int argc, const char **argv)
 			if (argc)
 				usage_with_options(info_usage, info_options);
 		}
+
+		/* If neither threads nor map requested, display both */
+		if (!info_threads && !info_map) {
+			info_threads = true;
+			info_map = true;
+		}
+
 		/* recycling report_lock_ops */
 		trace_handler = &report_lock_ops;
 		rc = __cmd_report(true);
-- 
2.44.0


