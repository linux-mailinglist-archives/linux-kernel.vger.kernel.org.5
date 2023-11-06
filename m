Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAC7E30D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjKFXOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjKFXOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:14:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D183;
        Mon,  6 Nov 2023 15:14:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0327DC433C8;
        Mon,  6 Nov 2023 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312482;
        bh=KBys1jNrKX8/EucXe/ANwjitylh0JOMnhGByTfQ2CUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjaM5R/0Qr3dJj1NSZuLbp0gBrXfVaPL9oAl6boBS9B4crKdiRpj5Zu5kkI1NEVYQ
         WvgDu/MuM67zXvvxtW30FnsHuifEB4KRHLkeqWra9l5wKNKZVQCfUK8twLcUuMRRs1
         Ga0sprUj5nZ7O8YRO4WIj3FQbck8QwMG7U3ezjXMlmdVtaphXaz+sN6a1yGyZiK8ZG
         8//17nfuP29UJ6ZJy59y0tKAeZEnqFPyDneX2JBLI9wp2kWRh2cwm8x/qqIXTUEnc8
         89rV+uqqO3aIeRaExMMn4azKBkOG2NEEd6yRULCwVqaW60vJltaFBVTNaCgpuQTfv/
         QaVJ+BfN5o/Bw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Arefev <arefev@swemel.ru>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        David Laight <David.Laight@aculab.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sasha Levin <sashal@kernel.org>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/13] srcu: Fix srcu_struct node grpmask overflow on 64-bit systems
Date:   Mon,  6 Nov 2023 18:14:16 -0500
Message-ID: <20231106231435.3734790-3-sashal@kernel.org>
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

From: Denis Arefev <arefev@swemel.ru>

[ Upstream commit d8d5b7bf6f2105883bbd91bbd4d5b67e4e3dff71 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b3e9bc3b60f0b..a1fcb8566b2e3 100644
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
@@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 	int cpu;
 
 	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1 << (cpu - snp->grplo))))
+		if (!(mask & (1UL << (cpu - snp->grplo))))
 			continue;
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 	}
-- 
2.42.0

