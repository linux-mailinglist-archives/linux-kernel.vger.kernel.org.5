Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE97AF6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjIZXoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjIZXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:41:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8751F0F;
        Tue, 26 Sep 2023 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695769096; x=1727305096;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DxIF+KDozytca3TFXn/HBp6pAW3jotr/Qf5xWOpXuSw=;
  b=b+I6qgiAHbWlMUFxTLlNRq2zXJoRte+Mbfkt2852qPrAH2xnnQ0tqT64
   0WMzdCIfKHDjI08x0jI0IkxnpsNgfaGFKVL7uGdCz4u1pHhrJsBhhVhBe
   af7z2GmiY/OprfKC5igWYedKLNi5O8haz20WiCxnOWsjDDtQqsRqvnT35
   m+DyHb4WTMuXdTt7JrxPEnpEpEeCCeazMNqtwepvMoOMaF37qSSBNIrpU
   diUjnwkttkigIw94hyHAh89tK6D4ZsaNwULiYE+E5a14wWjBHs2Kf2ASd
   Zg4OnSKeh1HEySVRyJsj0vRhj8DdqyDrJfOytMwu9H2wdd4xd0F5PXwmh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412599577"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412599577"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752346080"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752346080"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2023 15:58:14 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/5] thermal: processor_thermal: Power floor status
Date:   Tue, 26 Sep 2023 15:58:08 -0700
Message-Id: <20230926225813.995948-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support power floor notifications for Meteor Lake processors.

The first change is to prepare for power floor status and others
add support for power floor.

Srinivas Pandruvada (5):
  thermal: int340x: processor_thermal: Set feature mask before
    proc_thermal_add
  thermal: int340x: processor_thermal: Support power floor notifications
  thermal: int340x: processor_thermal: Handle power floor interrupts
  thermal: int340x: processor_thermal: Enable power floor support
  selftests/thermel/intel: Add test to read power floor status

 .../driver-api/thermal/intel_dptf.rst         |   8 ++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  68 ++++++++++-
 .../processor_thermal_device.h                |   8 ++
 .../processor_thermal_device_pci.c            |  29 +++--
 .../processor_thermal_power_floor.c           | 114 ++++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 .../thermal/intel/power_floor/Makefile        |  12 ++
 .../intel/power_floor/power_floor_test.c      | 108 +++++++++++++++++
 9 files changed, 336 insertions(+), 13 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
 create mode 100644 tools/testing/selftests/thermal/intel/power_floor/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c

-- 
2.41.0

