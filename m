Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0251A7EA5B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjKMWDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKMWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:03:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D7D50;
        Mon, 13 Nov 2023 14:03:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA5FC433C8;
        Mon, 13 Nov 2023 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699913012;
        bh=sUhE/qFaIDHh5RCqYIo7aaxz5Ifr+Yh3RMfcwpeT7hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6BJYJRy7C9DwtlCkUkAc2wzutdurdfjjUgqKtEfzDDhKHmQgct2AdQdDH39XP/59
         RfRvln9eJ05WKfKE1axkGZgUXurqVVeWyfc7wWLQyMdFQVJL7EyWdtkQ9y3UMpehUk
         84GbL37ihxEuB0jgGeLqE60Ui1uLj/qNRlrApyWl0f4nwknRDsGG66EoZGg5x+kp+O
         LTcpL2jUmCyJk+STYGuvHJpK2LCu8BTytk4VEtxGlFQ5wLvrJ3d7ChpJtGwq6dx8uc
         qOa22h9C/gpkguVsAU8VKnYwmI2Z0JDA0rlOyvzeAipjSsy9T1USfU08JYz62X20vZ
         i9fJT0OF7zJjw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 1/2] cpuidle: Remove unnecessary current_clr_polling_and_test() from haltpoll
Date:   Mon, 13 Nov 2023 17:03:25 -0500
Message-ID: <20231113220326.7933-2-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113220326.7933-1-frederic@kernel.org>
References: <20231113220326.7933-1-frederic@kernel.org>
MIME-Version: 1.0
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

When cpuidle drivers ->enter() callback are called, the TIF_NR_POLLING
flag is cleared already and TIF_NEED_RESCHED checked by call_cpuidle().

Therefore calling current_clr_polling_and_test() is redundant here and
further setting of TIF_NEED_RESCHED will result in an IPI and thus an
idle loop exit. This call can be safely removed.

Cc: Marcelo Tosatti <mtosatti@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
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
2.42.1

