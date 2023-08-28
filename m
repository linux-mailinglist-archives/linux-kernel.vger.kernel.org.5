Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF078A9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjH1KR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjH1KRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0123139
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:17:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D091963753
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4442CC433C7;
        Mon, 28 Aug 2023 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693217855;
        bh=D8lbxUCmnjlNeiSvHX7YwwU43j6s9LhFhNh6liRpGHA=;
        h=From:To:Cc:Subject:Date:From;
        b=ooZuxcOcsWYv+vWGgXSttwZJEFwAK/LoE0cPA8Q8VZNbN6EaKeLclRxN1DKauURMP
         8I0EutuCH5Y22WkFv1uze5vqooN47xME4CtQHtyOcbc6VizNJRhJXMaDRnj1rc3p7d
         PmQLGUkKVdn05hVBoz9PwMgb/jHeLYUUiMm8Io51hYULQ2yJxPc96jMNCOh3z8mfih
         ztPUkugp+Dc0GHmethggJMq1jai8TxaBOmtkMudqYsn8CaRmpQzUF+2Ojb1g/Jbq2g
         oWeIsMG4UWNEny46PgtlrFfspzeIXlAQSZiKsrebsmJyy8Ap7zsPVRggYPZ2wS39Cn
         XRkOgqMYHYF7g==
Message-ID: <32ff61b399fada600de5cb9ce363fa9d.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.6
Date:   Mon, 28 Aug 2023 11:17:18 +0100
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.6

for you to fetch changes up to 5d481ddb6a731281238b6a064c719a91f0234b0c:

  regmap: Merge up fixes from Linus' tree (2023-07-30 23:35:45 +0100)

----------------------------------------------------------------
regmap: Updates for v6.6

This is a much quieter release than the past few, there's one small API
addition that I noticed a user for in ALSA and a bunch of cleanups:

 - Provide an interface for determining if a register is present in the
   cache and add a user of it in ALSA.
 - Full support for dynamic allocations, following the temporary bodges
   that were done as fixes in the previous release.
 - Remove the unused and questionably working 64 bit support.

----------------------------------------------------------------
Andy Shevchenko (3):
      regmap: Revert "add 64-bit mode support" and Co.
      regmap: cache: Revert "Add 64-bit mode support"
      regmap: mmio: Remove unused 64-bit support code

Christophe JAILLET (1):
      regmap: Fix the type used for a bitmap pointer

Dan Carpenter (1):
      regmap: rbtree: Use alloc_flags for memory allocations

Guenter Roeck (2):
      regmap: Reject fast_io regmap configurations with RBTREE and MAPLE caches
      regmap: maple: Use alloc_flags for memory allocations

Mark Brown (7):
      regmap: Provide user selectable option to enable regmap
      regmap: Let users check if a register is cached
      regmap: Provide test for regcache_reg_present()
      ALSA: hda: Use regcache_reg_cached() rather than open coding
      regmap: Remove dynamic allocation warnings for rbtree and maple
      regmap: Merge up fixes from mainline
      regmap: Merge up fixes from Linus' tree

 drivers/base/regmap/Kconfig                  |  12 ++-
 drivers/base/regmap/regcache-maple.c         |  16 ++--
 drivers/base/regmap/regcache-rbtree.c        |  12 +--
 drivers/base/regmap/regcache.c               |  38 +++++----
 drivers/base/regmap/regmap-kunit.c           |  40 +++++++++
 drivers/base/regmap/regmap-mmio.c            |  24 ------
 drivers/base/regmap/regmap.c                 | 122 ---------------------------
 include/linux/regmap.h                       |   1 +
 sound/hda/hdac_regmap.c                      |   9 +-
 tools/testing/kunit/configs/all_tests.config |   2 +
 10 files changed, 94 insertions(+), 182 deletions(-)
