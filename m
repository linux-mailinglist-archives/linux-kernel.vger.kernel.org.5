Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50C7AE4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjIZFUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIZFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:20:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0FF2;
        Mon, 25 Sep 2023 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705624; x=1727241624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WwRDr25TqRIwoayNtleziPeT4USa3sxRbOwFlmDtVA=;
  b=CZ9JT25olegywqm8x8Jiqw+fQzX9YVnI+AtsguFLLGwsUtkJViJ6mECi
   N53GEu422wuwSIN1+XLYciuZ8ZbaYvxvlj5+h7O3Om2y3Bw581fy75/Za
   lfYhpE98kvsSj3vlBM3hApHYCSmnRY7duAgU23v1ahGLz6Et+F5Il05Rg
   hd7+8AD8e+CQ0PrmDVw2sdubZEHGKya+nyIpr98irnvMhyaiF0zrKMyrc
   Is6spiQUJquU3pUa2wuep9iiL5K+J9k+Zn+mdH6f5oT2nBX6CGP/xAx7S
   iXdlhcbcHV3K1ZoT5/iaMXJEgo+7M2aGdenpRfv3xwrW/Hd2hKfJLX4Qo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371820567"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="371820567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783824215"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="783824215"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Sep 2023 22:20:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D4D3311D; Tue, 26 Sep 2023 08:20:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v1 0/5] bitmap: get rid of bitmap_remap() and bitmap_biremap() uses
Date:   Tue, 26 Sep 2023 08:20:02 +0300
Message-Id: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Rasmus suggested [1], the bit remapping APIs should be local to NUMA.
However, they are being in use outside of that for a while. To make
above happen, introduces simplified APIs that can be used otherwise.

It seems we might have yet another user of the above mentioned APIs.

The last patch has not been tested anyhow (except compilation, so
all testing and comments are welcome).

The idea is to get an immutable tag (via my tree) that can be pulled
by bitmap and GPIO trees on the need (while usually I send PR to
the GPIO subsystem).

Link: https://lore.kernel.org/all/20230815235934.47782-1-yury.norov@gmail.com/ [1]

Andy Shevchenko (5):
  lib/test_bitmap: Excape space symbols when printing input string
  lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
  gpio: xilinx: Switch to use new bitmap_scatter() helper
  gpio: xilinx: Replace bitmap_bitremap() calls
  gpiolib: cdev: Utilize more bitmap APIs

 drivers/gpio/gpio-xilinx.c  | 13 ++----
 drivers/gpio/gpiolib-cdev.c | 79 +++++++++++++++++--------------------
 include/linux/bitmap.h      |  9 +++++
 lib/bitmap.c                | 70 ++++++++++++++++++++++++++++++++
 lib/test_bitmap.c           | 25 +++++++++++-
 5 files changed, 143 insertions(+), 53 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

