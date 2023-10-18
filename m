Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443517CD36B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJRFLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjJRFLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:11:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C48C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697605863; x=1729141863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z7l4GsviViNEBuJ4IMZVmWkLqK9g+LDQfyA0te/LnCI=;
  b=KLeApTb+HeVhET07mRBS0H9aAD+FjaHmCrI91UjevG/dQItzZP3mXPsF
   6Pa9vEmgTEiOabuxKw2GbgyCdLKm24SPO1WZ3ehkhuJJjBRNUz7BZfWUM
   m39oqjaiDAp303JrNyxaDxbHJOzEqW2SVWvpGwbikXW/xmW26DQIMv2zi
   5aeNPtzZnLTwjDOPGSjrUpZrOi+MJRXNrIYd14gGC32emsrNYRSo38qnh
   d7UI44HiO+X8/grZzDf6+coc14sQGlF/hxAV0tqMMkP0Ck9UUSnua20EI
   KddfPpjMLRyxN0X6zuZTfZEVfqQ6RpHr/JdiluFcfmxPYk3Ruai1tBoXY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389815360"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="389815360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 22:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900180602"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="900180602"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2023 22:08:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BCB4130; Wed, 18 Oct 2023 08:10:58 +0300 (EEST)
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
Subject: [rft, PATCH v1 0/2] drm/i915/dsi: An attempt to get rid of IOSF GPIO on VLV
Date:   Wed, 18 Oct 2023 08:10:50 +0300
Message-Id: <20231018051052.1328852-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI code for VBT has a set of ugly GPIO hacks, one of which is direct
talking to GPIO IP behind the actual driver's back. An attempt to fix
that is here.

If I understood correctly, my approach should work in the similar way as
the current IOSF GPIO. 

Hans, I believe you have some devices that use this piece of code,
is it possible to give a test run on (one of) them?

Andy Shevchenko (2):
  drm/i915/dsi: Extract common soc_gpio_exec() helper
  drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back

 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 150 +++++++------------
 1 file changed, 58 insertions(+), 92 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

