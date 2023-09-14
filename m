Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3873F79FBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjINGSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjINGSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:18:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D64F7;
        Wed, 13 Sep 2023 23:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694672307; x=1726208307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IA9Szt83UA+m0xuMf7Hdrsj2dhOmdjzYfCrJsm9w51E=;
  b=TZIZEbtKCohefNHoZuHuYQ1kn7veyvqPuLv9jSNsTw0YBonz0Zc8EZvo
   AdivhS2ZqlpCj6hIePQ8Qz2jGnqM7+f8cOIcAlrYfuV+a6jWvIUk39djz
   wslXKLZ5rGR9b0lxzJwX3+BLgXYUj6UTs5JVu0kSEqnb3fi1LDtULzXDk
   8yqpfpqlus8j1K7WT7uKEUVYMpoTIwbWQcx1WmDclEk6wt5Jz/OTU7KxO
   pKjMCxErUgXvGxvElyu3Tl5nVGB6vwlIJh9oTobwNAGoJmyl8uF1UlPh/
   g4C1+GZScF3Au01UKR0i9mH4FrjeJPdRVPWxWSuk4w8vFkIEKUvK3P6K3
   g==;
X-CSE-ConnectionGUID: HkcT5bKNT/qqQzS7wKsIFg==
X-CSE-MsgGUID: WEcacK1qQ8+gKJMibd8z+Q==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="4768622"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Sep 2023 23:18:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 13 Sep 2023 23:18:15 -0700
Received: from che-dk-unglab44lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 13 Sep 2023 23:18:12 -0700
From:   Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: [PATCH net-next v1] net: microchip: lan743x: add fixed phy unregister support
Date:   Thu, 14 Sep 2023 11:47:37 +0530
Message-ID: <20230914061737.3147-1-Pavithra.Sathyanarayanan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

