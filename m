Return-Path: <linux-kernel+bounces-50646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD55C847C07
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7303D288736
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2428313328F;
	Fri,  2 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejNmlryN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978F132468;
	Fri,  2 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911510; cv=none; b=YcGUObPfeV4wFt26jI4TEDxkMkmeKDbvh9D4GeUZhwpu18muy7t8ewWyAGXOeyUcTyXurao639hB/3mujtKAru5eXRCwIUIBS9RE8Zcv+Jb9RHUQFs0PzViRku+9LncuLZL9Ut0WFjGpGsso5R8Hw/LbGNqj9ZPerQKhtY0QzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911510; c=relaxed/simple;
	bh=ozKwyj+cawqB9+hDRoeS33gIgZE7kn/6L5uzLJ/tqHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/FDJD6DonAnJ7PvYY8WHriLrdDxCGUhedy2chKIMiFKHMvAwyxg1bUE1qGG8satgBu2JyYO6Jo1DyGujUryzqAdupnm8cU8PjCj17wdPJNXokP7nlNmeYB23l1yLvtlby38CNwzVJOnksS+u7MH1x7IdbE4+6eIa4SPEe9Gspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejNmlryN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DAC433F1;
	Fri,  2 Feb 2024 22:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911509;
	bh=ozKwyj+cawqB9+hDRoeS33gIgZE7kn/6L5uzLJ/tqHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejNmlryNPrqsqXEL0aqgztoVPSL1Y6D1cX/Y6sPy6aF8Yp3dfWyet1aTtRxwgBgyi
	 gxv5vFbxXylNw6m1yi7nbtLbGTVMjMsib4ryT/3DnjUSf0xz/NNejb+4rgWW/49kSt
	 NxCMdSH16x2zom61JG7hoZSvCGOe3ii9+QTgWe3TDMdckRQPxZDET71F8xcbY4RcrV
	 ll6ORU5wjSSns4UCRG1ioFgZwl318nlSB7NaQFL1kzdw9xLGHRk+tSZ4W3ZohGgHev
	 z7v5GZtVSSf6cWjXHFnGhNSgrhRRip7BArVFw+0uqfB87e317N3OmlvIb3+aGAITXw
	 ml9RVjSKPpvOg==
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
Date: Fri,  2 Feb 2024 14:04:57 -0800
Message-ID: <20240202220459.527138-13-namhyung@kernel.org>
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
2.43.0.594.gd9cf4e227d-goog


