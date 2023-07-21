Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7275BE19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGUGAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:00:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2759010E5;
        Thu, 20 Jul 2023 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919240; x=1721455240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WKA/IGfWnpS4IR7jGsDv1clVOOBnyLhIowkT0Wqkn7M=;
  b=hnpDb29wOLUIey3jmVHd6tO4tN65YesFSnLQHMmx4WNsePVjbxMOoOrC
   5vAqxeSvXr4dIScGmsQao4wR1tWH0rKL679qNNNxIHowm9AB2/u52vMCV
   dp/WNPf5nu6ME4eoYUZqHRVchuyhePcV2CFb9fkjx77EYzUPMBnAsbcBK
   kAF3kiTPPzrIKXZjogC6/48rxoYlnj7q4ehKeXk/Kl/Xb84uHR2kvPwj0
   yJhswNLbZ3ssP+9i7fU8dARxhEyPWOQKvM2v+18Dt03mQ1QOzLrS+tnN0
   Jx0vopuAFFbV796pjuBYBSjrzsQyHYSLuPscywMP9E4j9zfVl6D78rroc
   w==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="225102692"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:00:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:00:33 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:00:30 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bryan.whitehead@microchip.com>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 0/7] Add support to PHYLINK and SFP for PCI11x1x chips 
Date:   Fri, 21 Jul 2023 11:30:12 +0530
Message-ID: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.25.1
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

This patch series adds support to PHYLINK and SFP pluggable module.
Add software-nodes to hold the network interface phylink, sfp, i2c and GPIO
configuration and integrates the PCI1x1x chip I2C driver and GPIO driver to
access the SFP module EEPROM data.

Tested on chip PCI11010 Rev-B with Bridgeport Evaluation board Rev-1 with
following SFP modules:

1. FS's 2.5G SFP (SFP-2.5G-T) with 2.5 Gbps speed (interface 2500Base-X)

2. FS's DAC10G SFP (SFPP-PC01) with 2.5 Gbps speed (interface 2500Base-X)

3. FS's 1G SFP (SFP-GB-GE-TL) with 1G/100M/10M bps speed (interface SGMII)

4. Axcen's 1G SFP (AXGT-R1T4-05I1) with 1G/100M/10M bps speed (interface SGMII)

5. Excom's 1G SFP (SFP-T) with 1G/100M/10M bps speed (interface SGMII)

Raju Lakkaraju (7):
  net: lan743x: Create separate PCS power reset function
  net: lan743x: Create separate Link Speed Duplex state function
  net: lan743x: Add SFP support check flag
  net: lan743x: Add support to software-nodes for SFP and PHYLINK
  net: lan743x: Add support to the Phylink framework
  net: lan743x: Add support to ethtool phylink get and set settings
  net: lan743x: Register the platform device for sfp pluggable module

 drivers/net/ethernet/microchip/Kconfig        |   4 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  |  34 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 707 ++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  42 ++
 4 files changed, 718 insertions(+), 69 deletions(-)

-- 
2.25.1

