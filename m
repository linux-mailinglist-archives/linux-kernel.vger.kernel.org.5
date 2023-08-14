Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD777B10B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjHNGEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHNGEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:04:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A5112D;
        Sun, 13 Aug 2023 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691993043; x=1723529043;
  h=from:to:cc:subject:date:message-id;
  bh=qPmjJkvSREsVwrEMnbx2Dx4ZWJsgDwSmluuX5tF6w4E=;
  b=HIUdkUwIszch58MnCVVzBzBQ7GGDXN6YTnGiY3XbSG7AYS2khErWiduh
   lJQLUFnv9noLcAOW2yOx3oGlMs5LeCQv5HCr8d36RlIYWfm83bOJImNUc
   uclgXcGzc9UXTk1ifAvSdqh589WtEUjn9ToxuIxzMmR71KOppVG7lAA5q
   oBaOF4SeiihRBUIjI3/unBqBxQ5NVz5f/seERgONh1pAF9OyayKsPG1W4
   32aQubUX2avb0+xfSsULsv9z0Xr4UWsJYhEzxhQFg0SVAqFli84MMRHl/
   WCjv0aL7AGX1koLQz/Pqv4gw6/N1kygqsCZyAXv29lu9EerypNbxm1B0M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371970741"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="371970741"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 23:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="798702884"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="798702884"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2023 23:04:00 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/4] Reuse common functions from pinctrl-intel
Date:   Mon, 14 Aug 2023 11:33:07 +0530
Message-Id: <20230814060311.15945-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series exports common pinctrl functions that are used across
Intel specific platform drivers to PINCTRL_INTEL namespace and
reuses them into Baytrail, Cherryview and Lynxpoint drivers.
This helps reduce their code and memory footprint.

X86 kernels are fairly unikernels such that pinctrl-intel driver is
enabled by most Linux distributions and most Intel specific platform
drivers (inside drivers/pinctrl/intel) depend on it.

The only exception to this is Lynxpoint. But taking into account its
fairly old age, it wouldn't suffer much from pinctrl-intel dependency.

bloat-o-meter:
==============

Intel:
add/remove: 17/10 grow/shrink: 0/0 up/down: 375/-319 (56)
Total: Before=9598, After=9654, chg +0.58%

Baytrail:
add/remove: 1/6 grow/shrink: 0/2 up/down: 41/-441 (-400)
Total: Before=16538, After=16138, chg -2.42%

Cherryview:
add/remove: 1/6 grow/shrink: 2/0 up/down: 90/-272 (-182)
Total: Before=18133, After=17951, chg -1.00%

Lynxpoint:
add/remove: 1/6 grow/shrink: 0/1 up/down: 24/-354 (-330)
Total: Before=7836, After=7506, chg -4.21%

Raag Jadav (4):
  pinctrl: intel: export common pinctrl functions
  pinctrl: baytrail: reuse common functions from pinctrl-intel
  pinctrl: cherryview: reuse common functions from pinctrl-intel
  pinctrl: lynxpoint: reuse common functions from pinctrl-intel

 drivers/pinctrl/intel/Kconfig              |  6 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c   | 90 +++-------------------
 drivers/pinctrl/intel/pinctrl-cherryview.c | 69 +++--------------
 drivers/pinctrl/intel/pinctrl-intel.c      | 30 ++++----
 drivers/pinctrl/intel/pinctrl-intel.h      | 12 +++
 drivers/pinctrl/intel/pinctrl-lynxpoint.c  | 86 ++-------------------
 6 files changed, 57 insertions(+), 236 deletions(-)

-- 
2.17.1

