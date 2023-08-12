Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE877A0ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHLPza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHLPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:55:28 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA03E4D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:55:30 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: B958778.A37F6
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id B958778;
        Sat, 12 Aug 2023 17:55:27 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691855727;
        bh=6nS6t7LE/q4vTlscwIdQmPCVuyRCVQjUtrkAkC5xhjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CnI+buvg5YTxI8zWV7WHnq0+4Za6BmbbfvoRKlKzbzvdbDGeafCzFV/iGpfWcR65V
         bnebKlKMRi2a+iWzOGy5rBUP8z2VvhqhWTNZntPulF3ELNR37/75N7RK+i3ckkrQiU
         JNaqdGPlBeaRVsTpl8GlB6np9jt32KoI2wy3F6dM=
Received: from localhost.localdomain (rrcs-24-123-120-98.central.biz.rr.com [24.123.120.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 68094D4EBEB51;
        Sat, 12 Aug 2023 17:55:25 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        sohil.mehta@intel.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti cmdline options.
Date:   Sat, 12 Aug 2023 08:54:48 -0700
Message-Id: <20230812155448.8865-2-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812155448.8865-1-jo.vanbulck@cs.kuleuven.be>
References: <20230812155448.8865-1-jo.vanbulck@cs.kuleuven.be>
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

Link: https://lore.kernel.org/all/b9bbb279-fa8f-0784-900f-114ce186cbb3@intel.com/
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
---
 arch/x86/mm/pti.c | 55 ++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 78414c6d1..7575e224d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -69,6 +69,7 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
+/* Assume mode is auto unless overridden via cmdline below. */
 static enum pti_mode {
 	PTI_AUTO = 0,
 	PTI_FORCE_OFF,
@@ -77,50 +78,50 @@ static enum pti_mode {
 
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
+	if (pti_mode == PTI_FORCE_ON) {
+		pti_print_if_secure("force enabled on command line.");
+		goto enable;
+	}
 
-autosel:
 	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return;
 enable:
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
-- 
2.25.1

