Return-Path: <linux-kernel+bounces-124824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4083891CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D9A1C2719D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0111B24E0;
	Fri, 29 Mar 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLXK9xCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B02E1B04D3;
	Fri, 29 Mar 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716237; cv=none; b=NONPCczh9QhumSkyaS5NDHbFSd9HF+CAOSvnSiJNNy8BO/Rm8AOFDprd8+ardqyXrtkxtkxg3JDS7R/T/A+ozv5sNjEF7fO4ewpgE2DirPgv5FX8qn7jQXm2xZHu8Q3sEK+GX0jORkrV5B6d+zh8IzWXPPDysJhxtmveqiVCIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716237; c=relaxed/simple;
	bh=6bsS4MeXq1JFJQlm6HO0S+YRRPXy5PIhotKBG7LXizQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ5dnIT5GGb0WdTefUZWr1SViNCk3NBJnQyYHYrw0r5NW/HEbXvyZNkMzZJBRjKEXGDofzSiu7UN3KPIj/z4BrFOve89SQmWa9zVXZ+2fCHX6inZUegasXYIsVVe1LbXgLSif22xo/47PU2VOgmwCQu/ngjflOh8pK1U63+eym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLXK9xCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5EAC433C7;
	Fri, 29 Mar 2024 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716237;
	bh=6bsS4MeXq1JFJQlm6HO0S+YRRPXy5PIhotKBG7LXizQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLXK9xCCFC1CMkJFufkLhQbPx5fB8Cmu1xzIMPD8NaBEo7YV7dGZqGzIky3JyVuxI
	 q08Azuxfihr9x3HwT3SGbX2/Ha2SvMHS9Y5gs2UFY/YoP2PJ+2y6EkaPpaxQjedQmG
	 npoEWpku0vUqPeWkJossmZ3aKfX8XGtjSv0iH2a1FWDFGvKAe4hWW6LCGyF658Vwct
	 cNwH2FPewV48mi1tEnRhUZYgDi3gl/vrpxpOzQPbXfBkqKoHreMJTRUHCi5vuftRf4
	 +YV+M//8+qCC6rW/FYT/PAn0UqmxHJ6NlwblccrHQ9lzFoce+DwuvsmEj9CQ04C6iE
	 c39iE3MZSDRFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	bhe@redhat.com,
	lukas@wunner.de,
	feng.tang@intel.com,
	arnd@arndb.de,
	ubizjak@gmail.com,
	wangkefeng.wang@huawei.com
Subject: [PATCH AUTOSEL 6.6 15/75] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:41:56 -0400
Message-ID: <20240329124330.3089520-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit d988d9a9b9d180bfd5c1d353b3b176cb90d6861b ]

If the kernel crashes in a context where printk() calls always
defer printing (such as in NMI or inside a printk_safe section)
then the final panic messages will be deferred to irq_work. But
if irq_work is not available, the messages will not get printed
unless explicitly flushed. The result is that the final
"end Kernel panic" banner does not get printed.

Add one final flush after the last printk() call to make sure
the final panic messages make it out as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-14-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/panic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index ffa037fa777d5..ef9f9a4e928de 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -442,6 +442,14 @@ void panic(const char *fmt, ...)
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
+
+	/*
+	 * The final messages may not have been printed if in a context that
+	 * defers printing (such as NMI) and irq_work is not available.
+	 * Explicitly flush the kernel log buffer one last time.
+	 */
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
-- 
2.43.0


