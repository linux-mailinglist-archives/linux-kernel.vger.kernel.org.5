Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2670E805C2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjLERMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjLERLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C7D10CC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC000C433CB;
        Tue,  5 Dec 2023 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796297;
        bh=jnAj2HzSS5vLJibcc4v+uRFESuzSPOByS1GHsvUTy9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWd+Vuliw7I30Xv/FEB3vpVrtgjnAAJqCo+K0uWqQpL2ZAh4AmxEuhAzXml++pzjU
         1K4J94zasO03kdfCU14uoVtE/yKiG6tyZ9UYLDS9DzLlh4/hZsPjiol1cIPDwTr/uC
         tzEEy71R9oRND3JJiGV0rQqX39BHBTrLUtJfNErcubRE09HUre1p6q62t9bM1WvUZ6
         S+B36WavgqyR2xH14BtJ87K51CE8UNyaiE8bB0EjAKrg5a6P4MjJkBWcLVbaUI+rVh
         SfyZOZl1zqE1v/+W94y0lbrWShDLU41rde61RxTgdtwR+UyepBOvzpx4mBT1LuWS2V
         hoMRGyRpZY+xA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 7/7] PCI: Log bridge info when first enumerating bridge
Date:   Tue,  5 Dec 2023 11:11:19 -0600
Message-Id: <20231205171119.680358-8-helgaas@kernel.org>
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

Log bridge secondary/subordinate bus and window information at the same
time we log the bridge BARs, just after discovering the bridge and before
scanning the bridge's secondary bus.  This logs the bridge and downstream
devices in a more logical order:

  - pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
  - pci 0000:01:00.0: [10de:13b6] type 00 class 0x030200
  - pci 0000:01:00.0: reg 0x10: [mem 0xec000000-0xecffffff]
  - pci 0000:00:01.0: PCI bridge to [bus 01]
  - pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]

  + pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
  + pci 0000:00:01.0: PCI bridge to [bus 01]
  + pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
  + pci 0000:01:00.0: [10de:13b6] type 00 class 0x030200
  + pci 0000:01:00.0: reg 0x10: [mem 0xec000000-0xecffffff]

Note that we read the windows into a temporary struct resource that is
thrown away, not into the resources in the struct pci_bus.

The windows may be adjusted after we know what downstream devices require,
and those adjustments are logged as they are made.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 485d8c7aae04..7a4b500bffa1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -458,8 +458,17 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
 
 static void pci_read_bridge_windows(struct pci_dev *bridge)
 {
+	u32 buses;
 	u16 io;
 	u32 pmem, tmp;
+	struct resource res;
+
+	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
+	res.flags = IORESOURCE_BUS;
+	res.start = (buses >> 8) & 0xff;
+	res.end = (buses >> 16) & 0xff;
+	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
+		 bridge->transparent ? " (subtractive decode)" : "");
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -467,8 +476,12 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 	}
-	if (io)
+	if (io) {
 		bridge->io_window = 1;
+		pci_read_bridge_io(bridge, &res, true);
+	}
+
+	pci_read_bridge_mmio(bridge, &res, true);
 
 	/*
 	 * DECchip 21050 pass 2 errata: the bridge may miss an address
@@ -505,6 +518,8 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
 		if (tmp)
 			bridge->pref_64_window = 1;
 	}
+
+	pci_read_bridge_mmio_pref(bridge, &res, true);
 }
 
 void pci_read_bridge_bases(struct pci_bus *child)
@@ -524,9 +539,9 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-	pci_read_bridge_io(child->self, child->resource[0], true);
-	pci_read_bridge_mmio(child->self, child->resource[1], true);
-	pci_read_bridge_mmio_pref(child->self, child->resource[2], true);
+	pci_read_bridge_io(child->self, child->resource[0], false);
+	pci_read_bridge_mmio(child->self, child->resource[1], false);
+	pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
 
 	if (dev->transparent) {
 		pci_bus_for_each_resource(child->parent, res) {
-- 
2.34.1

