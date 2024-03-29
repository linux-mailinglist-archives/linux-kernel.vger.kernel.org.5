Return-Path: <linux-kernel+bounces-124683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B8891B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF7A1C262AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0817262A;
	Fri, 29 Mar 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNSISyUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640571428EC;
	Fri, 29 Mar 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715694; cv=none; b=Vca15yghTUEx6zHvXdLrJgiyDpQBnAyBuAjHY2hYhWkoelUwAtUai+Jf2mcSUTLl0YSiU/H3f5cgS9Y37bjdHo0ViXGhRCNhURIf/3hvlsdxyT9TNnIenhaGh4xp7yWZszK0Yg+S2d89xprYc8QF/KPKUjD9POGWwMAlC+dRdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715694; c=relaxed/simple;
	bh=4C1XuerS85Y7gsBAlxQh9gvIB9uBd56OU0XAnui9zag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtdPsyp3T1mIAnGL0PymO4MjxQABycn0BJB+qJCYOzYk6rhUPiyqxvQxvKohhsrR/TQotIMFOsQtTW4t6RoT1MYnJ/iXE5z/0aCiSQRVhrSplp0NCnjtT5JAbq0GRSa8AFA51pQt7IRrLYPTMKnRbACYlkDWgAPqJYoC6kvWJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNSISyUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54C8C433F1;
	Fri, 29 Mar 2024 12:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715694;
	bh=4C1XuerS85Y7gsBAlxQh9gvIB9uBd56OU0XAnui9zag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNSISyUukqq41RvR7yEizxgVsziKtdVREO03RXE3lBg939p4UfUmsKM5b9Z82XB3+
	 F8W5ubsuJLSsEGyKY7ZnYgH4Mvc8mcvfkjpQeDso4tqdgS1kBMfISSa4Pnj7/jYLex
	 trcorOqO8FxelJGO+nYoLWZn+mDYg9gPTBnDkrb+C93YALoEfJX8s0I3CCtXkkd7/5
	 Qsz60eClB7hVsS+DQafv/24tjKJSaFA6uZDAp0z96RTqRjvRkw799+HPwG92RliIIb
	 Op/34oEtCCcoJD2l6iCQBl+zpIr9YlFIuibsmSKwQlyBZ5FdXqWubi+349xHFoK3x4
	 ce2bV4b3fRYJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	mingo@kernel.org,
	arnd@arndb.de,
	ubizjak@gmail.com,
	bhe@redhat.com,
	feng.tang@intel.com,
	wangkefeng.wang@huawei.com
Subject: [PATCH AUTOSEL 5.4 05/15] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:34:28 -0400
Message-ID: <20240329123445.3086536-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index cef79466f9417..5559a6e4c4579 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -404,6 +404,14 @@ void panic(const char *fmt, ...)
 
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


