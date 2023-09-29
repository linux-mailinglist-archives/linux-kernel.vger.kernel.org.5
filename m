Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB07B294E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjI2AGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2AGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:06:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796A3F3;
        Thu, 28 Sep 2023 17:06:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1B9C433C8;
        Fri, 29 Sep 2023 00:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695945997;
        bh=kX49jEUPzZ2DjHCoxms5cPSwkraOJGucVyEvtCLUo8s=;
        h=From:To:Cc:Subject:Date:From;
        b=SNwHhr7TvQVZxVRjtAtw3qsoqTS27o0XJTgtjIOFfSgUCj/0tTLoMmj+3n6bOS07a
         Jfrq9oUBgRHdqKyyAR6g6WHStZl14TQhm0J8WsogR1mKar3QKLBPkjwHi2Er4/72j9
         o/rAIF1IaKaw1+E6Yv0rS+6wjjH0yscCA9bPeWENK0MBYNc9xCl2/rMzyNHeVj/S3p
         F8glDStJ2Ue2EsY3aBF5lG30AYj99+s1x1bvRnVriIsgIsWDL4+eFw1rGPPa3YWYcr
         tUrBqnPOQ6OuIFu2+a4cjHza5PV9FGUhYRRG5ZGMd8CUnj1KM6MJRF0SyUPMpBC+3j
         sdOpKoKE126FQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.6-rc3
Date:   Thu, 28 Sep 2023 17:06:34 -0700
Message-ID: <20230929000635.1480419-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to a47b44fbb13f5e7a981b4515dcddc93a321ae89c:

  clk: tegra: fix error return case for recalc_rate (2023-09-12 10:56:05 -0700)

----------------------------------------------------------------
A bunch of clk driver fixes for issues found recently.

 - Fix the binding for versaclock3 that was introduced this merge window
   so we know what the values are for clk consumers
 - Fix a 64-bit division issue in the versaclock3 driver
 - Avoid breakage in the versaclock3 driver by rejiggering the enums
   used to layout clks
 - Fix the parent name of a clk in the Spreadtrum ums512 clk driver
 - Fix a suspend/resume issue in Skyworks Si521xx clk driver where
   regmap restoration fails because writes are wedged
 - Return zero from Tegra bpmp recalc_rate() implementation when an
   error occurs so we don't consider an error as a large rate

----------------------------------------------------------------
Biju Das (4):
      dt-bindings: clock: versaclock3: Add description for #clock-cells property
      clk: vc3: Fix 64 by 64 division
      clk: vc3: Fix output clock mapping
      clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum values

Marek Vasut (2):
      clk: si521xx: Use REGCACHE_FLAT instead of NONE
      clk: si521xx: Fix regmap write accessor

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Zhifeng Tang (1):
      clk: sprd: Fix thm_parents incorrect configuration

 .../devicetree/bindings/clock/renesas,5p35023.yaml |  11 +-
 drivers/clk/clk-si521xx.c                          |   9 +-
 drivers/clk/clk-versaclock3.c                      | 117 ++++++++++-----------
 drivers/clk/sprd/ums512-clk.c                      |   2 +-
 drivers/clk/tegra/clk-bpmp.c                       |   2 +-
 5 files changed, 72 insertions(+), 69 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
