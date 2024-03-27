Return-Path: <linux-kernel+bounces-121568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22B88E9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F8C2C38F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50078131753;
	Wed, 27 Mar 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr1y1Cuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1C131732
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554501; cv=none; b=VS1lmQlJ/i4tfEhm422EukChvRV4GSWJtr1VlaFZRLzXFFoI74Yx/MoW+b/4FxL+AjaTSuwdb+WSS8VHoPFozYWJgtLR4XZZ1LPb2z6Aai4CywpmQb8h598rwzjGMKljSAfvtoM6oxQSdAS0xWwaHg1QQF0wpYjY5RLAEYKx1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554501; c=relaxed/simple;
	bh=kxw8lEOeXnx/duF9z7ST9TT/zC6EoGrvtJe8oJFI1B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1hOieLV/PYxIiL5qF3GJFnV8DCni4bXu3QpWkc1wsHSVNFUCk+VYDWS9k72ggM1bcmUBp4qkqzKNLY4V8t4ZBJj7+rMsAFOtm7J9HjDE+jT1FrduRfNzoRR4LulFK2R16f40bUAVpmzxTml4pBtlbxIE3Nb2ZEPnFbbnLRcOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr1y1Cuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A95BC433C7;
	Wed, 27 Mar 2024 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554501;
	bh=kxw8lEOeXnx/duF9z7ST9TT/zC6EoGrvtJe8oJFI1B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sr1y1Cuu9f/Se064mDUn1HaCUkTnbO9IBcwOnhO4s3a/Mlvj19hhrxttE8kNOJA1i
	 zW0nSCuYqRkkblNx79/0IToZ+uYKPrVtK/RsRTGET65JvBUlbnBr+xnURpFy6E9uEO
	 Jsc+HyY1Qqo4OpmJ5FHxS0LBgybRWxjAhhIC2DbLn+PzW/Mry+jN1z3i0/FuRNrs0A
	 T0BNpgtrWjidXAsNZVrDC5m0wr0xCw1IWoUuwrYkFCsnQe19gwecezPAQgkZcYdkCK
	 Jl7Orhrx+qfMJ4Tv93a6bLdHSbX/8kFx+KwKZCKZ40GSm5YwG8T0gWZ6tGf2kVX46Y
	 V+Yf/i5ucujfA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clocksource/drivers/timer-riscv: Add set_state_oneshot_stopped
Date: Wed, 27 Mar 2024 23:35:00 +0800
Message-ID: <20240327153502.2133-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327153502.2133-1-jszhang@kernel.org>
References: <20240327153502.2133-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid spurious timer interrupts when KTIME_MAX is used, we need to
configure set_state_oneshot_stopped(). Although implementing this is
optional, it still affects things like power management for the extra
timer interrupt.

Check commit 8fff52fd5093 ("clockevents: Introduce
CLOCK_EVT_STATE_ONESHOT_STOPPED state") for more information.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..e661fc037337 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -69,11 +69,12 @@ static int riscv_clock_shutdown(struct clock_event_device *evt)
 
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
-	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.rating			= 100,
-	.set_next_event		= riscv_clock_next_event,
-	.set_state_shutdown	= riscv_clock_shutdown,
+	.name				= "riscv_timer_clockevent",
+	.features			= CLOCK_EVT_FEAT_ONESHOT,
+	.rating				= 100,
+	.set_next_event			= riscv_clock_next_event,
+	.set_state_shutdown		= riscv_clock_shutdown,
+	.set_state_oneshot_stopped	= riscv_clock_shutdown,
 };
 
 /*
-- 
2.43.0


