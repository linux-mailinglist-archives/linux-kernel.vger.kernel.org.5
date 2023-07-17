Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F38756BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjGQSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjGQSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CE1702;
        Mon, 17 Jul 2023 11:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E63611E8;
        Mon, 17 Jul 2023 18:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16307C433C9;
        Mon, 17 Jul 2023 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617903;
        bh=l6fjQzSsJ9XsALv/Md6uxcktla62nAu93vPkfT4e3qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etxS+i0iNTnyaCWJcK4R0j8eUpxNo6zB/FtCsE4dKbjDj/mpdlZ1gGxaHB4kO1DzK
         ISDzkRTISi+vvI/rBORGbI4XDaSCALn7WAO2tnE3F0LKt9sMpY0K+z6XsaLN31OYPB
         502fTz8IddsJ0aliVyXmdi38ZaINNT5Ku37hSl/IsRmfud0EG8b5DZhMgDdGPvMiro
         KXlNEiqEHyOguUBRUJ/NpYncmwwY5nom9e28PpHTBSEGkyz8wDDzz3l0or7/m/L0BN
         b6h3M8jNUjvYDUKhF8hNUQ9QX50rx70/Rg7zJULOWxLsqVStAN1tuLsx90wQ0yiJt3
         3Uiv3taX/p/Kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE001CE0806; Mon, 17 Jul 2023 11:18:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] scftorture: Pause testing after memory-allocation failure
Date:   Mon, 17 Jul 2023 11:18:19 -0700
Message-Id: <20230717181820.1098541-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <38be0135-a7a4-4c16-b2c6-1b3817c3067f@paulmck-laptop>
References: <38be0135-a7a4-4c16-b2c6-1b3817c3067f@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scftorture test can quickly execute a large number of calls to no-wait
smp_call_function(), each of which holds a block of memory until the
corresponding handler is invoked.  Especially when the longwait module
parameter is specified, this can chew up an arbitrarily large amount
of memory.  This commit therefore blocks after each memory-allocation
failure, with the duration a function of longwait.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 83c33ba0ca7e..59032aaccd18 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -313,6 +313,7 @@ static void scf_handler_1(void *scfc_in)
 // Randomly do an smp_call_function*() invocation.
 static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_random_state *trsp)
 {
+	bool allocfail = false;
 	uintptr_t cpu;
 	int ret = 0;
 	struct scf_check *scfcp = NULL;
@@ -327,6 +328,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		if (!scfcp) {
 			WARN_ON_ONCE(!IS_ENABLED(CONFIG_KASAN));
 			atomic_inc(&n_alloc_errs);
+			allocfail = true;
 		} else {
 			scfcp->scfc_cpu = -1;
 			scfcp->scfc_wait = scfsp->scfs_wait;
@@ -433,7 +435,9 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		cpus_read_unlock();
 	else
 		preempt_enable();
-	if (!(torture_random(trsp) & 0xfff))
+	if (allocfail)
+		schedule_timeout_idle((1 + longwait) * HZ);  // Let no-wait handlers complete.
+	else if (!(torture_random(trsp) & 0xfff))
 		schedule_timeout_uninterruptible(1);
 }
 
-- 
2.40.1

