Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAFA7C6380
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377029AbjJLDyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbjJLDw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC0E5;
        Wed, 11 Oct 2023 20:51:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c737d61a00so4806775ad.3;
        Wed, 11 Oct 2023 20:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082710; x=1697687510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jbp8DzEFzCS/HQQoHHK2CySAUhB+wIeKLpuPuedDb9Q=;
        b=eIshufyTBmJATgHDh2W+F/A3w8jg6pCBc7eQ/oqePTnTkdo1wB2LEhNKcO20a8uJNa
         rUIug7y6dADWv8ZajwWvtbqkUmAC93JcZYRu75j+YwYGYmoxtOkpXC0hW6MM4y4NmWKL
         MR8kvm8yyKc1Wbndousp/H34GKt4WbXVKXlfdHoI3yM3aKyq9bsppjpQOyHXVOqNUa4F
         MnoS/1/yc2E3OVOxSggYfsjqEMToeSHkGA5oeeJCzN7kqfhepEEF/V5S20IWYev4Dmqm
         K1kEFyqkP/iN0qMRJvVd7c8qh0/ZNKfzYLbs7FGEzmIT/bj/78gmGcI0GamBWGvNGN3D
         PoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082710; x=1697687510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jbp8DzEFzCS/HQQoHHK2CySAUhB+wIeKLpuPuedDb9Q=;
        b=dYr4qCfslNoi+XVJgaFi6B9HW9RzhrlvDekrhO8VX6zBGQW/zTymC4L4Qlsn7RTzni
         4jeKf6uO+hRK65HHwMomOsx44llDhXgdJk8bMTecYJdwOzrRFcpDaWkDBjZ3IeQtFWza
         K9cIMuq0viF3tf2IwyZXos4rlvOyVcxAwGEKazSOXzODKiAq4g19gVdi6nhuIBDv+6yL
         BOt/HejNCph4rYOrQ5lnzBcyYviF2mIw407x4kRLcrraX9JGBLR3mb0QIdWj1+lAeTpd
         Wqm1UwKzwFn26ma5p6ffeezCfdcg5Yu6Fv+zLVYibPB2qfJ8UY7jzUb/nmTNJabkfb6A
         Dplg==
X-Gm-Message-State: AOJu0Yw2Y1t+Ajro2U1VPFmGoSn4OwI8E+KF7BObEKqWWhXKxxDpthrk
        bB4RaawGXIRwXlgJTgSLJLs=
X-Google-Smtp-Source: AGHT+IEIMKTTxCxxaR8KKMtaMId7cZL9K6kxGCgzNuDeuV+kMlZJPgPyAQpBd60zXkOUZ47ArbzZ7A==
X-Received: by 2002:a17:902:f546:b0:1c5:b622:6fcd with SMTP id h6-20020a170902f54600b001c5b6226fcdmr29003301plf.22.1697082710218;
        Wed, 11 Oct 2023 20:51:50 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:49 -0700 (PDT)
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
Subject: [PATCH 27/48] perf annotate-data: Add stack operation pseudo type
Date:   Wed, 11 Oct 2023 20:50:50 -0700
Message-ID: <20231012035111.676789-28-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 tools/perf/util/annotate-data.c |  7 +++++++
 tools/perf/util/annotate-data.h |  1 +
 tools/perf/util/annotate.c      | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index bf6d53705af3..a4276106e8a8 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -29,6 +29,13 @@ struct annotated_data_type unknown_type = {
 	},
 };
 
+struct annotated_data_type stackop_type = {
+	.self = {
+		.type_name = (char *)"(stack operation)",
+		.children = LIST_HEAD_INIT(stackop_type.self.children),
+	},
+};
+
 /* Data type collection debug statistics */
 struct annotated_data_stat ann_data_stat;
 
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
index ccd1200746dd..dbbd349e67fc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3688,6 +3688,18 @@ static struct annotated_item_stat *annotate_data_stat(struct list_head *head,
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
@@ -3748,6 +3760,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
2.42.0.655.g421f12c284-goog

