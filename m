Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CBB7F2BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjKULct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:32:47 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 761C19C;
        Tue, 21 Nov 2023 03:32:43 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id F3A6C80CC;
        Tue, 21 Nov 2023 11:32:39 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 0/3] Add support for DEVNAME:0.0 style hardware based addressing
Date:   Tue, 21 Nov 2023 13:31:54 +0200
Message-ID: <20231121113203.61341-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

With the recent serial core changes, we can now add DEVNAME:0.0 style
addressing for the serial ports. When using DEVNAME:0.0 naming, we don't
need to care which ttyS instance number is allocated depending on HSUART
settings or if the devicetree has added aliases for all the ports.

This also allows us to also drop the old console_setup() parsing for
character device names.

Regards,

Tony

Changes since v2:

- Console name got constified and already applied as suggested by Ilpo
  and Andy

- Add printk/conopt.c to save console command line options

- Add a patch to drop old console_setup() character device name parsing

- Use cleanup.h to simplify freeing as suggested by Andy

- Use types.h instead of kernel.h as suggested by Andy

- Use strcspn() as suggested by Andy

- Various coding improvments suggested by Andy

Changes since v1:

- Constify printk add_preferred_console() as suggested by Jiri

- Use proper kernel command line helpers for parsing console as
  suggested by Jiri

- Update description for HSUART based on Andy's comments

- Standardize on DEVNAME:0.0 style naming as suggested by Andy

- Added missing put_device() calls paired with device_find_child()

Tony Lindgren (3):
  printk: Save console options for add_preferred_console_match()
  serial: core: Add support for DEVNAME:0.0 style naming for kernel
    console
  serial: core: Move console character device handling from printk

 drivers/tty/serial/serial_base.h     |  14 ++++
 drivers/tty/serial/serial_base_bus.c | 104 ++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |   4 +
 include/linux/printk.h               |   3 +
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 115 +++++++++++++++++++++++++++
 kernel/printk/console_cmdline.h      |   4 +
 kernel/printk/printk.c               |  41 +++-------
 8 files changed, 254 insertions(+), 33 deletions(-)
 create mode 100644 kernel/printk/conopt.c

-- 
2.42.1
