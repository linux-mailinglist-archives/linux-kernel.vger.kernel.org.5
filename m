Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF37CFF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjJSQXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjJSQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:23:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C411126;
        Thu, 19 Oct 2023 09:23:04 -0700 (PDT)
Received: from anderl.fritz.box ([31.220.118.173]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MI41P-1qhhIJ1jV9-00FFCj; Thu, 19 Oct 2023 18:22:44 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergei Korolev <dssoftsk@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: bmp280: fix eoc interrupt usage
Date:   Thu, 19 Oct 2023 18:22:09 +0200
Message-Id: <20231019162209.18872-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018152816.56589-1-ak@it-klinger.de>
References: <20231018152816.56589-1-ak@it-klinger.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:szfII3NCiC1EDuhf3omFrXIz/cNi2TIlI4+gtPHfiVxW8Fr3RRU
 A3SHtJJkNIjimHQwGtAxpIM5AgL6iQ7pLpR1kMvnAUpUmhtm6FUZW+LsxX1/ixWfZLWwBnQ
 25UxdYIbXBvB8lZvwqr8CaYi3hxbtlbKQTC3RIsnahpV0KVGJZNco/edonb/kQmBitzCiaO
 ZQGtljFqheROANFTPSltw==
UI-OutboundReport: notjunk:1;M01:P0:M7o/P3M8TVQ=;S9p6l4NGE8yMZljoTUIhQ1jwF69
 hsJPccZddHvEpUPNCutkfHHm/nQlEtbnBDuHUDJMXdGgDYJzmnYGDYLjqUhKg7xE9/UXGDqRS
 2y0d+A4PM7trNx6qdEIOzCCxPM09HHJTgsBdvatPLCBqgfMtJn8ji5Z5RqFQ95bDISwn8/aSU
 DVFMMOPgBdwj03gVnG/u26KEpX7SqrUUgaERN8e6dIAiUCCZ0XIkGr57weT52Q88d87Gt40TX
 ZBqQGPO0TJcq3g04CS1fXqRhhvDgYux976onOqJoIxCcmpEwpvll5EZDhDAzhpFYBd1ZJ/P+2
 0gsgfiTQMQjiYZ5rIUTqzav105QJXj9eKbW63yGHMcdoDCy33J4G5eASD516zRFZbglSgfcI8
 wppfpPCtfqp0JQOLkSSyXJu/xriZ3/DNdhKuxmr+chlvHB28/f5UPECe+dpNJOJtkSYEEXCEe
 CjM70RnukbrefvZM8wxA2vupCSh+EjYmqmW91LKEDfRQ/SgNmZikd66b8zqeuM4t3hk2/Sm5F
 xd/6dChFdcEz2RhAqiVpbWXqx52popAqCl0bD1PSS3oHEi2PDi6swgt2C6UkmUe78d1+FJV7a
 56oqMmhOg7x/N/jY8DwIn69sLi4zr4DY7CAh9ncuCqJaAgWh2DMJFEzbIlTYqn534uZVZBNAH
 rpX8huRWb8lBRe7J9pTnVQ5JvYKqkGExrkv7zVfP0UHx2Dw6v7dlyihoWrebWPpozsvPSkZnD
 bfmKyEWT0TJz1aCIeJjG3O+/Y2akH/2hAEi4F32jVlB/UV79YxGXwU7CojBdr2MvDsqkrsjBW
 Z8N2DvNV4cbkCAmcOchX1M69WiW/kIu+yO7QqzK2dLAn8fwmS98nPbPfmOqNi3sXtSLCnxLJY
 2WrR7CD1lIPrYZA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_PERMERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the bmp085 can have an End-Of-Conversion (EOC) interrupt. But the
bmp085 and bmp180 share the same chip id. Therefore it's necessary to
distinguish the case in which the interrupt is set.

Fix the if statement so that only when the interrupt is set and the chip
id is recognized the interrupt is requested.

This bug exists since the support of EOC interrupt was introduced.
Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")

Also add a link to bmp085 datasheet for reference.

Suggested-by: Sergei Korolev <dssoftsk@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 v1 -> v2: Remove extra space (seen by Andy)

 drivers/iio/pressure/bmp280-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6089f3f9d8f4..ef9b3c4f2340 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -9,6 +9,7 @@
  * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
  *
  * Datasheet:
+ * https://www.sparkfun.com/datasheets/Components/General/BST-BMP085-DS000-05.pdf
  * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
@@ -2179,7 +2180,7 @@ int bmp280_common_probe(struct device *dev,
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
 	 */
-	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+	if (irq > 0 && (chip_id == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
 			return ret;
-- 
2.39.2

