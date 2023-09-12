Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7F79D9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbjILTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjILTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:52:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3309115;
        Tue, 12 Sep 2023 12:52:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7CFC433C8;
        Tue, 12 Sep 2023 19:52:39 +0000 (UTC)
Date:   Tue, 12 Sep 2023 21:52:36 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.6-rc2
Message-ID: <ZQDBhMmGlXPll86B@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some parisc architecture fixes and enhancements for kernel 6.6-rc2.

* Fix a module symbol resolving issue on parisc64
* Some sparse and build-warning fixes
* Enable Block-TLBs on 32-bit CPUs

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 6c1b980a7e79e55e951b4b2c47eefebc75071209:

  Merge tag 'dma-mapping-6.6-2023-08-29' of git://git.infradead.org/users/hch/dma-mapping (2023-08-29 20:32:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc2

for you to fetch changes up to 08700ec705043eb0cee01b35cf5b9d63f0230d12:

  linux/export: fix reference to exported functions for parisc64 (2023-09-12 17:42:00 +0200)

----------------------------------------------------------------
parisc architecture fixes and enhancements for kernel v6.6-rc2:

* fix reference to exported symbols for parisc64 [Masahiro Yamada]
* Block-TLB (BTLB) support on 32-bit CPUs
* sparse and build-warning fixes

----------------------------------------------------------------
Helge Deller (14):
      parisc: sba_iommu: Fix build warning if procfs if disabled
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: sba-iommu: Fix sparse warnigs
      parisc: ccio-dma: Fix sparse warnings
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning
      parisc: shmparam.h: Document aliasing requirements of PA-RISC
      parisc: Prepare for Block-TLB support on 32-bit kernel
      parisc: BTLB: Clear possibly existing BTLB entries
      parisc: BTLB: Add BTLB insert and purge firmware function wrappers
      parisc: BTLB: _edata symbol has to be page aligned for BTLB support
      parisc: firmware: Simplify calling non-PA20 functions
      parisc: BTLB: Initialize BTLB tables at CPU startup

Masahiro Yamada (1):
      linux/export: fix reference to exported functions for parisc64

 arch/parisc/include/asm/cache.h     |  1 +
 arch/parisc/include/asm/mckinley.h  |  8 -----
 arch/parisc/include/asm/pdc.h       |  5 +--
 arch/parisc/include/asm/processor.h |  1 +
 arch/parisc/include/asm/ropes.h     |  7 ++--
 arch/parisc/include/asm/shmparam.h  | 15 ++++++++
 arch/parisc/kernel/asm-offsets.c    |  2 ++
 arch/parisc/kernel/cache.c          |  8 +----
 arch/parisc/kernel/drivers.c        |  2 +-
 arch/parisc/kernel/firmware.c       | 56 +++++++++++++++++++++++------
 arch/parisc/kernel/head.S           | 16 +++++++--
 arch/parisc/kernel/irq.c            |  2 +-
 arch/parisc/kernel/processor.c      |  2 ++
 arch/parisc/kernel/vmlinux.lds.S    |  1 +
 arch/parisc/mm/init.c               | 72 +++++++++++++++++++++++++++++++++++++
 drivers/char/agp/parisc-agp.c       |  2 --
 drivers/parisc/ccio-dma.c           | 18 +++++-----
 drivers/parisc/iommu-helpers.h      |  8 ++---
 drivers/parisc/iosapic.c            |  4 +--
 drivers/parisc/iosapic_private.h    |  4 +--
 drivers/parisc/sba_iommu.c          | 38 +++++++++-----------
 include/linux/export-internal.h     |  2 ++
 scripts/mod/modpost.c               |  9 +++++
 23 files changed, 207 insertions(+), 76 deletions(-)
 delete mode 100644 arch/parisc/include/asm/mckinley.h
