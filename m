Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BE7D11AA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377559AbjJTOg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377527AbjJTOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:36:27 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F906D5E;
        Fri, 20 Oct 2023 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Z/6zKPKF3hdIP4o+3v8/dUx6MorHqNGqLwm78ILSxho=; b=pyHF96wxzujXx9RrIKtrBWqiF3
        6vSMOQOaaD2cWlmevMRYIH6ElggbIoNHqQOp7z56/FaFfRBTWNabSYakdTpWdmXKyeAcpkC78G/3o
        i18hC83J4eS6+XH6izx8c43WYdQU98HR/SrWSAaEPczRVrS2saRIf1EA02U5Bjpyd2L1IPGOA9XnT
        6pV3cLgYFQpaOfvQMySHh3R1zuaK3JptXC7zTdQ8qwwSG8cFHtxxE8/B30Ha7G/qH1TgwvzxX62f0
        zPgcKAyv31Hcz7ub4U5lS//kfSaNkNgzkC4CjLX8za/cNCnANKs5n3XWoP6oVcGSdaABSSUFHWSC9
        55ajVsIA==;
Received: from [192.168.13.184] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qtqbu-003A2x-86; Fri, 20 Oct 2023 16:36:22 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-alpha@vger.kernel.org, mattst88@gmail.com,
        ink@jurassic.park.msu.ru, richard.henderson@linaro.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, macro@orcam.me.uk,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH V6] alpha: Clean-up the panic notifier code
Date:   Fri, 20 Oct 2023 16:34:54 +0200
Message-ID: <20231020143616.23082-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alpha panic notifier has some code issues, not following
the conventions of other notifiers. Also, it might halt the
machine but still it is set to run as early as possible, which
doesn't seem to be a good idea.

So, let's clean the code and set the notifier to run as the
latest, following the same approach other architectures are
doing.

Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V6:
- Dropped the include removal (thanks Maciej/Petr!)
- Rebased on top of v6.6-rc6 

 arch/alpha/kernel/setup.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index c80258ec332f..8397ef1d4e11 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -47,13 +47,6 @@
 #include <linux/log2.h>
 #include <linux/export.h>
 
-static int alpha_panic_event(struct notifier_block *, unsigned long, void *);
-static struct notifier_block alpha_panic_block = {
-	alpha_panic_event,
-        NULL,
-        INT_MAX /* try to do it first */
-};
-
 #include <linux/uaccess.h>
 #include <asm/hwrpb.h>
 #include <asm/dma.h>
@@ -434,6 +427,21 @@ static const struct sysrq_key_op srm_sysrq_reboot_op = {
 };
 #endif
 
+static int alpha_panic_event(struct notifier_block *this,
+			     unsigned long event, void *ptr)
+{
+	/* If we are using SRM and serial console, just hard halt here. */
+	if (alpha_using_srm && srmcons_output)
+		__halt();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block alpha_panic_block = {
+	.notifier_call = alpha_panic_event,
+	.priority = INT_MIN, /* may not return, do it last */
+};
+
 void __init
 setup_arch(char **cmdline_p)
 {
@@ -1426,19 +1434,6 @@ const struct seq_operations cpuinfo_op = {
 	.show	= show_cpuinfo,
 };
 
-
-static int
-alpha_panic_event(struct notifier_block *this, unsigned long event, void *ptr)
-{
-#if 1
-	/* FIXME FIXME FIXME */
-	/* If we are using SRM and serial console, just hard halt here. */
-	if (alpha_using_srm && srmcons_output)
-		__halt();
-#endif
-        return NOTIFY_DONE;
-}
-
 static __init int add_pcspkr(void)
 {
 	struct platform_device *pd;
-- 
2.42.0

