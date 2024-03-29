Return-Path: <linux-kernel+bounces-124639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A69891ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36F52883F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D14C15FD17;
	Fri, 29 Mar 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWYzU0Zp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129515FCF0;
	Fri, 29 Mar 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715606; cv=none; b=DmJ2lJ8Z326ujEncjWx9PnQu3bJDHi6nJZ7RLRqHktoaEg2FnYcOt7E81dLxNYeMryKErKmiDlIAdo3kOu/zgJzcKOUFg/hRDw5bNB/MbItQDDgDUDszbWkQ0hD9er3SEtmJFTJ+at0xzebdbeT1FvZoytEsZ7ZjlFtmg4gD7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715606; c=relaxed/simple;
	bh=wu6kP4xIU5k3jmxEFqSl2CpRjVXZdjtE5UFK3jobj6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8//AUtCXtPCp9CT6Arh/O28UiSDtp5J6RzzcdRD+ig16MRtfheDD+2YCfVVETpXjSBIQyg4o6MTf428i26GXK8VyXC5U+wjD8Th8bxqrDiW/d1Ghy4LSBqL0BOkMhMvLWvrtIGeaVnyjlj5MJ3LK/N1Z5C4QG5OFufDvBs3hvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWYzU0Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D88C433C7;
	Fri, 29 Mar 2024 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715605;
	bh=wu6kP4xIU5k3jmxEFqSl2CpRjVXZdjtE5UFK3jobj6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWYzU0ZpOXsEgFcOhRWV09vnBMfed0Ae+xnBCl7Vl6uno0kBF+NshlhxURGs8crTk
	 M6/5cJ1rJxoZWnC/qE6gQySua7r2wQEcmtbe9fhAEojkXTfni8UubblAOzhQ0yR1Ub
	 /Zl9YuCnKyvPdUbSJKQlAdIdBOwlX0FXSBpa6k22wIGsTbRjbHoebu2Np0x0Zr1pB6
	 QjU6bB3cmIlSKkQEsCmZBMpg+K8xVxWb3WgEOVlqqEQvYGdcF0FyLEkMY5AWfbKtVr
	 Zs5dyfCa2i0Ze43b8sVOq4rI7RUIISjrEvaii3GiURNEJ5ksFmtm1t0AfkiuB2708Z
	 OgH6y7EflSUJg==
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
	feng.tang@intel.com,
	arnd@arndb.de,
	wangkefeng.wang@huawei.com
Subject: [PATCH AUTOSEL 5.15 05/20] panic: Flush kernel log buffer at the end
Date: Fri, 29 Mar 2024 08:32:53 -0400
Message-ID: <20240329123316.3085691-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
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


