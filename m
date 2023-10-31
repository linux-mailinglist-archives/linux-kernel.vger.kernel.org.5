Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82EB7DCAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbjJaK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343640AbjJaK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:27:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0991BA1;
        Tue, 31 Oct 2023 03:27:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA9CC433C8;
        Tue, 31 Oct 2023 10:27:21 +0000 (UTC)
Date:   Tue, 31 Oct 2023 11:27:18 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.7-rc1
Message-ID: <ZUDWhieODHLXVZf0@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the fixes and updates for the parisc architecture for 6.7-rc1:

Usual fixes and updates:
* Add up to 12 nops after TLB inserts for PA8x00 CPUs as the specification
  requires (Dave Anglin)
* Simplify the parisc smp_prepare_boot_cpu() code (Russell King)
* Use 64-bit little-endian values in SBA IOMMU PDIR table for AGP

Since there is upcoming support for booting a 64-bit kernel on QEMU,
some corner cases were fixed and improvements added:
* Fix 64-bit kernel crash in STI (graphics console) font setup code
* Support building an uncompressed Linux kernel
* Add support for soft power-off in qemu

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc1

for you to fetch changes up to 8a32aa17c1cd48df1ddaa78e45abcb8c7a2220d6:

  fbdev: stifb: Make the STI next font pointer a 32-bit signed offset (2023-10-30 14:54:41 +0100)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.7-rc1:

- Add nop instructions after TLB inserts for PA8x00 CPUs
- Fix a 64-bit kernel crash in STI font routines which miscalculates
  the font start address as it gets signed vs unsigned offsets wrong
- Support building an uncompressed Linux kernel
- Simplify smp_prepare_boot_cpu() function
- Support for soft power-off in qemu
- Use 64-bit little-endian values in SBA IOMMU PDIR table for AGP

----------------------------------------------------------------
Helge Deller (11):
      parisc: sba-iommu: Fix comment when calculating IOC number
      parisc: Add some missing PDC functions and constants
      parisc: Allow building uncompressed Linux kernel
      parisc/power: Add power soft-off when running on qemu
      parisc/power: Trivial whitespace cleanups and license update
      parisc: Move parisc_narrow_firmware variable to header file
      parisc/firmware: Use PDC constants for narrow/wide firmware
      parisc/agp: Use 64-bit LE values in SBA IOMMU PDIR table
      parisc/pdc: Add width field to struct pdc_model
      parisc: Show default CPU PSW.W setting as reported by PDC
      fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

John David Anglin (1):
      parisc: Add nop instructions after TLB inserts

Russell King (Oracle) (1):
      parisc: simplify smp_prepare_boot_cpu()

 arch/parisc/Kconfig                 |  1 +
 arch/parisc/boot/Makefile           |  2 +-
 arch/parisc/include/asm/processor.h |  1 +
 arch/parisc/include/uapi/asm/pdc.h  | 28 ++++++++++++-
 arch/parisc/kernel/drivers.c        |  4 +-
 arch/parisc/kernel/entry.S          | 81 ++++++++++++++++++++++++-------------
 arch/parisc/kernel/firmware.c       | 14 +++----
 arch/parisc/kernel/processor.c      |  6 +--
 arch/parisc/kernel/setup.c          |  3 --
 arch/parisc/kernel/smp.c            |  8 +---
 drivers/char/agp/parisc-agp.c       | 16 ++++----
 drivers/parisc/power.c              | 67 +++++++++++++-----------------
 drivers/parisc/sba_iommu.c          |  2 +-
 include/video/sticore.h             |  2 +-
 14 files changed, 133 insertions(+), 102 deletions(-)
