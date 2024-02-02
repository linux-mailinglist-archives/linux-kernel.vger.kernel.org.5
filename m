Return-Path: <linux-kernel+bounces-50647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA847847C09
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E07B22880
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70E1332A7;
	Fri,  2 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj1bKvcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F74132498;
	Fri,  2 Feb 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911510; cv=none; b=B9XujTkVVcfeRZe5ZHM7RsuuemsGBPfw+KIBb3CQIO8rZKNPs3cwAUmEWjr0Azb4/0s1UpJj1tb6lMGCQtDcpWOIhYm92pEkWSbGGQ/dUdSPjz0zPEZXdbVRP5VpGrytQd3gMqtdFIANhsTgiiBEVk6ovxxzJzgBti2K+9lZ0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911510; c=relaxed/simple;
	bh=u+3b408czl7+mH8GeTAKvju9aWQhRxzD0hyW0Dr5iWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBJLpojbZbIoZ0Yc0ozK85KovEb4V7Y2NodPbDy0GB/dg19qkvKotcaEyrDBVhdaVhLs22L+l2eGE5/fsmFYryndUzVnioigkno4bVKnQqug5tNFsHKM+xJStAjgn8THs6XlOdrOVA49LXXWGnaO4YWP0mZxZA+DAI6qAcpMW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj1bKvcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFC0C433C7;
	Fri,  2 Feb 2024 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911510;
	bh=u+3b408czl7+mH8GeTAKvju9aWQhRxzD0hyW0Dr5iWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rj1bKvcPX27x+4M1i+jYh7SuVlGttIBX9A5CC5LblU9hEvwGe2Od18VdDnFcbjFRk
	 no3J1Xy5wkzm48aOCRzIo3KckxAdIxPqejNlRdZhTiAnV05sFv513YXo8N4sRXvNkc
	 yc+SzlRdzjfBfA34VHkqBEWe0P6toRYi1gqtprXwEoJKSgtxfYXYe9gyyVK/u8gkcp
	 zHn4niC9G0eo5JBaPs1Ib35wfDrhZjU769cjkQL+edF94vJBNMNwaBOdaKde9+v+ia
	 L9d4L64ku4JADxIXdeXwwFnhW5HsYdcM9eaVLLWJxQwBESMMTkM1ZcHhL0gYCx2a1d
	 fzw9QfMK+Ysdw==
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
Date: Fri,  2 Feb 2024 14:04:59 -0800
Message-ID: <20240202220459.527138-15-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202220459.527138-1-namhyung@kernel.org>
References: <20240202220459.527138-1-namhyung@kernel.org>
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
2.43.0.594.gd9cf4e227d-goog


