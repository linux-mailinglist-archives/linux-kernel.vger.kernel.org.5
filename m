Return-Path: <linux-kernel+bounces-124895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C52891D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CA21C27888
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7005236590;
	Fri, 29 Mar 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB3ryuA4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14078236585;
	Fri, 29 Mar 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716385; cv=none; b=dPz7aAlgyoixWSmD/ZQdPewK1rI/gwsB0lY+MZT/kcq6qygv6wtBCNfmj2UFfJ9OwzAVprgBBv/f2vgMg1U182umCX2ZzMQHMce7oqLrvs2ikgNEsvQfGVIFOJChe6Ml3mPRLKJ8d8bXZ4dPB5wWetzpjbEtp+gbeUV+ITkbzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716385; c=relaxed/simple;
	bh=/IAO9x4QWXDpJ70Imh29GszKpID44rNqtuEIGMATmHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo1d24w5SpdjSnW7/282/IbM8m+UeKqzZQda+eLczRc2IxZ9cTUsaie/O7f7gaYI+0c0bFLpyB3cyUNoZKbssoFIg9OqLZj+wtmmGbWdcJWz2JOSp3Yq6EScy0Eu8okh/2nUtBdtnu4UknwYJzIYBRY0woMubu3bhjU42qRCEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB3ryuA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92A9C433F1;
	Fri, 29 Mar 2024 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716384;
	bh=/IAO9x4QWXDpJ70Imh29GszKpID44rNqtuEIGMATmHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EB3ryuA4HKhkU0x7SC1jG7L1Bi5I2SJ/LLQxFFk5bdCVsDZh+BAQsBEB8OjEF3Zid
	 mfIMwSPTe1ecZfyH9bhIfIz5C9nkL2yA9qeYLjzXNQNZyssmV9HoHfpD9sQ18bgUy4
	 Iaa5AGYaYByP1PE5udLicIKe1Hi0rSTtfipiTxASrudQ1UPa1P1N8NYCf9oXMaSWYp
	 PDoW6xK5FEhckCEnU6roIDZqwZHsEu6xhyqLTxjGEEc4fX9iXgmeGAoQDuyuYs+F6i
	 45VfQPJ7UmeVZwkkPhiq5iva2eZ77wk6EfMfNqE/SUEEcA3nZ3V5F/lXoJyfonm41G
	 FVRpw/FhkzOMQ==
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
	lukas@wunner.de,
	feng.tang@intel.com,
	arnd@arndb.de,
	wangkefeng.wang@huawei.com
Subject: [PATCH AUTOSEL 6.1 11/52] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:45:05 -0400
Message-ID: <20240329124605.3091273-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
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


