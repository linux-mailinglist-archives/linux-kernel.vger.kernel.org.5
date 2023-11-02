Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843A17DF5EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347433AbjKBPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjKBPMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:12:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E404D4E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698937956; x=1730473956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CLy1y5nIqzAmMc0U1jCcdZeU6NVug+2ZBa3uUHFLFTk=;
  b=FPYztSgR1V5+y4LSbvXsaNiiFX2n2wDfTdFQqd9S01L0LVdRgbYMq33P
   GMBIsekUDjKgYLiytSBERk7+2YIbvFSfvbPf5ahYfCaqwDEIKaz9FVPnV
   Gw5fNIvsdx0qhaXjzx0tkCImrngK5ePNZbfGX3kOmc55HC1tcWbzR8TkE
   aUjj7+mbCCWnaHGWU0Hu9DEA7Rxvpm8VjS9j2rVZWEHgz6lUSuz2KMOnD
   O8OsV9c1ZuD/6KOqif4g0inn8TW4mWHUuvoPIQ+wmBoUM50Xw5o9D0iLJ
   05BeRurFHDKs5h8yF/v2iI7c8P8Avbm+zaSnt+osQriCPA6olmcybeITN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1660142"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1660142"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="737784550"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="737784550"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2023 08:12:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 76FA0560; Thu,  2 Nov 2023 17:12:30 +0200 (EET)
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
Subject: [rft, PATCH v3 00/15] drm/i915/dsi: 2nd attempt to get rid of IOSF GPIO
Date:   Thu,  2 Nov 2023 17:12:13 +0200
Message-Id: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Andy Shevchenko (8):
  drm/i915/dsi: Replace while(1) with one with clear exit condition
  drm/i915/dsi: Get rid of redundant 'else'
  drm/i915/dsi: Replace check with a (missing) MIPI sequence name
  drm/i915/dsi: Extract common soc_gpio_set_value() helper
  drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back
  drm/i915/dsi: Prepare soc_gpio_set_value() to distinguish GPIO
    communities
  drm/i915/dsi: Replace poking of CHV GPIOs behind the driver's back
  drm/i915/iosf: Drop unused APIs

Hans de Goede (2):
  drm/i915/dsi: Remove GPIO lookup table at the end of
    intel_dsi_vbt_gpio_init()
  drm/i915/dsi: Fix wrong initial value for GPIOs in bxt_exec_gpio()

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
 3 files changed, 137 insertions(+), 238 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

