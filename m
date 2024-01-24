Return-Path: <linux-kernel+bounces-37390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A583AF30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F491C24478
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3F7F7F5;
	Wed, 24 Jan 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiSLcaLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C07E782
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115936; cv=none; b=Jw9B+6o31noB5LOfnpRa091yqSmbGt1bFGP7rpF+cWFAHmyAKKY8pXaHeyNvAmdRacOmViNfeWd21D7TLRukeoiBCdg+dI7fEwaxgLnCV04+GFzhamOEggPMoRLhAdwARZstckFNMBAHw7cjRC51N5XPV6+CM7TEIP+Zrufrrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115936; c=relaxed/simple;
	bh=q9uMk1kYzNMw7MFUczwSrP/48nreFiHWAfLI4g8u4gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rp3h3RsGKcZHWJlkFGXq8Mrj/hKVDWEHrlg08ljOlO39A6mIVJydNLnABK/nF361++UUWaoMYhNNyTE+f/tAcxB/12i3OITzaMcDB1xsGhVCZzRLX0+LcVBi6FqyoT/LIlQ8Xku0dk0k2WzRshJpdtIzUOFFq1sgASPZDitAVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiSLcaLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE68C433F1;
	Wed, 24 Jan 2024 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115935;
	bh=q9uMk1kYzNMw7MFUczwSrP/48nreFiHWAfLI4g8u4gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiSLcaLQx4KzXnHfYnbkXLUfNdon+Rz77GiBfnJ/CRKY2fmwi7IOc3WWrkReuHGmO
	 UB4Ti93CVUj4DdmIXvQqNOsH+E2SPdkOEVTg0lnjKJ0aLLF2CczUKyEosz6c7FokAO
	 5lLSmgGf8ITFUSvoqK/daOUEogfBm2En0OT1VsTyppvELjdUFqUZkX7sa+XcOcvDl5
	 uDzJGLuO+DyS2wXXXQiGvCtdYN8RfyhhIQJiJ7M/Zwtnkx4CSXNsuyk5n5CIMspIE+
	 J+KCUbz1WZrYnNLvlb5ZpxdwSYQzcSKIZtWstFz8SxFkpoiIRzjz68rHuDRrB88I0M
	 ysSiDrjn+4cvw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 11/15] tick: Move got_idle_tick away from common flags
Date: Wed, 24 Jan 2024 18:04:55 +0100
Message-ID: <20240124170459.24850-12-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170459.24850-1-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tick_nohz_idle_got_tick() is called by cpuidle_reflect() within the idle
loop with interrupts enabled. This function modifies the struct
tick_sched's bitfield "got_idle_tick". However this bitfield is stored
within the same mask as other bitfields that can be modified from
interrupts.

Fortunately so far it looks like the only race that can happen is while
writing ->got_idle_tick to 0, an interrupt fires and writes the
->idle_active field to 0. It's then possible that the interrupted write
to ->got_idle_tick writes back the old value of ->idle_active back to 1.

However if that happens, the worst possible outcome is that the time
spent between that interrupt and the upcoming call to
tick_nohz_idle_exit() is accounted as idle, which is negligible quantity.

Still all the bitfield writes within this struct tick_sched's shadow
mask should be IRQ-safe. Therefore move this bitfield out to its own
storage to avoid further suprises.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 35808bbb8a47..3b555e0fa937 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -61,7 +61,6 @@ struct tick_sched {
 	unsigned int			tick_stopped	: 1;
 	unsigned int			idle_active	: 1;
 	unsigned int			do_timer_last	: 1;
-	unsigned int			got_idle_tick	: 1;
 
 	/* Tick handling: jiffies stall check */
 	unsigned int			stalled_jiffies;
@@ -73,6 +72,7 @@ struct tick_sched {
 	ktime_t				next_tick;
 	unsigned long			idle_jiffies;
 	ktime_t				idle_waketime;
+	unsigned int			got_idle_tick;
 
 	/* Idle entry */
 	seqcount_t			idle_sleeptime_seq;
-- 
2.43.0


