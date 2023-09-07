Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32BC797B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbjIGSMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343622AbjIGSMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:12:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186FD10FB;
        Thu,  7 Sep 2023 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694110322; x=1725646322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IA9Szt83UA+m0xuMf7Hdrsj2dhOmdjzYfCrJsm9w51E=;
  b=fVu7wj3f1hnA1dOUbR4bw4dm9BnFUzOMmiiefk20U3vP/uxRD9WZZVCb
   Ozmmx14rCdsYex85todn+nfwHK4PGKU3oBdqZDj1YtYT4TE4n8eS7XwlQ
   y8XJg1tHhnlJGdeOCgtc6Md8GgoSKkNboP9jFS2OlwBQjlQpUcb/J7qPT
   IaLAYavVfl8g4IryeVwlCYA5+Pee72CBQnSJCHiLrh3/LOpjHrztD/uKd
   Z9GHCfBXXq+/90V6MEIpGEW6V9SrbnYlf7YIssdBu1se8tUblJILbipiu
   OdlZcxN04vC0Px78LTtKw+zJnLt56NuNVK36UyfBhrjXYMqxk4CmeTmbh
   Q==;
X-CSE-ConnectionGUID: NjtuykKFSRKJP7/JrDLGDA==
X-CSE-MsgGUID: cLUS/A1sTIyYCRatn2B8EQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="233886851"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2023 02:57:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 7 Sep 2023 02:56:56 -0700
Received: from che-dk-unglab44lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 7 Sep 2023 02:56:53 -0700
From:   Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: [RFC net-next v1] net: microchip: lan743x: add fixed phy unregister support
Date:   Thu, 7 Sep 2023 15:26:26 +0530
Message-ID: <20230907095626.2216929-1-Pavithra.Sathyanarayanan@microchip.com>
X-Mailer: git-send-email 2.25.1
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

When operating in fixed phy mode and if there is repeated open/close
phy test cases, everytime the fixed phy is registered as a new phy
which leads to overrun after 32 iterations. It is solved by adding
fixed_phy_unregister() in the phy_close path.

In phy_close path, netdev->phydev cannot be used directly in
fixed_phy_unregister() due to two reasons,
    - netdev->phydev is set to NULL in phy_disconnect()
    - fixed_phy_unregister() can be called only after phy_disconnect()
So saving the netdev->phydev in local variable 'phydev' and
passing it to phy_disconnect().

Signed-off-by: Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index c81cdeb4d4e7..f940895b14e8 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1466,9 +1466,15 @@ static void lan743x_phy_link_status_change(struct net_device *netdev)
 static void lan743x_phy_close(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct phy_device *phydev = netdev->phydev;
 
 	phy_stop(netdev->phydev);
 	phy_disconnect(netdev->phydev);
+
+	/* using phydev here as phy_disconnect NULLs netdev->phydev */
+	if (phy_is_pseudo_fixed_link(phydev))
+		fixed_phy_unregister(phydev);
+
 }
 
 static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
-- 
2.25.1

