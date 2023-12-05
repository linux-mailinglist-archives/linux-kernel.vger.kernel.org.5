Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97F805B56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjLERLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjLERLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA3D5F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F43BC433C8;
        Tue,  5 Dec 2023 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796292;
        bh=Nx+0hAHnMWWt1b/M1B+K86JZDV7nSP5pxFnxTxDfqPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0gNDt/UbLRTN4S8LpvEkpkiV8xhh8XrpERK/gjuMkKreW1mlIOBzc6LeJKTtO0Qt
         bHDab0b5psJ3E+InYvRASU70HB4yICtVrcyIoVZBD8sWqr8pvMwC+osXb8OU+xMcZV
         z1HvuAwH1qEsdajFVhspjm/d9NcweQfpc7dW1ZKinb97f025OusdMBnOgyfabf5468
         GkCJR3vzGMQm7uf2eS/Om/BUmR0viGhdvRSc0B7zjEE7nsmtgxOyYSQPGhUQGqLccO
         DAtyfl03kjvaywrkjuYkOGhVUWOFT0r82lGYlKajftAmc9QMDDXqc70UBNQJQkicJ7
         ib5Sgmhulnp3Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/7] PCI: Move pci_read_bridge_windows() below individual window accessors
Date:   Tue,  5 Dec 2023 11:11:16 -0600
Message-Id: <20231205171119.680358-5-helgaas@kernel.org>
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

Move pci_read_bridge_windows() below the functions that read the I/O,
memory, and prefetchable memory windows, so pci_read_bridge_windows() can
use them in the future.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 102 ++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f6ec79b6a037..9ada89c2b8cd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -344,57 +344,6 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 	}
 }
 
-static void pci_read_bridge_windows(struct pci_dev *bridge)
-{
-	u16 io;
-	u32 pmem, tmp;
-
-	pci_read_config_word(bridge, PCI_IO_BASE, &io);
-	if (!io) {
-		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
-		pci_read_config_word(bridge, PCI_IO_BASE, &io);
-		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
-	}
-	if (io)
-		bridge->io_window = 1;
-
-	/*
-	 * DECchip 21050 pass 2 errata: the bridge may miss an address
-	 * disconnect boundary by one PCI data phase.  Workaround: do not
-	 * use prefetching on this device.
-	 */
-	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
-		return;
-
-	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
-	if (!pmem) {
-		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
-					       0xffe0fff0);
-		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
-		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
-	}
-	if (!pmem)
-		return;
-
-	bridge->pref_window = 1;
-
-	if ((pmem & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
-
-		/*
-		 * Bridge claims to have a 64-bit prefetchable memory
-		 * window; verify that the upper bits are actually
-		 * writable.
-		 */
-		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &pmem);
-		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
-				       0xffffffff);
-		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
-		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, pmem);
-		if (tmp)
-			bridge->pref_64_window = 1;
-	}
-}
-
 static void pci_read_bridge_io(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
@@ -510,6 +459,57 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 	}
 }
 
+static void pci_read_bridge_windows(struct pci_dev *bridge)
+{
+	u16 io;
+	u32 pmem, tmp;
+
+	pci_read_config_word(bridge, PCI_IO_BASE, &io);
+	if (!io) {
+		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
+		pci_read_config_word(bridge, PCI_IO_BASE, &io);
+		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
+	}
+	if (io)
+		bridge->io_window = 1;
+
+	/*
+	 * DECchip 21050 pass 2 errata: the bridge may miss an address
+	 * disconnect boundary by one PCI data phase.  Workaround: do not
+	 * use prefetching on this device.
+	 */
+	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
+		return;
+
+	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
+	if (!pmem) {
+		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
+					       0xffe0fff0);
+		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
+		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
+	}
+	if (!pmem)
+		return;
+
+	bridge->pref_window = 1;
+
+	if ((pmem & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
+
+		/*
+		 * Bridge claims to have a 64-bit prefetchable memory
+		 * window; verify that the upper bits are actually
+		 * writable.
+		 */
+		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &pmem);
+		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
+				       0xffffffff);
+		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
+		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, pmem);
+		if (tmp)
+			bridge->pref_64_window = 1;
+	}
+}
+
 void pci_read_bridge_bases(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
-- 
2.34.1

