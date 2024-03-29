Return-Path: <linux-kernel+bounces-124977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F704891E71
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5041F2708F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D61AD9BD;
	Fri, 29 Mar 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/soy0xb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19091AD9A9;
	Fri, 29 Mar 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716555; cv=none; b=sYbLAnslZolCXuvBhdgnYprEu1e+WQGtLtOtEX0vjOySy202mf+yOLzZ+nMuHYESzI5FpfXah1uXdVS+pmWzpE45SANyATnwqOghp497sM6YXGxnpTR9mww9qjIg3FMSkIYQI9EWu0cp1O14HGUgVQ0l/cQdixBWph/DS8hyY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716555; c=relaxed/simple;
	bh=afXwabrmFKHm4awyP1u59fR04hTD1HHSHBy8IRIahVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pb9QL2R+t+FjofQN/NEFvZVvjx29gaCHOb9UPryn0oQLt1njzt0I8TP2OzsUC99413LPIDE4oAesItmAemIP0unmDaeF32yWT15NnL2zUXATh3Do+CuVmkBNqJ+JKBFQJptBG8P0qFtNaNpaqMnl4F1acflF3Lmryq+b8bIdIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/soy0xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04F6C43394;
	Fri, 29 Mar 2024 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716554;
	bh=afXwabrmFKHm4awyP1u59fR04hTD1HHSHBy8IRIahVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/soy0xb7gNaPQH4wFSlB2E0LrTJM7BXFtoeg2/9Z0ddGoliFQIq+7U121X43FNl9
	 rUV1Ulur4J0+FjWsDlcQljiWQSUKnMiv/VHw74pccrV/27/4KQZ5OoW90OQcKy4BaQ
	 o0goAi2Q1/o3HVCl1bgQNjP4xuIIU4ZVIS2hCxZKWpl2Mtzh/EGZ3GoEX4yN9PpULG
	 PEA0KCT3Kd50xqNaF20L5BB5pisFNyhw/yWpevBlV81JTpSL6nKQDY6V3aJhsuUQsS
	 WQ+aBHuzifYJKiOdQzQs/43mJixmOQl1P2pHIw4H75Gb7d+FhrH/DckRF8oUKuGjE+
	 /I+2lty93PfAQ==
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
	arnd@arndb.de,
	lukas@wunner.de,
	bhe@redhat.com,
	feng.tang@intel.com,
	wangkefeng.wang@huawei.com
Subject: [PATCH AUTOSEL 5.10 07/31] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:48:24 -0400
Message-ID: <20240329124903.3093161-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index bc39e2b27d315..30d8da0d43d8f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -427,6 +427,14 @@ void panic(const char *fmt, ...)
 
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


