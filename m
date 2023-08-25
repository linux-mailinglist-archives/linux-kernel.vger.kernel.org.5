Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F729789025
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHYVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjHYVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:08:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E6F2136;
        Fri, 25 Aug 2023 14:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCEB62CEA;
        Fri, 25 Aug 2023 21:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E1FC433C7;
        Fri, 25 Aug 2023 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692997729;
        bh=ARe4eaJDMUfyUJaaKSUTVZX4MA/XIiNgJzSti8DsjBU=;
        h=From:To:Cc:Subject:Date:From;
        b=hOA+NTLTETSlkdS2nikHS0TRZNk6ELgOTGjqnRh0mi6qrOhr+bjr71QLHK68jxkN7
         1QfrU+8rUE3t58QNJy2M6yIIJ+4xprYgxbIJsAz2bYgGrJ6SwtkITpnb8G8Pcr9Wbb
         rQVVV5OLqJZvIP3/xsVZqySAQJwh0ABWulBjIHoJxO0mqsxeGcyfOQzB0BgOTeC0kY
         x1tzpszqIvsnA35jHRMCGuULlXkWVcHkFvNbuOxydoYhFg+bbGUHNswnLFJ4xekiPX
         vz9cVpY0Ye608gDW9sTpbBNix+85tiv8yYlHlB/PgbPKk6qkn7XLt62YKcxuWqaHmw
         311XTmI4/nKUA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.5-rc7
Date:   Fri, 25 Aug 2023 14:08:46 -0700
Message-ID: <20230825210848.1209346-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae9b14582ad03abb3db66ba3f8dc5ca443ff54a1:

  Merge tag 'clk-meson-fixes-v6.5-1' of https://github.com/BayLibre/clk-meson into clk-fixes (2023-07-26 11:47:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 66fbfb35da47f391bdadf9fa7ceb88af4faa9022:

  clk: Fix slab-out-of-bounds error in devm_clk_release() (2023-08-22 15:25:18 -0700)

----------------------------------------------------------------
One clk driver fix and two clk framework fixes

 - Fix an OOB access when devm_get_clk_from_child() is used and
   devm_clk_release() casts the void pointer to the wrong type
 - Move clk_rate_exclusive_{get,put}() within the correct ifdefs in
   clk.h so that the stubs are used when CONFIG_COMMON_CLK=n
 - Register the proper clk provider function depending on the value of
   #clock-cells in the TI keystone driver

----------------------------------------------------------------
Andrey Skvortsov (1):
      clk: Fix slab-out-of-bounds error in devm_clk_release()

Biju Das (1):
      clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'

Francesco Dolcini (1):
      clk: keystone: syscon-clk: Fix audio refclk

 drivers/clk/clk-devres.c          | 13 ++++---
 drivers/clk/keystone/syscon-clk.c |  6 ++-
 include/linux/clk.h               | 80 +++++++++++++++++++--------------------
 3 files changed, 51 insertions(+), 48 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
