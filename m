Return-Path: <linux-kernel+bounces-124501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E385F8918F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206441C24B61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5866413F43E;
	Fri, 29 Mar 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Exkmj11v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4713FD95;
	Fri, 29 Mar 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715247; cv=none; b=KpChTREwm7UH8UhG9+BEZmS2b8Tw9Cq4FVhSLubyU3qHo04EkaWuGsvWWXI2C9rvLfyWE1ZobH53OZvuKBYu/iKT59+bumieihp0G9em+mCw9OLLb7VJvXZ1gyPDsTJXrhclsOPE0QRFFJQ0eo7CV9mG3znW4GdLGOfRjV4LxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715247; c=relaxed/simple;
	bh=WBxuzQAL7Uk/oH50pW4tkZDR4/xjBoDCxy6UmwLkmH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5bHptH2/qSegpLuPo6tOVhUk1Uef0Xw/YhpkEzcVd0xgeHJbO68sORcGoOABylgFClQoZWAuooMi+k2HuSrLafB2gooGd92lxdZ5Zrv8EVB54TvjTb0+MsqbeLlYEpRvCHodVG6FoztmkKzXGEhRbZh1NsreObnzl/g9vD4Bdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Exkmj11v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A922FC43399;
	Fri, 29 Mar 2024 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715247;
	bh=WBxuzQAL7Uk/oH50pW4tkZDR4/xjBoDCxy6UmwLkmH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Exkmj11vX/KzrpxhDEF880W1yZjsZkEGrSLLuF9PZF6bTb+eHsBEDwET4ir2uksCv
	 /JWIRLMluaqKaEISobCN3b/bnrgY2jtpPT/Osyu6bkJga8NwgsCN/IIu0SVgDnryLP
	 bF686dVa7exI1p/vQZTMhDfT4JWe7pslKuBgmAJzOMUcIRVnhqo2tiX7OTbTlwoI0j
	 /BP5HhI+AY1oFIwSCqEx4lNH0Q6w518Twk4/Viv+8LU6yAssfr78aUUllkdNVpYs2K
	 3w9AV9RrNMq8AEwR8YULaHozxHGiAj7fsNLhicgA8yX3POtlNBjzvTG5kCn2XRHxpQ
	 yn2lQTCUD07TA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	lukas@wunner.de,
	bhe@redhat.com,
	arnd@arndb.de,
	wangkefeng.wang@huawei.com,
	ubizjak@gmail.com,
	feng.tang@intel.com
Subject: [PATCH AUTOSEL 6.8 20/68] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:25:16 -0400
Message-ID: <20240329122652.3082296-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


