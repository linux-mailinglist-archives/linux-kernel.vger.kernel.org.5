Return-Path: <linux-kernel+bounces-81607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38586783C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D34C1F23BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E662412B17F;
	Mon, 26 Feb 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl9C22Gr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357A12A14B;
	Mon, 26 Feb 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957528; cv=none; b=cYl8rvc4Vu1pr4MqLeypsMsh59SUdOi87HdAxsa43m16BJs96xNOTejlAOXPRmyNnxPRBAy2h6kmf8SwtfCu1aD4de7xc96EZjIY0/umqRyofBmoFi+/EH8xCUXq7H5LHyFbIj4+EWnejQB97O8pw9uH7EVFZGAXsw8fpR6Vub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957528; c=relaxed/simple;
	bh=74CnFkZQ38BEQwdCa2/x1RRI0t/N2qwbGFXvoSq90DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmlSTclzvI9ye/PxTUFFNLsUfBuXpMT79C3ktNJ9u7sfNFnQRs3rMljgMssyKI5A6DQT1Y3jUTjATevvvtdncPsw4Ols2fXoRDNw8xRdVuwaV8/9uqImi8ryESnis4rQ99PesA6PSutDnh9S0yZneDd/S46QaAlmdptI+x2nnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tl9C22Gr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957527; x=1740493527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=74CnFkZQ38BEQwdCa2/x1RRI0t/N2qwbGFXvoSq90DY=;
  b=Tl9C22GrDCIfgIF2A1YWRNd8HgYuSQGRc2IcyLTp/BFJRUpHtpODlo10
   uSr7rRJA2SmChJNGSXQVRMh/fkt6bvheMXcZDqLgcMMkN1KIyB3Xl9Jt9
   dqGeKmMKuyjkhe3LZQiiGDBj8nozc7yOraD/ASCbyOXuzCJ/Vgmo17syX
   LpIC0Dcb+0qu8+SdmKQCrf/IyoSdVDR6ufhZZ2Sg2oA5DPGkil76oD+d8
   MteAHdf1pThdaO56V7lpitTJX17x8cWMuQG64XfMOE9onGJcRNAI4UQFO
   YEJxPNlg3BEpJXoYQfsy97qCmcmt6ZYSTEe58dSf5eT2wUFFK9blWtr90
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375144"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375144"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030139"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030139"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E5EA8213; Mon, 26 Feb 2024 16:25:15 +0200 (EET)
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
Subject: [PATCH v2 00/14] serial: Add a helper to parse device properties and more
Date: Mon, 26 Feb 2024 16:19:16 +0200
Message-ID: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
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

 drivers/tty/serial/8250/8250_aspeed_vuart.c |  50 +++-----
 drivers/tty/serial/8250/8250_bcm2835aux.c   |  92 ++++++--------
 drivers/tty/serial/8250/8250_bcm7271.c      |  56 +++-----
 drivers/tty/serial/8250/8250_dw.c           |  67 ++++------
 drivers/tty/serial/8250/8250_ingenic.c      |  20 +--
 drivers/tty/serial/8250/8250_lpc18xx.c      |  20 ++-
 drivers/tty/serial/8250/8250_of.c           | 105 ++++-----------
 drivers/tty/serial/8250/8250_omap.c         |  29 ++---
 drivers/tty/serial/8250/8250_pxa.c          |  22 ++--
 drivers/tty/serial/8250/8250_tegra.c        |  26 ++--
 drivers/tty/serial/8250/8250_uniphier.c     |  17 +--
 drivers/tty/serial/serial_port.c            | 134 ++++++++++++++++++++
 include/linux/serial_core.h                 |  10 +-
 13 files changed, 313 insertions(+), 335 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


