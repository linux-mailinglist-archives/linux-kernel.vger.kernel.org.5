Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF77936D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjIFIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjIFIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:40 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 264E0E52;
        Wed,  6 Sep 2023 01:06:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,231,1688396400"; 
   d="scan'208";a="178901450"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Sep 2023 17:06:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.21])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DBCAE41D147D;
        Wed,  6 Sep 2023 17:06:27 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/5] usb: typec: tcpci_rt1711h: Convert enum->pointer for data in the match tables
Date:   Wed,  6 Sep 2023 09:06:16 +0100
Message-Id: <20230906080619.36930-3-biju.das.jz@bp.renesas.com>
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

Currently did varaible is used for HW differences between the devices which
complicates the code by adding checks.

Therefore it is better to convert enum->pointer for data match and extend
match support for both ID and OF tables by using i2c_get_match_data().

Add struct rt1711h_chip_info with did variable and replace did->info in
struct rt1711h_chip. Later patch will add more hw differences to
struct rt1711h_chip_info and avoid checking did for HW differences.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
v1->v2:
 * Updated commit description.
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 30 ++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 6146bca8e55f..2b7258d3cb4e 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -51,13 +51,17 @@
 /* 1b0 as fixed rx threshold of rd/rp 0.55V, 1b1 depends on RTCRTL4[0] */
 #define BMCIO_RXDZEN	BIT(0)
 
+struct rt1711h_chip_info {
+	u16 did;
+};
+
 struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
 	struct device *dev;
 	struct regulator *vbus;
+	const struct rt1711h_chip_info *info;
 	bool src_en;
-	u16 did;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -105,7 +109,7 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 		return ret;
 
 	/* Enable PD30 extended message for RT1715 */
-	if (chip->did == RT1715_DID) {
+	if (chip->info->did == RT1715_DID) {
 		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
 					 RT1711H_ENEXTMSG, RT1711H_ENEXTMSG);
 		if (ret < 0)
@@ -200,7 +204,7 @@ static inline int rt1711h_init_cc_params(struct rt1711h_chip *chip, u8 status)
 	if ((cc1 >= TYPEC_CC_RP_1_5 && cc2 < TYPEC_CC_RP_DEF) ||
 	    (cc2 >= TYPEC_CC_RP_1_5 && cc1 < TYPEC_CC_RP_DEF)) {
 		rxdz_en = BMCIO_RXDZEN;
-		if (chip->did == RT1715_DID)
+		if (chip->info->did == RT1715_DID)
 			rxdz_sel = RT1711H_BMCIO_RXDZSEL;
 		else
 			rxdz_sel = 0;
@@ -319,7 +323,7 @@ static int rt1711h_check_revision(struct i2c_client *i2c, struct rt1711h_chip *c
 	ret = i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
 	if (ret < 0)
 		return ret;
-	if (ret != chip->did) {
+	if (ret != chip->info->did) {
 		dev_err(&i2c->dev, "did is not correct, 0x%04x\n", ret);
 		return -ENODEV;
 	}
@@ -336,7 +340,7 @@ static int rt1711h_probe(struct i2c_client *client)
 	if (!chip)
 		return -ENOMEM;
 
-	chip->did = (size_t)device_get_match_data(&client->dev);
+	chip->info = i2c_get_match_data(client);
 
 	ret = rt1711h_check_revision(client, chip);
 	if (ret < 0) {
@@ -391,17 +395,25 @@ static void rt1711h_remove(struct i2c_client *client)
 	tcpci_unregister_port(chip->tcpci);
 }
 
+static const struct rt1711h_chip_info rt1711h = {
+	.did = RT1711H_DID,
+};
+
+static const struct rt1711h_chip_info rt1715 = {
+	.did = RT1715_DID,
+};
+
 static const struct i2c_device_id rt1711h_id[] = {
-	{ "rt1711h", 0 },
-	{ "rt1715", 0 },
+	{ "rt1711h", (kernel_ulong_t)&rt1711h },
+	{ "rt1715", (kernel_ulong_t)&rt1715 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, rt1711h_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id rt1711h_of_match[] = {
-	{ .compatible = "richtek,rt1711h", .data = (void *)RT1711H_DID },
-	{ .compatible = "richtek,rt1715", .data = (void *)RT1715_DID },
+	{ .compatible = "richtek,rt1711h", .data = &rt1711h },
+	{ .compatible = "richtek,rt1715", .data = &rt1715 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt1711h_of_match);
-- 
2.25.1

