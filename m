Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8AC7A5EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjISJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjISJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8CD198;
        Tue, 19 Sep 2023 02:53:10 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:53:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695117188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzgA9F8IwwfNo7xjrqDlG248CoeZfGOO7kNYjMLnXRo=;
        b=gBe2BZmrnTAitWIhmuAglpi7IW7t9ffhaA0E5GYV+C48R4VVB/idFanyMjI2qLGo5Oeg/7
        V0EWH7d5ngj2d1oEo7ZXyk6s0CwQgMLYNUUlF4+XgN4XxhPL9ZVkpLs26qhtfRTMUvwRNM
        YHYWJz4Q3OTmrd/wwnl5PCGm5O2Kdp14mzX1fefGL2IOUUgMqeFwa+53CAJTUXCu8bFfCZ
        yS+3jKRoxQNOADJI6VITMHcVDUpdym9izlV905WcEVpQX4UcSulShl0voUqS7jGUOtc4/z
        EpTdvpsB77kB8BPIw8za0gVa+ciAU7qGDHQg5kdwPKEjFzso0LnxAubz9WKkzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695117188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzgA9F8IwwfNo7xjrqDlG248CoeZfGOO7kNYjMLnXRo=;
        b=XVRxcuYJX3i92obM/6IHAnWHTUrGLxoTppR9JbZwdMbITrKy4sZMeQEbA9qaszs6D+lxfy
        k6K0uUADD/8fbEDA==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Ingo Molnar <mingo@kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230819080921.5324-2-jo.vanbulck@cs.kuleuven.be>
References: <20230819080921.5324-2-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Message-ID: <169511718771.27769.15019317036773813903.tip-bot2@tip-bot2>
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

Commit-ID:     f75a0e70ed379019b209cdb591ffbfe2fbf4342f
Gitweb:        https://git.kernel.org/tip/f75a0e70ed379019b209cdb591ffbfe2fbf4342f
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Sat, 19 Aug 2023 10:09:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Sep 2023 11:42:48 +02:00

x86/pti: Fix kernel warnings for pti= and nopti cmdline options

Parse the pti= and nopti cmdline options using early_param to fix 'Unknown
kernel command line parameters "nopti", will be passed to user space'
warnings in the kernel log when nopti or pti= are passed to the kernel
cmdline on x86 platforms.

Additionally allow the kernel to warn for malformed pti= options.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
