Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7A774AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjHHUdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjHHUc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:32:29 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6B65B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:56:46 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: F404F2005A.A3714
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id F404F2005A;
        Tue,  8 Aug 2023 21:56:41 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691524601;
        bh=YcH4Fg8CUorp1vXIDgTjg2krAfCLOYoN7h6ArsaNswo=;
        h=From:To:Cc:Subject:Date;
        b=Czh0JcdLmMopZXkc9Kcmzs4UT1Kln8gnXzSMQTp5IUm4ZyNNwYYJnGYDwwXyGnbv/
         nis0Waq0F1zBXDh7mvZV8YqmdZmC9QBxTOjhR3D7OadboMslO7s8LQG3l5BkMnTcgf
         4+qmPugUs3xr0jlMJRxGLN5Ik6kc8oJRrZe0kljE=
Received: from localhost.localdomain (rrcs-24-123-120-98.central.biz.rr.com [24.123.120.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 39D54D4F7B7AA;
        Tue,  8 Aug 2023 21:56:38 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH RESEND] x86/pti: Fix kernel warnings for pti= and nopti cmdline options.
Date:   Tue,  8 Aug 2023 12:56:15 -0700
Message-Id: <20230808195615.9795-1-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the pti= and nopti cmdline options using early_param to fix 'Unknown
kernel command line parameters "nopti", will be passed to user space'
warnings in the kernel log when nopti or pti= are passed to the kernel
cmdline on x86 platforms. Additionally allow the kernel to warn for
malformed pti= options.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---

Resending this as I haven't heard back yet. I'd be happy to incorporate any
feedback.

Also adding test output before/after patch for reference:

dmesg | grep -e "page tables isolation" -e "Command line" \
             -e "Malformed" -e "Unknown kernel command line parameters" \
             && cat /sys/devices/system/cpu/vulnerabilities/meltdown

Before patch
============

KERNEL_CMDLINE="nopti"
 [    0.000000] Command line: root=/dev/vda console=ttyS0 nopti
 [    0.009875] Kernel/User page tables isolation: disabled on command line.
 [    0.021498] Unknown kernel command line parameters "nopti", will be passed to user space.
 Vulnerable

KERNEL_CMDLINE="pti=off"
 [    0.000000] Command line: root=/dev/vda console=ttyS0 pti=off
 [    0.009564] Kernel/User page tables isolation: disabled on command line.
 [    0.019542] Unknown kernel command line parameters "pti=off", will be passed to user space.
 Vulnerable

KERNEL_CMDLINE="pti=invalid"
 [    0.000000] Command line: root=/dev/vda console=ttyS0 pti=invalid
 [    0.021409] Unknown kernel command line parameters "pti=invalid", will be passed to user space.
 [    0.022411] Kernel/User page tables isolation: enabled
 Mitigation: PTI

After patch
===========

KERNEL_CMDLINE="nopti"
 [    0.000000] Command line: root=/dev/vda console=ttyS0 nopti
 [    0.009775] Kernel/User page tables isolation: disabled on command line.
 Vulnerable

KERNEL_CMDLINE="pti=off"
 [    0.000000] Command line: root=/dev/vda console=ttyS0 pti=off
 [    0.009879] Kernel/User page tables isolation: disabled on command line.
 Vulnerable

KERNEL_CMDLINE="pti=invalid"
 [    0.000000] Command line: root=/dev/vda console=ttyS0 pti=invalid
 [    0.000000] Malformed early option 'pti'
 [    0.020892] Kernel/User page tables isolation: enabled
 Mitigation: PTI


 arch/x86/mm/pti.c | 56 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 78414c6d1..ea5841cf9 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -69,6 +69,7 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
+/* Assume mode is auto unless overridden via cmdline below */
 static enum pti_mode {
 	PTI_AUTO = 0,
 	PTI_FORCE_OFF,
@@ -77,50 +78,47 @@ static enum pti_mode {
 
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
+	if (pti_mode == PTI_FORCE_OFF || cpu_mitigations_off()) {
 		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on command line.");
 		return;
 	}
 
-autosel:
-	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+	if (pti_mode == PTI_AUTO && !boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return;
-enable:
+
+	if (pti_mode == PTI_FORCE_ON)
+		pti_print_if_secure("force enabled on command line.");
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

base-commit: 1399419a8db7b3d6083b47062358d95dc8ec9663
-- 
2.25.1

