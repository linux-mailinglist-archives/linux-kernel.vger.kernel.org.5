Return-Path: <linux-kernel+bounces-133910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E44EA89AA9B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F4B21864
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C4376E5;
	Sat,  6 Apr 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8XjQBe/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF374D3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403084; cv=none; b=FTuv0SqoxV3O42XNAXF3Ep+Ht7LoibgbbKJ/tpqUf5UBb9D23fSgCjppQELbrXGux3XjtP6oE6DjVscxmIFKJ/Z8dsSIlwTpqHe/JTyPp804a7c+nBp9Fg6jRU1wavtnshFmNt3YiwCZuPymg9bcicp23Aq6Vgpyri/1ZOJumDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403084; c=relaxed/simple;
	bh=QNz4CJCFePste/7DhKkLbFCEPMnrk6GSUJBGB1Aj74U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INQ5VOPHpG21O7q2f/meBV0KqYAVtiW61xNSY3K3YFPwhqLV1s9+KVN4lwYbNFjYiP8FKEq4tus0BLIX8DXwI7++DtSw/4uiwao97fIBW47hAQpMT7qrNELwNf7aEC4ZN9D0Y7ey6g7VpWvKCIapcxRgo5vql2Ao3vsBpb99Kdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8XjQBe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4331C433F1;
	Sat,  6 Apr 2024 11:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403084;
	bh=QNz4CJCFePste/7DhKkLbFCEPMnrk6GSUJBGB1Aj74U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8XjQBe/E5HTHforMou7F0rT2W0G3OjrHdYJ6K+oat6W4FF6vVUP9NIUAIqT9EJUR
	 uqenOb2f/JATM2VxEjKOCIq8oMSyy1DPKELKFX5K1256zGXVDsS7f6K/qDevPWKkSl
	 7WivOFgVG7kANEROaGzXdC7LTSYVQ6TqzqyHHwsSr1Kirr/Vs5s0ObmhnhS+EKwuVR
	 bd2GGlIvffrXvgNc33owMD0XRJ6F6Y1lohtulMHUIG0PRuAq5pbKNCeDJHiDO+XY4+
	 xPgDLTi21AlyVDJbdJw3XmX4cYBBD/Qndb5zMUqu+n3H1GYqblgHIG97b0S4QaQdGP
	 N3cZKEBv//cLA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] clocksource/drivers/timer-clint: Add set_state_oneshot_stopped
Date: Sat,  6 Apr 2024 19:17:57 +0800
Message-ID: <20240406111757.1597-4-jszhang@kernel.org>
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
 drivers/clocksource/timer-clint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 1c17eff9861e..f468fa8bf5f0 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -134,6 +134,7 @@ static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
 	.rating				= 100,
 	.set_next_event			= clint_clock_next_event,
 	.set_state_shutdown		= clint_clock_shutdown,
+	.set_state_oneshot_stopped	= clint_clock_shutdown,
 };
 
 static int clint_timer_starting_cpu(unsigned int cpu)
-- 
2.43.0


