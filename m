Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684957C8528
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjJMMAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjJML7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA4D69;
        Fri, 13 Oct 2023 04:59:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A494C433CD;
        Fri, 13 Oct 2023 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198374;
        bh=a8yesXiumFDXUGe/vS4l+QF/cFiA8A3MQEGVRdpXwvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHDeb4vUdx7qWgGSZJE/nx0gtzccqoxRyGcZ9d0EglgM47SVCYp1pZP3LbfqA9ZqT
         JuDwr0cbFlkB+biF4i+Au6x1OkqDbBEYxtotxb4Z1+QWvXY0J8U88Vz6V2jZYXUkMc
         8JL9hcjp3zA0htcNejdqlDgMOWyJWpfC89WT+51bw0Aui8PX3wunu6vdEe1YJUBIn3
         eH8SVGfWe5F5FHfBSq7tpcaEuinewZEz032nQXs21HPvw4H3LROENMK8+e9bkcmQRr
         lfNCCcYJUHPSVm7a3l/xfusbwnKDT5JDXp+rHFscj3QKVd+K5EqtM9NpMfFjrBNCU5
         RWIQ8NYcPmGcw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Denis Arefev <arefev@swemel.ru>, Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 09/18] srcu: Fix srcu_struct node grpmask overflow on 64-bit systems
Date:   Fri, 13 Oct 2023 13:58:53 +0200
Message-Id: <20231013115902.1059735-10-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
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

From: Denis Arefev <arefev@swemel.ru>

The value of a bitwise expression 1 << (cpu - sdp->mynode->grplo)
is subject to overflow due to a failure to cast operands to a larger
data type before performing the bitwise operation.

The maximum result of this subtraction is defined by the RCU_FANOUT_LEAF
Kconfig option, which on 64-bit systems defaults to 16 (resulting in a
maximum shift of 15), but which can be set up as high as 64 (resulting
in a maximum shift of 63).  A value of 31 can result in sign extension,
resulting in 0xffffffff80000000 instead of the desired 0x80000000.
A value of 32 or greater triggers undefined behavior per the C standard.

This bug has not been known to cause issues because almost all kernels
take the default CONFIG_RCU_FANOUT_LEAF=16.  Furthermore, as long as a
given compiler gives a deterministic non-zero result for 1<<N for N>=32,
the code correctly invokes all SRCU callbacks, albeit wasting CPU time
along the way.

This commit therefore substitutes the correct 1UL for the buggy 1.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: David Laight <David.Laight@aculab.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 833a8f848a90..5602042856b1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 				snp->grplo = cpu;
 			snp->grphi = cpu;
 		}
-		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
+		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
 	}
 	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
 	return true;
@@ -835,7 +835,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 	int cpu;
 
 	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1 << (cpu - snp->grplo))))
+		if (!(mask & (1UL << (cpu - snp->grplo))))
 			continue;
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 	}
-- 
2.34.1

