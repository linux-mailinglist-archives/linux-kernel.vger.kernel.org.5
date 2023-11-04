Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BD7E11CF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 00:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjKDXPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 19:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKDXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 19:15:36 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449071BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 16:15:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 539CFFF805;
        Sat,  4 Nov 2023 23:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699139728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xLB49XCT9UcobRhWosbEP65dkPvczyn1raATHvaoT30=;
        b=aOpNhOe0i7PzzwapPBZILHkSTywT1N6thWUopC5pHani+GI39WtiZQENmW2t4shwXhsx7r
        C3pRFe5boYOr0q2G2kEl1RhDb9I/MTIYAnBlDHvLArWHdT6OaMECQ/mmXhVN32Mcae9Tzt
        MStYHkqdvncw4ltbHydezIqsG8G0YIofQ8M1LsSTqzdnCju4gjav5Oszr3P9IY5QYbuiey
        xJ77JEHbSvwKSVzxNp7xkavUipBIXP3c0OBX0bdkzNuIXkLh+saBw8MkWLvGEOH5DbDVIM
        7+hpj3BwEslfFi25TieggBZHo+Zc1S7tLYUJ5meANAyNAClUXVGCMosDg0VTnQ==
Date:   Sun, 5 Nov 2023 00:15:28 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.7
Message-ID: <202311042315286247d3ae@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the i3c subsytem pull request for 6.7. There are now more fixes
because as stated in my previous pull request, people now have access to
actual hardware.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.7

for you to fetch changes up to 9fd00df05e81a2e1080ce6e9abc35533dca99d74:

  i3c: master: handle IBIs in order they came (2023-11-04 00:44:32 +0100)

----------------------------------------------------------------
I3C for 6.7

Core:
 - handle IBI in the proper order

Drivers:
 - cdns: fix status register access
 - mipi-i3c-hci: many fixes now that the driver has been actually tested
 - svc: many IBI fixes, correct compatible string, fix hot join corner cases

----------------------------------------------------------------
Billy Tsai (1):
      i3c: master: mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.

Dinghao Liu (1):
      i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs

Frank Li (7):
      i3c: master: svc: fix race condition in ibi work thread
      i3c: master: svc: fix wrong data return when IBI happen during start frame
      i3c: master: svc: fix ibi may not return mandatory data byte
      i3c: master: svc: fix check wrong status register in irq handler
      i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
      i3c: master: svc: fix random hot join failure since timeout error
      i3c: master: svc: fix compatibility string mismatch with binding doc

Jarkko Nikula (12):
      i3c: master: Inherit DMA masks and parameters from parent device
      i3c: mipi-i3c-hci: Add MODULE_ALIAS
      i3c: mipi-i3c-hci: Fix DAT/DCT entry sizes
      i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler
      i3c: mipi-i3c-hci: Remove BUG() when Ring Abort request times out
      i3c: mipi-i3c-hci: Set ring start request together with enable
      i3c: mipi-i3c-hci: Fix race between bus cleanup and interrupt
      i3c: mipi-i3c-hci: Set number of SW enabled Ring Bundles earlier
      i3c: mipi-i3c-hci: Do not unmap region not mapped for transfer
      i3c: mipi-i3c-hci: Fix missing xfer->completion in hci_cmd_v1_daa()
      i3c: mipi-i3c-hci: Resume controller explicitly
      i3c: mipi-i3c-hci: Resume controller after aborted transfer

Joshua Yeong (1):
      i3c: master: cdns: Fix reading status register

Justin Stitt (1):
      i3c: replace deprecated strncpy

Kees Cook (4):
      i3c: dw: Annotate struct dw_i3c_xfer with __counted_by
      i3c: master: cdns: Annotate struct cdns_i3c_xfer with __counted_by
      i3c/master/mipi-i3c-hci: Annotate struct hci_rings_data with __counted_by
      i3c: svc: Annotate struct svc_i3c_xfer with __counted_by

Matt Johnston (1):
      i3c: Fix typo "Provisional ID" to "Provisioned ID"

Zbigniew Lukwinski (1):
      i3c: master: handle IBIs in order they came

 Documentation/ABI/testing/sysfs-bus-i3c        |  4 +-
 Documentation/devicetree/bindings/i3c/i3c.yaml |  4 +-
 Documentation/driver-api/i3c/protocol.rst      |  4 +-
 drivers/i3c/master.c                           | 24 +++++++++--
 drivers/i3c/master/dw-i3c-master.c             |  2 +-
 drivers/i3c/master/i3c-master-cdns.c           |  8 ++--
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c       |  1 +
 drivers/i3c/master/mipi-i3c-hci/core.c         | 14 +++---
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c       | 27 ++++++++----
 drivers/i3c/master/mipi-i3c-hci/dma.c          | 21 +++++----
 drivers/i3c/master/svc-i3c-master.c            | 60 ++++++++++++++++++++++++--
 include/linux/i3c/device.h                     |  2 +-
 include/linux/i3c/master.h                     |  6 ++-
 13 files changed, 133 insertions(+), 44 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
