Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350987D5773
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjJXQJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjJXQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:09:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E25AD7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163751; x=1729699751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7jqqEWWBGXf6MxxYFo4aSwri3S4nhJtTigEXNG+6fpQ=;
  b=A+Yrb5uhKl0boBvn/aMXZs7qmeFiuAjKKNdTGlCnYKHwhdS8gxhCqPuj
   1SfJbz/3WU29FWQrg2EWCQybRAhPSwwl3zKVb3N3ReOa4T8UW5DQ1FYDs
   TtgWRJ4KTsTUE5n8MC6Itx64RiHtjwd1UblVy4uZVwPvxdk44s5HbWTq2
   STSGC9V0r0dyoNMc/qGLUUewwWTBX/gqtpCHd/4FsGFsVAWqQ+JIWzTJs
   RIEEn/2sDIEhG6niBfbpXME4kj0uzE/yeSyJci/H8Wx+C4NEG1Rsdpdzq
   QbdNM2YA9IjJp9uEu/yhxVA4FVBS+/faJy8XeehCL7SXOndRZG08ghXgj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473328726"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="473328726"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="708354961"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="708354961"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2023 08:57:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC1F0195; Tue, 24 Oct 2023 18:57:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [rft, PATCH v2 0/7] drm/i915/dsi: 2nd attempt to get rid of IOSF GPIO
Date:   Tue, 24 Oct 2023 18:57:32 +0300
Message-Id: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

In v2:
- added a few cleanup patches
- reworked to use dynamic GPIO lookup tables
- converted CHV as well

Andy Shevchenko (7):
  drm/i915/dsi: Replace while(1) with one with clear exit condition
  drm/i915/dsi: Get rid of redundant 'else'
  drm/i915/dsi: Replace check with a (missing) MIPI sequence name
  drm/i915/dsi: Extract common soc_gpio_exec() helper
  drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back
  drm/i915/dsi: Replace poking of CHV GPIOs behind the driver's back
  drm/i915/iosf: Drop unused APIs

 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 260 +++++++------------
 drivers/gpu/drm/i915/vlv_sideband.c          |  17 --
 drivers/gpu/drm/i915/vlv_sideband.h          |   3 -
 3 files changed, 96 insertions(+), 184 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

