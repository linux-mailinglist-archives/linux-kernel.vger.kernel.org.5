Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E27C638F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbjJLD4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377167AbjJLDyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:54:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF7199A;
        Wed, 11 Oct 2023 20:52:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5809d5fe7f7so398725a12.3;
        Wed, 11 Oct 2023 20:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082733; x=1697687533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1kE8iuDTwlI9GdS4S0Z9K7JNGWfoZ1amqFutl3GXsA=;
        b=h5a/6m3ptIDnWrQnWunqK6YgJdALR4Rx83P6CTcH7uiJUnYE+HmptQswrc6ortrgaK
         dc2X1uPxUO0/flFZDWltm/RV6GdDqVb/1BTJAwO3qyj//GKhXhgc6A+o6+91w6XgCRP7
         DMUuZauEi+l696AV0ifNOrwJI/0SCmjj7Sv9hSD6GKzsS6LfBrp5Qs3/bGss4PMEZHil
         9fBfAiwNlwdFzeqk7TVTEJF6i/i66aSrYCTxx3nR/rwlKA9fxwEBy7WMp8obaMQS+/xb
         Ps0TviaIbNpU/JfhxrcdJEi7Jm4MCmu6dqb3y3ywq5ElkNCnMVoYgCO29MfCUUwYsyUq
         t2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082733; x=1697687533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1kE8iuDTwlI9GdS4S0Z9K7JNGWfoZ1amqFutl3GXsA=;
        b=w7+0Xq36mJrZtessq/l6HzwRVFRKb3B5H9BmSLBEDTntz532N9ANZ8s0Ovq8+L6LF7
         uAVMQi0fyNMNU6UAqdDAT1PhZYwgZKLMAixi7E+X5jXqohxuiwPiFHlY/bj0gAzDVXJW
         qU0qMXzKjGc/IYbxtSlm3dbcyV1kxkgQNNG17EcBm2UKShYcK88DoQaNrjXJC8aN4q5w
         pFkmDCZORL1ovc1Ap3r37cu+DgN6euidu4AAFIWW8inmkEIqRnSx5NCpGvQWjnfIU6at
         yQqVU+xoFuqk9wbwZInZkdUWnhwkeE1eWem+WntFXjk5U8RoQOZtk7FS7T+rW5UitEtr
         Xh2w==
X-Gm-Message-State: AOJu0Ywa781CHAF/nItbnqJ/F2PK1fbuOEVg7BzYNLfRrZPwi654NtH/
        ar2tVkj5ItCbNlDvihwj87c=
X-Google-Smtp-Source: AGHT+IEJc3M01zGWFp0ka99aRQFjBrE5xPBLbFf+iPcuVB2WHyZS+rbfRjwijLAmwHsLSmGjFTzcVg==
X-Received: by 2002:a05:6a20:12c1:b0:174:63a9:2ab with SMTP id v1-20020a056a2012c100b0017463a902abmr2119183pzg.45.1697082733543;
        Wed, 11 Oct 2023 20:52:13 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:13 -0700 (PDT)
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
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 45/48] perf annotate-data: Handle this-cpu variables in kernel
Date:   Wed, 11 Oct 2023 20:51:08 -0700
Message-ID: <20231012035111.676789-46-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 7a097f64a28a..414ae45b7c06 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3766,6 +3766,27 @@ void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
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
@@ -3857,6 +3878,16 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 					    &dloc.type_offset);
 		}
 
+		/* This CPU access in kernel - pretend PC-relative addressing */
+		if (op_loc->reg1 == -1 && ms->map->dso->kernel &&
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
index 076b5338ade1..c090cea1abdc 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -511,6 +511,10 @@ void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
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
2.42.0.655.g421f12c284-goog

