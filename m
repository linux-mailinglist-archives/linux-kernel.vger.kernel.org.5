Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8672D770149
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHDNT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHDNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:19:11 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1F6A659E;
        Fri,  4 Aug 2023 06:16:34 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7166980F7;
        Fri,  4 Aug 2023 13:15:55 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: Fix oops for port->pm on uart_change_pm()
Date:   Fri,  4 Aug 2023 16:15:51 +0300
Message-ID: <20230804131553.52927-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unloading a hardware specific 8250 driver can produce error "Unable to
handle kernel paging request at virtual address" about ten seconds after
unloading the driver. This happens on uart_hangup() calling
uart_change_pm().

Turns out commit 04e82793f068 ("serial: 8250: Reinit port->pm on port
specific driver unbind") was only a partial fix. If the hardware specific
driver has initialized port->pm function, we need to clear port->pm too.
Just reinitializing port->ops does not do this. Otherwise serial8250_pm()
will call port->pm() instead of serial8250_do_pm().

Fixes: 04e82793f068 ("serial: 8250: Reinit port->pm on port specific driver unbind")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3278,6 +3278,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 
 	spin_lock_init(&port->lock);
 	port->ctrl_id = 0;
+	port->pm = NULL;
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-- 
2.41.0
