Return-Path: <linux-kernel+bounces-69507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27543858A62
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5994B1C21E50
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4637A151CFE;
	Fri, 16 Feb 2024 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTAWCSTF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E3151CD1;
	Fri, 16 Feb 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127674; cv=none; b=S6sTxaWOvAsMZpd9DPADPCt27OfcJeiC8yDMci9A90RsjUc/b9xYFrO1wLu2tAHIUtTv47kI4Zyh3s5I7gbwMx3qmRUyo/muy4VMyc+C5A7LAFiLWorCCfEvenOc7hmWPLygCOdLaCBFcKZopqaNWhMs0IT3sG7zAQseBbO44KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127674; c=relaxed/simple;
	bh=JSCVTE9XqiSDlA8ej8yd/v+YYkjMI/c+XOMMHYmpMcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9xMtNa89UjGVftyZh1Pvf2NxyrpZyXmVJDNgODptdDZYiuvI+C0eAtVdHVT/q0Tv33/1zhHvVBSKUCj9UZlm0xAcx7UNKj6yBDJTD2NNOAdnVfEhVY/dHgR2lsjP2Q5x5gXcI0IeGzrQLQ7IMdPIfdfw0A8SMcP3mH6f2ZCWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTAWCSTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEFFC43390;
	Fri, 16 Feb 2024 23:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127673;
	bh=JSCVTE9XqiSDlA8ej8yd/v+YYkjMI/c+XOMMHYmpMcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTAWCSTFqFpQXQG/f3joQWMIncRQ5STu7HgSAMGWoppmG7mNaW/7UP7WCaKPO80OP
	 PDAUkm64BEI/oIPTYpSJoVGDwyyqbp3bL/5ImyYfyvOQor5HIqw+JHIjQttryesqM7
	 ZCnP31OeXbmcxL+hONZqbJ3VcHpNuQM8IBo0Ye/ZqY1tmOis6sJI+sxmlejm0Vfaim
	 RzTuboxDG4k5ez7x38ETDoi/qM4dEjEOi4qu1vcJiS9DVdJQwK45+7pI0XhLYVOpUJ
	 bNzYMjCQCG63xb4Ys6nUYvKaFb6lEbZ2vkdUBmZvGm2xRVW1XRD8tC5Rlq/Wqc7UtW
	 jKFVz3evaBKRA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 14/14] perf annotate-data: Add stack canary type
Date: Fri, 16 Feb 2024 15:54:23 -0800
Message-ID: <20240216235423.2343167-15-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216235423.2343167-1-namhyung@kernel.org>
References: <20240216235423.2343167-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the stack protector is enabled, compiler would generate code to
check stack overflow with a special value called 'stack carary' at
runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.

While there's a definition of fixed_percpu_data in asm/processor.h,
it seems that the header is not included everywhere and many places
it cannot find the type info.  As it's in the well-known location (at
%gs:40), let's add a pseudo stack canary type to handle it specially.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.h |  1 +
 tools/perf/util/annotate.c      | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 0bfef29fa52c..e293980eb11b 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -77,6 +77,7 @@ struct annotated_data_type {
 
 extern struct annotated_data_type unknown_type;
 extern struct annotated_data_type stackop_type;
+extern struct annotated_data_type canary_type;
 
 /**
  * struct data_loc_info - Data location information
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5f3136f57c62..f2683dadf3cf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -116,6 +116,13 @@ struct annotated_data_type stackop_type = {
 	},
 };
 
+struct annotated_data_type canary_type = {
+	.self = {
+		.type_name = (char *)"(stack canary)",
+		.children = LIST_HEAD_INIT(canary_type.self.children),
+	},
+};
+
 static int arch__grow_instructions(struct arch *arch)
 {
 	struct ins *new_instructions;
@@ -3764,6 +3771,17 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	return false;
 }
 
+static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
+{
+	/* On x86_64, %gs:40 is used for stack canary */
+	if (arch__is(arch, "x86")) {
+		if (loc->segment == INSN_SEG_X86_GS && loc->offset == 40)
+			return true;
+	}
+
+	return false;
+}
+
 u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 			struct disasm_line *dl)
 {
@@ -3938,6 +3956,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		}
 
 		mem_type = find_data_type(&dloc);
+
+		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
+			mem_type = &canary_type;
+			dloc.type_offset = 0;
+		}
+
 		if (mem_type)
 			istat->good++;
 		else
-- 
2.44.0.rc0.258.g7320e95886-goog


