Return-Path: <linux-kernel+bounces-106790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7887F3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EF0B210D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0015C917;
	Mon, 18 Mar 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXhBinCL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAF5C90D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803261; cv=none; b=i8N3euBhWEgLp2koKXf1sNv5Kv4t8H/ofcjPNIqc52n1fpAtK1F0OXf0wxadV8VRCI4nDePTCZF6n1mH/Tw6DpOKLWUkhNq1e6GCy/Jyx7L4+YK+GWm9ecdl+M/wgwGk6Evy835mIM29ToSf/NrjtvebnKL0alypzbsxRYjFiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803261; c=relaxed/simple;
	bh=GFQJjaJoEksnwgMSVkP1ixUpsviQBqiwHuOE7mOoQeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S89To/uiULzg8Xi3P8g3uUnCeIB/UDyRBbPS70kG0UDSxbSehe15G7IurDOylNxNgcYqV7T5GSrPU+Sa0OI1lxi/e5ateTeewf/uCfwPB2v2WYEzN33Ll38sJH0TgDx3mH6249jQ+uJbahbE75NLDvoCBEGUx8lRueGBBQjb0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXhBinCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE9C43399;
	Mon, 18 Mar 2024 23:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710803261;
	bh=GFQJjaJoEksnwgMSVkP1ixUpsviQBqiwHuOE7mOoQeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXhBinCL/sZXYInYsmcPbMic3kyrbbwBISJbfrMDr9Pe4l+sg0tWWtHs8cywBvSUr
	 ZJLfFWufsl76D+z7NT4m/u1jBNrFhKlGVIR8u7PHLEUzVDkNKTsxfE9FuSKtV+WZij
	 0c2Fd0d/1yy0WM4gIVoiCN8MSehLtRxsu4zCOkHA65C62kGADuYtmLR2R+D1RvkX8F
	 qzTz+4EquwrSLksOiFl0UaKbV8Q0OU5vBpt6SquoOj08PGit6MWGPvlpOO7CcvoDz4
	 VZTNHTJ9KLsp7wCW6aScplmGQezLBITwne0wTRbQqqLuAsiLamahva96h9dFNn6nvw
	 r/r9l+Eduj5YQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 1/2] timers/migration: Fix endless timer requeue after idle interrupts
Date: Tue, 19 Mar 2024 00:07:28 +0100
Message-ID: <20240318230729.15497-2-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318230729.15497-1-frederic@kernel.org>
References: <20240318230729.15497-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CPU is an idle migrator, but another CPU wakes up before it,
becomes an active migrator and handles the queue, the initial idle
migrator may end up endlessly reprogramming its clockevent, chasing ghost
timers forever such as in the following scenario:

               [GRP0:0]
             migrator = 0
             active   = 0
             nextevt  = T1
              /         \
             0           1
          active        idle (T1)

0) CPU 1 is idle and has a timer queued (T1), CPU 0 is active and is
the active migrator.

               [GRP0:0]
             migrator = NONE
             active   = NONE
             nextevt  = T1
              /         \
             0           1
          idle        idle (T1)
          wakeup = T1

1) CPU 0 is now idle and is therefore the idle migrator. It has
programmed its next timer interrupt to handle T1.

                [GRP0:0]
             migrator = 1
             active   = 1
             nextevt  = KTIME_MAX
              /         \
             0           1
          idle        active
          wakeup = T1

2) CPU 1 has woken up, it is now active and it has just handled its own
timer T1.

3) CPU 0 gets a timer interrupt to handle T1 but tmigr_handle_remote()
realize it is not the migrator anymore. So it early returns without
observing that T1 has been expired already and therefore without
updating its ->wakeup value.

4) CPU 0 goes into tmigr_cpu_new_timer() which also early returns
because it doesn't queue a timer of its own. So ->wakeup is left
unchanged and the next timer is programmed to fire now.

5) goto 3) forever

This results in timer interrupt storms in idle and also in nohz_full (as
observed in rcutorture's TREE07 scenario).

Fix this with forcing a re-evaluation of tmc->wakeup while trying
remote timer handling when the CPU isn't the migrator anymmore. The
check is inherently racy but in the worst case the CPU just races setting
the KTIME_MAX value that a remote expiry also tries to set.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 611cd904f035..c63a0afdcebe 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1038,8 +1038,15 @@ void tmigr_handle_remote(void)
 	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
 	 * return when nothing has to be done.
 	 */
-	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
-		return;
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask)) {
+		/*
+		 * If this CPU was an idle migrator, make sure to clear its wakeup
+		 * value so it won't chase timers that have already expired elsewhere.
+		 * This avoids endless requeue from tmigr_new_timer().
+		 */
+		if (READ_ONCE(tmc->wakeup) == KTIME_MAX)
+			return;
+	}
 
 	data.now = get_jiffies_update(&data.basej);
 
-- 
2.44.0


