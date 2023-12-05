Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6B804B32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjLEHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjLEHdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:33:41 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747A2CB;
        Mon,  4 Dec 2023 23:33:47 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 180E860354;
        Tue,  5 Dec 2023 07:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701761626;
        bh=7h5wlzQdpRnMNvGKsqPPaRZvd85tYn+u1pMnFtiPN10=;
        h=From:To:Cc:Subject:Date:From;
        b=mfq7qOTQojPAcWlc+l43nDG3ElnzK+UoO/XbCuDC8Lsfc0CvFKnZjXGhhtf6W3nmQ
         1DkHSRTW9WM+dZ5Ccn1a0+W/dVz6iKgy0zcCag6WAygvE6/LaOkSYKh+SOWubbNmmp
         ihes/iJyRU+7+gc4RnL6KWPyLu6PjGkt9cNhvcLY+k3yrbVD0VN0ZIo5AwA/gCbo5U
         fPbzECjGWgolo38YGoPzcUh1Nkn0j/1jS7IfOgGjo8M31+Cn+p+yqpJxMTaymXhdGJ
         g7CsRZmJv6PUEDEygd0nDG1dMh15RvZ59OO/D0Hw/UAtF0EUI0k/hhjY7ABvhbBU4H
         0TYeBUQY0GC4w==
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v4 0/4] Add support for DEVNAME:0.0 style hardware based addressing
Date:   Tue,  5 Dec 2023 09:32:32 +0200
Message-ID: <20231205073255.20562-1-tony@atomide.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
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

We also prepare the serial core to handle the ttyS related quirks done
in console_setup() to prepare things for eventually dropping the parsing
from console_setup(). This can only happen after further changes to
register_console().

Regards,

Tony

Changes since v3:
- Fix handling of brl_options by saving them too in console_opt_save()

- Drop changes to remove console_setup() parsing, further changes to
  register_console() are still needed before can leave out the early
  parsing

- Added a patch for serial8250_isa_init_preferred_console(), otherwise
  the console gets initialized later for x86 when the console_setup()
  parsing is dropped as pointed out by Petr

- Initialize __free() variables to NULL as noted by Dan

- Return handled in console_setup() if saving console options fails

- Simplify serial_base_add_preferred_console() and add a helper for
  serial_base_add_one_prefcon() as suggested by Andy

- Header include changes to kernel/printk/conopt.c as suggested by Andy

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

Tony Lindgren (4):
  printk: Save console options for add_preferred_console_match()
  serial: core: Add support for DEVNAME:0.0 style naming for kernel
    console
  serial: core: Handle serial console options
  serial: 8250: Add preferred console in serial8250_isa_init_ports()

 drivers/tty/serial/8250/8250_core.c  |  32 +++++++
 drivers/tty/serial/serial_base.h     |  14 +++
 drivers/tty/serial/serial_base_bus.c | 115 ++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |   4 +
 include/linux/printk.h               |   3 +
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 128 +++++++++++++++++++++++++++
 kernel/printk/console_cmdline.h      |   6 ++
 kernel/printk/printk.c               |  14 ++-
 9 files changed, 314 insertions(+), 4 deletions(-)
 create mode 100644 kernel/printk/conopt.c

-- 
2.43.0
