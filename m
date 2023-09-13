Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456179EF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjIMQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjIMQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:04 -0400
Received: from smtp67.iad3a.emailsrvr.com (smtp67.iad3a.emailsrvr.com [173.203.187.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31D3C2A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623237;
        bh=ElEo1fCXb3ElxGwXpE5dWw47teDAV9y9nmpqAtCla2A=;
        h=From:To:Subject:Date:From;
        b=QCsrn44SnttXfaaAwl3CRT/tv0fIOhZbUec8fSmFxZek4sifelFt4dGaNTm2uaR5V
         X31oKLoOSZkCIX2VrF1EdvXzblJxcWINDGkqPDdvIUgyqilPe/zCPTAV07hbJt2f3D
         eyjtJD060IjVeJy80QF7wEIiW/0jMa6RSWH95GAc=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1F45725299;
        Wed, 13 Sep 2023 12:40:36 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 07/13] comedi: comedi_8255: Conditionally remove I/O port support
Date:   Wed, 13 Sep 2023 17:40:07 +0100
Message-Id: <20230913164013.107520-8-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-8-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends will only be declared in the `HAS_IOPORT` configuration option
is enabled.

The comedi_8255 module supports both port I/O and memory-mapped I/O.

Conditionally compile the parts of the module that use port I/O if and
only if the `CONFIG_HAS_IOPORT` macro is defined so that it can still be
built if the port I/O functions have not been declared.  If the
`CONFIG_HAS_IOPORT` macro is undefined, replace the GPL-exported
`subdev_8255_io_init()` function with a dummy static inline version that
just returns `-ENXIO`.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct `CONFIG_HAS_PORTIO` to `CONFIG_HAS_IOPORT` in commit
description.
---
 drivers/comedi/drivers/comedi_8255.c |  8 ++++++++
 include/linux/comedi/comedi_8255.h   | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/comedi/drivers/comedi_8255.c b/drivers/comedi/drivers/comedi_8255.c
index 28fd9d8c95cc..e4974b508328 100644
--- a/drivers/comedi/drivers/comedi_8255.c
+++ b/drivers/comedi/drivers/comedi_8255.c
@@ -38,6 +38,8 @@ struct subdev_8255_private {
 		  unsigned long context);
 };
 
+#ifdef CONFIG_HAS_IOPORT
+
 static int subdev_8255_io(struct comedi_device *dev,
 			  int dir, int port, int data, unsigned long regbase)
 {
@@ -48,6 +50,8 @@ static int subdev_8255_io(struct comedi_device *dev,
 	return inb(dev->iobase + regbase + port);
 }
 
+#endif /* CONFIG_HAS_IOPORT */
+
 static int subdev_8255_mmio(struct comedi_device *dev,
 			    int dir, int port, int data, unsigned long regbase)
 {
@@ -169,6 +173,8 @@ static int __subdev_8255_init(struct comedi_device *dev,
 	return 0;
 }
 
+#ifdef CONFIG_HAS_IOPORT
+
 /**
  * subdev_8255_io_init - initialize DIO subdevice for driving I/O mapped 8255
  * @dev: comedi device owning subdevice
@@ -186,6 +192,8 @@ int subdev_8255_io_init(struct comedi_device *dev, struct comedi_subdevice *s,
 }
 EXPORT_SYMBOL_GPL(subdev_8255_io_init);
 
+#endif	/* CONFIG_HAS_IOPORT */
+
 /**
  * subdev_8255_mm_init - initialize DIO subdevice for driving mmio-mapped 8255
  * @dev: comedi device owning subdevice
diff --git a/include/linux/comedi/comedi_8255.h b/include/linux/comedi/comedi_8255.h
index b396fcfbf8b0..d24a69da389b 100644
--- a/include/linux/comedi/comedi_8255.h
+++ b/include/linux/comedi/comedi_8255.h
@@ -10,6 +10,8 @@
 #ifndef _COMEDI_8255_H
 #define _COMEDI_8255_H
 
+#include <linux/errno.h>
+
 #define I8255_SIZE		0x04
 
 #define I8255_DATA_A_REG	0x00
@@ -27,8 +29,17 @@
 struct comedi_device;
 struct comedi_subdevice;
 
+#ifdef CONFIG_HAS_IOPORT
 int subdev_8255_io_init(struct comedi_device *dev, struct comedi_subdevice *s,
 			unsigned long regbase);
+#else
+static inline int subdev_8255_io_init(struct comedi_device *dev,
+				      struct comedi_subdevice *s,
+				      unsigned long regbase)
+{
+	return -ENXIO;
+}
+#endif
 
 int subdev_8255_mm_init(struct comedi_device *dev, struct comedi_subdevice *s,
 			unsigned long regbase);
-- 
2.40.1

