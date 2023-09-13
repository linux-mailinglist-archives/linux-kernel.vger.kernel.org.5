Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6B79EF08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjIMQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjIMQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:42:57 -0400
Received: from smtp68.iad3a.emailsrvr.com (smtp68.iad3a.emailsrvr.com [173.203.187.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4F3C03
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623231;
        bh=5sNyqizTGm0nO4CVX93DWsQJaBmGszYPqjKFaOWoDA4=;
        h=From:To:Subject:Date:From;
        b=gvWrgHOg8lu27ZNdhpO8azRtrYqnHY1M+OCjCq0iOAm0cQEd5LtoMNMxVfLk5lvwb
         omdRyFkaV1z6xIy15668fNveuLBZr0ITB2C5WMj5we/Vqi4/EQdp0/bd5Ul7BE/p46
         LuDlcC0uMM7LvvpQ4LaXHwgcqTr71oWiyk2JdmaI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 51B972521C;
        Wed, 13 Sep 2023 12:40:30 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 03/13] comedi: comedi_8254: Replace comedi_8254_init() and comedi_8254_mm_init()
Date:   Wed, 13 Sep 2023 17:40:03 +0100
Message-Id: <20230913164013.107520-4-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-4-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`comedi_8254_init()` and `comedi_8254_mm_init()` return `NULL` on
failure, but the failure is not necessarily due to lack of memory.
Change them to return an `ERR_PTR` value on failure and rename the
functions to make it obvious the API has changed.  `comedi_8254_init()`
has been replaced with `comedi_8254_io_alloc()`, and
`comedi_8254_mm_init()` has been replaced with `comedi_8254_mm_alloc()`.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: N/A
---
 drivers/comedi/drivers.c                     |  3 +-
 drivers/comedi/drivers/adl_pci9111.c         |  8 +--
 drivers/comedi/drivers/adl_pci9118.c         |  8 +--
 drivers/comedi/drivers/adv_pci1710.c         |  8 +--
 drivers/comedi/drivers/adv_pci_dio.c         | 10 ++--
 drivers/comedi/drivers/aio_aio12_8.c         |  8 +--
 drivers/comedi/drivers/amplc_dio200_common.c | 12 ++---
 drivers/comedi/drivers/amplc_pci224.c        |  8 +--
 drivers/comedi/drivers/amplc_pci230.c        |  8 +--
 drivers/comedi/drivers/cb_das16_cs.c         |  8 +--
 drivers/comedi/drivers/cb_pcidas.c           | 21 ++++----
 drivers/comedi/drivers/cb_pcimdas.c          | 10 ++--
 drivers/comedi/drivers/comedi_8254.c         | 55 +++++++++++---------
 drivers/comedi/drivers/das08.c               |  9 ++--
 drivers/comedi/drivers/das16.c               |  8 +--
 drivers/comedi/drivers/das16m1.c             | 20 +++----
 drivers/comedi/drivers/das1800.c             |  8 +--
 drivers/comedi/drivers/das6402.c             |  8 +--
 drivers/comedi/drivers/das800.c              |  8 +--
 drivers/comedi/drivers/me4000.c              |  6 +--
 drivers/comedi/drivers/ni_at_a2150.c         |  8 +--
 drivers/comedi/drivers/ni_at_ao.c            |  8 +--
 drivers/comedi/drivers/ni_labpc_common.c     | 38 +++++++-------
 drivers/comedi/drivers/pcl711.c              |  8 +--
 drivers/comedi/drivers/pcl812.c              | 10 ++--
 drivers/comedi/drivers/pcl816.c              |  8 +--
 drivers/comedi/drivers/pcl818.c              |  8 +--
 drivers/comedi/drivers/rtd520.c              |  6 +--
 include/linux/comedi/comedi_8254.h           | 16 +++---
 29 files changed, 179 insertions(+), 165 deletions(-)

diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index d4e2ed709bfc..376130bfba8a 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -177,7 +177,8 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 		dev->n_subdevices = 0;
 	}
 	kfree(dev->private);
-	kfree(dev->pacer);
+	if (!IS_ERR(dev->pacer))
+		kfree(dev->pacer);
 	dev->private = NULL;
 	dev->pacer = NULL;
 	dev->driver = NULL;
