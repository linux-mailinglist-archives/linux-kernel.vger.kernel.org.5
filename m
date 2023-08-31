Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B52878F0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbjHaQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346712AbjHaQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:05:27 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CEA1E71;
        Thu, 31 Aug 2023 09:05:22 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400"; 
   d="scan'208";a="178328444"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 01:05:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A783E40189C0;
        Fri,  1 Sep 2023 01:05:19 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] usb: typec: tcpci_rt1711h: Drop CONFIG_OF ifdeffery
Date:   Thu, 31 Aug 2023 17:05:01 +0100
Message-Id: <20230831160501.55081-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
References: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
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

Add mod_devicetable.h include.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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

