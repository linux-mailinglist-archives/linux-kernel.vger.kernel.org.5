Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631517DB98B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjJ3MHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjJ3MHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1AD3;
        Mon, 30 Oct 2023 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667662; x=1730203662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zwSMionLKlybSbWrt7iGhb3VWvETokFqg3T+MVC3gQk=;
  b=EIhsF9/aUkmw59OiNDAzESguwgrj51StknJJoUHZ9pX9rh+D7C248pDz
   pRVTEtcojkvyDXo7E3jtywlNpVjBYGEV4xBAkLPLmDKwadfFJ0HdBU910
   v6Fd1WblPC0Z9CbqSRfjqySgH983ADxSGBpJVrM7KUHwqmlNKICgi8ZpV
   XFwBpcm2qwjK+RhIfyKsTlEDmKzc98F2r3qQ/QX43JfblCxjl6T1KD5p+
   yIAuBJ00Owf1QoNmIel7fQtkUGLshJ+T4OtIPnLx65Kl1Lj7PwD+T6rH4
   OCnazjH1uvPjcCiMVCxvPNYBGv4NRuzCDGKF7I32Qlb75Ljbo4pPLA+vP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107330"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107330"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771399"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771399"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CDCFD2D2; Mon, 30 Oct 2023 14:07:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 00/17] pinctrl: intel: Use NOIRQ PM helper
Date:   Mon, 30 Oct 2023 14:07:17 +0200
Message-Id: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel pin control drivers use NOIRQ variant of the PM callbacks.
To make them smaller and less error prone against different
kernel configurations (with possible defined but not used variables)
switch to use NOIRQ PM helper.

Changelog v3:
- dropped applied patches
- dropped MediaTek patch for now
- split Intel patch to the series using suggection by Paul

Changelog v2:
- rewritten commit message in patch 1 (Rafael)
- converted non-Intel pin control drivers as well
- added couple of kinda related patches to use pm_ptr()

Andy Shevchenko (17):
  pinctrl: intel: Provide Intel pin control wide PM ops structure
  pinctrl: alderlake: Switch to use Intel pin control PM ops
  pinctrl: broxton: Switch to use Intel pin control PM ops
  pinctrl: cannonlake: Switch to use Intel pin control PM ops
  pinctrl: cedarfork: Switch to use Intel pin control PM ops
  pinctrl: denverton: Switch to use Intel pin control PM ops
  pinctrl: elkhartlake: Switch to use Intel pin control PM ops
  pinctrl: emmitsburg: Switch to use Intel pin control PM ops
  pinctrl: geminilake: Switch to use Intel pin control PM ops
  pinctrl: icelake: Switch to use Intel pin control PM ops
  pinctrl: jasperlake: Switch to use Intel pin control PM ops
  pinctrl: lakefield: Switch to use Intel pin control PM ops
  pinctrl: lewisburg: Switch to use Intel pin control PM ops
  pinctrl: meteorlake: Switch to use Intel pin control PM ops
  pinctrl: sunrisepoint: Switch to use Intel pin control PM ops
  pinctrl: tigerlake: Switch to use Intel pin control PM ops
  pinctrl: intel: Make PM ops functions static

 drivers/pinctrl/intel/pinctrl-alderlake.c    |  5 ++---
 drivers/pinctrl/intel/pinctrl-broxton.c      |  5 ++---
 drivers/pinctrl/intel/pinctrl-cannonlake.c   |  5 ++---
 drivers/pinctrl/intel/pinctrl-cedarfork.c    |  5 ++---
 drivers/pinctrl/intel/pinctrl-denverton.c    |  5 ++---
 drivers/pinctrl/intel/pinctrl-elkhartlake.c  |  5 ++---
 drivers/pinctrl/intel/pinctrl-emmitsburg.c   |  5 ++---
 drivers/pinctrl/intel/pinctrl-geminilake.c   |  5 ++---
 drivers/pinctrl/intel/pinctrl-icelake.c      |  5 ++---
 drivers/pinctrl/intel/pinctrl-intel.c        | 14 +++++++-------
 drivers/pinctrl/intel/pinctrl-intel.h        | 11 +----------
 drivers/pinctrl/intel/pinctrl-jasperlake.c   |  5 ++---
 drivers/pinctrl/intel/pinctrl-lakefield.c    |  5 ++---
 drivers/pinctrl/intel/pinctrl-lewisburg.c    |  5 ++---
 drivers/pinctrl/intel/pinctrl-meteorlake.c   |  5 ++---
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c |  5 ++---
 drivers/pinctrl/intel/pinctrl-tigerlake.c    |  5 ++---
 17 files changed, 38 insertions(+), 62 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

