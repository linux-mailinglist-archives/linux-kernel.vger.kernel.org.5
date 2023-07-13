Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B07F752B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjGMUKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjGMUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:10:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A442709
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:10:18 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DKA4sN038606;
        Thu, 13 Jul 2023 15:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689279004;
        bh=mIwOozXXFg3KmTwudLxq5mLOys7noNt7A73QFukctPs=;
        h=From:To:CC:Subject:Date;
        b=CcW11lxdxpHw+7TBQif7FPJWeZE6Lc5pWYwdgj1k2jigz1JTaCYpnzMDizIAssUeN
         940bCK4qSdHDiQ2HjmBBTsRVGTGyATInwTPU3M2fcHdp/fEclCnGVtnDsleJpPomzc
         vv+4vLLyAwMqPGkgYXdJLLyfrej/t9Ws2LlK2YQU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DKA4VX068397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 15:10:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 15:10:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 15:10:03 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DKA3Ou022042;
        Thu, 13 Jul 2023 15:10:03 -0500
From:   Andrew Davis <afd@ti.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2] phy: ti: gmii-sel: Allow parent to not be syscon node
Date:   Thu, 13 Jul 2023 15:09:57 -0500
Message-ID: <20230713200957.134480-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the parent node is not a syscon type, then fallback and check
if we can get a regmap from our own node. This no longer forces
us to make the parent of this node a syscon node when that might
not be appropriate.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1:
 - Rebased on v6.5-rc1

 drivers/phy/ti/phy-gmii-sel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 6286cf25a4264..555b323f45da1 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -465,9 +465,12 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 
 	priv->regmap = syscon_node_to_regmap(node->parent);
 	if (IS_ERR(priv->regmap)) {
-		ret = PTR_ERR(priv->regmap);
-		dev_err(dev, "Failed to get syscon %d\n", ret);
-		return ret;
+		priv->regmap = device_node_to_regmap(node);
+		if (IS_ERR(priv->regmap)) {
+			ret = PTR_ERR(priv->regmap);
+			dev_err(dev, "Failed to get syscon %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = phy_gmii_sel_init_ports(priv);
-- 
2.39.2

