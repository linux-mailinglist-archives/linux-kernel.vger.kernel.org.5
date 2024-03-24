Return-Path: <linux-kernel+bounces-114786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF23889137
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B29D1C2208F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB51B6318;
	Mon, 25 Mar 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXnwbUMK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167061F0970;
	Sun, 24 Mar 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323392; cv=none; b=hwm0QpORMo9RRTTFfLz6/4R27ZhEIY3auIoFf3dOTTgh4u/WauzM0maA3dwuIGTrfvzpdWkGRXR7jyxQfXLAaByD48wylZwcC6BtjbxCa5zF3WWUuA3dKPgiVkhACdxoBgFUzyO91f+YghBqE0uQUoT/milsg+4tF9go2iKIa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323392; c=relaxed/simple;
	bh=RhExOqD90ay6b6jf70iwXvA+yE4eM00jqamd/5u6OQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx07svKwUsJZ2bw8lQsO7EMTkrUp2VsN9czOBebGSLzSYtHqoe7DVMiuv7Mb1zw3SCQ/qyzrqjvBViGr2smqgTgW3n+kf1jBwM8TWRUIAKRpgxqbe0z2UZo0MEiUtjvyIa+q8aOQsE5bKTEKpSGGZOHY3XCBGkD8DQDLFGwQSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXnwbUMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1D5C433C7;
	Sun, 24 Mar 2024 23:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323390;
	bh=RhExOqD90ay6b6jf70iwXvA+yE4eM00jqamd/5u6OQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXnwbUMKZFKPHOOxJcu19sDQsn8+SsR7gw5Db8AjtkU+KiMH0K4VgOEYYnPiEqJQX
	 n+xKeV+N8rC3PY7nbCR0rP7YbfGgmFT63yBJz0IG2w5BLHBpYNTPpKGAH62brcWnHK
	 /1ZWL/WWPjMHA4oIKHMLm+QUCeHLDNDZQ5phUhftO4qFx+ud0HJpCfq/Savo3E+FEf
	 hI9LpqmKu46mwdOwGapHYNps/UAh1jOP2wLg9a4+jiS6zyZ7iQDFPT1TXr4g45q+GW
	 Gln7aP33myLA/gqzq2bzyoPnnJCFzTFaIwQYu3WVL2iJN3O0eW7at6gFvn50v06nhl
	 KwctMYG26KRtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 091/317] printk: Disable passing console lock owner completely during panic()
Date: Sun, 24 Mar 2024 19:31:11 -0400
Message-ID: <20240324233458.1352854-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Petr Mladek <pmladek@suse.com>

[ Upstream commit d04d5882cd678b898a9d7c5aee6afbe9e6e77fcd ]

The commit d51507098ff91 ("printk: disable optimistic spin
during panic") added checks to avoid becoming a console waiter
if a panic is in progress.

However, the transition to panic can occur while there is
already a waiter. The current owner should not pass the lock to
the waiter because it might get stopped or blocked anytime.

Also the panic context might pass the console lock owner to an
already stopped waiter by mistake. It might happen when
console_flush_on_panic() ignores the current lock owner, for
example:

CPU0                                CPU1
----                                ----
console_lock_spinning_enable()
                                    console_trylock_spinning()
                                      [CPU1 now console waiter]
NMI: panic()
  panic_other_cpus_shutdown()
                                    [stopped as console waiter]
  console_flush_on_panic()
    console_lock_spinning_enable()
    [print 1 record]
    console_lock_spinning_disable_and_check()
      [handover to stopped CPU1]

This results in panic() not flushing the panic messages.

Fix these problems by disabling all spinning operations
completely during panic().

Another advantage is that it prevents possible deadlocks caused
by "console_owner_lock". The panic() context does not need to
take it any longer. The lockless checks are safe because the
functions become NOPs when they see the panic in progress. All
operations manipulating the state are still synchronized by the
lock even when non-panic CPUs would notice the panic
synchronously.

The current owner might stay spinning. But non-panic() CPUs
would get stopped anyway and the panic context will never start
spinning.

Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20240207134103.1357162-12-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index de44ccf9743c1..5ad824b080e27 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1802,10 +1802,23 @@ static bool console_waiter;
  */
 static void console_lock_spinning_enable(void)
 {
+	/*
+	 * Do not use spinning in panic(). The panic CPU wants to keep the lock.
+	 * Non-panic CPUs abandon the flush anyway.
+	 *
+	 * Just keep the lockdep annotation. The panic-CPU should avoid
+	 * taking console_owner_lock because it might cause a deadlock.
+	 * This looks like the easiest way how to prevent false lockdep
+	 * reports without handling races a lockless way.
+	 */
+	if (panic_in_progress())
+		goto lockdep;
+
 	raw_spin_lock(&console_owner_lock);
 	console_owner = current;
 	raw_spin_unlock(&console_owner_lock);
 
+lockdep:
 	/* The waiter may spin on us after setting console_owner */
 	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
 }
@@ -1829,6 +1842,22 @@ static int console_lock_spinning_disable_and_check(void)
 {
 	int waiter;
 
+	/*
+	 * Ignore spinning waiters during panic() because they might get stopped
+	 * or blocked at any time,
+	 *
+	 * It is safe because nobody is allowed to start spinning during panic
+	 * in the first place. If there has been a waiter then non panic CPUs
+	 * might stay spinning. They would get stopped anyway. The panic context
+	 * will never start spinning and an interrupted spin on panic CPU will
+	 * never continue.
+	 */
+	if (panic_in_progress()) {
+		/* Keep lockdep happy. */
+		spin_release(&console_owner_dep_map, _THIS_IP_);
+		return 0;
+	}
+
 	raw_spin_lock(&console_owner_lock);
 	waiter = READ_ONCE(console_waiter);
 	console_owner = NULL;
-- 
2.43.0


