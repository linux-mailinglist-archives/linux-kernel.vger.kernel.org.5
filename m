Return-Path: <linux-kernel+bounces-133909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40089AA9A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05A4B216AE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7E364AC;
	Sat,  6 Apr 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORp0hN7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762732C96
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403082; cv=none; b=DO0BPjcDaMb2oN61tCC5WqJQLDmv7iWnvIz4kLgplMx4W2S+d0SzNVShBasrCfPAIl1urKgc4seRrGotdvcb+pqKX+Pexl45aIiL7/rzpRI4x4T+q4EIaa2JApCApJJlCVSHM30OFUXXikxIIrcLzCadsqHSS/6luHO0Bn5rJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403082; c=relaxed/simple;
	bh=66gmc8NYeVWAyoDrDcv4Y+x0uF90S93OHXhD2YCJ+6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqHtA0BPHFGREYj1LXe1SADsveePxRE8Fd+wSu5FJ8L0nioeyH++kuFQshR3w1CoeXwa80+H1Cp6xh/wXUqpkdtze/Jnf22+6Yq1QoRkw+wro183IzGSIIn4cUzQRR1hliOMEdAn0GsKRJMsNC1crTVx1oF8+zsQaDdDOvBgbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORp0hN7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D956BC43141;
	Sat,  6 Apr 2024 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403082;
	bh=66gmc8NYeVWAyoDrDcv4Y+x0uF90S93OHXhD2YCJ+6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORp0hN7UO4eAFVjTVf+j76i3KDprQYwqJpkNxvDrt+iPdVVS6f0JuqH2XGji5lexO
	 VMgDm9Bm7R1z1XzoynU/F8vM/ab82da/na0x9fdYRATW5wtdBxEgqs2ueta2Wn1r6Y
	 kenWH0Xtfzq4OppuuLViU5DSllzVe1rMeN332aV+AcqgyZ/tyNr0UyN222Nz8VlgGi
	 xCVAAraEpdqZc/56/nku3IRctwH2c9uid1h4GtwLQ+5tSFSsD0/HrGGssaMTeb6LL4
	 hCqSEkaNErssRXqLItMqPpvkhkj/w7jRvglqDVMz818h7r4fNWOH4zZ3RZrUQqmjV1
	 skUKAikVI+gVg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/3] clocksource/drivers/timer-clint: Add set_state_shutdown
Date: Sat,  6 Apr 2024 19:17:56 +0800
Message-ID: <20240406111757.1597-3-jszhang@kernel.org>
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

Add clocksource detach/shutdown callback to disable RISC-V timer interrupt when
switching out clockevent from clint timer to another timer.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/clocksource/timer-clint.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 09fd292eb83d..1c17eff9861e 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -119,11 +119,21 @@ static int clint_clock_next_event(unsigned long delta,
 	return 0;
 }
 
+static int clint_clock_shutdown(struct clock_event_device *evt)
+{
+	void __iomem *r = clint_timer_cmp +
+			  cpuid_to_hartid_map(smp_processor_id());
+
+	writeq_relaxed(U64_MAX, r);
+	return 0;
+}
+
 static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
-	.name		= "clint_clockevent",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 100,
-	.set_next_event	= clint_clock_next_event,
+	.name				= "clint_clockevent",
+	.features			= CLOCK_EVT_FEAT_ONESHOT,
+	.rating				= 100,
+	.set_next_event			= clint_clock_next_event,
+	.set_state_shutdown		= clint_clock_shutdown,
 };
 
 static int clint_timer_starting_cpu(unsigned int cpu)
-- 
2.43.0


