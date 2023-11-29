Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5D7FDC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjK2QPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjK2QPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:15:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1017D67;
        Wed, 29 Nov 2023 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701274514; x=1732810514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4rJwzaKl6Nti620s0yITOjM1A5IvNX/6uM1qfPh4kAQ=;
  b=cXIZOmrtfba/oo0sglY/Z7qHJ3qJ2pJk/3RJ9YhmN6S2N6PXpyuHjTaY
   qP3Ax/aqBxU7eVBYz/mf/aCoT6p/RWwBr/YRw0MpET2ipOCydHdiQllJT
   K2fw9wvCRzz742TgZL31fTQFwoxJSxmzKGU1mY8NeKZGm19aiajpd6/tL
   0STqCKaFQo4+j7BlQOrIBZd6Phsko5AO65S5HUG/v+jR+JyctTcNmLNkr
   yctsz9AjU7Ia+RNiJTi3mLh9wYtm7tXcSSfqnvh1bPNJ/BKA1o/KSvRW6
   P9+F9k+62fwgQwcQZ35NiTKDihBQi1hOWcvbAXgbxwL0TCl5K+w+lPqME
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373372551"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373372551"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 08:15:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892498851"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="892498851"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2023 08:15:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F65D4D4; Wed, 29 Nov 2023 18:15:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v4 00/23] pinctrl: Convert struct group_desc to use struct pingroup
Date:   Wed, 29 Nov 2023 18:06:23 +0200
Message-ID: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct group_desc has a lot of duplication with struct pingroup.
Deduplicate that by embeddind the latter in the former and convert
users.

Linus, assuming everything is fine, I can push this to my tree.
Or you can apply it (assumming all CIs and people are happy with
the series).

NB. It seems to me that GCC 7.x has an issue when compound literal
is being assigned to a constant object. I believe it's a false positive
(at least I can't reproduce this with recent GCC and LLVM and hence
I haven't touched the code in order to address this.

NB. This series contains previously sent patches for Qualcomm and
Nuvoton. Here the updated version for Qualcomm that splits previous
patch to two and fixes compilation warnings.

NB. The function_desc is in plan to follow the similar deduplication.

In v4:
- made pins also unsigned in struct group_desc (Geert)
- made local pins variable unsigned in renesas drivers (Geert)
- collected more tags (Paul, Geert)

v3: https://lore.kernel.org/r/20231128200155.438722-1-andriy.shevchenko@linux.intel.com

In v3:
- fixed reported bug in equilibrium code (LKP)
- collected tags (Emil, Florian, Paul)

v2: https://lore.kernel.org/r/20231123193355.3400852-1-andriy.shevchenko@linux.intel.com

In v2:
- added a few patches to fix multiple compile-time errors (LKP)
- added tag (Jonathan)

v1: https://lore.kernel.org/r/20231122164040.2262742-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (23):
  pinctrl: qcom: lpass-lpi: Replace kernel.h with what is being used
  pinctrl: qcom: lpass-lpi: Remove unused member in struct lpi_pingroup
  pinctrl: equilibrium: Unshadow error code of
    of_property_count_u32_elems()
  pinctrl: equilibrium: Use temporary variable to hold pins
  pinctrl: imx: Use temporary variable to hold pins
  pinctrl: core: Make pins const unsigned int pointer in struct
    group_desc
  pinctrl: equilibrium: Convert to use struct pingroup
  pinctrl: keembay: Convert to use struct pingroup
  pinctrl: nuvoton: Convert to use struct pingroup and
    PINCTRL_PINGROUP()
  pinctrl: core: Add a convenient define PINCTRL_GROUP_DESC()
  pinctrl: ingenic: Make use of PINCTRL_GROUP_DESC()
  pinctrl: mediatek: Make use of PINCTRL_GROUP_DESC()
  pinctrl: core: Embed struct pingroup into struct group_desc
  pinctrl: bcm: Convert to use grp member
  pinctrl: equilibrium: Convert to use grp member
  pinctrl: imx: Convert to use grp member
  pinctrl: ingenic: Convert to use grp member
  pinctrl: keembay: Convert to use grp member
  pinctrl: mediatek: Convert to use grp member
  pinctrl: renesas: Convert to use grp member
  pinctrl: starfive: Convert to use grp member
  pinctrl: core: Remove unused members from struct group_desc
  pinctrl: Convert unsigned to unsigned int

 drivers/pinctrl/bcm/pinctrl-ns.c              |  4 +-
 drivers/pinctrl/core.c                        | 41 ++++++++---------
 drivers/pinctrl/core.h                        | 33 ++++++++------
 drivers/pinctrl/devicetree.c                  |  8 ++--
 drivers/pinctrl/freescale/pinctrl-imx.c       | 44 +++++++++----------
 drivers/pinctrl/mediatek/pinctrl-moore.c      | 13 +++---
 drivers/pinctrl/mediatek/pinctrl-moore.h      |  7 +--
 drivers/pinctrl/mediatek/pinctrl-paris.h      |  7 +--
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c     |  9 ++--
 drivers/pinctrl/pinconf-generic.c             | 16 +++----
 drivers/pinctrl/pinconf.c                     | 14 +++---
 drivers/pinctrl/pinconf.h                     | 10 ++---
 drivers/pinctrl/pinctrl-equilibrium.c         | 42 +++++++++---------
 drivers/pinctrl/pinctrl-ingenic.c             | 27 +++++-------
 drivers/pinctrl/pinctrl-keembay.c             |  6 +--
 drivers/pinctrl/pinctrl-utils.c               | 26 +++++------
 drivers/pinctrl/pinctrl-utils.h               | 18 ++++----
 drivers/pinctrl/pinmux.c                      | 36 +++++++--------
 drivers/pinctrl/pinmux.h                      | 20 ++++-----
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h      |  6 +--
 .../pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c   | 16 -------
 .../pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c | 20 ---------
 .../pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c   | 20 ---------
 .../pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c   | 15 -------
 .../pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 16 -------
 .../pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c   | 24 ----------
 .../pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c   | 24 ----------
 .../pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c   | 24 ----------
 drivers/pinctrl/renesas/pinctrl-rza1.c        |  2 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c        | 10 ++---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  6 +--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |  6 +--
 .../starfive/pinctrl-starfive-jh7100.c        |  8 ++--
 .../starfive/pinctrl-starfive-jh7110.c        |  8 ++--
 include/linux/pinctrl/machine.h               |  6 +--
 include/linux/pinctrl/pinconf-generic.h       | 10 ++---
 include/linux/pinctrl/pinconf.h               | 16 +++----
 include/linux/pinctrl/pinctrl.h               | 24 +++++-----
 include/linux/pinctrl/pinmux.h                | 22 +++++-----
 39 files changed, 242 insertions(+), 422 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

