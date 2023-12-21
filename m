Return-Path: <linux-kernel+bounces-9157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E3881C1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE1D1F233B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2FB79485;
	Thu, 21 Dec 2023 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GBb1eiuB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B864F78E9B;
	Thu, 21 Dec 2023 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=A3JAYH++UPopmKfr9YU5rDrgJ9jbknex8l6qeuhRBCw=; b=GBb1eiuB8wx1VRFGn1/vm+Itdz
	Nt6/GXzoZ518e4gHtXDuK1v1/xgaFAn6k8TwdIO6ZUQwzoDy9v25d4kJlT0yGrGtPuSg8ndT2Ys0G
	OpRMhencbdjRXmRJRVyC9ps9w+bzCh/92gQDhGi6md8k9FLhH4dRL2dldSwBV+a05j68=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJE-00025W-BA; Thu, 21 Dec 2023 18:18:32 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kubakici@wp.pl,
	indrakanti_ram@hotmail.com,
	phil@raspberrypi.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:07 -0500
Message-Id: <20231221231823.2327894-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 00/16] serial: sc16is7xx: fixes, cleanups and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings a few fixes, clean-ups and improvements to the
sc16is7xx driver.

Some of the patches have been suggested by Andy Shevchenko following this
dicussion:

Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com/

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

I did not test the change on a SC16is7xx using I2C interface, as my custom
board is only using SPI.

Thank you.

Link: [v1] https://lore.kernel.org/all/20231219171903.3530985-1-hugo@hugovil.com/

Changes for V2:
- Invert statements in "improve do/while loop in sc16is7xx_irq()".
- Drop patch "use in_range() for DT properties bound checks" at Andy's
  suggestion.
- Drop patch "fix whitespace in sc16is7xx_startup() comments".
- Drop patch "fix segfault when removing driver".
- Fix some commit descriptions after reviews.
- Remove casting in spi_get_device_match_data() and i2c_get_match_data(),
  and use dev_err_probe().
- Fix indentation and comments style.
- Add patch to fix SPI default frequency if unspecified and merge it with
  patch "use HZ_PER_MHZ macro to improve readability".
- Add patch to detect wrong SPI mode.
- Optimize struct sc16is7xx_one based on Andy's comment and running pahole.
- Use git diff histogram algo when generating patches.
- Revert to ARRAY_SIZE() macro in "add macro for max number of UART ports"
  and remove WARN_ON().

Hugo Villeneuve (16):
  serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of
    probe error
  serial: sc16is7xx: add check for unsupported SPI modes during probe
  serial: sc16is7xx: set safe default SPI clock frequency
  serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()
  serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()
  serial: sc16is7xx: use DECLARE_BITMAP for sc16is7xx_lines bitfield
  serial: sc16is7xx: use spi_get_device_match_data()
  serial: sc16is7xx: use i2c_get_match_data()
  serial: sc16is7xx: add driver name to struct uart_driver
  serial: sc16is7xx: add macro for max number of UART ports
  serial: sc16is7xx: add explicit return for some switch default cases
  serial: sc16is7xx: replace hardcoded divisor value with BIT() macro
  serial: sc16is7xx: drop unneeded MODULE_ALIAS
  serial: sc16is7xx: refactor FIFO access functions to increase
    commonality
  serial: sc16is7xx: reorder code to remove prototype declarations
  serial: sc16is7xx: refactor EFR lock

 drivers/tty/serial/sc16is7xx.c | 386 ++++++++++++++++-----------------
 1 file changed, 184 insertions(+), 202 deletions(-)


base-commit: 43f012df3c1e979966524f79b5371fde6545488a
-- 
2.39.2


