Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8277FF015
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjK3N0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjK3N0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:26:20 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570FD6C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:26:26 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BFFBD40E01AD;
        Thu, 30 Nov 2023 13:26:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zEjcqjdd30NV; Thu, 30 Nov 2023 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701350779; bh=00uVXfqqn+YrBcGvtEVE8xhk3/iP9v80Y1vQ6wiIiB8=;
        h=From:To:Cc:Subject:Date:From;
        b=NlsdJBbrCDTERx0h/P/9ERaCMRYcQdFv26qoWWGNjozAolwkvpxf1a5EprP/Ib3nu
         G+jRpYxs3PT3vqEC0TCUh4hEAZ6xRpUTzlcnvY9WgjMlQ6dLzXwTPpaLQkAD1ilqbs
         FNiwb6w1whzljtN6ToLmEFXAXjaXayFo4nPzp6c0mZRPKJTmUSV8wHC/hFFYtVEhb+
         rcIQjDkWPulJ2pCJldM4KIt7j+UG3lBtGMdkL1h3XLaIUbTDQkK2Y5n9mVDq+4ZvLO
         enytIKsVG4wgJZF82n5uqoD9tMjPeNyaTgvastwVfamjj17PjDzFUn9b0VHiGeCeXP
         vLJsT5EDdcQrR+eVsUJDdD7UMc93aWMdm/DK0r0GVX8whP0K2wyYpnTUta7uBGbeZN
         1gv1f8uigACDed/fLCEZ9Ysi6Es85TPCIUzvjLkVQdJKJBLM6VuenUjUGqrOtpfUqR
         qlqtIn6nRA/lCyPKgtHa5RvUhxVchzctsOR0ENZnw2Gaof1Bz7wY2i1MwjF5kDcHK5
         6j/zcyVDX7K+q0qAuZ5zmHydjB4X0SZNSdOmzbo8PmwnhvtOjM3vXspB4oxh2Q44LL
         bmLBZtMTmkOQkLSa12AsdPatf8yJU3jIiNdkLuXJ5EvqN0NwkSCC3VIHvLK6YAxzzV
         rvfTYo716sqHu5+YAtx9I1PQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1166440E0173;
        Thu, 30 Nov 2023 13:26:15 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: Do the C-bit verification only on the BSP
Date:   Thu, 30 Nov 2023 14:26:01 +0100
Message-ID: <20231130132601.10317-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

There's no need to do it on every AP.

The C-bit value read on the BSP and also verified there, is used
everywhere from now on.

There should be no functional changes resulting from this patch - just
a bit faster booting APs.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/head_64.S | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3dcabbc49149..af40d8eb4dca 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -114,6 +114,28 @@ SYM_CODE_START_NOALIGN(startup_64)
=20
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
=20
@@ -192,15 +214,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
 	/* Setup early boot stage 4-/5-level pagetables. */
 	addq	phys_base(%rip), %rax
=20
-	/*
-	 * For SEV guests: Verify that the C-bit is correct. A malicious
-	 * hypervisor could lie about the C-bit position to perform a ROP
-	 * attack on the guest by writing to the unencrypted stack and wait for
-	 * the next RET instruction.
-	 */
-	movq	%rax, %rdi
-	call	sev_verify_cbit
-
 	/*
 	 * Switch to new page-table
 	 *
--=20
2.42.0.rc0.25.ga82fb66fed25

