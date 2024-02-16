Return-Path: <linux-kernel+bounces-69505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C2858A60
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D120B26AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905514D447;
	Fri, 16 Feb 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbGdxWtq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB614F9EF;
	Fri, 16 Feb 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127673; cv=none; b=kCcGgs1eJK1z6au9yGHgAAqzSHUfgNbEQRK1dyFaxUh8mJhOdzdTjsbcasPoTChQjQffc9g9TeVaCPzbmqd1BdmJ01Zv5jNhuM1L5g2CjEaZiPfYeeuG0QIGupj/W0J6Li1vWCnTcQ461q28+URFBBV5Z3/OZ728Swtyrhbd6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127673; c=relaxed/simple;
	bh=7H93tb4nFoxmqjMsy4F0W3n1gdRCYZwiYhvSl0/wg+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZDjHrPunQSeG9q/3C8CYiX/HJFLAfra1zikmkaQ+8RdTJjxgGd9KrkP9qe/mW7c+uuP1GHhLlnHLLsMm/cUYabyEnKM6kEbsKg/WaLe3ZvUfGHo+mhJqolZtiR1vkoJ/CcNtJp6ZIxFtLvXqBjge17y8k7MyDUXa6joDtV9FrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbGdxWtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FBDC43330;
	Fri, 16 Feb 2024 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127672;
	bh=7H93tb4nFoxmqjMsy4F0W3n1gdRCYZwiYhvSl0/wg+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbGdxWtqka1vUepXIIOKJpZUUEQF1Uh+iaY3+hlzETqCcmxP6BGbwHCIshcPyZFUb
	 xzSTOuJXQrYO7/Ztk+Da3UTt6C93Fe037aE5lryspZh+R6L52VE9jFUhsY/ON83lEQ
	 err2HfGWkSzBYH9wLfxswwyz3rnPiBCOIEhbglSUEh6attWX9Kedvxkj2NrApcUpam
	 Xuaek3p7EIKCg274zuh2LVV26UIGvwtYJolXU1NdZmkJDK+LpSNyE6nSk/b5tFAIka
	 vHdfZNKGzqvR0x/S219pvSC80+1GVprPlDpadUpEqGA4fqz3o22DpIMvpchONw+Yio
	 8qebJZoODgE4w==
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
Subject: [PATCH 12/14] perf annotate-data: Handle this-cpu variables in kernel
Date: Fri, 16 Feb 2024 15:54:21 -0800
Message-ID: <20240216235423.2343167-13-namhyung@kernel.org>
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
and handle %gs in kernel to look up a global variable.  The new
get_percpu_var_info() helper is to get information about the variable.
Pretend it as a global variable by changing the register number to
DWARF_REG_PC.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 86ac44c476bf..5f3136f57c62 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3810,6 +3810,27 @@ void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
 	addr_location__exit(&al);
 }
 
+void get_percpu_var_info(struct thread *thread, struct map_symbol *ms,
+			 u8 cpumode, u64 var_addr, const char **var_name,
+			 int *poffset)
+{
+	struct addr_location al;
+	struct symbol *var;
+	u64 map_addr;
+
+	/* Kernel symbols might be relocated */
+	map_addr = var_addr + map__reloc(ms->map);
+
+	addr_location__init(&al);
+	var = thread__find_symbol_fb(thread, cpumode, map_addr, &al);
+	if (var) {
+		*var_name = var->name;
+		/* Calculate type offset from the start of variable */
+		*poffset = map_addr - map__unmap_ip(al.map, var->start);
+	}
+	addr_location__exit(&al);
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3906,6 +3927,16 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 					    &dloc.type_offset);
 		}
 
+		/* This CPU access in kernel - pretend PC-relative addressing */
+		if (op_loc->reg1 < 0 && map__dso(ms->map)->kernel &&
+		    arch__is(arch, "x86") && op_loc->segment == INSN_SEG_X86_GS) {
+			dloc.var_addr = op_loc->offset;
+			get_percpu_var_info(he->thread, ms, he->cpumode,
+					    dloc.var_addr, &dloc.var_name,
+					    &dloc.type_offset);
+			op_loc->reg1 = DWARF_REG_PC;
+		}
+
 		mem_type = find_data_type(&dloc);
 		if (mem_type)
 			istat->good++;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2bd654620de3..490134d19c9d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -513,6 +513,10 @@ void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
 			 struct disasm_line *dl, u8 cpumode, u64 *var_addr,
 			 const char **var_name, int *poffset);
 
+void get_percpu_var_info(struct thread *thread, struct map_symbol *ms,
+			 u8 cpumode, u64 var_addr, const char **var_name,
+			 int *poffset);
+
 /**
  * struct annotated_basic_block - Basic block of instructions
  * @list: List node
-- 
2.44.0.rc0.258.g7320e95886-goog


