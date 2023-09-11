Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2216C79B38A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354500AbjIKVyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbjIKPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58941E4B;
        Mon, 11 Sep 2023 08:10:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BFAX2o059252;
        Mon, 11 Sep 2023 10:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694445033;
        bh=GpivPZjtRoWE1QE6kdCTM1vklv/tVLesZ1YHxVwRqFY=;
        h=From:To:CC:Subject:Date;
        b=t03gcwyYilIHB3CNO3eaeOxIpqFNOEuziKA5XZR2cQXBaWaCNTmFoS/0VipkFZX9+
         01dYNvD78YWJkzO1LK3DipZLtpJsCGF0+YYPLFe8Jvp5Yl/AyfluAnez8rmFZ7yF6E
         mwngDXiWcjplb04YvV9hObW8z+9jwmcRgES2DF5Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BFAXnj028510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 10:10:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 10:10:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 10:10:32 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BFAW4i018459;
        Mon, 11 Sep 2023 10:10:32 -0500
From:   Andrew Davis <afd@ti.com>
To:     Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v3] mux: mmio: use reg property when parent device is not a syscon
Date:   Mon, 11 Sep 2023 10:10:30 -0500
Message-ID: <20230911151030.71100-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT binding for the reg-mux compatible states it can be used when the
"parent device of mux controller is not syscon device". It also allows
for a reg property. When the reg property is provided, use that to
identify the address space for this mux. If not provided fallback to
using the parent device as a regmap provider.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
---

Changes from v2:
 - Rebased on v6.6-rc1

Changes from v1:
 - Flip logic as suggested in v1[0]

[0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/

 drivers/mux/mmio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index fd1d121a584ba..b6095b7853ed2 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	if (of_device_is_compatible(np, "mmio-mux"))
+	if (of_device_is_compatible(np, "mmio-mux")) {
 		regmap = syscon_node_to_regmap(np->parent);
-	else
-		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
+	} else {
+		regmap = device_node_to_regmap(np);
+		if (IS_ERR(regmap))
+			regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
+	}
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(dev, "failed to get regmap: %d\n", ret);
-- 
2.39.2

