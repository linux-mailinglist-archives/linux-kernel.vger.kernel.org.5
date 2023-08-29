Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E753D78C883
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjH2PXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjH2PXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:23:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E206132
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=c6EWG1bxVjUa++TxxlSM+W3U1eow2wnEJPzH8b4Pkrg=; b=CHD7lODq/UwhF2VObgV7HmMGmr
        uJFeBJUe+zvVN75a9g+YsFxGL05C5LVCcIObbFLPiDb/cMLXTHeJLK4fEZYC9csbJLekEEGsduHBc
        1dXWEg0TqF54wox4P4Sz0GNV6Ghej7/UEUKVTA3sWvNKQVkg6IeBAbRPdbYYagX0Uh6JR+wSSCch3
        jzDdUNKKezF0QsbsjHm7wno5eqb0h5J6oOL7vhImunPVw6XsvmfGMUd0BcF1bdpTsFj+afiQcfouQ
        FRZy1DPKJNp4wVrRv/vFQs2eUFXhyBMwWWqox4TGf0iHEFDUc6nHUDnw7KS4Gs1yEXku+co8L0z38
        kW8Xd/6w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qb0YZ-00BmKJ-17;
        Tue, 29 Aug 2023 15:23:03 +0000
Date:   Tue, 29 Aug 2023 17:22:57 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>
Subject: [GIT PULL] dma-mapping updates for Linux 6.6
Message-ID: <ZO4NUZ+k4Q4zPu6X@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-08-29

for you to fetch changes up to d069ed288ac74c24e2b1c294aa9445c80ed6c518:

  swiotlb: optimize get_max_slots() (2023-08-08 10:29:21 -0700)

----------------------------------------------------------------
dma-maping updates for Linux 6.6

 - allow dynamic sizing of the swiotlb buffer, to cater for secure
   virtualization workloads that require all I/O to be bounce buffered
   (Petr Tesarik)
 - move a declaration to a header (Arnd Bergmann)
 - check for memory region overlap in dma-contiguous (Binglei Wang)
 - remove the somewhat dangerous runtime swiotlb-xen enablement and
   unexport is_swiotlb_active (Christoph Hellwig, Juergen Gross)
 - per-node CMA improvements (Yajun Deng)

----------------------------------------------------------------
Arnd Bergmann (1):
      dma-mapping: move arch_dma_set_mask() declaration to header

Binglei Wang (1):
      dma-contiguous: check for memory region overlap

Christoph Hellwig (2):
      x86: always initialize xen-swiotlb when xen-pcifront is enabling
      swiotlb: unexport is_swiotlb_active

Juergen Gross (1):
      xen/pci: add flag for PCI passthrough being possible

Petr Tesarik (11):
      swiotlb: bail out of swiotlb_init_late() if swiotlb is already allocated
      swiotlb: make io_tlb_default_mem local to swiotlb.c
      swiotlb: add documentation and rename swiotlb_do_find_slots()
      swiotlb: separate memory pool data from other allocator data
      swiotlb: add a flag whether SWIOTLB is allowed to grow
      swiotlb: if swiotlb is full, fall back to a transient memory pool
      swiotlb: determine potential physical address limit
      swiotlb: allocate a new memory pool when existing pools are full
      swiotlb: search the software IO TLB only if the device makes use of it
      swiotlb: move slot allocation explanation comment where it belongs
      swiotlb: optimize get_max_slots()

Yajun Deng (2):
      dma-contiguous: support per-numa CMA for all architectures
      dma-contiguous: support numa CMA for specified node

 Documentation/admin-guide/kernel-parameters.txt |  13 +-
 arch/arm/xen/mm.c                               |  10 +-
 arch/arm64/mm/init.c                            |   2 -
 arch/mips/pci/pci-octeon.c                      |   2 +-
 arch/powerpc/kernel/dma-mask.c                  |   1 +
 arch/x86/include/asm/xen/swiotlb-xen.h          |   6 -
 arch/x86/kernel/pci-dma.c                       |  29 +-
 arch/x86/xen/setup.c                            |   6 +
 drivers/base/core.c                             |   4 +-
 drivers/pci/xen-pcifront.c                      |   6 -
 drivers/xen/swiotlb-xen.c                       |   2 +-
 include/linux/device.h                          |  10 +-
 include/linux/dma-map-ops.h                     |  12 +-
 include/linux/dma-mapping.h                     |   2 +
 include/linux/swiotlb.h                         | 131 ++++-
 include/xen/xen.h                               |   6 +
 kernel/dma/Kconfig                              |  26 +-
 kernel/dma/contiguous.c                         | 108 +++-
 kernel/dma/direct.c                             |   2 +-
 kernel/dma/mapping.c                            |   6 -
 kernel/dma/swiotlb.c                            | 698 +++++++++++++++++++++---
 mm/cma.c                                        |  10 +-
 mm/slab_common.c                                |   5 +-
 23 files changed, 910 insertions(+), 187 deletions(-)
