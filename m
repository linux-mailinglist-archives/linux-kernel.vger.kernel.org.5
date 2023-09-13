Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD579EF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjIMQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjIMQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:13 -0400
Received: from smtp70.iad3a.emailsrvr.com (smtp70.iad3a.emailsrvr.com [173.203.187.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4CF420A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623239;
        bh=ej5eHlTJiDV8zMDOqgvn/HROCuMQrTku80Mf0Ox1bWU=;
        h=From:To:Subject:Date:From;
        b=IC5MwdM5cyXvxTALAT28deGnfUCe+8qcoLvEay4rJuWuXUa3fZio5GKOiPjxScTie
         /j+lCOB4YtwWzEUCwKDlMBCtBzbIMvzqpydttehxJ0U4xklVjJHYyTWtYYRvfkEYzD
         dybzN2iQsNAGWt42VuDFwa7VmHhw6ffQZ3jPU8eA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id B3E98239DD;
        Wed, 13 Sep 2023 12:40:38 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 09/13] comedi: ni_mio_common: Conditionally use I/O port or MMIO
Date:   Wed, 13 Sep 2023 17:40:09 +0100
Message-Id: <20230913164013.107520-10-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-10-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends will only be declared in the `HAS_IOPORT` configuration option
is enabled.

The "ni_mio_common.c" file contains calls to both port I/O functions and
memory-mapped I/O functions.  The file is `#include`d by "ni_atmio.c",
"ni_mio_cs.c", and "ni_pcimio.c" for the ni_atmio, ni_mio_cs, and
ni_pcimio modules, respectively.  Only "ni_pcimio.c" defines the
`PCIDMA` macro before including "ni_mio_common.c" and various bits of
code in "ni_mio_common.c" is conditionally compiled according to whether
that macro is defined or not.  Currently, the port I/O function calls
are compiled in regardless of whether the `PCIDMA` macro is defined or
not.  However, the fact is that the ni_atmio and ni_mio_cs modules will
never call the memory-mapped I/O functions, and the ni_pcimio module
will never call the port I/O functions.

Calls to the port I/O and memory-mapped I/O functions is confined to the
`ni_writel()`, `ni_writew()`, `ni_writeb()`, `ni_readl()`, `ni_readw()`,
and `ni_readb()` functions which do a run-time test to decide whether to
call the port I/O functions or the memory-mapped I/O functions.
Conditionally compile two variants of the functions so they only call
the port I/O functions if the `PCIDMA` macro is undefined (for the
ni_atmio and ni_mio_cs modules), and only call the memory-mapped I/O
functions if the `PCIDMA` macro is defined (for the ni_pcimio module).

Add a run-time check in the `ni_E_init()` function to return an error if
the comedi device has been set up to use port I/O if `PCIDMA` is
defined, or has been set up to use memory-mapped I/O if `PCIDMA` is not
defined.

The changes make it possible to build the ni_pcimio module even if the
port I/O functions have not been declared.  (The ni_atmio and ni_mio_cs
modules do still require the port I/O functions to be declared.)

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
v2: N/A
---
 drivers/comedi/drivers/ni_mio_common.c | 70 ++++++++++++++++++--------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
index 638be08b43e4..980f309d6de7 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -46,6 +46,12 @@
 #include <linux/comedi/comedi_8255.h>
 #include "mite.h"
 
+#ifdef PCIDMA
+#define IS_PCIMIO 1
+#else
+#define IS_PCIMIO 0
+#endif
+
 /* A timeout count */
 #define NI_TIMEOUT 1000
 
@@ -219,54 +225,72 @@ enum timebase_nanoseconds {
 
 static const int num_adc_stages_611x = 3;
 
+#ifdef PCIDMA
+
 static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
 {
-	if (dev->mmio)
-		writel(data, dev->mmio + reg);
-	else
-		outl(data, dev->iobase + reg);
+	writel(data, dev->mmio + reg);
 }
 
 static void ni_writew(struct comedi_device *dev, unsigned int data, int reg)
 {
-	if (dev->mmio)
-		writew(data, dev->mmio + reg);
-	else
-		outw(data, dev->iobase + reg);
+	writew(data, dev->mmio + reg);
 }
 
 static void ni_writeb(struct comedi_device *dev, unsigned int data, int reg)
 {
-	if (dev->mmio)
-		writeb(data, dev->mmio + reg);
-	else
-		outb(data, dev->iobase + reg);
+	writeb(data, dev->mmio + reg);
 }
 
 static unsigned int ni_readl(struct comedi_device *dev, int reg)
 {
-	if (dev->mmio)
-		return readl(dev->mmio + reg);
+	return readl(dev->mmio + reg);
+}
+
+static unsigned int ni_readw(struct comedi_device *dev, int reg)
+{
+	return readw(dev->mmio + reg);
+}
+
+static unsigned int ni_readb(struct comedi_device *dev, int reg)
+{
+	return readb(dev->mmio + reg);
+}
 
+#else /* PCIDMA */
+
+static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
+{
+	outl(data, dev->iobase + reg);
+}
+
+static void ni_writew(struct comedi_device *dev, unsigned int data, int reg)
+{
+	outw(data, dev->iobase + reg);
+}
+
+static void ni_writeb(struct comedi_device *dev, unsigned int data, int reg)
+{
+	outb(data, dev->iobase + reg);
+}
+
+static unsigned int ni_readl(struct comedi_device *dev, int reg)
+{
 	return inl(dev->iobase + reg);
 }
 
 static unsigned int ni_readw(struct comedi_device *dev, int reg)
 {
-	if (dev->mmio)
-		return readw(dev->mmio + reg);
-
 	return inw(dev->iobase + reg);
 }
 
 static unsigned int ni_readb(struct comedi_device *dev, int reg)
 {
-	if (dev->mmio)
-		return readb(dev->mmio + reg);
-
 	return inb(dev->iobase + reg);
 }
 
+#endif /* PCIDMA */
+
 /*
  * We automatically take advantage of STC registers that can be
  * read/written directly in the I/O space of the board.
@@ -5977,6 +6001,12 @@ static int ni_E_init(struct comedi_device *dev,
 	int i;
 	const char *dev_family = devpriv->is_m_series ? "ni_mseries"
 						      : "ni_eseries";
+	if (!IS_PCIMIO != !dev->mmio) {
+		dev_err(dev->class_dev,
+			"%s: bug! %s device not supported.\n",
+			KBUILD_MODNAME, board->name);
+		return -ENXIO;
+	}
 
 	/* prepare the device for globally-named routes. */
 	if (ni_assign_device_routes(dev_family, board->name,
-- 
2.40.1

