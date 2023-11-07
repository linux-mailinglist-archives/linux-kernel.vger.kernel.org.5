Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6907E4D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjKGX3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbjKGX3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:29:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D24B478E;
        Tue,  7 Nov 2023 15:25:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EBFC433BA;
        Tue,  7 Nov 2023 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399546;
        bh=meuXTQUTg2+8V3d9odHuqZExsixHpWWCDY77uQNM2uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ7edgfRuBxuBX2zUyQqAv9DphouJp7SZZCAeJ+HWrxEy0WQqsdXIc44fujcN5nW1
         S+tqFWZ2gm7LCMRE2pg5GZCtltG80YhLnxG40NZIce0usO6UGtbkAXh0DDyiLHCsEf
         B0d2L6SYBFW5vrJ4NQ8szIAN9rQrC4TmcN9PO+yIblsFWYXdjc1DTsSq8cIIZUh1x8
         ji1RIQBpuWDvuAxsFspjmAzIC4NNBrtXKqq36SkmLFrcAOYNXoI2c60Fb7RViP+17n
         6WmQTRIUg869SlU3aiW0x7ZjHzVRow2sUwOCMBek618016JjhfJvenOgQ9GnNr5OEY
         81orK7B/C/kZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/2] usb: pci-quirks: handle HAS_IOPORT dependency for UHCI handoff
Date:   Tue,  7 Nov 2023 18:25:41 -0500
Message-ID: <20231107232541.3777102-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232541.3777102-1-sashal@kernel.org>
References: <20231107232541.3777102-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 358ad297e379ff548247e3e24c6619559942bfdd ]

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. With the AMD quirk handled USB PCI quirks still use
inw() in uhci_check_and_reset_hc() and thus indirectly in
quirk_usb_handoff_uhci(). Handle this by conditionally compiling
uhci_check_and_reset_hc() and stubbing out quirk_usb_handoff_uhci() when
HAS_IOPORT is not available.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Link: https://lore.kernel.org/r/20230911125653.1393895-4-schnelle@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/pci-quirks.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index f5f2c83a2c669..03fa22fc6a074 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -627,6 +627,16 @@ bool usb_amd_pt_check_port(struct device *device, int port)
 }
 EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
 
+static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
+{
+	u16 cmd;
+
+	return !pci_read_config_word(pdev, PCI_COMMAND, &cmd) && (cmd & mask);
+}
+
+#define mmio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_MEMORY)
+
+#if defined(CONFIG_HAS_IOPORT) && IS_ENABLED(CONFIG_USB_UHCI_HCD)
 /*
  * Make sure the controller is completely inactive, unable to
  * generate interrupts or do DMA.
@@ -708,14 +718,7 @@ int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base)
 }
 EXPORT_SYMBOL_GPL(uhci_check_and_reset_hc);
 
-static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
-{
-	u16 cmd;
-	return !pci_read_config_word(pdev, PCI_COMMAND, &cmd) && (cmd & mask);
-}
-
 #define pio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_IO)
-#define mmio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_MEMORY)
 
 static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {
@@ -735,6 +738,12 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
 		uhci_check_and_reset_hc(pdev, base);
 }
 
+#else /* defined(CONFIG_HAS_IOPORT && IS_ENABLED(CONFIG_USB_UHCI_HCD) */
+
+static void quirk_usb_handoff_uhci(struct pci_dev *pdev) {}
+
+#endif /* defined(CONFIG_HAS_IOPORT && IS_ENABLED(CONFIG_USB_UHCI_HCD) */
+
 static int mmio_resource_enabled(struct pci_dev *pdev, int idx)
 {
 	return pci_resource_start(pdev, idx) && mmio_enabled(pdev);
-- 
2.42.0

