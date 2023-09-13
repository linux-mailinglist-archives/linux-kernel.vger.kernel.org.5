Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAB79E684
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbjIMLVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjIMLVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:21:04 -0400
Received: from smtp109.iad3b.emailsrvr.com (smtp109.iad3b.emailsrvr.com [146.20.161.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D81FE5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604059;
        bh=Pb/sSDvfoGCIM5lyU2VkooMFMiSDDoheHXCljC1iffc=;
        h=From:To:Subject:Date:From;
        b=qzYsEG3UkGWpEIz/rKa0vr5FS3kDQsPDQ9kLlTCdeuI5xgLN9D838QvbYS5qyp782
         TO+YJtQnZLRktwuno664y9PgIs3/1nlnf/unk8kZxf0FX0PXZdI5WtWevQLphPPJ4q
         HS8vS7YPDf8Mlq4AmxaseJUNwWSZmrdq9Q+tC53w=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9A1B2200C0;
        Wed, 13 Sep 2023 07:20:58 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 09/13] comedi: ni_mio_common: Conditionally use I/O port or MMIO
Date:   Wed, 13 Sep 2023 12:20:28 +0100
Message-Id: <20230913112032.90618-10-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913112032.90618-1-abbotti@mev.co.uk>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e346d63c-f057-4595-b974-8be9cf32e1c1-10-1
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

