Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D3F756A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGQR34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGQR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:29:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3F1716;
        Mon, 17 Jul 2023 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689614965; x=1721150965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cfXxY8OSt6dnoWrqrmzF+bK5umSU80545NZ+VPDZ5MY=;
  b=jUWdOK7rZE+3FkhptycuE6fFmLvh1SnUGqEf0Euh9UUpUBsMdsHSBgJP
   1rCePC+IjMsA8QdILB6JT7WiOjIOFW57NT8B//JemO6Gwjg0NwvRpnwIm
   LvxoFEDUNG74rSPNEnrCCX6EjDf7ehY0zijtHmBWdA2zpN1GdVurIqUCT
   mvEmMOvwq4YPtLzkoNcLMAdEusA+Yy6N7xDdWfnLwhVhjFuQO3vuOQdOE
   csf5a7wI9885m6xKtt1H0yHyj0kVy5O+wvjr8Mjw3DH5DHpIN5+O4MP8t
   1isJggQgjwx7kDc3Sva4qi4z8NtHpElgR8OWqXMLEbiZD5jy9lQqDtnb7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="350854485"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="350854485"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="813426654"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="813426654"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 10:28:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBFC1256; Mon, 17 Jul 2023 20:28:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2 00/10] pinctrl: Provide NOIRQ PM helper and use it
Date:   Mon, 17 Jul 2023 20:28:11 +0300
Message-Id: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel pin control drivers use NOIRQ variant of the PM callbacks.
Besides that several other drivers do similar. Provide a helper
to make them smaller and less error prone against different
kernel configurations (with possible defined but not used variables).

The idea is to have an immutable branch that PM tree can pull as well as
main pin control one. We also can do other way around, if Rafael prefers
that.

Changelog v2:
- rewritten commit message in patch 1 (Rafael)
- converted non-Intel pin control drivers as well
- added couple of kinda related patches to use pm_ptr()

Andy Shevchenko (10):
  pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: baytrail: Make use of pm_ptr()
  pinctrl: cherryview: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: intel: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: lynxpoint: Make use of pm_ptr()
  pinctrl: at91: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: mediatek: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: mvebu: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: renesas: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper
  pinctrl: tegra: Switch to use DEFINE_NOIRQ_DEV_PM_OPS() helper

 drivers/pinctrl/intel/pinctrl-baytrail.c      | 11 +++--------
 drivers/pinctrl/intel/pinctrl-cherryview.c    |  9 ++-------
 drivers/pinctrl/intel/pinctrl-intel.c         |  5 +----
 drivers/pinctrl/intel/pinctrl-intel.h         |  9 ++-------
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     |  7 +++----
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  5 +----
 drivers/pinctrl/mediatek/pinctrl-paris.c      |  9 +++------
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c   | 14 +++-----------
 drivers/pinctrl/pinctrl-at91.c                | 10 ++++------
 drivers/pinctrl/renesas/core.c                | 16 +++++++---------
 drivers/pinctrl/tegra/pinctrl-tegra.c         |  5 +----
 include/linux/pm.h                            |  9 +++++++++
 12 files changed, 39 insertions(+), 70 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

