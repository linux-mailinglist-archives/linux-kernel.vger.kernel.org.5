Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCB76FD04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHDJPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHDJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:14:18 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB684ED2;
        Fri,  4 Aug 2023 02:11:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHKj06YHJz4f3n5j;
        Fri,  4 Aug 2023 17:11:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHLwMxk2KskPg--.58335S9;
        Fri, 04 Aug 2023 17:11:49 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v6 5/5] rcu: Dump memory object info if callback function is invalid
Date:   Fri,  4 Aug 2023 17:11:35 +0800
Message-Id: <20230804091136.1177-6-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
References: <20230804091136.1177-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHLwMxk2KskPg--.58335S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtF47WrW7Kw1fury3tFWrZrb_yoW7GrW3pr
        ykuFy7Kw4kXFyrtay7Zw18WrWUA39Ygay3Ka95Crn3Cw4Ykr10gFyqyF12qrWYqF1rK34a
        qF1YqF43tr40ywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rV
        AKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU192
        -UUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

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
---
 kernel/rcu/rcu.h      | 7 +++++++
 kernel/rcu/srcutiny.c | 1 +
 kernel/rcu/srcutree.c | 1 +
 kernel/rcu/tasks.h    | 1 +
 kernel/rcu/tiny.c     | 1 +
 kernel/rcu/tree.c     | 1 +
 6 files changed, 12 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index d1dcb09750efbd6..bc81582238b9846 100644
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
index 336af24e0fe358a..c38e5933a5d6937 100644
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
index f1a905200fc2f79..833a8f848a90ae6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1710,6 +1710,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
 		debug_rcu_head_unqueue(rhp);
+		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7294be62727b12c..148ac6a464bfb12 100644
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
index 42f7589e51e09e7..fec804b7908032d 100644
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
index 7c79480bfaa04e4..927c5ba0ae42269 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2135,6 +2135,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		trace_rcu_invoke_callback(rcu_state.name, rhp);
 
 		f = rhp->func;
+		debug_rcu_head_callback(rhp);
 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
 		f(rhp);
 
-- 
2.34.1

