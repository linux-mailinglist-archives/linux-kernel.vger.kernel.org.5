Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357DB79C402
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjILDUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbjILCl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:41:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636CCF6A8A;
        Mon, 11 Sep 2023 19:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694484409; x=1726020409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9LhfAq2q3BUbfDKBgwcZ7LGfRN2/Wz59hW9/3Tb5yq0=;
  b=axClyJDT5mjI8hGLXIZ15YiniMOz/AkZcKnnnsMyQK0GOYNbz/ZAnyiA
   Kp59UyoKiKzzTwTcs2THym9Ie3Xsdc/GkeKzRQXsfllEABerY3PwV+WB1
   Q/V7CLUJrnn3ybQK+UoGqAz2aw7dcRH2kLQtsXe3g6tj7QY3hs6vvyTbB
   1Q0GqpdEkYBrO/MgzTbb38D7Eq85s8/z6xJZkGDKfEyl1MvB3lDjtrZKd
   A6H6iFBu1fAVf8YgFRTyj/ZkXLaIecAB/hpSzcMBC1u8E2V7D3waBPDVZ
   cjwZ3/uRQuZnpzOG4PtfMW8+WPRxYa/fQ5qodqURWD9+SrpeKakT1RU9b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382057881"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="382057881"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858570578"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858570578"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2023 17:58:07 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org
Cc:     chrome-platform@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 0/4] Displayport Alternate Mode 2.1 Support
Date:   Mon, 11 Sep 2023 17:57:48 -0700
Message-Id: <20230912005752.1532888-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enabels cable identification flow required for Displayport
Alternate Mode 2.1 support.

Please add this series to usb-next. 

Changes in v3:
- Removed [PATCH 3/5] usb: pd: Add helper macro to get Type C cable speed
  instead added the helper function in [PATCH 3/4].
- In [PATCH 3/4] Removed use of variable cable_speed. 

Changes in v2:
- Added two new patches [PATCH 2/5] and [PATCH 3/5] in to this series.
- Removed [PATCH 2/4]  platform/chrome: cros_ec: Add Displayport
  Alternatemode 2.1 feature flag
- In [PATCH 4/5] Removed feature flag and separate function for DP2.1.
- In [PATCH 4/5] used cable vdos instead of host commands to get cable
  details.


Utkarsh Patel (4):
  usb: typec: Add Displayport Alternate Mode 2.1 Support
  usb: typec: Add Active or Passive cable defination to cable discover
    mode VDO
  platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1
    Support
  usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1

 drivers/platform/chrome/cros_ec_typec.c  | 28 ++++++++++++++++++++++++
 drivers/usb/typec/altmodes/displayport.c |  5 ++++-
 drivers/usb/typec/mux/intel_pmc_mux.c    | 24 ++++++++++++++++++++
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c        |  4 ++--
 include/linux/usb/pd_vdo.h               |  1 +
 include/linux/usb/typec_dp.h             | 28 ++++++++++++++++++++----
 include/linux/usb/typec_tbt.h            |  1 +
 8 files changed, 85 insertions(+), 8 deletions(-)

-- 
2.25.1

