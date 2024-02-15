Return-Path: <linux-kernel+bounces-66467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5B9855D18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235E228471C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFDD16430;
	Thu, 15 Feb 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="buQzhEu1"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00816429;
	Thu, 15 Feb 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987441; cv=none; b=lMwZOaD42kWhYDnvkfHWm5FHbbP4q6QKfnvBtZILQMRYq31UZbVMQSbwXvATMTdt8SESM4+BzO0D2b9y0CF4B9V2rDJo94zlHbl7jcDgu2jd8tOvvtgYtq4KHIzzzdidMhrP9/69IiQ2PfgSiuY2H4nUcpCQ/kP6V7Dft/aFbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987441; c=relaxed/simple;
	bh=RuLH+zWGvYtPBZEQtwcgfIAvAmeG0yxzZpOuOW93as4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nm9JN9BsF8nw0Vpxfs0be1FlHlPZHp5BDhvp4F8AouRcYiSQiVcI/ljKDzsoYktn3OAuiC4D2l7FXqCfkK+6n2IMlb/m3xYEIU28EA8cncZfIoyKDmLLdOLLsh3Xxwj+w/z45pXpZzjyeVf3O51q2xac5kDh0KbpLsZn4cD6HJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=buQzhEu1; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F8vCri077138;
	Thu, 15 Feb 2024 02:57:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707987432;
	bh=2uhm9SilR2mce5+MUOP+57Tce8Zl11MBLLpOqvje+vc=;
	h=From:To:CC:Subject:Date;
	b=buQzhEu1FJteFhz3L2BJB5OOHqP4Mmr0474xwaukrUHomq0upeJ8ZOSK5w9+rDBcO
	 rxhnnhEQ8wOipvMq5REGjfFs+5iQt0/T/GxFJLUbxBjAmPGez20/bKYdhHSn4zbqXb
	 fTamUPpKWmfXgdJOmuB792qCM4p2Ez1dUPRZrY00=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F8vC8e006572
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 02:57:12 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 02:57:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 02:57:12 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F8v9Tq054044;
	Thu, 15 Feb 2024 02:57:10 -0600
From: Dhruva Gole <d-gole@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, <theo.lebrun@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole
	<d-gole@ti.com>
Subject: [PATCH] Documentation: spi: Update the "master/slave" terminology
Date: Thu, 15 Feb 2024 14:24:05 +0530
Message-ID: <20240215085404.1711976-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update the master/slave terminology wherever possible to adopt usage of
the controller/host/target. Some parts have been left untouched because
they were sysfs entries and will probably end up being inaccurate if
simply replaced here.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 Documentation/spi/spi-summary.rst | 40 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index e714472007f1..571f96807390 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -19,14 +19,14 @@ commonly used.  Each clock cycle shifts data out and data in; the clock
 doesn't cycle except when there is a data bit to shift.  Not all data bits
 are used though; not every protocol uses those full duplex capabilities.
 
-SPI hosts use a fourth "chip select" line to activate a given SPI slave
+SPI hosts use a fourth "chip select" line to activate a given SPI target
 device, so those three signal wires may be connected to several chips
-in parallel.  All SPI slaves support chipselects; they are usually active
-low signals, labeled nCSx for slave 'x' (e.g. nCS0).  Some devices have
+in parallel.  All SPI targets support chipselects; they are usually active
+low signals, labeled nCSx for target 'x' (e.g. nCS0).  Some devices have
 other signals, often including an interrupt to the host.
 
 Unlike serial busses like USB or SMBus, even low level protocols for
-SPI slave functions are usually not interoperable between vendors
+SPI target functions are usually not interoperable between vendors
 (except for commodities like SPI memory chips).
 
   - SPI may be used for request/response style device protocols, as with
@@ -43,8 +43,8 @@ SPI slave functions are usually not interoperable between vendors
 
   - Sometimes SPI is used to daisy-chain devices, like shift registers.
 
-In the same way, SPI slaves will only rarely support any kind of automatic
-discovery/enumeration protocol.  The tree of slave devices accessible from
+In the same way, SPI targets will only rarely support any kind of automatic
+discovery/enumeration protocol. The tree of target devices accessible from
 a given SPI host controller will normally be set up manually, with
 configuration tables.
 
