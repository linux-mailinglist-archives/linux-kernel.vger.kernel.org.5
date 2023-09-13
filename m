Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A8379EFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjIMRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjIMRHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:07:36 -0400
Received: from smtp119.iad3a.emailsrvr.com (smtp119.iad3a.emailsrvr.com [173.203.187.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438491BD1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694624851;
        bh=pK0cMMnR27s2hNteQP+Jk6qnFAGNVa+UnJLFRlW2bbQ=;
        h=From:To:Subject:Date:From;
        b=X2F0PpcQyf9d+yJmjVIKgOd1R8pvEUcaAwRLJM4o5whx+dSDw0oBTbV9kZr7di/ix
         HfSXVyiXoZQCxGVK3J9yTPIWlFl1JNjf5rhJMHd+aCeWcwWBTg5smFsO85FYLOwL4j
         miL2Wd3QN9vq7r3kEJXYeQjhASQHa4hCGprnfLFg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7C35E551C;
        Wed, 13 Sep 2023 13:07:30 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 07/13] comedi: comedi_8255: Conditionally remove I/O port support
Date:   Wed, 13 Sep 2023 18:07:06 +0100
Message-Id: <20230913170712.111719-8-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913170712.111719-1-abbotti@mev.co.uk>
References: <20230913164013.107520-1-abbotti@mev.co.uk>
 <20230913170712.111719-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 19793052-af61-4898-a406-82596fa230be-8-1
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
v3: N/A.
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

