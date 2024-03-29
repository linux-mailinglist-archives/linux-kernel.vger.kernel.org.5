Return-Path: <linux-kernel+bounces-124731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C335C891BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B16DB22101
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1AF1782EA;
	Fri, 29 Mar 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwmLFsjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B826178890;
	Fri, 29 Mar 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716026; cv=none; b=qjiMNCnmAJSmFzbsG12ar+NfqeLe64xVN4LECk271p65QYdw3W3YgfuQonGv7VoZ6NPV8lcwI2mWzf3bE6pJAcj7XVE2b5Gd2x4RLvgOjWBP0o+30MS7LAts7N0IoFT+kffSA7Lvjl/d9XjAMspSn2p/REDhdB7EhcXJE2cPHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716026; c=relaxed/simple;
	bh=WBxuzQAL7Uk/oH50pW4tkZDR4/xjBoDCxy6UmwLkmH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAxYIyQ1oEhKeNnG8+vEMrYGwocaoHG8XB7aTEd2K1gn/GoeyvRqfHAzLlr2Q35IplENw1cytl8snbwYy7cqjguwZL5n/4RQbiTgD7QgggOl86exCDztgonU6X1kO8g2ytS2dnCc/qAs5Wq9ijteU24UTevmY9qc0AtAGUI1+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwmLFsjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A7C43390;
	Fri, 29 Mar 2024 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716026;
	bh=WBxuzQAL7Uk/oH50pW4tkZDR4/xjBoDCxy6UmwLkmH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwmLFsjSEurH2/xTUh39aRikZ4o/+Xl2mQfTUYFMUNRqd1gPOIovzvSTlzAFJ92Dw
	 SO5KwGos8PmdSwd0bgMXY10NoM+Oh/uAm507aeLBhcUsw9mk4UoNO8yBHHtzWmjS+w
	 u3E46R3vKttIVMCkAHE9We+i5lXFLXXDOuTU7B46efMdWAeOQ7AnzAh/d3+ILIpZT7
	 JH/UIGa+x5/HTMJpPhWv4rLRzdkQdk287JfbOk6fp7uG02tnWgAgKW5E4O5C96jXIw
	 pSSwufKvLfD6VRTI+JxFU/SKlPmf6bQ3b/Jrvm6LBQ+OULoNwRx2Mrirw5iARCAZ/A
	 gemv8SuiYrV4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	wangkefeng.wang@huawei.com,
	ubizjak@gmail.com,
	feng.tang@intel.com,
	bhe@redhat.com,
	arnd@arndb.de
Subject: [PATCH AUTOSEL 6.8 22/98] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:36:53 -0400
Message-ID: <20240329123919.3087149-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 2807639aab51d..f22d8f33ea147 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -446,6 +446,14 @@ void panic(const char *fmt, ...)
 
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


