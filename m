Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C87BE829
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377981AbjJIRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376824AbjJIRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68394A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:32:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E9BC433C8;
        Mon,  9 Oct 2023 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872723;
        bh=T1jhTGzyYiwSzxgr8JeryuYGdjLqXTksM+snM+6dzJw=;
        h=From:To:Cc:Subject:Date:From;
        b=s3YVZv7joyPmPZ2paRgsJlDBPIrwjvuZsq3arKOYkyD3wR1wzc4Nmi4e49BfTqNrC
         ZGGVMPStAoXBpTKNlQfeEhVyNgJS6y7ZrwGHoL8OTLgm+FAwdahBW+u4758Y3bYZ6E
         ReB4ugUJbK366baXRNxYMqb/KnhNE9MYh7Z91Ph8SWyAN+PU5sxNlBfJg9QjUzuwOj
         qEA9sfg+EeOQOqT3KMpKX450lw4/DHNLAdSsaem+KGJ6eY6JO9kerrRtggQLAhQATG
         S+krstYiW7ai/lPMDCDDnvXfFw9DwAnkiAwo2SQN4Ljee5Z0WWLQOSCebXgGyt49pN
         qNe62AaidJiYw==
Received: (nullmailer pid 2517576 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mdio: xgene: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:04 -0500
Message-ID: <20231009172923.2457844-9-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() and
acpi_match_device() to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/mdio/mdio-xgene.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
index 7909d7caf45c..495fbe35b6ce 100644
--- a/drivers/net/mdio/mdio-xgene.c
+++ b/drivers/net/mdio/mdio-xgene.c
@@ -13,11 +13,13 @@
 #include <linux/io.h>
 #include <linux/mdio/mdio-xgene.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
-#include <linux/of_platform.h>
 #include <linux/phy.h>
+#include <linux/platform_device.h>
 #include <linux/prefetch.h>
+#include <linux/property.h>
 #include <net/ip.h>
 
 u32 xgene_mdio_rd_mac(struct xgene_mdio_pdata *pdata, u32 rd_addr)
@@ -326,24 +328,11 @@ static int xgene_mdio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mii_bus *mdio_bus;
-	const struct of_device_id *of_id;
 	struct xgene_mdio_pdata *pdata;
 	void __iomem *csr_base;
 	int mdio_id = 0, ret = 0;
 
-	of_id = of_match_device(xgene_mdio_of_match, &pdev->dev);
-	if (of_id) {
-		mdio_id = (uintptr_t)of_id->data;
-	} else {
-#ifdef CONFIG_ACPI
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(xgene_mdio_acpi_match, &pdev->dev);
-		if (acpi_id)
-			mdio_id = (enum xgene_mdio_id)acpi_id->driver_data;
-#endif
-	}
-
+	mdio_id = (uintptr_t)device_get_match_data(&pdev->dev);
 	if (!mdio_id)
 		return -ENODEV;
 
-- 
2.42.0

