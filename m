Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C742C7813DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379680AbjHRTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379872AbjHRTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:47:30 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB4046AF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:46:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7775360174;
        Fri, 18 Aug 2023 21:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692387947; bh=KNgLoSctpeoyclHh1eyk/4dS0zfISR6DPvBHZn9g92I=;
        h=From:To:Cc:Subject:Date:From;
        b=VmNv88ZKk/WPPzes1Xdplwhw3KgFH6ouUxhzf7PqZ5Yz1WZV6n1I+NKLJsxKpFBtY
         WgbUmCjMapEin0GoXlkD2WvS/1lu/ONgdJkhZlsUE5YoyZNVItHsELzhV1RfUXl2Xr
         zIDIMyGS5hg10euXRMes/rIcxSDj2tl48wskYzyT6diz4NwUhH/vGm3hWCJsORBU4H
         MoGgg+tmQLMaeYibxzNwXICZRGCsplUsTystaZQTpulHs3Nef2EogPCNImexscDuL1
         CbOBj0tDhi6gStoyesHWME4crpvxcbwbCvT9wmaiKho6boA62iYclHCmAe1WXLbBdA
         F/G98RXfsASKw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 11FcnylYLHUm; Fri, 18 Aug 2023 21:45:44 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 704986015E;
        Fri, 18 Aug 2023 21:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692387944; bh=KNgLoSctpeoyclHh1eyk/4dS0zfISR6DPvBHZn9g92I=;
        h=From:To:Cc:Subject:Date:From;
        b=vucawU90Pj2ZkUxzDMwzBzATGw9W1sPWHGdZd3gqltmskVaKL+HCpx4AlGtZ9LHHR
         iwarplVtrH4FNEduXg6YbTNGSQMhwRJrVD/uSaxkDddQA4QgMQKjTcI8Cr0QCHY+hK
         rMyimvmF1phP7BcS9mqUcQ5QBQ8nwy27E3SlbHvklRoKA9dedgFIrvcxTXa3M9tXMu
         NSPoXoEs0KAJhBCtcm5UoHXfIsVAL1gFiBAsLJ9TYYSzZfKuhnMP3uu6uI8Y2MxRvp
         DlyJTGPclyXQIyWXNC+hjZ3msK2wcWNZm+rWHsgNNB9FFAyUzgmL27Kf7lJFFCBoYz
         7UKBhXj8xsAGw==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v1 1/1] workqueue: make the increment pwq->stats[] increment atomic
Date:   Fri, 18 Aug 2023 21:44:49 +0200
Message-Id: <20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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

The quick and dirty solution is to use atomic_inc():

    lockdep_invariant_state(true);
→   atomic_inc((atomic_t *) &pwq->stats[PWQ_STAT_STARTED]);
    trace_workqueue_execute_start(work);
    worker->current_func(work);

There seem to be the other instances of the similar use of pwq->stats, but they need separate
patch and testing.

Fixes: 725e8ec59c56c ("workqueue: Add pwq->stats[] and a monitoring script")
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 v1:
	quick and dirty fix (RFC).

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 800b4208dba9..237e5800fbad 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2595,7 +2595,7 @@ __acquires(&pool->lock)
 	 * workqueues), so hiding them isn't a problem.
 	 */
 	lockdep_invariant_state(true);
-	pwq->stats[PWQ_STAT_STARTED]++;
+	atomic_inc((atomic_t *) &pwq->stats[PWQ_STAT_STARTED]);
 	trace_workqueue_execute_start(work);
 	worker->current_func(work);
 	/*
-- 
2.34.1

