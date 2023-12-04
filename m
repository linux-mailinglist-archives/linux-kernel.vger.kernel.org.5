Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA8803963
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbjLDQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344576AbjLDQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:00:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C988695;
        Mon,  4 Dec 2023 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701705649; x=1733241649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=goDby2BKVdPOi8LfllK5RKnXl6OkHzWAfmtHBKbAvNU=;
  b=l7U/UvABP4StHz5OQjt3TUld7R9jmFb5uQYsTqMVzWPTbB6e1gghD2a+
   eyfJvxi8EnB2AgUNYsdcBr0LN2jnunuPc/IsYNvn/XTZobNwhNxsVsyf3
   3Kuj0xuNGQegn3Y0w8odROCmCvrnnouiprwe9Rxc57y6VvY1qUqg45XZm
   1+3BzJzvay61U7QdRYEo/ovik3Ek3CWM3qPyakqnEftBwuHDPicVUCe40
   7RHse9GHvatQ1qT/paNvw8591KzCRBx3vokQfQbY59yEyOAAFkbNmGOBy
   YcvYqPVuMkVN+YoidMLaQeOD7o1tQOTRsSubza4TeXGXrT/NyLnIdSaad
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392626605"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="392626605"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 08:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836625915"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836625915"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2023 08:00:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E6219368; Mon,  4 Dec 2023 18:00:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org
Cc:     Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Subject: [PATCH v1 0/5] pinctrl: Use struct pingroup and PINCTRL_PINGROUP()
Date:   Mon,  4 Dec 2023 17:56:31 +0200
Message-ID: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com>
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

This is an excerpt from v4 of the "pinctrl: Convert struct group_desc
to use struct pingroup" [1]. The series has been compiled with GCC 8
for ARM64 besides x86_64 GCC 13 and LLVM 16.

Changelog to the mother series [1]:
- added a new patch against Renesas code, so no warnings will be seen

Link: https://lore.kernel.org/r/20231129161459.1002323-1-andriy.shevchenko@linux.intel.com [1]

Andy Shevchenko (5):
  pinctrl: renesas: Mark local variable with const in ->set_mux()
  pinctrl: core: Make pins const unsigned int pointer in struct
    group_desc
  pinctrl: equilibrium: Convert to use struct pingroup
  pinctrl: keembay: Convert to use struct pingroup
  pinctrl: nuvoton: Convert to use struct pingroup and
    PINCTRL_PINGROUP()

 drivers/pinctrl/core.c                    |  2 +-
 drivers/pinctrl/core.h                    |  4 ++--
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c |  9 ++++----
 drivers/pinctrl/pinctrl-equilibrium.c     | 26 +++++++++++------------
 drivers/pinctrl/pinctrl-keembay.c         |  4 ++--
 drivers/pinctrl/renesas/pinctrl-rzg2l.c   |  2 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c   |  2 +-
 7 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

