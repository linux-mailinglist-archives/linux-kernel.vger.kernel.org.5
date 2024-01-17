Return-Path: <linux-kernel+bounces-28562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D422383001C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7571C23412
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E15125AF;
	Wed, 17 Jan 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZQBA4JN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4DD30B;
	Wed, 17 Jan 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472822; cv=none; b=ARQZBviBYHAkEDT+GU9WQI9m2VWx9pxZeZs1c3gvZkU0wjekuop+MiftOeOwqqR4AY/ghZBirEKKcCAkLL9r1LIHF7t5Lig9p1jiSp3BMJ44FG+HaDwiMqgudO/LrtyjXsC8jL9N0VszCU9oba7iA6LZSaAZCuHd/ErcGTW3Brw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472822; c=relaxed/simple;
	bh=B1HSdqhi6NH0qJLvmTSnovvxG+q76GIDVpE975IlI6E=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=n8DxFnMxWsh52tCuY933Ht2Vouh9OCc/3OxlFXVL7Xgb9Hf6DE6dtwZRze7mPaCSEMHMDbA4Pikhp9SH/ARtsMvi8YXyizPEEp1Uh+iDIvF2CcsvDQyFcapdPaaH+XgVv40YYCxdcoyus2zl3NOOPxVDlqHdjnEDfJmbuPTwrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZQBA4JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8C2C4166B;
	Wed, 17 Jan 2024 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472821;
	bh=B1HSdqhi6NH0qJLvmTSnovvxG+q76GIDVpE975IlI6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZQBA4JNPJ0NdKrevArOQZ0+7tcuEC3epVNRbCWqD8bnU/lm8Wock3f3kJaKTG76e
	 vr4zyjnVbuj2OrkP94mHDSoQ9MVK9oi0VntEC4329I9FbH9iXcQx+Ovr5Qscz/QdN/
	 FfXvfx0gVJS54tTQCNCXUVYAnCEyaWrE+GhEjW4eEcJxve7P8iWyNspwMs+M1xqMRa
	 lvCgOmAaRUqscsEqK2xqgbcxaZsUttUCS15ujY8M6NOn9PSfautcb3fdFliQz6Ap/Y
	 acTynLNUgFRT2UyZPBVgUhE4hp2TNfhd2H/iYzFvp7gBXlaj/bolB80nr99jDmNwU5
	 nP8oRr31gh4wQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
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
Subject: [PATCH 4/9] perf annotate-data: Add stack operation pseudo type
Date: Tue, 16 Jan 2024 22:26:52 -0800
Message-ID: <20240117062657.985479-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
References: <20240117062657.985479-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A typical function prologue and epilogue include multiple stack
operations to save and restore the current value of registers.
On x86, it looks like below:

  push  r15
  push  r14
  push  r13
  push  r12

  ...

  pop   r12
  pop   r13
  pop   r14
  pop   r15
  ret

As these all touches the stack memory region, chances are high that they
appear in a memory profile data.  But these are not used for any real
purpose yet so it'd return no types.

One of my profile type shows that non neglible portion of data came from
the stack operations.  It also seems GCC generates more stack operations
than clang.

Annotate Instruction stats
total 264, ok 169 (64.0%), bad 95 (36.0%)

    Name      :  Good   Bad
  -----------------------------------------------------------
    movq      :    49    27
    movl      :    24     9
    popq      :     0    19   <-- here
    cmpl      :    17     2
    addq      :    14     1
    cmpq      :    12     2
    cmpxchgl  :     3     7

Instead of dealing them as unknown, let's create a seperate pseudo type
to represent those stack operations separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.h |  1 +
 tools/perf/util/annotate.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 65ddd839850f..214c625e7bc9 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -70,6 +70,7 @@ struct annotated_data_type {
 };
 
 extern struct annotated_data_type unknown_type;
+extern struct annotated_data_type stackop_type;
 
 /**
  * struct annotated_data_stat - Debug statistics
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3cdcdd449c86..655bd9443f5e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -107,6 +107,14 @@ static struct ins_ops ret_ops;
 struct annotated_data_stat ann_data_stat;
 LIST_HEAD(ann_insn_stat);
 
+/* Pseudo data types */
+struct annotated_data_type stackop_type = {
+	.self = {
+		.type_name = (char *)"(stack operation)",
+		.children = LIST_HEAD_INIT(stackop_type.self.children),
+	},
+};
+
 static int arch__grow_instructions(struct arch *arch)
 {
 	struct ins *new_instructions;
@@ -3724,6 +3732,18 @@ static struct annotated_item_stat *annotate_data_stat(struct list_head *head,
 	return istat;
 }
 
+static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
+{
+	if (arch__is(arch, "x86")) {
+		if (!strncmp(dl->ins.name, "push", 4) ||
+		    !strncmp(dl->ins.name, "pop", 3) ||
+		    !strncmp(dl->ins.name, "ret", 3))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3789,6 +3809,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return NULL;
 	}
 
+	if (is_stack_operation(arch, dl)) {
+		istat->good++;
+		he->mem_type_off = 0;
+		return &stackop_type;
+	}
+
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		if (!op_loc->mem_ref)
 			continue;
-- 
2.43.0.381.gb435a96ce8-goog


