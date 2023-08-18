Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C737813E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379765AbjHRTvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379915AbjHRTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:50:58 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A53422B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:50:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A671B60177;
        Fri, 18 Aug 2023 21:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692388232; bh=QQizOGMfDTsikjv1C2XD/mBlnlLOWInaDZZFpDTae5M=;
        h=From:To:Cc:Subject:Date:From;
        b=lB0lMohvILpi4pcCWpu0P2PtIEYPCoOJGgCaM+Jzhhx5hIpJlUSizIF0KXPT2sfkx
         nEPP9BfZs74zKcTr5YBigwEXfr4rheT28cCNwcyBaKIZQnXJnHZcDGtg0vK6quUx6V
         OpTyGQAjeLBjF3TgVukGGTF7FVrppnBff4FxaB7UfWfon62F285iMUiKOVMScMSPrx
         zaBYWm3sszeHWs76l5EyQL/IZCM7Xy869O+LGeHshddz5CWUIPIBseIMNiEqf4Z/0n
         bLggLQjtkSHDwaukA6y1uz5e7Mp4HoOBJrx+ztwP+FVIFWq1Os07m92hdArz69R8EU
         VSBHfjqluJWNQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bjWU8GpgYpSu; Fri, 18 Aug 2023 21:50:29 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id A95CC6015E;
        Fri, 18 Aug 2023 21:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692388229; bh=QQizOGMfDTsikjv1C2XD/mBlnlLOWInaDZZFpDTae5M=;
        h=From:To:Cc:Subject:Date:From;
        b=TqocKPFwpONZp81YiciwvCOl2lXvoUUW6X3kiZTDwaDYqDsrK4k9JQ2aQeboJWoUt
         cuZIld7e3E5dDPzWRmhSXc7gOG3duNhlUKj434gkqlKljkwH3LFSRDVLDuPK6R18Ik
         RR0z044uWiKVpAchyk27CTVHxHwsdipD5e5NvwFU56eJLrRcHgCZ2nNSmgw8MIQKmu
         zwbHfeeI2dXDW+aCYk2IUSB2D0rDApHInjVLV0CnRBArPT4KgETJFjyYAUdpcpk2Ur
         BdkRP8znmLkSnPbOUhG19mH6QGAheHns6ODJ/8uOSZIP5434C904NDwPten01KDiO0
         0Fw6Ex+36ob0w==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v2 1/1] workqueue: make the pwq->stats[] increment atomic
Date:   Fri, 18 Aug 2023 21:48:59 +0200
Message-Id: <20230818194858.29993-1-mirsad.todorovac@alu.unizg.hr>
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
 v2:
	fixed typo in the Subject line, commit unchanged.

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

