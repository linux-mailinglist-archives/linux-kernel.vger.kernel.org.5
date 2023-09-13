Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC15679EF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjIMQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjIMQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:17 -0400
Received: from smtp70.iad3a.emailsrvr.com (smtp70.iad3a.emailsrvr.com [173.203.187.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A326D421C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623241;
        bh=3DYoyucexyp3NqVzJwqSlUjI+W/qqxsbxRCtw8SQXNI=;
        h=From:To:Subject:Date:From;
        b=WUwaPRFnrEwUYx9OhkC9SGBLTd1kGg1IgqecM8VgkAZPsac33Zni09nRGXGkt8ZER
         gtmgyFYKq+PaxMvO/9C8iKCELS35GrbkTtzLZddobKH5T5FbsKB8oBOAdtzt/tqo7X
         +NKWRukLpJmuoFNBXS/a/8Nn7/+pQtb1iohBCpR8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0EF7E2391B;
        Wed, 13 Sep 2023 12:40:39 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 10/13] comedi: amplc_dio200_pci: Conditionally remove devices that use port I/O
Date:   Wed, 13 Sep 2023 17:40:10 +0100
Message-Id: <20230913164013.107520-11-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-11-1
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
and only if the `CONFIG_HAS_IOPORT` macro is defined.

Add a run-time check in `dio200_pci_auto_attach()` to return an error if
the device actually requires port I/O (based on the PCI BAR resource
flags) but the `HAS_IOPORT` configuration option is not enabled.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct `CONFIG_HAS_PORTIO` to `CONFIG_HAS_IOPORT` in commit
description.
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

