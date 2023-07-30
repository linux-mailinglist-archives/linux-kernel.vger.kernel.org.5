Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19D768650
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjG3P6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjG3P6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F71720;
        Sun, 30 Jul 2023 08:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E25C460C8B;
        Sun, 30 Jul 2023 15:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3117C433C7;
        Sun, 30 Jul 2023 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690732721;
        bh=kYbqEybwfpQQdm8dKaRsIM4J/bma0xsrZPDM931SxRY=;
        h=From:To:Cc:Subject:Date:From;
        b=i6AurqzOZGuzqd1FnuiSbx8W77/6uZrebwF9Mom/9wc0KVpCBftkp3P+qBguDG3j4
         hHI4bQSZUSJjDjSKdE42NAWYkDw6GdgaAKFkguLLum8cUT7rLR+cVwyJ7AcGFqdFse
         SvlLbZI4IZW03UonXGWhyB0dYzEYPMkDZhZDVwbFkamt097dAjkBqsBS5OpazV6vsQ
         ljjGSa8BNhAtm0bJaJ5Scw39iD1IwhWc6DJ6/BL9BeJXhvZfL9yJeQTIg1SfVZaPQi
         Ygi2sIz6iwYl0pSvwMifwPjnEXhe1vkKwGcYVElCxpoyiKJjx6aAu47rkbRPefkIJ1
         Pjt7nYAWixtjw==
Message-ID: <818b4c905bc295ef7b7e773ff3bbc0c5.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.5-rc3
Date:   Sun, 30 Jul 2023 16:58:30 +0100
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc3

for you to fetch changes up to cc71c42b3dc1085d3e72dfa5603e827b9eb59da1:

  spi: spi-qcom-qspi: Add mem_ops to avoid PIO for badly sized reads (2023-07-26 12:47:20 +0100)

----------------------------------------------------------------
spi: Fixes for v6.5

A bunch of fixes for the Qualcomm QSPI driver, fixing multiple issues
with the newly added DMA mode - it had a number of issues exposed when
tested in a wider range of use cases, both race condition style issues
and issues with different inputs to those that had been used in test.

----------------------------------------------------------------
Douglas Anderson (2):
      spi: spi-qcom-qspi: Fallback to PIO for xfers that aren't multiples of 4 bytes
      spi: spi-qcom-qspi: Add mem_ops to avoid PIO for badly sized reads

Vijaya Krishna Nivarthi (4):
      spi: spi-qcom-qspi: Ignore disabled interrupts' status in isr
      spi: spi-qcom-qspi: Use GFP_ATOMIC flag while allocating for descriptor
      spi: spi-qcom-qspi: Call dma_wmb() after setting up descriptors
      spi: spi-qcom-qspi: Add DMA_CHAIN_DONE to ALL_IRQS

 drivers/spi/spi-qcom-qspi.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)
