Return-Path: <linux-kernel+bounces-49377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CA8469B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012821F23486
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE321803A;
	Fri,  2 Feb 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpyrYF+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666B18028
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859730; cv=none; b=MyZodHEUnSDSklmq5Lq9MHTyg1zSjHkTgPU5FtSJMd9uI0MF6GrFQ9u5A6Px8reGNP94DZM9eTSsuZTvB6l+JeO3MluMs/WQCbRxW0WuL3G2MbjuoMCWZynoHmG1PMCSF++YTkvkN//AAIfXwRF5N+MY8Aidv039+H4PjaBDa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859730; c=relaxed/simple;
	bh=TFYyKtNU9LrtUbdDfZDtr2Ce6cbj0SCWcK3+Yb6QTxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldWppIackfrtOTkBC7SaB/rGvvO2PmSMInpHbSC+TWuj3k/ORMPXqMI63nfa931PUTHn0H5AIlALCX8OmUESr8MHC0zVaRQNDWQTwmqzLq50uYnBE+QW1IhG2ugZaARsgVHGXeyiDbQJPAPaanl8kJdLWsGgLwrqME3Y5u9D1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpyrYF+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D1AC433B1;
	Fri,  2 Feb 2024 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706859730;
	bh=TFYyKtNU9LrtUbdDfZDtr2Ce6cbj0SCWcK3+Yb6QTxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HpyrYF+4ooyhYEQuqTPHttDXPZeAJe2Jk5R32AMWODY7PhEo70DDcALFEzqcIKWmT
	 100AD5h3kIYTlfkj0yi5pcoNK3rQIbQl1Uy5FFVLj5xR7VbTSmaMliUJx6R6tho54h
	 ToNl0hxePM1xGUBWjdNwk+dIii0Eel14++EEirmxcGFq0QRE202zvogLo/vsiBDNPw
	 WhHbTfeNqo7lm3PjkY9WQTbtvHPQOfQIH+m7z5oNWWLJsLKMTn6S6zhZe5wml1wCwn
	 qsUT5/6+h7GmGVCBB2mTCiRiEe7jGpzCUXVQaYRbIidT+l6Z7n8f9dO2ccyENmC7sI
	 9SOSdde89o3BA==
From: alexs@kernel.org
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v2] x86/dumpstack: uniform die messages prompt
Date: Fri,  2 Feb 2024 15:45:12 +0800
Message-ID: <20240202074512.563274-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

panic() has a uniform prompt, like "Kernel panic - not syncing:". That's
easy to indicate a panic there. But die() message doesn't have.

We died thousands machine with very different reasons weekly. w/o a prompt
in dmesg, it's hard to write scripts to collect and anaylis the die reasons.
That makes admins' life pretty hard.

A uniform die() prompt could make the life of system administrators far more
easier.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
To: x86@kernel.org
To: Dave Hansen <dave.hansen@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index f18ca44c904b..e9ad413d21f8 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -393,6 +393,8 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 }
 NOKPROBE_SYMBOL(oops_end);
 
+#define DIE_PROMPT	"DIE:\n"
+
 static void __die_header(const char *str, struct pt_regs *regs, long err)
 {
 	const char *pr = "";
@@ -405,8 +407,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	printk(KERN_DEFAULT
-	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
-	       pr,
+	       DIE_PROMPT "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter, pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
-- 
2.43.0


