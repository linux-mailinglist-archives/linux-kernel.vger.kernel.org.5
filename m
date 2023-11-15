Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90FE7EBF14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjKOJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjKOJFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:05:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDE120;
        Wed, 15 Nov 2023 01:04:58 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLOytOKGBnb6B6iJmpeTnDki+l9w/n1XwObQHovifBs=;
        b=PrzolQA+m5jo/hrKeMdyMgGQPJUMxcOFUbgxFPb0/ViRvNCeoKpE/08kFEy9dMC+323Vxm
        XKwRQqAbOif4z7cgleZonVX4ONnJw+wj+T1h86+fcrlq3xh1NH3kON2EqAJZG1gwoNNLSu
        8re8R7bVVyu4d/sj+N8Gh+wzwstGbA9EObgwFe44nIo1kuDpFaUaVt9YANtloeZgttA9Dw
        LRNhB0/oNa3Yz4wXb+p/JtFjTfyErKJFRyIDUOBQkbC9oZL21aGteLaJwrGi2PDc65d09g
        priLf+9ssVuQaA1ti2CwkcgyS/iEbsd48zJ7EHrh9OyVilFJ/mt52oaCcZVQLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLOytOKGBnb6B6iJmpeTnDki+l9w/n1XwObQHovifBs=;
        b=igLiwJk5GVFqc2Kx5uJ0OuPxYuQVWIocZ3L9201Mx90oWfsXfyPEbpy+fHODpV8qOP+F4X
        Qcyw5Xqf0PvUHcAw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Use WRITE_ONCE() for p->on_rq
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e4896e0b-eacc-45a2-a7a8-de2280a51ecc@paulmck-laptop>
References: <e4896e0b-eacc-45a2-a7a8-de2280a51ecc@paulmck-laptop>
MIME-Version: 1.0
Message-ID: <170003909617.391.3174076166121466906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d6111cf45c5787282b2e20d77bdb6b28881d516a
Gitweb:        https://git.kernel.org/tip/d6111cf45c5787282b2e20d77bdb6b28881d516a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 31 Oct 2023 11:12:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:45 +01:00

sched: Use WRITE_ONCE() for p->on_rq

Since RCU-tasks uses READ_ONCE(p->on_rq), ensure the write-side
matches with WRITE_ONCE().

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/e4896e0b-eacc-45a2-a7a8-de2280a51ecc@paulmck-laptop
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d22..9d5099d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2124,12 +2124,14 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_task(rq, p, flags);
 
-	p->on_rq = TASK_ON_RQ_QUEUED;
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_QUEUED);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 }
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
+	WRITE_ONCE(p->on_rq, (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 
 	dequeue_task(rq, p, flags);
 }
