Return-Path: <linux-kernel+bounces-131927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39543898D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF401C283F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B01350FD;
	Thu,  4 Apr 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGSYEztl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CC134426;
	Thu,  4 Apr 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253443; cv=none; b=jTFdKCAw2oNcAFidg8JafWX+42HeEjBVk5R9Sc/p79Jn6+ZVHIQqe9Jtopa2Gn0NYwzksal5ja3l+YJb8q3IOHLM6Ua/gdqIiR/4ADB0tSGqnnvMkslGE/dgLBz4kxkR2+YEmO/kZOrRQ+bNvQhcR+YU8BoosL1Smrg345yOQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253443; c=relaxed/simple;
	bh=niT6BQxb6KQYb+xioB6nmxiNDINwRSyOvMNKOzr69J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1DlNZ7TKTsoofDHADQQqI5iXQSTeNZkYWE1pNpv3rRM3/L5UsE29SGxQPEviU0DW35kToXlPqjOLslphM63qurBjEdmVkIkOqAGbW7YWrdZqg2IdwGN84zYkwLNXYx6WjasPk9u7/xGPEIqdba1BeWUjIhU0qKfJFCx1OVnQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGSYEztl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE04AC4167E;
	Thu,  4 Apr 2024 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253443;
	bh=niT6BQxb6KQYb+xioB6nmxiNDINwRSyOvMNKOzr69J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGSYEztlyQ2d65DXA/9VDqohrGM22hsX9Jl7GvQKfzYroW5NOWOm8xcbfc75gyZOg
	 zs1J6GGB8bgZFbLi8kPFU05yqF3pKdzWw6wbkX1ms/zOREFLMaGD6i/wIOucNH2+Za
	 jvUzAqbjZVuX3cgrAuoZoiy3cz4x/9hWDR/5NhgBkfdnDBIbJ6gw50132AJFq32HdB
	 NydZ3T8DLM42PxfD4RzT2riPmDFvELSiWYpXpWalQaBRzDQkEX8C106rgxbMkyrUOT
	 Z/SA1v+jmFDjZ7HnIyvzCv2sEdIgs0HgwLZUYzH7ryxyZHaE1+5Bn6HAM50l4j/FOf
	 t6lpcYs3TkxLw==
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
Subject: [PATCH 9/9] perf annotate: Move start field struct to annotated_source
Date: Thu,  4 Apr 2024 10:57:16 -0700
Message-ID: <20240404175716.1225482-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404175716.1225482-1-namhyung@kernel.org>
References: <20240404175716.1225482-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only used in perf annotate output which means functions with actual
samples.  No need to consume memory for every symbol (annotation).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 10 +++++-----
 tools/perf/util/annotate.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5f79ae0bccfd..4db49611c386 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -909,9 +909,9 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	args.arch = arch;
 	args.ms = *ms;
 	if (annotate_opts.full_addr)
-		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
+		notes->src->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
-		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
+		notes->src->start = map__rip_2objdump(ms->map, ms->sym->start);
 
 	return symbol__disassemble(sym, &args);
 }
@@ -1456,9 +1456,9 @@ void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *m
 	annotate_opts.full_addr = !annotate_opts.full_addr;
 
 	if (annotate_opts.full_addr)
-		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
+		notes->src->start = map__objdump_2mem(ms->map, ms->sym->start);
 	else
-		notes->start = map__rip_2objdump(ms->map, ms->sym->start);
+		notes->src->start = map__rip_2objdump(ms->map, ms->sym->start);
 
 	annotation__update_column_widths(notes);
 }
@@ -1766,7 +1766,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		int color = -1;
 
 		if (!annotate_opts.use_offset)
-			addr += notes->start;
+			addr += notes->src->start;
 
 		if (!annotate_opts.use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d22b9e9a2fad..d5c821c22f79 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -270,6 +270,7 @@ struct annotated_source {
 	int			nr_entries;
 	int			nr_asm_entries;
 	int			max_jump_sources;
+	u64			start;
 	struct {
 		u8		addr;
 		u8		jumps;
@@ -312,7 +313,6 @@ struct annotated_branch {
 };
 
 struct LOCKABLE annotation {
-	u64			start;
 	struct annotated_source *src;
 	struct annotated_branch *branch;
 };
-- 
2.44.0.478.gd926399ef9-goog


