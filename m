Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A057E7587
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345718AbjKJADB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbjKJACN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:13 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411154EFC;
        Thu,  9 Nov 2023 16:01:04 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1194928a12.3;
        Thu, 09 Nov 2023 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574464; x=1700179264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JAGBpBGaq4osme9n0JKrBguz8AS2l54XNgGym3lX7g=;
        b=ddug7hb72+i8Imy0A1D9OjOZPrMnla0CvKNs/3Tns6uIVWweHWbSR2NgfJdQblLfhq
         miRlmXlAbJVAacRTOnMsHrk7nMR2gDlKYweCMHjgTM2n/HSvcveYL+F7hZitrzncA0gD
         nxRQ7FFwT7aBTCJrJMUeRYvZVTrfCpJ46ARiYkdAa4wrmM5uAW0pPmoxFl3HW4s/jtl/
         zniSAF58h1QbMm+LYw2iWHrstSumK7FjR+ivIyR3L7+dlUzv8E6GwHXKCi3ErtaQbwRS
         M2Gztenck8wEddXNA/pAy1Th6IZZaIetUMTRZRljJm+JgZ36QUUDeJK8M4A4/zbbMsJU
         /9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574464; x=1700179264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JAGBpBGaq4osme9n0JKrBguz8AS2l54XNgGym3lX7g=;
        b=Qr0WGT2lqVPS5vxX/Dzd867ZPVQHsDQQtaz0nIjnYLLOLSYGnzNvqBY8dXwEuUn/P2
         ptfbDfX52MqcTcLj6euKaxCDMmHB+HEZaJtDuMh/2unDhnMN/8KWmj7J3hC/Abya1HE3
         w3vNUYAp3X9unv/TCBJmTSV6QOFYnTRI663SqkNjxUQuGfhzLNedJnah97E9rM/C9NoM
         Gs3NSHkhftptTQNN1atXYOTKr01CGAUG+6YFBZ2oVEY2cYXRP95TM5/gQcNUGIYfn1fX
         Ja8hr5wwi5Bwfv8/USdOe6PiZ83xFmwoN9mL5nGg1U0C4nxbmvSs+m0g9QTtg2M3DYGf
         vT8w==
X-Gm-Message-State: AOJu0YwQPCMP+1s3qpujx72lBRM3El1HfRjP3eQoSWIzPnRsn8AZfyGk
        qYbXo+86X/ZoF/7DzzRpMjA=
X-Google-Smtp-Source: AGHT+IEwZ2gYlskDDB5oreKUo9s7/LOJTZVK1IKLbgzsRlq9u1SjQD4taZgFIjm7x+qsyk/B+SYVyA==
X-Received: by 2002:a17:90b:17cb:b0:27d:d9c2:6ee5 with SMTP id me11-20020a17090b17cb00b0027dd9c26ee5mr3556223pjb.9.1699574463252;
        Thu, 09 Nov 2023 16:01:03 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:02 -0800 (PST)
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
Subject: [PATCH 31/52] perf annotate-data: Add stack operation pseudo type
Date:   Thu,  9 Nov 2023 15:59:50 -0800
Message-ID: <20231110000012.3538610-32-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 19e7f4000368..4ea32c2dee4b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -104,6 +104,14 @@ static struct ins_ops ret_ops;
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
@@ -3728,6 +3736,18 @@ static struct annotated_item_stat *annotate_data_stat(struct list_head *head,
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
@@ -3788,6 +3808,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
2.42.0.869.gea05f2083d-goog

