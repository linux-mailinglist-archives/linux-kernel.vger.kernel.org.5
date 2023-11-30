Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5A7FF388
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346293AbjK3PYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346270AbjK3PYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:24:21 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0641B3;
        Thu, 30 Nov 2023 07:24:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 4A1BBFF816;
        Thu, 30 Nov 2023 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701357866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjanQLiV96Fread002ZWRWE0O5XHgSgVvDb1R2qXIW8=;
        b=EBvGX9ZXy3DQtGO2d7/eRwWcKL6Sfo+JOIqYIcEo/3+97xrmIbCerPNHwK1Dwg7Cugso0C
        0yC0SZrS5or2CqWTZAxlat8R4nOGhLEt1EB7ne/4un/xEruvnZwAiuqBFDZA+D6Jjo1Jjp
        W3ZVpgnTcHW89C/7Wyiwtl6K4Ssp/Z2axUVwYrmybO2Q9dSJRgoXze9YP6k908EXlRbgzI
        o6KC6L8AkvSN4xBDs4THH0fkOHi9M13udqzFEWI7wbUfIALJG1a2jZ9nq78APXvq9dnGzM
        jSx4UTaaWymqFcMDxr6suoCEcYNRdCBY+IVxz9ZU5dvH6XOedCNwajbsDt8kKQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Cc:     Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] PCI: of: Attach created of_node to existing device
Date:   Thu, 30 Nov 2023 16:24:04 +0100
Message-ID: <20231130152418.680966-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130152418.680966-1-herve.codina@bootlin.com>
References: <20231130152418.680966-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 407d1a51921e ("PCI: Create device tree node for bridge")
creates of_node for PCI devices.
During the insertion handling of these new DT nodes done by of_platform,
new devices (struct device) are created.
For each PCI devices a struct device is already present (created and
handled by the PCI core).
Having a second struct device to represent the exact same PCI device is
not correct.

On the of_node creation, tell the of_platform that there is no need to
create a device for this node (OF_POPULATED flag), link this newly
created of_node to the already present device and tell fwnode that the
device attached to this of_node is ready (fwnode_dev_initialized()).

With this fix, the of_node are available in the sysfs device tree:
/sys/devices/platform/soc/d0070000.pcie/
+ of_node -> .../devicetree/base/soc/pcie@d0070000
+ pci0000:00
  + 0000:00:00.0
    + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
    + 0000:01:00.0
      + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0

On the of_node removal, revert the operations.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..5afd2731e876 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -615,7 +615,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	np = pci_device_to_OF_node(pdev);
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
-	pdev->dev.of_node = NULL;
+
+	device_remove_of_node(&pdev->dev);
 
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
@@ -668,12 +669,22 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto out_free_node;
 
+	/*
+	 * This of_node will be added to an existing device.
+	 * Avoid any device creation and use the existing device
+	 */
+	of_node_set_flag(np, OF_POPULATED);
+	np->fwnode.dev = &pdev->dev;
+	fwnode_dev_initialized(&np->fwnode, true);
+
 	ret = of_changeset_apply(cset);
 	if (ret)
 		goto out_free_node;
 
 	np->data = cset;
-	pdev->dev.of_node = np;
+
+	/* Add the of_node to the existing device */
+	device_add_of_node(&pdev->dev, np);
 	kfree(name);
 
 	return;
-- 
2.42.0

