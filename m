Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36779EF17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjIMQn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjIMQnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:02 -0400
Received: from smtp68.iad3a.emailsrvr.com (smtp68.iad3a.emailsrvr.com [173.203.187.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668471BD7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623235;
        bh=I+3tYDBvgCASgcPMlE1EuA+siMZcLiAYrCF5qCsFuNk=;
        h=From:To:Subject:Date:From;
        b=bfOLwGwu6DCMaMbaU04NAuNgocsEhKpMH5YWiuyZ+sPEXvyGkX7p3Yf8zoxIUiEZ5
         tnrzfonQYtB+PynhAMJElQKevqu6yt3udrJN5lC493ZCxj3uKV71dZ3wiM0k9dWG5c
         It+62DopQqUYlyC5jNm/svlk9hVFzwwoZcfdoEPw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 908CC22FDF;
        Wed, 13 Sep 2023 12:40:34 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 06/13] comedi: comedi_8255: Rework subdevice initialization functions
Date:   Wed, 13 Sep 2023 17:40:06 +0100
Message-Id: <20230913164013.107520-7-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-7-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comedi drivers can initialize an 8255 subdevice in I/O space by calling
`subdev_8255_init()`, or in memory-mapped I/O space by calling
`subdev_8255_mm_init()`, or by supplying a call-back function pointer
and context to either of those functions.  Change it so that a new
function `subdev_8255_cb_init()` shall be called instead when supplying
a callback function and context, and remove the call-back function
parameter from `subdev_8255_init()` and `subdev_8255_mm_init()`.

Also rename `subdev_8255_init()` to `subdev_8255_io_init()`.  The
parameters are changing, so might as well rename it at the same time.

Also rename the `regbase` member of `struct subdev_8255_private` to
`context` since this holds the context for the call-back function call.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
v2: N/A
---
 drivers/comedi/drivers/8255.c               |   2 +-
 drivers/comedi/drivers/8255_pci.c           |   4 +-
 drivers/comedi/drivers/adv_pci_dio.c        |   4 +-
 drivers/comedi/drivers/aio_aio12_8.c        |   2 +-
 drivers/comedi/drivers/amplc_pc236_common.c |   2 +-
 drivers/comedi/drivers/amplc_pci230.c       |   2 +-
 drivers/comedi/drivers/cb_pcidas.c          |   2 +-
 drivers/comedi/drivers/cb_pcidas64.c        |   7 +-
 drivers/comedi/drivers/cb_pcidda.c          |   2 +-
 drivers/comedi/drivers/cb_pcimdas.c         |   2 +-
 drivers/comedi/drivers/cb_pcimdda.c         |   2 +-
 drivers/comedi/drivers/comedi_8255.c        | 115 +++++++++-----------
 drivers/comedi/drivers/daqboard2000.c       |   4 +-
 drivers/comedi/drivers/das08.c              |   2 +-
 drivers/comedi/drivers/das16.c              |   2 +-
 drivers/comedi/drivers/das16m1.c            |   2 +-
 drivers/comedi/drivers/dmm32at.c            |   3 +-
 drivers/comedi/drivers/ni_atmio16d.c        |   2 +-
 drivers/comedi/drivers/ni_daq_dio24.c       |   2 +-
 drivers/comedi/drivers/ni_labpc_common.c    |   4 +-
 drivers/comedi/drivers/ni_mio_common.c      |   4 +-
 drivers/comedi/drivers/pcl724.c             |   6 +-
 drivers/comedi/drivers/pcm3724.c            |   2 +-
 include/linux/comedi/comedi_8255.h          |  13 ++-
 24 files changed, 92 insertions(+), 100 deletions(-)

diff --git a/drivers/comedi/drivers/8255.c b/drivers/comedi/drivers/8255.c
index ced8ea09d4fa..f45f7bd1c61a 100644
--- a/drivers/comedi/drivers/8255.c
+++ b/drivers/comedi/drivers/8255.c
@@ -80,7 +80,7 @@ static int dev_8255_attach(struct comedi_device *dev,
 		if (ret) {
 			s->type = COMEDI_SUBD_UNUSED;
 		} else {
-			ret = subdev_8255_init(dev, s, NULL, iobase);
+			ret = subdev_8255_io_init(dev, s, iobase);
 			if (ret) {
 				/*
 				 * Release the I/O port region here, as the
diff --git a/drivers/comedi/drivers/8255_pci.c b/drivers/comedi/drivers/8255_pci.c
index 9ad52e9f5427..8498cabe4d91 100644
--- a/drivers/comedi/drivers/8255_pci.c
+++ b/drivers/comedi/drivers/8255_pci.c
@@ -242,9 +242,9 @@ static int pci_8255_auto_attach(struct comedi_device *dev,
 	for (i = 0; i < board->n_8255; i++) {
 		s = &dev->subdevices[i];
 		if (dev->mmio)
-			ret = subdev_8255_mm_init(dev, s, NULL, i * I8255_SIZE);
+			ret = subdev_8255_mm_init(dev, s, i * I8255_SIZE);
 		else
-			ret = subdev_8255_init(dev, s, NULL, i * I8255_SIZE);
+			ret = subdev_8255_io_init(dev, s, i * I8255_SIZE);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/comedi/drivers/adv_pci_dio.c b/drivers/comedi/drivers/adv_pci_dio.c
index 0319d8c7ee47..ca8054504760 100644
--- a/drivers/comedi/drivers/adv_pci_dio.c
+++ b/drivers/comedi/drivers/adv_pci_dio.c
@@ -642,8 +642,8 @@ static int pci_dio_auto_attach(struct comedi_device *dev,
 
 		for (j = 0; j < d->chans; j++) {
 			s = &dev->subdevices[subdev++];
-			ret = subdev_8255_init(dev, s, NULL,
-					       d->addr + j * I8255_SIZE);
+			ret = subdev_8255_io_init(dev, s,
+						  d->addr + j * I8255_SIZE);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/comedi/drivers/aio_aio12_8.c b/drivers/comedi/drivers/aio_aio12_8.c
index f9d40fa3d3a9..227a86a3a760 100644
--- a/drivers/comedi/drivers/aio_aio12_8.c
+++ b/drivers/comedi/drivers/aio_aio12_8.c
@@ -247,7 +247,7 @@ static int aio_aio12_8_attach(struct comedi_device *dev,
 
 	/* Digital I/O subdevice (8255) */
 	s = &dev->subdevices[2];
-	ret = subdev_8255_init(dev, s, NULL, AIO12_8_8255_BASE_REG);
+	ret = subdev_8255_io_init(dev, s, AIO12_8_8255_BASE_REG);
 	if (ret)
 		return ret;
 
diff --git a/drivers/comedi/drivers/amplc_pc236_common.c b/drivers/comedi/drivers/amplc_pc236_common.c
index 9f4f89b1ef23..326ca72c24ec 100644
--- a/drivers/comedi/drivers/amplc_pc236_common.c
+++ b/drivers/comedi/drivers/amplc_pc236_common.c
@@ -147,7 +147,7 @@ int amplc_pc236_common_attach(struct comedi_device *dev, unsigned long iobase,
 
 	s = &dev->subdevices[0];
 	/* digital i/o subdevice (8255) */
-	ret = subdev_8255_init(dev, s, NULL, 0x00);
+	ret = subdev_8255_io_init(dev, s, 0x00);
 	if (ret)
 		return ret;
 
diff --git a/drivers/comedi/drivers/amplc_pci230.c b/drivers/comedi/drivers/amplc_pci230.c
index 783da73877b9..c74209c2e83a 100644
--- a/drivers/comedi/drivers/amplc_pci230.c
+++ b/drivers/comedi/drivers/amplc_pci230.c
@@ -2529,7 +2529,7 @@ static int pci230_auto_attach(struct comedi_device *dev,
 	s = &dev->subdevices[2];
 	/* digital i/o subdevice */
 	if (board->have_dio) {
-		rc = subdev_8255_init(dev, s, NULL, PCI230_PPI_X_BASE);
+		rc = subdev_8255_io_init(dev, s, PCI230_PPI_X_BASE);
 		if (rc)
 			return rc;
 	} else {
diff --git a/drivers/comedi/drivers/cb_pcidas.c b/drivers/comedi/drivers/cb_pcidas.c
index 7a6cd681e932..8bb9b0623869 100644
--- a/drivers/comedi/drivers/cb_pcidas.c
+++ b/drivers/comedi/drivers/cb_pcidas.c
@@ -1352,7 +1352,7 @@ static int cb_pcidas_auto_attach(struct comedi_device *dev,
 
 	/* 8255 */
 	s = &dev->subdevices[2];
-	ret = subdev_8255_init(dev, s, NULL, PCIDAS_8255_BASE);
+	ret = subdev_8255_io_init(dev, s, PCIDAS_8255_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/comedi/drivers/cb_pcidas64.c b/drivers/comedi/drivers/cb_pcidas64.c
index ca6038a25f26..ff19fc3859e4 100644
--- a/drivers/comedi/drivers/cb_pcidas64.c
+++ b/drivers/comedi/drivers/cb_pcidas64.c
@@ -3877,11 +3877,10 @@ static int setup_subdevices(struct comedi_device *dev)
 	s = &dev->subdevices[4];
 	if (board->has_8255) {
 		if (board->layout == LAYOUT_4020) {
-			ret = subdev_8255_init(dev, s, dio_callback_4020,
-					       I8255_4020_REG);
+			ret = subdev_8255_cb_init(dev, s, dio_callback_4020,
+						  I8255_4020_REG);
 		} else {
-			ret = subdev_8255_mm_init(dev, s, NULL,
-						  DIO_8255_OFFSET);
+			ret = subdev_8255_mm_init(dev, s, DIO_8255_OFFSET);
 		}
 		if (ret)
 			return ret;
diff --git a/drivers/comedi/drivers/cb_pcidda.c b/drivers/comedi/drivers/cb_pcidda.c
index c52204a6bda4..c353d0f87da9 100644
--- a/drivers/comedi/drivers/cb_pcidda.c
+++ b/drivers/comedi/drivers/cb_pcidda.c
@@ -365,7 +365,7 @@ static int cb_pcidda_auto_attach(struct comedi_device *dev,
 	/* two 8255 digital io subdevices */
 	for (i = 0; i < 2; i++) {
 		s = &dev->subdevices[1 + i];
-		ret = subdev_8255_init(dev, s, NULL, i * I8255_SIZE);
+		ret = subdev_8255_io_init(dev, s, i * I8255_SIZE);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/comedi/drivers/cb_pcimdas.c b/drivers/comedi/drivers/cb_pcimdas.c
index 5816ef65ed5f..641c30df392e 100644
--- a/drivers/comedi/drivers/cb_pcimdas.c
+++ b/drivers/comedi/drivers/cb_pcimdas.c
@@ -405,7 +405,7 @@ static int cb_pcimdas_auto_attach(struct comedi_device *dev,
 
 	/* Digital I/O subdevice */
 	s = &dev->subdevices[2];
-	ret = subdev_8255_init(dev, s, NULL, PCIMDAS_8255_BASE);
+	ret = subdev_8255_io_init(dev, s, PCIMDAS_8255_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/comedi/drivers/cb_pcimdda.c b/drivers/comedi/drivers/cb_pcimdda.c
index bf8093a10315..541b5742bb1b 100644
--- a/drivers/comedi/drivers/cb_pcimdda.c
+++ b/drivers/comedi/drivers/cb_pcimdda.c
@@ -154,7 +154,7 @@ static int cb_pcimdda_auto_attach(struct comedi_device *dev,
 
 	s = &dev->subdevices[1];
 	/* digital i/o subdevice */
-	return subdev_8255_init(dev, s, NULL, PCIMDDA_8255_BASE_REG);
+	return subdev_8255_io_init(dev, s, PCIMDDA_8255_BASE_REG);
 }
 
 static struct comedi_driver cb_pcimdda_driver = {
diff --git a/drivers/comedi/drivers/comedi_8255.c b/drivers/comedi/drivers/comedi_8255.c
index 5562b9cd0a17..28fd9d8c95cc 100644
--- a/drivers/comedi/drivers/comedi_8255.c
+++ b/drivers/comedi/drivers/comedi_8255.c
@@ -33,9 +33,9 @@
 #include <linux/comedi/comedi_8255.h>
 
 struct subdev_8255_private {
-	unsigned long regbase;
+	unsigned long context;
 	int (*io)(struct comedi_device *dev, int dir, int port, int data,
-		  unsigned long regbase);
+		  unsigned long context);
 };
 
 static int subdev_8255_io(struct comedi_device *dev,
@@ -64,7 +64,7 @@ static int subdev_8255_insn(struct comedi_device *dev,
 			    unsigned int *data)
 {
 	struct subdev_8255_private *spriv = s->private;
-	unsigned long regbase = spriv->regbase;
+	unsigned long context = spriv->context;
 	unsigned int mask;
 	unsigned int v;
 
@@ -72,18 +72,18 @@ static int subdev_8255_insn(struct comedi_device *dev,
 	if (mask) {
 		if (mask & 0xff)
 			spriv->io(dev, 1, I8255_DATA_A_REG,
-				  s->state & 0xff, regbase);
+				  s->state & 0xff, context);
 		if (mask & 0xff00)
 			spriv->io(dev, 1, I8255_DATA_B_REG,
-				  (s->state >> 8) & 0xff, regbase);
+				  (s->state >> 8) & 0xff, context);
 		if (mask & 0xff0000)
 			spriv->io(dev, 1, I8255_DATA_C_REG,
-				  (s->state >> 16) & 0xff, regbase);
+				  (s->state >> 16) & 0xff, context);
 	}
 
-	v = spriv->io(dev, 0, I8255_DATA_A_REG, 0, regbase);
-	v |= (spriv->io(dev, 0, I8255_DATA_B_REG, 0, regbase) << 8);
-	v |= (spriv->io(dev, 0, I8255_DATA_C_REG, 0, regbase) << 16);
+	v = spriv->io(dev, 0, I8255_DATA_A_REG, 0, context);
+	v |= (spriv->io(dev, 0, I8255_DATA_B_REG, 0, context) << 8);
+	v |= (spriv->io(dev, 0, I8255_DATA_C_REG, 0, context) << 16);
 
 	data[1] = v;
 
@@ -94,7 +94,7 @@ static void subdev_8255_do_config(struct comedi_device *dev,
 				  struct comedi_subdevice *s)
 {
 	struct subdev_8255_private *spriv = s->private;
-	unsigned long regbase = spriv->regbase;
+	unsigned long context = spriv->context;
 	int config;
 
 	config = I8255_CTRL_CW;
@@ -108,7 +108,7 @@ static void subdev_8255_do_config(struct comedi_device *dev,
 	if (!(s->io_bits & 0xf00000))
 		config |= I8255_CTRL_C_HI_IO;
 
-	spriv->io(dev, 1, I8255_CTRL_REG, config, regbase);
+	spriv->io(dev, 1, I8255_CTRL_REG, config, context);
 }
 
 static int subdev_8255_insn_config(struct comedi_device *dev,
@@ -142,23 +142,19 @@ static int __subdev_8255_init(struct comedi_device *dev,
 			      struct comedi_subdevice *s,
 			      int (*io)(struct comedi_device *dev,
 					int dir, int port, int data,
-					unsigned long regbase),
-			      unsigned long regbase,
-			      bool is_mmio)
+					unsigned long context),
+			      unsigned long context)
 {
 	struct subdev_8255_private *spriv;
 
+	if (!io)
+		return -EINVAL;
+
 	spriv = comedi_alloc_spriv(s, sizeof(*spriv));
 	if (!spriv)
 		return -ENOMEM;
 
-	if (io)
-		spriv->io = io;
-	else if (is_mmio)
-		spriv->io = subdev_8255_mmio;
-	else
-		spriv->io = subdev_8255_io;
-	spriv->regbase	= regbase;
+	spriv->context = context;
 
 	s->type		= COMEDI_SUBD_DIO;
 	s->subdev_flags	= SDF_READABLE | SDF_WRITABLE;
@@ -174,88 +170,83 @@ static int __subdev_8255_init(struct comedi_device *dev,
 }
 
 /**
- * subdev_8255_init - initialize DIO subdevice for driving I/O mapped 8255
+ * subdev_8255_io_init - initialize DIO subdevice for driving I/O mapped 8255
  * @dev: comedi device owning subdevice
  * @s: comedi subdevice to initialize
- * @io: (optional) register I/O call-back function
- * @regbase: offset of 8255 registers from dev->iobase, or call-back context
+ * @regbase: offset of 8255 registers from dev->iobase
  *
  * Initializes a comedi subdevice as a DIO subdevice driving an 8255 chip.
  *
- * If the optional I/O call-back function is provided, its prototype is of
- * the following form:
- *
- *   int my_8255_callback(struct comedi_device *dev, int dir, int port,
- *                        int data, unsigned long regbase);
- *
- * where 'dev', and 'regbase' match the values passed to this function,
- * 'port' is the 8255 port number 0 to 3 (including the control port), 'dir'
- * is the direction (0 for read, 1 for write) and 'data' is the value to be
- * written.  It should return 0 if writing or the value read if reading.
- *
- * If the optional I/O call-back function is not provided, an internal
- * call-back function is used which uses consecutive I/O port addresses
- * starting at dev->iobase + regbase.
- *
  * Return: -ENOMEM if failed to allocate memory, zero on success.
  */
-int subdev_8255_init(struct comedi_device *dev, struct comedi_subdevice *s,
-		     int (*io)(struct comedi_device *dev, int dir, int port,
-			       int data, unsigned long regbase),
+int subdev_8255_io_init(struct comedi_device *dev, struct comedi_subdevice *s,
 		     unsigned long regbase)
 {
-	return __subdev_8255_init(dev, s, io, regbase, false);
+	return __subdev_8255_init(dev, s, subdev_8255_io, regbase);
 }
-EXPORT_SYMBOL_GPL(subdev_8255_init);
+EXPORT_SYMBOL_GPL(subdev_8255_io_init);
 
 /**
  * subdev_8255_mm_init - initialize DIO subdevice for driving mmio-mapped 8255
  * @dev: comedi device owning subdevice
  * @s: comedi subdevice to initialize
- * @io: (optional) register I/O call-back function
- * @regbase: offset of 8255 registers from dev->mmio, or call-back context
+ * @regbase: offset of 8255 registers from dev->mmio
  *
  * Initializes a comedi subdevice as a DIO subdevice driving an 8255 chip.
  *
- * If the optional I/O call-back function is provided, its prototype is of
- * the following form:
+ * Return: -ENOMEM if failed to allocate memory, zero on success.
+ */
+int subdev_8255_mm_init(struct comedi_device *dev, struct comedi_subdevice *s,
+			unsigned long regbase)
+{
+	return __subdev_8255_init(dev, s, subdev_8255_mmio, regbase);
+}
+EXPORT_SYMBOL_GPL(subdev_8255_mm_init);
+
+/**
+ * subdev_8255_cb_init - initialize DIO subdevice for driving callback-mapped 8255
+ * @dev: comedi device owning subdevice
+ * @s: comedi subdevice to initialize
+ * @io: register I/O call-back function
+ * @context: call-back context
+ *
+ * Initializes a comedi subdevice as a DIO subdevice driving an 8255 chip.
+ *
+ * The prototype of the I/O call-back function is of the following form:
  *
  *   int my_8255_callback(struct comedi_device *dev, int dir, int port,
- *                        int data, unsigned long regbase);
+ *                        int data, unsigned long context);
  *
- * where 'dev', and 'regbase' match the values passed to this function,
+ * where 'dev', and 'context' match the values passed to this function,
  * 'port' is the 8255 port number 0 to 3 (including the control port), 'dir'
  * is the direction (0 for read, 1 for write) and 'data' is the value to be
  * written.  It should return 0 if writing or the value read if reading.
  *
- * If the optional I/O call-back function is not provided, an internal
- * call-back function is used which uses consecutive MMIO virtual addresses
- * starting at dev->mmio + regbase.
  *
  * Return: -ENOMEM if failed to allocate memory, zero on success.
  */
-int subdev_8255_mm_init(struct comedi_device *dev, struct comedi_subdevice *s,
+int subdev_8255_cb_init(struct comedi_device *dev, struct comedi_subdevice *s,
 			int (*io)(struct comedi_device *dev, int dir, int port,
-				  int data, unsigned long regbase),
-			unsigned long regbase)
+				  int data, unsigned long context),
+			unsigned long context)
 {
-	return __subdev_8255_init(dev, s, io, regbase, true);
+	return __subdev_8255_init(dev, s, io, context);
 }
-EXPORT_SYMBOL_GPL(subdev_8255_mm_init);
+EXPORT_SYMBOL_GPL(subdev_8255_cb_init);
 
 /**
  * subdev_8255_regbase - get offset of 8255 registers or call-back context
  * @s: comedi subdevice
  *
- * Returns the 'regbase' parameter that was previously passed to
- * subdev_8255_init() or subdev_8255_mm_init() to set up the subdevice.
- * Only valid if the subdevice was set up successfully.
+ * Returns the 'regbase' or 'context' parameter that was previously passed to
+ * subdev_8255_io_init(), subdev_8255_mm_init(), or subdev_8255_cb_init() to
+ * set up the subdevice.  Only valid if the subdevice was set up successfully.
  */
 unsigned long subdev_8255_regbase(struct comedi_subdevice *s)
 {
 	struct subdev_8255_private *spriv = s->private;
 
-	return spriv->regbase;
+	return spriv->context;
 }
 EXPORT_SYMBOL_GPL(subdev_8255_regbase);
 
diff --git a/drivers/comedi/drivers/daqboard2000.c b/drivers/comedi/drivers/daqboard2000.c
index c0a4e1b06fb3..897bf46b95ee 100644
--- a/drivers/comedi/drivers/daqboard2000.c
+++ b/drivers/comedi/drivers/daqboard2000.c
@@ -738,8 +738,8 @@ static int db2k_auto_attach(struct comedi_device *dev, unsigned long context)
 		return result;
 
 	s = &dev->subdevices[2];
-	return subdev_8255_init(dev, s, db2k_8255_cb,
-				DB2K_REG_DIO_P2_EXP_IO_8_BIT);
+	return subdev_8255_cb_init(dev, s, db2k_8255_cb,
+				   DB2K_REG_DIO_P2_EXP_IO_8_BIT);
 }
 
 static void db2k_detach(struct comedi_device *dev)
diff --git a/drivers/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
index 6a3b5411aa90..5d5b9174f88a 100644
--- a/drivers/comedi/drivers/das08.c
+++ b/drivers/comedi/drivers/das08.c
@@ -429,7 +429,7 @@ int das08_common_attach(struct comedi_device *dev, unsigned long iobase)
 	s = &dev->subdevices[4];
 	/* 8255 */
 	if (board->i8255_offset != 0) {
-		ret = subdev_8255_init(dev, s, NULL, board->i8255_offset);
+		ret = subdev_8255_io_init(dev, s, board->i8255_offset);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index bfe8811be1b5..4ed56a02150e 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -1145,7 +1145,7 @@ static int das16_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	/* 8255 Digital I/O subdevice */
 	if (board->has_8255) {
 		s = &dev->subdevices[4];
-		ret = subdev_8255_init(dev, s, NULL, board->i8255_offset);
+		ret = subdev_8255_io_init(dev, s, board->i8255_offset);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
index ff9c5a8897bd..b8ea737ad3d1 100644
--- a/drivers/comedi/drivers/das16m1.c
+++ b/drivers/comedi/drivers/das16m1.c
@@ -583,7 +583,7 @@ static int das16m1_attach(struct comedi_device *dev,
 
 	/* Digital I/O subdevice (8255) */
 	s = &dev->subdevices[3];
-	ret = subdev_8255_init(dev, s, NULL, DAS16M1_8255_IOBASE);
+	ret = subdev_8255_io_init(dev, s, DAS16M1_8255_IOBASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/comedi/drivers/dmm32at.c b/drivers/comedi/drivers/dmm32at.c
index fe023c722aa3..644e3b643c79 100644
--- a/drivers/comedi/drivers/dmm32at.c
+++ b/drivers/comedi/drivers/dmm32at.c
@@ -599,7 +599,8 @@ static int dmm32at_attach(struct comedi_device *dev,
 
 	/* Digital I/O subdevice */
 	s = &dev->subdevices[2];
-	return subdev_8255_init(dev, s, dmm32at_8255_io, DMM32AT_8255_IOBASE);
+	return subdev_8255_cb_init(dev, s, dmm32at_8255_io,
+				   DMM32AT_8255_IOBASE);
 }
 
 static struct comedi_driver dmm32at_driver = {
diff --git a/drivers/comedi/drivers/ni_atmio16d.c b/drivers/comedi/drivers/ni_atmio16d.c
index 9fa902529a8e..e5e7cc423c87 100644
--- a/drivers/comedi/drivers/ni_atmio16d.c
+++ b/drivers/comedi/drivers/ni_atmio16d.c
@@ -677,7 +677,7 @@ static int atmio16d_attach(struct comedi_device *dev,
 	/* 8255 subdevice */
 	s = &dev->subdevices[3];
 	if (board->has_8255) {
-		ret = subdev_8255_init(dev, s, NULL, 0x00);
+		ret = subdev_8255_io_init(dev, s, 0x00);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/comedi/drivers/ni_daq_dio24.c b/drivers/comedi/drivers/ni_daq_dio24.c
index 487733111023..9419caf02edc 100644
--- a/drivers/comedi/drivers/ni_daq_dio24.c
+++ b/drivers/comedi/drivers/ni_daq_dio24.c
@@ -45,7 +45,7 @@ static int dio24_auto_attach(struct comedi_device *dev,
 
 	/* 8255 dio */
 	s = &dev->subdevices[0];
-	return subdev_8255_init(dev, s, NULL, 0x00);
+	return subdev_8255_io_init(dev, s, 0x00);
 }
 
 static struct comedi_driver driver_dio24 = {
diff --git a/drivers/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
index eb8f6431276a..5d5c1d0e9cb6 100644
--- a/drivers/comedi/drivers/ni_labpc_common.c
+++ b/drivers/comedi/drivers/ni_labpc_common.c
@@ -1287,9 +1287,9 @@ int labpc_common_attach(struct comedi_device *dev,
 	/* 8255 dio */
 	s = &dev->subdevices[2];
 	if (dev->mmio)
-		ret = subdev_8255_mm_init(dev, s, NULL, DIO_BASE_REG);
+		ret = subdev_8255_mm_init(dev, s, DIO_BASE_REG);
 	else
-		ret = subdev_8255_init(dev, s, NULL, DIO_BASE_REG);
+		ret = subdev_8255_io_init(dev, s, DIO_BASE_REG);
 	if (ret)
 		return ret;
 
diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/drivers/ni_mio_common.c
index d39998565808..638be08b43e4 100644
--- a/drivers/comedi/drivers/ni_mio_common.c
+++ b/drivers/comedi/drivers/ni_mio_common.c
@@ -6137,8 +6137,8 @@ static int ni_E_init(struct comedi_device *dev,
 	/* 8255 device */
 	s = &dev->subdevices[NI_8255_DIO_SUBDEV];
 	if (board->has_8255) {
-		ret = subdev_8255_init(dev, s, ni_8255_callback,
-				       NI_E_8255_BASE);
+		ret = subdev_8255_cb_init(dev, s, ni_8255_callback,
+					  NI_E_8255_BASE);
 		if (ret)
 			return ret;
 	} else {
diff --git a/drivers/comedi/drivers/pcl724.c b/drivers/comedi/drivers/pcl724.c
index 948a0576c9ef..00474710b81f 100644
--- a/drivers/comedi/drivers/pcl724.c
+++ b/drivers/comedi/drivers/pcl724.c
@@ -124,10 +124,10 @@ static int pcl724_attach(struct comedi_device *dev,
 		s = &dev->subdevices[i];
 		if (board->is_pet48) {
 			iobase = dev->iobase + (i * 0x1000);
-			ret = subdev_8255_init(dev, s, pcl724_8255mapped_io,
-					       iobase);
+			ret = subdev_8255_cb_init(dev, s, pcl724_8255mapped_io,
+						  iobase);
 		} else {
-			ret = subdev_8255_init(dev, s, NULL, i * I8255_SIZE);
+			ret = subdev_8255_io_init(dev, s, i * I8255_SIZE);
 		}
 		if (ret)
 			return ret;
diff --git a/drivers/comedi/drivers/pcm3724.c b/drivers/comedi/drivers/pcm3724.c
index ca8bef54dacc..fb41de3baef8 100644
--- a/drivers/comedi/drivers/pcm3724.c
+++ b/drivers/comedi/drivers/pcm3724.c
@@ -204,7 +204,7 @@ static int pcm3724_attach(struct comedi_device *dev,
 
 	for (i = 0; i < dev->n_subdevices; i++) {
 		s = &dev->subdevices[i];
-		ret = subdev_8255_init(dev, s, NULL, i * I8255_SIZE);
+		ret = subdev_8255_io_init(dev, s, i * I8255_SIZE);
 		if (ret)
 			return ret;
 		s->insn_config = subdev_3724_insn_config;
diff --git a/include/linux/comedi/comedi_8255.h b/include/linux/comedi/comedi_8255.h
index b2a5bc6b3a49..b396fcfbf8b0 100644
--- a/include/linux/comedi/comedi_8255.h
+++ b/include/linux/comedi/comedi_8255.h
@@ -27,16 +27,17 @@
 struct comedi_device;
 struct comedi_subdevice;
 
-int subdev_8255_init(struct comedi_device *dev, struct comedi_subdevice *s,
-		     int (*io)(struct comedi_device *dev, int dir, int port,
-			       int data, unsigned long regbase),
-		     unsigned long regbase);
+int subdev_8255_io_init(struct comedi_device *dev, struct comedi_subdevice *s,
+			unsigned long regbase);
 
 int subdev_8255_mm_init(struct comedi_device *dev, struct comedi_subdevice *s,
-			int (*io)(struct comedi_device *dev, int dir, int port,
-				  int data, unsigned long regbase),
 			unsigned long regbase);
 
+int subdev_8255_cb_init(struct comedi_device *dev, struct comedi_subdevice *s,
+			int (*io)(struct comedi_device *dev, int dir, int port,
+				  int data, unsigned long context),
+			unsigned long context);
+
 unsigned long subdev_8255_regbase(struct comedi_subdevice *s);
 
 #endif
-- 
2.40.1

