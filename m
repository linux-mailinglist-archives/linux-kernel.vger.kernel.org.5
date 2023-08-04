Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7E76FCF2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHDJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjHDJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:12:06 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A74649DA;
        Fri,  4 Aug 2023 02:09:14 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 87CC580F7;
        Fri,  4 Aug 2023 09:09:11 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH] serial: core: Fix kmemleak issue for serial core device remove
Date:   Fri,  4 Aug 2023 12:09:07 +0300
Message-ID: <20230804090909.51529-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak reports issues for serial8250 ports after the hardware specific
driver takes over on boot as noted by Tomi.

The kerneldoc for device_initialize() says we must call device_put()
after calling device_initialize(). We are calling device_put() on the
error path, but are missing it from the device remove path. This causes
release() to never get called for the devices on remove.

Let's add the missing put_device() calls for both serial ctrl and
port devices.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -99,6 +99,7 @@ void serial_base_ctrl_device_remove(struct serial_ctrl_device *ctrl_dev)
 		return;
 
 	device_del(&ctrl_dev->dev);
+	put_device(&ctrl_dev->dev);
 }
 
 struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
@@ -174,6 +175,7 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 		return;
 
 	device_del(&port_dev->dev);
+	put_device(&port_dev->dev);
 }
 
 static int serial_base_init(void)
-- 
2.41.0
