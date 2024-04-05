Return-Path: <linux-kernel+bounces-133585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754189A600
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBCFB22782
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AA17554F;
	Fri,  5 Apr 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2EsdL94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88D174EFC;
	Fri,  5 Apr 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351883; cv=none; b=DNfOz9LxrvnxU/ZT3XEQrTng3POpZ2tviurX4IAzxyZpBqY5y5aBl0jSh7FSiXUSmTMbnnhU0RyKDsY6/K76I5WDhxK6Zp9RHvojqvnTLdhQ4z7nHffyAbn9SROC20t2TJoAz8Ma+E6CdkBsFCCHzDHRieKoR+s2t+MFZroSJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351883; c=relaxed/simple;
	bh=/mD4TfV2bgQIloZA4pLiUgBGcNpWC07TW8Yr0ztFQao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg2zgMJuezsmbaqtcTakV9mE4ZX/0YGQosJBqM31VZt0zy7+nG3h75ompC5zitWBPAEZLO6i6ePfmDCfwWxIOEfaGMcIsO4N8aSX3a/YZq3/JW0eT/AGGOhbLbJjQNfq8XccvoFJLKVmlg40zhJAkU82b5JC+5gv+lZFzztRWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2EsdL94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A423C43394;
	Fri,  5 Apr 2024 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351882;
	bh=/mD4TfV2bgQIloZA4pLiUgBGcNpWC07TW8Yr0ztFQao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2EsdL94x3bXSp5rB9EZspfBC/kRewIvwocNqgJ1rPPJFjmKWiEz2TKy2HozZwtD4
	 8bUDcz7g9TlXjGb+dkVPMAL5H5okG40UfM+gJRkWcK3koJdsiW4tv13DMDmANS/LJw
	 uvNrBi/txRbqbZ9W5GOCq5kJFbt8wZRUGaMk26EuWe7cwY0WgE/hWdCMEiCPc7BAJ4
	 j/2ndT5mbgkNCUul8R0wR7dFBnMRMSN2jHoWd9s1RiBbXmoDHuIC3DQmlJTn3wkUaw
	 nFsaadzLAR1ArSTzJPNohjcQKAbuugTgf3poKKpsi5sWv0cwLbu6xwMdt3uUlaH2/s
	 hV4c8TXDCu7ug==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] perf annotate: Make sure to call symbol__annotate2() in TUI
Date: Fri,  5 Apr 2024 14:17:57 -0700
Message-ID: <20240405211800.1412920-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240405211800.1412920-1-namhyung@kernel.org>
References: <20240405211800.1412920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symbol__annotate2() initializes some data structures needed by TUI.
It has a logic to prevent calling it multiple times by checking if it
has the annotated source.  But data type profiling uses a different
code (symbol__annotate) to allocate the annotated lines in advance.
So TUI missed to call symbol__annotate2() when it shows the annotation
browser.

Make symbol__annotate() reentrant and handle that situation properly.
This fixes a crash in the annotation browser started by perf report in
TUI like below.

  $ perf report -s type,sym --tui
  # and press 'a' key and then move down

Fixes: 81e57deec325 ("perf report: Support data type profiling")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 tools/perf/util/annotate.c        | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ec5e21932876..4790c735599b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -970,7 +970,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (dso->annotate_warned)
 		return -1;
 
-	if (not_annotated) {
+	if (not_annotated || !sym->annotate2) {
 		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
 			char msg[BUFSIZ];
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 35235147b111..ded9ad86df00 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -879,6 +879,9 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (parch)
 		*parch = arch;
 
+	if (!list_empty(&notes->src->source))
+		return 0;
+
 	args.arch = arch;
 	args.ms = *ms;
 	if (annotate_opts.full_addr)
-- 
2.44.0.478.gd926399ef9-goog


