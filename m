Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89D758581
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGRTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGRTZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:25:22 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199D81BDA;
        Tue, 18 Jul 2023 12:25:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173456562"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2023 04:25:16 +0900
Received: from mulinux.home (unknown [10.226.93.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C674C4067F07;
        Wed, 19 Jul 2023 04:25:13 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 4/4] spi: rzv2m-csi: Make use of device_set_node
Date:   Tue, 18 Jul 2023 20:24:53 +0100
Message-Id: <20230718192453.543549-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com>
References: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_set_node instead of assigning controller->dev.of_node
directly because it also sets the firmware node.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

v2: Edited the changelog and added include of property.h, according
    to the feedback received from Andy.

 drivers/spi/spi-rzv2m-csi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 62575a61608a..d098aefa370d 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -12,6 +12,7 @@
 #include <linux/iopoll.h>
 #include <linux/log2.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
@@ -589,12 +590,13 @@ static int rzv2m_csi_probe(struct platform_device *pdev)
 	init_waitqueue_head(&csi->wait);
 
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-	controller->dev.of_node = pdev->dev.of_node;
 	controller->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 	controller->setup = rzv2m_csi_setup;
 	controller->transfer_one = rzv2m_csi_transfer_one;
 	controller->use_gpio_descriptors = true;
 
+	device_set_node(&controller->dev, dev_fwnode(dev));
+
 	ret = devm_request_irq(dev, irq, rzv2m_csi_irq_handler, 0,
 			       dev_name(dev), csi);
 	if (ret)
-- 
2.34.1

