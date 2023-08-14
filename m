Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048777BC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjHNPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjHNPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CB10DB;
        Mon, 14 Aug 2023 08:08:06 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MG8zIdJaSPttNahgRZX3O6vRsNEXcaW746LCNK2vMc=;
        b=RoDhZ4+Kl0lbICE+t7kADNeImv/UR2CKzyWTtj54Z0UAkt9j7WYeSc/hZLy60a3oF+sqhz
        VvSc3qjnR5lC7AgtDETNtQ3ELCLqDQh2F1kBE4j8xZxoMcHbXjRwKW0VEkDkQhZ/U+Tr31
        6KCw5Vi6RUd44rkFrccw6VAKT/51+9un5RjDTpnvAGeCHvK93Oz40TBPyXabjGt4Ql/sXq
        pKCU9kxb3o5Mndj5k+LzmRUizKbNABYPXOpqInETIACPseg/U42zE1ql6tdBGGcQXgL5Lf
        vT3Nz+iRgexIF7K5VImEIs7elpHqTNFSRIDVPv+uQyoJoxXDYm8TV6qtMzEtRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MG8zIdJaSPttNahgRZX3O6vRsNEXcaW746LCNK2vMc=;
        b=Q5Qcc+x0j1p3HtKhvPdVshLubnm2DRKWX8qFvEYilchkZEVBcwrM6jDi4MDFHqV9TqnVmd
        epaq5PcTpj8+PTCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_exec()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211812.168490417@infradead.org>
References: <20230801211812.168490417@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568491.27769.6494521766531042551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4bdada79f3464d85f6e187213c088e7c934e0554
Gitweb:        https://git.kernel.org/tip/4bdada79f3464d85f6e187213c088e7c934e0554
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:26 +02:00

sched: Simplify sched_exec()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211812.168490417@infradead.org
---
 kernel/sched/core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 68bd68d..cd7f2ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5498,23 +5498,20 @@ unsigned int nr_iowait(void)
 void sched_exec(void)
 {
 	struct task_struct *p = current;
-	unsigned long flags;
+	struct migration_arg arg;
 	int dest_cpu;
 
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
-	if (dest_cpu == smp_processor_id())
-		goto unlock;
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
+		dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
+		if (dest_cpu == smp_processor_id())
+			return;
 
-	if (likely(cpu_active(dest_cpu))) {
-		struct migration_arg arg = { p, dest_cpu };
+		if (unlikely(!cpu_active(dest_cpu)))
+			return;
 
-		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-		return;
+		arg = (struct migration_arg){ p, dest_cpu };
 	}
-unlock:
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
 }
 
 #endif
