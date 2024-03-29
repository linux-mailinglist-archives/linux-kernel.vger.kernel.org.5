Return-Path: <linux-kernel+bounces-125008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168CB891EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6914288932
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE41B451A;
	Fri, 29 Mar 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5ywSH4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426201B4530;
	Fri, 29 Mar 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716620; cv=none; b=sPVoc1C23BtBCzSmEMfr6sEmKktfDPrPr+n6ZBhAX8YZmV2HOY9GDNAuN/HRA3n6ABOEIpeAUpgsITE+urZB9moB+ywz2jG7sXXDv37/AaLA1SR81DAg95rdM3zzTlDwiY+x1DC5zB3+glX69SbLRy0XlJ4SvVszxw2+eiS9byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716620; c=relaxed/simple;
	bh=4C1XuerS85Y7gsBAlxQh9gvIB9uBd56OU0XAnui9zag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGe2Atq7fKcFD6J4JIFCCi2hU910cylC+NwS3nCjtcny/dSzlzzGA92nI4OJkDPJRGwL+WUf8oTDZLWjCArNsLQh2r5rtp0Y2PPVam8PY2GLgK65fexeQ/k4bRVXcMMcL1ciM1BJuDqw9XlrC4PIZMUM8izyeSY29qCT1PFHn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5ywSH4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D593C433C7;
	Fri, 29 Mar 2024 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716619;
	bh=4C1XuerS85Y7gsBAlxQh9gvIB9uBd56OU0XAnui9zag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5ywSH4ikhj5F9yI46XngDbvkDS13m5Fbnj32k3N8A3JvviPq5hUvrBFTqBJIe76q
	 jGw3hhiedJMeQpBjlCP5yWbENhE8UoQQ3odO3RDV5lpqM3t18PTt07cHLO4FsikuFy
	 ycVEFs4EscRV1KXETbXKFHF593CyJqeFeY6UNxVyKcgIZ6XI7VUB6HZFAb+86CLThd
	 JbTx/sSRGtF21mUwFrvPMjIpXIdDuA9i7Xsa3w1egguKYI0mxoOv5R4+e8eegd5/e+
	 frABBUceDsZ54DOeKhAIQS3VbjWXUVeZqlkL3e9+xhT4/EgvrupYTs2UeIyvB9Mp7v
	 HBNWyyDR4B4gQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	lukas@wunner.de,
	feng.tang@intel.com,
	bhe@redhat.com,
	ubizjak@gmail.com,
	arnd@arndb.de,
	wangkefeng.wang@huawei.com
Subject: [PATCH AUTOSEL 5.4 06/23] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:49:39 -0400
Message-ID: <20240329125009.3093845-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
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


