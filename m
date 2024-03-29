Return-Path: <linux-kernel+bounces-124611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAC8891A90
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADECA1F253B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B415ADBA;
	Fri, 29 Mar 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVm564r8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B913F420;
	Fri, 29 Mar 2024 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715541; cv=none; b=LyNp3UxwR3tgYKheEebbmi4iM3t/tXA4EBNau37bTs69hmzulAgSWgQrTyrkhk61z0W0JUxpImWov6Kp0OeIu5F9Ok+8pJS7dj15eaBsvaUBUBVpMibHT3LkyEWwQx4pT6rIhFNyLbkWIzb+v8b7xoMw4oGd28Tvm+0OJB8vERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715541; c=relaxed/simple;
	bh=/IAO9x4QWXDpJ70Imh29GszKpID44rNqtuEIGMATmHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiXuU4c9MnSU+fEImPU5guesvP5uiJ824/srsknq1k3Zo/BJ8tgn3zBdieC3zvXeBJiZ+AI0ov0/Ktnp7+gXYXlxnosZRj4akNBlCb8cj8Fozbiai0pTwf/7bhpnonrOKNldyPaw4++G83i1bkNuMNqOiqx67O2nG1ZhVbt92I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVm564r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BDEC433C7;
	Fri, 29 Mar 2024 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715541;
	bh=/IAO9x4QWXDpJ70Imh29GszKpID44rNqtuEIGMATmHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVm564r8KKRabJXFNjVPAG/CyxJkWcqAEqfBSKohuxPkzkaB/1/hXnHPIjRRcXg9V
	 EalHpZPlzyx93UAXxWQjb6SpdMDVNW90fQmiiqUmgokDEJMPKjhvgUU0kg485i3v/r
	 wWqvz8sSO9bZwGAQquuGktrkdBw7n88IFg1FfxyFD8WNgF69VRW0NmBK0kRXufN0eV
	 WI0G1XiaLOc5Fk/yYfCLJt9guOiFz3m/IQL2W/pLEsoIb3cZcPbiHFryhrqrD6fUab
	 /8RSa4EWWKk6QHLZPHBoz4H2Db665EWMVLhUn1wPqtfj+JHMUaQioxu+++qJMcSdhs
	 abKJ0iqAO3xNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	ubizjak@gmail.com,
	bhe@redhat.com,
	wangkefeng.wang@huawei.com,
	feng.tang@intel.com,
	arnd@arndb.de
Subject: [PATCH AUTOSEL 6.1 08/31] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:31:27 -0400
Message-ID: <20240329123207.3085013-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 63e94f3bd8dcd..e6c2bf04a32c0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -441,6 +441,14 @@ void panic(const char *fmt, ...)
 
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


