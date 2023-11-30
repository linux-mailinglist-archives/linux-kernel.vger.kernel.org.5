Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FAA7FF017
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbjK3N12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjK3N10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:27:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE999;
        Thu, 30 Nov 2023 05:27:33 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:27:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701350850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdri7M8cZwmmxj44/up6D+Gy+1F00rDNzTB9GeEu0HE=;
        b=41jNNMnHU+E+y5VkeBh3gn0gu3VGhCmUdhi32wfcmJtVqGBgo8YC8Wsqhv3JzME0/vbQa5
        Pbg20X1N8aXvdVkYUVU7ZbhVCUzzESpyUiFzTG6ztx5qxgQciUUCZqQ92Wu3/FH0mzBI0i
        3ehFeLsyenoFwu487bQBmSUfw5XVvmr14YICRAbTZd1xsy2WKRbvQKiomhoh0sTx1D8nK+
        tObrmEAvRTonyQGPcc9dF5HlVlEgIhoTeSAIgUWmohMs3CeVCJTaGYTdmLPqHhX3itWZZ+
        dF9iuRtmQbrCAC0afosB+AjfZbEBchmjkqNeEvJHHRcx85a70r0vYYI0MTH+/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701350850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdri7M8cZwmmxj44/up6D+Gy+1F00rDNzTB9GeEu0HE=;
        b=2KYyMwc2gGnf3SLL8kQG3kOMzJ2bdiXpBeX4KUeBQXp/yCsR9/Km5TqD6CA/OHC7uczcLd
        BFsDGfDI7B1/kKAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2] srcu: Use try-lock lockdep annotation for NMI-safe access.
Message-ID: <20231130132729.niM5FJPc@linutronix.de>
References: <20231121123315.egrgopGN@linutronix.de>
 <ZV5Dhjcb9Jd_lk0O@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV5Dhjcb9Jd_lk0O@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is claimed that srcu_read_lock_nmisafe() NMI-safe. However it
triggers a lockdep if used from NMI because lockdep expects a deadlock
since nothing disables NMIs while the lock is acquired.

This is because commit f0f44752f5f61 ("rcu: Annotate SRCU's update-side
lockdep dependencies") annotates synchronize_srcu() as a write lock
usage. This helps to detect a deadlocks such as
	srcu_read_lock();
	synchronize_srcu();
	srcu_read_unlock();

The side effect is that the lock srcu_struct now has a USED usage in normal
contexts, so it conflicts with a USED_READ usage in NMI. But this shouldn't
cause a real deadlock because the write lock usage from synchronize_srcu() is a
fake one and only used for read/write deadlock detection.

Use a try-lock annotation for srcu_read_lock_nmisafe() to avoid lockdep
complains if used from NMI.

Fixes: f0f44752f5f61 ("rcu: Annotate SRCU's update-side lockdep dependencies")
Link: https://lore.kernel.org/r/20230927160231.XRCDDSK4@linutronix.de
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rcupdate.h | 6 ++++++
 include/linux/srcu.h     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f7206b2623c98..31d523c4e0893 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -301,6 +301,11 @@ static inline void rcu_lock_acquire(struct lockdep_map *map)
 	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
 }
 
+static inline void rcu_try_lock_acquire(struct lockdep_map *map)
+{
+	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
+}
+
 static inline void rcu_lock_release(struct lockdep_map *map)
 {
 	lock_release(map, _THIS_IP_);
@@ -315,6 +320,7 @@ int rcu_read_lock_any_held(void);
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 # define rcu_lock_acquire(a)		do { } while (0)
+# define rcu_try_lock_acquire(a)	do { } while (0)
 # define rcu_lock_release(a)		do { } while (0)
 
 static inline int rcu_read_lock_held(void)
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 127ef3b2e6073..236610e4a8fa5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 
 	srcu_check_nmi_safety(ssp, true);
 	retval = __srcu_read_lock_nmisafe(ssp);
-	rcu_lock_acquire(&ssp->dep_map);
+	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
 }
 
-- 
2.43.0
