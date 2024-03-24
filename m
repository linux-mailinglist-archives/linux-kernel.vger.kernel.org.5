Return-Path: <linux-kernel+bounces-112756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32187887DD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52882808FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0543ACE;
	Sun, 24 Mar 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldnNVkVJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF8433C5;
	Sun, 24 Mar 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299998; cv=none; b=Pa9HEmX/7CeUHXZ85vf7JoFxZ+J7lFUXBn/wcZiLkt03C+Gltf5xwbn0Bjmc8UjhUufquyWO0vD6t+S6JhOMNwmpnm9xc3FDKVCEPvWlY6h1lkAOIMLRkn9OLpmL2PpjNXFUQEfihMWUCHcCad4ngPzump7bp/T+X1A/ijNKXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299998; c=relaxed/simple;
	bh=M5KWR1kOnUHwDGq3v++7oLxZFhzioC3ac36tmPcpu1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzsUWszg+7kvWY2UccjMZkjuK0Lnq+nRjSGexqBp9j3wpEwYBZvaQ9dDCqkoUaMJIVsXyq8VN1W50oLxW7W/lIo0l2k4wlX9n5b+h5pagmLcoGmoH67NOQNTobXK7FE0ykHRcG5hO2Z4d2Q3MacXPxsFSn+IuYUWYln2SWXOFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldnNVkVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DF7C433C7;
	Sun, 24 Mar 2024 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299998;
	bh=M5KWR1kOnUHwDGq3v++7oLxZFhzioC3ac36tmPcpu1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldnNVkVJ/r/Fm/rKM/gwTB6mOK604cCvqvfOh9tvhMyx5DH9NvTPFfGDTeA1p5NM5
	 oWEb+z+lotQ+Z+BfZAvboxssnsJY1hDSwHMyRVJJR3SQurAnjf6ajolJILsQGdR2jv
	 40uNmoeQaBzJFO6c/4d36iBHwzHe4GnRo2YU3IhkZQyuRwbk3rl8LDyYxzx5U447dX
	 /ZG4X1aCXAC67W14MxFrxjibapjcPDCmyWGl+u7Z4JjvLkPgC8+Ta1xomLM3XDiihQ
	 lzPMufy61QjlYjgaEgHzrc17F2PsvN4Lh/IffMQzPpbcsOaMxe/jboIvCwUtAWTYrw
	 1wyyEso1oQTBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zqiang <qiang.zhang1211@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	quic_neeraju@quicinc.com,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 10/11] rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()
Date: Sun, 24 Mar 2024 13:06:13 -0400
Message-ID: <20240324170619.545975-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit dda98810b552fc6bf650f4270edeebdc2f28bd3f ]

For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and
CONFIG_RCU_LAZY=y, the following scenarios will trigger WARN_ON_ONCE()
in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended() functions:

        CPU2                                               CPU11
kthread
rcu_nocb_cb_kthread                                       ksys_write
rcu_do_batch                                              vfs_write
rcu_torture_timer_cb                                      proc_sys_write
__kmem_cache_free                                         proc_sys_call_handler
kmemleak_free                                             drop_caches_sysctl_handler
delete_object_full                                        drop_slab
__delete_object                                           shrink_slab
put_object                                                lazy_rcu_shrink_scan
call_rcu                                                  rcu_nocb_flush_bypass
__call_rcu_commn                                            rcu_nocb_bypass_lock
                                                            raw_spin_trylock(&rdp->nocb_bypass_lock) fail
                                                            atomic_inc(&rdp->nocb_lock_contended);
rcu_nocb_wait_contended                                     WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
 WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                                          |
                            |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu != 11_ _ _ _ _ _ _ _ _ __|

Reproduce this bug with "echo 3 > /proc/sys/vm/drop_caches".

This commit therefore uses rcu_nocb_try_flush_bypass() instead of
rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan().  If the nocb_bypass
queue is being flushed, then rcu_nocb_try_flush_bypass will return
directly.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4efbf7333d4e1..d430b4656f59e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1383,7 +1383,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue;
 		}
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.43.0


