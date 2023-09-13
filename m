Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360BF79E6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbjIMLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjIMLde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:33:34 -0400
Received: from smtp72.iad3a.emailsrvr.com (smtp72.iad3a.emailsrvr.com [173.203.187.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E01C1FE9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604803;
        bh=jTD6S3A1Mblo08Ha6IHdDgLu3daAAvWNJ47NXzRPFbY=;
        h=From:To:Subject:Date:From;
        b=uWRCzmyVb+JF2ogY8fIBQ1guWcCnRVFnMS+P4+DWN8XEYPm+SjoHSaSYPEyebY0cE
         0RvKwX01XphmY+hu1oEOhRJnLbXkuQi7u+aRMSd6zQu5euizrd0PvmjQQGOam98Qn0
         i7iOYLCbIhVYFAzZ2eKT/XF3PcGnQlDRnEo2Id70=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0238E424B;
        Wed, 13 Sep 2023 07:33:21 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 12/13] comedi: amplc_dio200_common: Conditionally remove I/O port support
Date:   Wed, 13 Sep 2023 12:32:46 +0100
Message-Id: <20230913113247.91749-13-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913113247.91749-1-abbotti@mev.co.uk>
References: <20230913113247.91749-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 007ec4bd-2574-475a-9bbd-5a4f93b29aec-13-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends will only be declared in the `HAS_IOPORT` configuration option
is enabled.

The amplc_dio200_common module is used by the amplc_dio200 module (for
ISA cards) and the amplc_dio200_pci module (for PCI and PCI Express
cards).  It supports both port I/O and memory-mapped I/O.

Port I/O and memory-mapped I/O is confined to the `dio200___read8()`,
`dio200___read32()`, `dio200___write8()` and `dio200___write32()`
functions.  Conditionally compile two versions of those functions.  If
the `CONFIG_HAS_PORTIO` macro is defined, call either the port I/O or
memory mapped I/O functions depending on the `mmio` member of the
`struct comedi_device`.  If the `CONFIG_HAS_PORTIO` macro is undefined
only call the memory-mapped I/O functions.

Add a run-time check to `amplc_dio200_common_attach()` to return an
error if the device wants to use port I/O when the `CONFIG_HAS_PORTIO`
macro is undefined.

The changes allow the module to be built even if the port I/O functions
have not been declared.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/amplc_dio200_common.c | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
index e6d63e89e7bf..b1a9b4c4a185 100644
--- a/drivers/comedi/drivers/amplc_dio200_common.c
+++ b/drivers/comedi/drivers/amplc_dio200_common.c
@@ -86,6 +86,8 @@ struct dio200_subdev_intr {
 	unsigned int active:1;
 };
 
+#ifdef CONFIG_HAS_IOPORT
+
 static unsigned char dio200___read8(struct comedi_device *dev,
 				    unsigned int offset)
 {
@@ -120,6 +122,34 @@ static void dio200___write32(struct comedi_device *dev,
 		outl(val, dev->iobase + offset);
 }
 
+#else /* CONFIG_HAS_IOPORT */
+
+static unsigned char dio200___read8(struct comedi_device *dev,
+				    unsigned int offset)
+{
+	return readb(dev->mmio + offset);
+}
+
+static void dio200___write8(struct comedi_device *dev,
+			    unsigned int offset, unsigned char val)
+{
+	writeb(val, dev->mmio + offset);
+}
+
+static unsigned int dio200___read32(struct comedi_device *dev,
+				    unsigned int offset)
+{
+	return readl(dev->mmio + offset);
+}
+
+static void dio200___write32(struct comedi_device *dev,
+			     unsigned int offset, unsigned int val)
+{
+	writel(val, dev->mmio + offset);
+}
+
+#endif /* CONFIG_HAS_IOPORT */
+
 static unsigned char dio200_read8(struct comedi_device *dev,
 				  unsigned int offset)
 {
@@ -803,6 +833,12 @@ int amplc_dio200_common_attach(struct comedi_device *dev, unsigned int irq,
 	unsigned int n;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT) && !dev->mmio) {
+		dev_err(dev->class_dev,
+			"error! need I/O port support\n");
+		return -ENXIO;
+	}
+
 	ret = comedi_alloc_subdevices(dev, board->n_subdevs);
 	if (ret)
 		return ret;
-- 
2.40.1

