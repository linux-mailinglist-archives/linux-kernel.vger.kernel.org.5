Return-Path: <linux-kernel+bounces-133908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC5489AA99
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204FD1F21B57
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F10F2DF92;
	Sat,  6 Apr 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD+KtTXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B062CCA0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403081; cv=none; b=N4m8ymYpPfI6KMrYVKoa53xjH5tgIKcPZnb6MwcreameH/YoAx01RmOdD2+hQL9/6XV8P8joqQOCVqMqmERmk6BjQeK7jPJpP1p/nfbONiKSD+y6t+enWo/4w1lqWo1sJblBbntyZky1Hj8I1urLjMOtP3MqYYXSKq5ojcON2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403081; c=relaxed/simple;
	bh=kxw8lEOeXnx/duF9z7ST9TT/zC6EoGrvtJe8oJFI1B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dqowo22PocrAb6Jrr4hypscv6ZYG13lnYedtfZ6RjUjQscdW4P2+8OzwvfnpZZOsQKGumnOQerFTmO3wwIrNeKmVLx1J3YB/OVjyXDOXaayrOX2GO/TkFp4UbkIm8XWIyVkZrSYt6Ya9Isuu93z1Yt+Aewij/t81enR33OHUB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD+KtTXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C9C43390;
	Sat,  6 Apr 2024 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403080;
	bh=kxw8lEOeXnx/duF9z7ST9TT/zC6EoGrvtJe8oJFI1B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kD+KtTXj/GBjQUtr6D1v/myTGzsq973TWGwuzcxWDl6/CjFmbP50gM/JVNX58qrgd
	 EUcASu06PHK5jfQ3QNBfcSNrsLpU7hjW9xVTzsUQ8BCdx59mBulPvueYfkwwhZh1D3
	 Ro4Cs/FOBTRN2zGolCo9LGk43zQhmZC/ZB4Rs4/PXyJS0X35Gg8HyttKhBQHaT3erO
	 PhwZfs16AI77tZ+6Py0jXcj9ZcBwMwW/U+hAbUGaslrA9P4Owjs/jFxLQmXH62SGvh
	 DOVmIxFb0qf+tnmLIuXObaJkPONg1btiKj9dDq/7L+WYYej7XRoQ4vdH8MUDWbgsXP
	 +8m3vR/9SczOQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/3] clocksource/drivers/timer-riscv: Add set_state_oneshot_stopped
Date: Sat,  6 Apr 2024 19:17:55 +0800
Message-ID: <20240406111757.1597-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406111757.1597-1-jszhang@kernel.org>
References: <20240406111757.1597-1-jszhang@kernel.org>
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


