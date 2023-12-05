Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D9805C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjLERLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbjLERLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FADD6C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14575C433C7;
        Tue,  5 Dec 2023 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796294;
        bh=FiSPAvyirIPaDAA683jIvAenpsrIJHbqwJy3YwLfHjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cc47frs6jF+zRJ3YzgTYW4w2Usb3IFVTtjezSuDNa1GVq4KBrCdNSfSeNh59H6mEX
         5IBuw1RsRQUMcjcex37wnmrROjge/d3e1/qURhkkFxnhOmw+iNskUWqMISEzMTI9Az
         X6Pco/fu2sS7Ah4QNe13E0z1SVbuva1UwLWmdYkeQGR0WtImFYws44XO7Y+T6Lok6G
         bwPg+mO2Rx/Hmr/rquMxrkHRoIJc/UA371tUnH39KVDQYrMqBqLXqTY1U7lKHRTtXx
         JkwhFYNjmQlvQnKoqNh+8opnYSdoJoGgA9NQf6JSv3ze457jfn06Ynhewu/2zm/ELE
         8g1z88lmtSb0A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/7] PCI: Supply bridge device, not secondary bus, to read window details
Date:   Tue,  5 Dec 2023 11:11:17 -0600
Message-Id: <20231205171119.680358-6-helgaas@kernel.org>
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

Previously we logged information about devices *below* the bridge before
logging information about the bridge itself, e.g.,

  pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
  pci 0000:01:00.0: [10de:13b6] type 00 class 0x030200
  pci 0000:01:00.0: reg 0x10: [mem 0xec000000-0xecffffff]
  pci 0000:00:01.0: PCI bridge to [bus 01]
  pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]

This is partly because the bridge windows are read in this path:

  pci_scan_child_bus_extend
    for (devfn = 0; devfn < 256; devfn += 8)
      pci_scan_slot(bus, devfn)       # scan below bridge
    pcibios_fixup_bus(bus)
      pci_read_bridge_bases(bus)      # read bridge windows
        pci_read_bridge_io(bus)

Remove the assumption that the secondary (child) pci_bus already exists by
passing in the bridge device (instead of the pci_bus) and a resource
pointer when reading bridge windows.  A future change can use this to log
the bridge details before we enumerate the devices below the bridge.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9ada89c2b8cd..5ac9c150e68b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -344,13 +344,11 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
-static void pci_read_bridge_io(struct pci_bus *child)
+static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res)
 {
-	struct pci_dev *dev = child->self;
 	u8 io_base_lo, io_limit_lo;
 	unsigned long io_mask, io_granularity, base, limit;
 	struct pci_bus_region region;
-	struct resource *res;
 
 	io_mask = PCI_IO_RANGE_MASK;
 	io_granularity = 0x1000;
@@ -360,7 +358,6 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		io_granularity = 0x400;
 	}
 
-	res = child->resource[0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
 	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
 	base = (io_base_lo & io_mask) << 8;
@@ -384,15 +381,12 @@ static void pci_read_bridge_io(struct pci_bus *child)
 	}
 }
 
-static void pci_read_bridge_mmio(struct pci_bus *child)
+static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res)
 {
-	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
 	struct pci_bus_region region;
-	struct resource *res;
 
-	res = child->resource[1];
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
 	base = ((unsigned long) mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
@@ -406,16 +400,13 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
 	}
 }
 
-static void pci_read_bridge_mmio_pref(struct pci_bus *child)
+static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res)
 {
-	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
 	u64 base64, limit64;
 	pci_bus_addr_t base, limit;
 	struct pci_bus_region region;
-	struct resource *res;
 
-	res = child->resource[2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
 	base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
@@ -527,9 +518,9 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-	pci_read_bridge_io(child);
-	pci_read_bridge_mmio(child);
-	pci_read_bridge_mmio_pref(child);
+	pci_read_bridge_io(child->self, child->resource[0]);
+	pci_read_bridge_mmio(child->self, child->resource[1]);
+	pci_read_bridge_mmio_pref(child->self, child->resource[2]);
 
 	if (dev->transparent) {
 		pci_bus_for_each_resource(child->parent, res) {
-- 
2.34.1

