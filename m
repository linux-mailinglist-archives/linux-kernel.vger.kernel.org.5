Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5840175E9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGXC25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjGXC2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:28:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA7102;
        Sun, 23 Jul 2023 19:28:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R8PH02d5Xz4f3p16;
        Mon, 24 Jul 2023 10:28:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7LY4b1k4_awOg--.28306S5;
        Mon, 24 Jul 2023 10:28:45 +0800 (CST)
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
Subject: [PATCH v2 1/1] rcu: Simplify check_cpu_stall()
Date:   Mon, 24 Jul 2023 10:26:51 +0800
Message-Id: <20230724022651.899-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230724022651.899-1-thunder.leizhen@huaweicloud.com>
References: <20230724022651.899-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7LY4b1k4_awOg--.28306S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xuF4xWFy3Gw43uFW8tFb_yoW5Xw48pa
        9rJ342gan8JF4Ik39rt34kJr15Xws5XFy7JasrJr1Fya9rAr1Fgas0qryfGFy5ur93Xr4S
        vF95tr17Ca1DtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8qFAJUUUUU=
        =
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 kernel/rcu/tree_stall.h | 42 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index cc884cd49e026a3..b45d7e49944cdd7 100644
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
@@ -770,33 +770,21 @@ static void check_cpu_stall(struct rcu_data *rdp)
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
-	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {
-		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
-		WRITE_ONCE(rcu_state.jiffies_stall, jn);
+
+		if (READ_ONCE(rcu_state.jiffies_stall) == jn) {
+			jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+			WRITE_ONCE(rcu_state.jiffies_stall, jn);
+		}
 	}
 }
 
-- 
2.25.1

