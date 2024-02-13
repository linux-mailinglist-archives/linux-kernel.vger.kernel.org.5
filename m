Return-Path: <linux-kernel+bounces-63141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754C852B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8631C22688
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1422097;
	Tue, 13 Feb 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="rsbHN13g"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3352137E;
	Tue, 13 Feb 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813989; cv=none; b=TwF7wnMTU8xPYM4+VuaQljp2UMbW172ohfvZIEKZgMMhEmCcODR/D4rxv6giQvinxm78ltSdIteg3lJz+VK7zDm5h6bW4XhPscniygCVKUTgITl/xTczaW+g5+X//ysNNvKp5nRzOgAtqQV/XDpin0j3yM6igvz/fJTOsLYTYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813989; c=relaxed/simple;
	bh=I8Dk1CjqScKBtQApLfXJ53Ss9d0W5sdwa22iNPoG3vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcvKE8BnhIAKfKNWemNqyKZtRFyAOODcGfC2c9J5vto7erP6LFC5H+YKHJa19ueN5CO2l1OHuWBdPvZGkes5Gi0xVl7FyjSasN3OMNLEnsBlKAMITf7HNbxBKAfdVtZ0OFVjEJ7Wcjj1iOGblLr5GCO2jfbq4Gdp6/ePh/NbjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=rsbHN13g; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id F19C660505;
	Tue, 13 Feb 2024 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707813986;
	bh=I8Dk1CjqScKBtQApLfXJ53Ss9d0W5sdwa22iNPoG3vY=;
	h=From:To:Cc:Subject:Date:From;
	b=rsbHN13gdMiK4m9PKkNyMA1M8Q5mkR0/0IQLimo4d40yCOjKmDidzP7oq1srnvx4e
	 XJQQZRaDQqmIJFECD56kppnBRsANTSkCOAfdVgfCvGG3X598eCNbl8XWrIrNyG8xxB
	 p5fgc5JFCo0HCqh0N6Axky9kOHyOSnV8wjhY/8egBRP7LMxZMCpcOtvc3pQjI+0V0e
	 oqAlNLqGaBea57x3shI1Y2TYYgnU7dExn6lKDbNJ+gcg4QYmzi2GhF2KhQQSc00xlA
	 fPNR4g3/jBpXYsDiPPm7noT1MpoyPTn3t3/FKG+KxU7TPk7M34wT1XBrJlMy/rVE8Z
	 O8cUomo+8Km2g==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 0/6] Add support for DEVNAME:0.0 style hardware based addressing
Date: Tue, 13 Feb 2024 10:45:07 +0200
Message-ID: <20240213084545.40617-1-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

With the recent serial core changes, we can now add DEVNAME:0.0 style
addressing for the serial ports. When using DEVNAME:0.0 naming, we don't
need to care which ttyS instance number is allocated depending on HSUART
settings or if the devicetree has added aliases for all the ports.

We also prepare the serial core to handle the ttyS related quirks done
in console_setup() to prepare things for eventually dropping the parsing
from console_setup().

These patches are against tty-next, but apply with fuzz also against Linux
next with the recent printk changes.

Regards,

Tony

Changes since v5:
- Include types.h as noted by Andy

- Update patch description to use serial_base_add_one_prefcon() as noded
  by Andy

Changes since v4:
- Fix passing empty brl_opt to add_preferred_console() instead of NULL

- Fix console_setup() trying to parse a console index out of a DEVNAME:0.0
  option that can be an IO address instead of an index

- Fix issue with default console getting enabled before DEVNAME:0.0
  handling device driver calls add_preferred_console()

- Fix error check for kasprintf(), use serial_base_add_one_prefcon() and
  coding suggestions by Andy

- Fixed compile errors if console is not enabled in .config as noted
  by kernel test robot

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

Tony Lindgren (6):
  printk: Save console options for add_preferred_console_match()
  printk: Don't try to parse DEVNAME:0.0 console options
  printk: Flag register_console() if console is set on command line
  serial: core: Add support for DEVNAME:0.0 style naming for kernel
    console
  serial: core: Handle serial console options
  serial: 8250: Add preferred console in serial8250_isa_init_ports()

 drivers/tty/serial/8250/8250_core.c  |   5 +
 drivers/tty/serial/serial_base.h     |  24 +++++
 drivers/tty/serial/serial_base_bus.c | 136 +++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |   4 +
 include/linux/printk.h               |   3 +
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 143 +++++++++++++++++++++++++++
 kernel/printk/console_cmdline.h      |   6 ++
 kernel/printk/printk.c               |  23 ++++-
 9 files changed, 341 insertions(+), 5 deletions(-)
 create mode 100644 kernel/printk/conopt.c


base-commit: 6cc3028f797a549f256d593867a769ab6a8265f2
-- 
2.43.1