@@ -75,7 +75,7 @@ protocol supported by every MMC or SD memory card.  (The older "DataFlash"
 cards, predating MMC cards but using the same connectors and card shape,
 support only SPI.)  Some PC hardware uses SPI flash for BIOS code.
 
-SPI slave chips range from digital/analog converters used for analog
+SPI target chips range from digital/analog converters used for analog
 sensors and codecs, to memory, to peripherals like USB controllers
 or Ethernet adapters; and more.
 
@@ -119,7 +119,7 @@ trailing clock edge (CPHA=1), that's SPI mode 1.
 
 Note that the clock mode is relevant as soon as the chipselect goes
 active.  So the host must set the clock to inactive before selecting
-a slave, and the slave can tell the chosen polarity by sampling the
+a target, and the target can tell the chosen polarity by sampling the
 clock level when its select line goes active.  That's why many devices
 support for example both modes 0 and 3:  they don't care about polarity,
 and always clock data in/out on rising clock edges.
@@ -142,13 +142,13 @@ There are two types of SPI driver, here called:
 
   Controller drivers ...
         controllers may be built into System-On-Chip
-	processors, and often support both Master and Slave roles.
+	processors, and often support both Controller and target roles.
 	These drivers touch hardware registers and may use DMA.
 	Or they can be PIO bitbangers, needing just GPIO pins.
 
   Protocol drivers ...
         these pass messages through the controller
-	driver to communicate with a Slave or Master device on the
+	driver to communicate with a target or Controller device on the
 	other side of an SPI link.
 
 So for example one protocol driver might talk to the MTD layer to export
@@ -184,17 +184,17 @@ shows up in sysfs in several locations::
 	MOSI, and MISO.
 
    /sys/devices/.../CTLR/slave ... virtual file for (un)registering the
-	slave device for an SPI slave controller.
-	Writing the driver name of an SPI slave handler to this file
-	registers the slave device; writing "(null)" unregisters the slave
+	target device for an SPI target controller.
+	Writing the driver name of an SPI target handler to this file
+	registers the target device; writing "(null)" unregisters the target
 	device.
-	Reading from this file shows the name of the slave device ("(null)"
+	Reading from this file shows the name of the target device ("(null)"
 	if not registered).
 
    /sys/class/spi_slave/spiB ... symlink to a logical node which could hold
-	class related state for the SPI slave controller on bus "B".  When
+	class related state for the SPI target controller on bus "B".  When
 	registered, a single spiB.* device is present here, possible sharing
-	the physical SPI bus segment with other SPI slave devices.
+	the physical SPI bus segment with other SPI target devices.
 
 At this time, the only class-specific state is the bus number ("B" in "spiB"),
 so those /sys/class entries are only useful to quickly identify busses.
@@ -270,10 +270,10 @@ same SOC controller is used.  For example, on one board SPI might use
 an external clock, where another derives the SPI clock from current
 settings of some master clock.
 
-Declare Slave Devices
+Declare target Devices
 ^^^^^^^^^^^^^^^^^^^^^
 
-The second kind of information is a list of what SPI slave devices exist
+The second kind of information is a list of what SPI target devices exist
 on the target board, often with some board-specific data needed for the
 driver to work correctly.
 
@@ -469,7 +469,7 @@ routines are available to allocate and zero-initialize an spi_message
 with several transfers.
 
 
-How do I write an "SPI Master Controller Driver"?
+How do I write an "SPI Controller Driver"?
 -------------------------------------------------
 An SPI controller will probably be registered on the platform_bus; write
 a driver to bind to the device, whichever bus is involved.
@@ -527,7 +527,7 @@ SPI Host Controller Methods
 	Drivers may change the defaults provided by board_info, and then
 	call spi_setup(spi) to invoke this routine.  It may sleep.
 
-	Unless each SPI slave has its own configuration registers, don't
+	Unless each SPI target has its own configuration registers, don't
 	change them right away ... otherwise drivers could corrupt I/O
 	that's in progress for other SPI devices.
 

base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
-- 
2.34.1


