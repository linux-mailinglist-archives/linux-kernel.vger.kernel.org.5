Return-Path: <linux-kernel+bounces-2188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580C815921
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316A3285E84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970C4219F9;
	Sat, 16 Dec 2023 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IdnFIlEC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQjA0Sjj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1714005;
	Sat, 16 Dec 2023 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 16 Dec 2023 12:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702731531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWTL02ik7kDn5fM6Msulg+dYgLYIyO6t+MXOT8Sr/W8=;
	b=IdnFIlEC6v6C7RRP9xecw1o+PryswOcAbnAskqkESHXpAed6is9xeU039qlvGF5cEku/0E
	HoI5GOD4K+N39H5mMB1KIhYwxI9X9t8uIt2zMuQxLDQ0pCLytwI7UzCEvGekClSGSDcvQA
	sOlZz9wpDOo9G3Dtqb/QdtfBGYQkghrN1T4iDroRVMaCIEBABzqaQgrPLIv/a+ysHT+osY
	TOBItk8peGjt2LCPsduw3pLACzj05DVLoVyaMYRi29aZD6MTcDbZt1MRJvAVio3+uB6/9Y
	yDJYk7mn7AyKAuDwKQRHJUUgWtaQPRP67yHwiH5IdETvv+HXzImxpvVlE7b3hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702731531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWTL02ik7kDn5fM6Msulg+dYgLYIyO6t+MXOT8Sr/W8=;
	b=oQjA0SjjJtI+Nvrq2ZFz/P4fCf0+YgBobOxrBxi9oVtjjD/r2vdMxnFGcPbeoexDxspnUr
	CqczHNmVZoZG/9DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternatives: Disable interrupts and sync when
 optimizing NOPs in place
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZT6narvE%2BLxX%2B7Be@windriver.com>
References: <ZT6narvE%2BLxX%2B7Be@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170273153061.398.13274192737128400603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2dc4196138055eb0340231aecac4d78c2ec2bea5
Gitweb:        https://git.kernel.org/tip/2dc4196138055eb0340231aecac4d78c2ec2bea5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 07 Dec 2023 20:49:26 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Dec 2023 19:34:42 +01:00

x86/alternatives: Disable interrupts and sync when optimizing NOPs in place

apply_alternatives() treats alternatives with the ALT_FLAG_NOT flag set
special as it optimizes the existing NOPs in place.

Unfortunately, this happens with interrupts enabled and does not provide any
form of core synchronization.

So an interrupt hitting in the middle of the update and using the affected code
path will observe a half updated NOP and crash and burn. The following
3 NOP sequence was observed to expose this crash halfway reliably under QEMU
  32bit:

   0x90 0x90 0x90

which is replaced by the optimized 3 byte NOP:

   0x8d 0x76 0x00

So an interrupt can observe:

   1) 0x90 0x90 0x90		nop nop nop
   2) 0x8d 0x90 0x90		undefined
   3) 0x8d 0x76 0x90		lea    -0x70(%esi),%esi
   4) 0x8d 0x76 0x00		lea     0x0(%esi),%esi

Where only #1 and #4 are true NOPs. The same problem exists for 64bit obviously.

Disable interrupts around this NOP optimization and invoke sync_core()
before re-enabling them.

Fixes: 270a69c4485d ("x86/alternative: Support relocations in alternatives")
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/ZT6narvE%2BLxX%2B7Be@windriver.com
---
 arch/x86/kernel/alternative.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index fd44739..aae7456 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -255,6 +255,16 @@ static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 	}
 }
 
+static void __init_or_module noinline optimize_nops_inplace(u8 *instr, size_t len)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	optimize_nops(instr, len);
+	sync_core();
+	local_irq_restore(flags);
+}
+
 /*
  * In this context, "source" is where the instructions are placed in the
  * section .altinstr_replacement, for example during kernel build by the
@@ -438,7 +448,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			optimize_nops(instr, a->instrlen);
+			optimize_nops_inplace(instr, a->instrlen);
 			continue;
 		}
 

