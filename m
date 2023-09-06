Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A217936D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjIFIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjIFIGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:50 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5CEFE72;
        Wed,  6 Sep 2023 01:06:39 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,231,1688396400"; 
   d="scan'208";a="175191038"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 17:06:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1D9B941D147D;
        Wed,  6 Sep 2023 17:06:36 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/5] usb: typec: tcpci_rt1711h: Drop CONFIG_OF ifdeffery
Date:   Wed,  6 Sep 2023 09:06:19 +0100
Message-Id: <20230906080619.36930-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
References: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop of_match_ptr() from rt1711h_of_match and get rid of ugly CONFIG_OF
ifdeffery. This slightly increases the size of rt1711h_of_match on non-OF
system and shouldn't be an issue.

It also allows, in case if needed, to enumerate this device via ACPI with
PRP0001 magic.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
 * Updated commit description for ACPI with PRP0001 magic.
v2:
 * New patch
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 5d2dc7ead9d0..67422d45eb54 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -411,19 +412,17 @@ static const struct i2c_device_id rt1711h_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt1711h_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id rt1711h_of_match[] = {
 	{ .compatible = "richtek,rt1711h", .data = &rt1711h },
 	{ .compatible = "richtek,rt1715", .data = &rt1715 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt1711h_of_match);
-#endif
 
 static struct i2c_driver rt1711h_i2c_driver = {
 	.driver = {
 		.name = "rt1711h",
-		.of_match_table = of_match_ptr(rt1711h_of_match),
+		.of_match_table = rt1711h_of_match,
 	},
 	.probe = rt1711h_probe,
 	.remove = rt1711h_remove,
-- 
2.25.1

