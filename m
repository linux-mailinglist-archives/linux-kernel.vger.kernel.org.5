Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD075C0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGUIE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGUIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:04:23 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760512707;
        Fri, 21 Jul 2023 01:04:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6hsZ65jTz4f403c;
        Fri, 21 Jul 2023 16:04:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgA34qX_O7pk9KzbOQ--.39718S6;
        Fri, 21 Jul 2023 16:04:19 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] rcu: Simplify check_cpu_stall()
Date:   Fri, 21 Jul 2023 15:57:16 +0800
Message-Id: <20230721075716.857-3-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230721075716.857-1-thunder.leizhen@huaweicloud.com>
References: <20230721075716.857-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA34qX_O7pk9KzbOQ--.39718S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xuF4xWFy8Cry3WFykXwb_yoW5Gr4Upa
        9xJa42gan8JFs29392q34kJr15Ar4kXFy7Jasrtw1Fya9rAF1Fgas09ryfGFy5ur93Xr4S
        vFyFqr1UCa1DtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F2
        4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
        JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
        AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
        IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7g4SUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The code and comments of self detected and other detected are the same
except the output function. Combine the same parts to avoid duplication.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree_stall.h | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 371713f3f7d15d9..0ade7f9dcaa18da 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -711,7 +711,7 @@ static void print_cpu_stall(unsigned long gps)
 
 static void check_cpu_stall(struct rcu_data *rdp)
 {
-	bool didstall = false;
+	bool self_detected;
 	unsigned long gs1;
 	unsigned long gs2;
 	unsigned long gps;
@@ -758,10 +758,10 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
 	jn = jiffies + ULONG_MAX / 2;
+	self_detected = READ_ONCE(rnp->qsmask) & rdp->grpmask;
 	if (rcu_gp_in_progress() &&
-	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
+	    (self_detected || ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY)) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
-
 		/*
 		 * If a virtual machine is stopped by the host it can look to
 		 * the watchdog like an RCU stall. Check to see if the host
@@ -770,31 +770,17 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		if (kvm_check_and_clear_guest_paused())
 			return;
 
-		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall(gps);
-		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
-			rcu_ftrace_dump(DUMP_ALL);
-		didstall = true;
-
-	} else if (rcu_gp_in_progress() &&
-		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
-		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
-
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
+		if (self_detected) {
+			/* We haven't checked in, so go dump stack. */
+			print_cpu_stall(gps);
+		} else {
+			/* They had a few time units to dump stack, so complain. */
+			print_other_cpu_stall(gs2, gps);
+		}
 
-		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
-		didstall = true;
-	}
-	if (didstall) {
+
 		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
 		WRITE_ONCE(rcu_state.jiffies_stall, jn);
 	}
-- 
2.25.1

