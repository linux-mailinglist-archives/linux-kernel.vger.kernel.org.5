Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E88756688
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGQOh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGQOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A97E3;
        Mon, 17 Jul 2023 07:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7089610A2;
        Mon, 17 Jul 2023 14:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77E7C433C8;
        Mon, 17 Jul 2023 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689604642;
        bh=9pC2imQJgAfczabA7SVAkkQZ10wRCzLbSNn3X5leRmY=;
        h=From:To:Cc:Subject:Date:From;
        b=AwfuVLCaBpYGBMQ2tq8oG+vIoN/xhHuy0rqoixqNcCiDUL/MESYTWJ4EL+95UAS/P
         yS4XYe81JLSg2ENGrQm9y0A4s83gAq3L6m5bTv3ja5N1Sg6Zagkftg2GjLLyzwpZsu
         hCgY++XMIliKcblIRWOgf5IZyeALgV1ASkp+HMUMsGGvBVtlZMiDJm+6Ec0Bk507CC
         E3i8EHK9kyO3cFJbTbD5ni4Eb9/x+j65sw0OD+xn9uN+330iYRfPTvHeasPjsvSmef
         XkBA515O2vVsmNf8hgJYq0SmlcN85aydYVuvCHO+nSkTXa+ZWXkJxT4mE+OTxInECh
         rpOfOzQHQpTxQ==
Received: (nullmailer pid 1715843 invoked by uid 1000);
        Mon, 17 Jul 2023 14:37:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] of: Move of_platform_register_reconfig_notifier() into DT core
Date:   Mon, 17 Jul 2023 08:37:16 -0600
Message-Id: <20230717143718.1715773-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason the generic platform bus code needs to call
of_platform_register_reconfig_notifier(). The notifier can be setup
before the platform bus is. Let's move it into of_core_init() which is
called just before platform_bus_init() instead to keep more of the DT
bits in the DT code.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/platform.c     | 2 +-
 drivers/of/base.c           | 1 +
 drivers/of/of_private.h     | 6 ++++++
 drivers/of/platform.c       | 2 ++
 include/linux/of_platform.h | 6 ------
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 77510e4f47de..76bfcba25003 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1528,6 +1528,6 @@ int __init platform_bus_init(void)
 	error =  bus_register(&platform_bus_type);
 	if (error)
 		device_unregister(&platform_bus);
-	of_platform_register_reconfig_notifier();
+
 	return error;
 }
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 166fb7d75337..e235f3a57ea8 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -167,6 +167,7 @@ void __init of_core_init(void)
 {
 	struct device_node *np;
 
+	of_platform_register_reconfig_notifier();
 
 	/* Create the kset, and register existing nodes */
 	mutex_lock(&of_mutex);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index b57f1014e419..f38397c7b582 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -60,6 +60,12 @@ static inline int of_property_notify(int action, struct device_node *np,
 }
 #endif /* CONFIG_OF_DYNAMIC */
 
+#if defined(CONFIG_OF_DYNAMIC) && defined(CONFIG_OF_ADDRESS)
+void of_platform_register_reconfig_notifier(void);
+#else
+static inline void of_platform_register_reconfig_notifier(void) { }
+#endif
+
 #if defined(CONFIG_OF_KOBJ)
 int of_node_is_attached(const struct device_node *node);
 int __of_add_property_sysfs(struct device_node *np, struct property *pp);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 051e29b7ad2b..e71adb394b41 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -21,6 +21,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "of_private.h"
+
 const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "simple-mfd", },
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index d8045bcfc35e..fadfea575485 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -127,10 +127,4 @@ static inline int devm_of_platform_populate(struct device *dev)
 static inline void devm_of_platform_depopulate(struct device *dev) { }
 #endif
 
-#if defined(CONFIG_OF_DYNAMIC) && defined(CONFIG_OF_ADDRESS)
-extern void of_platform_register_reconfig_notifier(void);
-#else
-static inline void of_platform_register_reconfig_notifier(void) { }
-#endif
-
 #endif	/* _LINUX_OF_PLATFORM_H */
-- 
2.40.1

