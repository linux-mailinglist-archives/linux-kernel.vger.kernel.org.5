Return-Path: <linux-kernel+bounces-90566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB8870147
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EE6B21E35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AFB3D3BD;
	Mon,  4 Mar 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4dInaOs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478161E497;
	Mon,  4 Mar 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555447; cv=none; b=Tbx9tHANcHs+JWb/Z6pNILD56lDq/w5505JsvW9cfLXBz4NWAIfFbXCqsTDmRg+VKqHxwM3PMtPX/V2sNVMMY0fjk2Mmq/PLkq4RgFpTjS7O4KW6u4l/toSpodYZvQWFYmc3z2Jlrdkt5einmW3FPWv2hSMetk5mRhR/EWRPAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555447; c=relaxed/simple;
	bh=dDFiSzziXJFNdVtCeloj7uM1p/JFexseASaR1J4v3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+keNI6aT7/jzTm2zbV2otuiy4n/IoB3rxe0aBZorLJCkQp9v/+aq9IN+NLGFQ2SJeZ6LpR2lHd6p7+LayuTSIH8HmvZ0uhxk7TqjIJg0drQP84v87EJbUnpinaKGgShSSiq+tWtLQiyAgw9BzpP2vFLNabSxo1gmIT+FaDp/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4dInaOs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555445; x=1741091445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dDFiSzziXJFNdVtCeloj7uM1p/JFexseASaR1J4v3lc=;
  b=k4dInaOsQ5SZFMsZboHXT5bG5Dod5DKk3lutYHkXPIK2eEoSCCy/gooZ
   0RMY4zao9Sm+IFyEPTjhjG7JdIGrLuSJsuyzv9a3rmwVvrV3k53Jsn/Vt
   wfzpJzFBgUUpbLR6zLUOavqlkOnBQiQHaNMXqCvH1MTNl8j7GT27vpsS8
   KtzSATr9D88+YoqtrhKJWrfpp37hJ4Kq7UXnGokUuPr2+IvgbMNdPQWAb
   u0iUm8qcAJgaNvVqjjDS84MiZbG2PmNYB2CfacknTY0bFycMrg/2cQiSN
   uM9+lLeeR6EledU6KauD3T3zjBkDF2eutr6Fel41hQytKJA3tz3BOBO0e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815025"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815025"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040421"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040421"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 29C201D6; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 00/14] serial: Add a helper to parse device properties and more
Date: Mon,  4 Mar 2024 14:27:01 +0200
Message-ID: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
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

Tested on Intel Apollo Lake with DesingWare 8250 UARTs (clang compiled)
and in QEMU for Aspeed configuration (gcc compiled). The rest has been
compile tested on x86_64 with clang.

In v3:
- split the helper to two and export as GPL (Greg)
- added tags (Florian, Kunihiko)

In v2:
- fixed typo (Hugo)
- renamed UPIO_UNSET --> UPIO_UNKNOWN (Florian)
- fixed 8250_of not working (Andrew)
- dropped unused variable in 8250_bcm7271 (LKP)
- added tag to 8250_aspeed_vuart (Andrew)

Andy Shevchenko (14):
  serial: core: Move struct uart_port::quirks closer to possible values
  serial: core: Add UPIO_UNKNOWN constant for unknown port type
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

 drivers/tty/serial/8250/8250_aspeed_vuart.c |  50 ++-----
 drivers/tty/serial/8250/8250_bcm2835aux.c   |  92 ++++++-------
 drivers/tty/serial/8250/8250_bcm7271.c      |  56 +++-----
 drivers/tty/serial/8250/8250_dw.c           |  67 ++++-----
 drivers/tty/serial/8250/8250_ingenic.c      |  20 +--
 drivers/tty/serial/8250/8250_lpc18xx.c      |  20 ++-
 drivers/tty/serial/8250/8250_of.c           | 105 +++-----------
 drivers/tty/serial/8250/8250_omap.c         |  29 ++--
 drivers/tty/serial/8250/8250_pxa.c          |  22 ++-
 drivers/tty/serial/8250/8250_tegra.c        |  26 ++--
 drivers/tty/serial/8250/8250_uniphier.c     |  17 +--
 drivers/tty/serial/serial_port.c            | 145 ++++++++++++++++++++
 include/linux/serial_core.h                 |  11 +-
 13 files changed, 325 insertions(+), 335 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


