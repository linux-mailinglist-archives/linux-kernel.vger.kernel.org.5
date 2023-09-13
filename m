Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8900E79E6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbjIMLdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbjIMLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:33:32 -0400
Received: from smtp75.iad3a.emailsrvr.com (smtp75.iad3a.emailsrvr.com [173.203.187.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011D71BEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604800;
        bh=uLhfAgflV0leHcWKdgbLK0rcyQ0A5RWhfZPt2aW2IHY=;
        h=From:To:Subject:Date:From;
        b=bqG2GNImRQM2z8MHxGCv+JYgDdl/7k8XM36T9dme6/yTxbc33X3/B160dXMTose+5
         93zW/q8w4ayokl73WwR+2SLCDCOjKVZ4ukab4/N3rOjgT8o/0gU+6bzF9tVfwtCEle
         0aO1+MeihFZ0DbM5shI/8aRe7YWDPWL/N6YU748M=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 5A2C94227;
        Wed, 13 Sep 2023 07:33:19 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 10/13] comedi: amplc_dio200_pci: Conditionally remove devices that use port I/O
Date:   Wed, 13 Sep 2023 12:32:44 +0100
Message-Id: <20230913113247.91749-11-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913113247.91749-1-abbotti@mev.co.uk>
References: <20230913113247.91749-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 007ec4bd-2574-475a-9bbd-5a4f93b29aec-11-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends will only be declared in the `HAS_IOPORT` configuration option
is enabled.

The amplc_dio200_pci module supports various Amplicon PCI and PCI
Express devices.  Some of the supported devices (the PCI ones) use port
I/O, and some of them (the PCIe ones) only use memory-mapped I/O.

Conditionally compile in support for the devices that need port I/O if
and only if the `CONFIG_HAS_PORTIO` macro is defined.

Add a run-time check in `dio200_pci_auto_attach()` to return an error if
the device actually requires port I/O (based on the PCI BAR resource
flags) but the `HAS_IOPORT` configuration option is not enabled.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/amplc_dio200_pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/amplc_dio200_pci.c b/drivers/comedi/drivers/amplc_dio200_pci.c
index 527994d82a1f..cb5b328a28e3 100644
--- a/drivers/comedi/drivers/amplc_dio200_pci.c
+++ b/drivers/comedi/drivers/amplc_dio200_pci.c
@@ -223,14 +223,17 @@
  */
 
 enum dio200_pci_model {
+#ifdef CONFIG_HAS_IOPORT
 	pci215_model,
 	pci272_model,
+#endif /* CONFIG_HAS_IOPORT */
 	pcie215_model,
 	pcie236_model,
 	pcie296_model
 };
 
 static const struct dio200_board dio200_pci_boards[] = {
+#ifdef CONFIG_HAS_IOPORT
 	[pci215_model] = {
 		.name		= "pci215",
 		.mainbar	= 2,
@@ -252,6 +255,7 @@ static const struct dio200_board dio200_pci_boards[] = {
 		.sdinfo		= { 0x00, 0x08, 0x10, 0x3f },
 		.has_int_sce	= true,
 	},
+#endif /* CONFIG_HAS_IOPORT */
 	[pcie215_model] = {
 		.name		= "pcie215",
 		.mainbar	= 1,
@@ -364,8 +368,12 @@ static int dio200_pci_auto_attach(struct comedi_device *dev,
 				"error! cannot remap registers\n");
 			return -ENOMEM;
 		}
-	} else {
+	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
 		dev->iobase = pci_resource_start(pci_dev, bar);
+	} else {
+		dev_err(dev->class_dev,
+			"error! need I/O port support\n");
+		return -ENXIO;
 	}
 
 	if (board->is_pcie) {
@@ -385,8 +393,10 @@ static struct comedi_driver dio200_pci_comedi_driver = {
 };
 
 static const struct pci_device_id dio200_pci_table[] = {
+#ifdef CONFIG_HAS_IOPORT
 	{ PCI_VDEVICE(AMPLICON, 0x000b), pci215_model },
 	{ PCI_VDEVICE(AMPLICON, 0x000a), pci272_model },
+#endif /* CONFIG_HAS_IOPORT */
 	{ PCI_VDEVICE(AMPLICON, 0x0011), pcie236_model },
 	{ PCI_VDEVICE(AMPLICON, 0x0012), pcie215_model },
 	{ PCI_VDEVICE(AMPLICON, 0x0014), pcie296_model },
-- 
2.40.1

