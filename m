Return-Path: <linux-kernel+bounces-124943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BDA891E16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E98A286C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A31A76FA;
	Fri, 29 Mar 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFENI1rH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B191A76E7;
	Fri, 29 Mar 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716481; cv=none; b=BgyUa4Ws1Vohv1iTi6j4kG9zEWC7MnMJ0rPBXt3LnI09adXw0g5g6CHIsbEKhvyF+njqZMq83xcGjXZNxs9LNbX6Ks7XVN02EptRvj22f61unqeKBtU+quWJwyZTkoXD+6yCsvV2hnwyMGptYyfs8VwEuK3gqn5f69ni/bNppv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716481; c=relaxed/simple;
	bh=wu6kP4xIU5k3jmxEFqSl2CpRjVXZdjtE5UFK3jobj6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHkuQl3UCuRrjH2K+XP9kXTE65RmWblqN0+2Sb81BeMPy6oJOFYDRbesRrcgHmMDx4dHkcRs2kV8Vjf/s8qfGIZwta4Fk9vM2oMPoXTjF6wD5aDvsGci++4s0UWXDPlLyy2OIgpTQTL+n+iJisw9pCnbX2O0gd7qOK8CguvO1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFENI1rH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE17C433C7;
	Fri, 29 Mar 2024 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716481;
	bh=wu6kP4xIU5k3jmxEFqSl2CpRjVXZdjtE5UFK3jobj6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFENI1rHQfO8JfT9BlcHL0Sq4AjycbqJUF9w0oVRWmMbok2qtld87l26Uz//yhU4y
	 GudIQLRJjdpWtpe3bJsPdJ2P9qGi1Bkc6CKS4PZvipNYMvxjzAfEb3CT4VaiTtDFfy
	 rHHz/u5ExGtYfZV0fzulIfhebdgS1QgC7z3Lwm3ScU3l9FZq9nIsDgBVUZoH3EaqJG
	 niepv3KWPvg7yx6jD/VZyfdL6vQGnJGWsIQ785ez3F5knQKxxYU2r201xLcYNSJDUq
	 czPsbOPzauFu9K1Iq8Os0+sKN2Bl+552kCErh/5HMDqkNcNACRN5PYNL1rZ1mAWjYG
	 L1BOzqcg2qbdw==
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
	feng.tang@intel.com,
	arnd@arndb.de,
	ubizjak@gmail.com,
	wangkefeng.wang@huawei.com
Subject: [PATCH AUTOSEL 5.15 07/34] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:47:08 -0400
Message-ID: <20240329124750.3092394-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index 47933d4c769b6..3b14c6d123ddc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -425,6 +425,14 @@ void panic(const char *fmt, ...)
 
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


