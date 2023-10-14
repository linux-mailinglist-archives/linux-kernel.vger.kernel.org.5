Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38197C945F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjJNLji convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Oct 2023 07:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJNLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 07:39:37 -0400
Received: from postfix2.imaqliq.com (postfix2.imaqliq.com [93.189.151.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D4C9;
        Sat, 14 Oct 2023 04:39:35 -0700 (PDT)
Received: from verse.imaqliq.com (unknown [93.189.151.95])
        by postfix2.imaqliq.com (Postfix) with ESMTP id 8C4041C294E;
        Sat, 14 Oct 2023 14:39:32 +0300 (MSK)
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
Subject: [PATCH v6] tty: serial: meson: fix hard LOCKUP on crtscts mode
From:   Pavel Krasavin <pkrasavin@imaqliq.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Sat, 14 Oct 2023 11:39:26 +0000
Message-ID: <OF66360032.51C36182-ON00258A48.003F656B-00258A48.0040092C@gdc.ru>
X-Mailer: Lotus Domino Web Server Release 12.0.2 November 03, 2022
X-MIMETrack: Serialize by http on verse/com(Release 12.0.2|November 03, 2022) at 10/14/2023
 11:39:26,
        Serialize complete at 10/14/2023 11:39:26,
        Serialize by Router on verse/com(Release 12.0.2|November 03, 2022) at 10/14/2023
 11:39:31
X-KeepSent: 66360032:51C36182-00258A48:003F656B;
 type=4; name=$KeepSent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 180616 [Oct 13 2023]
X-KLMS-AntiSpam-Version: 6.0.0.2
X-KLMS-AntiSpam-Envelope-From: pkrasavin@imaqliq.com
X-KLMS-AntiSpam-Rate: 10
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dmarc=fail header.from=imaqliq.com policy=none;spf=softfail smtp.mailfrom=imaqliq.com;dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 539 539 807534d9021bfe9ca369c363d15ac993cd93d4d9, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, imaqliq.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;93.189.151.95:7.1.2;gdc.ru:7.1.1;verse.imaqliq.com:7.1.1, FromAlignment: s, {Tracking_dmark_f}, ApMailHostAddress: 93.189.151.95
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/10/14 10:01:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/14 08:14:00 #22187517
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Krasavin <pkrasavin@imaqliq.com>

There might be hard lockup if we set crtscts mode on port without RTS/CTS configured:

# stty -F /dev/ttyAML6 crtscts; echo 1 > /dev/ttyAML6; echo 2 > /dev/ttyAML6
[   95.890386] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   95.890857] rcu:     3-...0: (201 ticks this GP) idle=e33c/1/0x4000000000000000 softirq=5844/5846 fqs=4984
[   95.900212] rcu:     (detected by 2, t=21016 jiffies, g=7753, q=296 ncpus=4)
[   95.906972] Task dump for CPU 3:
[   95.910178] task:bash            state:R  running task     stack:0     pid:205   ppid:1      flags:0x00000202
[   95.920059] Call trace:
[   95.922485]  __switch_to+0xe4/0x168
[   95.925951]  0xffffff8003477508
[   95.974379] watchdog: Watchdog detected hard LOCKUP on cpu 3
[   95.974424] Modules linked in: 88x2cs(O) rtc_meson_vrtc

Possible solution would be to not allow to setup crtscts on such port.

Tested on S905X3 based board.

Fixes: ff7693d079e5 ("ARM: meson: serial: add MesonX SoC on-chip uart driver")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Krasavin <pkrasavin@imaqliq.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
v6: stable tag added
v5: https://lore.kernel.org/lkml/OF43DA36FF.2BD3BB21-ON00258A47.005A8125-00258A47.005A9513@gdc.ru/
added missed Reviewed-by tags, Fixes tag added according to Dmitry and Neil notes
v4: https://lore.kernel.org/lkml/OF55521400.7512350F-ON00258A47.003F7254-00258A47.0040E15C@gdc.ru/
More correct patch subject according to Jiri's note
v3: https://lore.kernel.org/lkml/OF6CF5FFA0.CCFD0E8E-ON00258A46.00549EDF-00258A46.0054BB62@gdc.ru/
"From:" line added to the mail
v2: https://lore.kernel.org/lkml/OF950BEF72.7F425944-ON00258A46.00488A76-00258A46.00497D44@gdc.ru/
braces for single statement removed according to Dmitry's note
v1: https://lore.kernel.org/lkml/OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru/
---

--- a/drivers/tty/serial/meson_uart.c	2023-10-12 15:44:02.410538523 +0300
+++ b/drivers/tty/serial/meson_uart.c	2023-10-12 15:58:06.242395253 +0300
@@ -380,10 +380,14 @@ static void meson_uart_set_termios(struc
 	else
 		val |= AML_UART_STOP_BIT_1SB;
 
-	if (cflags & CRTSCTS)
-		val &= ~AML_UART_TWO_WIRE_EN;
-	else
+	if (cflags & CRTSCTS) {
+		if (port->flags & UPF_HARD_FLOW)
+			val &= ~AML_UART_TWO_WIRE_EN;
+		else
+			termios->c_cflag &= ~CRTSCTS;
+	} else {
 		val |= AML_UART_TWO_WIRE_EN;
+	}
 
 	writel(val, port->membase + AML_UART_CONTROL);
 
@@ -705,6 +709,7 @@ static int meson_uart_probe(struct platf
 	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int irq;
+	bool has_rtscts;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -732,6 +737,7 @@ static int meson_uart_probe(struct platf
 		return irq;
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
 
 	if (meson_ports[pdev->id]) {
 		return dev_err_probe(&pdev->dev, -EBUSY,
@@ -762,6 +768,8 @@ static int meson_uart_probe(struct platf
 	port->mapsize = resource_size(res_mem);
 	port->irq = irq;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
+	if (has_rtscts)
+		port->flags |= UPF_HARD_FLOW;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
 	port->dev = &pdev->dev;
 	port->line = pdev->id;
