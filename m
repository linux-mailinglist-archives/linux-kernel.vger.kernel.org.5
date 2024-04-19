Return-Path: <linux-kernel+bounces-151428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D38AAEC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592A91F221C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DE85640;
	Fri, 19 Apr 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="G4QmKmJk"
Received: from forward400c.mail.yandex.net (forward400c.mail.yandex.net [178.154.239.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DA1EB45;
	Fri, 19 Apr 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530721; cv=none; b=FhLUwBFWrxmpxMqhFvIiJvCk7tzqtdy34NznbQ2xcBD8Yp5hZ5vB2sL9VgXh6AbuwRdz84q7LDILya2fAL0ycXTmEV287uqq1aUNEbmERC6gjJ7FUNckJRRxtk1zbxuxOkjGyZoCDb2IUTtzuKql2Hl0HWGHkB0veiW/X5++MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530721; c=relaxed/simple;
	bh=wiiljzM3Wd7+xoKqn4leYGdo5FYLPwLPz9bmGP81zwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iv/jGnt59GbOu9hLcsWe2nq0eyvc/ucSncTTZLwZmJS7tfAGh2GD7yo1VNehllhhgvVbg/htR5MuAnjzg6s9Uf6R/mlB/9mCTi48rf5ZhnqnfKrEMYI7n+a4wfOBazNmjhpRr0YWQ5O9fOq7YFrFb6IRj2K3azVEwCRZlGLk/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=G4QmKmJk; arc=none smtp.client-ip=178.154.239.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5003:0:640:89b0:0])
	by forward400c.mail.yandex.net (Yandex) with ESMTPS id 3F32561AA2;
	Fri, 19 Apr 2024 15:45:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8jF8ngSo6uQ0-woL8W9gD;
	Fri, 19 Apr 2024 15:45:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713530709; bh=HdR5eexhqsNhoqRza+JNIaSslNR9+wly6BUlhN5SYXU=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=G4QmKmJkyFax62sdQxVbrDcl1PZI4gzl/Q+r8AsbJdXawVxd2ObBGGC8F1L/WM/NL
	 frB7UhFQetolbJoEXwK5UYuwvwDchAxYXlx+yN86LfmQk68/aK9YOuTgOYbdW+qrqQ
	 /r8tao6/YqvdPaEPD88Aa+MbXu5OtqzWFkW1H7Ro=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 0/3] add support for EXAR XR20M1172 UART
Date: Fri, 19 Apr 2024 15:45:00 +0300
Message-Id: <20240419124506.1531035-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

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

Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/Kconfig                    | 18 +++---
 drivers/tty/serial/sc16is7xx.c                | 62 +++++++++++++++++--
 drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
 drivers/tty/serial/sc16is7xx_spi.c            |  1 +
 5 files changed, 70 insertions(+), 13 deletions(-)


base-commit: c6795fbffc4547b40933ec368200bd4926a41b44
-- 
2.34.1


