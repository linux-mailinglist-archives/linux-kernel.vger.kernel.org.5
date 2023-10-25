Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DB7D6F11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbjJYOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbjJYOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:33:18 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED47A3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:33:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39PEX4DI112703;
        Wed, 25 Oct 2023 09:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698244384;
        bh=RhH/BrUGOztTNz0KuDNnXxR7aI5X9VJPOk14LY5Iigs=;
        h=From:To:CC:Subject:Date;
        b=EE5vBJ8cJmV3fW4ijWk4TRVNwMo88o6v5fyAQH3wckhY+DiTaxS4jpBQMmdPtPwI1
         npGRKwwaYju3nScYfaPuQ46Jjy1LGxXGEEAUq9FFLhaMV8mnMWo0F6wdJnH4PqsJKr
         ss3u5eVdtx4xxeM68l3OsvJTjIh1q3hbMx+zViYE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39PEX4jF004035
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Oct 2023 09:33:04 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Oct 2023 09:33:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Oct 2023 09:33:04 -0500
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39PEX4Jk105094;
        Wed, 25 Oct 2023 09:33:04 -0500
From:   Andrew Davis <afd@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH] phy: ti: gmii-sel: Fix register offset when parent is not a syscon node
Date:   Wed, 25 Oct 2023 09:33:02 -0500
Message-ID: <20231025143302.1265633-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the node for this phy selector is a child node of a syscon node then the
property 'reg' is used as an offset into the parent regmap. When the node
is standalone and gets its own regmap this offset is pre-applied. So we need
to track which method was used to get the regmap and not apply the offset
in the standalone case.

Fixes: 1fdfa7cccd35 ("phy: ti: gmii-sel: Allow parent to not be syscon node")
Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 555b323f45da1..bc847d3879f79 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -64,6 +64,7 @@ struct phy_gmii_sel_priv {
 	u32 num_ports;
 	u32 reg_offset;
 	u32 qsgmii_main_ports;
+	bool no_offset;
 };
 
 static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
@@ -402,7 +403,8 @@ static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
 		priv->num_ports = size / sizeof(u32);
 		if (!priv->num_ports)
 			return -EINVAL;
-		priv->reg_offset = __be32_to_cpu(*offset);
+		if (!priv->no_offset)
+			priv->reg_offset = __be32_to_cpu(*offset);
 	}
 
 	if_phys = devm_kcalloc(dev, priv->num_ports,
@@ -471,6 +473,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get syscon %d\n", ret);
 			return ret;
 		}
+		priv->no_offset = true;
 	}
 
 	ret = phy_gmii_sel_init_ports(priv);
-- 
2.39.2

