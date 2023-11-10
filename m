Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78C87E84A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbjKJUwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjKJUvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:51:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD536824C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rTDDJ39p2/9RhU5/XQUbQQVJgSZq+xnn1qxqWoHI9x4=; b=MnxFlr7vhkts8x9CK+vrb8uBHw
        yV3IBAU12521sMrM32umdbb2MX6cGbxP2MIRHt9JLRX803Yw07vA8QGC/BJn2/JhlZO7Tq6+jc0Uq
        17XPnN+a9KdNoDCMS8B2oq8COdhJbztc3YWslWvOk6baoEM6YUfjm49w5Kc2ZsuwhwS0vRYr11qR+
        KrGifuYDI+1nOEVbjumZfFxRdyqlzmsAsASoFmYi10CIqQvpSOwCEERwSyM6Kj1rNGnhLpX2rKUXE
        ISbmpp/piVpIkLlhibI8fVWpHAwlVsM/MAj3ranSOjoreBdWR04KXUceZYjzOflt9GvAzTmcVNQB1
        zakXh0vQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1LUn-007zwi-1a;
        Fri, 10 Nov 2023 07:00:01 +0000
Date:   Fri, 10 Nov 2023 07:59:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.7
Message-ID: <ZU3U759SwIC4Vv-F@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f6f76a6a29f36d2f3e4510d0bde5046672f6924:

  Merge tag 'mm-nonmm-stable-2023-11-02-14-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-11-02 20:53:31 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.7-2023-11-10

for you to fetch changes up to 53c87e846e335e3c18044c397cc35178163d7827:

  swiotlb: fix out-of-bounds TLB allocations with CONFIG_SWIOTLB_DYNAMIC (2023-11-08 16:27:05 +0100)

----------------------------------------------------------------
ma-mapping fixes for Linux 6.7

 - don't leave pages decrypted for DMA in encrypted memory setups linger
   around on failure (Petr Tesarik)
 - fix an out of bounds access in the new dynamic swiotlb code (Petr Tesarik)
 - fix dma_addressing_limited for systems with weird physical memory layouts
   (Jia He)

----------------------------------------------------------------
Jia He (2):
      dma-mapping: move dma_addressing_limited() out of line
      dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover all system RAM

Petr Tesarik (2):
      swiotlb: do not free decrypted pages if dynamic
      swiotlb: fix out-of-bounds TLB allocations with CONFIG_SWIOTLB_DYNAMIC

 include/linux/dma-mapping.h | 19 +++++--------------
 kernel/dma/direct.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.h         |  1 +
 kernel/dma/mapping.c        | 22 ++++++++++++++++++++++
 kernel/dma/swiotlb.c        | 28 ++++++++++++++++++----------
 5 files changed, 86 insertions(+), 24 deletions(-)
