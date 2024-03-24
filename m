Return-Path: <linux-kernel+bounces-113052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB779888118
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56B71C214B9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2301448F9;
	Sun, 24 Mar 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH7mSFuI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8A1448D8;
	Sun, 24 Mar 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319862; cv=none; b=M6WoNBA4ly1yYV8WRdgm4YlMPSj9Udgkl3JcxxSogO99qvpMR1R538f4cKFSSoukCLSRSU412Lzt2bdNkhYP3znj81j6wETLsRLsR4/882jAc+3OaXfiduIr8FWXvNk0mcbWBcrNd6wVLNRDUKxPayVEPMZKF6U/sMyFNpyr2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319862; c=relaxed/simple;
	bh=Jb7k3GoU6Ve+LODOIYdKGbcfDg48IkkmThzdS/zf9lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWeLOEC8iN3D/sPm3ZSTLgAHOrgIZub6FkvkfKpODDt8oye1tnqfs6yNHhtznP6/RyrtTignsvysKEcFLJJGoLCq3Bg69imYls8llN5yb1UHOEppK5g1DiNSZj7fY7dOesLUeykw0qCx4y+K8/kBMeJOFf2lTrGPM07HgpFsyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH7mSFuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B0CC433C7;
	Sun, 24 Mar 2024 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319861;
	bh=Jb7k3GoU6Ve+LODOIYdKGbcfDg48IkkmThzdS/zf9lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IH7mSFuIPdJK7zd8gD/NYm0RLnBqzes39j9uigRoBtzsyBszkPIPdnpCebyfYgub1
	 8kLc8BYEq5JPoxu5+ASK3jT4ssh3FeFiByS9ZEQfKD6f0waVRHllhFuBqns+nty8r2
	 WhGYcPqAtOCM8PnyFK8ysTVfP2jak1Hff1EQYb0YMBsb139rHX2wvUPu8G7raIQbM3
	 PtvuQtAqH7oRXFkaSrDJIjolMOxcxH3TYTQjubop2ypC1slNe2vLLlynuH+tfgUYxj
	 UmPhMdWDoEfeHVGtdn6HyUJD9RsDR6D4xpeZ73fCPwimVKCOBBElC3DxgR8Ie8io64
	 0tne1MvKhEpng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 165/715] printk: Disable passing console lock owner completely during panic()
Date: Sun, 24 Mar 2024 18:25:44 -0400
Message-ID: <20240324223455.1342824-166-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index b7e50f8438df3..72f6a564e832f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1869,10 +1869,23 @@ static bool console_waiter;
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
@@ -1897,6 +1910,22 @@ static int console_lock_spinning_disable_and_check(int cookie)
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


