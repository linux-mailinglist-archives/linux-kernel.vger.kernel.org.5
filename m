Return-Path: <linux-kernel+bounces-120706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB688DBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31EC1C26816
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4C52F6E;
	Wed, 27 Mar 2024 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="cG94nuem"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B711184;
	Wed, 27 Mar 2024 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537277; cv=none; b=QqMwzXqLTrKiaxEb6Ji0/5b6GAEBlvOmjWV3tql6lJpGMMKepP7bYlKovRJ8iQFoOA8/TYrAoAfqBkvPcgWID5oYDOGHca9UdlPPb5YEtuhu2Vc/fDk3J51mzz8cMRf3wyUZoMiQfszBcmUri5GQnVEEff+4Me/0Xx5/qJfkAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537277; c=relaxed/simple;
	bh=40lkwxzBEwM7Py74gTq3bfjY6w9uPEe3SKWLtzCYjg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBbq5KUj/Ue1BINFbYLqHfbRTQQpHqXZzyzhT6E1u7Ui4F0ULkAq2iVAP6sdOFj9JgMgRktBJ6XrYm46gyhdS+ZFOJHcFT6SC/7jM3Q234Qc8oUj/W6+E2RKZSOBexr57RC+pO+7A2UlMNboBxd5mN1yFZ5QoesbA0iDhqfputQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=cG94nuem; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 3E5F160868;
	Wed, 27 Mar 2024 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711537272;
	bh=40lkwxzBEwM7Py74gTq3bfjY6w9uPEe3SKWLtzCYjg8=;
	h=From:To:Cc:Subject:Date:From;
	b=cG94nuemFEapD1f6abUjghjK2JnyFWC0Zz1MGJwQxxtbWa2V2Un66nRvlyfH5PssS
	 Y+RW87TWdS09NqiZ/elUguxv5gB2fLRqzup0qAY986DNEnfq8nVU3CdAk2nZX2LRVe
	 0nAEhDXL257wcqCL1BAxCML19DVVE2Vfih9qgD9guCmm1PHf66yVb12gZ+ZCCiQMQ2
	 endxO8OkFGtFlXQBkoRXjg9T6Mp0pkHLjHkoDIJ18AsnRDiksP8EOEopmNHg2TdHeY
	 AK32dx/oC90ZiMENefROP0EZNsMQyTwjJ2qfxhb5Z2VuEgr62NfigV6VMUpp++uLUd
	 3zjXgRT8j6i+Q==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
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
	linux-serial@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 0/7] Add support for DEVNAME:0.0 style hardware based addressing
Date: Wed, 27 Mar 2024 12:59:34 +0200
Message-ID: <20240327110021.59793-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
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

Regards,

Tony

Changes since v6:
- Simplify console_opt_save() and add Co-developed-by for Andy

- Add patch to document new console option as suggested by Sebastian

- Init __free() as noted by Andy and the kernel test robot

- Use strstarts() for the boolean test and drop redundant assignment
  as noted by Andy

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

Tony Lindgren (7):
  printk: Save console options for add_preferred_console_match()
  printk: Don't try to parse DEVNAME:0.0 console options
  printk: Flag register_console() if console is set on command line
  serial: core: Add support for DEVNAME:0.0 style naming for kernel
    console
  serial: core: Handle serial console options
  serial: 8250: Add preferred console in serial8250_isa_init_ports()
  Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial
    ports

 .../admin-guide/kernel-parameters.txt         |  19 +++
 drivers/tty/serial/8250/8250_core.c           |   5 +
 drivers/tty/serial/serial_base.h              |  24 +++
 drivers/tty/serial/serial_base_bus.c          | 136 ++++++++++++++++
 drivers/tty/serial/serial_core.c              |   4 +
 include/linux/printk.h                        |   3 +
 kernel/printk/Makefile                        |   2 +-
 kernel/printk/conopt.c                        | 146 ++++++++++++++++++
 kernel/printk/console_cmdline.h               |   6 +
 kernel/printk/printk.c                        |  23 ++-
 10 files changed, 363 insertions(+), 5 deletions(-)
 create mode 100644 kernel/printk/conopt.c

-- 
2.44.0

