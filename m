Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19476B5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjHANYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjHANYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1841985
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE895615A4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDFBC433C7;
        Tue,  1 Aug 2023 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896290;
        bh=OCbZZEYY6XG+Gj++glqCcqULb++oCr0LofyrtVtyhEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUheRgQ6e3jTLVKzFRNeivu8xi+wx3bSs7luMToq7MPUyeMEOdFV9Z10Xwj52jGBl
         TsBzJKvb9b+/lHy5AF7lkLk+ev1RoQAc/mtDMsEnAswNdWKiH79GfrtjsA5DmDxD8M
         GFiG1ohj3mNsLa4alssdvt9LGyjknXtmPAD/p8AhgFnq34OEh2S6c0lToN5VK9gU5j
         kA/v7zsvQ5CTF3dGiW/7YcQBuJqvH75sOtwB2Kultu/XQULLc5jC2TOqCrm5klZUOs
         /brfyl+A+H/TH738p7IqIOp+65VenPfrbLtrAiSiK77m2Oh3wDfMsnvm2MzM8Luh4+
         u7PdXIokymRMw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 1/6] softirq: Turn set_softirq_pending() to reset_softirq_pending()
Date:   Tue,  1 Aug 2023 15:24:36 +0200
Message-Id: <20230801132441.559222-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801132441.559222-1-frederic@kernel.org>
References: <20230801132441.559222-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_softirq_pending() is only ever used to reset the pending vector's
mask to 0. Make the function more specialized for that very purpose and
rename it accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/interrupt.h | 2 +-
 kernel/softirq.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index bf82980f569d..2099fe3980bc 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -524,7 +524,7 @@ DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
 #endif
 
 #define local_softirq_pending()	(__this_cpu_read(local_softirq_pending_ref))
-#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
+#define reset_softirq_pending()	(__this_cpu_write(local_softirq_pending_ref, 0))
 #define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
 
 #endif /* local_softirq_pending */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 623985f18833..1a3c3fe341ea 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -532,7 +532,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	set_softirq_pending(0);
+	reset_softirq_pending();
 
 	local_irq_enable();
 
-- 
2.34.1

