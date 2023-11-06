Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B97E3149
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjKFXXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjKFXWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:22:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E8212F;
        Mon,  6 Nov 2023 15:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8410C32776;
        Mon,  6 Nov 2023 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312640;
        bh=KkG5pCddvXahJDY5ashTO39qCyNvdEJ6Nt7Khz8dXJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UA5sT6EXKlj1dHlB8Qy7XEkuqauEyoNpq/oZglYxerHc2hVco30W4iA5iRUMwXU3O
         75Kobex7GNPVIxkBLPAqwSrakwFiKka+KlTZJ9JEZi06SYf3tJBpOwiuk+VFrJs7RU
         6X2k64bBtapplFpyK8x+zLBXsPcSEWm/zqIl9nDyWJ+NMRNXtcb2XWM+WxXuE5Uhoc
         RlCIpnbZlc49lbiMcbpqUHUWNFNPwYgGpENOhtdg1VfTlQ/m9sz6Kjc/8+Xz9jKSuR
         r/iVL3ahQDoQIvllpADjU43nwm5s7AMXnWtSvbMq/KoaOUkoIE9VRCN1SBY5xo/+gG
         7d2nqmIMXbx4g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ronald Wahl <ronald.wahl@raritan.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de
Subject: [PATCH AUTOSEL 4.19 4/5] clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware
Date:   Mon,  6 Nov 2023 18:17:07 -0500
Message-ID: <20231106231711.3735997-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106231711.3735997-1-sashal@kernel.org>
References: <20231106231711.3735997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.297
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

From: Ronald Wahl <ronald.wahl@raritan.com>

[ Upstream commit 6d3bc4c02d59996d1d3180d8ed409a9d7d5900e0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/tcb_clksrc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 43f4d5c4d6fa4..998d9115add6b 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -294,6 +294,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
 	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
-- 
2.42.0

