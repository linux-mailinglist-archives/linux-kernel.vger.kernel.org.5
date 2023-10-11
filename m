Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67127C5E57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376446AbjJKU0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376412AbjJKU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:26:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C73091;
        Wed, 11 Oct 2023 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697056010; x=1728592010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dE6YTAgpIUGjQqgWImfLh5Fh6tJ6lKZxZUBMMvpIri0=;
  b=HjFt7l/ILMgfeVj1xTeuzDpTI552tgynytWTU+bI3rE1+y0iEdz9CIyn
   G10o+p28IzbSpKJ7eOB1ftbw13U8AnBT9ZQExSWt8qgEC53kIO6UV16Fy
   NNb/LOISXDhzg33Wjf4iydMLNFwN6w3EwC6m9feHdWgQggBi5pJT7UhCB
   K8CPLWeVcIJAT9BryXEhOEkFuW4RZxuZkpRxXnD4Tq6wi7C6k/0q4jDjW
   bmgH2M6kdZ5rJRyt/Qq9uw6YrDLcMbf7w8OhG1/7sMJHznu/wvIjHz6gi
   zBOYKZdf4xQ9R3URxLHGKuubHsxNvtcIh5wP5akg4ipwmUHNtF8pqZ8nn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="471015144"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="471015144"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 13:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783393505"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783393505"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2023 13:26:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ED1B7430; Wed, 11 Oct 2023 23:26:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 0/4] hte: Improve GPIO handling and other cleanups
Date:   Wed, 11 Oct 2023 23:26:34 +0300
Message-Id: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series that provides a new API to GPIO library (so far only
available in the GPIO tree), and respective update to the Tegra
HTE driver. On top a couple of other cleaups (patches 3 & 4, they
can be applied separately).

Patch 2 inherited tags from its respective discussion thread [1].

Due to dependencies this either should be applied to the GPIO tree,
or to the HTE when GPIO updates land the upstream (optionally with
the first patch be applied even now to the GPIO tree independently).

Another option is to have an immutable branch or tag, but I assume
that was discussed and rejected (?) in [1].

In v2:
- collected tags (Linus, Dipen) 
- fixed couple of typos (Dipen)

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

