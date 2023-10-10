Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F07BFA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJJMAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjJJMAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7917196;
        Tue, 10 Oct 2023 05:00:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DBDC43391;
        Tue, 10 Oct 2023 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939202;
        bh=qaLq/eyHDpze8WBnz65vaRdkOfmOKpB2MmuvHIFiCik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCRcrQA39pefD1wQ9xLbtVmaVJUEJy45H047G1h/1RMkw+yLxG4KzZQeRFgCHnbEd
         ky3IoQ1F7i7RImJHGK7BV884RMAcbHPgZx6qMaljCRpoPTVFg/8AEqEVcA5Ev+rmpd
         y5NT1d/CNDVWqgi/OCxzEvS78qa5CNK3DvcJW4Ckhon5Wg9UG9vxxkGyperQTypHYL
         tY/6MG0W4ZOp7dHVwEGIwO6MhLvHKa4ZdHNRgqw0NCYl2I2SHBImD4klxXUAytQBGO
         oRGuvzkmfle7wDK5sbwypvwPO5KZEZifV0FVifbrIONdO8fO4+nIfGsbWocdtsqnjl
         G/JaOUhMzekhw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 10/23] locktorture: Consolidate "if" statements in lock_torture_writer()
Date:   Tue, 10 Oct 2023 13:59:08 +0200
Message-Id: <20231010115921.988766-11-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a pair of adjacent "if" statements with identical conditions in
the lock_torture_writer() function.  This commit therefore combines them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/locking/locktorture.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 57ee16cf879d..c8c322e69a90 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -889,11 +889,10 @@ static int lock_torture_writer(void *arg)
 			lock_is_write_held = true;
 			if (WARN_ON_ONCE(atomic_read(&lock_is_read_held)))
 				lwsp->n_lock_fail++; /* rare, but... */
-
 			lwsp->n_lock_acquired++;
-		}
-		if (!skip_main_lock) {
+
 			cxt.cur_ops->write_delay(&rand);
+
 			lock_is_write_held = false;
 			WRITE_ONCE(last_lock_release, jiffies);
 			cxt.cur_ops->writeunlock(tid);
-- 
2.34.1

