Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A0780A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376513AbjHRK7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376503AbjHRK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:59:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578B2708;
        Fri, 18 Aug 2023 03:59:42 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:59:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692356380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTv4pFh/msj/e8MHpeG2kjzzvgaMDjvc24xN0c1e9qg=;
        b=qWsFXKM5MC+Cx4VGLBTmhI9tmvLDsXnMOYvnhUYI7/aYB5FZDpnq/Kd1zKGXU5iJc88PW3
        iyDOo0UUOO4QSyBZnuuf/HhgINrWx3jDEbuo8DmeHZ28aK8UFrU0BKJ9Hc2oiVRhhhylFX
        ++MteJ8+EcNfO3ZMeb8greHdvtQtjprFxysm0GTcBQ32QYbxD6HSq8JdE0LQnuPMNRJ0i/
        HpCP5skskLCAHabS5YEPqV9Erw6R8iSJoO79Z0NNXR5/rcnATt3wtGJgc0okGrmR5mYYP4
        fTakhP//+5n9pJkZMTxi6UJTBNcgJ2jsw5zP5LOancnRzHVYjw3nIyZ1aMWBCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692356380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTv4pFh/msj/e8MHpeG2kjzzvgaMDjvc24xN0c1e9qg=;
        b=Fp3RXWFY46FvVC6veohOLS0749HkOise8lQ68uzROF0mHxEB3n3A0FsxNaRMLCUetEHP7S
        L+wgHCehxGrp5uCA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/srso: Correct the mitigation status when SMT is
 disabled
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814200813.p5czl47zssuej7nv@treble>
References: <20230814200813.p5czl47zssuej7nv@treble>
MIME-Version: 1.0
Message-ID: <169235637927.27769.12345029773512843447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6405b72e8d17bd1875a56ae52d23ec3cd51b9d66
Gitweb:        https://git.kernel.org/tip/6405b72e8d17bd1875a56ae52d23ec3cd51b9d66
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 15 Aug 2023 11:53:13 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 18 Aug 2023 12:43:10 +02:00

x86/srso: Correct the mitigation status when SMT is disabled

Specify how is SRSO mitigated when SMT is disabled. Also, correct the
SMT check for that.

Fixes: e9fbc47b818b ("x86/srso: Disable the mitigation on unaffected configurations")
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20230814200813.p5czl47zssuej7nv@treble
---
 arch/x86/kernel/cpu/bugs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9026e3f..f081d26 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2428,8 +2428,7 @@ static void __init srso_select_mitigation(void)
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
+		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
@@ -2714,7 +2713,7 @@ static ssize_t retbleed_show_state(char *buf)
 static ssize_t srso_show_state(char *buf)
 {
 	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
-		return sysfs_emit(buf, "Not affected\n");
+		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
