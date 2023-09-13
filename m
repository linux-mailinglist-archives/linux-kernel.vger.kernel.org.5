Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C379E6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbjIMLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbjIMLdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:33:45 -0400
Received: from smtp79.iad3a.emailsrvr.com (smtp79.iad3a.emailsrvr.com [173.203.187.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0CD2114
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694604804;
        bh=bd75VHbHEFhfuVcFk1fhrnxBR8KungR64zUKoVzeJyc=;
        h=From:To:Subject:Date:From;
        b=YmKYUZCH9fBbjLBdObeZWiFZl3Gpmmx0UBHISENRwwxZ5NxVU8KOGCDNxJ/Uev8fc
         IxFsfOwmmfPS96/CeXDeF4WXCFAgayfi9HGjLjeKVa6BmCKl2ecoNA9lE/gf/N7QKh
         iIBj2663GLE4rhr/ecunrVKK8U7OIT4yLxIulTdE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 59A7B424F;
        Wed, 13 Sep 2023 07:33:23 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 13/13] comedi: add HAS_IOPORT dependencies again
Date:   Wed, 13 Sep 2023 12:32:47 +0100
Message-Id: <20230913113247.91749-14-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913113247.91749-1-abbotti@mev.co.uk>
References: <20230913113247.91749-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 007ec4bd-2574-475a-9bbd-5a4f93b29aec-14-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. We thus need to add HAS_IOPORT as dependency for
those drivers using them.

This was previously done in commit b5c75b68b7de ("comedi: add HAS_IOPORT
dependencies"), but that has been reverted because it made it impossible
to select configuration options for several comedi drivers.  This is a
do-over that avoids that.

Since the original patch, modifications have been made to various comedi
modules so that they can still be built even if the port I/O functions
have not been declared, so the configuration options for building those
modules no longer need to depend on HAS_IOPORT.

Make the COMEDI_ISA_DRIVERS menu option (which allows configuration
options for ISA and PC/104 drivers to be selected) depend on HAS_IOPORT,
and also depend on ISA || ISA_BUS || PC104.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/Kconfig | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 536101f68e0f..93c68a40a17b 100644
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -67,6 +67,7 @@ config COMEDI_TEST
 
 config COMEDI_PARPORT
 	tristate "Parallel port support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for the standard parallel port.
 	  A cheap and easy way to get a few more digital I/O lines. Steal
@@ -79,6 +80,7 @@ config COMEDI_PARPORT
 config COMEDI_SSV_DNP
 	tristate "SSV Embedded Systems DIL/Net-PC support"
 	depends on X86_32 || COMPILE_TEST
+	depends on HAS_IOPORT
 	help
 	  Enable support for SSV Embedded Systems DIL/Net-PC
 
@@ -89,6 +91,8 @@ endif # COMEDI_MISC_DRIVERS
 
 menuconfig COMEDI_ISA_DRIVERS
 	bool "Comedi ISA and PC/104 drivers"
+	depends on ISA || ISA_BUS || PC104
+	depends on HAS_IOPORT
 	help
 	  Enable comedi ISA and PC/104 drivers to be built
 
@@ -589,6 +593,7 @@ config COMEDI_8255_PCI
 
 config COMEDI_ADDI_WATCHDOG
 	tristate
+	depends on HAS_IOPORT
 	help
 	  Provides support for the watchdog subdevice found on many ADDI-DATA
 	  boards. This module will be automatically selected when needed. The
@@ -596,6 +601,7 @@ config COMEDI_ADDI_WATCHDOG
 
 config COMEDI_ADDI_APCI_1032
 	tristate "ADDI-DATA APCI_1032 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_1032 cards
 
@@ -604,6 +610,7 @@ config COMEDI_ADDI_APCI_1032
 
 config COMEDI_ADDI_APCI_1500
 	tristate "ADDI-DATA APCI_1500 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_1500 cards
 
@@ -612,6 +619,7 @@ config COMEDI_ADDI_APCI_1500
 
 config COMEDI_ADDI_APCI_1516
 	tristate "ADDI-DATA APCI-1016/1516/2016 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI-1016, APCI-1516 and APCI-2016 boards.
@@ -623,6 +631,7 @@ config COMEDI_ADDI_APCI_1516
 
 config COMEDI_ADDI_APCI_1564
 	tristate "ADDI-DATA APCI_1564 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI_1564 cards
@@ -632,6 +641,7 @@ config COMEDI_ADDI_APCI_1564
 
 config COMEDI_ADDI_APCI_16XX
 	tristate "ADDI-DATA APCI_16xx support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_16xx cards
 
@@ -640,6 +650,7 @@ config COMEDI_ADDI_APCI_16XX
 
 config COMEDI_ADDI_APCI_2032
 	tristate "ADDI-DATA APCI_2032 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI_2032 cards
@@ -649,6 +660,7 @@ config COMEDI_ADDI_APCI_2032
 
 config COMEDI_ADDI_APCI_2200
 	tristate "ADDI-DATA APCI_2200 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI_2200 cards
@@ -658,6 +670,7 @@ config COMEDI_ADDI_APCI_2200
 
 config COMEDI_ADDI_APCI_3120
 	tristate "ADDI-DATA APCI_3120/3001 support"
+	depends on HAS_IOPORT
 	depends on HAS_DMA
 	help
 	  Enable support for ADDI-DATA APCI_3120/3001 cards
@@ -667,6 +680,7 @@ config COMEDI_ADDI_APCI_3120
 
 config COMEDI_ADDI_APCI_3501
 	tristate "ADDI-DATA APCI_3501 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_3501 cards
 
@@ -675,6 +689,7 @@ config COMEDI_ADDI_APCI_3501
 
 config COMEDI_ADDI_APCI_3XXX
 	tristate "ADDI-DATA APCI_3xxx support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_3xxx cards
 
@@ -683,6 +698,7 @@ config COMEDI_ADDI_APCI_3XXX
 
 config COMEDI_ADL_PCI6208
 	tristate "ADLink PCI-6208A support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADLink PCI-6208A cards
 
@@ -691,6 +707,7 @@ config COMEDI_ADL_PCI6208
 
 config COMEDI_ADL_PCI7X3X
 	tristate "ADLink PCI-723X/743X isolated digital i/o board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADlink PCI-723X/743X isolated digital i/o boards.
 	  Supported boards include the 32-channel PCI-7230 (16 in/16 out),
@@ -702,6 +719,7 @@ config COMEDI_ADL_PCI7X3X
 
 config COMEDI_ADL_PCI8164
 	tristate "ADLink PCI-8164 4 Axes Motion Control board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADlink PCI-8164 4 Axes Motion Control board
 
@@ -710,6 +728,7 @@ config COMEDI_ADL_PCI8164
 
 config COMEDI_ADL_PCI9111
 	tristate "ADLink PCI-9111HR support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for ADlink PCI9111 cards
@@ -719,6 +738,7 @@ config COMEDI_ADL_PCI9111
 
 config COMEDI_ADL_PCI9118
 	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
+	depends on HAS_IOPORT
 	depends on HAS_DMA
 	select COMEDI_8254
 	help
@@ -729,6 +749,7 @@ config COMEDI_ADL_PCI9118
 
 config COMEDI_ADV_PCI1710
 	tristate "Advantech PCI-171x and PCI-1731 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Advantech PCI-1710, PCI-1710HG, PCI-1711,
@@ -739,6 +760,7 @@ config COMEDI_ADV_PCI1710
 
 config COMEDI_ADV_PCI1720
 	tristate "Advantech PCI-1720 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1720 Analog Output board.
 
@@ -747,6 +769,7 @@ config COMEDI_ADV_PCI1720
 
 config COMEDI_ADV_PCI1723
 	tristate "Advantech PCI-1723 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1723 cards
 
@@ -755,6 +778,7 @@ config COMEDI_ADV_PCI1723
 
 config COMEDI_ADV_PCI1724
 	tristate "Advantech PCI-1724U support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1724U cards.  These are 32-channel
 	  analog output cards with voltage and current loop output ranges and
@@ -765,6 +789,7 @@ config COMEDI_ADV_PCI1724
 
 config COMEDI_ADV_PCI1760
 	tristate "Advantech PCI-1760 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1760 board.
 
@@ -773,6 +798,7 @@ config COMEDI_ADV_PCI1760
 
 config COMEDI_ADV_PCI_DIO
 	tristate "Advantech PCI DIO card support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -796,6 +822,7 @@ config COMEDI_AMPLC_DIO200_PCI
 
 config COMEDI_AMPLC_PC236_PCI
 	tristate "Amplicon PCI236 DIO board support"
+	depends on HAS_IOPORT
 	select COMEDI_AMPLC_PC236
 	help
 	  Enable support for Amplicon PCI236 DIO board.
@@ -805,6 +832,7 @@ config COMEDI_AMPLC_PC236_PCI
 
 config COMEDI_AMPLC_PC263_PCI
 	tristate "Amplicon PCI263 relay board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Amplicon PCI263 relay board.  This is a PCI board
 	  with 16 reed relay output channels.
@@ -814,6 +842,7 @@ config COMEDI_AMPLC_PC263_PCI
 
 config COMEDI_AMPLC_PCI224
 	tristate "Amplicon PCI224 and PCI234 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Amplicon PCI224 and PCI234 AO boards
@@ -823,6 +852,7 @@ config COMEDI_AMPLC_PCI224
 
 config COMEDI_AMPLC_PCI230
 	tristate "Amplicon PCI230 and PCI260 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -834,6 +864,7 @@ config COMEDI_AMPLC_PCI230
 
 config COMEDI_CONTEC_PCI_DIO
 	tristate "Contec PIO1616L digital I/O board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for the Contec PIO1616L digital I/O board
 
@@ -842,6 +873,7 @@ config COMEDI_CONTEC_PCI_DIO
 
 config COMEDI_DAS08_PCI
 	tristate "DAS-08 PCI support"
+	depends on HAS_IOPORT
 	select COMEDI_DAS08
 	help
 	  Enable support for PCI DAS-08 cards.
@@ -861,6 +893,7 @@ config COMEDI_DT3000
 
 config COMEDI_DYNA_PCI10XX
 	tristate "Dynalog PCI DAQ series support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Dynalog PCI DAQ series
 	  PCI-1050
@@ -911,6 +944,7 @@ config COMEDI_JR3_PCI
 
 config COMEDI_KE_COUNTER
 	tristate "Kolter-Electronic PCI Counter 1 card support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Kolter-Electronic PCI Counter 1 cards
 
@@ -929,6 +963,7 @@ config COMEDI_CB_PCIDAS64
 
 config COMEDI_CB_PCIDAS
 	tristate "MeasurementComputing PCI-DAS support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -942,6 +977,7 @@ config COMEDI_CB_PCIDAS
 
 config COMEDI_CB_PCIDDA
 	tristate "MeasurementComputing PCI-DDA series support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DDA
@@ -953,6 +989,7 @@ config COMEDI_CB_PCIDDA
 
 config COMEDI_CB_PCIMDAS
 	tristate "MeasurementComputing PCIM-DAS1602/16, PCIe-DAS1602/16 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 	help
@@ -964,6 +1001,7 @@ config COMEDI_CB_PCIMDAS
 
 config COMEDI_CB_PCIMDDA
 	tristate "MeasurementComputing PCIM-DDA06-16 support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCIM-DDA06-16
@@ -973,6 +1011,7 @@ config COMEDI_CB_PCIMDDA
 
 config COMEDI_ME4000
 	tristate "Meilhaus ME-4000 support"
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	help
 	  Enable support for Meilhaus PCI data acquisition cards
@@ -1102,7 +1141,7 @@ endif # COMEDI_PCI_DRIVERS
 
 menuconfig COMEDI_PCMCIA_DRIVERS
 	tristate "Comedi PCMCIA drivers"
-	depends on PCMCIA
+	depends on PCMCIA && HAS_IOPORT
 	help
 	  Enable support for comedi PCMCIA drivers.
 
@@ -1253,6 +1292,7 @@ config COMEDI_8255
 
 config COMEDI_8255_SA
 	tristate "Standalone 8255 support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for 8255 digital I/O as a standalone driver.
@@ -1289,10 +1329,12 @@ config COMEDI_AMPLC_DIO200
 
 config COMEDI_AMPLC_PC236
 	tristate
+	depends on HAS_IOPORT
 	select COMEDI_8255
 
 config COMEDI_DAS08
 	tristate
+	depends on HAS_IOPORT
 	select COMEDI_8254
 	select COMEDI_8255
 
-- 
2.40.1

