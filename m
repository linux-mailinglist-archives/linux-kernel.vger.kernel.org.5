Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4F80DA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbjLKTDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbjLKTDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:03:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929C7C0;
        Mon, 11 Dec 2023 11:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321417; x=1733857417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q2BczxrNZm1mBCco6sqW/QGBn/6Xmav22CnVogTYodc=;
  b=RduQeacqgb/9arZ5AqJQFik8Y/nIT4tCmYeQAn4NpAqUp6yFdRSNz9Oq
   lfgyjfXn8Wgg4rVIg/TvBVC/AUkuh9zHYMyg/cs52y6XO0H7THj9sFfy3
   7+vBQW082ekjdY8RrSZvIosmCaCQVOMO7o8o55jQjDID6fzu0w7kzbtJC
   tD3+wf+KbCR68i3wtZ/yAant2SYfp59qHnOhiixi6MYJQkeq1Vo8hJpMB
   s/OmJllyjOuH9VUPdKzhRT60S7XmvKHkFvUFKA63OF5k3J0zcWCZGib07
   sKh2B7hN/j/Rl2+WPoJrAKhofmhxHl/1uxjxNMUykUh9l520OFnsNYWWF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480893475"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="480893475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766491653"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766491653"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2023 11:03:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AFB52AB; Mon, 11 Dec 2023 21:03:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v5 00/13] pinctrl: Convert struct group_desc to use struct pingroup
Date:   Mon, 11 Dec 2023 20:57:53 +0200
Message-ID: <20231211190321.307330-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
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

NB. The function_desc is in plan to follow the similar deduplication.

This time test-compiled with old GCC 8 for arm64, besides GCC 13 and
LLVM 16 for x86_64.

In v5:
- dropped applied patches
- elaborated the need of the conversion (Fabio)
- reworked to avoid build errors on old GCC (Marek, Krzysztof, Geert)

v4: https://lore.kernel.org/r/20231129161459.1002323-1-andriy.shevchenko@linux.intel.com

In v4:
- made pins also unsigned in struct group_desc (Geert)
- made local pins variable unsigned in renesas drivers (Geert)
- collected more tags (Paul, Geert)

v3: https://lore.kernel.org/r/20231128200155.438722-1-andriy.shevchenko@linux.intel.com

In v3:
- fixed reported bug in equilibrium code (LKP)                                                                   - collected tags (Emil, Florian, Paul)

v2: https://lore.kernel.org/r/20231123193355.3400852-1-andriy.shevchenko@linux.intel.com

In v2:
- added a few patches to fix multiple compile-time errors (LKP)
- added tag (Jonathan)

v1: https://lore.kernel.org/r/20231122164040.2262742-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (13):
  pinctrl: core: Add a convenient define PINCTRL_GROUP_DESC()
  pinctrl: mediatek: Use C99 initializers in PINCTRL_PIN_GROUP()
  pinctrl: ingenic: Use C99 initializers in PINCTRL_PIN_GROUP()
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

 drivers/pinctrl/bcm/pinctrl-ns.c              |  4 +--
 drivers/pinctrl/core.c                        | 11 +++---
 drivers/pinctrl/core.h                        | 17 +++++----
 drivers/pinctrl/freescale/pinctrl-imx.c       | 31 ++++++++--------
 drivers/pinctrl/mediatek/pinctrl-moore.c      | 13 ++++---
 drivers/pinctrl/mediatek/pinctrl-moore.h      | 10 +++---
 drivers/pinctrl/mediatek/pinctrl-paris.h      | 10 +++---
 drivers/pinctrl/pinctrl-equilibrium.c         |  4 +--
 drivers/pinctrl/pinctrl-ingenic.c             | 35 ++++++++++---------
 drivers/pinctrl/pinctrl-keembay.c             |  2 +-
 drivers/pinctrl/renesas/pinctrl-rza1.c        |  2 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c        | 10 +++---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  4 +--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |  4 +--
 .../starfive/pinctrl-starfive-jh7100.c        |  8 ++---
 .../starfive/pinctrl-starfive-jh7110.c        |  8 ++---
 16 files changed, 84 insertions(+), 89 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

