Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32F7CE816
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjJRTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJRTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:48:46 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2741A116;
        Wed, 18 Oct 2023 12:48:44 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CAED941538;
        Wed, 18 Oct 2023 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697658519;
        bh=mtPHQ5yHBOHSmjh1WF7JqZ4Wpj+oE6q9+cxhTmzOCaI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=NQcJP978iEeyOSPVexS16F7tPRTFDui8bibK1SrJqrg90/+Ub9rnkOL93qo7O+0Gv
         9jEVOqa7n3iRYD1PbCJk2hIJqwrejMggCM+Vqpdi+y1XbZKtUUP3/2UY5AtHITJGES
         WnXZQ9aEfwEgFAisfcmCMeO38IPzOVrsWeOifOLARedPqlV5MaYsvVA/om0lXenhzi
         lGDqw1iIDvZdEYzxXQQ82XVb5/HkOp5RDrdMPxyLwyywrt8++lOCxRk1TT84/HJnrs
         NWQaepBgBaNoIcQz6wf0MAjuua6eB01SJZZJ/JpfXNq09ZmNEHVeaN3/VEYTBurFoV
         Tb41+mONncNAg==
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RT 02/12] locking/rwbase: Mitigate indefinite writer starvation
Date:   Wed, 18 Oct 2023 15:48:23 -0400
Message-Id: <20231018194833.651674-3-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018194833.651674-1-joseph.salisbury@canonical.com>
References: <20231018194833.651674-1-joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


On PREEMPT_RT, rw_semaphore and rwlock_t locks are unfair to writers.
Readers can indefinitely acquire the lock unless the writer fully acquired
the lock, which might never happen if there is always a reader in the
critical section owning the lock.

Mel Gorman reported that since LTP-20220121 the dio_truncate test case
went from having 1 reader to having 16 readers and that number of readers
is sufficient to prevent the down_write ever succeeding while readers
exist. Eventually the test is killed after 30 minutes as a failure.

Mel proposed a timeout to limit how long a writer can be blocked until
the reader is forced into the slowpath.

Thomas argued that there is no added value by providing this timeout.  From
a PREEMPT_RT point of view, there are no critical rw_semaphore or rwlock_t
locks left where the reader must be preferred.

Mitigate indefinite writer starvation by forcing the READER into the
slowpath once the WRITER attempts to acquire the lock.

Reported-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/877cwbq4cq.ffs@tglx
Link: https://lore.kernel.org/r/20230321161140.HMcQEhHb@linutronix.de
Cc: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 286deb7ec03d941664ac3ffaff58814b454adf65)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 kernel/locking/rwbase_rt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 88191f6e252c..a28148a05383 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -73,15 +73,6 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	int ret;
 
 	raw_spin_lock_irq(&rtm->wait_lock);
-	/*
-	 * Allow readers, as long as the writer has not completely
-	 * acquired the semaphore for write.
-	 */
-	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
-		atomic_inc(&rwb->readers);
-		raw_spin_unlock_irq(&rtm->wait_lock);
-		return 0;
-	}
 
 	/*
 	 * Call into the slow lock path with the rtmutex->wait_lock
-- 
2.34.1

