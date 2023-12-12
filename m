Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CFC80E04C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbjLLAb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjLLAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:51 -0500
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258FC4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:51 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35d62401a3dso20370205ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341110; x=1702945910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p7jSbmFWzlgqILy1ydi3XwmgeUDLIb9gpoZhCX/f6c=;
        b=eM/7R4dlU+3Hvnd1ff3PxRy31YeSDSlrkl5wUAjSllATS6DsQ+sB1W8rn0uvsQZRq8
         mMVSNkX4pMiGmresjtn31hMW6NVcivPqAxnTT+TyuzNaEwzTROAcIe2nGcZy8EY36sQ5
         herordhLEeKcbjhfJ58TUMUCsBJib0VTcYq0oQNi6RXOy2aE6hyDtiEGR/3JkXhzk25d
         7GXqyoIsJuHKmWoFXkuvjw9FJOuRg7juoUd9veffCb8b3MRdtBYArvF/mEhIfBTPx/oL
         a1iTvIwjZFaFLeOF6nEh+0Vgw2bGIk8N2CPJVUQJGI9QyN4PXZzq+bghax/xblwyQZgR
         V5Eg==
X-Gm-Message-State: AOJu0YzJESYTraqvLntSPio7r+KOX7eIIKtrIAGY0qsO3UJYNcmv7qhz
        zjCPFR8f9nqINL5o68rXeGFvA6wGpkFBNgc5
X-Google-Smtp-Source: AGHT+IEDWhq5oJtmbSoG0V58RDHImr0dKgNzBxhQhPwjIQezYf9dcbMZ4GGr2qbTYn/aO+A4K/HjNA==
X-Received: by 2002:a92:c54a:0:b0:35d:7c07:cc99 with SMTP id a10-20020a92c54a000000b0035d7c07cc99mr6715539ilj.49.1702341110590;
        Mon, 11 Dec 2023 16:31:50 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bl1-20020a056e0232c100b0035d79f5d8acsm2598851ilb.79.2023.12.11.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:50 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 1/8] sched: Expose move_queued_task() from core.c
Date:   Mon, 11 Dec 2023 18:31:34 -0600
Message-ID: <20231212003141.216236-2-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
References: <20231212003141.216236-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The migrate_task_to() function exposed from kernel/sched/core.c migrates
the current task, which is silently assumed to also be its first
argument, to the specified CPU. The function uses stop_one_cpu() to
migrate the task to the target CPU, which won't work if @p is not the
current task as the stop_one_cpu() callback isn't invoked on remote
CPUs.

While this operation is useful for task_numa_migrate() in fair.c, it
would be useful if move_queued_task() in core.c was given external
linkage, as it actually can be used to migrate any task to a CPU.

A follow-on patch will call move_queued_task() from fair.c when
migrating a task in a shared runqueue to a remote CPU.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/sched.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f..fb6f505d5792 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2518,8 +2518,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
  *
  * Returns (locked) new rq. Old rq's lock is released.
  */
-static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-				   struct task_struct *p, int new_cpu)
+struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, int new_cpu)
 {
 	lockdep_assert_rq_held(rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..5afdbd7e2381 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1787,6 +1787,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
+
+extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+				   struct task_struct *p, int new_cpu);
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct balance_callback *head,
-- 
2.42.1

