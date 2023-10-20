Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CCF7D0E49
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377037AbjJTLSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjJTLSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:18:09 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CC0CA;
        Fri, 20 Oct 2023 04:18:07 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39KBHhj2034034;
        Fri, 20 Oct 2023 06:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697800663;
        bh=lsAeSoK43n/QTcYg4kVAxzU7Yseh9TpDXJToFJLPGy0=;
        h=From:To:CC:Subject:Date;
        b=izV7M6VYkysbLu+/iIr8qmIiWUhriC6gaQutRJ8boYmoZeSud70WGh7XKu2015igZ
         fSLUgh2ExPno2Zkxdpyb4XOrWRy2S6a3D/cj2wFEg9ickerZi7BW+YOj6FO1KTnQdF
         kgGVBPnyjLObOKOd40tmMq2Nz4em9V8tjkQY1AJ8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39KBHheH015355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Oct 2023 06:17:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 06:17:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 06:17:43 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39KBHciW020272;
        Fri, 20 Oct 2023 06:17:39 -0500
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <rogerq@kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <horms@kernel.org>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v2] net: ethernet: ti: davinci_mdio: Update K3 SoCs list for errata i2329
Date:   Fri, 20 Oct 2023 16:47:38 +0530
Message-ID: <20231020111738.14671-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The errata i2329 affects certain K3 SoC versions. The k3-socinfo.c
driver generates the revision string for different variants of the
same SoC in an incremental fashion. This is not true for all SoCs.
An example case being J721E, for which the actual silicon revision
names are 1.0, 1.1 for its variants, while the k3-socinfo.c driver
interprets these variants as revisions 1.0, 2.0 respectively,
which is incorrect.

While the work to fixup the silicon revision string is posted
to the soc tree, this patch serves as a fail-safe step by maintaining
a list of correct and incorrect revision strings, so that the fixup
work does not break the errata workaround for such corrected SoCs.

The silicon revisions affected by the errata i2329 can be found under
the MDIO module in the "Advisories by Modules" section of each
SoC errata document listed below

AM62x: https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
AM64X: https://www.ti.com/lit/er/sprz457g/sprz457g.pdf
AM65X: https://www.ti.com/lit/er/sprz452i/sprz452i.pdf
J7200: https://www.ti.com/lit/er/sprz491d/sprz491d.pdf
J721E: https://www.ti.com/lit/er/sprz455d/sprz455d.pdf
J721S2: https://www.ti.com/lit/er/sprz530b/sprz530b.pdf

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---

Changes since v1:
* For J721E, retained the incorrect SR ID and added the correct one
* Add AM65x SR2.1 to the workaround list

v1: https://lore.kernel.org/all/20231018140009.1725-1-r-gunasekaran@ti.com/

 drivers/net/ethernet/ti/davinci_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 628c87dc1d28..25aaef502edc 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -516,9 +516,11 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
 	{ .family = "AM64X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
 	{ .family = "AM65X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
 	{ .family = "AM65X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
+	{ .family = "AM65X", .revision = "SR2.1", .data = &am65_mdio_soc_data },
 	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
 	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
 	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
+	{ .family = "J721E", .revision = "SR1.1", .data = &am65_mdio_soc_data },
 	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
 	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
 	{ /* sentinel */ },

base-commit: 2030579113a1b1b5bfd7ff24c0852847836d8fd1
-- 
2.17.1

