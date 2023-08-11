Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F692779585
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjHKRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjHKRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C337B35A9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C316645D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1BAC433C7;
        Fri, 11 Aug 2023 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773268;
        bh=1NQPETUBxztpoNgtonFeGuuxCy+oiM7V1jas7MgPpLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NhgGjX14Vfxa5mHU4CwZ2RvYwEyiALn1takLmpPnUFScmOqNOLb0xTxOhL1wecuIS
         dMQBaSRZK7lU0sYnl1m4AKEEZJsC+GDq86xovFbDEUqs2OoqKC5F0/tNP7MOzZQD8Z
         GTn92asL7geG3HT25qM9kIileTY0/BNd0CIotA8zwuKZ8G/VX6V3qXCWkZAi5H16ni
         scdvr1dq69gt2tSYU5VnJS/bPiV2FeaeH5yNcVqNZCWd9lWLK7JFpI6pdOYRNs6fG3
         XUwWGuwqqyEnTInszoWbFfRtaWNeqjUM3iM0GnYPZQIcOfLhmJP9IrMCwx2LjTQbif
         od+SqAWYBmbaA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 06/10] cpuidle: Remove unnecessary current_clr_polling_and_test() from haltpoll
Date:   Fri, 11 Aug 2023 19:00:45 +0200
Message-Id: <20230811170049.308866-7-frederic@kernel.org>
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

When cpuidle drivers ->enter() callback are called, the TIF_NR_POLLING
flag is cleared already and TIF_NEED_RESCHED checked by call_cpuidle().

Therefore calling current_clr_polling_and_test() is redundant here and
further setting of TIF_NEED_RESCHED will result in an IPI and thus an
idle loop exit. This call can be safely removed.

Cc: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index e66df22f9695..b641bc535102 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -28,11 +28,8 @@ static enum cpuhp_state haltpoll_hp_state;
 static int default_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index)
 {
-	if (current_clr_polling_and_test()) {
-		local_irq_enable();
-		return index;
-	}
 	arch_cpu_idle();
+
 	return index;
 }
 
-- 
2.34.1

