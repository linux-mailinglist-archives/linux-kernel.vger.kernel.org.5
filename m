Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D27C7CBFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjJQJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJQJnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:43:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12B998;
        Tue, 17 Oct 2023 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535809; x=1729071809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aA+396/l67uMfrVCyXw8FN73UoV7n1BkXMcRb+xZZuo=;
  b=DJRrXWf3mpLUJBVNbQiv5TbIIey2dBeOGaAiN4BQMxbhdwhZiVKqhb+u
   tLSyjz7QAAVPRUnUgK3fI2xlMO51MrrYTICpM7+Ti57xhYSBVi+9b7FLw
   /X0Dn+daDtHRIxcpqOkIkFIAwrAwEhGWiCW/guQmEcUqkHADQXwgjt7B1
   81Z18NEtYNePnclr31woJ/LEivsq8AcHIO7X9BFyNMQ46W/HvGZrPEbnf
   ci3MPrxKsqbSym3g6D3YX/cDnwSWsYAWLKDSO7XvovrNNlezxnnNmfyT0
   G90lnejKTQi/B1RJLgbf4mT5ctUEjL5XUVdLsVnk7XOwzIS/SkQ6NWDRn
   w==;
X-CSE-ConnectionGUID: EEbPSG5+T0W6T1Zrb5aZ6A==
X-CSE-MsgGUID: ZZ3vNBvmREq0+76behTLNw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10101600"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:43:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:19 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:16 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <Bryan.Whitehead@microchip.com>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <linux@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 0/7] Add support to PHYLINK and SFP for PCI11x1x chips 
Date:   Tue, 17 Oct 2023 15:12:01 +0530
Message-ID: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support to phylink and sfp pluggable module.
Add software-nodes to hold the network interface phylink, sfp, i2c and gpio
configuration and integrates the PCI1x1x chip i2c driver and gpio driver to
access the sfp module eeprom data.

Tested on chip PCI11010 Rev-B with Bridgeport Evaluation board Rev-1 with
following SFP modules:

1. FS's 2.5G SFP (SFP-2.5G-T) with 2.5 Gbps speed (interface 2500Base-X)

2. Mellanox DAC10G SFP (MC3309130-001) at 2.5 Gbps speed (interface 2500Base-X)
and 1Gpbs speed (interface 1000Base-X)

3. Axcen's 1G SFP (AXGT-R1T4-05I1) at 1G/100M/10M bps speed (interface SGMII)

4. Fiber 1G SFP (AXGE-1354-0531) at 1Gpbs speed (interface 1000Base-X)

Change Log:
===========
V0 -> V1:
  - Integrate with Synopsys DesignWare XPCS drivers
  - Based on external review comments,
    - Changes made to SGMII interface support only 1G/100M/10M bps speed
    - Changes made to 2500Base-X interface support only 2.5Gbps speed
    - Add check for not is_sgmii_en with is_sfp_support_en support
    - Change the "pci11x1x_strap_get_status" function return type from void to  
      int
    - Add ethtool phylink wol, eee, pause get/set functions

Raju Lakkaraju (7):
  net: lan743x: Create separate PCS power reset function
  net: lan743x: Create separate Link Speed Duplex state function
  net: lan743x: Add SFP support check flag
  net: lan743x: Add support to software-nodes for sfp and phylink
  net: lan743x: Register the platform device for sfp pluggable module
  net: lan743x: Add support to the phylink framework
  net: lan743x: Add support to ethtool phylink get and set settings

 drivers/net/ethernet/microchip/Kconfig        |    9 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  |   85 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 1090 ++++++++++++-----
 drivers/net/ethernet/microchip/lan743x_main.h |   49 +
 4 files changed, 868 insertions(+), 365 deletions(-)

-- 
2.34.1

