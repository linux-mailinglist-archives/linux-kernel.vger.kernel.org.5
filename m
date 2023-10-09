Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1867BD4B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbjJIHxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345455AbjJIHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:53:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801499F;
        Mon,  9 Oct 2023 00:53:25 -0700 (PDT)
Date:   Mon, 09 Oct 2023 07:53:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696838003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMda0ObVnvrbIc5KMb8eOr0wT0ue9Dz7UquWAeJsp9c=;
        b=gSOoSyWb5M/i3uKkTrEsQH2Y2+nR0Yl98XZtZ7Bq0Rl2dBB9rXfqeUXZW+I/tieBRnrMYp
        EuWufHAXQI09aThGWefhoclmPMdFjr6GIAq7wStlATQJ2SUFKHBh1PfvbGf4SSdiVF2fp+
        3JGBCBgfpIZEObay4n/JLrGAK26vO1vOpksvt5iZN9rFWryXybyyLKxSs1WoJ/k+6S2+GO
        9QS2RI9R00hT4n8zok2pLSp2xiCuuRcPNLn0cc4guz+eHyXcfQdvxe54NoyOL6ExC+PrOx
        ohl0KxhEF23Qn3yirdBkfvn/QZpbfO+J2rq+YMfthHeCWOdbugtu0vAeP2cgLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696838003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMda0ObVnvrbIc5KMb8eOr0wT0ue9Dz7UquWAeJsp9c=;
        b=DamDX0mH82cevb5U4cwDk9yNOmEkEgk/ic+nuJvFaQuK85JHcY6AE6Nvii+ZWvPkVv/Wsp
        ACZanCE/3QTzjKAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Fix min_deadline heap integrity
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Mike Galbraith <efault@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231006192445.GE743@noisy.programming.kicks-ass.net>
References: <20231006192445.GE743@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169683800306.3135.4450756007825411493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     8dafa9d0eb1a1550a0f4d462db9354161bc51e0c
Gitweb:        https://git.kernel.org/tip/8dafa9d0eb1a1550a0f4d462db9354161bc51e0c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 Oct 2023 21:24:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Oct 2023 09:48:32 +02:00

sched/eevdf: Fix min_deadline heap integrity

Marek and Biju reported instances of:

  "EEVDF scheduling fail, picking leftmost"

which Mike correlated with cgroup scheduling and the min_deadline heap
getting corrupted; some trace output confirms:

> And yeah, min_deadline is hosed somehow:
>
>    validate_cfs_rq: --- /
>    __print_se: ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -66302085 E (11372/tr)
>    __print_se:   ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -66302085 E (-1//autogroup-31)
>    __print_se:   ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N (-1//autogroup-33)
>    validate_cfs_rq: min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256

Turns out that reweight_entity(), which tries really hard to be fast,
does not do the normal dequeue+update+enqueue pattern but *does* scale
the deadline.

However, it then fails to propagate the updated deadline value up the
heap.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Mike Galbraith <efault@gmx.de>
Link: https://lkml.kernel.org/r/20231006192445.GE743@noisy.programming.kicks-ass.net
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef7490c..a4b904a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3613,6 +3613,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 */
 		deadline = div_s64(deadline * old_weight, weight);
 		se->deadline = se->vruntime + deadline;
+		min_deadline_cb_propagate(&se->run_node, NULL);
 	}
 
 #ifdef CONFIG_SMP
