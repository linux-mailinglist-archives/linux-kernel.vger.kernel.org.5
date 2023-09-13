Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11C179E67F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbjIMLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbjIMLVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:21:02 -0400
Received: from smtp111.iad3b.emailsrvr.com (smtp111.iad3b.emailsrvr.com [146.20.161.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C872118
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604058;
        bh=x5etE6hQat85RKwGFWa9VifsFJ9wpy5aUmUk22feDXQ=;
        h=From:To:Subject:Date:From;
        b=on1dWPv79ZrarYZeofxCeBD2R05UZDrxylRLuA+zVLUn1pm8cx7R+Ht2YLE3S5sWO
         0gxp/DH/aDB8/wcQa0R7vwFvGTe9EWVttg91eatXvj4Vh71YgROOm4a4zuW7MhpLR6
         M6Q4X3nqzTSmf6ZV3d8ByMln0Sjdv5pBO1YPu4W8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 84871200C1;
        Wed, 13 Sep 2023 07:20:57 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 08/13] comedi: ni_labpc_common: Conditionally remove I/O port support
Date:   Wed, 13 Sep 2023 12:20:27 +0100
Message-Id: <20230913112032.90618-9-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913112032.90618-1-abbotti@mev.co.uk>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e346d63c-f057-4595-b974-8be9cf32e1c1-9-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends will only be declared in the `HAS_IOPORT` configuration option
is enabled.

The ni_labpc_common module is used by the ni_labpc module (for ISA
cards), the ni_labpc_cs module (for PCMCIA cards), and the ni_labpc_pci
module (for PCI cards).  The ISA and PCMCIA cards use port I/O and the
PCI cards use memory-mapped I/O.

Conditionally compile the parts of the module that use the port I/O
functions so they are compiled if and only if the `CONFIG_HAS_PORTIO`
macro is defined, so that the module can be built if the port I/O
functions have not been declared.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/ni_labpc_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
index 5d5c1d0e9cb6..7170b4e98b5e 100644
--- a/drivers/comedi/drivers/ni_labpc_common.c
+++ b/drivers/comedi/drivers/ni_labpc_common.c
@@ -78,6 +78,9 @@ static const struct comedi_lrange range_labpc_ao = {
  * functions that do inb/outb and readb/writeb so we can use
  * function pointers to decide which to use
  */
+
+#ifdef CONFIG_HAS_PORTIO
+
 static unsigned int labpc_inb(struct comedi_device *dev, unsigned long reg)
 {
 	return inb(dev->iobase + reg);
@@ -89,6 +92,8 @@ static void labpc_outb(struct comedi_device *dev,
 	outb(byte, dev->iobase + reg);
 }
 
+#endif	/* CONFIG_HAS_PORTIO */
+
 static unsigned int labpc_readb(struct comedi_device *dev, unsigned long reg)
 {
 	return readb(dev->mmio + reg);
@@ -1200,8 +1205,12 @@ int labpc_common_attach(struct comedi_device *dev,
 		devpriv->read_byte = labpc_readb;
 		devpriv->write_byte = labpc_writeb;
 	} else {
+#ifdef CONFIG_HAS_PORTIO
 		devpriv->read_byte = labpc_inb;
 		devpriv->write_byte = labpc_outb;
+#else
+		return -ENXIO;
+#endif
 	}
 
 	/* initialize board's command registers */
-- 
2.40.1

