Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F00766507
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjG1HPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjG1HPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:15:36 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7362703;
        Fri, 28 Jul 2023 00:15:30 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2A0A010000B;
        Fri, 28 Jul 2023 10:15:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2A0A010000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690528529;
        bh=tjFRdoC0YQTuiVRI/wa1w2TMkVFq1VJlUunzcx1UuUE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=QDe6rbSryTd2Txc2wFEcj9aLUGsgPTiubY//kR4VfN7TcGqUGvHVvQTAVxz7LHI3W
         Lcn4w09u6SGRW8hpkQNLtaFcGGnHsyiYU0x5FGXQcmhFURAGF8uoppMHuTQSohuEb2
         ucq96lMC8/9TlByS0NHxD3q9FV5wIfbY4YlZoTWY29Mjepa+HZlOvch+4d2G5eRUgK
         X7DDpGQ7sJ0KS+lPU1SngcnmlXgaZtAC0ioOjT9DfpiusI3uBqY7jtOjE0+Kkhq9Ru
         ysjN2a1H0yz3fJlDO4eetMusvFJph19nOA7urB7FvDwoR8x3sOxLtzM1Mv6ttXfli0
         IoEafzOxtMNsw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 28 Jul 2023 10:15:29 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 10:15:05 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <jirislaby@kernel.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>, <xianwei.zhao@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1] tty: serial: meson: refactor objects definition for different devnames
Date:   Fri, 28 Jul 2023 10:15:22 +0300
Message-ID: <20230728071522.17503-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/23 10:45:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/23 10:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macroses for name generation are not useful. They hide the real place
for object declaration. Instead, use direct names such as
'meson_uart_driver_*' and 'meson_serial_console_*' for all objects.

Additionally, rename 'MESON_SERIAL_CONSOLE_DEFINE()' to
'MESON_SERIAL_CONSOLE()', and 'MESON_UART_DRIVER_DEFINE()' to
'MESON_UART_DRIVER()' to simplify the code.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

In the patch series located at [1], the standard tty devname 'ttyS0' was
introduced for the A1 and S4 SoC families. Despite being merged into the
tty-next branch, a few TODOs flagged by Neil remained unresolved.

As a result, there is follow-up patchset to eliminate all the issues
mentioned by Neil in one of the previous patchsets [2].

Links:
    [1] https://lore.kernel.org/lkml/20230705181833.16137-1-ddrokosov@sberdevices.ru
    [2] https://lore.kernel.org/lkml/606ed182-14b8-4c8f-37d3-21971ec71f38@linaro.org

---
 drivers/tty/serial/meson_uart.c | 39 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 84cf10b0ca5c..790d910dafa5 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -76,13 +76,8 @@
 #define AML_UART_POLL_USEC		5
 #define AML_UART_TIMEOUT_USEC		10000
 
-#define MESON_UART_DRIVER(_devname) meson_uart_driver_##_devname
-
-#define MESON_UART_DRIVER_DECLARE(_devname) \
-	static struct uart_driver MESON_UART_DRIVER(_devname)
-
-MESON_UART_DRIVER_DECLARE(ttyAML);
-MESON_UART_DRIVER_DECLARE(ttyS);
+static struct uart_driver meson_uart_driver_ttyAML;
+static struct uart_driver meson_uart_driver_ttyS;
 
 static struct uart_port *meson_ports[AML_UART_PORT_NUM];
 
@@ -617,21 +612,19 @@ static int meson_serial_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-#define MESON_SERIAL_CONSOLE(_devname) meson_serial_console_##_devname
-
-#define MESON_SERIAL_CONSOLE_DEFINE(_devname)				\
-	static struct console MESON_SERIAL_CONSOLE(_devname) = {	\
+#define MESON_SERIAL_CONSOLE(_devname)					\
+	static struct console meson_serial_console_##_devname = {	\
 		.name		= __stringify(_devname),		\
 		.write		= meson_serial_console_write,		\
 		.device		= uart_console_device,			\
 		.setup		= meson_serial_console_setup,		\
 		.flags		= CON_PRINTBUFFER,			\
 		.index		= -1,					\
-		.data		= &MESON_UART_DRIVER(_devname),		\
+		.data		= &meson_uart_driver_##_devname,	\
 	}
 
-MESON_SERIAL_CONSOLE_DEFINE(ttyAML);
-MESON_SERIAL_CONSOLE_DEFINE(ttyS);
+MESON_SERIAL_CONSOLE(ttyAML);
+MESON_SERIAL_CONSOLE(ttyS);
 
 static void meson_serial_early_console_write(struct console *co,
 					     const char *s,
@@ -656,13 +649,13 @@ meson_serial_early_console_setup(struct earlycon_device *device, const char *opt
 OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		    meson_serial_early_console_setup);
 
-#define MESON_SERIAL_CONSOLE_PTR(_devname) (&MESON_SERIAL_CONSOLE(_devname))
+#define MESON_SERIAL_CONSOLE_PTR(_devname) (&meson_serial_console_##_devname)
 #else
-#define MESON_SERIAL_CONSOLE_PTR(_devname)	(NULL)
+#define MESON_SERIAL_CONSOLE_PTR(_devname) (NULL)
 #endif
 
-#define MESON_UART_DRIVER_DEFINE(_devname)  \
-	static struct uart_driver MESON_UART_DRIVER(_devname) = {	\
+#define MESON_UART_DRIVER(_devname)					\
+	static struct uart_driver meson_uart_driver_##_devname = {	\
 		.owner		= THIS_MODULE,				\
 		.driver_name	= "meson_uart",				\
 		.dev_name	= __stringify(_devname),		\
@@ -670,8 +663,8 @@ OF_EARLYCON_DECLARE(meson, "amlogic,meson-ao-uart",
 		.cons		= MESON_SERIAL_CONSOLE_PTR(_devname),	\
 	}
 
-MESON_UART_DRIVER_DEFINE(ttyAML);
-MESON_UART_DRIVER_DEFINE(ttyS);
+MESON_UART_DRIVER(ttyAML);
+MESON_UART_DRIVER(ttyS);
 
 static int meson_uart_probe_clocks(struct platform_device *pdev,
 				   struct uart_port *port)
@@ -700,7 +693,7 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
 static struct uart_driver *meson_uart_current(const struct meson_uart_data *pd)
 {
 	return (pd && pd->uart_driver) ?
-		pd->uart_driver : &MESON_UART_DRIVER(ttyAML);
+		pd->uart_driver : &meson_uart_driver_ttyAML;
 }
 
 static int meson_uart_probe(struct platform_device *pdev)
@@ -819,12 +812,12 @@ static struct meson_uart_data meson_g12a_uart_data = {
 };
 
 static struct meson_uart_data meson_a1_uart_data = {
-	.uart_driver = &MESON_UART_DRIVER(ttyS),
+	.uart_driver = &meson_uart_driver_ttyS,
 	.has_xtal_div2 = false,
 };
 
 static struct meson_uart_data meson_s4_uart_data = {
-	.uart_driver = &MESON_UART_DRIVER(ttyS),
+	.uart_driver = &meson_uart_driver_ttyS,
 	.has_xtal_div2 = true,
 };
 
-- 
2.36.0

