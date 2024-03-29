Return-Path: <linux-kernel+bounces-124732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5234891BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26371C21DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9EC1788B3;
	Fri, 29 Mar 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcibOs5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F5178300;
	Fri, 29 Mar 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716027; cv=none; b=kf88OwcLcs65pwvbpMFoELPmW9ozFZvJCbPfJ8JvycxgvsSpQEpjW1ls8lv6ZHTfZ4vgQFZTx37TdMshdKyQqCfNRqVOWC6WjTs4PL7RcnOpxUlVeoQT/opLMj2/4u2OYrkywy9JiPkkLegCBi87OHx++dfw40EKBRooVPfpp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716027; c=relaxed/simple;
	bh=OAeN0QcaQFWpAB8YgvTAPxvKI+ywGWLbU1SWwuh4gww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Crp2+m5JBRXL2iB+11S5zNHYxwOr4i187VvkJogXV8JgSQQOEM+tdwuzYCS0+l3wMRveKO3iuRokz3elOk3rgQONZCMfrLCeNNcppGiAMV86zwQV1zCTLkle21fVbhf4IGt5AnMa6gKBadQRp3EdgrswKKH3DWvQptNYRbq9A1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcibOs5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDB1C43394;
	Fri, 29 Mar 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716027;
	bh=OAeN0QcaQFWpAB8YgvTAPxvKI+ywGWLbU1SWwuh4gww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AcibOs5LaoS3DkObWt+KhAVoPQd3+ZfHjAwJqWvxknkK0QwnpGR+iygWgmv6BTiOT
	 LdUmTe7jHf4PSqJH2yESQEBmev+H0V2EwauceBTbCx79/p5ovmij4ZB687v3dAuaya
	 07RA6dDgxRMW8j1SeBz/oZ47Cs+tAdleiVEXJHmwTXXD4wFi2/2VjVZiaFLrSJbi/7
	 JvIXqKJ7+itGfsaen+JIuOiygIe1SPmreJ4uNIzerlPh7XkxmltAoe49nAEgsX/Gs8
	 rK3fDzBcHbAV8svfCUfPPW7xHEUJkwlSjb8YChNFOhu12FKbs3VO0mEDKLT/9XCRva
	 J50FDueiOQQ0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 23/98] dump_stack: Do not get cpu_sync for panic CPU
Date: Fri, 29 Mar 2024 08:36:54 -0400
Message-ID: <20240329123919.3087149-23-sashal@kernel.org>
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

[ Upstream commit 7412dc6d55eed6b76180e40ac3601412ebde29bd ]

dump_stack() is called in panic(). If for some reason another CPU
is holding the printk_cpu_sync and is unable to release it, the
panic CPU will be unable to continue and print the stacktrace.

Since non-panic CPUs are not allowed to store new printk messages
anyway, there is no need to synchronize the stacktrace output in
a panic situation.

For the panic CPU, do not get the printk_cpu_sync because it is
not needed and avoids a potential deadlock scenario in panic().

Link: https://lore.kernel.org/lkml/ZcIGKU8sxti38Kok@alley
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-15-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/printk.h   |  2 ++
 kernel/printk/internal.h |  1 -
 lib/dump_stack.c         | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1ed..955e31860095e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -273,6 +273,8 @@ static inline void printk_trigger_flush(void)
 }
 #endif
 
+bool this_cpu_in_panic(void);
+
 #ifdef CONFIG_SMP
 extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ac2d9750e5f81..6c2afee5ef620 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,7 +130,6 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
-bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a7..222c6d6c8281a 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -96,15 +96,25 @@ static void __dump_stack(const char *log_lvl)
  */
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
+	bool in_panic = this_cpu_in_panic();
 	unsigned long flags;
 
 	/*
 	 * Permit this cpu to perform nested stack dumps while serialising
-	 * against other CPUs
+	 * against other CPUs, unless this CPU is in panic.
+	 *
+	 * When in panic, non-panic CPUs are not permitted to store new
+	 * printk messages so there is no need to synchronize the output.
+	 * This avoids potential deadlock in panic() if another CPU is
+	 * holding and unable to release the printk_cpu_sync.
 	 */
-	printk_cpu_sync_get_irqsave(flags);
+	if (!in_panic)
+		printk_cpu_sync_get_irqsave(flags);
+
 	__dump_stack(log_lvl);
-	printk_cpu_sync_put_irqrestore(flags);
+
+	if (!in_panic)
+		printk_cpu_sync_put_irqrestore(flags);
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
-- 
2.43.0


