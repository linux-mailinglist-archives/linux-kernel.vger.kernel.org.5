Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E29789798
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjHZO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHZO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:58:03 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A9C9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:58:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0CFA46015F;
        Sat, 26 Aug 2023 16:57:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693061877; bh=mNpAKpZVOQpI7d7tjB6CZf/grXuVVR5g3oppxne9y30=;
        h=From:To:Cc:Subject:Date:From;
        b=ofFqEW4aDIH2mI0Xm1pwoJeKFKXkqsoIHmtg+k0HaciySnq3ce/aC7Va4ClW3dFPX
         EM4RSgLNDJUvcFoOWh76n9SswYSQfNwcehgDv0a19mC6KzU0YLcqboM6VH2XNC7lgC
         4YYNZLuYyDzDzdZZ+w5wVxwC8U+YhS02HgZdIjqq+6KNOnePWlKeF71YRJ1tmvHH0d
         bbq65KMDwEUcQrCbvjY/sOqKn+EwTAgTd5lli5jr4eNlcBctq0844+yNE9IlbRC9h7
         KpS2J7B+LWywIzPNibOjH7a4PGE22mwhQ6LSUIco0BS04FwFKBkL/cDDic7FBo9m7e
         tW+IPTLLVVLzg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9liayQ1X24Zw; Sat, 26 Aug 2023 16:57:53 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 6C2B36015E;
        Sat, 26 Aug 2023 16:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693061873; bh=mNpAKpZVOQpI7d7tjB6CZf/grXuVVR5g3oppxne9y30=;
        h=From:To:Cc:Subject:Date:From;
        b=q997b+BtE3XeRBLIcRr+1GbMAE75HNMHaAPeW4hcInCpQV+d4lTocLiVODvfA12VR
         qo3PN0n8nK/ZuXV7oHeSn2AUNy8LWyU2M8tpk8D7zg0XeEx3dF/x6eRzYUEKJDbRtV
         TNw7dpohRFWWI0TzoBRXkcGU994lyeOWb7Jpxqi8HTQLX3nOCe8CteP0TbXQUO+fmJ
         aLpGA0yCKdk04zLlKTp1RCVEbsLOBgGMmB7CJ1EAq1dqtxRem82xuxgofVgHFjUrgP
         MdfBaDDK0heHFjeIYtx92d6rzR5qONkoircJO7IM/oDHyKqwiHTtaK1wa3+lKnxOmM
         TyMNYDbqbWbZg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v2 1/1] workqueue: fix data race with the pwq->stats[] increment
Date:   Sat, 26 Aug 2023 16:51:03 +0200
Message-Id: <20230826145102.5962-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN has discovered a data race in kernel/workqueue.c:2598:

[ 1863.554079] ==================================================================
[ 1863.554118] BUG: KCSAN: data-race in process_one_work / process_one_work

[ 1863.554142] write to 0xffff963d99d79998 of 8 bytes by task 5394 on cpu 27:
[ 1863.554154] process_one_work (kernel/workqueue.c:2598)
[ 1863.554166] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
[ 1863.554177] kthread (kernel/kthread.c:389)
[ 1863.554186] ret_from_fork (arch/x86/kernel/process.c:145)
[ 1863.554197] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[ 1863.554213] read to 0xffff963d99d79998 of 8 bytes by task 5450 on cpu 12:
[ 1863.554224] process_one_work (kernel/workqueue.c:2598)
[ 1863.554235] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
[ 1863.554247] kthread (kernel/kthread.c:389)
[ 1863.554255] ret_from_fork (arch/x86/kernel/process.c:145)
[ 1863.554266] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[ 1863.554280] value changed: 0x0000000000001766 -> 0x000000000000176a

[ 1863.554295] Reported by Kernel Concurrency Sanitizer on:
[ 1863.554303] CPU: 12 PID: 5450 Comm: kworker/u64:1 Tainted: G             L     6.5.0-rc6+ #44
[ 1863.554314] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 1863.554322] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[ 1863.554941] ==================================================================

    lockdep_invariant_state(true);
→   pwq->stats[PWQ_STAT_STARTED]++;
    trace_workqueue_execute_start(work);
    worker->current_func(work);

Moving pwq->stats[PWQ_STAT_STARTED]++; before the line

    raw_spin_unlock_irq(&pool->lock);

resolves the data race without performance penalty.

KCSAN detected at least one additional data race:

[  157.834751] ==================================================================
[  157.834770] BUG: KCSAN: data-race in process_one_work / process_one_work

[  157.834793] write to 0xffff9934453f77a0 of 8 bytes by task 468 on cpu 29:
[  157.834804] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606) 
[  157.834815] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752) 
[  157.834826] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389) 
[  157.834834] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145) 
[  157.834845] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312) 

[  157.834859] read to 0xffff9934453f77a0 of 8 bytes by task 214 on cpu 7:
[  157.834868] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606) 
[  157.834879] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752) 
[  157.834890] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389) 
[  157.834897] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145) 
[  157.834907] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312) 

[  157.834920] value changed: 0x000000000000052a -> 0x0000000000000532

[  157.834933] Reported by Kernel Concurrency Sanitizer on:
[  157.834941] CPU: 7 PID: 214 Comm: kworker/u64:2 Tainted: G             L     6.5.0-rc7-kcsan-00169-g81eaf55a60fc #4
[  157.834951] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[  157.834958] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[  157.835567] ==================================================================

in code:

        trace_workqueue_execute_end(work, worker->current_func);
→       pwq->stats[PWQ_STAT_COMPLETED]++;
        lock_map_release(&lockdep_map);
        lock_map_release(&pwq->wq->lockdep_map);

which needs to be resolved separately.

Fixes: 725e8ec59c56c ("workqueue: Add pwq->stats[] and a monitoring script")
Cc: Tejun Heo <tj@kernel.org>
Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
Link: https://lore.kernel.org/lkml/20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 v2:
        Lai Jiangshan suggested that pwq->stats[PWQ_STAT_STARTED] increment is
        moved ahead of raw_spin_unlock_irq(&pool->lock); (RFC)
	Additional data race in kernel/workqueue.c:2606 disovered by KCSAN.

 v1:
        quick and dirty fix (RFC).

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 800b4208dba9..e51ab3d4765e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2569,6 +2569,7 @@ __acquires(&pool->lock)
 	 */
 	set_work_pool_and_clear_pending(work, pool->id);
 
+	pwq->stats[PWQ_STAT_STARTED]++;
 	raw_spin_unlock_irq(&pool->lock);
 
 	lock_map_acquire(&pwq->wq->lockdep_map);
@@ -2595,7 +2596,6 @@ __acquires(&pool->lock)
 	 * workqueues), so hiding them isn't a problem.
 	 */
 	lockdep_invariant_state(true);
-	pwq->stats[PWQ_STAT_STARTED]++;
 	trace_workqueue_execute_start(work);
 	worker->current_func(work);
 	/*
-- 
2.34.1

