Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E614A7BC93B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344101AbjJGRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjJGRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:11:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E579C;
        Sat,  7 Oct 2023 10:11:00 -0700 (PDT)
Date:   Sat, 07 Oct 2023 17:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696698657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qxOsyzNLULe8IX+kSDd7OdRreRx580qotjDMWlV34o=;
        b=VUHZhGMWeLmW9dA8Q3AEjzkfV5RLnKsOPZtTxqdPzhaJzjhM6kIGfvEeRQgeqVTzIi6Chy
        TModgjsVCmHGwus2Yx0h7tsbYh5mghSB/yhWz+XTkXWlsx9Dec1WDOQiDVRo6N2EwH8d+P
        6+UzwXRgvxav9ZCGEOr8Woonse+yA6Ev9WI99PVigJI44yQOlNsQ09fVl6VQnXDb8RrpIV
        mxGFdrugvnddvdr6o4WbmIGALgEvLrhtV/Xu1vz1QUrlpQMIBuRo20ywcwbVYPr5sPGnfE
        Ul5r+v78pKvi/PzmzB/TpDddd58LO7RIKvjf9rpl6CQYkndHK0pAVdojyYZjFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696698657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qxOsyzNLULe8IX+kSDd7OdRreRx580qotjDMWlV34o=;
        b=ISS+PjGbbvhVaYABbIl1noWYZ5RhUB/tVshyItdLWHbPwUyPetzvyfAa6rULEASMlR+cX6
        dUmn+626UF6zJaBw==
From:   "tip-bot2 for Yajun Deng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Print 'tgid' in sched_show_task()
Cc:     Yajun Deng <yajun.deng@linux.dev>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230720080516.1515297-1-yajun.deng@linux.dev>
References: <20230720080516.1515297-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Message-ID: <169669865669.3135.10220410461181815312.tip-bot2@tip-bot2>
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

Commit-ID:     bc87127a45928de5fdf0ec39d7a86e1edd0e179e
Gitweb:        https://git.kernel.org/tip/bc87127a45928de5fdf0ec39d7a86e1edd0e179e
Author:        Yajun Deng <yajun.deng@linux.dev>
AuthorDate:    Thu, 20 Jul 2023 16:05:16 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Oct 2023 11:33:28 +02:00

sched/debug: Print 'tgid' in sched_show_task()

Multiple blocked tasks are printed when the system hangs. They may have
the same parent pid, but belong to different task groups.

Printing tgid lets users better know whether these tasks are from the same
task group or not.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230720080516.1515297-1-yajun.deng@linux.dev
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5783cb..cf6d3fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9089,9 +9089,9 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
-		free, task_pid_nr(p), ppid,
-		read_task_thread_flags(p));
+	pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d flags:0x%08lx\n",
+		free, task_pid_nr(p), task_tgid_nr(p),
+		ppid, read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
