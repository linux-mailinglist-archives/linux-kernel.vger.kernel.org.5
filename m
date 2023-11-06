Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BE97E30D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjKFXOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjKFXOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:14:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800783;
        Mon,  6 Nov 2023 15:14:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30755C433CC;
        Mon,  6 Nov 2023 23:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312480;
        bh=JglGB9z9iLYLAaTutZzSw+YfrzMPygk3spBNuCQxQQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtUdmBv+qvlXAn5sc/ZkIvE1VAcB+OuOs7aF1NQkQAyUY1x91TtiXsDp6xKbDukNi
         tyqswRrQJS0yZjxFk+KkkoqGW7g1ce5hd9ZAdEL5z/AkdWzxGKGuu7oh6ZyMu9Km+3
         piJwkv0DikED+TUeFtTYOhfKnYohtV4JJAXsub29lDERgQlRPVLPJG+lXmbMOv6mI7
         CSGy4wYbvIU6OUmUdEaJLUJv3AnWxpZ/sX12DL4BW3ieVKpcYssA8TZnOfu7glqRen
         lyDAs24n/37vM4Z/qdF/5UoAOHhp2Cj66+gcMkZtKa4wqfplveVxAo0HA5r9qUi4r/
         HGbHaB4sb+SQA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sasha Levin <sashal@kernel.org>, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, jiangshanlai@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/13] rcu: Dump memory object info if callback function is invalid
Date:   Mon,  6 Nov 2023 18:14:15 -0500
Message-ID: <20231106231435.3734790-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231435.3734790-1-sashal@kernel.org>
References: <20231106231435.3734790-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 2cbc482d325ee58001472c4359b311958c4efdd1 ]

When a structure containing an RCU callback rhp is (incorrectly) freed
and reallocated after rhp is passed to call_rcu(), it is not unusual for
rhp->func to be set to NULL. This defeats the debugging prints used by
__call_rcu_common() in kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
which expect to identify the offending code using the identity of this
function.

And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things
are even worse, as can be seen from this splat:

Unable to handle kernel NULL pointer dereference at virtual address 0
... ...
PC is at 0x0
LR is at rcu_do_batch+0x1c0/0x3b8
... ...
 (rcu_do_batch) from (rcu_core+0x1d4/0x284)
 (rcu_core) from (__do_softirq+0x24c/0x344)
 (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
 (__irq_exit_rcu) from (irq_exit+0x8/0x10)
 (irq_exit) from (__handle_domain_irq+0x74/0x9c)
 (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
 (gic_handle_irq) from (__irq_svc+0x5c/0x94)
 (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
 (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
 (default_idle_call) from (do_idle+0xf8/0x150)
 (do_idle) from (cpu_startup_entry+0x18/0x20)
 (cpu_startup_entry) from (0xc01530)

This commit therefore adds calls to mem_dump_obj(rhp) to output some
information, for example:

  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256

This provides the rough size of the memory block and the offset of the
rcu_head structure, which as least provides at least a few clues to help
locate the problem. If the problem is reproducible, additional slab
debugging can be enabled, for example, CONFIG_DEBUG_SLAB=y, which can
provide significantly more information.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcu.h      | 7 +++++++
 kernel/rcu/srcutiny.c | 1 +
 kernel/rcu/srcutree.c | 1 +
 kernel/rcu/tasks.h    | 1 +
 kernel/rcu/tiny.c     | 1 +
 kernel/rcu/tree.c     | 1 +
 6 files changed, 12 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 98e13be411afd..d612731feea48 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_RCU_H
 #define __LINUX_RCU_H
 
+#include <linux/slab.h>
 #include <trace/events/rcu.h>
 
 /*
@@ -248,6 +249,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 }
 #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
+static inline void debug_rcu_head_callback(struct rcu_head *rhp)
+{
+	if (unlikely(!rhp->func))
+		kmem_dump_obj(rhp);
+}
+
 extern int rcu_cpu_stall_suppress_at_boot;
 
 static inline bool rcu_stall_is_suppressed_at_boot(void)
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 336af24e0fe35..c38e5933a5d69 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	while (lh) {
 		rhp = lh;
 		lh = lh->next;
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675a..b3e9bc3b60f0b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1708,6 +1708,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
 		debug_rcu_head_unqueue(rhp);
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8d65f7d576a34..7c845532a50ac 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -538,6 +538,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 42f7589e51e09..fec804b790803 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 
 	trace_rcu_invoke_callback("", head);
 	f = head->func;
+	debug_rcu_head_callback(head);
 	WRITE_ONCE(head->func, (rcu_callback_t)0L);
 	f(head);
 	rcu_lock_release(&rcu_callback_map);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd07..29e4acbafefda 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2135,6 +2135,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		trace_rcu_invoke_callback(rcu_state.name, rhp);
 
 		f = rhp->func;
+		debug_rcu_head_callback(rhp);
 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
 		f(rhp);
 
-- 
2.42.0

