Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F37B0989
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjI0QD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjI0QDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:03:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B7C121;
        Wed, 27 Sep 2023 09:02:35 -0700 (PDT)
Date:   Wed, 27 Sep 2023 18:02:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695830553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EdCiO/WzKECbYs7KtcCYhKCOSLS8gRQvCAW/vFRb9F4=;
        b=gA8E7/z/ye+UWQvTptCUxfM7HS3iYd/tK9vXkmkbp6ehYQxjZfhSnwUbo4yeTQVXJ9IyaK
        8wwAtn2uo82b34MM6QBT6xBYWLHHZHhUQxGiLRWHByNXFKXmbA2NGgWBwPixIIC7qn67Q0
        rXHrEqx5L933ymrrywoXolbIUbAnG0yGsz7c0XyJmjfTWkMe8gKDoTyWp+Q9+TsYh6mrfE
        ZNxJCnQvTyxZ13dpeZ7/wj6oYmTKRHzkxrouy8xoZEUrQ6rMcvQcIQGGMWXBr8+Rz1ibrB
        q0E2C/9dyj2TETBAiMJrYc13NWVAl8mzXrUff1NU3ponoQLgs3BldvxYTFfGrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695830553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EdCiO/WzKECbYs7KtcCYhKCOSLS8gRQvCAW/vFRb9F4=;
        b=YReDyt9JG3c9HFVm3jjR59KBPrudAz6g1lOu804uGt8ruhv64qozjuWhLyNqZHyepfHAYV
        cCC1Rw8pXSmPDmAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [RFC PATCH] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <20230927160231.XRCDDSK4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The splat:
| =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| WARNING: inconsistent lock state
| 6.6.0-rc3-rt5+ #85 Not tainted
| --------------------------------
| inconsistent {INITIAL USE} -> {IN-NMI} usage.
| swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
| ffffffff828e6c90 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0=
x3a/0x50
| {INITIAL USE} state was registered at:
=E2=80=A6
|        CPU0
|        ----
|   lock(console_srcu);
|   <Interrupt>
|     lock(console_srcu);
|
|  *** DEADLOCK ***
|

My guess is that trylock annotation should not apply to
rcu_lock_acquire(). This would distinguish it from from non-NMI safe
srcu_read_lock_nmisafe() and NMI check in rcu_read_unlock() is only
there to survive if accidentally used in-NMI.

 include/linux/rcupdate.h | 6 ++++++
 include/linux/srcu.h     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade909..44aab5c0bd2c1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -303,6 +303,11 @@ static inline void rcu_lock_acquire(struct lockdep_map=
 *map)
 	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
 }
=20
+static inline void rcu_try_lock_acquire(struct lockdep_map *map)
+{
+	lock_acquire(map, 0, 1, 2, 0, NULL, _THIS_IP_);
+}
+
 static inline void rcu_lock_release(struct lockdep_map *map)
 {
 	lock_release(map, _THIS_IP_);
@@ -317,6 +322,7 @@ int rcu_read_lock_any_held(void);
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
=20
 # define rcu_lock_acquire(a)		do { } while (0)
+# define rcu_try_lock_acquire(a)	do { } while (0)
 # define rcu_lock_release(a)		do { } while (0)
=20
 static inline int rcu_read_lock_held(void)
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 127ef3b2e6073..236610e4a8fa5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -229,7 +229,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_st=
ruct *ssp) __acquires(ssp
=20
 	srcu_check_nmi_safety(ssp, true);
 	retval =3D __srcu_read_lock_nmisafe(ssp);
-	rcu_lock_acquire(&ssp->dep_map);
+	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
 }
=20
--=20
2.40.1

