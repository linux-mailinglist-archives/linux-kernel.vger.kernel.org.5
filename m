Return-Path: <linux-kernel+bounces-47355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11597844CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E5296BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625E13342C;
	Wed, 31 Jan 2024 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoLMS/qV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76D12FF6E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742711; cv=none; b=chNKGfPzykxl4KEsRGV0PfZHFy5SAGibRecDZodojej7GFdN9tNsfJ8tpM0VdMfRQ01Z1chDJAma9k6BiG4wyy6anNPnOFT8giuonP13EFWpJxh5QmDsCWZZXTOJnursbRVopHEWHky/ne4g9BwyCdno/AT226kIATyzwd/6cKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742711; c=relaxed/simple;
	bh=ENJnGfyd2+EEzXokoqGcyz6LV1lezsDunVEKa8lSN3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDVhSEUSV7jlK8EhgbeIvMxJqc4wG0/qxy5dTHD84UkN8NxKVfVHW5Bb4VvErWLvPTxtRjiFkANezAMPW3gfa6XlNapKBNLDBPA3Apsq+MH6YqXFQ9y6sWWNvP87bDe080RKn8dK4OEItqa7tnqY0Hw2CCENqKbF5Riik7JfLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoLMS/qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABABC43390;
	Wed, 31 Jan 2024 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742711;
	bh=ENJnGfyd2+EEzXokoqGcyz6LV1lezsDunVEKa8lSN3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoLMS/qVXCgH12a1Qre5TUQYW2zMqW7aif3QRBnwmKnh/CwClddGFrVOQ3/wHBehZ
	 TpOsRQfoWIKxlSNiYGI7h0xrDjIIm/aMCRmehB12wpuZWLFxlU8AAP/+oEqCya/Eck
	 q5TvYxnTcFLJTVE47WljMBjsX8Fj1t2gjHmGIioovO9JI7rN7iPCy2h9VTQvwk81jP
	 NqefnWqWuoMD56dIHL6vDQa+qUT+ckIMaRM6Ilo/TJQsdN9nkWAPCbggi6v2zRTuu2
	 peEAgUekX9mf6T7XW5fduGkpFukgYKmfkn49+VIj2KBdP74xgTa5idCqhdx+/ZdJvn
	 QzTpk1RI/c65g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 11/15] tick: Move got_idle_tick away from common flags
Date: Thu,  1 Feb 2024 00:11:16 +0100
Message-ID: <20240131231120.12006-12-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131231120.12006-1-frederic@kernel.org>
References: <20240131231120.12006-1-frederic@kernel.org>
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

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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


