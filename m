Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B157A78E468
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345612AbjHaBby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbjHaBbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC31CC5;
        Wed, 30 Aug 2023 18:31:35 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiT9d7rKpbITeafms0QkDi48UzdAxXr2bWvYOZoLk1Y=;
        b=dSNyPp8hgVpSG7QZwlcYtcgt5o4UTjYzTO0k/2HUVYtjoMLaGPLx1XVKvSPogMm46g35sm
        jDgcVGwEo0YJKS8WkWPWmvwP3qFBx5Sw5ZrFnG2TVXscoDimYpWUW/KWGxGVu/rom0d0m7
        bxxYn95faa8ZkszKy3pZxe9yi/ULm+FFuusA7/5cAtiVtBxNLjcuJghEuPCVW5cC5Dsjzz
        4Eb9Ktc2MM8PMq0nWnvG3M7/oVAecjhzShXcSveCpltvKs621cs7PFbdnYrw0eRU5y78eg
        C03T3TEqFw0gxTIop6fm7d9t2Toi7aGOdIxArEWRMp8zRFC+H0B9nwhO35ULCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiT9d7rKpbITeafms0QkDi48UzdAxXr2bWvYOZoLk1Y=;
        b=B7HGWOqsWmerTiEO14/qSXBpzkxBXjc7KWUXmxGTU8sY+E4F8UdoWwJ8KXGXfufKikdb8b
        aZd15MX0ke9H02CQ==
From:   "tip-bot2 for Walter Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Disable timer
 before programming CVAL
Cc:     stable@vger.kernel.org, Walter Chang <walter.chang@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230717090735.19370-1-walter.chang@mediatek.com>
References: <20230717090735.19370-1-walter.chang@mediatek.com>
MIME-Version: 1.0
Message-ID: <169344549125.27769.12141832888285612351.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e7d65e40ab5a5940785c5922f317602d0268caaf
Gitweb:        https://git.kernel.org/tip/e7d65e40ab5a5940785c5922f317602d0268caaf
Author:        Walter Chang <walter.chang@mediatek.com>
AuthorDate:    Mon, 17 Jul 2023 17:07:34 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 18 Aug 2023 12:06:16 +02:00

clocksource/drivers/arm_arch_timer: Disable timer before programming CVAL

Due to the fact that the use of `writeq_relaxed()` to program CVAL is
not guaranteed to be atomic, it is necessary to disable the timer before
programming CVAL.

However, if the MMIO timer is already enabled and has not yet expired,
there is a possibility of unexpected behavior occurring: when the CPU
enters the idle state during this period, and if the CPU's local event
is earlier than the broadcast event, the following process occurs:

tick_broadcast_enter()
  tick_broadcast_oneshot_control(TICK_BROADCAST_ENTER)
    __tick_broadcast_oneshot_control()
      ___tick_broadcast_oneshot_control()
        tick_broadcast_set_event()
          clockevents_program_event()
            set_next_event_mem()

During this process, the MMIO timer remains enabled while programming
CVAL. To prevent such behavior, disable timer explicitly prior to
programming CVAL.

Fixes: 8b82c4f883a7 ("clocksource/drivers/arm_arch_timer: Move MMIO timer programming over to CVAL")
Cc: stable@vger.kernel.org
Signed-off-by: Walter Chang <walter.chang@mediatek.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230717090735.19370-1-walter.chang@mediatek.com
---
 drivers/clocksource/arm_arch_timer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e09d442..f6c5f89 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -774,6 +774,13 @@ static __always_inline void set_next_event_mem(const int access, unsigned long e
 	u64 cnt;
 
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+
+	/* Timer must be disabled before programming CVAL */
+	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
+		ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
+		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	}
+
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
