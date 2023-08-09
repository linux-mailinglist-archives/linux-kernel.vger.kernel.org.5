Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAE776C00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjHIWMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHIWMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:12:50 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F42C6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:12:50 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56d6dfa8b52so254996eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619169; x=1692223969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP5NLcx+M4QmYU6meO9mqo2/zqcH6UWPGLNVDd2SvCk=;
        b=Bd9Cb3SOblK0Z4bDjNX08/vUeDhBcQ7VW7bbMF3JhsbQ+CoHKi8qGicEgX1PXHQwcy
         vxFyOtT+SZztv1CLMlmJurl9RlGPB3a1hBsqRw/aNCibsJ5btVnwoPaubEDo/uSjby42
         6DQZzYABUphMy/+Mao8pWd2yLPnQVC517vSvHl5qWz6L9nwC6ludFX/3Px79bIrBe0bE
         Md53He0lnexok8BLabaLdDyKfDih9XzJaQDIptz9vnvgahlqL8VMIGaNgzbAI0pwK9lM
         0VsD7NJyDgcqF0/ijHeJsI0TAjY/FwarB8J7hxMQyTNz16+w/bcdiJFtjibWkP9MDds4
         qArw==
X-Gm-Message-State: AOJu0YygySZyC8xmQrUjDff+9FNzVA85UmNe0+n/TZGAUdICaWlXkigt
        2o4LdZp+c5ysXkl2RBF/Tt/KXKmPG0jeaD2X
X-Google-Smtp-Source: AGHT+IGBe8mP0Qj6kg8ZMDbIJtGNYttRZE0a2Koi5oC5ID5yZCW805PtwupDPEYN0rNHsxq+Qan/Ww==
X-Received: by 2002:a05:6808:1488:b0:3a7:b47a:9fb with SMTP id e8-20020a056808148800b003a7b47a09fbmr869999oiw.46.1691619169037;
        Wed, 09 Aug 2023 15:12:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ed08])
        by smtp.gmail.com with ESMTPSA id o10-20020a0c8c4a000000b0063f7cf13c56sm3706775qvb.107.2023.08.09.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:12:48 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: [PATCH v3 1/7] sched: Expose move_queued_task() from core.c
Date:   Wed,  9 Aug 2023 17:12:12 -0500
Message-ID: <20230809221218.163894-2-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
References: <20230809221218.163894-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
index 614271a75525..394e216b9d37 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2519,8 +2519,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
index 19af1766df2d..69b100267fd0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1763,6 +1763,9 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SMP
 
+
+extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+				   struct task_struct *p, int new_cpu);
 static inline void
 queue_balance_callback(struct rq *rq,
 		       struct balance_callback *head,
-- 
2.41.0

