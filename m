Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D207B7D5486
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjJXO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJXO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:57:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABA93;
        Tue, 24 Oct 2023 07:57:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EC5C433C7;
        Tue, 24 Oct 2023 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698159467;
        bh=s/VUvPIvocwydre8aEQCLcJ68J8VdRol0E4B7DLzRHc=;
        h=Date:From:To:Subject:Cc:From;
        b=Ctp1TyfPYbWe/9XLLyWuwjW0W1A5VQslCYUYCixU9MHE7zrerhGEzK+3mF3L45BgJ
         vpU9D4fBG7s73jxIkoox69gPatUnQBW0+IaL2KH2tTl3Td99AJsIyNGoT//xJ3L0js
         H+MiUgrO3esFi2QCw/nFYNwTZ653d1nN1U9v8AAtHl5BjGjZEDnHyj/y4LuVtmvRUx
         nrpDgJYbNpYx8GVlbQtBIjngsm6zW0hrWKGCHnl3xVjBtBIVRD6hXvOeht2zLpYalm
         lkFnKNoONNxvxcqgu8pISkNCtT8m7QTxGoUulhVYgvJ9tfgkebvHNRTtc9bwEr+LfG
         8AaJ560a+H42w==
Message-ID: <ca22c9b7-ad60-4a64-8460-bab57fdc3d9b@kernel.org>
Date:   Tue, 24 Oct 2023 23:57:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] devfreq next for 6.7
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v6.7. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.7

for you to fetch changes up to 8f0cd531ee18c70f4655112c49f3c3e329636e7f:

  dt-bindings: devfreq: event: rockchip,dfi: Add rk3588 support (2023-10-19 21:27:11 +0900)

----------------------------------------------------------------
Update devfreq next for v6.7

Detailed description for this pull request:
1. Update devfreq core
- Switch to dev_pm_opp_find_freq_(ceil/floor)_indexed() APIs
 to support the specific device like UFS which handle the multiple clocks
 through OPP (Operationg Performance Point) framework.

2. Update the devfreq / devfreq-event drivers
- Add perf support to the Rockchip DFI(DDR Monitor Module) devfreq-event driver.
: Generalize rockchip-dfi.c to support new RK3568/RK3588 using different DDR type.
: Covert devicetree bidning document format to yaml.
: DFI is a unit which is suitable for measuring DDR utilization
  for the DDR frequency scaling driver. Add perf support feature
  to rockchip-dfi.c to extend DFI usage. The perf support has been tested
  on a RK3568 and a RK3399.

- Protect the OPP handling code in critical section
  because the voltage of shared OPP might be changed by multiple drivers
  on Mediatek CCI devfreq driver.

- Use device_get_match_data() on Samsung Exynos PPMU devfreq-event driver.

----------------------------------------------------------------
Dan Carpenter (1):
      PM / devfreq: mediatek: unlock on error in mtk_ccifreq_target()

Manivannan Sadhasivam (1):
      PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs

Mark Tseng (1):
      PM / devfreq: mediatek: protect oop in critical session

Rob Herring (1):
      PM / devfreq: exynos-ppmu: Use device_get_match_data()

Sascha Hauer (22):
      PM / devfreq: rockchip-dfi: Make pmu regmap mandatory
      PM / devfreq: rockchip-dfi: Embed desc into private data struct
      PM / devfreq: rockchip-dfi: use consistent name for private data struct
      PM / devfreq: rockchip-dfi: Add SoC specific init function
      PM / devfreq: rockchip-dfi: dfi store raw values in counter struct
      PM / devfreq: rockchip-dfi: Use free running counter
      PM / devfreq: rockchip-dfi: introduce channel mask
      PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE defines
      PM / devfreq: rockchip-dfi: Clean up DDR type register defines
      PM / devfreq: rockchip-dfi: Add RK3568 support
      PM / devfreq: rockchip-dfi: Handle LPDDR2 correctly
      PM / devfreq: rockchip-dfi: Handle LPDDR4X
      PM / devfreq: rockchip-dfi: Pass private data struct to internal functions
      PM / devfreq: rockchip-dfi: Prepare for multiple users
      PM / devfreq: rockchip-dfi: give variable a better name
      PM / devfreq: rockchip-dfi: Add perf support
      PM / devfreq: rockchip-dfi: make register stride SoC specific
      PM / devfreq: rockchip-dfi: account for multiple DDRMON_CTRL registers
      PM / devfreq: rockchip-dfi: add support for RK3588
      dt-bindings: devfreq: event: convert Rockchip DFI binding to yaml
      dt-bindings: devfreq: event: rockchip,dfi: Add rk3568 support
      dt-bindings: devfreq: event: rockchip,dfi: Add rk3588 support

 .../bindings/devfreq/event/rockchip,dfi.yaml       |  74 ++
 .../bindings/devfreq/event/rockchip-dfi.txt        |  18 -
 .../memory-controllers/rockchip,rk3399-dmc.yaml    |   2 +-
 drivers/devfreq/devfreq.c                          |  14 +-
 drivers/devfreq/event/exynos-ppmu.c                |  13 +-
 drivers/devfreq/event/rockchip-dfi.c               | 814 ++++++++++++++++++---
 drivers/devfreq/mtk-cci-devfreq.c                  |   9 +-
 drivers/devfreq/rk3399_dmc.c                       |  10 +-
 include/soc/rockchip/rk3399_grf.h                  |   9 +-
 include/soc/rockchip/rk3568_grf.h                  |  13 +
 include/soc/rockchip/rk3588_grf.h                  |  18 +
 include/soc/rockchip/rockchip_grf.h                |  18 +
 12 files changed, 854 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
 delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
 create mode 100644 include/soc/rockchip/rk3568_grf.h
 create mode 100644 include/soc/rockchip/rk3588_grf.h
 create mode 100644 include/soc/rockchip/rockchip_grf.h
