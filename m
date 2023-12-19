Return-Path: <linux-kernel+bounces-5263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC58188B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971751F249B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09D19473;
	Tue, 19 Dec 2023 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="imOW/Kw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yh1ORP8r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866621945A;
	Tue, 19 Dec 2023 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Dec 2023 13:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702992819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZu7+f4jqN8y26ObwbxjE93jUOV36LfTZnAHKob9k4E=;
	b=imOW/Kw1Cwl4ft0SmPPotxwsLhzNtOJYRjZA6zXjpcqzXHoys1seC77an5JxyBoR2yXahc
	bVGh6jcLXJI3JmwloAyAHp6eqqt9TST6km1Ow4MrXNI2EIP9Bz4HcRqZUdOCjz790hHCtC
	6hjdulJNDmjUZloDSgp01skI6GuuFfj0ErzDa8q5B6rJx1PysLfJ76NhumvYuf/X8p4UHR
	Aj6G6qC+B6s8Ts6E4ekadE3Emg6CAeG64s4/wY0+TdTQ3YTMIFCPuErHsQtW7C3I63Doru
	9YYmTzPkvlQB0a/H+GkM7fRmN3S3YTnXJH6/M5QznVDEcI9BLUBD92Cn2iOAzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702992819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZu7+f4jqN8y26ObwbxjE93jUOV36LfTZnAHKob9k4E=;
	b=Yh1ORP8rnd+BcBQzUcb0Rf5akvwDcI9uEr6uHBLzPWCSrKbDtQ8Z5B0Ka3vD7M9OSBKbfl
	UbilJhA2v4m5yJDg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/alternatives: Move apply_relocation() out of
 init section
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231204072856.1033621-1-arnd@kernel.org>
References: <20231204072856.1033621-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170299281805.398.14125432177983046398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     86ed430cf5296ca97a66f1f37e30b7dfe47cd36f
Gitweb:        https://git.kernel.org/tip/86ed430cf5296ca97a66f1f37e30b7dfe47cd36f
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 04 Dec 2023 08:28:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Dec 2023 14:21:49 +01:00

x86/alternatives: Move apply_relocation() out of init section

This function is now called from a few places that are no __init_or_module,
resulting a link time warning:

  WARNING: modpost: vmlinux: section mismatch in reference: patch_dest+0x8a (section: .text) -> apply_relocation (section: .init.text)

Remove the annotation here.

[ mingo: Also sync up add_nop() with these changes. ]

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20231204072856.1033621-1-arnd@kernel.org
---
 arch/x86/kernel/alternative.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5052371..1781e02 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL_GPL(alternatives_patched);
 #define DA_ENDBR	0x08
 #define DA_SMP		0x10
 
-static unsigned int __initdata_or_module debug_alternative;
+static unsigned int debug_alternative;
 
 static int __init debug_alt(char *str)
 {
@@ -132,7 +132,7 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
  * each single-byte NOPs). If @len to fill out is > ASM_NOP_MAX, pad with INT3 and
  * *jump* over instead of executing long and daft NOPs.
  */
-static void __init_or_module add_nop(u8 *instr, unsigned int len)
+static void add_nop(u8 *instr, unsigned int len)
 {
 	u8 *target = instr + len;
 
@@ -206,7 +206,7 @@ static int skip_nops(u8 *instr, int offset, int len)
  * Optimize a sequence of NOPs, possibly preceded by an unconditional jump
  * to the end of the NOP sequence into a single NOP.
  */
-static bool __init_or_module
+static bool
 __optimize_nops(u8 *instr, size_t len, struct insn *insn, int *next, int *prev, int *target)
 {
 	int i = *next - insn->length;
@@ -325,7 +325,7 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 	return (target < src || target > src + src_len);
 }
 
-void __init_or_module apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
+void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 {
 	int prev, target = 0;
 

