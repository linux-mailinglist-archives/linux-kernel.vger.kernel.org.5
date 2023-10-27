Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3097DA049
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbjJ0SZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjJ0SYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:24:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E61FCF;
        Fri, 27 Oct 2023 11:23:13 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlSE1S6mOvSXypD+y0xJVASym3C2ooMSVuQ65wfM2iE=;
        b=Bb+VnG5croBUh0LH+jHheVtDaul9LhBZ0L27HwHBkve27nMCXPfUwHNxik4bT34AZf4suP
        IgdGBSsmw7Z6iXSMkbQOfLB5TxHrU8fWuAw6OX41DuL2RsxWbSbIL39h8tm1PFO753V/J5
        9Yn47eY7u/tvob2+frkK/wbDhMJk6AkjR1rG/jrAoVhRVPPbl5i2e+sCcm503xePfs8yMl
        7MyRheRLAb0em24UHM0yxYmmMfGj3SV3JOkesKgwSQFQRN/l1T4l7pzy4dS3vIWf6Hamuv
        plvMAoh3aocb9VeciF00AKfkNgnhLIFmOrSymtEpzXMj8q4n3mWm/d39JKqE3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlSE1S6mOvSXypD+y0xJVASym3C2ooMSVuQ65wfM2iE=;
        b=zWNUMv9YkfImGpDQJx5x8r6clpX4xrGlcsecJ5oIrAt9DoecT3KsR6AJV5za2Fk9x/ZMME
        CjWGDR7B6L4B6qDA==
From:   "tip-bot2 for Ronald Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-atmel-tcb: Fix
 initialization on SAM9 hardware
Cc:     Ronald Wahl <ronald.wahl@raritan.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231007161803.31342-1-rwahl@gmx.de>
References: <20231007161803.31342-1-rwahl@gmx.de>
MIME-Version: 1.0
Message-ID: <169843099077.3135.6542731450492019643.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6d3bc4c02d59996d1d3180d8ed409a9d7d5900e0
Gitweb:        https://git.kernel.org/tip/6d3bc4c02d59996d1d3180d8ed409a9d7d5900e0
Author:        Ronald Wahl <ronald.wahl@raritan.com>
AuthorDate:    Sat, 07 Oct 2023 18:17:13 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 13 Oct 2023 12:56:50 +02:00

clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware

On SAM9 hardware two cascaded 16 bit timers are used to form a 32 bit
high resolution timer that is used as scheduler clock when the kernel
has been configured that way (CONFIG_ATMEL_CLOCKSOURCE_TCB).

The driver initially triggers a reset-to-zero of the two timers but this
reset is only performed on the next rising clock. For the first timer
this is ok - it will be in the next 60ns (16MHz clock). For the chained
second timer this will only happen after the first timer overflows, i.e.
after 2^16 clocks (~4ms with a 16MHz clock). So with other words the
scheduler clock resets to 0 after the first 2^16 clock cycles.

It looks like that the scheduler does not like this and behaves wrongly
over its lifetime, e.g. some tasks are scheduled with a long delay. Why
that is and if there are additional requirements for this behaviour has
not been further analysed.

There is a simple fix for resetting the second timer as well when the
first timer is reset and this is to set the ATMEL_TC_ASWTRG_SET bit in
the Channel Mode register (CMR) of the first timer. This will also rise
the TIOA line (clock input of the second timer) when a software trigger
respective SYNC is issued.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231007161803.31342-1-rwahl@gmx.de
---
 drivers/clocksource/timer-atmel-tcb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 27af17c..2a90c92 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -315,6 +315,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
