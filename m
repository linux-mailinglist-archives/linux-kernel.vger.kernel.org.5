Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797B979EF19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjIMQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjIMQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:12 -0400
Received: from smtp71.iad3a.emailsrvr.com (smtp71.iad3a.emailsrvr.com [173.203.187.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3DE3C3F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623238;
        bh=S6A0R8UwQZX2BpyXHgTGz+DwJ/QqgrKGsXty8EwurHc=;
        h=From:To:Subject:Date:From;
        b=Ua8tscvNtOwMDvvROGKnBNj8/ecADNUrDbauucEpinSLPAiinNJoguwYqRYQY3eHr
         D4WSuMlbjs2/zUHUjIesawnPCgduiUOyE8yZAftobUObwb5Sjwx+iiCJreZm1r1AHL
         i+t/zTj+ydzUkjZ/Rj0IWJSTEjP/CXVO/W6cNZdI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 681A423049;
        Wed, 13 Sep 2023 12:40:37 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 08/13] comedi: ni_labpc_common: Conditionally remove I/O port support
Date:   Wed, 13 Sep 2023 17:40:08 +0100
Message-Id: <20230913164013.107520-9-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-9-1
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
functions so they are compiled if and only if the `CONFIG_HAS_IOPORT`
macro is defined, so that the module can be built if the port I/O
functions have not been declared.

Add a run-time check in the `labpc_common_attach()` to return an error
if the comedi device wants to use port I/O when the `CONFIG_HAS_IOPORT`
macro is undefined.

The changes allow the module to be built even if the port I/O functions
have not been declared.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct `CONFIG_HAS_PORTIO` to `CONFIG_HAS_IOPORT`.  Edit commit
message to describe run-time check in `labpc_common_attach()`, and to
mention that the changes allow the module to be built even if the port
I/O functions have not been declared.
---
 drivers/comedi/drivers/ni_labpc_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/comedi/drivers/ni_labpc_common.c b/drivers/comedi/drivers/ni_labpc_common.c
index 5d5c1d0e9cb6..7e0ce0ce0adf 100644
--- a/drivers/comedi/drivers/ni_labpc_common.c
+++ b/drivers/comedi/drivers/ni_labpc_common.c
@@ -78,6 +78,9 @@ static const struct comedi_lrange range_labpc_ao = {
  * functions that do inb/outb and readb/writeb so we can use
  * function pointers to decide which to use
  */
+
+#ifdef CONFIG_HAS_IOPORT
+
 static unsigned int labpc_inb(struct comedi_device *dev, unsigned long reg)
 {
 	return inb(dev->iobase + reg);
@@ -89,6 +92,8 @@ static void labpc_outb(struct comedi_device *dev,
 	outb(byte, dev->iobase + reg);
 }
 
+#endif	/* CONFIG_HAS_IOPORT */
+
 static unsigned int labpc_readb(struct comedi_device *dev, unsigned long reg)
 {
 	return readb(dev->mmio + reg);
@@ -1200,8 +1205,12 @@ int labpc_common_attach(struct comedi_device *dev,
 		devpriv->read_byte = labpc_readb;
 		devpriv->write_byte = labpc_writeb;
 	} else {
+#ifdef CONFIG_HAS_IOPORT
 		devpriv->read_byte = labpc_inb;
 		devpriv->write_byte = labpc_outb;
+#else
+		return -ENXIO;
+#endif
 	}
 
 	/* initialize board's command registers */
-- 
2.40.1

