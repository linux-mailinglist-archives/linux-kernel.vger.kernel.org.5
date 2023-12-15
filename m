Return-Path: <linux-kernel+bounces-1504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D45814F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DB61F2199B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF32830137;
	Fri, 15 Dec 2023 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TzQ1dA8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yt5bl1GU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB630129;
	Fri, 15 Dec 2023 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Dec 2023 18:09:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702663799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g6WxWSr9My4EqInVfw9NRhqNdCjVoy5l5OLWMaXqDD4=;
	b=1TzQ1dA85+4kXIccjiUhT2CD2sLuibuO8rAnwABdyM5uGkYyvDDPQ7UsOJgBiiV83y81yu
	MfN5XqzzIG6vpd/n6QqMk7Fz+xJ8vuwuLRjCtGWY7S3QGk/mLA+mx2ri1Pcibiw6i1GtDb
	flh7brcXNIGJ50Zzk72nq095hGBM1HcTdxovGeaQj3fwAWPhuz85qQXoKlo78sYjXMy8qJ
	2oEnDKFp8LyALbK4rf2FFK8V4STh/ATvQQGdydXewMY1XGeUxsJVB6nuYmwY9eplamKteR
	Efu5CReik8e2lgMlhH3voWIEnwZ+ivs5lweM5uncpS93K+oR+mVr+s+ZAgcWTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702663799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g6WxWSr9My4EqInVfw9NRhqNdCjVoy5l5OLWMaXqDD4=;
	b=yt5bl1GUlWg7Ua7cgwSDwh7sHBFs6smKzoMyxuY2fhBnrI/3qGMxr850jjS29FUDe/j7UH
	6o2TLcZTHw7axXDQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/percpu: Use %RIP-relative address in untagged_addr()
Cc: Uros Bizjak <ubizjak@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradaed.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170266379864.398.7891451489965815897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     91c17d7b04498ffb52939a18eb7e28fd23c9b654
Gitweb:        https://git.kernel.org/tip/91c17d7b04498ffb52939a18eb7e28fd23c9b654
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 13 Dec 2023 16:03:15 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 15 Dec 2023 09:50:14 -08:00

x86/percpu: Use %RIP-relative address in untagged_addr()

%RIP-relative addresses are nowadays correctly handled in alternative
instructions, so remove misleading comment and improve assembly to
use %RIP-relative address.

Also, explicitly using %gs: prefix will segfault for non-SMP builds.
Use macros from percpu.h which will DTRT with segment prefix register
as far as SMP/non-SMP builds are concerned.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradaed.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20231213150357.5942-1-ubizjak%40gmail.com
---
 arch/x86/include/asm/uaccess_64.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4..01455c0 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -11,6 +11,7 @@
 #include <asm/alternative.h>
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
+#include <asm/percpu.h>
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -18,14 +19,10 @@
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	/*
-	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
-	 * in alternative instructions. The relocation gets wrong when gets
-	 * copied to the target place.
-	 */
 	asm (ALTERNATIVE("",
-			 "and %%gs:tlbstate_untag_mask, %[addr]\n\t", X86_FEATURE_LAM)
-	     : [addr] "+r" (addr) : "m" (tlbstate_untag_mask));
+			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
+	     : [addr] "+r" (addr)
+	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
 
 	return addr;
 }

