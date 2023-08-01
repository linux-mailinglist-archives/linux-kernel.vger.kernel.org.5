Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8676A97B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjHAGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjHAGsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:48:42 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E123895
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DDfKZAST0kBdA4G1Zj06EBEeG3//RNdqqNF0W9wlm6w=; b=JVGwLVev2GMY3Uuq446yK44MGz
        8hauO+kaAfK9fCwNUmRr5UeYwrtFT67wnf77tXgpfPp4iBcoJlo8797kbkwFUIULlUh5K1kRDmXbg
        0KgOJ4x32ShUuMQcxv1zALE7nxOpUnoFJwvmQyJtTn28xdL8ZjBm3K9Klv5dZeydbMDj1Z0mx1jYB
        XLIDBxqmTqLj2gGtSIlNvX7rvGsoGVWQXCO5m6Hora64e0nysbMNuvuXtBIAiWNZdDEvg7F8pB6ZC
        Td7H5zOpROAg0M+OP3gN7CI5irpx78JBc5G2+sQFOL0IDSBzD0674ZPF2TMcOEf20J8LGN3CSeodp
        SAnT6v0Q==;
Received: from [192.168.1.4] (port=16778 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qQjBL-0008GM-1R;
        Tue, 01 Aug 2023 08:48:35 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 1 Aug 2023 08:48:34 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>, Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v5] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Tue, 1 Aug 2023 08:48:15 +0200
Message-ID: <20230801064815.25694-1-ante.knezic@helmholz.de>
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
V5 : No patch changes, repost due to missing CC
V4 : Rework as suggested by Vladimir Oltean <olteanv@gmail.com>
     and Russell King <linux@armlinux.org.uk>
 * print error in case of failure to apply erratum
 * use mdiobus_c45_write instead of mdiodev_c45_write
 * use bool variable instead of embedding a chip pointer inside
   pcs struct.
V3 : Rework to fit the new phylink_pcs infrastructure
V2 : Rework as suggested by Andrew Lunn <andrew@lun.ch> 
 * make int lanes[] const 
 * reorder prod_nums
 * update commit message to indicate we are dealing with
   undocumented Marvell registers and magic values
---
 drivers/net/dsa/mv88e6xxx/pcs-639x.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
index 98dd49dac421..ba373656bfe1 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -20,6 +20,7 @@ struct mv88e639x_pcs {
 	struct mdio_device mdio;
 	struct phylink_pcs sgmii_pcs;
 	struct phylink_pcs xg_pcs;
+	bool erratum_3_14;
 	bool supports_5g;
 	phy_interface_t interface;
 	unsigned int irq;
@@ -205,13 +206,53 @@ static void mv88e639x_sgmii_pcs_pre_config(struct phylink_pcs *pcs,
 	mv88e639x_sgmii_pcs_control_pwr(mpcs, false);
 }
 
+static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
+{
+	const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
+		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
+		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
+		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
+	int err, i;
+
+	/* 88e6190x and 88e6390x errata 3.14:
+	 * After chip reset, SERDES reconfiguration or SERDES core
+	 * Software Reset, the SERDES lanes may not be properly aligned
+	 * resulting in CRC errors
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
+		err = mdiobus_c45_write(mpcs->mdio.bus, lanes[i],
+					MDIO_MMD_PHYXS,
+					0xf054, 0x400C);
+		if (err)
+			return err;
+
+		err = mdiobus_c45_write(mpcs->mdio.bus, lanes[i],
+					MDIO_MMD_PHYXS,
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
+	int err;
 
 	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
 
+	if (mpcs->erratum_3_14) {
+		err = mv88e6390_erratum_3_14(mpcs);
+		if (err)
+			dev_err(mpcs->mdio.dev.parent,
+				"failed to apply erratum 3.14: %pe\n",
+				ERR_PTR(err));
+	}
+
 	return 0;
 }
 
@@ -524,6 +565,10 @@ static int mv88e6390_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	mpcs->xg_pcs.ops = &mv88e6390_xg_pcs_ops;
 	mpcs->xg_pcs.neg_mode = true;
 
+	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
+	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
+		mpcs->erratum_3_14 = true;
+
 	err = mv88e639x_pcs_setup_irq(mpcs, chip, port);
 	if (err)
 		goto err_free;
-- 
2.11.0

