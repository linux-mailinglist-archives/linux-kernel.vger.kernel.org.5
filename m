Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3C7AC798
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjIXKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIXKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:39:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A95E100;
        Sun, 24 Sep 2023 03:39:30 -0700 (PDT)
Date:   Sun, 24 Sep 2023 10:39:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695551968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVJiYUzD9F29394TtoNsTaYS7Ooze63GOZWkFzLlpMA=;
        b=X3LnbuF2RoinoquB8qVFCf5wyu/Pnz1ZoRRTdmMznmG4tYI9GiLLa7FdXT+IPRXtQu/Xky
        Ks43mX/4JMY8F0NJGqbXlklUFklQVUtqUn58KypTeyV/47kXOJZ9PLaJdhuHiNqamshkxv
        SMF6ZXooxSIuC+vJ0wYHvlPa3ED7ZHfZTPV0O56DGG+r6pgdh4M6EC86ns3n91Dl3Jn0Mf
        F3cOm8H7Qj4rNjhSQVhatCIQ/H/aE23s4Ou/z4Xr0Fk0vHiMixhOKGfmhw/xWhKNXWYj7K
        TOnE/SN3bPlvMCOtZZq1qOA0XqHWugNN+uE194s9j0lYQaTBfRi4RBj6Dr4VSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695551968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVJiYUzD9F29394TtoNsTaYS7Ooze63GOZWkFzLlpMA=;
        b=Qz3PvNr4tCoAb333h8NE8OICyLqhweMBjp8yQFJG5FcDo3BRDP0T3HQiWHTDCpfFpnLxOz
        nFGwbLzjn7LQrODg==
From:   "tip-bot2 for Wang Jinchao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Refactor the task_flags check for
 worker sleeping in sched_submit_work()
Cc:     Wang Jinchao <wangjinchao@xfusion.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZOIMvURE99ZRAYEj@fedora>
References: <ZOIMvURE99ZRAYEj@fedora>
MIME-Version: 1.0
Message-ID: <169555196768.27769.8331878851124889212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3eafe225995c67f8c179011ec2d6e4c12b32a53d
Gitweb:        https://git.kernel.org/tip/3eafe225995c67f8c179011ec2d6e4c12b32a53d
Author:        Wang Jinchao <wangjinchao@xfusion.com>
AuthorDate:    Sun, 20 Aug 2023 20:53:17 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 12:15:06 +02:00

sched/core: Refactor the task_flags check for worker sleeping in sched_submit_work()

Simplify the conditional logic for checking worker flags
by splitting the original compound `if` statement into
separate `if` and `else if` clauses.

This modification not only retains the previous functionality,
but also reduces a single `if` check, improving code clarity
and potentially enhancing performance.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ZOIMvURE99ZRAYEj@fedora
---
 kernel/sched/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1074934..84881a5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6711,12 +6711,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
-		if (task_flags & PF_WQ_WORKER)
-			wq_worker_sleeping(tsk);
-		else
-			io_wq_worker_sleeping(tsk);
-	}
+	if (task_flags & PF_WQ_WORKER)
+		wq_worker_sleeping(tsk);
+	else if (task_flags & PF_IO_WORKER)
+		io_wq_worker_sleeping(tsk);
 
 	/*
 	 * spinlock and rwlock must not flush block requests.  This will
