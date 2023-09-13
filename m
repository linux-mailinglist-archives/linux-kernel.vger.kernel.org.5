Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3079E689
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbjIMLVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbjIMLVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:21:02 -0400
Received: from smtp105.iad3b.emailsrvr.com (smtp105.iad3b.emailsrvr.com [146.20.161.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26031BD1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604057;
        bh=Rcu+WRcF+p3jk6uJghybFBGg7QHs0LcO4lWUEsaEf5w=;
        h=From:To:Subject:Date:From;
        b=cv7gORdk2clgqp48dvwHFMnW9ZY736WWJ6r0YBoIQaxk83CFjoQJ9ZICg9nxNEy4p
         FNjRiRIMUFosEdfHFAMaW4GZaF781+koUPylTfKqKlcTBes0a7UlQ4yqm0LpR8VYC4
         wxjPZj+okV4I6oxBL7OKTaoFPSYYAW+ERLrgA4ZE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6FA5D200F2;
        Wed, 13 Sep 2023 07:20:56 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 07/13] comedi: comedi_8255: Conditionally remove I/O port support
Date:   Wed, 13 Sep 2023 12:20:26 +0100
Message-Id: <20230913112032.90618-8-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913112032.90618-1-abbotti@mev.co.uk>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e346d63c-f057-4595-b974-8be9cf32e1c1-8-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends will only be declared in the `HAS_IOPORT` configuration option
is enabled.

The comedi_8255 module supports both port I/O and memory-mapped I/O.

Conditionally compile the parts of the module that use port I/O if and
only if the `CONFIG_HAS_PORTIO` macro is defined so that it can still be
built if the port I/O functions have not been declared.  If the
`CONFIG_HAS_IOPORT` macro is undefined, replace the GPL-exported
`subdev_8255_io_init()` function with a dummy static inline version that
just returns `-ENXIO`.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
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

