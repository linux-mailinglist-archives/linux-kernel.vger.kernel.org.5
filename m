Return-Path: <linux-kernel+bounces-124662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47A891B22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6BC1F21D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFC16EC10;
	Fri, 29 Mar 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUb6Xera"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F516EC04;
	Fri, 29 Mar 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715654; cv=none; b=UzgQaffz7bc27oXFnyq/+uonRXWtxmayU4oJ9Rl0Wt8zFa2I/UmFHCu484VlUQOVqN3+okkIv4ZB4l21RmfAw3J8dfKNmlEYqq43wtOveBHjF/X3QXdqDn52HorMTB04R3CeYbUfvvH3pyOiF6bKID4YhVpVrW1EkKqDlH/yOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715654; c=relaxed/simple;
	bh=afXwabrmFKHm4awyP1u59fR04hTD1HHSHBy8IRIahVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijeJGW2X3jYhpl/Gb/nRMQ4a18elYA+AL63v30G3301MwFd676kLbgplIlQUvznaCcQBTvopjIIzpoGsF+PoDkAa/YXrLrhd4xGm+CXtbkn42MLekRTDz8+0XkH3sDitxFklLErhB8OfW9Cy96Om/igX4S2dSGSeAN+KB1e2XIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUb6Xera; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A775C433F1;
	Fri, 29 Mar 2024 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715653;
	bh=afXwabrmFKHm4awyP1u59fR04hTD1HHSHBy8IRIahVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUb6XeraY5MA1XDv75H9CdKYL2SGZIJQLaudAh30mhLm5LobJm1p+KNdW6uIWIktY
	 FffOqE50csqGF/UPARb0EuBGZ4f5VLYQ4FBQyFfOBsgvc+xily2o+247BfH8RFoWsd
	 Wo2iJeD2fcOy5oSdMtfBCyvm+Ifynx6eIdrYirZGkIDXpiJOyXJOQUOoJtCjA1IpXO
	 RiN3/RPEg/+JYyjp/TIpmJWZ7l9GORnKZWnqoUIpO4Ujz9SmetvwBsWXpBVpsJK9Zc
	 Yvja+5l2fAFLV9Qg5c8smhAWjneINRnphZsnNCeIPvrfWYfCVhSE+0nJHfAProTYnR
	 Ef3sVJUlH1nhQ==
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
	lukas@wunner.de,
	bhe@redhat.com,
	ubizjak@gmail.com,
	feng.tang@intel.com,
	arnd@arndb.de
Subject: [PATCH AUTOSEL 5.10 05/17] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:33:44 -0400
Message-ID: <20240329123405.3086155-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
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


