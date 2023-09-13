Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26479E6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjIMLdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbjIMLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:33:18 -0400
Received: from smtp73.iad3a.emailsrvr.com (smtp73.iad3a.emailsrvr.com [173.203.187.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5319B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604793;
        bh=vGdISjzSsCl7AP5nEB0MZrEzyOvgK8VcBZUCftmqT4w=;
        h=From:To:Subject:Date:From;
        b=cbZ1PJzwepFSc+uYiavikh96noulWZ1zwRBBFavSyYX67iqfpb2a8xvh3eB3hlN0q
         Ud4aBTppKfgkskTilS2pqW+tFROhPxnxNmy08Tn46aJgckSvz0Yrd4EW2DCicGXd+K
         h29oBU3h8cBimsSdyb2qYVUIJBgTf+380/gMx3a0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 83B8B3B4D;
        Wed, 13 Sep 2023 07:33:12 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 05/13] comedi: 8255_pci: Conditionally remove devices that use port I/O
Date:   Wed, 13 Sep 2023 12:32:39 +0100
Message-Id: <20230913113247.91749-6-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913113247.91749-1-abbotti@mev.co.uk>
References: <20230913113247.91749-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 007ec4bd-2574-475a-9bbd-5a4f93b29aec-6-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends will only be declared in the `HAS_IOPORT` configuration option
is enabled.

The 8255_pci module supports PCI digital I/O devices from various
manufacturers that consist of one or more 8255 Programmable Peripheral
Interface chips (or equivalent hardware) to provide their digital I/O
ports.  Some of the devices use port I/O and some only use memory-mapped
I/O.

Conditionally compile in support for the devices that need port I/O if
and only if the `CONFIG_HAS_PORTIO` macro is defined.  Change
`pci_8255_auto_attach()` to return an error if the device actually
requires port I/O (based on the PCI BAR resource flags) but the
`HAS_IOPORT` configuration is not enabled.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/8255_pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/8255_pci.c b/drivers/comedi/drivers/8255_pci.c
index 0fec048e3a53..4c4c0ef1db05 100644
--- a/drivers/comedi/drivers/8255_pci.c
+++ b/drivers/comedi/drivers/8255_pci.c
@@ -57,6 +57,7 @@
 #include <linux/comedi/comedi_8255.h>
 
 enum pci_8255_boardid {
+#ifdef CONFIG_HAS_PORTIO
 	BOARD_ADLINK_PCI7224,
 	BOARD_ADLINK_PCI7248,
 	BOARD_ADLINK_PCI7296,
@@ -65,6 +66,7 @@ enum pci_8255_boardid {
 	BOARD_CB_PCIDIO48H_OLD,
 	BOARD_CB_PCIDIO48H_NEW,
 	BOARD_CB_PCIDIO96H,
+#endif	/* CONFIG_HAS_PORTIO */
 	BOARD_NI_PCIDIO96,
 	BOARD_NI_PCIDIO96B,
 	BOARD_NI_PXI6508,
@@ -82,6 +84,7 @@ struct pci_8255_boardinfo {
 };
 
 static const struct pci_8255_boardinfo pci_8255_boards[] = {
+#ifdef CONFIG_HAS_PORTIO
 	[BOARD_ADLINK_PCI7224] = {
 		.name		= "adl_pci-7224",
 		.dio_badr	= 2,
@@ -122,6 +125,7 @@ static const struct pci_8255_boardinfo pci_8255_boards[] = {
 		.dio_badr	= 2,
 		.n_8255		= 4,
 	},
+#endif	/* CONFIG_HAS_PORTIO */
 	[BOARD_NI_PCIDIO96] = {
 		.name		= "ni_pci-dio-96",
 		.dio_badr	= 1,
@@ -219,8 +223,11 @@ static int pci_8255_auto_attach(struct comedi_device *dev,
 		dev->mmio = pci_ioremap_bar(pcidev, board->dio_badr);
 		if (!dev->mmio)
 			return -ENOMEM;
-	} else {
+	} else if (IS_ENABLED(CONFIG_HAS_PORTIO)) {
 		dev->iobase = pci_resource_start(pcidev, board->dio_badr);
+	} else {
+		dev_err(dev->class_dev, "error! need I/O port support\n");
+		return -ENXIO;
 	}
 
 	/*
@@ -259,6 +266,7 @@ static int pci_8255_pci_probe(struct pci_dev *dev,
 }
 
 static const struct pci_device_id pci_8255_pci_table[] = {
+#ifdef CONFIG_HAS_PORTIO
 	{ PCI_VDEVICE(ADLINK, 0x7224), BOARD_ADLINK_PCI7224 },
 	{ PCI_VDEVICE(ADLINK, 0x7248), BOARD_ADLINK_PCI7248 },
 	{ PCI_VDEVICE(ADLINK, 0x7296), BOARD_ADLINK_PCI7296 },
@@ -269,6 +277,7 @@ static const struct pci_device_id pci_8255_pci_table[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CB, 0x000b, PCI_VENDOR_ID_CB, 0x000b),
 	  .driver_data = BOARD_CB_PCIDIO48H_NEW },
 	{ PCI_VDEVICE(CB, 0x0017), BOARD_CB_PCIDIO96H },
+#endif	/* CONFIG_HAS_PORTIO */
 	{ PCI_VDEVICE(NI, 0x0160), BOARD_NI_PCIDIO96 },
 	{ PCI_VDEVICE(NI, 0x1630), BOARD_NI_PCIDIO96B },
 	{ PCI_VDEVICE(NI, 0x13c0), BOARD_NI_PXI6508 },
-- 
2.40.1

