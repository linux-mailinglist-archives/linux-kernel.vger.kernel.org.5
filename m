Return-Path: <linux-kernel+bounces-80338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D841D862D80
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F1AB2107D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907A47A76;
	Sun, 25 Feb 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjV4lzBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C03F9D4
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901738; cv=none; b=TCgh7xR+igrK7ibkNdiUR3ttmYxImWq3W6dAJkUC0alqxh7cXFmP6pfRGiN6v2vRHLfVVJdWgi+juu89cbg4JizNf4nnoeMh0ichRtUtfzgiCVnDS4aJYvtvl7c6IlzYS3wtUbOJQeBbUqOiCiIlKiUeXiNg9xJkUIVGgbtust0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901738; c=relaxed/simple;
	bh=ENJnGfyd2+EEzXokoqGcyz6LV1lezsDunVEKa8lSN3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKn/cXKTG+g6+NH4PSdn0Kd7JI2xwWOe3DW/DXYBLiZ9izuzgdCwLX3wUURyrbz5B4bMFSHdjqkwnRJ3rGL+GREKHkyR44E7pJHX8Kya9qQ8iV/hnKnbN22osdfCYApFTPZk9+7XWSxYxxNvuSMNWlZzcuYtVAyZ9mdOKmB+9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjV4lzBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8B7C433C7;
	Sun, 25 Feb 2024 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901737;
	bh=ENJnGfyd2+EEzXokoqGcyz6LV1lezsDunVEKa8lSN3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjV4lzBy+48yVJ6MtN08wD5bGhgv4/sVSxjayzSEscmTLWMCAtNbmZGo4tj3+eeDn
	 /rYrbsD1m1OkVKe1DKtywblm8kGzLWXyntzuo8iACq7Pw1/JJKaCfw5XY9r8jimH34
	 sKxEcyC18kmKMe0pjf3dXNiHklF3An4HXXPBx50+tA9v4jJn7BoIBtFuAp2VFSZe42
	 di97SQZPDeW9OjlIHgeyEVGwgNiQpn32IjkaAO6XS1BOxDguoLGTT1GU5XDEReGwTl
	 0NF3HpA96e56ii9CwwxARG7S35TlGwWy+yGUQK18dmb/NRdm+ni9KojQZkluy4Aq/Q
	 dHAL9rpt2Jf2Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 11/16] tick: Move got_idle_tick away from common flags
Date: Sun, 25 Feb 2024 23:55:03 +0100
Message-ID: <20240225225508.11587-12-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
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


