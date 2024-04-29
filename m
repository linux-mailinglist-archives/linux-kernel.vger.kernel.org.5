Return-Path: <linux-kernel+bounces-163154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033578B6667
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B303A284851
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593FE194C7C;
	Mon, 29 Apr 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSEkZM6h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594085945;
	Mon, 29 Apr 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433828; cv=none; b=Oy66IbQppxczs4q/D/V2WzmQsMM8S4QXhxfFLJeitSuwVgi5XKUwn4J3ZcpbWz9Tb07J+Mi1KrhE3+qqUz+Pr1w+hux5gfLFEaRSZWWLjAMrxoslQz/2HkccLDNPKvfZHj5ZqsvN5wUTSdNBH9oy4wrpQrrCFkIYbuvhqhE6oJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433828; c=relaxed/simple;
	bh=8Izqy6wmN7d6G+VKdDnydx8YVjPo7ETQXmEV8pw8ae0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SE7itYD4BUEAIbcszcXugFRoKMN+dyyKEkr2QR2kiQOthpN76ySv90AIMjpttVDxkEqzos/+QajUlx98z3Ze6mXhR3ISQcvsba7x5dCzaXYAgvwEFzDNnkiNgiYKsEY7FDMNvHX/0u/jD9kAWAMiS6T1RdA7FX12EScyQFvYwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSEkZM6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D189C113CD;
	Mon, 29 Apr 2024 23:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714433828;
	bh=8Izqy6wmN7d6G+VKdDnydx8YVjPo7ETQXmEV8pw8ae0=;
	h=From:To:Cc:Subject:Date:From;
	b=BSEkZM6hPsYKjtpV1/E7dgKyuSPi4LQmjP2FoDwk5M+OyvdSY/poOi5ooOKoML1Q0
	 5fMlTsYcdlaUVZne6EJqfD26BAEdxlyhK3CEb/q/UN9EdGSoBndNeCnBiVIrIpnmq6
	 E1lE9ORzUIspHIRLvE6PvkeAr10xPXHimM+zVgtuFav49JH8B9TMVyaITTcYU2F63y
	 YrRIFEW1gw3VyQA8xkBhjxY00VHHJXwrE08coHuy1+3LMqWuKzaeO8vBdfnpNiovmd
	 rLPTcjORtoVkeqt442RD8UUSbySOCgPgvdGWZHOEwM1QmeCFy2dIDZuMirBHeFkm5s
	 QlGGbA34UESlg==
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
Subject: [PATCH v2] tools lib subcmd: Show parent options in help
Date: Mon, 29 Apr 2024 16:37:07 -0700
Message-ID: <20240429233707.1511175-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've just realized that help message in a subcommand didn't show one
in the parent command.  Since the option parser understands the parent,
display code should do the same.  For example, `perf ftrace latency -h`
should show options in the `perf ftrace` command too.

Before:

  $ perf ftrace latency -h

   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- [<command>] [<options>]
      or: perf ftrace {trace|latency} [<options>] [<command>]
      or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]

      -b, --use-bpf         Use BPF to measure function latency
      -n, --use-nsec        Use nano-second histogram
      -T, --trace-funcs <func>
                            Show latency of given function

After:

  $ perf ftrace latency -h

   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- [<command>] [<options>]
      or: perf ftrace {trace|latency} [<options>] [<command>]
      or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]

      -a, --all-cpus        System-wide collection from all CPUs
      -b, --use-bpf         Use BPF to measure function latency
      -C, --cpu <cpu>       List of cpus to monitor
      -n, --use-nsec        Use nano-second histogram
      -p, --pid <pid>       Trace on existing process id
      -T, --trace-funcs <func>
                            Show latency of given function
      -v, --verbose         Be more verbose
          --tid <tid>       Trace on existing thread id (exclusive to --pid)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
*v2: remove goto and add comments  (Ian)

 tools/lib/subcmd/parse-options.c | 36 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 9fa75943f2ed..eb896d30545b 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -806,18 +806,30 @@ static int option__cmp(const void *va, const void *vb)
 
 static struct option *options__order(const struct option *opts)
 {
-	int nr_opts = 0, nr_group = 0, len;
-	const struct option *o = opts;
-	struct option *opt, *ordered, *group;
-
-	for (o = opts; o->type != OPTION_END; o++)
-		++nr_opts;
-
-	len = sizeof(*o) * (nr_opts + 1);
-	ordered = malloc(len);
-	if (!ordered)
-		goto out;
-	memcpy(ordered, opts, len);
+	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
+	const struct option *o, *p = opts;
+	struct option *opt, *ordered = NULL, *group;
+
+	/* flatten the options that have parents */
+	for (p = opts; p != NULL; p = o->parent) {
+		for (o = p; o->type != OPTION_END; o++)
+			++nr_opts;
+
+		/*
+		 * the length is given by the number of options plus a null
+		 * terminator for the last loop iteration.
+		 */
+		len = sizeof(*o) * (nr_opts + !o->parent);
+		group = realloc(ordered, len);
+		if (!group)
+			goto out;
+		ordered = group;
+		memcpy(&ordered[nr_parent], p, sizeof(*o) * (nr_opts - nr_parent));
+
+		nr_parent = nr_opts;
+	}
+	/* copy the last OPTION_END */
+	memcpy(&ordered[nr_opts], o, sizeof(*o));
 
 	/* sort each option group individually */
 	for (opt = group = ordered; opt->type != OPTION_END; opt++) {
-- 
2.44.0.769.g3c40516874-goog


