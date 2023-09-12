Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71C79CF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjILLEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjILLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:04:22 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 027C810DE;
        Tue, 12 Sep 2023 04:04:09 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 5F15F80FC;
        Tue, 12 Sep 2023 11:04:07 +0000 (UTC)
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
Subject: [PATCH v2 0/3] Add support for DEVNAME:0.0 style hardware based addressing
Date:   Tue, 12 Sep 2023 14:03:42 +0300
Message-ID: <20230912110350.14482-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

With the recent serial core changes in v6.5, we can now add DEVNAME:0.0
style addressing for the serial ports. When using DEVNAME:0.0 naming, we
don't need to care which ttyS instance number is allocated depending on
HSUART settings or if the devicetree has added aliases for all the ports.

With these changes the port mapping is visible for usespace in sysfs with:

$ grep DEVNAME /sys/bus/serial-base/devices/*/tty/uevent

Regards,

Tony

Changes since v1:

- Constify printk add_preferred_console() as suggested by Jiri

- Use proper kernel command line helpers for parsing console as
  suggested by Jiri

- Update description for HSUART based on Andy's comments

- Standardize on DEVNAME:0.0 style naming as suggested by Andy

- Added missing put_device() calls paired with device_find_child()

Tony Lindgren (3):
  printk: Constify name for add_preferred_console()
  serial: core: Add support for DEVNAME:0.0 style naming for kernel
    console
  serial: core: Add sysfs links for serial core port instances for ttys

 drivers/tty/serial/Makefile          |   3 +
 drivers/tty/serial/serial_base.h     |  11 +++
 drivers/tty/serial/serial_base_con.c | 133 +++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |  26 ++++++
 include/linux/console.h              |   2 +-
 kernel/printk/printk.c               |   4 +-
 6 files changed, 176 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tty/serial/serial_base_con.c


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.42.0
