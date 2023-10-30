Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03BF7DBB67
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjJ3OIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3OIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:08:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C589B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZvVwMmMCo28cYULH2hI7U9noh43qi+Y+r47o/gBi8K0=; b=2W2T4tXsXA3+MrRnsZ/2CgXlHA
        0vbu6ddViciW4oH3aa2bWbnOK4P80TAkVwLSgZUD2EDRx1xfz9T8PUCFfea5z6cYpNUVKWoOtQkKH
        qm+IgSkFJOp9MrHtkCJ0RLgJjxXbF4eQik3BQveFC3aOugRNA5eX2J5WMRvRsdx1aRry+HFjlNSt7
        LE707TBWKbeKhAPSsubvOh9jWxWIwtxLHPer7faI7tv+HZMLB4pAFWmZaiTUqO6hVjs1YQ37tpHKj
        XKhloJjzEroXhPindG89xH/KnK5pDXloztrjgIg/2QJ9O/Rzk5p7zv0uXfSSRNCPovGJfeNiJKVXm
        e/Ctj/9A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxSwd-003SqF-36;
        Mon, 30 Oct 2023 14:08:44 +0000
Date:   Mon, 30 Oct 2023 15:08:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.7
Message-ID: <ZT-46QZiN8b37Swy@infradead.org>
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

Hi Linus,

the Kconfig dependencies added in this branch caught configuration issues
in a riscv platform.  The fixes for that went into th soc tree, so it
if you want to avoid them it might make sense to pull this branch after
the soc tree.

The following changes since commit ce55c22ec8b223a90ff3e084d842f73cfba35588:

  Merge tag 'net-6.6-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-10-19 12:08:18 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-10-30

for you to fetch changes up to 36d91e851598a9ea523ad4681dd11fa661d59695:

  dma-debug: Fix a typo in a debugging eye-catcher (2023-10-23 07:52:54 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 6.7

 - get rid of the fake support for coherent DMA allocation on coldfire with
   caches (Christoph Hellwig)
 - add a few Kconfig dependencies so that Kconfig catches the use of
   invalid configurations (Christoph Hellwig)
 - fix a type in dma-debug output (Chuck Lever)
 - rewrite a comment in swiotlb (Sean Christopherson)

----------------------------------------------------------------
Christoph Hellwig (8):
      dma-direct: add dependencies to CONFIG_DMA_GLOBAL_POOL
      dma-direct: add a CONFIG_ARCH_HAS_DMA_ALLOC symbol
      dma-direct: simplify the use atomic pool logic in dma_direct_alloc
      dma-direct: warn when coherent allocations aren't supported
      m68k: use the coherent DMA code for coldfire without data cache
      net: fec: use dma_alloc_noncoherent for data cache enabled coldfire
      m68k: don't provide arch_dma_alloc for nommu/coldfire
      m68k: remove unused includes from dma.c

Chuck Lever (1):
      dma-debug: Fix a typo in a debugging eye-catcher

Sean Christopherson (1):
      swiotlb: rewrite comment explaining why the source is preserved on DMA_FROM_DEVICE

 arch/arm/Kconfig                          |  1 +
 arch/m68k/Kconfig                         |  6 +--
 arch/m68k/Kconfig.cpu                     | 12 +++++
 arch/m68k/kernel/Makefile                 |  2 +-
 arch/m68k/kernel/dma.c                    | 34 +-----------
 arch/parisc/Kconfig                       |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 86 +++++++++++++++++++++++++++----
 kernel/dma/Kconfig                        | 11 ++++
 kernel/dma/debug.c                        |  2 +-
 kernel/dma/direct.c                       | 37 +++++--------
 kernel/dma/swiotlb.c                      | 12 +++--
 11 files changed, 127 insertions(+), 77 deletions(-)
