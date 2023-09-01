Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC478F90E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbjIAH0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIAH0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:26:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37E10CA;
        Fri,  1 Sep 2023 00:26:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c0db66af1bso11780175ad.2;
        Fri, 01 Sep 2023 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693553203; x=1694158003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAGxcS0Opg+suR3IknDJWnVNGUT8oBpwETzoofGK/sw=;
        b=UPC+suIhIevumcrWZeVZACmRV+AHVov+3oMCymq22h1SjofgoaLCHuLWzoUeDx5yPw
         IGrwyQTVYwZYePNDptJAbbmFkoVDZ602hEVagVrpng3DF6CrULtJ2eyucG90xmQTw/B7
         lrhnVqAzPnVayx1U8wlmB0bhx9Z4vvogLfT4G5lCOrs+oqU/qpreu2wdULu1JUggQG6a
         wFyha2cg1Jpwuf9wQZXiNKCfkbAfOMZa0Xn8XXcB52XFXFvNKqjbXCSPN3+vjjKmY9d+
         lmopbdBSlJtVKnudhyFM9kSWaeQvcNRAIw41O9OoO4gOIGfNToPrtnsUzVD7E62JQCDk
         W4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693553203; x=1694158003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAGxcS0Opg+suR3IknDJWnVNGUT8oBpwETzoofGK/sw=;
        b=d7tg3gMJ2xvmPNOTnZzgmGbgAtkD5bd4NDIgjIywZeg6zX/pWEw5Ri34HFHj8lpHhA
         h+JUG2MmzvQZ43rTHvoaLJL6qqd45zJKsr68VJyIPMXp2pHNkLiTqN+4Me7tiRAEBkHr
         GHkzuM+ejzAl7395esyaFGb+kh3B82qQg+inyKxMb6V585jvaQYVWEuevkw5SqQfakhq
         6+ZhV+huUXpiMcaW2pfiRCxhOpAFDRms//PDLVDKGpZ6kRKT0HdcOyjtbjSV9CHrdVV9
         GoCOcGpbO/3h9wGWUG6RnJr3DTX3Ki13FdPuDtVmT4yKR32m+zJv5CXmznf9DD50q1g+
         rDJQ==
X-Gm-Message-State: AOJu0YwAaGtH9NILjOX9zlNVqsff11G8ytsDcliZBrsYzPqS3Mca+KyS
        DrDT6NU98bAhtWCWGcxhg2LPpGGZQVE=
X-Google-Smtp-Source: AGHT+IHr9WLh627Owj6tG8ggbr7GaKxtaT4zpm8yoG7cPq4FeRZd8DQNOOOqoLnlzDIM6NzVdGITRg==
X-Received: by 2002:a17:902:a5c9:b0:1c0:c7ae:a8a2 with SMTP id t9-20020a170902a5c900b001c0c7aea8a2mr1668718plq.35.1693553203285;
        Fri, 01 Sep 2023 00:26:43 -0700 (PDT)
Received: from localhost.localdomain ([8.210.156.175])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001bdd719874esm2357971plb.168.2023.09.01.00.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 00:26:42 -0700 (PDT)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>, stable@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix the unusable problem caused by non-empty pipe_cpumask
Date:   Fri,  1 Sep 2023 15:26:26 +0800
Message-Id: <20230901072626.278880-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem in the linux-6.5 when I execute the following
command:

 $ perf ftrace -t irqsoff
 failed to open trace_pipe

At the same time, when I open this file, the same error occurs.

Therefore, after carefully looking at the code, the open function of
'trace_pipe' returns -EBUSY in open_pipe_on_cpu() because no clearing
operation was performed when 'trace_array->pipe_cpumask' was allocated.

With this patch, Use zalloc_cpumask_var() to ensure that
'trace_array->pipe_cpumask' is reset to 0 when allocated.

Cc: stable@vger.kernel.org
Fixes: c2489bb7e6be ("tracing: Introduce pipe_cpumask to avoid race on trace_pipes")
Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d8233d34b5a0..c0b8a72f3466 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9461,7 +9461,7 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
-	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
@@ -10406,7 +10406,7 @@ __init static int tracer_alloc_buffers(void)
 	if (trace_create_savedcmd() < 0)
 		goto out_free_temp_buffer;
 
-	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
 		goto out_free_savedcmd;
 
 	/* TODO: make the number of buffers hot pluggable with CPUS */
-- 
2.39.2

