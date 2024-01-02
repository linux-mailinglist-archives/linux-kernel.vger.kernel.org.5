Return-Path: <linux-kernel+bounces-14120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C156882180B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B581F21EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D22108;
	Tue,  2 Jan 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBq6Mytl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AA20F8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 07:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF3BC433C7;
	Tue,  2 Jan 2024 07:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704181346;
	bh=9DEKpBAK4lAfxEl+HK6SsacI9TfcOy6SmxwkqN+ethw=;
	h=From:To:Cc:Subject:Date:From;
	b=XBq6Mytlngor+fYXTiV7tYQE4gmlfDid3wxgABGQbLv0zLFeV8oJTRHL8O+5mXOuw
	 LoTN/f41GPhDAXSe0519oqjz/7peMuXp9TAJTX3f7Rsu98R5+Ili6VCIP/UhjxDExD
	 xCY8M+8R0nb5h9NpjozNpPaMDlQEiFQuso6gYJz4Nkxt2+yRj+ky0gvZt32vYyORld
	 3GJFQGrvisapwp+8HjcwQDynGZ5gfl3kmVyLbYua1uqgY0EshNg6A5wD5Wigau12tE
	 JYwOaKh44tILNw0UpUGALIrN1X8tzRIxreiLqYJK8HKoTgex3tpnWl2nPtmfXc3CL1
	 9mERgdw4uRDLw==
From: alexs@kernel.org
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH] x86/dumpstack: uniform die messages
Date: Tue,  2 Jan 2024 15:43:51 +0800
Message-ID: <20240102074351.1528009-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

panic() has a uniform preempt, like "Kernel panic - not syncing:". But
die() doesn't have.

We died thousands machine with very different reasons. With current die
messages in dmesg, it's hard to write scripts to collect and anaylis the
die reasons. So we'd better give die() a uniform preempt to make the
life of system administrators a bit easier.

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
index f18ca44c904b..00766e7ac077 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -393,6 +393,8 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 }
 NOKPROBE_SYMBOL(oops_end);
 
+#define DIE_PREEMPT	"DIE:\n"
+
 static void __die_header(const char *str, struct pt_regs *regs, long err)
 {
 	const char *pr = "";
@@ -405,8 +407,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	printk(KERN_DEFAULT
-	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
-	       pr,
+	       DIE_PREEMPT "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter, pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
-- 
2.43.0


