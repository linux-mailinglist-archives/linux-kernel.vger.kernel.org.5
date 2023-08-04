Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9B770353
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjHDOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjHDOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:39:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B1C46B3;
        Fri,  4 Aug 2023 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691159957; x=1722695957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JWDzbwlS50ws/taA8DxOR95OzxbQkw4nudsfTFbqpA4=;
  b=FqTv1cP8yirsBF2dtc1NTix/1Arw4pJP90lJklIVQCiZz42e8tBv+mS9
   nIjCH1cK954wI6/3fnj1j043AG7RxjtcIuvFNjnaEYkZMsK3359VyS8Wy
   qrF++1/Xne5/59SQIuRYV4TxzyHKmj2icUAbnTw5T4llPwU4/vOh5pxbE
   NO0PF9z7ZjI8odpPvehQCW90D4q0sO5Arrc6ZxcQfeNU7Gns4XmXKMiAy
   wVr490n1juUnxAeg54NuR3Y2+/SvdTy+I2Zbmoyi9RtbDejfBJJ16Nf6k
   3Pk5GzG3Apn993w1idDWYduag/E1Reddq9Ejsm6Fo5EFFumb0V/jx5nM6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373816847"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="373816847"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="723678948"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="723678948"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 07:39:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E77F45B; Fri,  4 Aug 2023 17:39:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tero Kristo <kristo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 0/4] clk: Add kstrdup_and_replace() helper and use it
Date:   Fri,  4 Aug 2023 17:39:06 +0300
Message-Id: <20230804143910.15504-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few existing users and more might come which would like
to have the kstrdup_and_replace() functionality.

Provide this new API and reuse it in a few users.

Since most of that is under CCF, perhaps it makes sense to route it
via that tree.

Changelog v2:
- added tag to patch 2 (Greg KH)
- fixed typo in three commit messages

Andy Shevchenko (4):
  lib/string_helpers: Add kstrdup_and_replace() helper
  driver core: Replace kstrdup() + strreplace() with
    kstrdup_and_replace()
  clk: tegra: Replace kstrdup() + strreplace() with
    kstrdup_and_replace()
  clk: ti: Replace kstrdup() + strreplace() with kstrdup_and_replace()

 drivers/base/core.c            |  5 ++---
 drivers/clk/tegra/clk.c        |  6 ++----
 drivers/clk/ti/clk.c           |  4 ++--
 drivers/clk/ti/clkctrl.c       |  9 +++++----
 include/linux/string_helpers.h |  2 ++
 lib/string_helpers.c           | 15 +++++++++++++++
 6 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