diff --git a/drivers/comedi/drivers/adl_pci9111.c b/drivers/comedi/drivers/adl_pci9111.c
index c50f94272a74..086d93f40cb9 100644
--- a/drivers/comedi/drivers/adl_pci9111.c
+++ b/drivers/comedi/drivers/adl_pci9111.c
@@ -647,10 +647,10 @@ static int pci9111_auto_attach(struct comedi_device *dev,
 			dev->irq = pcidev->irq;
 	}
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCI9111_8254_BASE_REG,
-				      I8254_OSC_BASE_2MHZ, I8254_IO16, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCI9111_8254_BASE_REG,
+					  I8254_OSC_BASE_2MHZ, I8254_IO16, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/adl_pci9118.c b/drivers/comedi/drivers/adl_pci9118.c
index 9a816c718303..a76e2666d583 100644
--- a/drivers/comedi/drivers/adl_pci9118.c
+++ b/drivers/comedi/drivers/adl_pci9118.c
@@ -1524,10 +1524,10 @@ static int pci9118_common_attach(struct comedi_device *dev,
 	devpriv->iobase_a = pci_resource_start(pcidev, 0);
 	dev->iobase = pci_resource_start(pcidev, 2);
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCI9118_TIMER_BASE,
-				      I8254_OSC_BASE_4MHZ, I8254_IO32, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCI9118_TIMER_BASE,
+					  I8254_OSC_BASE_4MHZ, I8254_IO32, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	pci9118_reset(dev);
 
diff --git a/drivers/comedi/drivers/adv_pci1710.c b/drivers/comedi/drivers/adv_pci1710.c
index 4f2639968260..c49b0f1f5228 100644
--- a/drivers/comedi/drivers/adv_pci1710.c
+++ b/drivers/comedi/drivers/adv_pci1710.c
@@ -767,10 +767,10 @@ static int pci1710_auto_attach(struct comedi_device *dev,
 		return ret;
 	dev->iobase = pci_resource_start(pcidev, 2);
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCI171X_TIMER_BASE,
-				      I8254_OSC_BASE_10MHZ, I8254_IO16, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCI171X_TIMER_BASE,
+					  I8254_OSC_BASE_10MHZ, I8254_IO16, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	n_subdevices = 1;	/* all boards have analog inputs */
 	if (board->has_ao)
diff --git a/drivers/comedi/drivers/adv_pci_dio.c b/drivers/comedi/drivers/adv_pci_dio.c
index efa3e46b554b..0319d8c7ee47 100644
--- a/drivers/comedi/drivers/adv_pci_dio.c
+++ b/drivers/comedi/drivers/adv_pci_dio.c
@@ -664,11 +664,11 @@ static int pci_dio_auto_attach(struct comedi_device *dev,
 	if (board->timer_regbase) {
 		s = &dev->subdevices[subdev++];
 
-		dev->pacer = comedi_8254_init(dev->iobase +
-					      board->timer_regbase,
-					      0, I8254_IO8, 0);
-		if (!dev->pacer)
-			return -ENOMEM;
+		dev->pacer =
+		    comedi_8254_io_alloc(dev->iobase + board->timer_regbase,
+					 0, I8254_IO8, 0);
+		if (IS_ERR(dev->pacer))
+			return PTR_ERR(dev->pacer);
 
 		comedi_8254_subdevice_init(s, dev->pacer);
 	}
diff --git a/drivers/comedi/drivers/aio_aio12_8.c b/drivers/comedi/drivers/aio_aio12_8.c
index 30b8a32204d8..f9d40fa3d3a9 100644
--- a/drivers/comedi/drivers/aio_aio12_8.c
+++ b/drivers/comedi/drivers/aio_aio12_8.c
@@ -206,10 +206,10 @@ static int aio_aio12_8_attach(struct comedi_device *dev,
 	if (ret)
 		return ret;
 
-	dev->pacer = comedi_8254_init(dev->iobase + AIO12_8_8254_BASE_REG,
-				      0, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + AIO12_8_8254_BASE_REG,
+					  0, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
index 2c1507a23f8a..19166cb26f5e 100644
--- a/drivers/comedi/drivers/amplc_dio200_common.c
+++ b/drivers/comedi/drivers/amplc_dio200_common.c
@@ -556,14 +556,14 @@ static int dio200_subdev_8254_init(struct comedi_device *dev,
 	}
 
 	if (dev->mmio) {
-		i8254 = comedi_8254_mm_init(dev->mmio + offset,
-					    0, I8254_IO8, regshift);
+		i8254 = comedi_8254_mm_alloc(dev->mmio + offset,
+					     0, I8254_IO8, regshift);
 	} else {
-		i8254 = comedi_8254_init(dev->iobase + offset,
-					 0, I8254_IO8, regshift);
+		i8254 = comedi_8254_io_alloc(dev->iobase + offset,
+					     0, I8254_IO8, regshift);
 	}
-	if (!i8254)
-		return -ENOMEM;
+	if (IS_ERR(i8254))
+		return PTR_ERR(i8254);
 
 	comedi_8254_subdevice_init(s, i8254);
 
diff --git a/drivers/comedi/drivers/amplc_pci224.c b/drivers/comedi/drivers/amplc_pci224.c
index 5a04e55daeea..1373637c2ca2 100644
--- a/drivers/comedi/drivers/amplc_pci224.c
+++ b/drivers/comedi/drivers/amplc_pci224.c
@@ -1051,10 +1051,10 @@ pci224_auto_attach(struct comedi_device *dev, unsigned long context_model)
 	outw(devpriv->daccon | PCI224_DACCON_FIFORESET,
 	     dev->iobase + PCI224_DACCON);
 
-	dev->pacer = comedi_8254_init(devpriv->iobase1 + PCI224_Z2_BASE,
-				      I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(devpriv->iobase1 + PCI224_Z2_BASE,
+					  I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 1);
 	if (ret)
diff --git a/drivers/comedi/drivers/amplc_pci230.c b/drivers/comedi/drivers/amplc_pci230.c
index 92ba8b8c0172..783da73877b9 100644
--- a/drivers/comedi/drivers/amplc_pci230.c
+++ b/drivers/comedi/drivers/amplc_pci230.c
@@ -2475,10 +2475,10 @@ static int pci230_auto_attach(struct comedi_device *dev,
 			dev->irq = pci_dev->irq;
 	}
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCI230_Z2_CT_BASE,
-				      0, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCI230_Z2_CT_BASE,
+					  0, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	rc = comedi_alloc_subdevices(dev, 3);
 	if (rc)
diff --git a/drivers/comedi/drivers/cb_das16_cs.c b/drivers/comedi/drivers/cb_das16_cs.c
index 8e0d2fa5f95d..306208a0695b 100644
--- a/drivers/comedi/drivers/cb_das16_cs.c
+++ b/drivers/comedi/drivers/cb_das16_cs.c
@@ -363,10 +363,10 @@ static int das16cs_auto_attach(struct comedi_device *dev,
 	if (!devpriv)
 		return -ENOMEM;
 
-	dev->pacer = comedi_8254_init(dev->iobase + DAS16CS_TIMER_BASE,
-				      I8254_OSC_BASE_10MHZ, I8254_IO16, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + DAS16CS_TIMER_BASE,
+					  I8254_OSC_BASE_10MHZ, I8254_IO16, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/cb_pcidas.c b/drivers/comedi/drivers/cb_pcidas.c
index 0c7576b967fc..7a6cd681e932 100644
--- a/drivers/comedi/drivers/cb_pcidas.c
+++ b/drivers/comedi/drivers/cb_pcidas.c
@@ -1288,16 +1288,16 @@ static int cb_pcidas_auto_attach(struct comedi_device *dev,
 	}
 	dev->irq = pcidev->irq;
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCIDAS_AI_8254_BASE,
-				      I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCIDAS_AI_8254_BASE,
+					  I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
-	devpriv->ao_pacer = comedi_8254_init(dev->iobase + PCIDAS_AO_8254_BASE,
-					     I8254_OSC_BASE_10MHZ,
-					     I8254_IO8, 0);
-	if (!devpriv->ao_pacer)
-		return -ENOMEM;
+	devpriv->ao_pacer =
+	    comedi_8254_io_alloc(dev->iobase + PCIDAS_AO_8254_BASE,
+				 I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
+	if (IS_ERR(devpriv->ao_pacer))
+		return PTR_ERR(devpriv->ao_pacer);
 
 	ret = comedi_alloc_subdevices(dev, 7);
 	if (ret)
@@ -1453,7 +1453,8 @@ static void cb_pcidas_detach(struct comedi_device *dev)
 		if (devpriv->amcc)
 			outl(INTCSR_INBOX_INTR_STATUS,
 			     devpriv->amcc + AMCC_OP_REG_INTCSR);
-		kfree(devpriv->ao_pacer);
+		if (!IS_ERR(devpriv->ao_pacer))
+			kfree(devpriv->ao_pacer);
 	}
 	comedi_pci_detach(dev);
 }
diff --git a/drivers/comedi/drivers/cb_pcimdas.c b/drivers/comedi/drivers/cb_pcimdas.c
index 8bdb00774f11..5816ef65ed5f 100644
--- a/drivers/comedi/drivers/cb_pcimdas.c
+++ b/drivers/comedi/drivers/cb_pcimdas.c
@@ -364,11 +364,11 @@ static int cb_pcimdas_auto_attach(struct comedi_device *dev,
 	devpriv->BADR3 = pci_resource_start(pcidev, 3);
 	dev->iobase = pci_resource_start(pcidev, 4);
 
-	dev->pacer = comedi_8254_init(devpriv->BADR3 + PCIMDAS_8254_BASE,
-				      cb_pcimdas_pacer_clk(dev),
-				      I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(devpriv->BADR3 + PCIMDAS_8254_BASE,
+					  cb_pcimdas_pacer_clk(dev),
+					  I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 6);
 	if (ret)
diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index 3f8657fc7ee5..696596944506 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
@@ -24,14 +24,17 @@
  *
  * This module provides the following basic functions:
  *
- * comedi_8254_init() / comedi_8254_mm_init()
+ * comedi_8254_io_alloc() / comedi_8254_mm_alloc()
  *	Initializes this module to access the 8254 registers. The _mm version
- *	sets up the module for MMIO register access the other for PIO access.
- *	The pointer returned from these functions is normally stored in the
- *	comedi_device dev->pacer and will be freed by the comedi core during
- *	the driver (*detach). If a driver has multiple 8254 devices, they need
- *	to be stored in the drivers private data and freed when the driver is
- *	detached.
+ *	sets up the module for MMIO register access; the _io version sets it
+ *	up for PIO access.  These functions return a pointer to a struct
+ *	comedi_8254 on success, or an ERR_PTR value on failure.  The pointer
+ *	returned from these functions is normally stored in the comedi_device
+ *	dev->pacer and will be freed by the comedi core during the driver
+ *	(*detach). If a driver has multiple 8254 devices, they need to be
+ *	stored in the drivers private data and freed when the driver is
+ *	detached.  If the ERR_PTR value is stored, code should check the
+ *	pointer value with !IS_ERR(pointer) before freeing.
  *
  *	NOTE: The counters are reset by setting them to I8254_MODE0 as part of
  *	this initialization.
@@ -621,14 +624,14 @@ static struct comedi_8254 *__i8254_init(comedi_8254_iocb_fn *iocb,
 	/* sanity check that the iosize is valid */
 	if (!(iosize == I8254_IO8 || iosize == I8254_IO16 ||
 	      iosize == I8254_IO32))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (!iocb)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	i8254 = kzalloc(sizeof(*i8254), GFP_KERNEL);
 	if (!i8254)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	i8254->iocb	= iocb;
 	i8254->context	= context;
@@ -646,17 +649,19 @@ static struct comedi_8254 *__i8254_init(comedi_8254_iocb_fn *iocb,
 }
 
 /**
- * comedi_8254_init - allocate and initialize the 8254 device for pio access
+ * comedi_8254_io_alloc - allocate and initialize the 8254 device for pio access
  * @iobase:	port I/O base address
  * @osc_base:	base time of the counter in ns
  *		OPTIONAL - only used by comedi_8254_cascade_ns_to_timer()
  * @iosize:	I/O register size
  * @regshift:	register gap shift
+ *
+ * Return: A pointer to a struct comedi_8254 or an ERR_PTR value.
  */
-struct comedi_8254 *comedi_8254_init(unsigned long iobase,
-				     unsigned int osc_base,
-				     unsigned int iosize,
-				     unsigned int regshift)
+struct comedi_8254 *comedi_8254_io_alloc(unsigned long iobase,
+					 unsigned int osc_base,
+					 unsigned int iosize,
+					 unsigned int regshift)
 {
 	comedi_8254_iocb_fn *iocb;
 
@@ -671,24 +676,26 @@ struct comedi_8254 *comedi_8254_init(unsigned long iobase,
 		iocb = i8254_io32_cb;
 		break;
 	default:
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	return __i8254_init(iocb, iobase, osc_base, iosize, regshift);
 }
-EXPORT_SYMBOL_GPL(comedi_8254_init);
+EXPORT_SYMBOL_GPL(comedi_8254_io_alloc);
 
 /**
- * comedi_8254_mm_init - allocate and initialize the 8254 device for mmio access
+ * comedi_8254_mm_alloc - allocate and initialize the 8254 device for mmio access
  * @mmio:	memory mapped I/O base address
  * @osc_base:	base time of the counter in ns
  *		OPTIONAL - only used by comedi_8254_cascade_ns_to_timer()
  * @iosize:	I/O register size
  * @regshift:	register gap shift
+ *
+ * Return: A pointer to a struct comedi_8254 or an ERR_PTR value.
  */
-struct comedi_8254 *comedi_8254_mm_init(void __iomem *mmio,
-					unsigned int osc_base,
-					unsigned int iosize,
-					unsigned int regshift)
+struct comedi_8254 *comedi_8254_mm_alloc(void __iomem *mmio,
+					 unsigned int osc_base,
+					 unsigned int iosize,
+					 unsigned int regshift)
 {
 	comedi_8254_iocb_fn *iocb;
 
@@ -703,11 +710,11 @@ struct comedi_8254 *comedi_8254_mm_init(void __iomem *mmio,
 		iocb = i8254_mmio32_cb;
 		break;
 	default:
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	return __i8254_init(iocb, (unsigned long)mmio, osc_base, iosize, regshift);
 }
-EXPORT_SYMBOL_GPL(comedi_8254_mm_init);
+EXPORT_SYMBOL_GPL(comedi_8254_mm_alloc);
 
 static int __init comedi_8254_module_init(void)
 {
diff --git a/drivers/comedi/drivers/das08.c b/drivers/comedi/drivers/das08.c
index f8ab3af2e391..6a3b5411aa90 100644
--- a/drivers/comedi/drivers/das08.c
+++ b/drivers/comedi/drivers/das08.c
@@ -439,10 +439,11 @@ int das08_common_attach(struct comedi_device *dev, unsigned long iobase)
 	/* Counter subdevice (8254) */
 	s = &dev->subdevices[5];
 	if (board->i8254_offset) {
-		dev->pacer = comedi_8254_init(dev->iobase + board->i8254_offset,
-					      0, I8254_IO8, 0);
-		if (!dev->pacer)
-			return -ENOMEM;
+		dev->pacer =
+		    comedi_8254_io_alloc(dev->iobase + board->i8254_offset,
+					 0, I8254_IO8, 0);
+		if (IS_ERR(dev->pacer))
+			return PTR_ERR(dev->pacer);
 
 		comedi_8254_subdevice_init(s, dev->pacer);
 	} else {
diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index 728dc02156c8..bfe8811be1b5 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -1067,10 +1067,10 @@ static int das16_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 			osc_base = I8254_OSC_BASE_1MHZ / it->options[3];
 	}
 
-	dev->pacer = comedi_8254_init(dev->iobase + DAS16_TIMER_BASE_REG,
-				      osc_base, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + DAS16_TIMER_BASE_REG,
+					  osc_base, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	das16_alloc_dma(dev, it->options[2]);
 
diff --git a/drivers/comedi/drivers/das16m1.c b/drivers/comedi/drivers/das16m1.c
index 275effb77746..ff9c5a8897bd 100644
--- a/drivers/comedi/drivers/das16m1.c
+++ b/drivers/comedi/drivers/das16m1.c
@@ -529,15 +529,16 @@ static int das16m1_attach(struct comedi_device *dev,
 			dev->irq = it->options[1];
 	}
 
-	dev->pacer = comedi_8254_init(dev->iobase + DAS16M1_8254_IOBASE2,
-				      I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + DAS16M1_8254_IOBASE2,
+					  I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
-	devpriv->counter = comedi_8254_init(dev->iobase + DAS16M1_8254_IOBASE1,
-					    0, I8254_IO8, 0);
-	if (!devpriv->counter)
-		return -ENOMEM;
+	devpriv->counter =
+	    comedi_8254_io_alloc(dev->iobase + DAS16M1_8254_IOBASE1,
+				 0, I8254_IO8, 0);
+	if (IS_ERR(devpriv->counter))
+		return PTR_ERR(devpriv->counter);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
@@ -603,7 +604,8 @@ static void das16m1_detach(struct comedi_device *dev)
 	if (devpriv) {
 		if (devpriv->extra_iobase)
 			release_region(devpriv->extra_iobase, DAS16M1_SIZE2);
-		kfree(devpriv->counter);
+		if (!IS_ERR(devpriv->counter))
+			kfree(devpriv->counter);
 	}
 	comedi_legacy_detach(dev);
 }
diff --git a/drivers/comedi/drivers/das1800.c b/drivers/comedi/drivers/das1800.c
index f09608c0f4ff..7117c67aee7e 100644
--- a/drivers/comedi/drivers/das1800.c
+++ b/drivers/comedi/drivers/das1800.c
@@ -1233,10 +1233,10 @@ static int das1800_attach(struct comedi_device *dev,
 	if (!devpriv->fifo_buf)
 		return -ENOMEM;
 
-	dev->pacer = comedi_8254_init(dev->iobase + DAS1800_COUNTER,
-				      I8254_OSC_BASE_5MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + DAS1800_COUNTER,
+					  I8254_OSC_BASE_5MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/das6402.c b/drivers/comedi/drivers/das6402.c
index 1af394591e74..68f95330de45 100644
--- a/drivers/comedi/drivers/das6402.c
+++ b/drivers/comedi/drivers/das6402.c
@@ -590,10 +590,10 @@ static int das6402_attach(struct comedi_device *dev,
 		}
 	}
 
-	dev->pacer = comedi_8254_init(dev->iobase + DAS6402_TIMER_BASE,
-				      I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + DAS6402_TIMER_BASE,
+					  I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/das800.c b/drivers/comedi/drivers/das800.c
index 4ca33f46eaa7..300775523031 100644
--- a/drivers/comedi/drivers/das800.c
+++ b/drivers/comedi/drivers/das800.c
@@ -672,10 +672,10 @@ static int das800_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 			dev->irq = irq;
 	}
 
-	dev->pacer = comedi_8254_init(dev->iobase + DAS800_8254,
-				      I8254_OSC_BASE_1MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + DAS800_8254,
+					  I8254_OSC_BASE_1MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 3);
 	if (ret)
diff --git a/drivers/comedi/drivers/me4000.c b/drivers/comedi/drivers/me4000.c
index 9aea02b86ed9..7dd3a0071863 100644
--- a/drivers/comedi/drivers/me4000.c
+++ b/drivers/comedi/drivers/me4000.c
@@ -1209,9 +1209,9 @@ static int me4000_auto_attach(struct comedi_device *dev,
 		if (!timer_base)
 			return -ENODEV;
 
-		dev->pacer = comedi_8254_init(timer_base, 0, I8254_IO8, 0);
-		if (!dev->pacer)
-			return -ENOMEM;
+		dev->pacer = comedi_8254_io_alloc(timer_base, 0, I8254_IO8, 0);
+		if (IS_ERR(dev->pacer))
+			return PTR_ERR(dev->pacer);
 
 		comedi_8254_subdevice_init(s, dev->pacer);
 	} else {
diff --git a/drivers/comedi/drivers/ni_at_a2150.c b/drivers/comedi/drivers/ni_at_a2150.c
index df8d219e6723..e4e5a0ebd195 100644
--- a/drivers/comedi/drivers/ni_at_a2150.c
+++ b/drivers/comedi/drivers/ni_at_a2150.c
@@ -707,10 +707,10 @@ static int a2150_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	/* an IRQ and DMA are required to support async commands */
 	a2150_alloc_irq_and_dma(dev, it);
 
-	dev->pacer = comedi_8254_init(dev->iobase + I8253_BASE_REG,
-				      0, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + I8253_BASE_REG,
+					  0, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 1);
 	if (ret)
diff --git a/drivers/comedi/drivers/ni_at_ao.c b/drivers/comedi/drivers/ni_at_ao.c
index 9f3147b72aa8..9cf6b4ff6b65 100644
--- a/drivers/comedi/drivers/ni_at_ao.c
+++ b/drivers/comedi/drivers/ni_at_ao.c
@@ -303,10 +303,10 @@ static int atao_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	if (!devpriv)
 		return -ENOMEM;
 
-	dev->pacer = comedi_8254_init(dev->iobase + ATAO_82C53_BASE,
-				      0, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + ATAO_82C53_BASE,
+					  0, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
index 763249653228..eb8f6431276a 100644
--- a/drivers/comedi/drivers/ni_labpc_common.c
+++ b/drivers/comedi/drivers/ni_labpc_common.c
@@ -1222,24 +1222,24 @@ int labpc_common_attach(struct comedi_device *dev,
 	}
 
 	if (dev->mmio) {
-		dev->pacer = comedi_8254_mm_init(dev->mmio + COUNTER_B_BASE_REG,
-						 I8254_OSC_BASE_2MHZ,
-						 I8254_IO8, 0);
-		devpriv->counter = comedi_8254_mm_init(dev->mmio +
-						       COUNTER_A_BASE_REG,
-						       I8254_OSC_BASE_2MHZ,
-						       I8254_IO8, 0);
+		dev->pacer =
+		    comedi_8254_mm_alloc(dev->mmio + COUNTER_B_BASE_REG,
+					 I8254_OSC_BASE_2MHZ, I8254_IO8, 0);
+		devpriv->counter =
+		    comedi_8254_mm_alloc(dev->mmio + COUNTER_A_BASE_REG,
+					 I8254_OSC_BASE_2MHZ, I8254_IO8, 0);
 	} else {
-		dev->pacer = comedi_8254_init(dev->iobase + COUNTER_B_BASE_REG,
-					      I8254_OSC_BASE_2MHZ,
-					      I8254_IO8, 0);
-		devpriv->counter = comedi_8254_init(dev->iobase +
-						    COUNTER_A_BASE_REG,
-						    I8254_OSC_BASE_2MHZ,
-						    I8254_IO8, 0);
+		dev->pacer =
+		    comedi_8254_io_alloc(dev->iobase + COUNTER_B_BASE_REG,
+					 I8254_OSC_BASE_2MHZ, I8254_IO8, 0);
+		devpriv->counter =
+		    comedi_8254_io_alloc(dev->iobase + COUNTER_A_BASE_REG,
+					 I8254_OSC_BASE_2MHZ, I8254_IO8, 0);
 	}
-	if (!dev->pacer || !devpriv->counter)
-		return -ENOMEM;
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
+	if (IS_ERR(devpriv->counter))
+		return PTR_ERR(devpriv->counter);
 
 	ret = comedi_alloc_subdevices(dev, 5);
 	if (ret)
@@ -1341,8 +1341,10 @@ void labpc_common_detach(struct comedi_device *dev)
 {
 	struct labpc_private *devpriv = dev->private;
 
-	if (devpriv)
-		kfree(devpriv->counter);
+	if (devpriv) {
+		if (!IS_ERR(devpriv->counter))
+			kfree(devpriv->counter);
+	}
 }
 EXPORT_SYMBOL_GPL(labpc_common_detach);
 
diff --git a/drivers/comedi/drivers/pcl711.c b/drivers/comedi/drivers/pcl711.c
index 05172c553c8a..0cf3917defe7 100644
--- a/drivers/comedi/drivers/pcl711.c
+++ b/drivers/comedi/drivers/pcl711.c
@@ -429,10 +429,10 @@ static int pcl711_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 			dev->irq = it->options[1];
 	}
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCL711_TIMER_BASE,
-				      I8254_OSC_BASE_2MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCL711_TIMER_BASE,
+					  I8254_OSC_BASE_2MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/pcl812.c b/drivers/comedi/drivers/pcl812.c
index 70dbc129fcf5..0df639c6a595 100644
--- a/drivers/comedi/drivers/pcl812.c
+++ b/drivers/comedi/drivers/pcl812.c
@@ -1143,11 +1143,11 @@ static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		return ret;
 
 	if (board->irq_bits) {
-		dev->pacer = comedi_8254_init(dev->iobase + PCL812_TIMER_BASE,
-					      I8254_OSC_BASE_2MHZ,
-					      I8254_IO8, 0);
-		if (!dev->pacer)
-			return -ENOMEM;
+		dev->pacer =
+		    comedi_8254_io_alloc(dev->iobase + PCL812_TIMER_BASE,
+					 I8254_OSC_BASE_2MHZ, I8254_IO8, 0);
+		if (IS_ERR(dev->pacer))
+			return PTR_ERR(dev->pacer);
 
 		if ((1 << it->options[1]) & board->irq_bits) {
 			ret = request_irq(it->options[1], pcl812_interrupt, 0,
diff --git a/drivers/comedi/drivers/pcl816.c b/drivers/comedi/drivers/pcl816.c
index a5e5320be648..28d1a88c50f6 100644
--- a/drivers/comedi/drivers/pcl816.c
+++ b/drivers/comedi/drivers/pcl816.c
@@ -615,10 +615,10 @@ static int pcl816_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	/* an IRQ and DMA are required to support async commands */
 	pcl816_alloc_irq_and_dma(dev, it);
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCL816_TIMER_BASE,
-				      I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCL816_TIMER_BASE,
+					  I8254_OSC_BASE_10MHZ, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	ret = comedi_alloc_subdevices(dev, 4);
 	if (ret)
diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
index 29e503de8267..4127adcfb229 100644
--- a/drivers/comedi/drivers/pcl818.c
+++ b/drivers/comedi/drivers/pcl818.c
@@ -1015,10 +1015,10 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	else
 		osc_base = I8254_OSC_BASE_1MHZ;
 
-	dev->pacer = comedi_8254_init(dev->iobase + PCL818_TIMER_BASE,
-				      osc_base, I8254_IO8, 0);
-	if (!dev->pacer)
-		return -ENOMEM;
+	dev->pacer = comedi_8254_io_alloc(dev->iobase + PCL818_TIMER_BASE,
+					  osc_base, I8254_IO8, 0);
+	if (IS_ERR(dev->pacer))
+		return PTR_ERR(dev->pacer);
 
 	/* max sampling speed */
 	devpriv->ns_min = board->ns_min;
diff --git a/drivers/comedi/drivers/rtd520.c b/drivers/comedi/drivers/rtd520.c
index 7e0ec1a2a2ca..44bb0decd7a4 100644
--- a/drivers/comedi/drivers/rtd520.c
+++ b/drivers/comedi/drivers/rtd520.c
@@ -1289,9 +1289,9 @@ static int rtd_auto_attach(struct comedi_device *dev,
 
 	/* 8254 Timer/Counter subdevice */
 	s = &dev->subdevices[3];
-	dev->pacer = comedi_8254_mm_init(dev->mmio + LAS0_8254_TIMER_BASE,
-					 RTD_CLOCK_BASE, I8254_IO8, 2);
-	if (!dev->pacer)
+	dev->pacer = comedi_8254_mm_alloc(dev->mmio + LAS0_8254_TIMER_BASE,
+					  RTD_CLOCK_BASE, I8254_IO8, 2);
+	if (IS_ERR(dev->pacer))
 		return -ENOMEM;
 
 	comedi_8254_subdevice_init(s, dev->pacer);
diff --git a/include/linux/comedi/comedi_8254.h b/include/linux/comedi/comedi_8254.h
index 18d12321c87d..393ccb301028 100644
--- a/include/linux/comedi/comedi_8254.h
+++ b/include/linux/comedi/comedi_8254.h
@@ -136,13 +136,13 @@ void comedi_8254_set_busy(struct comedi_8254 *i8254,
 void comedi_8254_subdevice_init(struct comedi_subdevice *s,
 				struct comedi_8254 *i8254);
 
-struct comedi_8254 *comedi_8254_init(unsigned long iobase,
-				     unsigned int osc_base,
-				     unsigned int iosize,
-				     unsigned int regshift);
-struct comedi_8254 *comedi_8254_mm_init(void __iomem *mmio,
-					unsigned int osc_base,
-					unsigned int iosize,
-					unsigned int regshift);
+struct comedi_8254 *comedi_8254_io_alloc(unsigned long iobase,
+					 unsigned int osc_base,
+					 unsigned int iosize,
+					 unsigned int regshift);
+struct comedi_8254 *comedi_8254_mm_alloc(void __iomem *mmio,
+					 unsigned int osc_base,
+					 unsigned int iosize,
+					 unsigned int regshift);
 
 #endif	/* _COMEDI_8254_H */
-- 
2.40.1

