Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99120811236
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjLMNAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjLMNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C046FE;
        Wed, 13 Dec 2023 05:00:04 -0800 (PST)
Date:   Wed, 13 Dec 2023 13:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702472402;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+IhSpyWTQ/axW+CWLsdfkEGbDn1Jz0prTjI1ZqS1To=;
        b=NLSslS5ICLrIG0BxDdoCbbqWBzKURefiIdkAqp6AELB3x5kzY4lWsUyRN7BicbAdIU3P5r
        aeFGCVmK3Md/cgpu/PO2HltA7v6oi0PU5hWwao0rvj18HBA6yctmmpeKjIq4A3XJ6vXde0
        DEQuAKfPyKuwUMBsM34WdojmVhTp5X/8WjsrODHpRJEkkJfOypVwGuYYhMuacU857nR5tT
        K+LP6/YxDFTHdAGvXLTTm4F2N/amBoBlnmQDGq//NofKk+oSgmU4Hh8kzKw42WXyeeQLAC
        aiRIq3LUSFICZrBAFqisMau5uGVjs6BDccWjQhDcG3w72hQb+7qR9ngoDjjK7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702472402;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+IhSpyWTQ/axW+CWLsdfkEGbDn1Jz0prTjI1ZqS1To=;
        b=ycDsrcYyqZcAmxl5g3k2nWUHrcDtAlf3ykcleR3oWS7Olx3enzWBCxQmyj8+7/DezZ37So
        uPg3HAvwqWdZQCDA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/head_64: Use TESTB instead of TESTL in
 secondary_startup_64_no_verify()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231109201032.4439-1-ubizjak@gmail.com>
References: <20231109201032.4439-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170247240126.398.13145604902928035582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7d28365a06af74cee015a448d32ab6e98cd05cfb
Gitweb:        https://git.kernel.org/tip/7d28365a06af74cee015a448d32ab6e98cd05cfb
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 09 Nov 2023 21:09:56 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 13 Dec 2023 13:35:38 +01:00

x86/head_64: Use TESTB instead of TESTL in secondary_startup_64_no_verify()

There is no need to use TESTL when checking the least-significant bit
with a TEST instruction. Use TESTB, which is three bytes shorter:

   f6 05 00 00 00 00 01    testb  $0x1,0x0(%rip)

vs:

   f7 05 00 00 00 00 01    testl  $0x1,0x0(%rip)
   00 00 00

for the same effect.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231109201032.4439-1-ubizjak@gmail.com
---
 arch/x86/kernel/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3..1f79d80 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -182,7 +182,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Enable PAE mode, PSE, PGE and LA57 */
 	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
-	testl	$1, __pgtable_l5_enabled(%rip)
+	testb	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
 	orl	$X86_CR4_LA57, %ecx
 1:
