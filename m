Return-Path: <linux-kernel+bounces-121907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B088EF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585F3B251C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3513153577;
	Wed, 27 Mar 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VspDePx/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A9152DE9;
	Wed, 27 Mar 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567913; cv=none; b=m1tANl+VyInn9EZZCZKJchp/UWZFVoH+bqNdbdP4we9qJukVaJXMY/BwGjD9u9EpgVHvcW24e0Uxhe0K7lstzLwtZzfRwlxvRWHg6nMLc0LbTAfP5+TWCNkH+/LJcH+/zWH8HOOgAmS0h0wpRpKCuKX2CEXDBPqT/U8oCqTPYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567913; c=relaxed/simple;
	bh=/BHAdaF+s+CWPuV02pEylhhQSEZjjV8zTiRovVO1XXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS2sYynL/Hn7kpp483PYnBCLL6peZ0dyKwSgY+gOdzXK3tTwN7oRY/5TES24HlpjAlVF4itJKeMevQ5nSJZnHU3yXaZmJk7vK2GqDicS8SzZIC2+l3+XUuSjd8SRLFXmKR06rha1iYSaCuJweEDCB7+IxOeI3B1yDyXVQaMUidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VspDePx/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567911; x=1743103911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BHAdaF+s+CWPuV02pEylhhQSEZjjV8zTiRovVO1XXs=;
  b=VspDePx/cBlHlnmagPSNLq5yApj3cYcgilguSfE1xyitNRxhon3oeroc
   WnQU/hJEZrJrbFxsuepvw2EtDDuV1utWikj4hq6Oht9nUSBZZq7zDPNFM
   idRvEqcSOPHzPfom2dWPYKU/Wrwcv1uZftE985HDLTQglh6LoZS8o+MVS
   5W8U4uKrNKrMKIeX5IGwQadLXlzMj6Lm8l6mAdL3I0J2qQt/t8MQ2EewB
   /EWctNxWuI01en7b0WRVuW0zAk4TdE4D+NnqIeGbwrxwH/5KQrlWA+ggE
   9O/mFOuBZykusKjehQg5kFZxHcrk4Mt/s0bGbiJ6iHSZwDWGLR/KJbo+j
   g==;
X-CSE-ConnectionGUID: 9xckIqMRTl29UKh8icdfRw==
X-CSE-MsgGUID: zkDsx+2QQP+/kOVlsDL+KQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187340"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075030"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075030"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DB2867C4; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 8/9] spi: pxa2xx: Remove outdated documentation
Date: Wed, 27 Mar 2024 21:29:27 +0200
Message-ID: <20240327193138.2385910-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation is referring to the legacy enumeration of the SPI
host controllers and target devices. It has nothing to do with the
modern way, which is the only supported in kernel right now. Hence,
remove outdated documentation file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/spi/pxa2xx.rst | 208 -----------------------------------
 drivers/spi/Kconfig          |   3 +-
 2 files changed, 1 insertion(+), 210 deletions(-)
 delete mode 100644 Documentation/spi/pxa2xx.rst

diff --git a/Documentation/spi/pxa2xx.rst b/Documentation/spi/pxa2xx.rst
deleted file mode 100644
index 33d2ad95901e..000000000000
--- a/Documentation/spi/pxa2xx.rst
+++ /dev/null
@@ -1,208 +0,0 @@
-==============================
-PXA2xx SPI on SSP driver HOWTO
-==============================
-
-This a mini HOWTO on the pxa2xx_spi driver. The driver turns a PXA2xx
-synchronous serial port into an SPI host controller
-(see Documentation/spi/spi-summary.rst). The driver has the following features
-
-- Support for any PXA2xx and compatible SSP.
-- SSP PIO and SSP DMA data transfers.
-- External and Internal (SSPFRM) chip selects.
-- Per peripheral device (chip) configuration.
-- Full suspend, freeze, resume support.
-
-The driver is built around a &struct spi_message FIFO serviced by kernel
-thread. The kernel thread, spi_pump_messages(), drives message FIFO and
-is responsible for queuing SPI transactions and setting up and launching
-the DMA or interrupt driven transfers.
-
-Declaring PXA2xx host controllers
----------------------------------
-Typically, for a legacy platform, an SPI host controller is defined in the
-arch/.../mach-*/board-*.c as a "platform device". The host controller configuration
-is passed to the driver via a table found in include/linux/spi/pxa2xx_spi.h::
-
-  struct pxa2xx_spi_controller {
-	u8 num_chipselect;
-	u8 enable_dma;
-	...
-  };
-
-The "pxa2xx_spi_controller.num_chipselect" field is used to determine the number of
-peripheral devices (chips) attached to this SPI host controller.
-
-The "pxa2xx_spi_controller.enable_dma" field informs the driver that SSP DMA should
-be used. This caused the driver to acquire two DMA channels: Rx channel and
-Tx channel. The Rx channel has a higher DMA service priority than the Tx channel.
-See the "PXA2xx Developer Manual" section "DMA Controller".
-
-For the new platforms the description of the controller and peripheral devices
-comes from Device Tree or ACPI.
-
-NSSP HOST SAMPLE
-----------------
-Below is a sample configuration using the PXA255 NSSP for a legacy platform::
-
-  static struct resource pxa_spi_nssp_resources[] = {
-	[0] = {
-		.start	= __PREG(SSCR0_P(2)), /* Start address of NSSP */
-		.end	= __PREG(SSCR0_P(2)) + 0x2c, /* Range of registers */
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_NSSP, /* NSSP IRQ */
-		.end	= IRQ_NSSP,
-		.flags	= IORESOURCE_IRQ,
-	},
-  };
-
-  static struct pxa2xx_spi_controller pxa_nssp_controller_info = {
-	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
-	.enable_dma = 1, /* Enables NSSP DMA */
-  };
-
-  static struct platform_device pxa_spi_nssp = {
-	.name = "pxa2xx-spi", /* MUST BE THIS VALUE, so device match driver */
-	.id = 2, /* Bus number, MUST MATCH SSP number 1..n */
-	.resource = pxa_spi_nssp_resources,
-	.num_resources = ARRAY_SIZE(pxa_spi_nssp_resources),
-	.dev = {
-		.platform_data = &pxa_nssp_controller_info, /* Passed to driver */
-	},
-  };
-
-  static struct platform_device *devices[] __initdata = {
-	&pxa_spi_nssp,
-  };
-
-  static void __init board_init(void)
-  {
-	(void)platform_add_device(devices, ARRAY_SIZE(devices));
-  }
-
-Declaring peripheral devices
-----------------------------
-Typically, for a legacy platform, each SPI peripheral device (chip) is defined in the
-arch/.../mach-*/board-*.c using the "spi_board_info" structure found in
-"linux/spi/spi.h". See "Documentation/spi/spi-summary.rst" for additional
-information.
-
-Each peripheral device (chip) attached to the PXA2xx must provide specific chip configuration
-information via the structure "pxa2xx_spi_chip" found in
-"include/linux/spi/pxa2xx_spi.h". The PXA2xx host controller driver will use
-the configuration whenever the driver communicates with the peripheral
-device. All fields are optional.
-
-::
-
-  struct pxa2xx_spi_chip {
-	u8 tx_threshold;
-	u8 rx_threshold;
-	u8 dma_burst_size;
-	u32 timeout;
-  };
-
-The "pxa2xx_spi_chip.tx_threshold" and "pxa2xx_spi_chip.rx_threshold" fields are
-used to configure the SSP hardware FIFO. These fields are critical to the
-performance of pxa2xx_spi driver and misconfiguration will result in rx
-FIFO overruns (especially in PIO mode transfers). Good default values are::
-
-	.tx_threshold = 8,
-	.rx_threshold = 8,
-
-The range is 1 to 16 where zero indicates "use default".
-
-The "pxa2xx_spi_chip.dma_burst_size" field is used to configure PXA2xx DMA
-engine and is related the "spi_device.bits_per_word" field.  Read and understand
-the PXA2xx "Developer Manual" sections on the DMA controller and SSP Controllers
-to determine the correct value. An SSP configured for byte-wide transfers would
-use a value of 8. The driver will determine a reasonable default if
-dma_burst_size == 0.
-
-The "pxa2xx_spi_chip.timeout" fields is used to efficiently handle
-trailing bytes in the SSP receiver FIFO. The correct value for this field is
-dependent on the SPI bus speed ("spi_board_info.max_speed_hz") and the specific
-peripheral device. Please note that the PXA2xx SSP 1 does not support trailing byte
-timeouts and must busy-wait any trailing bytes.
-
-NOTE: the SPI driver cannot control the chip select if SSPFRM is used, so the
-chipselect is dropped after each spi_transfer.  Most devices need chip select
-asserted around the complete message. Use SSPFRM as a GPIO (through a descriptor)
-to accommodate these chips.
-
-
-NSSP PERIPHERAL SAMPLE
-----------------------
-For a legacy platform or in some other cases, the pxa2xx_spi_chip structure
-is passed to the pxa2xx_spi driver in the "spi_board_info.controller_data"
-field. Below is a sample configuration using the PXA255 NSSP.
-
-::
-
-  static struct pxa2xx_spi_chip cs8415a_chip_info = {
-	.tx_threshold = 8, /* SSP hardware FIFO threshold */
-	.rx_threshold = 8, /* SSP hardware FIFO threshold */
-	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
-	.timeout = 235, /* See Intel documentation */
-  };
-
-  static struct pxa2xx_spi_chip cs8405a_chip_info = {
-	.tx_threshold = 8, /* SSP hardware FIFO threshold */
-	.rx_threshold = 8, /* SSP hardware FIFO threshold */
-	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
-	.timeout = 235, /* See Intel documentation */
-  };
-
-  static struct spi_board_info streetracer_spi_board_info[] __initdata = {
-	{
-		.modalias = "cs8415a", /* Name of spi_driver for this device */
-		.max_speed_hz = 3686400, /* Run SSP as fast a possible */
-		.bus_num = 2, /* Framework bus number */
-		.chip_select = 0, /* Framework chip select */
-		.platform_data = NULL; /* No spi_driver specific config */
-		.controller_data = &cs8415a_chip_info, /* Host controller config */
-		.irq = STREETRACER_APCI_IRQ, /* Peripheral device interrupt */
-	},
-	{
-		.modalias = "cs8405a", /* Name of spi_driver for this device */
-		.max_speed_hz = 3686400, /* Run SSP as fast a possible */
-		.bus_num = 2, /* Framework bus number */
-		.chip_select = 1, /* Framework chip select */
-		.controller_data = &cs8405a_chip_info, /* Host controller config */
-		.irq = STREETRACER_APCI_IRQ, /* Peripheral device interrupt */
-	},
-  };
-
-  static void __init streetracer_init(void)
-  {
-	spi_register_board_info(streetracer_spi_board_info,
-				ARRAY_SIZE(streetracer_spi_board_info));
-  }
-
-
-DMA and PIO I/O Support
------------------------
-The pxa2xx_spi driver supports both DMA and interrupt driven PIO message
-transfers.  The driver defaults to PIO mode and DMA transfers must be enabled
-by setting the "enable_dma" flag in the "pxa2xx_spi_controller" structure.
-For the newer platforms, that are known to support DMA, the driver will enable
-it automatically and try it first with a possible fallback to PIO. The DMA
-mode supports both coherent and stream based DMA mappings.
-
-The following logic is used to determine the type of I/O to be used on
-a per "spi_transfer" basis::
-
-  if spi_message.len > 65536 then
-	print "rate limited" warning
-	use PIO transfers
-
-  if enable_dma and the size is in the range [DMA burst size..65536] then
-	use streaming DMA mode
-
-  otherwise
-	use PIO transfer
-
-THANKS TO
----------
-David Brownell and others for mentoring the development of this driver.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c1bb1895009c..11d7ac8aed4a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -821,8 +821,7 @@ config SPI_PXA2XX
 	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
-	  controller. The driver can be configured to use any SSP port and
-	  additional documentation can be found a Documentation/spi/pxa2xx.rst.
+	  controller. The driver can be configured to use any SSP port.
 
 config SPI_PXA2XX_PCI
 	def_tristate SPI_PXA2XX && PCI && COMMON_CLK
-- 
2.43.0.rc1.1.gbec44491f096


