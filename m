Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1E7BEA44
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbjJITGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346660AbjJITGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:06:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D0A4;
        Mon,  9 Oct 2023 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878360; x=1728414360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f7etTLNPVQPXqURaYmQQ/fnq6PNGB6oZHTXtNFJ1FHk=;
  b=oA6GdJjgsECHBdnS94qtkIBQJ+xKAWR8OqEWteQQQFaXkBTHin0jJLfm
   FTNbupG7fmWM6ZzXFuuWMCAYse0bg5mqAK7ypAI/3PVhqubikmaxUN2Nb
   aUZG+uOOp239+msiOXOx51b03yn+qH925WP3JMdmc8C1aY1t7fAcaPpv8
   qlw82KufHdVOYKs26IlcnULDoHtFTCiqUjrbO0ap7HtDsyL63OIumLRVy
   rBT60nBdWO0R65NBrd7vDjcsfG5OuUacraB+FrQTlts0TNWZ72XAOGlB3
   NBg99beVc9fckcbiyIrfcv2Ga3g8WTHYaAfYuaL1CT+7qwdfXrf7sImnW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213765"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213765"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445833"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445833"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:05:59 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/7] thermal: processor_thermal: Power floor status
Date:   Mon,  9 Oct 2023 12:05:31 -0700
Message-Id: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support power floor notifications for Meteor Lake processors.

The first three changes is to prepare for power floor status and others
add support for power floor.

v2
- Use common define for offset
- Fix potential race during clearing of interrupt with workload hint
- Address comment for v1 for
thermal: int340x: processor_thermal: Support power floor notifications

Srinivas Pandruvada (7):
  thermal: int340x: processor_thermal: Move interrupt status MMIO offset
    to common header
  thermal: int340x: processor_thermal: Common function to clear SOC
    interrupt
  thermal: int340x: processor_thermal: Set feature mask before
    proc_thermal_add
  thermal: int340x: processor_thermal: Support power floor notifications
  thermal: int340x: processor_thermal: Handle power floor interrupts
  thermal: int340x: processor_thermal: Enable power floor support
  selftests/thermel/intel: Add test to read power floor status

 .../driver-api/thermal/intel_dptf.rst         |   8 ++
 .../thermal/intel/int340x_thermal/Makefile    |   1 +
 .../processor_thermal_device.c                |  68 +++++++++-
 .../processor_thermal_device.h                |  11 ++
 .../processor_thermal_device_pci.c            |  43 ++++--
 .../processor_thermal_power_floor.c           | 126 ++++++++++++++++++
 .../processor_thermal_wt_hint.c               |   3 -
 tools/testing/selftests/Makefile              |   1 +
 .../thermal/intel/power_floor/Makefile        |  12 ++
 .../intel/power_floor/power_floor_test.c      | 108 +++++++++++++++
 10 files changed, 365 insertions(+), 16 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
 create mode 100644 tools/testing/selftests/thermal/intel/power_floor/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c

-- 
2.40.1

