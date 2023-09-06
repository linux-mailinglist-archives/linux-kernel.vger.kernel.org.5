Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034E27936D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjIFIGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbjIFIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:42 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16356E4F;
        Wed,  6 Sep 2023 01:06:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,231,1688396400"; 
   d="scan'208";a="175191028"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 17:06:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0E2AF41D147A;
        Wed,  6 Sep 2023 17:06:33 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/5] usb: typec: tcpci_rt1711h: Add enable_pd30_extended_message variable to struct rt1711h_chip_info
Date:   Wed,  6 Sep 2023 09:06:18 +0100
Message-Id: <20230906080619.36930-5-biju.das.jz@bp.renesas.com>
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

The RT1715 has PD30 extended message compared to RT1711H. Add a variable
enable_pd30_extended_message to struct rt1711h_chip_info to enable this
feature for RT1715.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
v1->v2:
 * Changed enable_pd30_extended_message variable type to bool.
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 40822bae9ae8..5d2dc7ead9d0 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -54,6 +54,7 @@
 struct rt1711h_chip_info {
 	u32 rxdz_sel;
 	u16 did;
+	bool enable_pd30_extended_message;
 };
 
 struct rt1711h_chip {
@@ -110,7 +111,7 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 		return ret;
 
 	/* Enable PD30 extended message for RT1715 */
-	if (chip->info->did == RT1715_DID) {
+	if (chip->info->enable_pd30_extended_message) {
 		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
 					 RT1711H_ENEXTMSG, RT1711H_ENEXTMSG);
 		if (ret < 0)
@@ -400,6 +401,7 @@ static const struct rt1711h_chip_info rt1711h = {
 static const struct rt1711h_chip_info rt1715 = {
 	.rxdz_sel = RT1711H_BMCIO_RXDZSEL,
 	.did = RT1715_DID,
+	.enable_pd30_extended_message = true,
 };
 
 static const struct i2c_device_id rt1711h_id[] = {
-- 
2.25.1

