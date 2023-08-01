Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADEE76BF3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjHAVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHAVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D435A2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=drbNuL55DYuL5wiscrlTnGAb/cO6SeGIhgtGTiA6PhQ=; b=CmSlmMvBqFeZkasybngqkB/9/Z
        mUv7r6cmiKzOML5p3sP/7eNW16u9qXgad8LSgfbpyGh4CxsLLmw2+fNFo/ocTFfJNo0Roo/ELwr6o
        VWbMNAPshVBVeQplDvk7SN1Lgu5HGT6/O2moDQB/+MlNaKc8mQ0s4GL3cEOphzAOK24BFFOkgWJFk
        GzKQEzHnF7TRhjXrm0ER9eKzep+vUFLQNNxtbR+DusrIdrO6+z7R6eEDn9IfZESBYjm8ARA9ed+eh
        4e2nwM1i8mQ175codWVx83vH1F5D6LSOw/I4VMx1Ei1MK7jL0k6BtcRWfsQ7puqN0FmXoKGXL4Zph
        igvkYxww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQwqn-00EvTv-1f;
        Tue, 01 Aug 2023 21:24:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEDCA3006ED;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4BEB720282F78; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211812.168490417@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] sched: Simplify sched_exec()
References: <20230801204121.929256934@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5431,23 +5431,20 @@ unsigned int nr_iowait(void)
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


