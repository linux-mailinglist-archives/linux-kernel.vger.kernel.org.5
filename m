Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8A75C4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGUK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjGUK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:26:57 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC7110
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4DKJJPARmxLKlgkNjc664F0ozs9IfyrogZCNq6AQT2o=; b=IAiuftl/MhC/5obEyxZ8NDXaAB
        zyseibrSWp6S1KIwJvojMn38nd8vSI0UUiV+pBJOtFpQ9pRe91rfGsjiUvlKxQENpzttvxiQKQ9tS
        R81mw/NKasBvV6sAVWNCNvi3pZ6bvgyYBa1Im5d4M7bpSK8MMEC/8Bq3YxAqCcV3KC5k0yy7PMp/z
        hAIcKgvzmZMtUnR0K5Cba3wkTrLHCwONRt3ulKQN/wMVuAornbUyzbTjkby4SQvNBr1y4SQCgqy2h
        ipu7ULSFgD7WyCgL1UEWEpV5/ScKMPpH8KAEs8EF7TzwASkvkRIq8es3q4K9p24mIhhvQVOjvtk5S
        oFvMTO3Q==;
Received: from [192.168.1.4] (port=63172 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qMnLM-0004ef-08;
        Fri, 21 Jul 2023 12:26:40 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 21 Jul 2023 12:26:39 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Fri, 21 Jul 2023 12:26:18 +0200
Message-ID: <20230721102618.13408-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes XAUI/RXAUI lane alignment errors.
Issue causes dropped packets when trying to communicate over
fiber via SERDES lanes of port 9 and 10.
Errata document applies only to 88E6190X and 88E6390X devices.
Requires poking in undocumented registers.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
V3 : Rework to fit the new phylink_pcs infrastructure
V2 : Rework as suggested by Andrew Lunn <andrew@lun.ch> 
 * make int lanes[] const 
 * reorder prod_nums
 * update commit message to indicate we are dealing with
   undocumented Marvell registers and magic values
---
 drivers/net/dsa/mv88e6xxx/pcs-639x.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
index 98dd49dac421..50b14804c360 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -20,6 +20,7 @@ struct mv88e639x_pcs {
 	struct mdio_device mdio;
 	struct phylink_pcs sgmii_pcs;
 	struct phylink_pcs xg_pcs;
+	struct mv88e6xxx_chip *chip;
 	bool supports_5g;
 	phy_interface_t interface;
 	unsigned int irq;
@@ -205,13 +206,52 @@ static void mv88e639x_sgmii_pcs_pre_config(struct phylink_pcs *pcs,
 	mv88e639x_sgmii_pcs_control_pwr(mpcs, false);
 }
 
+static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
+{
+	const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
+		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
+		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
+		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
+	struct mdio_device mdio;
+	int err, i;
+
+	/* 88e6190x and 88e6390x errata 3.14:
+	 * After chip reset, SERDES reconfiguration or SERDES core
+	 * Software Reset, the SERDES lanes may not be properly aligned
+	 * resulting in CRC errors
+	 */
+
+	mdio.bus = mpcs->mdio.bus;
+
+	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
+		mdio.addr = lanes[i];
+
+		err = mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
+					0xf054, 0x400C);
+		if (err)
+			return err;
+
+		err = mdiodev_c45_write(&mdio, MDIO_MMD_PHYXS,
+					0xf054, 0x4000);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
 					   phy_interface_t interface)
 {
 	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
+	struct mv88e6xxx_chip *chip = mpcs->chip;
 
 	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
 
+	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
+	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
+		mv88e6390_erratum_3_14(mpcs);
+
 	return 0;
 }
 
@@ -523,6 +563,7 @@ static int mv88e6390_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	mpcs->sgmii_pcs.neg_mode = true;
 	mpcs->xg_pcs.ops = &mv88e6390_xg_pcs_ops;
 	mpcs->xg_pcs.neg_mode = true;
+	mpcs->chip = chip;
 
 	err = mv88e639x_pcs_setup_irq(mpcs, chip, port);
 	if (err)
@@ -873,6 +914,7 @@ static int mv88e6393x_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	mpcs->xg_pcs.ops = &mv88e6393x_xg_pcs_ops;
 	mpcs->xg_pcs.neg_mode = true;
 	mpcs->supports_5g = true;
+	mpcs->chip = chip;
 
 	err = mv88e6393x_erratum_4_6(mpcs);
 	if (err)
-- 
2.11.0

