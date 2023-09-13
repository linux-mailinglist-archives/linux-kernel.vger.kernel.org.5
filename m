Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783FA79EFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjIMRH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIMRH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:07:26 -0400
Received: from smtp118.iad3a.emailsrvr.com (smtp118.iad3a.emailsrvr.com [173.203.187.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733DDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694624841;
        bh=euqjwZb6dubS+43EgVReoNYE3c5GNQw3CY5eKNN0B9c=;
        h=From:To:Subject:Date:From;
        b=NTsMs/ploqtjbtwZI1JcAX0PSRFmdrZ/tTs6s8MQO5X4F7vWVPkqPJoDJfR6ltebV
         +shAqwBEEGWj/Sc7XbBbR2JbZhAz+HObk4SA4PNkBg5lQrDBFMLOjK3fSfFeT+7x/v
         kVS4JLLcx+yS2EoGpSD2VcseY5f0zE50FPc8nasA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7C6C94343;
        Wed, 13 Sep 2023 13:07:20 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 00/13] comedi: Re-do HAS_IOPORT dependencies
Date:   Wed, 13 Sep 2023 18:06:59 +0100
Message-Id: <20230913170712.111719-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913164013.107520-1-abbotti@mev.co.uk>
References: <20230913164013.107520-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 19793052-af61-4898-a406-82596fa230be-1-1
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

======

v3:

0. Patch titles and numbering is unchanged since v2.

1. Adds missing `---` divider lines before patch changelogs for patches
06 and 09.

2. The 'In-Reply-To:' and 'References:' email headers were incorrect in
the v2 series.
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

