Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3975BE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGUGDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGUGCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:02:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6945273C;
        Thu, 20 Jul 2023 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919329; x=1721455329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k6CQs54q/v1moVIj+/SNnFPZ3nakzOWZlEo//zuDhx4=;
  b=koCqNK40ZAmbxWg6sUIMP8ZSR6FaH2+0fmsOH/VvaUy3lSj7IZ5U7jP5
   YQdV2tU+ABXBZ5/IpqDcSTPijEBTjQ0SxivEGGp3C4H5CZYESXtV71ko0
   VtZUd7OXnjXKe9sC2XnPFcmtjuUsGNwrFp2EuwLXaXqxhcdlxznPcLPZt
   mGuNFm7buTcbfgmx2Dii/Yr1bV8rmRJHTvcVgWiTInYYAzzWGauil2IZ8
   cS/NBuu8qszi6QA1gJ5u+rd02q30WndZZ5iIBrpyjE3yYr8nExBCmfnka
   GMGtSZELxj/N77MsRY2rNcg1cvotAda4N6jfT06P2RkajoZ1RNoG4mjgU
   A==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="221463770"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:01:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:01:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:01:14 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
        <linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 2/2] net: sfp: add quirk for FS's DAC10G SFP (SFPP-PC01)
Date:   Fri, 21 Jul 2023 11:30:57 +0530
Message-ID: <20230721060057.2998-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721060057.2998-1-Raju.Lakkaraju@microchip.com>
References: <20230721060057.2998-1-Raju.Lakkaraju@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk for a DAC10G SFP that identifies itself as "FS" "SFPP-PC01".
Add a quirk to enable the SGMII interface, modes 2500base-T, 1000base-T,
100base-T/Full and 100base-T/Half support.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/phy/sfp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index ee049efdf71b..80d2680f08ab 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -421,6 +421,18 @@ static void sfp_quirk_oem_2_5g(const struct sfp_eeprom_id *id,
 	sfp_quirk_disable_autoneg(id, modes, interfaces);
 }
 
+static void sfp_quirk_fs_dac(const struct sfp_eeprom_id *id,
+			     unsigned long *modes,
+			     unsigned long *interfaces)
+{
+	/* Fiberstore(FS)'s DAC SFP (SFPP-PC01) */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, modes);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
+}
+
 static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 				      unsigned long *modes,
 				      unsigned long *interfaces)
@@ -465,6 +477,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	// FS 2.5G Base-T
 	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	// FS DAC10G (SFPP-PC01)
+	SFP_QUIRK_M("FS", "SFPP-PC01", sfp_quirk_fs_dac),
 
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
-- 
2.25.1

