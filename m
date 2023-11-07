Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18437E4D80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbjKGXgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344501AbjKGXgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:36:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9043C38;
        Tue,  7 Nov 2023 15:25:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C030C433CA;
        Tue,  7 Nov 2023 23:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399525;
        bh=DaEoBjzBN+vCwMrV9Gjr42aKwUiFZczz9zbfOkbk6lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acyDdrIxFlzeHfzhAMQuEXVf5ibQsmvVyvQNZPdlOqmUp8FVf3HrF6P/FseBn0kyf
         Gt1TW1kdLyw3Lpd1JEvIl8KpxFg+Z00xR/MHd6oULPlSGADSgEQnUxVAlC8DUJZT+t
         JoD73a4GVTVT7GlPL3eOTnRfp1WxmD0m5gYgDCQh7pDUAA4FjC/QHNUpFNlMdZbbPf
         pqf8DJ5kdDW9EgvpzzULqu1GIZShrxs61VHF7tb4LgpFBurhtDv614/+wMhMFOmmHb
         PLPPuqIqjxZlS1cW5NkjfJmCjh0x1Vs5MMeR54c1X0TwkHXW0pwpBUG9qyYMrXrejN
         9lRN32QNvgCaQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/4] usb: pci-quirks: handle HAS_IOPORT dependency for UHCI handoff
Date:   Tue,  7 Nov 2023 18:25:15 -0500
Message-ID: <20231107232519.3776922-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232519.3776922-1-sashal@kernel.org>
References: <20231107232519.3776922-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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
index c178eb89070f6..766d965c11c5f 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -631,6 +631,16 @@ void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
 
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
@@ -712,14 +722,7 @@ int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base)
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
@@ -739,6 +742,12 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
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

