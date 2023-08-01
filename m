Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11276ACBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjHAJSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHAJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:17:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EDA1FE8;
        Tue,  1 Aug 2023 02:16:27 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3719FgIU066693;
        Tue, 1 Aug 2023 04:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690881342;
        bh=1cDlk5nQTkGkrYDGAtT1DqReE4dFrRfYsSqMaXOFOrQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V7eyo7zv5xmzapeFnpw+BvTWX+ccH7aihStTygQ7zvYyP4q+SNLEfabEcfctGV1TK
         MVYOt+nzN+6NqT7eTNjszAqkfHF4Hh21OUZuFBhATsNWHArMWS2c8Y4i2ceMII8X8L
         bB6kup+eCRvl5j+FipJFQF0rVl0SNme4XIeYHAEs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3719FgDe066944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Aug 2023 04:15:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Aug 2023 04:15:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Aug 2023 04:15:42 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3719FgRj038531;
        Tue, 1 Aug 2023 04:15:42 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3719Ff8o016141;
        Tue, 1 Aug 2023 04:15:41 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v13 10/10] net: ti: icssg-prueth: Add Power management support
Date:   Tue, 1 Aug 2023 14:44:28 +0530
Message-ID: <20230801091428.1359979-11-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801091428.1359979-1-danishanwar@ti.com>
References: <20230801091428.1359979-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend / resume APIs to support power management in ICSSG ethernet
driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 57 ++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 80721d82f6c5..47b941fb0198 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1813,6 +1813,62 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth_put_cores(prueth, ICSS_SLICE0);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int prueth_suspend(struct device *dev)
+{
+	struct prueth *prueth = dev_get_drvdata(dev);
+	struct net_device *ndev;
+	int i, ret;
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		ndev = prueth->registered_netdevs[i];
+
+		if (!ndev)
+			continue;
+
+		if (netif_running(ndev)) {
+			netif_device_detach(ndev);
+			ret = emac_ndo_stop(ndev);
+			if (ret < 0) {
+				netdev_err(ndev, "failed to stop: %d", ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int prueth_resume(struct device *dev)
+{
+	struct prueth *prueth = dev_get_drvdata(dev);
+	struct net_device *ndev;
+	int i, ret;
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		ndev = prueth->registered_netdevs[i];
+
+		if (!ndev)
+			continue;
+
+		if (netif_running(ndev)) {
+			ret = emac_ndo_open(ndev);
+			if (ret < 0) {
+				netdev_err(ndev, "failed to start: %d", ret);
+				return ret;
+			}
+			netif_device_attach(ndev);
+		}
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops prueth_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(prueth_suspend, prueth_resume)
+};
+
 static const struct prueth_pdata am654_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 	.quirk_10m_link_issue = 1,
@@ -1830,6 +1886,7 @@ static struct platform_driver prueth_driver = {
 	.driver = {
 		.name = "icssg-prueth",
 		.of_match_table = prueth_dt_match,
+		.pm = &prueth_dev_pm_ops,
 	},
 };
 module_platform_driver(prueth_driver);
-- 
2.34.1

