Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D8783E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjHVLNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjHVLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:13:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CBCCD4;
        Tue, 22 Aug 2023 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692702812; x=1724238812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0BmNgT7Lq4jLEOqmdKssa+DAw9AJFd3Z4vEXWDUvxbs=;
  b=CEY0iziOi/nm14zIxF71Zvdln0ahXaYdYlWJKhpRKTJOTcqYqjt8Gbjm
   JiuiscJCVzE324fyq7q9avBcGC4RyCUnnGx25Ny+igjDjaw/wRuZwLfhC
   aJz95rgV49Y7dAj1NJjC/nJ29pRChviFBLgi7wCDHAJcdwJIrg471G9w0
   3NlRrgsyqvT9aZD2WiugT4QRWjyZ7/wFfdm3NVYfD0criHgf6tnB6e6Q/
   I09+Knab7+z3wP/0JGon6Vt1+VxrubOqacUqYTE68blBK+Foa2/+Gel14
   pKDnqoAO7IIUbu0ui9ZbSWh3UXy7YO99paG6NBztPARG98pZ2MtZfec4u
   A==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="648107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2023 04:13:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 22 Aug 2023 04:13:32 -0700
Received: from che-lt-i63539.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 22 Aug 2023 04:13:27 -0700
From:   Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
Subject: [PATCH] serial: atmel: Fix Spectre v1 vulnerability reported by smatch
Date:   Tue, 22 Aug 2023 16:43:21 +0530
Message-ID: <20230822111321.56434-1-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports the below spectre variant 1 vulnerability.

drivers/tty/serial/atmel_serial.c:2675 atmel_console_setup() warn: potential spectre issue 'atmel_ports' [r] (local cap)

Fix the same by using the array_index_nospec() to mitigate this
potential vulnerability especially because the console index is
controlled by user-space.

Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3467a875641a..25f004dd9efd 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -33,6 +33,7 @@
 #include <linux/suspend.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 
 #include <asm/div64.h>
 #include <asm/ioctls.h>
@@ -2662,13 +2663,23 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
 
 static int __init atmel_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port = &atmel_ports[co->index].uart;
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct uart_port *port;
+	struct atmel_uart_port *atmel_port;
 	int baud = 115200;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
 
+	if (unlikely(co->index < 0 || co->index >= ATMEL_MAX_UART))
+		return -ENODEV;
+
+	co->index = array_index_nospec(co->index, ATMEL_MAX_UART);
+	port = &atmel_ports[co->index].uart;
+	if (!port)
+		return -ENODEV;
+
+	atmel_port = to_atmel_uart_port(port);
+
 	if (port->membase == NULL) {
 		/* Port not initialized yet - delay setup */
 		return -ENODEV;
-- 
2.34.1

