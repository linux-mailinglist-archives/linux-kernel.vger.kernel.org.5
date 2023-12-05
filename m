Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D30805B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbjLERLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLERLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7710010C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7D5C433C8;
        Tue,  5 Dec 2023 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796296;
        bh=P6MreLneMjMDrItMtukIGzlsAENE6jsCMg7X7o8UutY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuOw5t8yc8/ve77QaN3zsna0h630CYxkmxyBbjFx9KlumRPvTz5oVP6sexYA17EMq
         z/24PlBQ45DpV5MSu+uJ2hVE7d3TqBw6VmE1NBGsolqF0PYmo21tNJNMzhC2qX2hbm
         IYwDUW2ES0rLe/LqM22Q8k0La3Ju3wxpNsGPDeht1JG0FbQZtCylwgTCNes1N/uGet
         QJuYVdSOjwSmxXXUgkdf0PfAY9/qNeYZHiXfRIBX5ILhBvOELg99VqZbu+sC1xfgw2
         m0vKvE0Dmz9s5pc7DUZcjeh4aVBpvT6uRQMYVWSJGvAQcaLhXONSYmvSjLSTtgUflS
         jTsW7LHakXgpg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/7] PCI: Log bridge windows conditionally
Date:   Tue,  5 Dec 2023 11:11:18 -0600
Message-Id: <20231205171119.680358-7-helgaas@kernel.org>
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

Previously pci_read_bridge_io(), pci_read_bridge_mmio(), and
pci_read_bridge_mmio_pref() unconditionally logged the bridge window
resource.  A future change will call these functions earlier and more
often.  Add a "log" parameter so callers can control whether to generate
the log message.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5ac9c150e68b..485d8c7aae04 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -344,7 +344,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
-static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res)
+static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
+			       bool log)
 {
 	u8 io_base_lo, io_limit_lo;
 	unsigned long io_mask, io_granularity, base, limit;
@@ -377,11 +378,13 @@ static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res)
 		region.start = base;
 		region.end = limit + io_granularity - 1;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_info(dev, "  bridge window %pR\n", res);
+		if (log)
+			pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
-static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res)
+static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res,
+				 bool log)
 {
 	u16 mem_base_lo, mem_limit_lo;
 	unsigned long base, limit;
@@ -396,11 +399,13 @@ static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_info(dev, "  bridge window %pR\n", res);
+		if (log)
+			pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
-static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res)
+static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
+				      bool log)
 {
 	u16 mem_base_lo, mem_limit_lo;
 	u64 base64, limit64;
@@ -446,7 +451,8 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_info(dev, "  bridge window %pR\n", res);
+		if (log)
+			pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -518,9 +524,9 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
-	pci_read_bridge_io(child->self, child->resource[0]);
-	pci_read_bridge_mmio(child->self, child->resource[1]);
-	pci_read_bridge_mmio_pref(child->self, child->resource[2]);
+	pci_read_bridge_io(child->self, child->resource[0], true);
+	pci_read_bridge_mmio(child->self, child->resource[1], true);
+	pci_read_bridge_mmio_pref(child->self, child->resource[2], true);
 
 	if (dev->transparent) {
 		pci_bus_for_each_resource(child->parent, res) {
-- 
2.34.1

