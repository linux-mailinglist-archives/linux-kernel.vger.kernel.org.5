Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007387AAEFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjIVJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIVJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:59:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E638F;
        Fri, 22 Sep 2023 02:59:28 -0700 (PDT)
Date:   Fri, 22 Sep 2023 09:59:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695376767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xSQafXNxgQJP26IJtLUKRX4XIhQKDG5RuHCBFnIp8g=;
        b=jaNcmnthuYPSol5qKOD/vsvFaFB1k3oFRmtHE8VJUKjhnHuqdTDY0GxIu9aDeeYjG9C4oI
        DYdc8Cz4jHdvftno+lFAkRZyLEM/I/VbgN3nCguEAdPqmxOXvP94mxyIl/DBz8Na73/xpn
        si0r+Y0F16bbB4gqJUlXKtM6SZ5GQHUGfCBzKRVQ16GLzOCw7dV80mdJiB79Xp95HfrUS/
        gNX4PibS/e6yjXN0SKe7v4zmSoEyPOIRmBhAOoQ5UEhM5Sj1UadYnnSURbplEZ/ZftASaE
        eNfhmsrMzo7F+J9FbUXfkRvpJVHenOjZVBg5NuA0Pl/cTtkgmnFwV76Q0X36Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695376767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xSQafXNxgQJP26IJtLUKRX4XIhQKDG5RuHCBFnIp8g=;
        b=bZ2Ho3YNt4nes4giczcw+3ZiOUbBjic66y6k6H2H38rplboWIBR2Z8Kj9iSR/R5i8i5Ngw
        uikxrHL9j+MWRKCA==
From:   "tip-bot2 for Liming Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Avoid checking in_atomic_preempt_off()
 twice in schedule_debug()
Cc:     Liming Wu <liming.wu@jaguarmicro.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230825023501.1848-1-liming.wu@jaguarmicro.com>
References: <20230825023501.1848-1-liming.wu@jaguarmicro.com>
MIME-Version: 1.0
Message-ID: <169537676655.27769.432100540285605722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dc461c48deda8a2d243fbaf49e276d555eb833d8
Gitweb:        https://git.kernel.org/tip/dc461c48deda8a2d243fbaf49e276d555eb833d8
Author:        Liming Wu <liming.wu@jaguarmicro.com>
AuthorDate:    Fri, 25 Aug 2023 10:35:00 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 11:50:49 +02:00

sched/debug: Avoid checking in_atomic_preempt_off() twice in schedule_debug()

in_atomic_preempt_off() already gets called in schedule_debug() once,
which is the only caller of __schedule_bug().

Skip the second call within __schedule_bug(), it should always be true
at this point.

[ mingo: Clarified the changelog. ]

Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230825023501.1848-1-liming.wu@jaguarmicro.com
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 52ceb85..1074934 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5899,8 +5899,7 @@ static noinline void __schedule_bug(struct task_struct *prev)
 	print_modules();
 	if (irqs_disabled())
 		print_irqtrace_events(prev);
-	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)
-	    && in_atomic_preempt_off()) {
+	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
 		pr_err("Preemption disabled at:");
 		print_ip_sym(KERN_ERR, preempt_disable_ip);
 	}
