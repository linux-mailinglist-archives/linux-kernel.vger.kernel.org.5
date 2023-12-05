Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30B805BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbjLERL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjLERLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33538D43
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0D1C433C9;
        Tue,  5 Dec 2023 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796286;
        bh=SHRKGwDoVF1G5pI2uXdiU2j2HD1GhNV1bFDWy1EgiQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oz7aiQkW8Riza4Ilemm9GNYNXNd8o78kRd0umW+FYYavHtzRjmbSvhY+XnsuAKS1R
         ETZ16KI3ktKyiPVGQCwWVQBMIPBb2ORwdv6fczHVgAS7FW+cz762RTMkuog4P9izWu
         VtyKND0Rh/0Xi7QGg9VKSIMYbkpjcOHEBleijIaF+MzndkG9HRYO6GFmamuOTxp/f1
         SPCRqil0ia6q41yeHBm3eq493FY9BE6I2kNLIKBaJmvG3eyvBx9AuZREcYEFFOj3CI
         zqPVpyKAmXs2ddX26uJIDty1pUDfVpIUbGdIt8AbqXaoZLohjHGt9ZhNS8DOSAyUS1
         z4RjwMjEX6+lA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/7] PCI: Log device type during enumeration
Date:   Tue,  5 Dec 2023 11:11:13 -0600
Message-Id: <20231205171119.680358-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205171119.680358-1-helgaas@kernel.org>
References: <20231205171119.680358-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Log the device type when enumeration a device.  Sample output changes:

  - pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
  + pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint

  - pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
  + pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400 PCIe Root Port

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed6b7f48736a..1dbc06f0305c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1817,6 +1817,43 @@ static void early_dump_pci_device(struct pci_dev *pdev)
 		       value, 256, false);
 }
 
+static const char *pci_type_str(struct pci_dev *dev)
+{
+	static const char *str[] = {
+		"PCIe Endpoint",
+		"PCIe Legacy Endpoint",
+		"PCIe unknown",
+		"PCIe unknown",
+		"PCIe Root Port",
+		"PCIe Upstream Switch Port",
+		"PCIe Downstream Switch Port",
+		"PCIe to PCI/PCI-X bridge",
+		"PCI/PCI-X to PCIe bridge",
+		"PCIe Root Complex Integrated Endpoint",
+		"PCIe Root Complex Event Collector",
+	};
+	int type;
+
+	if (pci_is_pcie(dev)) {
+		type = pci_pcie_type(dev);
+		if (type < ARRAY_SIZE(str))
+			return str[type];
+
+		return "PCIe unknown";
+	}
+
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+		return "conventional PCI endpoint";
+	case PCI_HEADER_TYPE_BRIDGE:
+		return "conventional PCI bridge";
+	case PCI_HEADER_TYPE_CARDBUS:
+		return "CardBus bridge";
+	default:
+		return "conventional PCI";
+	}
+}
+
 /**
  * pci_setup_device - Fill in class and map information of a device
  * @dev: the device structure to fill
@@ -1887,8 +1924,9 @@ int pci_setup_device(struct pci_dev *dev)
 
 	pci_set_removable(dev);
 
-	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
-		 dev->vendor, dev->device, dev->hdr_type, dev->class);
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x %s\n",
+		 dev->vendor, dev->device, dev->hdr_type, dev->class,
+		 pci_type_str(dev));
 
 	/* Device class may be changed after fixup */
 	class = dev->class >> 8;
-- 
2.34.1

