Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD27936D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjIFIGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjIFIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:40 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02D6FCF0;
        Wed,  6 Sep 2023 01:06:33 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,231,1688396400"; 
   d="scan'208";a="178901461"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Sep 2023 17:06:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id F001B41D147D;
        Wed,  6 Sep 2023 17:06:30 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] usb: typec: tcpci_rt1711h: Add rxdz_sel variable to struct rt1711h_chip_info
Date:   Wed,  6 Sep 2023 09:06:17 +0100
Message-Id: <20230906080619.36930-4-biju.das.jz@bp.renesas.com>
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

The RT1715 needs 0.35V/0.75V rx threshold for rd/rp whereas it is 0.4V/0.7V
for RT1711H. Add rxdz_sel variable to struct rt1711h_chip_info for
handling this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
v1->v2:
 * Swapped the rxdz_sel variable in struct rt1711h_chip_info to avoid
   holes.
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 2b7258d3cb4e..40822bae9ae8 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -52,6 +52,7 @@
 #define BMCIO_RXDZEN	BIT(0)
 
 struct rt1711h_chip_info {
+	u32 rxdz_sel;
 	u16 did;
 };
 
@@ -204,10 +205,7 @@ static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
 	if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
 	    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
 		rxdz_en = BMCIO_RXDZEN;
-		if (chip->info->did == RT1715_DID)
-			rxdz_sel = RT1711H_BMCIO_RXDZSEL;
-		else
-			rxdz_sel = 0;
+		rxdz_sel = chip->info->rxdz_sel;
 	} else {
 		rxdz_en = 0;
 		rxdz_sel = RT1711H_BMCIO_RXDZSEL;
@@ -400,6 +398,7 @@ static const struct rt1711h_chip_info rt1711h = {
 };
 
 static const struct rt1711h_chip_info rt1715 = {
+	.rxdz_sel = RT1711H_BMCIO_RXDZSEL,
 	.did = RT1715_DID,
 };
 
-- 
2.25.1

