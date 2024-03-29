Return-Path: <linux-kernel+bounces-124564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808048919FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372301F2694A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992533DABF1;
	Fri, 29 Mar 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDrVKXcy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FB15359D;
	Fri, 29 Mar 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715417; cv=none; b=WCAL/13fqNJ2Gwbx98iALaDUMu0CxdVfIwZyEt+cdY0QViLsZ37dflxCkimE3HonQ2Xv8GbfgaLrvidcpf27ie+hq9Eoo8P51hWAZCqWwY8IkJ9LfL374FQEmTw1ILbmBBnDew3zo9j1e6z2pM71M1q4/jhb87N3+Faso8zUtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715417; c=relaxed/simple;
	bh=6bsS4MeXq1JFJQlm6HO0S+YRRPXy5PIhotKBG7LXizQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5VZRXyNKgP6TGwmE6COPEfntbGR8ypkOIUhDtiHQoDmToGXEcLi3XxJIyIU86EgNYYAsNWi5zSpTQLtMArtQL2hvC2JeJBB+qEgQshLyoE1wG9hlRPv1aIdaXpZOtq70zE2LJMTB2escf+HsiBKY3mR0TC0i5exR2OizOSod20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDrVKXcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426CDC433C7;
	Fri, 29 Mar 2024 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715417;
	bh=6bsS4MeXq1JFJQlm6HO0S+YRRPXy5PIhotKBG7LXizQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDrVKXcyEHxVlT6OzP/nm55oSvvzsdkmjqqZlR56OzCSor+sDtRNQvtLZ/0xykCvt
	 9LxLkA3r06Ny+ekqq5JMlDyCuQ8nKkPnHiT1471bjPD5T/9OWqk3BiEs6340bWpKd8
	 Zdq8aufOf7x7K9sGuVe7Hs4pulklpW8aoZXxSxuzUGuMbYteQXMqBUMGS8aVFjop7N
	 U0ePUhifjtyr06bXuYtPZVKx7OrS+GfRXAfSb5V5nxCdhMVrK671tSpI7PKM5AC5eE
	 4S10yk0zp5UtodMqlsupMiR9aAFuuXSnRAEPYjSkVcgj38R1ITk4jAx/bJhU6zRFku
	 8ZrIM/kgiyeDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	wangkefeng.wang@huawei.com,
	arnd@arndb.de,
	lukas@wunner.de,
	feng.tang@intel.com,
	ubizjak@gmail.com,
	bhe@redhat.com
Subject: [PATCH AUTOSEL 6.6 13/52] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:28:43 -0400
Message-ID: <20240329122956.3083859-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
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


