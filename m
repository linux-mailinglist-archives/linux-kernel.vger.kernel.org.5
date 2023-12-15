Return-Path: <linux-kernel+bounces-1492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA68C814F58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9633E1F256C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6C82EF9;
	Fri, 15 Dec 2023 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMd0Xkx8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FE82EEF;
	Fri, 15 Dec 2023 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702662921; x=1734198921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UH9+q6pJRO5+cSo0tmTFEhgrE0ZiEhcMwoihcTVbnBc=;
  b=DMd0Xkx8dysAqTT3ZLWeovd5mw1LXu3gfTxoM+lZX8BSDjD+bQkhdjSc
   OSpgKRWPSJEnjGcPCe9/lCnmsxMzALgkop07/JjjmwA+k44/B77dvNTmR
   PXy4mWgwh1yDq9+xYnA5h83Yb2DKiscDXJr1+s1BaxdyVuALkwheAinZf
   YmQ58NnBKvQejmsNV3PazBEYpJLuq0pePcSFbfwxV/ZpKc6EDjOm8WbS1
   JmqXThmwcKyDYTJoVehwCaP/cXrM8EV1rdkPmBzFwKEdRpcvJMpD3Y7C+
   xiIaaUH8W+nXYzrYiqOiR4h+fU9oVc55m3wmPdvpByt7/rQCRp5BpIrpQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375456303"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375456303"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840745963"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840745963"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 09:55:20 -0800
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	irogers@google.com
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	marcan@marcan.st,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf evlist: Move the modifier after the slash when rename a hybrid event
Date: Fri, 15 Dec 2023 09:54:55 -0800
Message-Id: <20231215175455.1300261-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The event name shown in the perf top is wrong on a hybrid machine.
 $perf top
 1K cpu_atom/cycles:P/
 11K cpu_core/cycles:P/

If using it on the command line:

 $perf top -e cpu_atom/cycles:P/
 event syntax error: 'cpu_atom/cycles:P/'
                              \___ Bad event or PMU

The evlist__uniquify_name() changes a hybrid event name to "//" style.
When using the "//" style, the event modifiers must be appended after
the last "/".

Split the old name into event and modifier. Apply the correct format for
the "//" style.

The patch fixes the same issue on the perf record as well.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/lkml/ZXxyanyZgWBTOnoK@kernel.org/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6f0892803c22..83f4e3ec62d0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2521,8 +2521,8 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 
 void evlist__uniquify_name(struct evlist *evlist)
 {
+	char *new_name, *old_name, *modifier, *tmp;
 	struct evsel *pos;
-	char *new_name;
 	int ret;
 
 	if (perf_pmus__num_core_pmus() == 1)
@@ -2535,8 +2535,13 @@ void evlist__uniquify_name(struct evlist *evlist)
 		if (strchr(pos->name, '/'))
 			continue;
 
-		ret = asprintf(&new_name, "%s/%s/",
-			       pos->pmu_name, pos->name);
+		/* The event modifiers must be appended after "/" */
+		old_name = strtok_r(pos->name, ":", &tmp);
+		if (!old_name)
+			continue;
+		modifier = strtok_r(NULL, ":", &tmp);
+		ret = asprintf(&new_name, "%s/%s/%s",
+			       pos->pmu_name, old_name, !modifier ? "" : modifier);
 		if (ret) {
 			free(pos->name);
 			pos->name = new_name;
-- 
2.35.1


