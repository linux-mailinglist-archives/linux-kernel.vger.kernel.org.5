Return-Path: <linux-kernel+bounces-5672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16524818DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E99287330
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC09374CD;
	Tue, 19 Dec 2023 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="esjkA65/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BD36B03;
	Tue, 19 Dec 2023 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Ng6Fc+vttD9IX1hHO2+obVGdw8TgMe6tqqaoAqIoRYw=; b=esjkA65/TYm961Gks1fT1j/EmM
	JdOLrbB8B7ejSclm/C798avi5fat/bu8Ui/mVa4Wgaak1uDvTYadzd3Svckg8p73n4B8Rr4zZy8dV
	KKXveG1WcRolyDwOPiaYMNvEqkpsD10KWjNcXReZVuMDfBqdxHeItTBsxH47eyVLswgE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkI-0007Ao-7m; Tue, 19 Dec 2023 12:19:06 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 19 Dec 2023 12:18:44 -0500
Message-Id: <20231219171903.3530985-1-hugo@hugovil.com>
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
Subject: [PATCH 00/18] serial: sc16is7xx: fixes, cleanups and improvements
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

Hugo Villeneuve (18):
  serial: sc16is7xx: fix segfault when removing driver
  serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of
    probe error
  serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()
  serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()
  serial: sc16is7xx: use DECLARE_BITMAP for sc16is7xx_lines bitfield
  serial: sc16is7xx: use spi_get_device_match_data()
  serial: sc16is7xx: use i2c_get_match_data()
  serial: sc16is7xx: add driver name to struct uart_driver
  serial: sc16is7xx: add macro for max number of UART ports
  serial: sc16is7xx: use HZ_PER_MHZ macro to improve readability
  serial: sc16is7xx: add explicit return for some switch default cases
  serial: sc16is7xx: replace hardcoded divisor value with BIT() macro
  serial: sc16is7xx: use in_range() for DT properties bound checks
  serial: sc16is7xx: drop unneeded MODULE_ALIAS
  serial: sc16is7xx: pass R/W buffer in FIFO functions
  serial: sc16is7xx: reorder code to remove prototype declarations
  serial: sc16is7xx: refactor EFR lock
  serial: sc16is7xx: fix whitespace in sc16is7xx_startup() comments

 drivers/tty/serial/sc16is7xx.c | 392 ++++++++++++++++-----------------
 1 file changed, 191 insertions(+), 201 deletions(-)


base-commit: 43f012df3c1e979966524f79b5371fde6545488a
-- 
2.39.2


