Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5B7E759E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKJAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbjKJADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F421FFD;
        Thu,  9 Nov 2023 16:01:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso1369689a91.2;
        Thu, 09 Nov 2023 16:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574492; x=1700179292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPYCIl0SPFtUtXhBJ2STPHUgQ84W10L+ZFD5fhYt5l4=;
        b=k48OsoUfHytUkMVPN/zc+YpSz3fz4LzjI0/hcjSRAZdO+g1yF9MljGrgvj51CcUC7c
         DMtmMkC8FAtwn/e0pwGUOv5fqDZND24rUBLe24OD6CymI424G8rJ1+Z1J2SYaD9JfErR
         Z4O/wGZCmJO0dLA+iL3Cw4wl//wY9vh/DaM+e8uiZ8HeNn6dUMH+qINH7XOOH5ZCVpJp
         MMeVk8mCjtBEwufm4wsGD9HFUMwUp0DsqLTVMz6kVmxuo5h/2h2KWlkTJE4XMNPX1L4V
         AjmXFpgoTL1S7lpLv4HiuTqQPjIcHLeHTKbwzVoaLOVsEhmROggWuZcpq3SQpi1fGESU
         yKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574492; x=1700179292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPYCIl0SPFtUtXhBJ2STPHUgQ84W10L+ZFD5fhYt5l4=;
        b=pufvxUGNlVh9Vy30u7mczicFAQIrxY0bskCzoenYwQIi1MhDoVsZKnDLhI4YN15l/9
         JkrP8IdgVtuloPnJQmQ9x5lxVGXiF1is0M/wx/VuFNjdmgU7FhutFSnMQ0UFV+X9hWBj
         RkZpYS2hzMiAluLwCvIniznEkoZKMVJ9rw4GO4NevzTcP+bt6d+ZYjVe0arHng62SvPg
         sKnkojOQ48C17ykVYDv2gtsCuY6+zCNvSRvm+wpTUbYQYFHXGWjHeUp1yrEIcMTx3sDP
         bmN+jgsvxU+xrBYpghurtHcW9i9/lOA9VlgyG+4OppzyTancuNsGxNLNt0EdukGoQXQ0
         vl8g==
X-Gm-Message-State: AOJu0Yy7O9ANpqz6P92527ec0aRMorje2xKadxSK5fnqmb+FMBXlOSu4
        FmYht/w4kXfVDdIGrXaYukI=
X-Google-Smtp-Source: AGHT+IGUJznhRPjctQDkM4r0GLaixAGJfmawGPpiW1jghgltzY4EsWoA1Hf6TdtpsHwv8bKSyfi1uw==
X-Received: by 2002:a17:90b:1e04:b0:280:62a7:3743 with SMTP id pg4-20020a17090b1e0400b0028062a73743mr3412008pjb.30.1699574491830;
        Thu, 09 Nov 2023 16:01:31 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:31 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 49/52] perf annotate-data: Handle this-cpu variables in kernel
Date:   Thu,  9 Nov 2023 16:00:08 -0800
Message-ID: <20231110000012.3538610-50-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index a9075af10d24..9b72eae2400c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3814,6 +3814,27 @@ void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
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
@@ -3905,6 +3926,16 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 					    &dloc.type_offset);
 		}
 
+		/* This CPU access in kernel - pretend PC-relative addressing */
+		if (op_loc->reg1 < 0 && ms->map->dso->kernel &&
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
index 21a0947ed5e9..c3cc0cba10b7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -519,6 +519,10 @@ void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
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
2.42.0.869.gea05f2083d-goog

