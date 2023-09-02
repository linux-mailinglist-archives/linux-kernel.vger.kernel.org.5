Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAD7908C5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjIBQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBQ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:57:41 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DBDE4B;
        Sat,  2 Sep 2023 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vAo+LFd8P1VYayE/TRtQa6KVzenEdB+YZHq1dQ5Nrf4=; b=YGl8zWLC5Fw7FoYB9JWESmEblh
        qaI2lzebLVQH5vC7Q0xhTBTyew0TOU/ZOYoE5rirY33nUgucZWm9wm3HCqb5V2uRJP1yodAYc+LZw
        KTiunZr1Yk48zQZ0QyyRHS6xNScTwBzj0VF7IRXUiwtdiffK9yz7x6h7ZGsZUqn09kE1oUDY3/55J
        F2A/auH2OK0cw2TBDPKkdOfKWIw8xT18+uf3CQl9mqYS02vX0lGHDwyCc1FYW89RsSTh7rA8WmZu6
        6PxfkKf22KHyfYmm/bNLaPkc5Chn8vSFLn96/50WPy+DXlbUw6Es5sRtgMoPMBw868RAiS9rqS0YY
        aQe2567Q==;
Received: from [179.232.147.2] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qcTwC-001Q7M-Mp; Sat, 02 Sep 2023 18:57:33 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-alpha@vger.kernel.org, mattst88@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <richard.henderson@linaro.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5] alpha: Clean-up the panic notifier code
Date:   Sat,  2 Sep 2023 13:44:15 -0300
Message-ID: <20230902165725.3504046-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.41.0
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
doing - also, remove the unnecessary include of a header already
included indirectly.

Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V5: rebased against v6.5, build-tested using defconfig.

V4: https://lore.kernel.org/lkml/20230220212245.153554-1-gpiccoli@igalia.com/

Hi Matt, apologies for the annoyance. Seems that this one was never picked-up;
let me know if there's anything missing.

Thanks in advance,

Guilherme


 arch/alpha/kernel/setup.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 3d7473531ab1..07afd2bf18d7 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -41,19 +41,11 @@
 #include <linux/sysrq.h>
 #include <linux/reboot.h>
 #endif
-#include <linux/notifier.h>
 #include <asm/setup.h>
 #include <asm/io.h>
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
@@ -434,6 +426,21 @@ static const struct sysrq_key_op srm_sysrq_reboot_op = {
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
@@ -1426,19 +1433,6 @@ const struct seq_operations cpuinfo_op = {
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
2.41.0

