Return-Path: <linux-kernel+bounces-107043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD3387F6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763071F224ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9898002B;
	Tue, 19 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hInb/Drm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620B7FBAF;
	Tue, 19 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827488; cv=none; b=tGuQ7JLrjw+XUkwQg6kG/WFaPnbo3T/hy40h07Fzy7WMOxsVxmubh6OCjqHF6+0beQcfuKMD7CAMfo9GLdedtbUgkNgDig2AmQHQM7ELDm622E7U+ykKsMHuf+gnKBe6N3kfyoQUh0f7gUGbXbe9aBxs2NAR92iJNkiBEqyzy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827488; c=relaxed/simple;
	bh=uJSdghEGLKMsHLGxhc9BRL8wS6WYTQdxoEBPQ8UAYQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoHNcoF+GmZjO9h3Iiii7PgUqe3fWH3gykKzeZVTCFHHgFsMgG3oA6u5gB8K9BXCPHRfmFrk/Txzk4gnTgACe/BYT5qI8Ke6CqgU0PaYC+lzzgUgonF3aSVhEP9IemxYTeekYC8WuDjuYSePOWVj0qOdwzxrHrITa3KRgLlupio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hInb/Drm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F2AC43390;
	Tue, 19 Mar 2024 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827487;
	bh=uJSdghEGLKMsHLGxhc9BRL8wS6WYTQdxoEBPQ8UAYQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hInb/DrmioxpC/1b7/UzJjjH3S6SZXRm5+NvXmMkdpP7JdiNPwPzW/CgECrt99GvY
	 WmuldXyzJMwtk40n/QQ2ONF2418mBqW7Zw0e7oLN0rkSB254XqIlWXDm0ABEP/OKU1
	 6NV/YUeVNRoYlNJSYqtTMkii+8SKg338p+T2k8KZgm55W56DJdGSIfI92ByX2KowqZ
	 M2m4bASKV0mDFFcA8HjVusbUrJ3e+Il9HH66nCq+yr0DerAksUJyT/N/NBzQqyiD6Q
	 Jfye6q9ShAs8WdQZVBPQswKw1RpDun2pud2Maco9073Hvo9oQSfnUCZuhVWlqeExX6
	 7zVJjx58hK0FA==
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
Subject: [PATCH 17/23] perf annotate-data: Handle this-cpu variables in kernel
Date: Mon, 18 Mar 2024 22:51:09 -0700
Message-ID: <20240319055115.4063940-18-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86, the kernel gets the current task using the current macro like
below:

  #define current  get_current()

  static __always_inline struct task_struct *get_current(void)
  {
      return this_cpu_read_stable(pcpu_hot.current_task);
  }

So it returns the current_task field of struct pcpu_hot which is the
first member.  On my build, it's located at 0x32940.

  $ nm vmlinux | grep pcpu_hot
  0000000000032940 D pcpu_hot

And the current macro generates the instructions like below:

  mov  %gs:0x32940, %rcx

So the %gs segment register points to the beginning of the per-cpu
region of this cpu and it points the variable with a constant.

Let's update the instruction location info to have a segment register
and handle %gs in kernel to look up a global variable.  Pretend it as
a global variable by changing the register number to DWARF_REG_PC.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 21 +++++++++++++++++++--
 tools/perf/util/annotate.c      |  7 +++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index f5329a78a97d..d57622ddd5d3 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -790,7 +790,7 @@ static void delete_var_types(struct die_var_type *var_types)
 /* It's at the target address, check if it has a matching type */
 static bool check_matching_type(struct type_state *state,
 				struct data_loc_info *dloc, int reg,
-				Dwarf_Die *type_die)
+				Dwarf_Die *cu_die, Dwarf_Die *type_die)
 {
 	Dwarf_Word size;
 	u32 insn_offset = dloc->ip - dloc->ms->sym->start;
@@ -864,6 +864,23 @@ static bool check_matching_type(struct type_state *state,
 		return true;
 	}
 
+	if (map__dso(dloc->ms->map)->kernel && arch__is(dloc->arch, "x86")) {
+		u64 addr;
+		int offset;
+
+		if (dloc->op->segment == INSN_SEG_X86_GS && dloc->op->imm) {
+			pr_debug_dtp(" this-cpu var\n");
+
+			addr = dloc->op->offset;
+
+			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
+						&offset, type_die)) {
+				dloc->type_offset = offset;
+				return true;
+			}
+		}
+	}
+
 	pr_debug_dtp("\n");
 	return false;
 }
@@ -897,7 +914,7 @@ static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
 
 			if (this_ip == dloc->ip) {
 				found = check_matching_type(&state, dloc, reg,
-							    type_die);
+							    cu_die, type_die);
 				goto out;
 			}
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3aa3a3b987ad..e4121acb4f88 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3921,6 +3921,13 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 							    op_loc->offset, dl);
 		}
 
+		/* This CPU access in kernel - pretend PC-relative addressing */
+		if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
+		    op_loc->segment == INSN_SEG_X86_GS && op_loc->imm) {
+			dloc.var_addr = op_loc->offset;
+			op_loc->reg1 = DWARF_REG_PC;
+		}
+
 		mem_type = find_data_type(&dloc);
 		if (mem_type)
 			istat->good++;
-- 
2.44.0.291.gc1ea87d7ee-goog


