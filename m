Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893E37E8891
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjKKCub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjKKCuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:50:03 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C346A4;
        Fri, 10 Nov 2023 18:49:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d33298f8fdso1428415a34.1;
        Fri, 10 Nov 2023 18:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670976; x=1700275776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ5DGNkzrpF+z1k1MORpA8Dv8wskoKjmfE9MNDUcVko=;
        b=cZPmSn+8Jb35MhtKxNcdO+3XCzDUbzLEhHNku9jJHvpehDcSDXgQ4zdW7hmV820bCW
         4eJX4eWaTGhywsAM6IzOJZ/o3X7i34jbX0d72c00Ul2EGxO7Z2z/hxTC/QCTVyVjCbHX
         bOFkoxhcRi8daFgSTAkIZDEOWKDqvA3eBBVYK5W2wPIv1/+MPvd6c9lc9T+V4yBIIHzc
         dE0vGxlKyyeH02AYWufNeW8TmQv7e80Hts3bqJcNJAEAQkCfM/z0aKWMq+18OmpyTOkk
         XMEcFnIC82rpTc0h6M34jhoWWcscOTseMQZ8PEZJgP5BpgcRiJh1aPmYvmofQ382v+Fy
         Bfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670976; x=1700275776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZ5DGNkzrpF+z1k1MORpA8Dv8wskoKjmfE9MNDUcVko=;
        b=F7tNQjZ3Vh6BYdFXsL32NOTzJbU975LvxDZpFgHCbmjcU4tRBWflZ34vR2boOVp7su
         2UB+CCxh07JQdWYsRo3aEHqDaxSuRFR3WZgYf0heQE1d9cevlLqSqIO4VF7s3Z3yJkAj
         GBZbtpJCh3P8722gGn/co+EQKBbEgHK+Odgnf3k3VNqNONt5+TNplh5hzX4oqWrrujJ1
         2h7heNK9Ay1M6ZWYxhtu9pv5To4JuCC8x/TSVWWN/i6RpunRqejDHIh/U8BYtHiCuADr
         TFMbooGmvS3eDFQ0S4qCRAdmJIHA4fgPe5PGWsMWaz8r0loKN36WZHMYak+8OsP0Zjxu
         Ba8g==
X-Gm-Message-State: AOJu0YxuRjKvUWmua3jJg3RfNXevZcWDL6ynPmbo5lQa1scHFJi8zkYB
        P01J+CnIFriAvRqp7x2r47o=
X-Google-Smtp-Source: AGHT+IGc/m2/1Xy0BJSd9qMDp7p0LifXaQ+Jwd9Tf1KuVMJfXRBOkQbg8pSYNAioEna6UHc5i9sDIA==
X-Received: by 2002:a05:6830:4387:b0:6d6:446b:ee69 with SMTP id s7-20020a056830438700b006d6446bee69mr1000021otv.6.1699670975712;
        Fri, 10 Nov 2023 18:49:35 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902708400b001c739768214sm360790plk.92.2023.11.10.18.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/36] sched_ext: Make watchdog handle ops.dispatch() looping stall
Date:   Fri, 10 Nov 2023 16:47:47 -1000
Message-ID: <20231111024835.2164816-22-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dispatch path retries if the local DSQ is still empty after
ops.dispatch() either dispatched or consumed a task. This is both out of
necessity and for convenience. It has to retry because the dispatch path
might lose the tasks to dequeue while the rq lock is released while trying
to migrate tasks across CPUs, and the retry mechanism makes ops.dispatch()
implementation easier as it only needs to make some forward progress each
iteration.

However, this makes it possible for ops.dispatch() to stall CPUs by
repeatedly dispatching ineligible tasks. If all CPUs are stalled that way,
the watchdog or sysrq handler can't run and the system can't be saved. Let's
address the issue by breaking out of the dispatch loop after 32 iterations.

It is unlikely but not impossible for ops.dispatch() to legitimately go over
the iteration limit. We want to come back to the dispatch path in such cases
as not doing so risks stalling the CPU by idling with runnable tasks
pending. As the previous task is still current in balance_scx(),
resched_curr() doesn't do anything - it will just get cleared. Let's instead
use scx_kick_bpf() which will trigger reschedule after switching to the next
task which will likely be the idle task.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/ext.c             | 17 +++++++++++++++++
 tools/sched_ext/scx_qmap.bpf.c | 17 +++++++++++++++++
 tools/sched_ext/scx_qmap.c     |  8 ++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c18a67791bc7..d0c60dfac08e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,7 @@
 enum scx_internal_consts {
 	SCX_NR_ONLINE_OPS	= SCX_OP_IDX(init),
 	SCX_DSP_DFL_MAX_BATCH	= 32,
+	SCX_DSP_MAX_LOOPS	= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT = 30 * HZ,
 };
 
@@ -174,6 +175,7 @@ static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
 
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 		      u64 enq_flags);
+void scx_bpf_kick_cpu(s32 cpu, u64 flags);
 
 struct scx_task_iter {
 	struct sched_ext_entity		cursor;
@@ -1298,6 +1300,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	struct scx_rq *scx_rq = &rq->scx;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	int nr_loops = SCX_DSP_MAX_LOOPS;
 
 	lockdep_assert_rq_held(rq);
 
@@ -1352,6 +1355,20 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 			return 1;
 		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
 			return 1;
+
+		/*
+		 * ops.dispatch() can trap us in this loop by repeatedly
+		 * dispatching ineligible tasks. Break out once in a while to
+		 * allow the watchdog to run. As IRQ can't be enabled in
+		 * balance(), we want to complete this scheduling cycle and then
+		 * start a new one. IOW, we want to call resched_curr() on the
+		 * next, most likely idle, task, not the current one. Use
+		 * scx_bpf_kick_cpu() for deferred kicking.
+		 */
+		if (unlikely(!--nr_loops)) {
+			scx_bpf_kick_cpu(cpu_of(rq), 0);
+			break;
+		}
 	} while (dspc->nr_tasks);
 
 	return 0;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index da43f962ab4e..1c3a7d050e32 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -28,6 +28,7 @@ const volatile u64 slice_ns = SCX_SLICE_DFL;
 const volatile bool switch_partial;
 const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
+const volatile u32 dsp_inf_loop_after;
 const volatile s32 disallow_tgid;
 
 u32 test_error_cnt;
@@ -187,6 +188,22 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	s32 pid;
 	int i;
 
+	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
+		struct task_struct *p;
+
+		/*
+		 * PID 2 should be kthreadd which should mostly be idle and off
+		 * the scheduler. Let's keep dispatching it to force the kernel
+		 * to call this function over and over again.
+		 */
+		p = bpf_task_from_pid(2);
+		if (p) {
+			scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, 0);
+			bpf_task_release(p);
+			return;
+		}
+	}
+
 	if (!idx || !cnt) {
 		scx_bpf_error("failed to lookup idx[%p], cnt[%p]", idx, cnt);
 		return;
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index cac9f0780ce9..3d99a8e9b676 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -18,12 +18,13 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-d PID] [-p]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-d PID] [-p]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
+"  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
@@ -49,7 +50,7 @@ int main(int argc, char **argv)
 	skel = scx_qmap__open();
 	SCX_BUG_ON(!skel, "Failed to open skel");
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:d:ph")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:d:ph")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -63,6 +64,9 @@ int main(int argc, char **argv)
 		case 'T':
 			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
 			break;
+		case 'l':
+			skel->rodata->dsp_inf_loop_after = strtoul(optarg, NULL, 0);
+			break;
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
-- 
2.42.0

