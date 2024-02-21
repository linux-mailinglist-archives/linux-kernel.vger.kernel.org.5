Return-Path: <linux-kernel+bounces-75303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000E85E626
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56281F21944
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8A8564A;
	Wed, 21 Feb 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hm8Ta5Av"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3671097B;
	Wed, 21 Feb 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540497; cv=none; b=bpxMIzJAnsRzdkz9w/ItRz15lybubQQvRmajyP3TmyLc7WHBkf1c5eI0fR9gqnBaNsjXgO0NZx6xjEjLBTpy0kO4eyhXmzZEF+S13A+VYuaK+sDIM12rhvb4aDt6Pgv0uKm/UKqLpLcEJHo573jErp7ZDA3HEgbPrUtcAJOxgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540497; c=relaxed/simple;
	bh=SXh9o6lcdXir6m04bi7g64vXsMqCpE0OVYelVUUwvJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7jDY3Oj9gF54nsxZiBCoaacZnhy/bBVqDZWWfa0bD1M89uDrVp81jQctZqYksyyfddRcj/y4o1xFMUwXz59atYLtd5Iu9rQynmVOwoO2g2HKhQjafGOwTa/HKIgkf0auBYZ/NcAg4BnL4JNBTtIt+d7KUq7Sm9184N/xBcYxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hm8Ta5Av; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708540496; x=1740076496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SXh9o6lcdXir6m04bi7g64vXsMqCpE0OVYelVUUwvJE=;
  b=Hm8Ta5AvbyPfws3ExSEsD4tx48RydUqtvKZ0z7Qgojt0Rk0bF7Xv869o
   6X2ALCdlnJWaBt6n4vP2i4dYlPm20sdlaJjEvkO79RfAscYjJLVxrQxca
   B868aFyJ7cklN2lo1sAxSJjuDCcj527uZ2t2u1261AVxQMWqDX0IF40jZ
   EimihVwygUSRteB6f62iUkE0H6n1YDLZodpx2UI/j/2bu7RELfSvBuq0w
   qa8s3YOdTOLaEfRwnafxEaGpbRW2FBRiRoSv3wKZzZi8MyRxPN4eIbZtc
   bKAK/Mto/BswmibRUDplkE5W6oV25UA7hCB5mQLQnJS3CJSqnSlIOvgf3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28164672"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28164672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:34:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936684737"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936684737"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 10:34:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A7CB11FD; Wed, 21 Feb 2024 20:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [rft, PATCH v1 00/14]  serial: Add a helper to parse device properties and more
Date: Wed, 21 Feb 2024 20:31:16 +0200
Message-ID: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have noticed that many drivers are using the subset of the common
properties and IRQ retrieval code. With the moving it to one place
we have got a common parser one for many.

Tested on Intel Apollo Lake with DesingWare 8250 UARTs.
The rest has been compile tested on x86_64 with clang.

Andy Shevchenko (14):
  serial: core: Move struct uart_port::quirks closer to possible values
  serial: core: Add UPIO_UNSET constant for unset port type
  serial: port: Introduce a common helper to read properties
  serial: 8250_aspeed_vuart: Switch to use uart_read_port_properties()
  serial: 8250_bcm2835aux: Switch to use uart_read_port_properties()
  serial: 8250_bcm7271: Switch to use uart_read_port_properties()
  serial: 8250_dw: Switch to use uart_read_port_properties()
  serial: 8250_ingenic: Switch to use uart_read_port_properties()
  serial: 8250_lpc18xx: Switch to use uart_read_port_properties()
  serial: 8250_of: Switch to use uart_read_port_properties()
  serial: 8250_omap: Switch to use uart_read_port_properties()
  serial: 8250_pxa: Switch to use uart_read_port_properties()
  serial: 8250_tegra: Switch to use uart_read_port_properties()
  serial: 8250_uniphier: Switch to use uart_read_port_properties()

 drivers/tty/serial/8250/8250_aspeed_vuart.c |  50 +++-----
 drivers/tty/serial/8250/8250_bcm2835aux.c   |  92 ++++++-------
 drivers/tty/serial/8250/8250_bcm7271.c      |  53 +++-----
 drivers/tty/serial/8250/8250_dw.c           |  67 ++++------
 drivers/tty/serial/8250/8250_ingenic.c      |  20 +--
 drivers/tty/serial/8250/8250_lpc18xx.c      |  20 ++-
 drivers/tty/serial/8250/8250_of.c           | 105 ++++-----------
 drivers/tty/serial/8250/8250_omap.c         |  29 ++---
 drivers/tty/serial/8250/8250_pxa.c          |  22 ++--
 drivers/tty/serial/8250/8250_tegra.c        |  26 ++--
 drivers/tty/serial/8250/8250_uniphier.c     |  17 +--
 drivers/tty/serial/serial_port.c            | 135 ++++++++++++++++++++
 include/linux/serial_core.h                 |  10 +-
 13 files changed, 313 insertions(+), 333 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


