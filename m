Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262477E0F17
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKDL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjKDL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:29:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831891AA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699097377;
        bh=5CLEWlb/FZJQNq94xbAoxDHDCfPn4Oh7tFwFnTmNzCA=;
        h=From:Date:Subject:To:Cc:From;
        b=J22UjRvyVrsMWv1cyfJRtYIix0l/Q07ZPxnVR4jpGsIvaVjRAZ+Eqj9sKpjQrGkw2
         rsjJElGmnnc9UozwXJm3bVY8vjiG/UGdUuqQNLCX6tdl0++AXIJM/5bhFWx3lh1S7C
         yErA/DsDL1HWWRqjvhVbopjJy90ZLIJ0nHZP/BXU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 04 Nov 2023 12:29:30 +0100
Subject: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABkrRmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwMT3YKygsS8zGTd4ozSkpT88jxd07REY4tEC3PLxBRDJaC2gqLUtMw
 KsJHRSkFuzkqxtbUA2om/xmcAAAA=
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Willy Tarreau <w@1wt.eu>, Yuan Tan <tanyuan@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699097376; l=3120;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5CLEWlb/FZJQNq94xbAoxDHDCfPn4Oh7tFwFnTmNzCA=;
 b=Z9wMVem+r2d/PaEOBigYC8TqCp8MBn4xEDV9ZrtDPTaxeozFZP3MzKlUIPjqvbgeAUMUoNLXM
 V8XzLOrG74OCLqHvnXYOvBoSggaQYWan0soq1piXeGPD/IF8IiIoNME
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
The corresponding patch to qemu has also been submitted[0].
General discussions about the feature should happen on the other thread.

[0] https://lore.kernel.org/qemu-devel/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de/
---
 drivers/misc/pvpanic/pvpanic.c | 19 +++++++++++++++++--
 include/uapi/misc/pvpanic.h    |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 305b367e0ce3..d7d807f5e47a 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/panic_notifier.h>
+#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/cdev.h>
 #include <linux/list.h>
@@ -74,6 +75,13 @@ static struct notifier_block pvpanic_panic_nb = {
 	.priority = INT_MAX,
 };
 
+static int pvpanic_sys_off(struct sys_off_data *data)
+{
+	pvpanic_send_event(PVPANIC_SHUTDOWN);
+
+	return NOTIFY_DONE;
+}
+
 static void pvpanic_remove(void *param)
 {
 	struct pvpanic_instance *pi_cur, *pi_next;
@@ -152,7 +160,7 @@ int devm_pvpanic_probe(struct device *dev, void __iomem *base)
 		return -ENOMEM;
 
 	pi->base = base;
-	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN;
 
 	/* initlize capability by RDPT */
 	pi->capability &= ioread8(base);
@@ -168,12 +176,18 @@ int devm_pvpanic_probe(struct device *dev, void __iomem *base)
 }
 EXPORT_SYMBOL_GPL(devm_pvpanic_probe);
 
+static struct sys_off_handler *sys_off_handler;
+
 static int pvpanic_init(void)
 {
 	INIT_LIST_HEAD(&pvpanic_list);
 	spin_lock_init(&pvpanic_lock);
 
 	atomic_notifier_chain_register(&panic_notifier_list, &pvpanic_panic_nb);
+	sys_off_handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
+						   pvpanic_sys_off, NULL);
+	if (IS_ERR(sys_off_handler))
+		sys_off_handler = NULL;
 
 	return 0;
 }
@@ -182,6 +196,7 @@ module_init(pvpanic_init);
 static void pvpanic_exit(void)
 {
 	atomic_notifier_chain_unregister(&panic_notifier_list, &pvpanic_panic_nb);
-
+	if (sys_off_handler)
+		unregister_sys_off_handler(sys_off_handler);
 }
 module_exit(pvpanic_exit);
diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
index 54b7485390d3..82fc618bfbcf 100644
--- a/include/uapi/misc/pvpanic.h
+++ b/include/uapi/misc/pvpanic.h
@@ -5,5 +5,6 @@
 
 #define PVPANIC_PANICKED	(1 << 0)
 #define PVPANIC_CRASH_LOADED	(1 << 1)
+#define PVPANIC_SHUTDOWN	(1 << 2)
 
 #endif /* __PVPANIC_H__ */

---
base-commit: 90b0c2b2edd1adff742c621e246562fbefa11b70
change-id: 20231104-pvpanic-shutdown-5fa38a879ad1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

