Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046A07C0041
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjJJPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:18:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2CA2C4;
        Tue, 10 Oct 2023 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696951130; x=1728487130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nlNBWQ2A0/Oiqs4e9gC1rp7hpzNQKUXy0oakOEFBbE4=;
  b=nJDi/hrazicKUOC8jJ3lQC8okCUc0Fvwf8ABNvFlJ9Kgkkef3tAETKs0
   oTOyHkwLW9rjuDf3yp+2Iy/G9/XlAarim1QSqRwgsSzRoKyP7q63bQQm6
   D8Sn1e9n/vJMQCv4Z0Ou8zztp64gj+JRg3BGUKylkuvbt+WRonZKCNjD6
   Jla3Gr4RObCPCAaeY1qWGgIt5imZjMXGEmLaD6maPXrMmuo0jJ3BuLqFc
   XIB+xyzwxZIYmlqrdV5jMqUa5ke2nqkXIaszAAz9tSatJdyBTf+BUunC3
   OFuryL0jqMYyBV6WZ6le7q3aEs+kM/gmHtQS60tBYNzIvv74Oua767aUE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415439407"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="415439407"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1084830072"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1084830072"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2023 08:17:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2801135A; Tue, 10 Oct 2023 18:17:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 0/4] hte: Improve GPIO handling and other cleanups
Date:   Tue, 10 Oct 2023 18:17:05 +0300
Message-Id: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series provides a new API to GPIO library (so far only
available in the GPIO tree), and respective update to the Tegra
HTE driver. On top a couple of other cleaups (patches 3 & 4, they
can be applied separately).

Patch 2 inherited tags from its respective discussion thread [1],
but I believe the Tested-by needs to be confirmed again.

Due to dependencies this either should be applied to the GPIO tree,
or to the HTE when GPIO updates land the upstream (optionally with
the first patch be applied even now to the GPIO tree independently).

Another option is to have an immutable branch or tag, but I assume
that was discussed and rejected (?) in [1].

Link: https://lore.kernel.org/linux-gpio/20230905185309.131295-15-brgl@bgdev.pl/ [1]
Cc: Dipen Patel <dipenp@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

Andy Shevchenko (3):
  gpiolib: provide gpio_device_find_by_fwnode()
  hte: tegra194: Remove redundant dev_err()
  hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()

Bartosz Golaszewski (1):
  hte: tegra194: don't access struct gpio_chip

 drivers/gpio/gpiolib.c      | 20 ++++++++++++++++
 drivers/hte/hte-tegra194.c  | 46 +++++++++++++++++++------------------
 include/linux/gpio/driver.h |  1 +
 3 files changed, 45 insertions(+), 22 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

