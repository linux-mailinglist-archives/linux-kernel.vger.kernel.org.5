Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7437FE2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjK2WVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjK2WVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:21:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB4A3;
        Wed, 29 Nov 2023 14:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701296500; x=1732832500;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z/lRb6jOKcLVvakdgQeZU82qUclb1WEH9r84F28valY=;
  b=II4ttN9EUOYaQmBOD2V6Q30RFJsJ+ytTATYUt46B7GcOOjZAH2Ti/RE7
   xiKVT7lsuogEMW58yN3fEq5xvT5WuxkpCMY4MKxe9ABuTJegZziXjvRZR
   1lP+JQHcJw6TT2o4AOBhz94Kdq/riJP4G/gOCm31z/5wgvgoNF0A3Ly0s
   ubmXMkAL/IHQVaoIiVBWSYR3RHuZZxFFYKSoz1wDyssz2tRkwPHNMtwi/
   TBBw17m8jv+u9vtiuwcZcq3kg+D1RmLLC5Hhe87hgA05AAFgSetzIXZKY
   x/VJTDpYAcPQA0+MsSjxSv93k1WjwhSEiK79VpAlIM/I274KmmhB3IjIp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11936992"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11936992"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798070406"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798070406"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:32 -0800
Received: from debox1-desk4.lan (unknown [10.209.108.167])
        by linux.intel.com (Postfix) with ESMTP id 8D51B5807E2;
        Wed, 29 Nov 2023 14:21:32 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V6 00/20] intel_pmc: Add telemetry API to read counters
Date:   Wed, 29 Nov 2023 14:21:12 -0800
Message-Id: <20231129222132.2331261-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer Intel silicon, more IP counters are being added in Intel Platform
Monitoring Technology (PMT) telemetry spaces hosted in MMIO.  There is a
need for the intel_pmc_core driver and other drivers to access PMT hosted
telemetry in the kernel using an API. This patchset adds driver APIs to
allow registering and reading telemetry entries. It makes changes to the
intel_pmc_core driver to use these interfaces to access the low power mode
counters that are now exclusively available from PMT.

David E. Box (15):
  platform/x86/intel/vsec: Fix xa_alloc memory leak
  platform/x86/intel/vsec: Remove unnecessary return
  platform/x86/intel/vsec: Move structures to header
  platform/x86/intel/vsec: remove platform_info from vsec device
    structure
  platform/x86/intel/vsec: Use cleanup.h
  platform/x86/intel/vsec: Assign auxdev parent by argument
  platform/x86/intel/vsec: Add base address field
  platform/x86/intel/pmt: Add header to struct intel_pmt_entry
  platform/x86/intel/pmt: telemetry: Export API to read telemetry
  platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
  platform/x86/intel/pmc: Cleanup SSRAM discovery
  platform/x86/intel/pmc/mtl: Use return value from
    pmc_core_ssram_init()
  platform/x86/intel/pmc: Find and register PMC telemetry entries
  platform/x86/intel/pmc: Add debug attribute for Die C6 counter
  platform/x86/intel/pmc: Show Die C6 counter on Meteor Lake

Gayatri Kammela (1):
  platform/x86/intel/vsec: Add intel_vsec_register

Rajvi Jingar (1):
  platform/x86/intel/pmc: Display LPM requirements for multiple PMCs

Xi Pardee (3):
  platform/x86:intel/pmc: Call pmc_get_low_power_modes from platform
    init
  platform/x86/intel/pmc: Retrieve LPM information using Intel PMT
  platform/x86/intel/pmc: Read low power mode requirements for MTL-M and
    MTL-P

 drivers/platform/x86/intel/pmc/Kconfig      |   1 +
 drivers/platform/x86/intel/pmc/adl.c        |   2 +
 drivers/platform/x86/intel/pmc/cnp.c        |   2 +
 drivers/platform/x86/intel/pmc/core.c       | 185 +++++++++-----
 drivers/platform/x86/intel/pmc/core.h       |  10 +-
 drivers/platform/x86/intel/pmc/core_ssram.c | 265 +++++++++++++++++---
 drivers/platform/x86/intel/pmc/icl.c        |  10 +-
 drivers/platform/x86/intel/pmc/mtl.c        |  87 ++++++-
 drivers/platform/x86/intel/pmc/spt.c        |  10 +-
 drivers/platform/x86/intel/pmc/tgl.c        |   1 +
 drivers/platform/x86/intel/pmt/class.c      |  43 +++-
 drivers/platform/x86/intel/pmt/class.h      |  30 ++-
 drivers/platform/x86/intel/pmt/crashlog.c   |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c  | 193 +++++++++++++-
 drivers/platform/x86/intel/pmt/telemetry.h  | 126 ++++++++++
 drivers/platform/x86/intel/vsec.c           | 131 +++++-----
 drivers/platform/x86/intel/vsec.h           |  45 +++-
 17 files changed, 939 insertions(+), 204 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.34.1

