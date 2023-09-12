Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19B79CF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjILLJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjILLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:08:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008CE1732;
        Tue, 12 Sep 2023 04:08:33 -0700 (PDT)
Date:   Tue, 12 Sep 2023 11:08:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694516912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6z6FoePWAdjYwuSbIa2gAp7l1kBB9B/skm+SI3XrvE=;
        b=zZPteV87RgBufXVLfKK+GAHfxSFboemnhlT16QM/MmNjDW72NVhvEVxxKOhp8q3Uc9Os9a
        eOLoVZFXOf09cuPD+rytwWmBov9wkBJS8JJb8MfWtSXHQDb8bnqw04AVC+o5U3hF35NDdl
        g78i/u4mwmHD5eT1liRRxoO5uZig4DQuOWlgeSz7aUKzx8M2N1MC0a6J+8OWU4gwTCE2Th
        Jbb3MYnGViVysgT2V7Jp1ELpgRAvZNE4YqarjZJqoI6H/2mAUWF+gyxv3SMOBO3lnpjItq
        WheTLSohla2ep6b7ptneKIdnklb+5YvUcbU3YWcJPHS8fm7dX5sTOLLhca1Ysg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694516912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6z6FoePWAdjYwuSbIa2gAp7l1kBB9B/skm+SI3XrvE=;
        b=RgLxUNW8EChqVrX5fcsC9VlxPWm2qlf3Ak4XNIhHnlzvrdquFq3ZquJSZMPXwmC9KyzEmU
        QETXQEi6XWjOpKCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()
Cc:     David Kaplan <David.Kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230802110323.086971726@infradead.org>
References: <20230802110323.086971726@infradead.org>
MIME-Version: 1.0
Message-ID: <169451691192.27769.584862233902801314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1666863f28d7c490fa62ed5d1dfb1ba31453dc98
Gitweb:        https://git.kernel.org/tip/1666863f28d7c490fa62ed5d1dfb1ba31453dc98
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Aug 2023 12:55:47 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Tue, 12 Sep 2023 12:40:28 +02:00

x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()

Commit cb855971d717 ("x86/putuser: Provide room for padding") changed
__put_user_nocheck_*() into proper functions but failed to note that
SYM_FUNC_START() already provides ENDBR, rendering the explicit ENDBR
superfluous.

Fixes: cb855971d717 ("x86/putuser: Provide room for padding")
Reported-by: David Kaplan <David.Kaplan@amd.com>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230802110323.086971726@infradead.org
---
 arch/x86/lib/putuser.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 1451e0c..235bbda 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -56,7 +56,6 @@ SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
 SYM_FUNC_START(__put_user_nocheck_1)
-	ENDBR
 	ASM_STAC
 2:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,7 +75,6 @@ SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
 SYM_FUNC_START(__put_user_nocheck_2)
-	ENDBR
 	ASM_STAC
 4:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -96,7 +94,6 @@ SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
 SYM_FUNC_START(__put_user_nocheck_4)
-	ENDBR
 	ASM_STAC
 6:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -119,7 +116,6 @@ SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 SYM_FUNC_START(__put_user_nocheck_8)
-	ENDBR
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
