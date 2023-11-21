Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CA27F2D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjKUMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjKUMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:33:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459C11C;
        Tue, 21 Nov 2023 04:33:19 -0800 (PST)
Date:   Tue, 21 Nov 2023 13:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700569997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Fh9e3GaErBHGJCOCbK/EGCyKE1R80+6heNDm0N0TMWA=;
        b=wRATZsQk4Ria7Rl7ltcBbbJTT3Ilc9PeqBCPZJtujOZ9ckY4Js7fjsSeJU9HwCP6aSCSh2
        Lz+cmtIpDw014hyQGiwFtek83644Yn9ATk2kff11HAdoTCSi9jjk9ZEnksd+0cew2jHMzO
        omoQiROzwzTLF9lpFXV1K6OGM8qB3U5BN4i2ndTscIr5ATXpb4ZK3cK0oFZs+eh/KESx+J
        Le/+rhkhh5EbMxWAVS45j7aAJ4vl/CDvxzLlBi6FpXdnNa7J9pojdjVjhrukpu0G21zKx3
        AithaSGpHvriir/YVHTnrGR4PuURPQrb08QoYGGVTeUyMip7oO03TlImdsv34g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700569997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Fh9e3GaErBHGJCOCbK/EGCyKE1R80+6heNDm0N0TMWA=;
        b=x+PC4P4BkaQPUae8UReQEYwUBsiT86OWBEWK14JS9Wj7In+IcXfjZsDaduUOuer4mu7mdd
        SuLm2Cxb4bdaQnCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [REPOST PATCH] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <20231121123315.egrgopGN@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is claimed that srcu_read_lock_nmisafe() NMI-safe. However it
triggers a lockdep if used from NMI because lockdep expects a deadlock
since nothing disables NMIs while the lock is acquired.

Use a try-lock annotation for srcu_read_lock_nmisafe() to avoid lockdep
complains if used from NMI.

Fixes: f0f44752f5f61 ("rcu: Annotate SRCU's update-side lockdep dependencies")
Link: https://lore.kernel.org/r/20230927160231.XRCDDSK4@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This is a repost of
	https://lore.kernel.org/r/20230927160231.XRCDDSK4@linutronix.de

Based on the discussion there I *think* this is preferred over the NMI
check in lock_acquire().
But then PeterZ also pointed out that he has a problem with
	f0f44752f5f61 ("rcu: Annotate SRCU's update-side lockdep dependencies")

because trace_.*_rcuidle machinery. This looks okay because the _rcuidle
part is using SRCU and the rcu_dereference_raw() tracepoint_func is
using RCU + SRCU in its free part.

 include/linux/rcupdate.h |    6 ++++++
 include/linux/srcu.h     |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -301,6 +301,11 @@ static inline void rcu_lock_acquire(stru
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
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe
 
 	srcu_check_nmi_safety(ssp, true);
 	retval = __srcu_read_lock_nmisafe(ssp);
-	rcu_lock_acquire(&ssp->dep_map);
+	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
 }
 
