Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090F7D0E95
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377197AbjJTLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377148AbjJTLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03EBD49;
        Fri, 20 Oct 2023 04:37:17 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQGEIy1LdKfqt2kfVkFuk9/fT9Gj/V/gTHu5P6ProZw=;
        b=Yio8fp8trObEnrzlrfSAxf0FkSFTT4Qw5F8yq3UOr2Hs1tIr42ydenD0x0OsjQO9WVwryA
        OuSY35kgEBfPGUaqhjWOMvPVX6njrw0HWA65NNM4MDbxbnJCLlQ1eE5QqgCB+6+zpa0z0T
        RGQhXKzxGTmljWKCYodmOaCWpDZEseUwolO2TEbwotfumE5xlSvLRlimNly6dBayHbTISi
        GrdRTjZJn1BUDICurqJhVfNnRJDMKkk8eGfLzlCXK4vKzSdLjuRiSXtGv74P+5cj1WLZAM
        BwbBDX/Xg78oxrpyJafumpqJSBL6SDMGp3yXFaC9I3LcPdp2QiUmBmL77eOLOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQGEIy1LdKfqt2kfVkFuk9/fT9Gj/V/gTHu5P6ProZw=;
        b=SIhM691drJFG6ssreCf387yGLG+5j6JtodnMaXQotsF6z/7B1nGmVYMEVCbvo0Rvbmq964
        a7zU590SWrjm3MAw==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230819080921.5324-2-jo.vanbulck@cs.kuleuven.be>
References: <20230819080921.5324-2-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Message-ID: <169780183596.3135.4427078331601256934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     0bd7feb2df7ef092c6b8914acca706fb21826f80
Gitweb:        https://git.kernel.org/tip/0bd7feb2df7ef092c6b8914acca706fb21826f80
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Sat, 19 Aug 2023 10:09:21 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 12:50:14 +02:00

x86/pti: Fix kernel warnings for pti= and nopti cmdline options

Parse the pti= and nopti cmdline options using early_param to fix 'Unknown
kernel command line parameters "nopti", will be passed to user space'
warnings in the kernel log when nopti or pti= are passed to the kernel
cmdline on x86 platforms.

Additionally allow the kernel to warn for malformed pti= options.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20230819080921.5324-2-jo.vanbulck@cs.kuleuven.be
---
 arch/x86/mm/pti.c | 58 +++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 78414c6..5dd7339 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -69,6 +69,7 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
+/* Assume mode is auto unless overridden via cmdline below. */
 static enum pti_mode {
 	PTI_AUTO = 0,
 	PTI_FORCE_OFF,
@@ -77,50 +78,49 @@ static enum pti_mode {
 
 void __init pti_check_boottime_disable(void)
 {
-	char arg[5];
-	int ret;
-
-	/* Assume mode is auto unless overridden. */
-	pti_mode = PTI_AUTO;
-
 	if (hypervisor_is_type(X86_HYPER_XEN_PV)) {
 		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on XEN PV.");
 		return;
 	}
 
-	ret = cmdline_find_option(boot_command_line, "pti", arg, sizeof(arg));
-	if (ret > 0)  {
-		if (ret == 3 && !strncmp(arg, "off", 3)) {
-			pti_mode = PTI_FORCE_OFF;
-			pti_print_if_insecure("disabled on command line.");
-			return;
-		}
-		if (ret == 2 && !strncmp(arg, "on", 2)) {
-			pti_mode = PTI_FORCE_ON;
-			pti_print_if_secure("force enabled on command line.");
-			goto enable;
-		}
-		if (ret == 4 && !strncmp(arg, "auto", 4)) {
-			pti_mode = PTI_AUTO;
-			goto autosel;
-		}
-	}
-
-	if (cmdline_find_option_bool(boot_command_line, "nopti") ||
-	    cpu_mitigations_off()) {
+	if (cpu_mitigations_off())
 		pti_mode = PTI_FORCE_OFF;
+	if (pti_mode == PTI_FORCE_OFF) {
 		pti_print_if_insecure("disabled on command line.");
 		return;
 	}
 
-autosel:
-	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+	if (pti_mode == PTI_FORCE_ON)
+		pti_print_if_secure("force enabled on command line.");
+
+	if (pti_mode == PTI_AUTO && !boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return;
-enable:
+
 	setup_force_cpu_cap(X86_FEATURE_PTI);
 }
 
+static int __init pti_parse_cmdline(char *arg)
+{
+	if (!strcmp(arg, "off"))
+		pti_mode = PTI_FORCE_OFF;
+	else if (!strcmp(arg, "on"))
+		pti_mode = PTI_FORCE_ON;
+	else if (!strcmp(arg, "auto"))
+		pti_mode = PTI_AUTO;
+	else
+		return -EINVAL;
+	return 0;
+}
+early_param("pti", pti_parse_cmdline);
+
+static int __init pti_parse_cmdline_nopti(char *arg)
+{
+	pti_mode = PTI_FORCE_OFF;
+	return 0;
+}
+early_param("nopti", pti_parse_cmdline_nopti);
+
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	/*
