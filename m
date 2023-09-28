Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256A07B133D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjI1Gnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Gnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:43:42 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8FCB7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:43:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qlkkJ-0008Vd-GX; Thu, 28 Sep 2023 08:43:35 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qlkkH-009W67-HS; Thu, 28 Sep 2023 08:43:33 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qlkkH-0031Ji-10; Thu, 28 Sep 2023 08:43:33 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tim van der Staaij <Tim.vanderstaaij@zigngroup.com>
Subject: [PATCH] serial: imx: Put DMA enabled UART in separate lock subclass
Date:   Thu, 28 Sep 2023 08:43:20 +0200
Message-Id: <20230928064320.711603-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep complains about possible circular locking dependencies when the
i.MX SDMA driver issues console messages under its spinlock. While the
SDMA driver calls back into the UART when issuing a message, the i.MX
UART driver will never call back into the SDMA driver for this UART,
because DMA is explicitly not used for UARTs providing the console.

To avoid the lockdep warnings put the UART port lock for console devices
into a separate subclass.

This fixes possible deadlock warnings like the following which was
provoked by adding a printk to the i.MX SDMA driver at a place where the
driver holds its spinlock.

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc3-00045-g517852be693b-dirty #110 Not tainted
------------------------------------------------------
swapper/0/0 is trying to acquire lock:
c1818e04 (console_owner){-...}-{0:0}, at: console_flush_all+0x1c4/0x634

but task is already holding lock:
c44649e0 (&vc->lock){-...}-{3:3}, at: sdma_int_handler+0xc4/0x368

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&vc->lock){-...}-{3:3}:
       _raw_spin_lock_irqsave+0x4c/0x68
       sdma_prep_dma_cyclic+0x1a8/0x21c
       imx_uart_startup+0x44c/0x5d4
       uart_startup+0x120/0x2b0
       uart_port_activate+0x44/0x98
       tty_port_open+0x80/0xd0
       uart_open+0x18/0x20
       tty_open+0x120/0x664
       chrdev_open+0xc0/0x214
       do_dentry_open+0x1d0/0x544
       path_openat+0xbb0/0xea0
       do_filp_open+0x5c/0xd4
       do_sys_openat2+0xb8/0xf0
       sys_openat+0x8c/0xd8
       ret_fast_syscall+0x0/0x1c

-> #1 (&port_lock_key){-.-.}-{3:3}:
       _raw_spin_lock_irqsave+0x4c/0x68
       imx_uart_console_write+0x164/0x1a0
       console_flush_all+0x220/0x634
       console_unlock+0x64/0x164
       vprintk_emit+0xb0/0x390
       vprintk_default+0x24/0x2c
       _printk+0x2c/0x5c
       register_console+0x244/0x478
       serial_core_register_port+0x5c4/0x618
       imx_uart_probe+0x4e0/0x7d4
       platform_probe+0x58/0xb0
       really_probe+0xc4/0x2e0
       __driver_probe_device+0x84/0x1a0
       driver_probe_device+0x2c/0x108
       __driver_attach+0x94/0x17c
       bus_for_each_dev+0x7c/0xd0
       bus_add_driver+0xc4/0x1cc
       driver_register+0x7c/0x114
       imx_uart_init+0x20/0x40
       do_one_initcall+0x7c/0x3c4
       kernel_init_freeable+0x17c/0x228
       kernel_init+0x14/0x140
       ret_from_fork+0x14/0x24

-> #0 (console_owner){-...}-{0:0}:
       __lock_acquire+0x14b0/0x29a0
       lock_acquire.part.0+0xb4/0x264
       console_flush_all+0x20c/0x634
       console_unlock+0x64/0x164
       vprintk_emit+0xb0/0x390
       vprintk_default+0x24/0x2c
       _printk+0x2c/0x5c
       sdma_int_handler+0xcc/0x368
       __handle_irq_event_percpu+0x94/0x2d0
       handle_irq_event+0x38/0xd0
       handle_fasteoi_irq+0x98/0x248
       handle_irq_desc+0x1c/0x2c
       gic_handle_irq+0x6c/0x90
       generic_handle_arch_irq+0x2c/0x64
       __irq_svc+0x90/0xbc
       cpuidle_enter_state+0x1a0/0x4f4
       cpuidle_enter+0x30/0x40
       do_idle+0x210/0x2b4
       cpu_startup_entry+0x28/0x2c
       rest_init+0xd0/0x184
       arch_post_acpi_subsys_init+0x0/0x8

other info that might help us debug this:

Chain exists of:
  console_owner --> &port_lock_key --> &vc->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&vc->lock);
                               lock(&port_lock_key);
                               lock(&vc->lock);
  lock(console_owner);

 *** DEADLOCK ***

3 locks held by swapper/0/0:
 #0: c44649e0 (&vc->lock){-...}-{3:3}, at: sdma_int_handler+0xc4/0x368
 #1: c1818d50 (console_lock){+.+.}-{0:0}, at: vprintk_default+0x24/0x2c
 #2: c1818d08 (console_srcu){....}-{0:0}, at: console_flush_all+0x44/0x634

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc3-00045-g517852be693b-dirty #110
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x60/0x90
 dump_stack_lvl from check_noncircular+0x184/0x1b8
 check_noncircular from __lock_acquire+0x14b0/0x29a0
 __lock_acquire from lock_acquire.part.0+0xb4/0x264
 lock_acquire.part.0 from console_flush_all+0x20c/0x634
 console_flush_all from console_unlock+0x64/0x164
 console_unlock from vprintk_emit+0xb0/0x390
 vprintk_emit from vprintk_default+0x24/0x2c
 vprintk_default from _printk+0x2c/0x5c
 _printk from sdma_int_handler+0xcc/0x368
 sdma_int_handler from __handle_irq_event_percpu+0x94/0x2d0
 __handle_irq_event_percpu from handle_irq_event+0x38/0xd0
 handle_irq_event from handle_fasteoi_irq+0x98/0x248
 handle_fasteoi_irq from handle_irq_desc+0x1c/0x2c
 handle_irq_desc from gic_handle_irq+0x6c/0x90
 gic_handle_irq from generic_handle_arch_irq+0x2c/0x64
 generic_handle_arch_irq from __irq_svc+0x90/0xbc
Exception stack(0xc1801ee8 to 0xc1801f30)
1ee0:                   ffffffff ffffffff 00000001 00030349 00000000 00000012
1f00: 00000000 d7e45f4b 00000012 00000000 d7e16d63 c1810828 00000000 c1801f38
1f20: c108125c c1081260 60010013 ffffffff
 __irq_svc from cpuidle_enter_state+0x1a0/0x4f4
 cpuidle_enter_state from cpuidle_enter+0x30/0x40
 cpuidle_enter from do_idle+0x210/0x2b4
 do_idle from cpu_startup_entry+0x28/0x2c
 cpu_startup_entry from rest_init+0xd0/0x184
 rest_init from arch_post_acpi_subsys_init+0x0/0x8

Reported-by: Tim van der Staaij <Tim.vanderstaaij@zigngroup.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 13cb78340709a..83ea5b41930ab 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1457,8 +1457,10 @@ static int imx_uart_startup(struct uart_port *port)
 	imx_uart_writel(sport, ucr4 & ~UCR4_DREN, UCR4);
 
 	/* Can we enable the DMA support? */
-	if (!uart_console(port) && imx_uart_dma_init(sport) == 0)
+	if (!uart_console(port) && imx_uart_dma_init(sport) == 0) {
+		lockdep_set_subclass(&port->lock, 1);
 		dma_is_inited = 1;
+	}
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.39.2

