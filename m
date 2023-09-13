Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249C079EF18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjIMQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjIMQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:18 -0400
Received: from smtp65.iad3a.emailsrvr.com (smtp65.iad3a.emailsrvr.com [173.203.187.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC7A4227
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623242;
        bh=Gqt0xUEjwvsOjmZu6WszvumHXpWvipdZWDL6ltORHoQ=;
        h=From:To:Subject:Date:From;
        b=qAVcf1DckYYJOLI5uqe3x8sEsRd2q6K9E7QazxFLM8YXAGfcH0ukD38Aj6gLLdeqJ
         q+K4y73WGFXHXJ7ZL6duQzgjRIlKA4r7VLdW70/draL4XsCk1PMLQPWKjr0U+H9Hhn
         5yUKQiYIyVs97lWPwdwTOuIBbZjwj3JP51HZNGQA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 57C3E239A1;
        Wed, 13 Sep 2023 12:40:41 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 11/13] comedi: amplc_dio200_common: Refactor register access functions
Date:   Wed, 13 Sep 2023 17:40:11 +0100
Message-Id: <20230913164013.107520-12-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-12-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `dio200_read8()`, `dio200_write8()`, `dio200_read32()` and
`dio200_write32()` functions apply a right-shift to the register offset
for some devices and then perform the actual register access.  Factor
the register access part out to new functions `dio200___read8()`,
`dio200___write8()`, `dio200___read32()`, and `dio200___write32()`.
This will reduce duplicated code in a subsequent patch that will
conditionally compile support for port I/O as part of the `HAS_IOPORT`
changes.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct `HAS_PORTIO` to `HAS_IOPORT` in commit description.
---
 drivers/comedi/drivers/amplc_dio200_common.c | 52 ++++++++++++++------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/comedi/drivers/amplc_dio200_common.c b/drivers/comedi/drivers/amplc_dio200_common.c
index 19166cb26f5e..e6d63e89e7bf 100644
--- a/drivers/comedi/drivers/amplc_dio200_common.c
+++ b/drivers/comedi/drivers/amplc_dio200_common.c
@@ -86,6 +86,40 @@ struct dio200_subdev_intr {
 	unsigned int active:1;
 };
 
+static unsigned char dio200___read8(struct comedi_device *dev,
+				    unsigned int offset)
+{
+	if (dev->mmio)
+		return readb(dev->mmio + offset);
+	return inb(dev->iobase + offset);
+}
+
+static void dio200___write8(struct comedi_device *dev,
+			    unsigned int offset, unsigned char val)
+{
+	if (dev->mmio)
+		writeb(val, dev->mmio + offset);
+	else
+		outb(val, dev->iobase + offset);
+}
+
+static unsigned int dio200___read32(struct comedi_device *dev,
+				    unsigned int offset)
+{
+	if (dev->mmio)
+		return readl(dev->mmio + offset);
+	return inl(dev->iobase + offset);
+}
+
+static void dio200___write32(struct comedi_device *dev,
+			     unsigned int offset, unsigned int val)
+{
+	if (dev->mmio)
+		writel(val, dev->mmio + offset);
+	else
+		outl(val, dev->iobase + offset);
+}
+
 static unsigned char dio200_read8(struct comedi_device *dev,
 				  unsigned int offset)
 {
@@ -94,9 +128,7 @@ static unsigned char dio200_read8(struct comedi_device *dev,
 	if (board->is_pcie)
 		offset <<= 3;
 
-	if (dev->mmio)
-		return readb(dev->mmio + offset);
-	return inb(dev->iobase + offset);
+	return dio200___read8(dev, offset);
 }
 
 static void dio200_write8(struct comedi_device *dev,
@@ -107,10 +139,7 @@ static void dio200_write8(struct comedi_device *dev,
 	if (board->is_pcie)
 		offset <<= 3;
 
-	if (dev->mmio)
-		writeb(val, dev->mmio + offset);
-	else
-		outb(val, dev->iobase + offset);
+	dio200___write8(dev, offset, val);
 }
 
 static unsigned int dio200_read32(struct comedi_device *dev,
@@ -121,9 +150,7 @@ static unsigned int dio200_read32(struct comedi_device *dev,
 	if (board->is_pcie)
 		offset <<= 3;
 
-	if (dev->mmio)
-		return readl(dev->mmio + offset);
-	return inl(dev->iobase + offset);
+	return dio200___read32(dev, offset);
 }
 
 static void dio200_write32(struct comedi_device *dev,
@@ -134,10 +161,7 @@ static void dio200_write32(struct comedi_device *dev,
 	if (board->is_pcie)
 		offset <<= 3;
 
-	if (dev->mmio)
-		writel(val, dev->mmio + offset);
-	else
-		outl(val, dev->iobase + offset);
+	dio200___write32(dev, offset, val);
 }
 
 static unsigned int dio200_subdev_8254_offset(struct comedi_device *dev,
-- 
2.40.1

