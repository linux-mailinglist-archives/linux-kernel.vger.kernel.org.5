Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E479027C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350492AbjIATcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIATcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:32:05 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 12:32:00 PDT
Received: from smtp93.iad3b.emailsrvr.com (smtp93.iad3b.emailsrvr.com [146.20.161.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE4210E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1693596392;
        bh=szcYN2QzQj5hcIPHwz26NqoA83cJxTQFaJrm+4mISOE=;
        h=From:To:Subject:Date:From;
        b=WBmsDJnxuNlRoKsdQqf4qOhKZtjCQqRYKYC+8019UoC+Mbom8UiBZL7t5M1/6owAi
         kYqV75aQuUw9RN/Ui8zbBqJS/uR+osozPFnssKZCfbD4RhDY973029zAFnIajzw6ld
         4fsGe1FzabU3CTc/Xf6gCKS3InErngOWa05jz9sA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp12.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 5B489C0123;
        Fri,  1 Sep 2023 15:26:31 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT changes
Date:   Fri,  1 Sep 2023 20:26:15 +0100
Message-Id: <20230901192615.89591-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bba86aa2-72d8-4795-9d86-3d1e1c9840b1-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") changed the
"select" directives to "depend on" directives for several config
stanzas, but the options they depended on could not be selected,
breaking previously selected options.  Change them back to "select"
directives and add "depends on HAS_IOPORT" to config entries for modules
that either use inb()/outb() and friends directly, or (recursively)
depend on modules that do so.

Fixes: b5c75b68b7de ("comedi: add HAS_IOPORT dependencies")
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/Kconfig | 119 +++++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 47 deletions(-)

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 7a8d402f05be..094102e5ee1f 100644
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -103,8 +103,7 @@ if COMEDI_ISA_DRIVERS
 
 config COMEDI_PCL711
 	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-711 and 711b, ADlink ACL-8112
 
@@ -165,9 +164,8 @@ config COMEDI_PCL730
 
 config COMEDI_PCL812
 	tristate "Advantech PCL-812/813 and ADlink ACL-8112/8113/8113/8216"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-812/PG, PCL-813/B, ADLink
 	  ACL-8112DG/HG/PG, ACL-8113, ACL-8216, ICP DAS A-821PGH/PGL/PGL-NDA,
@@ -178,9 +176,8 @@ config COMEDI_PCL812
 
 config COMEDI_PCL816
 	tristate "Advantech PCL-814 and PCL-816 ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-814 and PCL-816 ISA cards
 
@@ -189,9 +186,8 @@ config COMEDI_PCL816
 
 config COMEDI_PCL818
 	tristate "Advantech PCL-718 and PCL-818 ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCL-818 ISA cards
 	  PCL-818L, PCL-818H, PCL-818HD, PCL-818HG, PCL-818 and PCL-718
@@ -210,7 +206,7 @@ config COMEDI_PCM3724
 
 config COMEDI_AMPLC_DIO200_ISA
 	tristate "Amplicon PC212E/PC214E/PC215E/PC218E/PC272E"
-	depends on COMEDI_AMPLC_DIO200
+	select COMEDI_AMPLC_DIO200
 	help
 	  Enable support for Amplicon PC212E, PC214E, PC215E, PC218E and
 	  PC272E ISA DIO boards
@@ -262,8 +258,7 @@ config COMEDI_DAC02
 
 config COMEDI_DAS16M1
 	tristate "MeasurementComputing CIO-DAS16/M1DAS-16 ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Measurement Computing CIO-DAS16/M1 ISA cards.
@@ -273,7 +268,7 @@ config COMEDI_DAS16M1
 
 config COMEDI_DAS08_ISA
 	tristate "DAS-08 compatible ISA and PC/104 card support"
-	depends on COMEDI_DAS08
+	select COMEDI_DAS08
 	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS08
 	  and compatible ISA and PC/104 cards:
@@ -286,9 +281,8 @@ config COMEDI_DAS08_ISA
 
 config COMEDI_DAS16
 	tristate "DAS-16 compatible ISA and PC/104 card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS16
@@ -305,8 +299,7 @@ config COMEDI_DAS16
 
 config COMEDI_DAS800
 	tristate "DAS800 and compatible ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Keithley Metrabyte DAS800 and compatible ISA cards
 	  Keithley Metrabyte DAS-800, DAS-801, DAS-802
@@ -318,9 +311,8 @@ config COMEDI_DAS800
 
 config COMEDI_DAS1800
 	tristate "DAS1800 and compatible ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for DAS1800 and compatible ISA cards
 	  Keithley Metrabyte DAS-1701ST, DAS-1701ST-DA, DAS-1701/AO,
@@ -334,8 +326,7 @@ config COMEDI_DAS1800
 
 config COMEDI_DAS6402
 	tristate "DAS6402 and compatible ISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for DAS6402 and compatible ISA cards
 	  Computerboards, Keithley Metrabyte DAS6402 and compatibles
@@ -414,8 +405,7 @@ config COMEDI_FL512
 
 config COMEDI_AIO_AIO12_8
 	tristate "I/O Products PC/104 AIO12-8 Analog I/O Board support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for I/O Products PC/104 AIO12-8 Analog I/O Board
@@ -469,9 +459,8 @@ config COMEDI_ADQ12B
 
 config COMEDI_NI_AT_A2150
 	tristate "NI AT-A2150 ISA card support"
-	depends on HAS_IOPORT
 	select COMEDI_ISADMA if ISA_DMA_API
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for National Instruments AT-A2150 cards
 
@@ -480,8 +469,7 @@ config COMEDI_NI_AT_A2150
 
 config COMEDI_NI_AT_AO
 	tristate "NI AT-AO-6/10 EISA card support"
-	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for National Instruments AT-AO-6/10 cards
 
@@ -512,7 +500,7 @@ config COMEDI_NI_ATMIO16D
 
 config COMEDI_NI_LABPC_ISA
 	tristate "NI Lab-PC and compatibles ISA support"
-	depends on COMEDI_NI_LABPC
+	select COMEDI_NI_LABPC
 	help
 	  Enable support for National Instruments Lab-PC and compatibles
 	  Lab-PC-1200, Lab-PC-1200AI, Lab-PC+.
@@ -576,7 +564,7 @@ endif # COMEDI_ISA_DRIVERS
 
 menuconfig COMEDI_PCI_DRIVERS
 	tristate "Comedi PCI drivers"
-	depends on PCI && HAS_IOPORT
+	depends on PCI
 	help
 	  Enable support for comedi PCI drivers.
 
@@ -587,6 +575,7 @@ if COMEDI_PCI_DRIVERS
 
 config COMEDI_8255_PCI
 	tristate "Generic PCI based 8255 digital i/o board support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for PCI based 8255 digital i/o boards. This driver
@@ -604,6 +593,7 @@ config COMEDI_8255_PCI
 
 config COMEDI_ADDI_WATCHDOG
 	tristate
+	depends on HAS_IOPORT
 	help
 	  Provides support for the watchdog subdevice found on many ADDI-DATA
 	  boards. This module will be automatically selected when needed. The
@@ -611,6 +601,7 @@ config COMEDI_ADDI_WATCHDOG
 
 config COMEDI_ADDI_APCI_1032
 	tristate "ADDI-DATA APCI_1032 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_1032 cards
 
@@ -619,6 +610,7 @@ config COMEDI_ADDI_APCI_1032
 
 config COMEDI_ADDI_APCI_1500
 	tristate "ADDI-DATA APCI_1500 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_1500 cards
 
@@ -627,6 +619,7 @@ config COMEDI_ADDI_APCI_1500
 
 config COMEDI_ADDI_APCI_1516
 	tristate "ADDI-DATA APCI-1016/1516/2016 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI-1016, APCI-1516 and APCI-2016 boards.
@@ -638,6 +631,7 @@ config COMEDI_ADDI_APCI_1516
 
 config COMEDI_ADDI_APCI_1564
 	tristate "ADDI-DATA APCI_1564 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI_1564 cards
@@ -647,6 +641,7 @@ config COMEDI_ADDI_APCI_1564
 
 config COMEDI_ADDI_APCI_16XX
 	tristate "ADDI-DATA APCI_16xx support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_16xx cards
 
@@ -655,6 +650,7 @@ config COMEDI_ADDI_APCI_16XX
 
 config COMEDI_ADDI_APCI_2032
 	tristate "ADDI-DATA APCI_2032 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI_2032 cards
@@ -664,6 +660,7 @@ config COMEDI_ADDI_APCI_2032
 
 config COMEDI_ADDI_APCI_2200
 	tristate "ADDI-DATA APCI_2200 support"
+	depends on HAS_IOPORT
 	select COMEDI_ADDI_WATCHDOG
 	help
 	  Enable support for ADDI-DATA APCI_2200 cards
@@ -673,6 +670,7 @@ config COMEDI_ADDI_APCI_2200
 
 config COMEDI_ADDI_APCI_3120
 	tristate "ADDI-DATA APCI_3120/3001 support"
+	depends on HAS_IOPORT
 	depends on HAS_DMA
 	help
 	  Enable support for ADDI-DATA APCI_3120/3001 cards
@@ -682,6 +680,7 @@ config COMEDI_ADDI_APCI_3120
 
 config COMEDI_ADDI_APCI_3501
 	tristate "ADDI-DATA APCI_3501 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_3501 cards
 
@@ -690,6 +689,7 @@ config COMEDI_ADDI_APCI_3501
 
 config COMEDI_ADDI_APCI_3XXX
 	tristate "ADDI-DATA APCI_3xxx support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADDI-DATA APCI_3xxx cards
 
@@ -698,6 +698,7 @@ config COMEDI_ADDI_APCI_3XXX
 
 config COMEDI_ADL_PCI6208
 	tristate "ADLink PCI-6208A support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADLink PCI-6208A cards
 
@@ -706,6 +707,7 @@ config COMEDI_ADL_PCI6208
 
 config COMEDI_ADL_PCI7X3X
 	tristate "ADLink PCI-723X/743X isolated digital i/o board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADlink PCI-723X/743X isolated digital i/o boards.
 	  Supported boards include the 32-channel PCI-7230 (16 in/16 out),
@@ -717,6 +719,7 @@ config COMEDI_ADL_PCI7X3X
 
 config COMEDI_ADL_PCI8164
 	tristate "ADLink PCI-8164 4 Axes Motion Control board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for ADlink PCI-8164 4 Axes Motion Control board
 
@@ -726,7 +729,7 @@ config COMEDI_ADL_PCI8164
 config COMEDI_ADL_PCI9111
 	tristate "ADLink PCI-9111HR support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for ADlink PCI9111 cards
 
@@ -735,8 +738,8 @@ config COMEDI_ADL_PCI9111
 
 config COMEDI_ADL_PCI9118
 	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
+	depends on HAS_IOPORT
 	depends on HAS_DMA
-	depends on COMEDI_8254
 	help
 	  Enable support for ADlink PCI-9118DG, PCI-9118HG, PCI-9118HR cards
 
@@ -746,7 +749,7 @@ config COMEDI_ADL_PCI9118
 config COMEDI_ADV_PCI1710
 	tristate "Advantech PCI-171x and PCI-1731 support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Advantech PCI-1710, PCI-1710HG, PCI-1711,
 	  PCI-1713 and PCI-1731
@@ -756,6 +759,7 @@ config COMEDI_ADV_PCI1710
 
 config COMEDI_ADV_PCI1720
 	tristate "Advantech PCI-1720 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1720 Analog Output board.
 
@@ -764,6 +768,7 @@ config COMEDI_ADV_PCI1720
 
 config COMEDI_ADV_PCI1723
 	tristate "Advantech PCI-1723 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1723 cards
 
@@ -772,6 +777,7 @@ config COMEDI_ADV_PCI1723
 
 config COMEDI_ADV_PCI1724
 	tristate "Advantech PCI-1724U support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1724U cards.  These are 32-channel
 	  analog output cards with voltage and current loop output ranges and
@@ -782,6 +788,7 @@ config COMEDI_ADV_PCI1724
 
 config COMEDI_ADV_PCI1760
 	tristate "Advantech PCI-1760 support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Advantech PCI-1760 board.
 
@@ -791,7 +798,7 @@ config COMEDI_ADV_PCI1760
 config COMEDI_ADV_PCI_DIO
 	tristate "Advantech PCI DIO card support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Advantech PCI DIO cards
@@ -804,7 +811,8 @@ config COMEDI_ADV_PCI_DIO
 
 config COMEDI_AMPLC_DIO200_PCI
 	tristate "Amplicon PCI215/PCI272/PCIe215/PCIe236/PCIe296 DIO support"
-	depends on COMEDI_AMPLC_DIO200
+	depends on HAS_IOPORT
+	select COMEDI_AMPLC_DIO200
 	help
 	  Enable support for Amplicon PCI215, PCI272, PCIe215, PCIe236
 	  and PCIe296 DIO boards.
@@ -814,6 +822,7 @@ config COMEDI_AMPLC_DIO200_PCI
 
 config COMEDI_AMPLC_PC236_PCI
 	tristate "Amplicon PCI236 DIO board support"
+	depends on HAS_IOPORT
 	select COMEDI_AMPLC_PC236
 	help
 	  Enable support for Amplicon PCI236 DIO board.
@@ -823,6 +832,7 @@ config COMEDI_AMPLC_PC236_PCI
 
 config COMEDI_AMPLC_PC263_PCI
 	tristate "Amplicon PCI263 relay board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Amplicon PCI263 relay board.  This is a PCI board
 	  with 16 reed relay output channels.
@@ -833,7 +843,7 @@ config COMEDI_AMPLC_PC263_PCI
 config COMEDI_AMPLC_PCI224
 	tristate "Amplicon PCI224 and PCI234 support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Amplicon PCI224 and PCI234 AO boards
 
@@ -843,7 +853,7 @@ config COMEDI_AMPLC_PCI224
 config COMEDI_AMPLC_PCI230
 	tristate "Amplicon PCI230 and PCI260 support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for Amplicon PCI230 and PCI260 Multifunction I/O
@@ -854,6 +864,7 @@ config COMEDI_AMPLC_PCI230
 
 config COMEDI_CONTEC_PCI_DIO
 	tristate "Contec PIO1616L digital I/O board support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for the Contec PIO1616L digital I/O board
 
@@ -862,7 +873,8 @@ config COMEDI_CONTEC_PCI_DIO
 
 config COMEDI_DAS08_PCI
 	tristate "DAS-08 PCI support"
-	depends on COMEDI_DAS08
+	depends on HAS_IOPORT
+	select COMEDI_DAS08
 	help
 	  Enable support for PCI DAS-08 cards.
 
@@ -881,6 +893,7 @@ config COMEDI_DT3000
 
 config COMEDI_DYNA_PCI10XX
 	tristate "Dynalog PCI DAQ series support"
+	depends on HAS_IOPORT
 	help
 	  Enable support for Dynalog PCI DAQ series
 	  PCI-1050
@@ -914,6 +927,7 @@ config COMEDI_ICP_MULTI
 
 config COMEDI_DAQBOARD2000
 	tristate "IOtech DAQboard/2000 support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for the IOtech DAQboard/2000
@@ -939,6 +953,7 @@ config COMEDI_KE_COUNTER
 
 config COMEDI_CB_PCIDAS64
 	tristate "MeasurementComputing PCI-DAS 64xx, 60xx, and 4020 support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DAS 64xx,
@@ -950,7 +965,7 @@ config COMEDI_CB_PCIDAS64
 config COMEDI_CB_PCIDAS
 	tristate "MeasurementComputing PCI-DAS support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DAS with
@@ -963,6 +978,7 @@ config COMEDI_CB_PCIDAS
 
 config COMEDI_CB_PCIDDA
 	tristate "MeasurementComputing PCI-DDA series support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DDA
@@ -975,7 +991,7 @@ config COMEDI_CB_PCIDDA
 config COMEDI_CB_PCIMDAS
 	tristate "MeasurementComputing PCIM-DAS1602/16, PCIe-DAS1602/16 support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI Migration
@@ -986,6 +1002,7 @@ config COMEDI_CB_PCIMDAS
 
 config COMEDI_CB_PCIMDDA
 	tristate "MeasurementComputing PCIM-DDA06-16 support"
+	depends on HAS_IOPORT
 	select COMEDI_8255
 	help
 	  Enable support for ComputerBoards/MeasurementComputing PCIM-DDA06-16
@@ -996,7 +1013,7 @@ config COMEDI_CB_PCIMDDA
 config COMEDI_ME4000
 	tristate "Meilhaus ME-4000 support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Meilhaus PCI data acquisition cards
 	  ME-4650, ME-4670i, ME-4680, ME-4680i and ME-4680is
@@ -1054,7 +1071,8 @@ config COMEDI_NI_670X
 
 config COMEDI_NI_LABPC_PCI
 	tristate "NI Lab-PC PCI-1200 support"
-	depends on COMEDI_NI_LABPC
+	depends on HAS_IOPORT
+	select COMEDI_NI_LABPC
 	help
 	  Enable support for National Instruments Lab-PC PCI-1200.
 
@@ -1064,6 +1082,7 @@ config COMEDI_NI_LABPC_PCI
 config COMEDI_NI_PCIDIO
 	tristate "NI PCI-DIO32HS, PCI-6533, PCI-6534 support"
 	depends on HAS_DMA
+	depends on HAS_IOPORT
 	select COMEDI_MITE
 	select COMEDI_8255
 	help
@@ -1099,7 +1118,7 @@ config COMEDI_NI_PCIMIO
 config COMEDI_RTD520
 	tristate "Real Time Devices PCI4520/DM7520 support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for Real Time Devices PCI4520/DM7520
 
@@ -1140,7 +1159,7 @@ if COMEDI_PCMCIA_DRIVERS
 config COMEDI_CB_DAS16_CS
 	tristate "CB DAS16 series PCMCIA support"
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	help
 	  Enable support for the ComputerBoards/MeasurementComputing PCMCIA
 	  cards DAS16/16, PCM-DAS16D/12 and PCM-DAS16s/16
@@ -1150,7 +1169,8 @@ config COMEDI_CB_DAS16_CS
 
 config COMEDI_DAS08_CS
 	tristate "CB DAS08 PCMCIA support"
-	depends on COMEDI_DAS08
+	depends on HAS_IOPORT
+	select COMEDI_DAS08
 	help
 	  Enable support for the ComputerBoards/MeasurementComputing DAS-08
 	  PCMCIA card
@@ -1179,7 +1199,8 @@ config COMEDI_NI_DAQ_DIO24_CS
 
 config COMEDI_NI_LABPC_CS
 	tristate "NI DAQCard-1200 PCMCIA support"
-	depends on COMEDI_NI_LABPC
+	depends on HAS_IOPORT
+	select COMEDI_NI_LABPC
 	help
 	  Enable support for the National Instruments PCMCIA DAQCard-1200
 
@@ -1282,6 +1303,7 @@ config COMEDI_8254
 
 config COMEDI_8255
 	tristate
+	depends on HAS_IOPORT
 
 config COMEDI_8255_SA
 	tristate "Standalone 8255 support"
@@ -1317,16 +1339,19 @@ config COMEDI_KCOMEDILIB
 	  called kcomedilib.
 
 config COMEDI_AMPLC_DIO200
-	depends on COMEDI_8254
 	tristate
+	depends on HAS_IOPORT
+	select COMEDI_8254
 
 config COMEDI_AMPLC_PC236
 	tristate
+	depends on HAS_IOPORT
 	select COMEDI_8255
 
 config COMEDI_DAS08
 	tristate
-	depends on COMEDI_8254
+	depends on HAS_IOPORT
+	select COMEDI_8254
 	select COMEDI_8255
 
 config COMEDI_ISADMA
@@ -1335,7 +1360,7 @@ config COMEDI_ISADMA
 config COMEDI_NI_LABPC
 	tristate
 	depends on HAS_IOPORT
-	depends on COMEDI_8254
+	select COMEDI_8254
 	select COMEDI_8255
 
 config COMEDI_NI_LABPC_ISADMA
-- 
2.40.1

