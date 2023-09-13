Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2672979EFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjIMRHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjIMRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:07:31 -0400
Received: from smtp112.iad3a.emailsrvr.com (smtp112.iad3a.emailsrvr.com [173.203.187.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A51BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694624847;
        bh=I/tHvGfvIq4pfoyP88Yoc/G05xULJ8fWaIvY9vzRiPo=;
        h=From:To:Subject:Date:From;
        b=tNTVTGePy2ETvYe63x8zPiMQzlQKkONWfVBmNdB8CTIuCew+WrS5Lw2Zdk/nRAV+Z
         btT8quW5VX8qN8VQPKGHRdJYnU6C7VCU0POspxt9e9zKLZdwIrRYQ/SWVLO2AYwxgU
         J2dOXikxkXSl7HoaLGOjaxeERStvCTeI6xu2Vbmw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 37E9354FE;
        Wed, 13 Sep 2023 13:07:26 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 04/13] comedi: comedi_8254: Conditionally remove I/O port support
Date:   Wed, 13 Sep 2023 18:07:03 +0100
Message-Id: <20230913170712.111719-5-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913170712.111719-1-abbotti@mev.co.uk>
References: <20230913164013.107520-1-abbotti@mev.co.uk>
 <20230913170712.111719-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 19793052-af61-4898-a406-82596fa230be-5-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comedi_8254 module supports both port I/O and memory-mapped I/O.
In a future patch, the port I/O functions (`inb()`, `outb()`, and
friends) will only be declared if the `HAS_IOPORT` configuration option
is enabled.

Conditionally compile the parts of the module that use port I/O so they
are compiled if and only if the `CONFIG_HAS_IOPORT` macro is defined, so
that it can still be built if the port I/O functions have not been
declared.  If `CONFIG_HAS_IOPORT` is undefined, replace the GPL-exported
`comedi_8254_io_alloc()` function with a dummy static inline version
that just returns `ERR_PTR(-ENXIO)`.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: N/A.
v3: Add missing `---` divider before patch changelog.
---
 drivers/comedi/drivers/comedi_8254.c |  8 ++++++++
 include/linux/comedi/comedi_8254.h   | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index 696596944506..6beca2a6d66e 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
@@ -122,6 +122,8 @@
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_8254.h>
 
+#ifdef CONFIG_HAS_IOPORT
+
 static unsigned int i8254_io8_cb(struct comedi_8254 *i8254, int dir,
 				unsigned int reg, unsigned int val)
 {
@@ -164,6 +166,8 @@ static unsigned int i8254_io32_cb(struct comedi_8254 *i8254, int dir,
 	}
 }
 
+#endif	/* CONFIG_HAS_IOPORT */
+
 static unsigned int i8254_mmio8_cb(struct comedi_8254 *i8254, int dir,
 				   unsigned int reg, unsigned int val)
 {
@@ -648,6 +652,8 @@ static struct comedi_8254 *__i8254_init(comedi_8254_iocb_fn *iocb,
 	return i8254;
 }
 
+#ifdef CONFIG_HAS_IOPORT
+
 /**
  * comedi_8254_io_alloc - allocate and initialize the 8254 device for pio access
  * @iobase:	port I/O base address
@@ -682,6 +688,8 @@ struct comedi_8254 *comedi_8254_io_alloc(unsigned long iobase,
 }
 EXPORT_SYMBOL_GPL(comedi_8254_io_alloc);
 
+#endif	/* CONFIG_HAS_IOPORT */
+
 /**
  * comedi_8254_mm_alloc - allocate and initialize the 8254 device for mmio access
  * @mmio:	memory mapped I/O base address
diff --git a/include/linux/comedi/comedi_8254.h b/include/linux/comedi/comedi_8254.h
index 393ccb301028..d527f04400df 100644
--- a/include/linux/comedi/comedi_8254.h
+++ b/include/linux/comedi/comedi_8254.h
@@ -12,6 +12,8 @@
 #define _COMEDI_8254_H
 
 #include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
 
 struct comedi_device;
 struct comedi_insn;
@@ -136,10 +138,21 @@ void comedi_8254_set_busy(struct comedi_8254 *i8254,
 void comedi_8254_subdevice_init(struct comedi_subdevice *s,
 				struct comedi_8254 *i8254);
 
+#ifdef CONFIG_HAS_IOPORT
 struct comedi_8254 *comedi_8254_io_alloc(unsigned long iobase,
 					 unsigned int osc_base,
 					 unsigned int iosize,
 					 unsigned int regshift);
+#else
+static inline struct comedi_8254 *comedi_8254_io_alloc(unsigned long iobase,
+						       unsigned int osc_base,
+						       unsigned int iosize,
+						       unsigned int regshift)
+{
+	return ERR_PTR(-ENXIO);
+}
+#endif
+
 struct comedi_8254 *comedi_8254_mm_alloc(void __iomem *mmio,
 					 unsigned int osc_base,
 					 unsigned int iosize,
-- 
2.40.1

