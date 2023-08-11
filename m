Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF7779580
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjHKRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjHKRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DB30E7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E25D67684
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D28C433C8;
        Fri, 11 Aug 2023 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773261;
        bh=YaoIKYC/HMtW27OOcRlg0CgBQJS8nCnjs/a8mtWVN9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMAuv/uUk1D/ks5Q4Tofx42uo+5BObOOtWMdaGvK9vFT2YixjWvjrwrhxmNgits1L
         9O8X6v6ubtlin/ESJ/BraO1nBxVuVsD5GIDnmrr+ywXDcsVpxMsTcEjIt7XK/dICL9
         /aNDYUXTHwGSLFkS3TEVydJPQWPG8aVYtIjZzR0TIaqcGYjfHCmcr3QIukV9ex873X
         rfZUX0OBrxoHoGN/gEOO6i9z/5JMiLh3sHiQlyte7T7u2xlvf/WhrLbB46Tx32q/MC
         kTN+EESC255qjJDAseDUBchyqbkz3+tdE2pALmTWWLxow57Ebe42t2PCdyGilblR05
         dNZHqH95bTnNw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 03/10] cpuidle: Report illegal tick stopped while polling
Date:   Fri, 11 Aug 2023 19:00:42 +0200
Message-Id: <20230811170049.308866-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811170049.308866-1-frederic@kernel.org>
References: <20230811170049.308866-1-frederic@kernel.org>
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

poll_idle() can't be called while the tick is stopped because it enables
interrupts and only polls on TIF_NEED_RESCHED, which doesn't tell if an
interrupt queues a timer that would require a tick re-programming.

There is no point anyway to poll with the tick stopped so add a check
to make sure it never happens.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/poll_state.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..009f46f121ae 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
+#include <linux/tick.h>
 
 #define POLL_IDLE_RELAX_COUNT	200
 
@@ -19,6 +20,13 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 
 	dev->poll_time_limit = false;
 
+	/*
+	 * This re-enables IRQs and only polls on TIF_NEED_RESCHED.
+	 * A timer queued by an interrupt here may go unnoticed if
+	 * the tick is stopped.
+	 */
+	WARN_ON_ONCE(tick_nohz_tick_stopped());
+
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count = 0;
-- 
2.34.1

