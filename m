Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8138479EF09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjIMQnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjIMQmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:42:55 -0400
Received: from smtp69.iad3a.emailsrvr.com (smtp69.iad3a.emailsrvr.com [173.203.187.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A498B3AB0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623230;
        bh=3OpSotYlI5Vmvy9kosOkaQx9lHgk5sHnMlJq3LB316E=;
        h=From:To:Subject:Date:From;
        b=CBwlazGjmPWp8QpQHA0lMHp/idE8gVMbp/dbYyaHacaxHA9VkQSV3DDp1kw3uMwSY
         uVCOiBcGAoMj5dMdtjf5IAFRd42Y2XxX+RnR2Gh8fkgpTYY5rd7GFG7ZVbqBvL0KAq
         i6iouxZPRU/nSkSVRhI9DlIxI1p38UAkvzCV4n6U=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id EEDE22391B;
        Wed, 13 Sep 2023 12:40:28 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 02/13] comedi: comedi_8254: Use a call-back function for register access
Date:   Wed, 13 Sep 2023 17:40:02 +0100
Message-Id: <20230913164013.107520-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-3-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the comedi_8254 module to use a call-back function for register
access.  This will make it easier to isolate the parts that will depend
on the `CONFIG_HAS_IOPORT` macro being defined and also allows the
possibility of supplying an external callback function during
initialization by a variant of the `comedi_8254_init()` and
`comedi_8254_mm_init()` functions, although that has not been
implemented yet.

The `struct comedi_8254` members have been changed to use a pointer to a
callback function and a context of type `unsigned long`.  The
`comedi_8254_init()` and `comedi_8254_mm_init()` functions use an
internal callback function and set the context to the base address of
the registers (for `comedi_8254_mm_init()` that involves converting a
`void __iomem *` to `unsigned long`).

A minor change to `dio200_subdev_8254_offset()` in the
amplc_dio200_common module has been made due to the changes in `struct
comedi_8254`.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: N/A
---
 drivers/comedi/drivers/amplc_dio200_common.c |   4 +-
 drivers/comedi/drivers/comedi_8254.c         | 177 +++++++++++++------
 include/linux/comedi/comedi_8254.h           |  22 ++-
 3 files changed, 144 insertions(+), 59 deletions(-)

diff --git a/drivers/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
index ff651f2eb86c..2c1507a23f8a 100644
--- a/drivers/comedi/drivers/amplc_dio200_common.c
+++ b/drivers/comedi/drivers/amplc_dio200_common.c
@@ -149,9 +149,9 @@ static unsigned int dio200_subdev_8254_offset(struct comedi_device *dev,
 
 	/* get the offset that was passed to comedi_8254_*_init() */
 	if (dev->mmio)
-		offset = i8254->mmio - dev->mmio;
+		offset = (void __iomem *)i8254->context - dev->mmio;
 	else
-		offset = i8254->iobase - dev->iobase;
+		offset = i8254->context - dev->iobase;
 
 	/* remove the shift that was added for PCIe boards */
 	if (board->is_pcie)
diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index b4185c1b2695..3f8657fc7ee5 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
@@ -119,63 +119,101 @@
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8254.h>
 
-static unsigned int __i8254_read(struct comedi_8254 *i8254, unsigned int reg)
+static unsigned int i8254_io8_cb(struct comedi_8254 *i8254, int dir,
+				unsigned int reg, unsigned int val)
 {
-	unsigned int reg_offset = (reg * i8254->iosize) << i8254->regshift;
-	unsigned int val;
+	unsigned long iobase = i8254->context;
+	unsigned int reg_offset = (reg * I8254_IO8) << i8254->regshift;
 
-	switch (i8254->iosize) {
-	default:
-	case I8254_IO8:
-		if (i8254->mmio)
-			val = readb(i8254->mmio + reg_offset);
-		else
-			val = inb(i8254->iobase + reg_offset);
-		break;
-	case I8254_IO16:
-		if (i8254->mmio)
-			val = readw(i8254->mmio + reg_offset);
-		else
-			val = inw(i8254->iobase + reg_offset);
-		break;
-	case I8254_IO32:
-		if (i8254->mmio)
-			val = readl(i8254->mmio + reg_offset);
-		else
-			val = inl(i8254->iobase + reg_offset);
-		break;
+	if (dir) {
+		outb(val, iobase + reg_offset);
+		return 0;
+	} else {
+		return inb(iobase + reg_offset);
 	}
-	return val & 0xff;
 }
 
-static void __i8254_write(struct comedi_8254 *i8254,
-			  unsigned int val, unsigned int reg)
+static unsigned int i8254_io16_cb(struct comedi_8254 *i8254, int dir,
+				  unsigned int reg, unsigned int val)
 {
-	unsigned int reg_offset = (reg * i8254->iosize) << i8254->regshift;
+	unsigned long iobase = i8254->context;
+	unsigned int reg_offset = (reg * I8254_IO16) << i8254->regshift;
 
-	switch (i8254->iosize) {
-	default:
-	case I8254_IO8:
-		if (i8254->mmio)
-			writeb(val, i8254->mmio + reg_offset);
-		else
-			outb(val, i8254->iobase + reg_offset);
-		break;
-	case I8254_IO16:
-		if (i8254->mmio)
-			writew(val, i8254->mmio + reg_offset);
-		else
-			outw(val, i8254->iobase + reg_offset);
-		break;
-	case I8254_IO32:
-		if (i8254->mmio)
-			writel(val, i8254->mmio + reg_offset);
-		else
-			outl(val, i8254->iobase + reg_offset);
-		break;
+	if (dir) {
+		outw(val, iobase + reg_offset);
+		return 0;
+	} else {
+		return inw(iobase + reg_offset);
+	}
+}
+
+static unsigned int i8254_io32_cb(struct comedi_8254 *i8254, int dir,
+				  unsigned int reg, unsigned int val)
+{
+	unsigned long iobase = i8254->context;
+	unsigned int reg_offset = (reg * I8254_IO32) << i8254->regshift;
+
+	if (dir) {
+		outl(val, iobase + reg_offset);
+		return 0;
+	} else {
+		return inl(iobase + reg_offset);
+	}
+}
+
+static unsigned int i8254_mmio8_cb(struct comedi_8254 *i8254, int dir,
+				   unsigned int reg, unsigned int val)
+{
+	void __iomem *mmiobase = (void __iomem *)i8254->context;
+	unsigned int reg_offset = (reg * I8254_IO8) << i8254->regshift;
+
+	if (dir) {
+		writeb(val, mmiobase + reg_offset);
+		return 0;
+	} else {
+		return readb(mmiobase + reg_offset);
+	}
+}
+
+static unsigned int i8254_mmio16_cb(struct comedi_8254 *i8254, int dir,
+				    unsigned int reg, unsigned int val)
+{
+	void __iomem *mmiobase = (void __iomem *)i8254->context;
+	unsigned int reg_offset = (reg * I8254_IO16) << i8254->regshift;
+
+	if (dir) {
+		writew(val, mmiobase + reg_offset);
+		return 0;
+	} else {
+		return readw(mmiobase + reg_offset);
 	}
 }
 
+static unsigned int i8254_mmio32_cb(struct comedi_8254 *i8254, int dir,
+				    unsigned int reg, unsigned int val)
+{
+	void __iomem *mmiobase = (void __iomem *)i8254->context;
+	unsigned int reg_offset = (reg * I8254_IO32) << i8254->regshift;
+
+	if (dir) {
+		writel(val, mmiobase + reg_offset);
+		return 0;
+	} else {
+		return readl(mmiobase + reg_offset);
+	}
+}
+
+static unsigned int __i8254_read(struct comedi_8254 *i8254, unsigned int reg)
+{
+	return 0xff & i8254->iocb(i8254, 0, reg, 0);
+}
+
+static void __i8254_write(struct comedi_8254 *i8254,
+			  unsigned int val, unsigned int reg)
+{
+	i8254->iocb(i8254, 1, reg, val);
+}
+
 /**
  * comedi_8254_status - return the status of a counter
  * @i8254:	comedi_8254 struct for the timer
@@ -571,8 +609,8 @@ void comedi_8254_subdevice_init(struct comedi_subdevice *s,
 }
 EXPORT_SYMBOL_GPL(comedi_8254_subdevice_init);
 
-static struct comedi_8254 *__i8254_init(unsigned long iobase,
-					void __iomem *mmio,
+static struct comedi_8254 *__i8254_init(comedi_8254_iocb_fn *iocb,
+					unsigned long context,
 					unsigned int osc_base,
 					unsigned int iosize,
 					unsigned int regshift)
@@ -585,12 +623,15 @@ static struct comedi_8254 *__i8254_init(unsigned long iobase,
 	      iosize == I8254_IO32))
 		return NULL;
 
+	if (!iocb)
+		return NULL;
+
 	i8254 = kzalloc(sizeof(*i8254), GFP_KERNEL);
 	if (!i8254)
 		return NULL;
 
-	i8254->iobase	= iobase;
-	i8254->mmio	= mmio;
+	i8254->iocb	= iocb;
+	i8254->context	= context;
 	i8254->iosize	= iosize;
 	i8254->regshift	= regshift;
 
@@ -617,7 +658,22 @@ struct comedi_8254 *comedi_8254_init(unsigned long iobase,
 				     unsigned int iosize,
 				     unsigned int regshift)
 {
-	return __i8254_init(iobase, NULL, osc_base, iosize, regshift);
+	comedi_8254_iocb_fn *iocb;
+
+	switch (iosize) {
+	case I8254_IO8:
+		iocb = i8254_io8_cb;
+		break;
+	case I8254_IO16:
+		iocb = i8254_io16_cb;
+		break;
+	case I8254_IO32:
+		iocb = i8254_io32_cb;
+		break;
+	default:
+		return NULL;
+	}
+	return __i8254_init(iocb, iobase, osc_base, iosize, regshift);
 }
 EXPORT_SYMBOL_GPL(comedi_8254_init);
 
@@ -634,7 +690,22 @@ struct comedi_8254 *comedi_8254_mm_init(void __iomem *mmio,
 					unsigned int iosize,
 					unsigned int regshift)
 {
-	return __i8254_init(0, mmio, osc_base, iosize, regshift);
+	comedi_8254_iocb_fn *iocb;
+
+	switch (iosize) {
+	case I8254_IO8:
+		iocb = i8254_mmio8_cb;
+		break;
+	case I8254_IO16:
+		iocb = i8254_mmio16_cb;
+		break;
+	case I8254_IO32:
+		iocb = i8254_mmio32_cb;
+		break;
+	default:
+		return NULL;
+	}
+	return __i8254_init(iocb, (unsigned long)mmio, osc_base, iosize, regshift);
 }
 EXPORT_SYMBOL_GPL(comedi_8254_mm_init);
 
diff --git a/include/linux/comedi/comedi_8254.h b/include/linux/comedi/comedi_8254.h
index d8264417e53c..18d12321c87d 100644
--- a/include/linux/comedi/comedi_8254.h
+++ b/include/linux/comedi/comedi_8254.h
@@ -57,10 +57,24 @@ struct comedi_subdevice;
 /* counter maps zero to 0x10000 */
 #define I8254_MAX_COUNT			0x10000
 
+struct comedi_8254;
+
+/**
+ * typedef comedi_8254_iocb_fn - call-back function type for 8254 register access
+ * @i8254:		pointer to struct comedi_8254
+ * @dir:		direction (0 = read, 1 = write)
+ * @reg:		register number
+ * @val:		value to write
+ *
+ * Return: Register value when reading, 0 when writing.
+ */
+typedef unsigned int comedi_8254_iocb_fn(struct comedi_8254 *i8254, int dir,
+					 unsigned int reg, unsigned int val);
+
 /**
  * struct comedi_8254 - private data used by this module
- * @iobase:		PIO base address of the registers (in/out)
- * @mmio:		MMIO base address of the registers (read/write)
+ * @iocb:		I/O call-back function for register access
+ * @context:		context for register access (e.g. a base address)
  * @iosize:		I/O size used to access the registers (b/w/l)
  * @regshift:		register gap shift
  * @osc_base:		cascaded oscillator speed in ns
@@ -76,8 +90,8 @@ struct comedi_subdevice;
  * @insn_config:	driver specific (*insn_config) callback
  */
 struct comedi_8254 {
-	unsigned long iobase;
-	void __iomem *mmio;
+	comedi_8254_iocb_fn *iocb;
+	unsigned long context;
 	unsigned int iosize;
 	unsigned int regshift;
 	unsigned int osc_base;
-- 
2.40.1

