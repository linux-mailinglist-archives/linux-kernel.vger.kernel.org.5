Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5F812017
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442621AbjLMUhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:37:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E2B99;
        Wed, 13 Dec 2023 12:37:09 -0800 (PST)
Date:   Wed, 13 Dec 2023 20:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702499827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tdgEFmJtgiJ/hsWpMo64wL16sVk4He/t45frB5SOHw=;
        b=R+cuITriSuDmpM32izQ4dtf2ecIG7/QtBgWUJujQeiM2KLrch6Ytc5Fzmvt2NmJRfBpwfj
        PPq9GAbu+SCC6LxtEHhz8U2Uaaaa07H3t7nSsYlSKYmT/JGu8TDg0Kg5fv5d6gzgG2VU8J
        24D0tRrzwFP8/3jeYOsK/0iJT+HSBBSBsLrlXnnE1Fbq5KKNkTauhqioUJgc4nyE4WuSht
        epn6cLmGAWxu4GD15AXROHTZ3Y9BRfBno6J780UHGTPQtcyHA7A1HKALArmbgFBIAtMD99
        yjZYBoTThhz6ElSu0MVXWaKMCZBJ7WsU7BJ9y0W3ZMmtRCxb4ifa0Z0Mu0KyTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702499827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tdgEFmJtgiJ/hsWpMo64wL16sVk4He/t45frB5SOHw=;
        b=KlT+slEwlTUqXddfrYmCwENX1Vxkn9FkXTziZZ6+3CiQ+2VCoyNsd/YRLkAOZwGDVgVrW6
        Ay+9NHZMHWEdcbCA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Do the C-bit verification only on the BSP
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231130132601.10317-1-bp@alien8.de>
References: <20231130132601.10317-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170249982674.398.5844405041679284531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     30579c8baa5b4bd986420a984dad2940f1ff65d3
Gitweb:        https://git.kernel.org/tip/30579c8baa5b4bd986420a984dad2940f1ff65d3
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 30 Nov 2023 14:26:01 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 13 Dec 2023 21:07:56 +01:00

x86/sev: Do the C-bit verification only on the BSP

There's no need to do it on every AP.

The C-bit value read on the BSP and also verified there, is used
everywhere from now on.

No functional changes - just a bit faster booting APs.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20231130132601.10317-1-bp@alien8.de
---
 arch/x86/kernel/head_64.S | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3..d1dc39a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -114,6 +114,28 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	mov	%rax, %rdi
+	mov	%rax, %r14
+
+	addq	phys_base(%rip), %rdi
+
+	/*
+	 * For SEV guests: Verify that the C-bit is correct. A malicious
+	 * hypervisor could lie about the C-bit position to perform a ROP
+	 * attack on the guest by writing to the unencrypted stack and wait for
+	 * the next RET instruction.
+	 */
+	call	sev_verify_cbit
+
+	/*
+	 * Restore CR3 value without the phys_base which will be added
+	 * below, before writing %cr3.
+	 */
+	 mov	%r14, %rax
+#endif
+
 	jmp 1f
 SYM_CODE_END(startup_64)
 
@@ -193,15 +215,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	phys_base(%rip), %rax
 
 	/*
-	 * For SEV guests: Verify that the C-bit is correct. A malicious
-	 * hypervisor could lie about the C-bit position to perform a ROP
-	 * attack on the guest by writing to the unencrypted stack and wait for
-	 * the next RET instruction.
-	 */
-	movq	%rax, %rdi
-	call	sev_verify_cbit
-
-	/*
 	 * Switch to new page-table
 	 *
 	 * For the boot CPU this switches to early_top_pgt which still has the
