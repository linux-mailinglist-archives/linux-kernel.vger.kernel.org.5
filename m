Return-Path: <linux-kernel+bounces-159018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B38B2832
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9DD282D25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29B3A1BB;
	Thu, 25 Apr 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="XqrmH6aV"
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7939863;
	Thu, 25 Apr 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070051; cv=none; b=liWDbZoeC/vhRm6sGQzw+SSHj8kOicQJII5P+652BEFvMnJ+wPDHQWF5CWFGVeEgHvsEwi2LKG2q/eJsO8Q3mHIENsP9tUqSLGd3QLVw040rxS/OSjPwmVFYQk1G8gHT7aIOxIx7Wu8WIwZ42Zl7WFeizhxEcGAc9GUlrxj7Jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070051; c=relaxed/simple;
	bh=wN4A4unNnlOZj+21I34KhefPgU9JSHhJRE+bPr0j7WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXRjygmHJtwkGnje7Z/Z66ez1vG+45wqi7Gbkl8inL2ul8b/ma1FQo5bNCsR3RkpZojQ9p3ehiFhmgba5gDHVsy/VS0nQ8dgVNY328YjD9eiYdYFPkpACYMbdoHHZFbjn1IjzuB06sunpQGv2AUvtTQLEOp3amUDMbzqyixswBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=XqrmH6aV; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5408:0:640:72fa:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id DBAFE60B59;
	Thu, 25 Apr 2024 21:33:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sXRDEK0m5mI0-jm83D1zP;
	Thu, 25 Apr 2024 21:33:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1714070037; bh=pt7zXw+VM0FjK7sS/SShMwgvNUfzk6AwbcgerfZYJd4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XqrmH6aVeQjwhId2DnW5q0w0p/2zFpqNodeK04ukC+gVUDhFkyhDrravQAWUxUx59
	 Z0KOCXoJCts5VxQLgFU9dX3iw6m2a47/9aoz/+qWO0zscdc9awA3wnF/wBGXztYvpy
	 H9lkvgL4Bf2FHZ8ey5u6Qk06+coHLfx80/k7esQQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <rilian.la.te@ya.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Konstantin Pugin <ria.freelander@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 0/3] add support for EXAR XR20M1172 UART
Date: Thu, 25 Apr 2024 21:32:32 +0300
Message-ID: <20240425183251.174412-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
it has additional register which can change UART multiplier
to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
flag to guard access to its specific DLD register. It seems than
other EXAR SPI UART modules also have this register, but I tested
only XR20M1172.
Yes, in datasheet this register is called "DLD - Divisor Fractional"
or "DLD - Divisor Fractional Register", calling depends on datasheet
version.

I am sorry about too many submissions and top post reply. About second -
I do not know how to reply properly to this ML from GMail phone app. About first - I just
get very good feedback from Andy Shevchenko, and want to fix his review picks ASAP.

Hugo, I am sorry, I fixes a bug, but forgot to amend a fix(

Log from v9 compilation:
```
  CC [M]  drivers/tty/serial/omap-serial.o
  CC [M]  drivers/tty/serial/owl-uart.o
  CC [M]  drivers/tty/serial/pch_uart.o
  CC [M]  drivers/tty/serial/qcom_geni_serial.o
  CC [M]  drivers/tty/serial/ucc_uart.o
  CC [M]  drivers/tty/serial/rp2.o
  CC [M]  drivers/tty/serial/samsung_tty.o
  CC [M]  drivers/tty/serial/sccnxp.o
  CC [M]  drivers/tty/serial/sc16is7xx.o
  CC [M]  drivers/tty/serial/sc16is7xx_spi.o
  CC [M]  drivers/tty/serial/sc16is7xx_i2c.o
  CC [M]  drivers/tty/serial/sh-sci.o
  CC [M]  drivers/tty/serial/sifive.o
  CC [M]  drivers/tty/serial/sprd_serial.o
  CC [M]  drivers/tty/serial/st-asc.o
  CC [M]  drivers/tty/serial/stm32-usart.o
```

Changes in v2:
  - use full name in git authorship

Changes in v3:
  - change formatting of commit messages to unify width
  - rework commit messages according to code review
  - add XR20M117X namespace for EXAR-specific register
  - do not use UPF_MAGIC_MULTIPLIER for checking EXAR chip,
    use s->devtype directly
  - replace while loop to fls function and expanded check
  - sort compatibles
  - reformat multiline comment.

Changes in v4:
  - rebase onto tty-next branch
  - added Kconfig mention of the chip
  - used rounddown_power_of_two instead of fls and manual shift
  - used FIELD_PREP instead of custom macro
  - removed has_dld bit from common struct, replaced by check function,
    which checks directly by s->devtype
  - fixed tab count
  - properly apply Vladimir Zapolskiy's tag to patch 2 only

Changes in v5:
  - fixes for tty-next branch
  - address a new code review picks
  - send properly to all participants
  - added Ack tag

Changes in v6:
  - KConfig fixes
  - New code review fixes

Changes in v7:
  - Added missed tag
  - Added missed v5 fixes

Changes in v8:
  - Fixed semicolon
  - Added missed tags
  - Fixed commit messages

Changes in v9:
  - Really fixed compilation (checked by git reset --hard && make allmodconfig && make)
  - Implemented Hugo and Andy's messages

Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/Kconfig                    |  3 +-
 drivers/tty/serial/sc16is7xx.c                | 63 +++++++++++++++++--
 drivers/tty/serial/sc16is7xx.h                |  1 +
 drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
 drivers/tty/serial/sc16is7xx_spi.c            |  1 +
 6 files changed, 64 insertions(+), 6 deletions(-)


base-commit: 660a708098569a66a47d0abdad998e29e1259de6
-- 
2.44.0


