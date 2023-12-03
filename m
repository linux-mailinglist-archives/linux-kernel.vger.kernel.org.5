Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6678022A7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjLCLP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:15:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3CA2;
        Sun,  3 Dec 2023 03:16:00 -0800 (PST)
Date:   Sun, 03 Dec 2023 11:15:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701602158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ+VBXklhmVch7Sg2vc0ARJ1AeCnK1tBH54ISC203KI=;
        b=aCiqE0gJlIwkgJbAP7VryY/SfHO2newtiJlJsbMsBdAnC/qthTaU+JRoXoakp9XrGLjxVD
        UnEILmt5H9vLjrjwuv/w3P572/pbDUrEx1aC6aqsWx3NMCsARcVf8No7J1Cce392F5Q89t
        GbK2ZTyP4MzgKOewnNDxuGFQLNaxIjCH2J82hTiZQjh5Pt7UqQ1QjFAhb7mGVbBVsrX5Pd
        8l/roLWkOqK9opU9Au0KWdgqseAbZnezB4Hchmmz75LJFsiH9sMK+Y7dbwYHPDMTUCBEo7
        qpm4yooV0Eh0WzlflzZ03nNxibLdmfSAf7Ti6aqMiUJozc/utyPXHaYj0XMvww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701602158;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ+VBXklhmVch7Sg2vc0ARJ1AeCnK1tBH54ISC203KI=;
        b=8JGd6ffJHHd6dgW56m4o+GfX6/Rt1zNYXkDBMR1PopCo2xT98Ho9XXGQBYkgWUfimrFjgN
        nOiqMeAHSH4LWkCA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Set new revision only after
 a successful update
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
References: <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Message-ID: <170160215680.398.309337215455167122.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9c21ea53e6bd1104c637b80a0688040f184cc761
Gitweb:        https://git.kernel.org/tip/9c21ea53e6bd1104c637b80a0688040f184cc761
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 01 Dec 2023 14:35:06 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 03 Dec 2023 11:49:53 +01:00

x86/microcode/intel: Set new revision only after a successful update

This was meant to be done only when early microcode got updated
successfully. Move it into the if-branch.

Also, make sure the current revision is read unconditionally and only
once.

Fixes: 080990aa3344 ("x86/microcode: Rework early revisions reporting")
Reported-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5d6ea87..857e608 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -370,14 +370,14 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 {
 	struct cpio_data cp;
 
+	intel_collect_cpu_info(&uci->cpu_sig);
+
 	if (!load_builtin_intel_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	intel_collect_cpu_info(&uci->cpu_sig);
-
 	return scan_microcode(cp.data, cp.size, uci, save);
 }
 
@@ -410,13 +410,13 @@ void __init load_ucode_intel_bsp(struct early_load_data *ed)
 {
 	struct ucode_cpu_info uci;
 
-	ed->old_rev = intel_get_microcode_revision();
-
 	uci.mc = get_microcode_blob(&uci, false);
-	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
-		ucode_patch_va = UCODE_BSP_LOADED;
+	ed->old_rev = uci.cpu_sig.rev;
 
-	ed->new_rev = uci.cpu_sig.rev;
+	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED) {
+		ucode_patch_va = UCODE_BSP_LOADED;
+		ed->new_rev = uci.cpu_sig.rev;
+	}
 }
 
 void load_ucode_intel_ap(void)
