Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D9F79EF05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjIMQnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjIMQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:42:51 -0400
Received: from smtp70.iad3a.emailsrvr.com (smtp70.iad3a.emailsrvr.com [173.203.187.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B4212F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623227;
        bh=RPae74SFyNMNMle2W62auXphRC1MqWIbOcTSVGqhAA4=;
        h=From:To:Subject:Date:From;
        b=a3+kNefOJvufxK18wLFBSiG55jPgnM6om3EbjBomNip1Ou/UdINokKOKJlIQ/k7Mv
         oMfrkyC74AI9XW3m0BQ7PXGhQ+6Yxw3ZKVr9mx3wP9zfZJQ3rGjLkEhVsJ/6g/1xHn
         Nmxu7ptIzvkFNnHcMytPQNICVbB7FMPmwZPBUGTw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp25.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 55E4C23049;
        Wed, 13 Sep 2023 12:40:26 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 00/13] comedi: Re-do HAS_IOPORT dependencies
Date:   Wed, 13 Sep 2023 17:40:00 +0100
Message-Id: <20230913164013.107520-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: bb5231ff-a70f-4c9d-8b55-93f03f91465d-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") was reverted
because it made it impossible to select configuration options that
depend on the COMEDI_8254, COMEDI_DAS08, COMEDI_NI_LABPC, or
COMEDI_AMPLC_DIO200 options due to changing 'select' directives to
'depends on' directives and there being no other way to select those
codependent configuration options.

This patch series conditionally removes port I/O support from various
comedi modules so they still be built when a future patch removes the
port I/O functions (inb(), outb() and friends) unless the HAS_IOPORT
configuration option is selected.  The final patch 13 adds HAS_IOPORT
dependencies to the configuration options as in the reverted patch, but
there are now fewer options that need to depend on HAS_IOPORT, and the
'select' directives have not been replaced with 'depends on' directives.

01) comedi: Correct dependencies for COMEDI_NI_PCIDIO
02) comedi: comedi_8254: Use a call-back function for register access
03) comedi: comedi_8254: Replace comedi_8254_init() and comedi_8254_mm_init()
04) comedi: comedi_8254: Conditionally remove I/O port support
05) comedi: 8255_pci: Conditionally remove devices that use port I/O
06) comedi: comedi_8255: Rework subdevice initialization functions
07) comedi: comedi_8255: Conditionally remove I/O port support
08) comedi: ni_labpc_common: Conditionally remove I/O port support
09) comedi: ni_mio_common: Conditionally use I/O port or MMIO
10) comedi: amplc_dio200_pci: Conditionally remove devices that use port I/O
11) comedi: amplc_dio200_common: Refactor register access functions
12) comedi: amplc_dio200_common: Conditionally remove I/O port support
13) comedi: add HAS_IOPORT dependencies again

=============================
v2:

0. Patch titles and numbering is unchanged since v1.

1. Corrects [CONFIG_]HAS_PORTIO to [CONFIG_]HAS_IOPORT in the code for
patches 05 and 08, and in the description for patches 05, 06, 08, 10,
11, and 12.

2. Enhances the commit description for patch 08 a bit.
=============================

 drivers/comedi/Kconfig                       |  45 +++++-
 drivers/comedi/drivers.c                     |   3 +-
 drivers/comedi/drivers/8255.c                |   2 +-
 drivers/comedi/drivers/8255_pci.c            |  15 +-
 drivers/comedi/drivers/adl_pci9111.c         |   8 +-
 drivers/comedi/drivers/adl_pci9118.c         |   8 +-
 drivers/comedi/drivers/adv_pci1710.c         |   8 +-
 drivers/comedi/drivers/adv_pci_dio.c         |  14 +-
 drivers/comedi/drivers/aio_aio12_8.c         |  10 +-
 drivers/comedi/drivers/amplc_dio200_common.c | 104 +++++++++---
 drivers/comedi/drivers/amplc_dio200_pci.c    |  12 +-
 drivers/comedi/drivers/amplc_pc236_common.c  |   2 +-
 drivers/comedi/drivers/amplc_pci224.c        |   8 +-
 drivers/comedi/drivers/amplc_pci230.c        |  10 +-
 drivers/comedi/drivers/cb_das16_cs.c         |   8 +-
 drivers/comedi/drivers/cb_pcidas.c           |  23 +--
 drivers/comedi/drivers/cb_pcidas64.c         |   7 +-
 drivers/comedi/drivers/cb_pcidda.c           |   2 +-
 drivers/comedi/drivers/cb_pcimdas.c          |  12 +-
 drivers/comedi/drivers/cb_pcimdda.c          |   2 +-
 drivers/comedi/drivers/comedi_8254.c         | 234 ++++++++++++++++++---------
 drivers/comedi/drivers/comedi_8255.c         | 123 +++++++-------
 drivers/comedi/drivers/daqboard2000.c        |   4 +-
 drivers/comedi/drivers/das08.c               |  11 +-
 drivers/comedi/drivers/das16.c               |  10 +-
 drivers/comedi/drivers/das16m1.c             |  22 +--
 drivers/comedi/drivers/das1800.c             |   8 +-
 drivers/comedi/drivers/das6402.c             |   8 +-
 drivers/comedi/drivers/das800.c              |   8 +-
 drivers/comedi/drivers/dmm32at.c             |   3 +-
 drivers/comedi/drivers/me4000.c              |   6 +-
 drivers/comedi/drivers/ni_at_a2150.c         |   8 +-
 drivers/comedi/drivers/ni_at_ao.c            |   8 +-
 drivers/comedi/drivers/ni_atmio16d.c         |   2 +-
 drivers/comedi/drivers/ni_daq_dio24.c        |   2 +-
 drivers/comedi/drivers/ni_labpc_common.c     |  51 +++---
 drivers/comedi/drivers/ni_mio_common.c       |  74 ++++++---
 drivers/comedi/drivers/pcl711.c              |   8 +-
 drivers/comedi/drivers/pcl724.c              |   6 +-
 drivers/comedi/drivers/pcl812.c              |  10 +-
 drivers/comedi/drivers/pcl816.c              |   8 +-
 drivers/comedi/drivers/pcl818.c              |   8 +-
 drivers/comedi/drivers/pcm3724.c             |   2 +-
 drivers/comedi/drivers/rtd520.c              |   6 +-
 include/linux/comedi/comedi_8254.h           |  51 ++++--
 include/linux/comedi/comedi_8255.h           |  24 ++-
 46 files changed, 649 insertions(+), 359 deletions(-)

