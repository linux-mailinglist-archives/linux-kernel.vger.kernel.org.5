Return-Path: <linux-kernel+bounces-121569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BD688E9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3023F1C3156E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EAB131BC8;
	Wed, 27 Mar 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3vctCY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14496131E3E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554504; cv=none; b=Xb28kA8aiPnfzGgCEEHELjYbOr2kxfIPFneXjHDqp5HmNSIoPzx1jsndjBXD8hrzDbqu9/GXmrPHmr4bL5tkjsG6F+PGC5oEPaSwqxkWY/OgYhRMmlFlu4AdO8OKrMKxklPV0Zct0oz7KBajYsiFLwF5X1E4/sOWbGDGtjeW8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554504; c=relaxed/simple;
	bh=Nw3gMFJ/F/poxLbQzgT93Y2Pv42axzvi9HneGeq24nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U18ZXFUJali/4RC5e4e4281FkIBVRxQXXUo01zO2kipN3wof/asAvYMN/nxf7u5jpp1mEUcYaKjE/nYGO7BguE8NCuOBTw2o78zzLxKrzctLjG1/Iz5DqHCTg/qswiTRw8MB5/t+FyU+vcojpgVUaS+BLG0k31iBa0xR04PEEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3vctCY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1735C433B1;
	Wed, 27 Mar 2024 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554503;
	bh=Nw3gMFJ/F/poxLbQzgT93Y2Pv42axzvi9HneGeq24nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3vctCY4JRAjYtkAQ9qoJRjfijrTnXvrV+n2Bi6grrTy1C/hCrBQNQG75kqU5pou4
	 7HdzjXIGxIkOXUPUHLVfmemuWs0TkX99r1f1H1fj0v4Uw1DEX5qdpI0vkB0B24c4K4
	 Wi4eRQG1SFM+SfTggRlSwzW35E9NbQ/cmsn5JRCyFBavzMNy7Wmbv3EVj8+re/UTf9
	 P5FaRh5UZ5/zqd3g9RdGF7P8DNji083zB77mImuMUIuYHmg9bVzS3QN4FPvoHPMYiw
	 e8hxkUty/1x8LVKowUWEyj73DMCRqsZXOrWL/MRc0NYyDMqS9vv5N49fliBRdZg4wu
	 74mtVZw54zisg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clocksource/drivers/timer-clint: Add set_state_shutdown
Date: Wed, 27 Mar 2024 23:35:01 +0800
Message-ID: <20240327153502.2133-3-jszhang@kernel.org>
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

Add clocksource detach/shutdown callback to disable RISC-V timer interrupt when
switching out clockevent from clint timer to another timer.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/clocksource/timer-clint.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 09fd292eb83d..56cf6c672e6d 100644
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
+	writeq_relaxed(ULONG_MAX, r);
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


