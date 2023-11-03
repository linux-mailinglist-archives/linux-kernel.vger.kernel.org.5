Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494B7E0A14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378208AbjKCUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378015AbjKCUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:18:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B92D63
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699042721; x=1730578721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SsqYwVa3nj+KQxx6klaIUKyb/YVe7UbmMNumzB/z7A8=;
  b=QqJ5NcbFNLVQi57O5tc2vcAWGE/fqTRq8N5kVDAKPTTF4GmThOgf6x4w
   N5gjcxcvskOgUX+AAXovO80DSiRLaz46Ts5d/sdZ/2mYy6mmRq8Ax422Z
   Ng8fteM7mYfn66devWSrDdbDBB6YbPgA3D7P72Z6iHk5SeMhVLerZV3Ul
   KVDPEVE5k5yPyqZYkI3WVWdAPNStU12rOeFMdUB3n9xikLHjmOn06in4X
   3FFgKFWG4OjdhtiauJ2J/RoiI2Ku3NkD+x/yLGQ5E5NOUsYNRCBC++SnJ
   hJ/dJQ2VKNb/oBlibaLqGLgoZwU0HdSR6OHYONZaRYaER6ZTVuk362kGd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387904504"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="387904504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="885303649"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="885303649"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2023 13:18:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B4795E2; Fri,  3 Nov 2023 22:18:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [rft, PATCH v4 00/16] drm/i915/dsi: 4th attempt to get rid of IOSF GPIO
Date:   Fri,  3 Nov 2023 22:18:15 +0200
Message-Id: <20231103201831.1037416-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI code for VBT has a set of ugly GPIO hacks, one of which is direct
talking to GPIO IP behind the actual driver's back. A second attempt
to fix that is here.

If I understood correctly, my approach should work in the similar way as
the current IOSF GPIO.

Hans, I believe you have some devices that use this piece of code,
is it possible to give a test run on (one of) them?

In v4:
- fixed compile time errors in patch 14 (Hans, LKP)
- fixed cover letter Subject
- added patch 15 (as suggested by Ville)
- added Ack tag (Jani)

In v3:
- incorporated series by Jani
- incorporated couple of precursor patches by Hans
- added Rb tag for used to be first three patches (Andi)
- rebased on top of the above changes
- fixed indexing for multi-community devices, such as Cherry View

In v2:
- added a few cleanup patches
- reworked to use dynamic GPIO lookup tables
- converted CHV as well

Andy Shevchenko (9):
  drm/i915/dsi: Replace while(1) with one with clear exit condition
  drm/i915/dsi: Get rid of redundant 'else'
  drm/i915/dsi: Replace check with a (missing) MIPI sequence name
  drm/i915/dsi: Extract common soc_gpio_set_value() helper
  drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back
  drm/i915/dsi: Prepare soc_gpio_set_value() to distinguish GPIO
    communities
  drm/i915/dsi: Replace poking of CHV GPIOs behind the driver's back
  drm/i915/dsi: Combine checks in mipi_exec_gpio()
  drm/i915/iosf: Drop unused APIs

Hans de Goede (2):
  drm/i915/dsi: Remove GPIO lookup table at the end of
    intel_dsi_vbt_gpio_init()
  drm/i915/dsi: Fix wrong initial value for GPIOs in
    bxt_gpio_set_value()

Jani Nikula (5):
  drm/i915/dsi: assume BXT gpio works for non-native GPIO
  drm/i915/dsi: switch mipi_exec_gpio() from dev_priv to i915
  drm/i915/dsi: clarify GPIO exec sequence
  drm/i915/dsi: rename platform specific *_exec_gpio() to
    *_gpio_set_value()
  drm/i915/dsi: bxt/icl GPIO set value do not need gpio source

 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 355 +++++++------------
 drivers/gpu/drm/i915/vlv_sideband.c          |  17 -
 drivers/gpu/drm/i915/vlv_sideband.h          |   3 -
 3 files changed, 136 insertions(+), 239 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

